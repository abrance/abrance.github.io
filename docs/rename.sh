#!/bin/bash

rename_files() {
    local current_dir="$1"
    cd "$current_dir"

    # Iterate over each file in the current directory
    for file in *; do
        # If the item is a directory, recursively call the function
        if [[ -d $file ]]; then
            rename_files "$file"
            cd ..
        # If the item is a file and doesn't match the desired format, rename it
	    elif [[ -f $file && $file =~ \.md$ && ! $file =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2} ]]; then

            # Extract the date from the file's content (assuming the date is in the Front Matter)
            date=$(grep -E '^date: ' "$file" | sed -E 's/date: ([0-9]{4}-[0-9]{2}-[0-9]{2}).*/\1/')
            if [[ -z $date ]]; then
                echo "Warning: No date found in $file. Using current date for renaming."
                date=$(date +"%Y-%m-%d")
            fi
            new_name="${date}-${file}"
            mv "$file" "$new_name"
            echo "Renamed $file to $new_name"
        fi
    done
}

# Call the function starting from the _posts directory
rename_files _posts
