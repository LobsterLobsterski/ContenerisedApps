#!/bin/bash

# Exit on error
set -e

# Check arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: ./builder.sh <GitHubRepo> <DockerHubRepo>"
  echo "Example: ./builder.sh mluukkai/express_app mluukkai/testing"
  exit 1
fi

# Extract parameters
GITHUB_REPO=$1
DOCKER_REPO=$2
REPO_NAME=$(basename "$GITHUB_REPO")

# Check Docker Hub credentials
if [ -z "$DOCKER_USER" ] || [ -z "$DOCKER_PWD" ]; then
  echo "Error: DOCKER_USER and DOCKER_PWD must be set."
  exit 1
fi

# Login to Docker Hub
echo "Logging into Docker Hub..."
echo "$DOCKER_PWD" | docker login -u "$DOCKER_USER" --password-stdin

# Clone GitHub repository
echo "Cloning repository https://github.com/$GITHUB_REPO.git ..."
git clone "https://github.com/$GITHUB_REPO.git"

# Change directory and build Docker image
cd "$REPO_NAME" || exit
echo "Building Docker image $DOCKER_REPO:latest ..."
docker build -t "$DOCKER_REPO:latest" .

# Push the image to Docker Hub
echo "Pushing Docker image to Docker Hub..."
docker push "$DOCKER_REPO:latest"

# Cleanup
cd ..
rm -rf "$REPO_NAME"

echo "Done! Image pushed to Docker Hub: $DOCKER_REPO:latest"
