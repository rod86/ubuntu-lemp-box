#!/bin/bash

### CONFIG #####
VIRTUALHOSTS_PATH="/etc/nginx/sites-available/"
TEMPLATES_PATH="/home/vagrant/bin/templates/"


echo ''
echo '####  HOST GENERATOR  ####'
echo ''

# Check if the user is root
if [ $USER != 'root' ]
then
    echo "You must run this script as a root user"
    exit
fi


### INPUT PARAMETERS ###

# project name
while [ -z $project_name ]
do
    read -p "Enter project name: " project_name
done

# project domain
while [ -z $project_domain ]
do
    read -p "Enter project domain: " project_domain

    if [ -f ${VIRTUALHOSTS_PATH}${project_domain}.conf ]
    then
        echo "This site already exists"
        project_domain=''
    fi
done

# project type
while [ -z $project_type ]
do
    read -p "Enter project type [default]: " project_type

    if [ -z $project_type ]
    then
        project_type='default'
    fi

    if [ ! -z $project_type ] && [ ! -f $TEMPLATES_PATH$project_type".conf" ]
    then
        echo "project doesn't exists"
        project_type=''
    fi
done


### GENERATE HOST FILE ###

template=$TEMPLATES_PATH$project_type".conf"
virtualhost="${VIRTUALHOSTS_PATH}${project_domain}.conf"

echo "Creating virtualhost for "$project_domain"..."
cp $template $virtualhost

# replace values
sed -i s/{{PROJECT_NAME}}/$project_name/g $virtualhost
sed -i s/{{PROJECT_DOMAIN}}/$project_domain/g $virtualhost

echo "Enabling virtualhost..."
ln -s $virtualhost ${virtualhost/sites-available/sites-enabled}


### RESTART SERVICES ###

echo "Restarting services..."
service nginx restart
