#!/bin/bash

# Navigate to _posts directory
cd _posts

# Iterate over each file in the directory
for file in *; do
    # Check if the filename matches the desired format using a regex pattern
    if [[ ! -f $file ]]; then
        continue
    fi
    if [[ ! $file =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2} ]]; then
        # Extract the date from the file's content (assuming the date is in the Front Matter)
        date=$(grep -E '^date: ' "$file" | sed -E 's/date: ([0-9]{4}-[0-9]{2}-[0-9]{2}).*/\1/')
        # If a date is found, rename the file
            new_name=`date +"%Y-%m-%d"`"-${file}"
            mv "$file" "$new_name"
            echo "Renamed $file to $new_name"
            # Handle the case where no date is found in the file's Front Matter
            echo "Warning: No date found in $file. Skipping."
    fi
done

