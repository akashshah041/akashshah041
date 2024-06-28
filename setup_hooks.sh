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
    if git cherry-pick "$start_commit"; then
        echo "Cherry-pick successful for branch: $branch"
    else
        echo "Cherry-pick failed for branch: $branch. Aborting."
        git cherry-pick --abort
        return 1
    fi

    echo "Adding hooks and setup_config.sh"
    # Push the changes to the remote branch
    git push origin "$branch"
    # Add and commit the hooks and setup_config script
    git add hooks setup_config.sh
    git commit -m "Add hooks and setup_config"

    echo "Pushing changes to remote branch: $branch"

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
    IFS=' ' read -r branch start_commit <<< "$branch_info"
    process_branch "$branch" "$start_commit"
done

# Checkout back to the main branch
git checkout master
