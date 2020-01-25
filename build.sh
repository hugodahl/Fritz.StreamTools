#!/usr/bin/env sh

# Print usage if the tag wasn't spefied.
if [ -z "$1" ];
then
	echo "Specify a value for the tag to be used for git and docker\n"
	echo "Usage : "
	echo "\t${0##*/} \"<tag>\""
	exit 1
fi

echo "Git commit and docker images will be tagged with \"$1\" . . ."

# Build the docker image locally
docker build -t fritz.streamtools:$1 -t fritz.streamtools:latest -f Fritz.StreamTools/Dockerfile .

# Tag the newly built image with the specified tag, as well as ":latest"
docker tag fritz.streamtools:$1 fritzregistry.azurecr.io/fritz.streamtools:$1
docker tag fritz.streamtools:$1 fritzregistry.azurecr.io/fritz.streamtools:latest

# Tag the git commit, and push to the remote
git tag v$1
git push --tags

# Push the newly built image and tags to the container registry
docker push fritzregistry.azurecr.io/fritz.streamtools:$1
docker push fritzregistry.azurecr.io/fritz.streamtools:latest
