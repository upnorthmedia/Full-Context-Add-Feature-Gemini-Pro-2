# 🚀 Gemini Feature Generator

A powerful CLI tool that leverages Google's Gemini AI & Repomix to analyze your codebase and generate feature implementations.

## ✨ Features

- 🔍 Analyzes your entire codebase structure using repomix
- 🤖 Utilizes Gemini AI for intelligent feature suggestions
- 📝 Generates detailed markdown documentation
- 🛠️ Provides compartmentalized code implementations
- ⚡ Specializes in Next.js 15, TypeScript, and SaaS integrations (can be modified)

## 🔧 Prerequisites

- Bash-compatible shell
- Node.js and npm installed
- curl
- Google Cloud Gemini API key

## 🚀 Installation

1. Clone this repository:
```bash
git clone <repository-url>
cd <repository-name>
```

2. Make the script executable:
```bash
chmod +x gemini-feature.sh
```

## 📖 Usage

1. Run the script:
```bash
./gemini-feature.sh
```

2. When prompted, enter your Gemini API key

3. The script will run repomix to analyze your codebase

4. Enter a description of the feature you want to implement

5. Review the generated response in `response.md`

## 🔄 How It Works

1. **API Key Collection** 🔑
   - Securely prompts for your Gemini API key
   - Validates the key is not empty

2. **Codebase Analysis** 📊
   - Runs repomix to generate a comprehensive codebase overview
   - Automatically handles repomix prompts

3. **Feature Description** 💭
   - Collects your feature requirements
   - Ensures the description is not empty

4. **AI Processing** 🧠
   - Uploads codebase analysis to Gemini API
   - Processes your feature request with specialized system instructions
   - Generates detailed implementation suggestions

5. **Response Formatting** 📝
   - Saves response in properly formatted markdown
   - Normalizes line endings and spacing
   - Creates clear, readable documentation

## ⚙️ Configuration

The script includes several configurable parameters in the Gemini API call:

- Temperature: 0.7 (controls creativity)
- Top K: 64 (diversity of responses)
- Top P: 0.95 (nucleus sampling)
- Max Output Tokens: 65536 (response length)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## ⚠️ Important Notes

- Keep your API key secure and never commit it to version control
- Ensure you have sufficient API quota for your usage
- The quality of suggestions depends on the clarity of your feature description

## 🐛 Troubleshooting

If you encounter issues:

1. Verify your API key is valid
2. Ensure all prerequisites are installed
3. Check your internet connection
4. Verify repomix is accessible via npx
