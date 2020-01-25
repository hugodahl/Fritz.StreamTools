#!/usr/bin/env sh

# Display usage if the tag name parameter was not specified
if [ -z "$1" ];
then
	echo "Specify a value for the docker image tag to remove\n"
	echo "Usage : "
	echo "\t${0##*/} \"<tag>\""
	exit 1
fi

docker rmi fritzregistry.azurecr.io/fritz.streamtools:$1
docker rmi fritz.streamtools:$1
