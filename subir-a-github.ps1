# =====================================================================
# Calibu ERP — Subir a GitHub automáticamente
# Doble clic para ejecutar
# =====================================================================

$ErrorActionPreference = "Stop"
$repoPath = "$PSScriptRoot\calibu-erp-repo"
$remoteUrl = "https://github.com/HuevosCalibu/Calibu.git"

Write-Host ""
Write-Host "=== Calibu ERP — Subiendo a GitHub ===" -ForegroundColor Cyan
Write-Host ""

# Verificar que la carpeta existe
if (-not (Test-Path $repoPath)) {
    Write-Host "ERROR: No se encontro la carpeta calibu-erp-repo" -ForegroundColor Red
    Write-Host "Asegurate de que 'calibu-erp-repo' este en la misma carpeta que este script."
    Read-Host "Presiona Enter para salir"
    exit 1
}

Set-Location $repoPath

# Configurar git si no está
$gitConfig = git config --global user.email 2>$null
if (-not $gitConfig) {
    git config --global user.email "erwin.budinich@gmail.com"
    git config --global user.name "Erwin Budinich"
}

Write-Host "Inicializando repositorio git..." -ForegroundColor Yellow
git init -q
git checkout -b main 2>$null

Write-Host "Agregando todos los archivos..." -ForegroundColor Yellow
git add .

Write-Host "Creando commit..." -ForegroundColor Yellow
git commit -q -m "Calibu ERP v4.5 - build completo"

Write-Host "Conectando con GitHub..." -ForegroundColor Yellow
git remote remove origin 2>$null
git remote add origin $remoteUrl

Write-Host ""
Write-Host "Subiendo archivos a GitHub..." -ForegroundColor Green
Write-Host "(Se abrira una ventana para ingresar tus credenciales de GitHub)" -ForegroundColor White
Write-Host ""

git push --force -u origin main

Write-Host ""
Write-Host "=== LISTO ===" -ForegroundColor Green
Write-Host "Tu codigo esta en: https://github.com/HuevosCalibu/Calibu" -ForegroundColor Cyan
Write-Host ""
Read-Host "Presiona Enter para cerrar"
