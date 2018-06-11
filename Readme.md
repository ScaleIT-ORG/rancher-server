# ScaleIT Platform Container Manager - Rancher Server

## Get started:
1. Rename `.env.default`file to `.env` and run `docker-compose up` in the current directory. This script runs the docker-compose.yml with 
Rancher Server specifications. 
2. In Rancher UI, go to Admin -> Settings and update the Host Registration
 with the updated URL for Rancher server (e.g. staging.server.edu:8080). Please note that it must include
 the exposed port (8080) that you started Rancher server with
 (https://docs.rancher.com/rancher/v1.2/en/faqs/server/#what-happens-
if-the-ip-of-rancher-server-has-changed)
3. Go to Infrastructure -> Hosts. If you see any hosts already started, consider to delete them if their state is not "Running" during next 2 Minutres. Afterwards click "Add Host" button and you will be redirected to the page with the docker command which has to be run on your server. So just run that command with the command line of your server (consider to copy the command without "sudo", if you do not need admin permission). 

Now the rancher server is set up and ready for further exploitations. 

## Proxy
There is the separate software as a submodule, called Rancher Active Proxy, which is an all-in-one reverse proxy for [Rancher](http://rancher.com), supporting Letsencrypt out of the box!

### Easy Setup with catalog
Add `https://github.com/ScaleIT-ORG/spcm-active-proxy-rancher.git` to your custom catalog list (Rancher > Admin > Settings).
Then go to catalog and install Rancher Active Proxy !

### How to configure proxy for your application
Here are described steps that are needed to provide DNS-forwarding to an application by reverse proxy.
All that you need is to add approriate labels to the docker-compose.yml 
that starts your application. 

The first label is `rap.port: 'some_port's_number'`. This label defines the port of the container to use (is only needed if several port are exposed ). If this label is not defined, the default port 80 will be used.

The second label is `rap.host: dns-name.of.your.app`. This label defines virtual host to use (several value could be separate by , ).

The possible example can look like this: 
    
    version: '2'
    services:
      myapp:
        image: app_image/my_app

        volumes:
          - my/app/volumes

        ports:
          - 80:80          
        labels:
          rap.port: '80'   
          rap.host: myapp.example.com
          rap.le_host: myapp.example.com

If SSL usage is required, then the volume, which contains the corresponding certificates, has to be added to the `docker-compose.yml` file, for more detailed infromation please refer to the [correspondig section](https://github.com/adi90x/rancher-active-proxy#ssl-support) of the original documentation.
These are basic steps described that are needed to provide reverse proxy for your app. If you need to elaborate more complex stuff, check the documentation of the other [possible labels](https://github.com/adi90x/rancher-active-proxy#summary-of-available-labels-for-proxied-containers) by reverse proxy service. 

If you need to provide more advanced general settings, please refer to the [full documentation](https://github.com/adi90x/rancher-active-proxy) 
