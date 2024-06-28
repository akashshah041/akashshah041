#!/bin/bash

# Copy the pre-commit hook to the .git/hooks directory
cp hooks/pre-commit .git/hooks/
chmod +x .git/hooks/pre-commit
