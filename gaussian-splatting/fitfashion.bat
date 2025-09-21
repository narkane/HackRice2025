@echo off
setlocal enabledelayedexpansion

REM Gaussian Splatting Video Processing Pipeline
REM Automates: Video -> Frames -> Convert -> Train

echo === Gaussian Splatting Video Processing Pipeline ===
echo.

REM Activate conda environment
echo Activating conda environment 'g_splat'...
call conda activate g_splat
if errorlevel 1 (
    echo Error: Could not activate conda environment 'g_splat'
    pause
    exit /b 1
)
echo Environment activated successfully.
echo.

REM Stage 1: Video to Frames
echo STAGE 1: Converting video to image frames
echo ----------------------------------------

REM Get input video file
set /p VIDEO_PATH="Enter input video file path: "
if not exist "%VIDEO_PATH%" (
    echo Error: Video file not found: %VIDEO_PATH%
    pause
    exit /b 1
)

REM Get output directory
set /p OUTPUT_DIR="Enter output directory path (will be created if doesn't exist): "
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

REM Calculate FPS recommendation
echo.
echo FPS Calculation Help:
echo - Target: 100-200 output frames
echo - If your video is 30fps and 10 seconds long (300 total frames):
echo   - fps=1 gives ~150 frames (good)
echo   - fps=2 gives ~300 frames (too many)
echo   - fps=0.5 gives ~75 frames (too few)
echo.

set /p FPS_VALUE="Enter FPS value for extraction (e.g., 1, 2, 0.5): "

REM Construct ffmpeg command
set FFMPEG_CMD=ffmpeg -i "%VIDEO_PATH%" -qscale:v 1 -qmin 1 -vf fps=%FPS_VALUE% "%OUTPUT_DIR%\%%04d.jpg"

echo.
echo About to run:
echo %FFMPEG_CMD%
echo.

set /p CONTINUE="Continue with frame extraction? (y/n): "
if /i not "%CONTINUE%"=="y" (
    echo Pipeline stopped at Stage 1
    pause
    exit /b 0
)

REM Run ffmpeg
%FFMPEG_CMD%
if errorlevel 1 (
    echo Error running ffmpeg
    pause
    exit /b 1
)

REM Count generated frames
set FRAME_COUNT=0
for %%f in ("%OUTPUT_DIR%\*.jpg") do set /a FRAME_COUNT+=1
echo Generated %FRAME_COUNT% frames in %OUTPUT_DIR%

echo.
set /p CONTINUE="Stage 1 complete. Continue to Stage 2 (convert.py)? (y/n): "
if /i not "%CONTINUE%"=="y" (
    echo Pipeline stopped after Stage 1
    echo Frames available in: %OUTPUT_DIR%
    pause
    exit /b 0
)

REM Stage 2: Convert
echo.
echo STAGE 2: Running convert.py
echo ----------------------------

set CONVERT_CMD=python convert.py -s "%OUTPUT_DIR%"

echo About to run:
echo %CONVERT_CMD%
echo.

set /p CONTINUE="Continue with convert.py? (y/n): "
if /i not "%CONTINUE%"=="y" (
    echo Pipeline stopped at Stage 2
    echo Frames available in: %OUTPUT_DIR%
    pause
    exit /b 0
)

REM Run convert.py
%CONVERT_CMD%
if errorlevel 1 (
    echo Error running convert.py
    pause
    exit /b 1
)

echo.
set /p CONTINUE="Stage 2 complete. Continue to Stage 3 (train.py)? (y/n): "
if /i not "%CONTINUE%"=="y" (
    echo Pipeline stopped after Stage 2
    echo Converted data available in: %OUTPUT_DIR%
    pause
    exit /b 0
)

REM Stage 3: Train
echo.
echo STAGE 3: Running train.py
echo --------------------------

set TRAIN_CMD=python train.py -s "%OUTPUT_DIR%"

echo About to run:
echo %TRAIN_CMD%
echo.

set /p CONTINUE="Continue with training? (y/n): "
if /i not "%CONTINUE%"=="y" (
    echo Pipeline stopped at Stage 3
    echo Converted data available in: %OUTPUT_DIR%
    pause
    exit /b 0
)

REM Run train.py
%TRAIN_CMD%
if errorlevel 1 (
    echo Error running train.py
    pause
    exit /b 1
)

echo.
echo === PIPELINE COMPLETE ===
echo All stages finished successfully!
echo Output directory: %OUTPUT_DIR%
pause