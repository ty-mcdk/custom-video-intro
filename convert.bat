@echo off
echo ========================================
echo   gen1recomp Custom Intro Converter
echo ========================================
echo.

if "%~1"=="" (
    echo [ERROR] No video files detected!
    echo Please drag and drop your video files (mp4, webm, mkv, avi, mov, etc.^) directly onto this .bat file.
    echo.
    pause
    exit /b
)

:ProcessLoop
if "%~1"=="" goto Finish

echo Converting "%~nx1" to "%~n1.ogv"...
echo This may take a moment...
ffmpeg -v warning -stats -i "%~1" -c:v libtheora -q:v 10 -c:a libvorbis -q:a 6 -y "%~dp0%~n1.ogv"
echo.

:: Shift the arguments down by 1 and loop back
shift
goto ProcessLoop

:Finish
echo ========================================
echo Batch Conversion Complete! 
echo Move your new .ogv files into the mod's assets folder.
echo ========================================
pause