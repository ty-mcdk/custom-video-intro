#!/bin/bash
echo "========================================"
echo "  gen1recomp Custom Intro Converter"
echo "========================================"
echo ""

if [ "$#" -eq 0 ]; then
    echo "[ERROR] No video files detected!"
    echo "Usage: ./convert.sh <video1> <video2> ..."
    echo "Supports .mp4, .webm, .mkv, .avi, .mov, and more."
    echo ""
    exit 1
fi

# Loop through every file passed to the script
for FILE in "$@"; do
    # Extract filename without path and without extension
    BASENAME=$(basename -- "$FILE")
    FILENAME="${BASENAME%.*}"
    OUTPUT_FILE="${FILENAME}.ogv"

    echo "Converting '$BASENAME' to '$OUTPUT_FILE'..."
    
    # Hide messy output, show only progress stats
    ffmpeg -v warning -stats -i "$FILE" -c:v libtheora -q:v 10 -c:a libvorbis -q:a 6 -y "$OUTPUT_FILE"
    echo ""
done

echo "========================================"
echo "Batch Conversion Complete! "
echo "Move your new .ogv files into the mod's assets folder."
echo "========================================"