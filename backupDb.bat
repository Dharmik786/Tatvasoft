@echo off

REM Get the current timestamp using PowerShell
for /f %%i in ('powershell -command "Get-Date -Format yyyyMMdd_HHmmss"') do set TIMESTAMP=%%i

REM Directory where backups will be stored
set BACKUP_DIR=D:\Pratice Projects\Dbbackups

REM MongoDB connection details
set MONGODB_URI=mongodb+srv://pm24nt29:dZsAfu5WUpR5TeMP@cluster0.6d9uiuw.mongodb.net/
set MONGODB_DB=StyleMensWear

REM Create backup directory if it doesn't exist
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

REM Run mongodump to create backup
mongodump --uri=%MONGODB_URI% --db=%MONGODB_DB% --out "%BACKUP_DIR%\%TIMESTAMP%"
if %ERRORLEVEL% NEQ 0 (
    echo "mongodump failed"
    exit /b %ERRORLEVEL%
)

REM Check if backup directory exists and compress it
if exist "%BACKUP_DIR%\%TIMESTAMP%" (
    powershell -command "Compress-Archive -Path '%BACKUP_DIR%\%TIMESTAMP%' -DestinationPath '%BACKUP_DIR%\%TIMESTAMP%.zip'"
    
    REM Remove uncompressed backup directory
    rmdir /s /q "%BACKUP_DIR%\%TIMESTAMP%"
) else (
    echo "Backup directory does not exist"
    exit /b 1
)


