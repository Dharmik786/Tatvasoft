@echo off

REM Set the path to your ZIP file
set ZIP_FILE=D:\Pratice Projects\Dbbackups\20250206_145856.zip

REM Temporary extraction directory
set TEMP_DIR=D:\Pratice Projects\Dbbackups\temp_extraction

REM MongoDB connection details
set MONGODB_URI=mongodb+srv://190320107063cedharmikpatel:81ftiR4mWum9i3x7@cluster0.vlwbl3e.mongodb.net/
set MONGODB_DB=MensStyleWear2

REM Create temporary extraction directory if it doesn't exist
if not exist "%TEMP_DIR%" mkdir "%TEMP_DIR%"

REM Extract the ZIP file
powershell -command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%TEMP_DIR%'"

if %ERRORLEVEL% NEQ 0 (
    echo "Extraction of ZIP file failed"
    exit /b %ERRORLEVEL%
)

REM Restore command
set RESTORE_DB=MensStyleWear1510
set RESTORE_PATH=%TEMP_DIR%\20241015_140831\StyleMensWear

REM Run mongorestore to restore the database
mongorestore --uri="%MONGODB_URI%" --db="%RESTORE_DB%" "%RESTORE_PATH%"

if %ERRORLEVEL% NEQ 0 (
    echo "mongorestore failed"
    exit /b %ERRORLEVEL%
)

echo Backup restore completed.

REM Clean up the temporary extraction directory
rmdir /s /q "%TEMP_DIR%"
