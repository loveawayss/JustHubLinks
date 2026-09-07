# Instalador/atualizador remoto do JustHub para Windows.
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "Stop"

$manifestUrl = "https://raw.githubusercontent.com/loveawayss/JustReleases/main/update_info.json"
$tempPath = Join-Path $env:TEMP "JustHUBInstaller.exe"

try {
    Write-Host "Consultando versao mais recente do JustHub..." -ForegroundColor Cyan
    $updateInfo = Invoke-RestMethod -Uri $manifestUrl -UseBasicParsing
    
    $installerUrl = $updateInfo.downloadUrl
    $expectedSha256 = $updateInfo.sha256.ToLowerInvariant()
    $version = $updateInfo.version

    Write-Host "Baixando JustHub v$version..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $installerUrl -OutFile $tempPath -UseBasicParsing
    if (-not (Test-Path -LiteralPath $tempPath)) { throw "Falha ao salvar o instalador temporario." }

    $actualSha256 = (Get-FileHash -LiteralPath $tempPath -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($actualSha256 -ne $expectedSha256) { throw "Hash SHA-256 inconsistente para o instalador." }

    Write-Host "Instalando/atualizando silenciosamente..." -ForegroundColor Green
    $process = Start-Process -FilePath $tempPath -ArgumentList "/S" -PassThru -Wait
    if ($process.ExitCode -ne 0) { throw "O instalador terminou com o codigo $($process.ExitCode)." }

    Remove-Item -LiteralPath $tempPath -ErrorAction SilentlyContinue
    Write-Host "JustHub v$version instalado com sucesso!" -ForegroundColor Green
} catch {
    Remove-Item -LiteralPath $tempPath -ErrorAction SilentlyContinue
    Write-Host "Erro ao baixar ou instalar o JustHub: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
