#!/bin/bash
# --- Publish Script for my Github Blog!
# --- Auth: Breno Augusto Cruz Faria

directory=`pwd | cut -d '/' -f5` 
main_directory="brenoacf.github.io"

# Check directory
# ---------------
if [ "$directory" != "$main_directory" ]; then
    echo "Invalid directory"
    exit
fi

# Check Git Commit Message
# ------------------------
if [ $# -lt 1 ]; then
    echo "Missing commit message"
    exit
fi

# Check git status
# ----------------
if output=$(git status --porcelain) && [ -z "$output" ]; then
    echo "Not to commit"
    exit
fi

echo "Commiting with message: $1"
git add --all
git commit -m "$1"
git push origin master

#END
