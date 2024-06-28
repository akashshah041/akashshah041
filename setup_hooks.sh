#!/bin/bash

# Ensure the script exits if any command fails
set -e

# Function to process each branch
process_branch() {
    local branch=$1
    local start_commit=$2

    echo "Processing branch: $branch"

    # Checkout the branch
    git checkout "$branch"

    # Cherry-pick the commit range
    git cherry-pick "$start_commit"

    # Add and commit the hooks and setup_config script
    git add hooks setup_config.sh
    git commit -m "Add hooks and setup_config"

    # Push the changes to the remote branch
    git push origin "$branch"
}

# List of branches to process with their respective commit ranges
branches=(
    "branch3 7abce6a922480841ba6d108b2bfbc84d8e8c6e11"
    # Add more branches as needed
)

# Loop through each branch and process it
for branch_info in "${branches[@]}"; do
    process_branch "$branch" "$start_commit"
done

# Checkout back to the main branch
git checkout master
