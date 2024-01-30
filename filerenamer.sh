#!/bin/bash

# Define the directory containing the .wav files
directory="./data/musdb-hq/train/input"

# Initialize the counter
counter=1

# Loop through all .wav files in the directory
for file in "$directory"/*.wav; do
    # Check if the file is a regular file
    if [ -f "$file" ]; then
        # Construct the new file name with the counter
        new_file="${directory}/sample${counter}.wav"

        # Rename the file
        mv "$file" "$new_file"

        # Increment the counter
        ((counter++))
    fi
done
