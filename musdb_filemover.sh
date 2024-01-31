#!/bin/bash


# Step One

main_folder="./data/musdb-hq/train"
# Navigate to the directory
cd "$main_folder"

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

# Step two

# Define the path to the 'input' subfolder
input_subfolder="${main_folder}/input"

# Create the 'input' subfolder if it does not exist
mkdir -p "$input_subfolder"

# Move all files (but not directories) from the main folder to the 'input' subfolder
find "$main_folder" -maxdepth 1 -type f -exec mv {} "$input_subfolder" \;



# Step Three
directory="${main_folder}/input"

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