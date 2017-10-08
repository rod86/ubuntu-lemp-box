#!/bin/bash

### CONFIG #####
VIRTUALHOSTS_PATH="/etc/nginx/sites-available/"
TEMPLATES_PATH="/home/vagrant/bin/templates/"


# Check if the user is root
if [ $USER != 'root' ]
then
    echo "This script must be run as a root user" >&2
    exit 1
fi

# get parameters
while getopts ":h:n:t:" opt; do
    case $opt in
        h)
            project_host="$OPTARG"
            ;;
        n)
            project_name="$OPTARG"
            ;;
        t)
            project_type="$OPTARG"
            ;;
        \?)
            echo "Invalid option -$OPTARG" >&2
            exit 1
            ;;
    esac
done

# project domain
if [ -z $project_host ]
then
    echo "Paramater -h is required" >&2
fi

if [ -f ${VIRTUALHOSTS_PATH}${project_host} ]
then
    echo "Host ${project_host} already exists" >&2
    exit 1
fi

# project name
if [ -z $project_name ]
then
    project_name=$project_host
fi

# project type
if [ -z $project_type ]
then
    project_type='default'
fi

if [ ! -z $project_type ] && [ ! -f $TEMPLATES_PATH$project_type ]
then
    echo "Project type ${project_type} doesn't exist" >&2
    exit 1
fi


### GENERATE HOST FILE ###

echo "Generating host ${project_host}..."

template=$TEMPLATES_PATH$project_type
virtualhost=$VIRTUALHOSTS_PATH$project_host

echo "Creating host files..."
cp $template $virtualhost

# replace values
sed -i s/{{PROJECT_NAME}}/$project_name/g $virtualhost
sed -i s/{{PROJECT_HOST}}/$project_host/g $virtualhost

echo "Enabling host..."
ln -s $virtualhost ${virtualhost/sites-available/sites-enabled}


### RESTART SERVICES ###

echo "Restarting services..."
service nginx restart

echo "Host generated successfully"
exit 0
