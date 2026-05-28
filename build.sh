#!/bin/bash

# Build the image
docker build -t soapyaudio-builder . || exit 1

# Extract the build artefacts
container_id=$(docker create soapyaudio-builder)
docker cp $container_id:/src/installed.tgz soapyaudio-builder-artefacts.tgz
docker rm $container_id
