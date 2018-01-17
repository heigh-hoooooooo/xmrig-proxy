FROM ubuntu:16.04

WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get -y install build-essential cmake libuv1-dev uuid-dev libmicrohttpd-dev

# Clean
RUN rm -rf /var/lib/apt/lists/*

# Get Code
COPY . .

RUN mkdir build
WORKDIR /app/build
RUN cmake .. -DCMAKE_BUILD_TYPE=Release -DUV_LIBRARY=/usr/lib/x86_64-linux-gnu/libuv.a
RUN make -j

# Volume
VOLUME /config
RUN cp /app/src/config.json /config/config.json

# Ports
EXPOSE 80

# Command
CMD ["/app/build/xmrig-proxy", "-c", "/config/config.json"]
