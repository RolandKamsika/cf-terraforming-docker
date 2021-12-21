# cf-terraforming-docker
A docker Image to run CF-Terraforming for importing of state for Cloudflare

**Usage**

_Help_

docker run -it --rm rolandok/cf_terraform --help 

_Generate Resource definitions based on existing infrastructure_

docker run -it --rm rolandok/cf_terraform -z $zoneId -e $email -k $globalApiKey generate --resource-type "cloudflare_record"

_Import existing resources into state file_

docker run -it --rm rolandok/cf_terraform -a $accountId -e $email -k $globalApiKey import --resource-type "cloudflare_record"
