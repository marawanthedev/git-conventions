#!/bin/bash

# Get the root directory of the Git project
git_dir=$(git rev-parse --show-toplevel)
hooks_dir="$git_dir/.git/hooks"
commit_msg_hook="$hooks_dir/commit-msg"

# Check if the 'commit-msg' hook already exists
if [ -f "$commit_msg_hook" ]; then
  echo "The 'commit-msg' hook already exists. Skipping creation."
else
  # Create the 'commit-msg' hook script and add the content
  echo '#!/bin/sh' > "$commit_msg_hook"
  echo '#' >> "$commit_msg_hook"
  echo '# This is an example commit-msg hook script.' >> "$commit_msg_hook"
  echo '' >> "$commit_msg_hook"
  cat <<EOF >> "$commit_msg_hook"
commit_message_file="\$1"
commit_message=\$(cat "\$commit_message_file")

# Define the regex pattern for the first format: "productName: message #TicketNumber"
pattern_product="^.+: .+ #[0-9]{1,6}$"

# Define the regex pattern for the second format: "core: message"
pattern_core="^admin: .+"

if ! [[ \$commit_message =~ \$pattern_product || \$commit_message =~ \$pattern_core ]]; then
  echo "Error: Commit messages should follow one of the following patterns:"
  echo "1. 'productName: message #TicketNumber' (e.g., 'MyProduct: Fix a bug #12345')"
  echo "2. 'admin: message' (e.g., 'admin: Update release notes')"
  exit 1
fi
EOF

  # Make the 'commit-msg' hook script executable
  chmod +x "$commit_msg_hook"
  echo "'commit-msg' hook created and made executable."
fi