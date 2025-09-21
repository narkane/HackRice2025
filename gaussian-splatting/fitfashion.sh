#!/bin/bash

# Set python environment to g_splat
conda activate g_splat

# Gaussian Splatting Video Processing Pipeline
# Automates: Video -> Frames -> Convert -> Train

set -e  # Exit on any error

echo "=== Gaussian Splatting Video Processing Pipeline ==="
echo

# Stage 1: Video to Frames
echo "STAGE 1: Converting video to image frames"
echo "----------------------------------------"

# Get input video file
read -p "Enter input video file path: " VIDEO_PATH
if [[ ! -f "$VIDEO_PATH" ]]; then
    echo "Error: Video file not found: $VIDEO_PATH"
    exit 1
fi

# Get output directory
read -p "Enter output directory path (will be created if doesn't exist): " OUTPUT_DIR
mkdir -p "$OUTPUT_DIR"

# Calculate FPS recommendation
echo
echo "FPS Calculation Help:"
echo "- Target: 100-200 output frames"
echo "- If your video is 30fps and 10 seconds long (300 total frames):"
echo "  - fps=1 gives ~150 frames (good)"
echo "  - fps=2 gives ~300 frames (too many)"
echo "  - fps=0.5 gives ~75 frames (too few)"
echo

read -p "Enter FPS value for extraction (e.g., 1, 2, 0.5): " FPS_VALUE

# Construct ffmpeg command
FFMPEG_CMD="ffmpeg -i \"$VIDEO_PATH\" -qscale:v 1 -qmin 1 -vf fps=$FPS_VALUE \"$OUTPUT_DIR/%04d.jpg\""

echo
echo "About to run:"
echo "$FFMPEG_CMD"
echo

read -p "Continue with frame extraction? (y/n): " CONTINUE
if [[ $CONTINUE != "y" && $CONTINUE != "Y" ]]; then
    echo "Pipeline stopped at Stage 1"
    exit 0
fi

# Run ffmpeg
eval $FFMPEG_CMD

# Count generated frames
FRAME_COUNT=$(find "$OUTPUT_DIR" -name "*.jpg" | wc -l)
echo "Generated $FRAME_COUNT frames in $OUTPUT_DIR"

echo
read -p "Stage 1 complete. Continue to Stage 2 (convert.py)? (y/n): " CONTINUE
if [[ $CONTINUE != "y" && $CONTINUE != "Y" ]]; then
    echo "Pipeline stopped after Stage 1"
    echo "Frames available in: $OUTPUT_DIR"
    exit 0
fi

# Stage 2: Convert
echo
echo "STAGE 2: Running convert.py"
echo "----------------------------"

CONVERT_CMD="python convert.py -s \"$OUTPUT_DIR\""

echo "About to run:"
echo "$CONVERT_CMD"
echo

read -p "Continue with convert.py? (y/n): " CONTINUE
if [[ $CONTINUE != "y" && $CONTINUE != "Y" ]]; then
    echo "Pipeline stopped at Stage 2"
    echo "Frames available in: $OUTPUT_DIR"
    exit 0
fi

# Run convert.py
eval $CONVERT_CMD

echo
read -p "Stage 2 complete. Continue to Stage 3 (train.py)? (y/n): " CONTINUE
if [[ $CONTINUE != "y" && $CONTINUE != "Y" ]]; then
    echo "Pipeline stopped after Stage 2"
    echo "Converted data available in: $OUTPUT_DIR"
    exit 0
fi

# Stage 3: Train
echo
echo "STAGE 3: Running train.py"
echo "--------------------------"

TRAIN_CMD="python train.py -s \"$OUTPUT_DIR\""

echo "About to run:"
echo "$TRAIN_CMD"
echo

read -p "Continue with training? (y/n): " CONTINUE
if [[ $CONTINUE != "y" && $CONTINUE != "Y" ]]; then
    echo "Pipeline stopped at Stage 3"
    echo "Converted data available in: $OUTPUT_DIR"
    exit 0
fi

# Run train.py
eval $TRAIN_CMD

echo
echo "=== PIPELINE COMPLETE ==="
echo "All stages finished successfully!"
echo "Output directory: $OUTPUT_DIR"
