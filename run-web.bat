@echo off
REM Builds and serves the PaintFE web port, then opens it in your default browser.
setlocal

where cargo >nul 2>nul
if errorlevel 1 (
    echo [ERROR] cargo not found on PATH. Install Rust from https://rustup.rs and reopen this terminal.
    pause
    exit /b 1
)

where trunk >nul 2>nul
if errorlevel 1 (
    echo [ERROR] trunk not found on PATH.
    echo Install it with:  cargo install trunk
    pause
    exit /b 1
)

rustup target list --installed 2>nul | findstr /c:"wasm32-unknown-unknown" >nul
if errorlevel 1 (
    echo [ERROR] wasm32-unknown-unknown target not installed.
    echo Install it with:  rustup target add wasm32-unknown-unknown
    pause
    exit /b 1
)

cd /d "%~dp0web"
echo Starting trunk in %cd% ...
echo (First build can take several minutes - this is normal.)
trunk serve --open

REM If trunk exits (crash or Ctrl+C), keep the window open so the error is visible.
echo.
echo trunk exited with code %errorlevel%.
pause
