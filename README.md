# docker-updaterole
use docker to update chef role


This docker image is pretty specific to the need to update a chef role with particular parameters.  In this case, version number attribute.



Assuming %xyz% are parameters

chef_deploy_role is the name of the chef role to update
deploy_role_version is the new version number, which will update an attribute in the following path: default_attributes.deploy.versionToDeploy

docker run --env role=%chef_deploy_role% --env version="%deploy_role_version%" -v local/chef:/etc/chef jcastillo/docker-upgraderole:v2
