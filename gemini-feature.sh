#!/bin/bash

# Function to prompt for API key
get_api_key() {
    read -p "Please enter your Gemini API key: " GEMINI_API_KEY
    if [ -z "$GEMINI_API_KEY" ]; then
        echo "API key cannot be empty"
        exit 1
    fi
}

# Function to get feature description
get_feature_description() {
    echo "Please describe the feature you want to add to your codebase:"
    read -r FEATURE_DESC
    if [ -z "$FEATURE_DESC" ]; then
        echo "Feature description cannot be empty"
        exit 1
    fi
}

# Run repomix and automatically answer yes
run_repomix() {
    echo "y" | npx repomix
    if [ $? -ne 0 ]; then
        echo "Error running repomix"
        exit 1
    fi
}

# Make API call to Gemini
call_gemini() {
    # First upload the file
    local FILE_SIZE=$(wc -c < "repomix-output.txt")
    local FILE_URI=$(curl "https://generativelanguage.googleapis.com/upload/v1beta/files?key=${GEMINI_API_KEY}" \
        -H "X-Goog-Upload-Command: start, upload, finalize" \
        -H "X-Goog-Upload-Header-Content-Length: ${FILE_SIZE}" \
        -H "X-Goog-Upload-Header-Content-Type: text/plain" \
        -H "Content-Type: application/json" \
        -d "{'file': {'display_name': 'repomix-output.txt'}}" \
        --data-binary "@repomix-output.txt" | jq -r '.file.uri')

    # Make the main API call and save to clean.md
    curl -X POST "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-thinking-exp-01-21:generateContent?key=${GEMINI_API_KEY}" \
        -H "Content-Type: application/json" \
        -d '{
            "contents": [
                {
                    "role": "user",
                    "parts": [
                        {
                            "fileData": {
                                "fileUri": "'"${FILE_URI}"'",
                                "mimeType": "text/plain"
                            }
                        }
                    ]
                },
                {
                    "role": "user",
                    "parts": [
                        {
                            "text": "'"${FEATURE_DESC}"'"
                        }
                    ]
                }
            ],
            "systemInstruction": {
                "role": "user",
                "parts": [
                    {
                        "text": "You are a senior full stack engineer specializing in NextJS 15, Typescript, and SAAS payments integration i.e. Stripe. You provide helpful and clear answers along with compartmentalized code."
                    }
                ]
            },
            "generationConfig": {
                "temperature": 0.7,
                "topK": 64,
                "topP": 0.95,
                "maxOutputTokens": 65536,
                "responseMimeType": "text/plain"
            }
        }' | jq -r '.candidates[0].content.parts[0].text' > response.md

    echo "Response has been saved to response.md"
}

# Main execution flow
main() {
    get_api_key
    run_repomix
    get_feature_description
    call_gemini
}

# Run the script
main
