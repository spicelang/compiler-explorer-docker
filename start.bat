@echo off

docker ps -q --filter ancestor="compiler-explorer" | xargs -r docker stop
docker build -t compiler-explorer --label compiler-explorer .
docker run -d -p 80:10240 --name compiler-explorer compiler-explorer
