# cf-terraforming-docker
A docker Image to run [CF-Terraforming](https://github.com/cloudflare/cf-terraforming) for importing of state for Cloudflare

**Image on DockerHub:**

https://hub.docker.com/repository/docker/rolandok/cf_terraforming

Get the image via the following command:

_docker pull rolandok/cf_terraforming_

**Build locally**

_Build and tag the image from the repo root_

docker build -f dockerfile -t rolandok/cf_terraforming:latest .

**Usage**

_Help_

docker run -it --rm rolandok/cf_terraforming --help 

_Generate Resource definitions based on existing infrastructure_

docker run -it --rm rolandok/cf_terraforming -z $zoneId -e $email -k $globalApiKey generate --resource-type "cloudflare_record"

_Import existing resources into state file_

docker run -it --rm rolandok/cf_terraforming -a $accountId -e $email -k $globalApiKey import --resource-type "cloudflare_record"
