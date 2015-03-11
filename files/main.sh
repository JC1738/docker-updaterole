#!/bin/sh -x

#
# main entry point to run s3cmd
#

#
# Check for required parameters
#

if [ -z "${role}" ]; then
    echo "ERROR: Role not set."
    exit 1
fi

if [ -z "${version}" ]; then
    echo "ERROR: Version not set."
    exit 1
fi


echo "Starting Update Role"



echo "All parameters have been provided..."

knife role show ${role} -f json > temp.json

#cat temp.json

underscore -i temp.json process "data.default_attributes.deploy.versionToDeploy='${version}';data;" -o new.json

cat new.json

knife role from file new.json

#underscore -i gc-deploy-uat1.json process 'data.default_attributes.deploy.versionToDeploy="Trunk_UmamiFrontEnd_7645.prod.com.zip";data;' -o gc-deploy-uat1_new.json

#
# Finished operations
#
echo "Finished knife operations"
