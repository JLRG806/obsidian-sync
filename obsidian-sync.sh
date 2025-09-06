#!/bin/bash
set -e

cat << "EOF"
    ______    _______    ________  __     ________   __          __      _____  ___        /$$$$$$
   /    " \  |   _  "\  /"       )|" \   |"      "\ |" \        /""\    (\"   \|"  \      /$$__  $$
  // ____  \ (. |_)  :)(:   \___/ ||  |  (.  ___  :)||  |      /    \   |.\\   \    |    | $$  \__/ /$$   /$$ /$$$$$$$   /$$$$$$$
 /  /    ) :)|:     \/  \___  \   |:  |  |: \   ) |||:  |     /' /\  \  |: \.   \\  |    |  $$$$$$ | $$  | $$| $$__  $$ /$$_____/
(: (____/ // (|  _  \\   __/  \\  |.  |  (| (___\ |||.  |    //  __'  \ |.  \    \. |    \____  $$| $$  | $$| $$  \ $$| $$
 \        /  |: |_)  :) /" \   :) /\  |\ |:       :)/\  |\  /   /  \\  \|    \    \ |    /$$  \ $$| $$  | $$| $$  | $$| $$
  \"_____/   (_______/ (_______/ (__\_|_)(________/(__\_|_)(___/    \___)\___|\____\)   |  $$$$$$/|  $$$$$$$| $$  | $$|  $$$$$$$
                                                                                         \______/  \____  $$|__/  |__/ \_______/
                                                                                                    /$$  | $$
                                                                                                   |  $$$$$$/
                                                                                                    \______/
EOF

echo "Starting Obsidian notes sync..."
# Load environment variables from .env file if it exists
if [ -f .env ]; then
  set -a
  source .env
  set +a
fi

echo "Using SSH key from: $GITHUB_PRIVATE_SSH_KEY_PATH"

# Start the SSH agent and add the private key
eval "$(ssh-agent -s)"
ssh-add "${GITHUB_PRIVATE_SSH_KEY_PATH}"

# Pull the latest changes from the remote repository
echo "Pulling latest changes from remote repository..."
git pull origin main

echo "Syncing notes from Obsidian vault..."


echo "Do you want to push changes to the remote repository? (y/n)"
# Read user input 
read -r user_input
user_input="$(echo "$user_input" | xargs)" # Trim whitespace

while [ -z "$user_input" ]; do
  echo "Input cannot be empty. Please enter 'y' or 'n':"
  read -r user_input
  user_input="$(echo "$user_input" | xargs)"
done

if [ "$user_input" = "y" ] || [ "$user_input" = "Y" ]; then
  # Stage all changes
  git add .

  echo "Committing changes..."
  if [ -z "$GIT_COMMIT_MESSAGE" ]; then
    echo "GIT_COMMIT_MESSAGE is not set. Please enter a commit message:"
    read -r GIT_COMMIT_MESSAGE
    if [ -z "$GIT_COMMIT_MESSAGE" ]; then
      echo "Commit message cannot be empty. Aborting."
      exit 1
    fi
  fi
  git commit -m "$GIT_COMMIT_MESSAGE"

  echo "Pushing changes to remote repository..."
  git push origin main
fi

# Kill the SSH agent
eval "$(ssh-agent -k)"

# Success message
echo "----------------------------------------"
echo "📦 Obsidian Sync"
echo "✅ Sync completed at $(date '+%Y-%m-%d %H:%M:%S')"
echo "----------------------------------------"


