# ACC Dedicated Server Setup

1. Move the Dockerfile to the remote system and build the image.

```
# local
scp Dockerfile tjt1980@acc.lanmaster53.com:/home/tjt1980/
# remote
docker build --rm -t acc-server .
```

2. Configure the server locally using an editor that works with `UTF-16-LE`. Explanations for the files and settings can be found at [https://www.acc-wiki.info/wiki/Server_Configuration](https://www.acc-wiki.info/wiki/Server_Configuration).
3. Move the server to the remote system.

```
# local
scp -r server tjt1980@acc.lanmaster53.com:/home/tjt1980/
```

5. Launch the server.


```
# remote
docker run -d --name acc-server -v "/home/tjt1980/server:/opt/serverr -p 9232:9232/tcp -p 9231:9231/udp acc-server
```

Use the following command to attach to the container. A container cannot be detached from unless the container was created with the `-it` switch. If so, then the `ctrl-p` `ctrl-q` sequence will safely detach from the container without causing it to exit.

```
# remote
docker attach acc-server
```

4. After shutting down the server, remove the container to free up resources.

```
# remote
docker rm acc-server
```

For multiple server configurations, make a local copy of the server, update the configuration files, and reference the new server when uploading and setting the volume on the docker container. For example, if I created a server called `zandvoort-practice`, I would use the following commands to create and use the custom configuration.

```
# local
cp -r server zandvoort-practice
# modify the configuration files
scp -r zandvoort-practice tjt1980@acc.lanmaster53.com:/home/tjt1980/
# remote
docker run -d --name acc-server -v "/home/tjt1980/zandvoort-practice:/opt/server" -p 9232:9232/tcp -p 9231:9231/udp acc-server
```
