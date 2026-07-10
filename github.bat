@echo off
:: 👑 Git Super-Smart Auto Push by Abdul Mueed
title Git Auto Push - Abdul Mueed

echo ======================================================
echo 👾  Welcome, Abdul Mueed - Let's push this repo in style
echo ======================================================
echo.

:: Check if git is installed
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Git not found! Please install Git first.
    pause
    exit /b
)

:CHOOSE_ACCOUNT
echo 🌐 Select GitHub Account:
echo [1] PluginStream  (acc1)
echo [2] am-abdulmueed (acc2)
echo.
set /p accChoice=👤 Enter choice (1 or 2): 

if "%accChoice%"=="1" goto SET_ACC1
if "%accChoice%"=="2" goto SET_ACC2

:: Invalid choice fallback
echo ❌ Invalid choice! Please enter 1 or 2.
echo.
goto CHOOSE_ACCOUNT

:SET_ACC1
echo.
echo 👤 Selected Account: PluginStream (acc1)
set "account=github.com-acc1"
set "user=PluginStream"
set "email=am.abdulmueed4@gmail.com"
goto ASK_REPO

:SET_ACC2
echo.
echo 👤 Selected Account: am-abdulmueed (acc2)
set "account=github.com-acc2"
set "user=am-abdulmueed"
set "email=am.abdulmueed5@gmail.com"
goto ASK_REPO

:ASK_REPO
echo.
set "repoName="
set /p repoName=📦 Enter Repository Name (e.g. protube): 
if "%repoName%"=="" (
    echo ❌ Repository name cannot be empty!
    goto ASK_REPO
)

:: Base URL Generation using your SSH Config Hosts
set "finalUrl=git@%account%:%user%/%repoName%.git"
echo.
echo 🔗 Generated SSH URL: %finalUrl%
echo ======================================================

:: Initialize git (if not already)
if not exist ".git" (
    echo 🧩 Initializing Git repository...
    git init
    :: Set clean author configs locally for this repo
    git config user.name "%user%"
    if "%user%"=="am-abdulmueed" git config user.name "Abdulmueed"
    git config user.email "%email%"
) else (
    echo 🔁 Git repo already initialized.
)

:: Add all files
echo ➕ Adding files...
git add .

:: Commit with message
echo.
set "msg="
set /p msg=💬 Enter commit message (default: "Initial commit"): 
if "%msg%"=="" set msg=Initial commit
git commit -m "%msg%"

:: Create & switch to main branch
echo 🪄 Setting up main branch...
git branch -M main

:: Add remote origin (SSH dynamic linking)
echo 🌍 Linking remote repository...
git remote remove origin >nul 2>&1
git remote add origin %finalUrl%

:: Push to GitHub
echo 🚀 Pushing code to remote repo...
git push -u origin main

if %errorlevel% neq 0 (
    echo.
    echo ❌ Error: Push failed! Check if repository exists on GitHub.
) else (
    echo.
    echo ✅ SUCCESS! Your repo has been pushed via SSH, boss 😎
)
echo ======================================================
pause