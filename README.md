# docker-vdr
Docker container with Klaus Schmidinger's VDR

Building:
docker bld -t vdr .

Running the container with DVB support and mapping the ports
docker run -d --name vdr --device=/dev/dvb:/dev/dvb -p 8008:8008 -p 37890:37890 -p 6419:6419 -p 3000:3000 -p 34890:34890 vdr
