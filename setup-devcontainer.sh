#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
TEMPLATE_FILE="$SCRIPT_DIR/python-js.json"

if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "Error: Template file $TEMPLATE_FILE not found"
    exit 1
fi

echo "Setting up devcontainer for your project..."
echo

read -p "Enter project name: " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
    echo "Error: Project name cannot be empty"
    exit 1
fi

read -p "Enter Docker path [../Dockerfile]: " DOCKER_PATH
if [ -z "$DOCKER_PATH" ]; then
    DOCKER_PATH="../Dockerfile"
fi

read -p "Enter container user [vscode]: " CONTAINER_USER
if [ -z "$CONTAINER_USER" ]; then
    CONTAINER_USER="vscode"
fi

TARGET_DIR=".devcontainer"
TARGET_FILE="$TARGET_DIR/devcontainer.json"

if [ ! -d "$TARGET_DIR" ]; then
    mkdir -p "$TARGET_DIR"
    echo "Created .devcontainer directory"
fi

if [ -f "$TARGET_FILE" ]; then
    read -p "devcontainer.json already exists. Overwrite? (y/N): " OVERWRITE
    if [[ ! "$OVERWRITE" =~ ^[Yy]$ ]]; then
        echo "Aborted"
        exit 0
    fi
fi

sed -e "s/\"name\": \"python-js\"/\"name\": \"$PROJECT_NAME\"/" \
    -e "s|\"dockerfile\": \"../Dockerfile\"|\"dockerfile\": \"$DOCKER_PATH\"|" \
    -e "s|target=/home/vscode/.config|target=/home/$CONTAINER_USER/.config|" \
    -e "s|// \"remoteUser\": \"root\"|\"remoteUser\": \"$CONTAINER_USER\"|" \
    "$TEMPLATE_FILE" > "$TARGET_FILE"

echo
echo "✅ devcontainer.json created successfully at $TARGET_FILE"
echo "Project name: $PROJECT_NAME"
echo "Docker path: $DOCKER_PATH"
echo "Container user: $CONTAINER_USER"