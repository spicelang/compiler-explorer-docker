#!/bin/sh

docker build -t compiler-explorer:latest .
docker run compiler-explorer