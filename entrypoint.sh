#!/bin/sh

set -e
set -x

SSH_PATH="$HOME/.ssh"

mkdir -p "$SSH_PATH"
touch "$SSH_PATH/known_hosts"

echo "${INPUT_KEY}" > "$SSH_PATH/deploy_key"

chmod 700 "$SSH_PATH"
chmod 600 "$SSH_PATH/known_hosts"
chmod 600 "$SSH_PATH/deploy_key"

eval $(ssh-agent)
ssh-add "$SSH_PATH/deploy_key"
ssh-add -L
ssh-keyscan -t rsa ${INPUT_HOST} >> "$SSH_PATH/known_hosts"
cat "$SSH_PATH/known_hosts"
ssh -v -i "$SSH_PATH/deploy_key" -o StrictHostKeyChecking=no -A -tt -p 22 ${INPUT_USER}@${INPUT_HOST} "$*"
