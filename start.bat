@echo off

docker build -t compiler-explorer:latest .
docker run compiler-explorer