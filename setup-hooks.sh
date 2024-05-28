#!/bin/bash

# Set the path to the Git hooks directory
hooks_dir=".githooks"

# Create symbolic links for each hook script in the .githooks directory
for hook in $(ls $hooks_dir); do
    ln -sf ../../$hooks_dir/$hook .git/hooks/$hook
done
