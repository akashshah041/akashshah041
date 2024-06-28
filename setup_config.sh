#!/bin/bash

# Copy the post-checkout hook to the .git/hooks directory
cp hooks/post-checkout  .git/hooks/
chmod +x .git/hooks/post-checkout

# Set the custom hooks path for the current branch
git config core.hooksPath hooks

