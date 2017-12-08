# ScaleIT Platform Container Manager - Rancher Server

## Get started:
1. Rename .env.default file .env and run "sh run.sh" in the current directory. This script runs the docker-compose.yml with 
Rancher Server specifications and after that executes the docker command in order to run the rancher host (agent). 
2. In Rancher, go to Admin -> Settings and update the Host Registration
 with the updated URL for Rancher server. Please note that it must include
 the exposed port that you started Rancher server with
 (https://docs.rancher.com/rancher/v1.2/en/faqs/server/#what-happens-
if-the-ip-of-rancher-server-has-changed)
3. (On First Start on new Machine) Copy Rancher Token to .env file
4. Run in Terminal "docker-compose stop" and "docker-compose up"

## Backup:
In order to provide backups for rancher server, one needs to copy the
 directory with mysql DB (./serverdb). One possible strategy to do this: 

1. Open the directory with rancher server - "cd /srv/container-management/rancher_elk" 
2. Stop all containers to be able to safely copy server's DB - "docker-compose stop"
3. Copy the DB files in some backup-directory "cp -rf ./serverdb <some backup directory>"
4. Now set the UID/GID for the folder so that the mysql user within the container has
 the correct ownership of the mysql mount: "chown -R 102:105 <some backup directory>"
5. Set <some backup directory> in volumes of docker-compose.yml file: "nano docker-compose.yml"
->services->rancher_server->volumes: change line "- /old/directory/serverdb:/var/lib/mysql" to 
"- <some backup directory>/serverdb:/var/lib/mysql"
6. Save changes and run "sh run.sh"

## Oeffentliche Ports:
 -8080

# Elasticsearch

## Beschreibung
Elasticsearch

## Oeffentliche Ports
 -

# Logstash

## Beschreibung
Logstash

## Oeffentliche ports:
 -

# Kibana

## Beschreibung
Kibana

## Oeffentliche Ports
 - 5601
