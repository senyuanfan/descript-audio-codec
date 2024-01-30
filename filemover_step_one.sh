#!/bin/bash

# Navigate to the 'test' directory
cd ./data/musdb-hq/train

# Iterate through all subdirectories
for dir in */ ; do
    # Iterate through all .wav files in the subdirectory
    for file in "$dir"*.wav; do
        # Extract the base name of the directory
        dir_base=$(basename "$dir")

        # Extract the filename
        filename=$(basename "$file")

        # Create a new filename with the directory and file name
        new_filename="${dir_base}_${filename}"

        # Move and rename the file to the 'test' directory
        mv "$file" "$new_filename"
    done

    # Optionally, remove the now-empty subdirectory
    rm -r "$dir"
done