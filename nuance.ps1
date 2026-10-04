 param(
    [string]$Model = "llama3.2:3b"
)

$ErrorActionPreference = "Stop"

if (-not (Get-Command ollama -ErrorAction SilentlyContinue)) {
    Write-Host ""
    Write-Host "NUANCE"
    Write-Host "AI TEXT INTERPRETATION"
    Write-Host ""
    Write-Host "Ollama is not installed or is not on PATH."
    Write-Host ""
    Write-Host "Install Ollama, then run this file again."
    exit 1
}

Clear-Host

Write-Host ""
Write-Host "NUANCE"
Write-Host "AI TEXT INTERPRETATION"
Write-Host ""
Write-Host "Model: $Model"
Write-Host ""
Write-Host "Paste text to analyze."
Write-Host "Press ENTER on an empty line when finished."
Write-Host ""

$lines = @()

while ($true) {
    $line = Read-Host

    if ([string]::IsNullOrWhiteSpace($line)) {
        break
    }

    $lines += $line
}

if ($lines.Count -eq 0) {
    Write-Host "No text supplied."
    exit 0
}

$text = $lines -join "`n"

$prompt = @"
You are NUANCE, a minimalist text interpretation system.

Analyze the supplied text without rewriting it.

Return exactly these four sections:

TONE
Describe the emotional, rhetorical, or stylistic tone in 1 to 3 sentences.

SUBTEXT
Identify implied meaning, intention, tension, or assumptions that are not directly stated.

AMBIGUITY
Identify important phrases, meanings, or interpretations that could reasonably be understood in more than one way.

CORE MEANING
State the central meaning of the text as precisely as possible in 1 to 2 sentences.

Rules:
- Be concise.
- Be analytical.
- Do not diagnose the writer.
- Do not moralize.
- Do not invent context.
- Do not add sections.
- Do not rewrite the original text.

TEXT:
$text
"@

Write-Host ""
Write-Host "ANALYZING..."
Write-Host ""

try {
    & ollama run $Model $prompt

    if ($LASTEXITCODE -ne 0) {
        throw "Ollama returned exit code $LASTEXITCODE."
    }
}
catch {
    Write-Host ""
    Write-Host "NUANCE ERROR"
    Write-Host $_.Exception.Message
    Write-Host ""
    Write-Host "If the model is not installed, run:"
    Write-Host "ollama pull $Model"
    exit 1
}

Write-Host ""