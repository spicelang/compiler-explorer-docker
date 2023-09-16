FROM ubuntu:22.04

# Install baseline
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y ca-certificates software-properties-common apt-utils && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata curl wget git build-essential binutils gcc-11 g++-11 && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install LLVM
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 17 && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y llvm && \
    rm -rf /var/lib/apt/lists/*

# Install Spice
RUN curl -fsSL https://server.chillibits.com/files/repo/gpg | tee /etc/apt/trusted.gpg.d/chillibits.asc && \
    add-apt-repository "deb https://repo.chillibits.com/$(lsb_release -is | awk '{print tolower($0)}')-$(lsb_release -cs) $(lsb_release -cs) main" && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y spice

# Install Compiler Explorer
RUN git clone --depth 1 https://github.com/spicelang/compiler-explorer.git /opt/compiler-explorer
RUN cd /opt/compiler-explorer && npm install && make prebuild

WORKDIR /opt/compiler-explorer
EXPOSE 10240
ENTRYPOINT [ "make", "run-only" ]