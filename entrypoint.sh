#!/bin/sh

set -e

SSH_PATH="$HOME/.ssh"

mkdir -p "$SSH_PATH"
touch "$SSH_PATH/known_hosts"

echo "${INPUT_KEY}" > "$SSH_PATH/deploy_key"

chmod 700 "$SSH_PATH"
chmod 600 "$SSH_PATH/known_hosts"
chmod 600 "$SSH_PATH/deploy_key"

eval $(ssh-agent)
ssh-add "$SSH_PATH/deploy_key"
echo "HOST: ${HOST}"
echo "INPUT_HOST: ${INPUT_HOST}"
echo "USER: ${USER}"
echo "INPUT_USER: ${INPUT_USER}"
ssh-keyscan -t rsa ${INPUT_HOST} >> "$SSH_PATH/known_hosts"

ssh -o StrictHostKeyChecking=no -A -tt -p ${PORT:-22} ${INPUT_USER}@${INPUT_HOST} "$*"
