#!/bin/bash

if [[ "$GOARCH" = "arm" ]]; then

echo "Detected ARM. Setting additional variables.";

apt-get install -y libc6-armel-cross libc6-dev-armel-cross binutils-arm-linux-gnueabi gcc-arm-linux-gnueabihf

env CC=arm-linux-gnueabihf-gcc CXX=arm-linux-gnueabihf-g++ \
CGO_ENABLED=1 GOOS=linux GOARM=7 \
go build \
-installsuffix 'static' \
-ldflags '-extldflags "-static"' \
-o /metrics-sidecar github.com/kubernetes-sigs/dashboard-metrics-scraper

elif [[ "$GOARCH" = "arm64" ]]; then

echo "Detected ARM64. Setting additional variables.";

apt-get install -y gcc-aarch64-linux-gnu

env CC=aarch64-linux-gnu-gcc \
CGO_ENABLED=1 GOOS=linux \
go build \
-installsuffix 'static' \
-ldflags '-extldflags "-static"' \
-o /metrics-sidecar github.com/kubernetes-sigs/dashboard-metrics-scraper

elif [[ "$GOARCH" = "s390x" ]]; then

echo "Detected s390x. Setting additional variables.";

apt-get install -y gcc-s390x-linux-gnu

env CC=s390x-linux-gnu-gcc \
CGO_ENABLED=1 GOOS=linux \
go build \
-installsuffix 'static' \
-ldflags '-extldflags "-static"' \
-o /metrics-sidecar github.com/kubernetes-sigs/dashboard-metrics-scraper
else

echo "Build script building for ${GOARCH}";

go build \
-installsuffix 'static' \
-ldflags '-extldflags "-static"' \
-o /metrics-sidecar github.com/kubernetes-sigs/dashboard-metrics-scraper

fi
