# NUANCE

Minimal local AI text interpretation tool.

NUANCE analyzes written language through four interpretive categories:

- TONE
- SUBTEXT
- AMBIGUITY
- CORE MEANING

It runs locally through Ollama from PowerShell and requires no API key, hosted backend, database, or web application.

## Requirements

- Windows
- PowerShell
- Ollama
- An Ollama-compatible local model

## Installation

### 1. Install Ollama

Install Ollama for Windows.

### 2. Download the model

Open PowerShell and run:

```powershell
ollama pull llama3.2:3b
