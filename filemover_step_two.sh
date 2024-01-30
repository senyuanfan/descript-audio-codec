#!/bin/bash

# Define the path to your main folder
main_folder="./data/musdb-hq/test"

# Define the path to the 'input' subfolder
input_subfolder="${main_folder}/input"

# Create the 'input' subfolder if it does not exist
mkdir -p "$input_subfolder"

# Move all files (but not directories) from the main folder to the 'input' subfolder
find "$main_folder" -maxdepth 1 -type f -exec mv {} "$input_subfolder" \;