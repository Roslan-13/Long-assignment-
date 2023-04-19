#!/bin/bash

# Create the EmployeeData folder if it doesn't exist
if [ ! -d "/EmployeeData" ]; then
    mkdir /EmployeeData
fi

# Create the HR folder with restricted permissions
mkdir /EmployeeData/HR
chmod 770 /EmployeeData/HR
chmod g-rwx,o-rwx /EmployeeData/HR

# Create the IT, Finance, Executive, Administrative, and Call Centre folders
mkdir /EmployeeData/IT
mkdir /EmployeeData/Finance
mkdir /EmployeeData/Executive
mkdir /EmployeeData/Administrative
mkdir /EmployeeData/Call\ Centre

# Set the permissions for the IT, Finance, Administrative, and Call Centre folders
chmod -R 750 /EmployeeData/IT
chmod -R 750 /EmployeeData/Finance
chmod -R 750 /EmployeeData/Administrative
chmod -R 750 /EmployeeData/Call\ Centre

# Set the permissions for the Executive folder
chmod -R 770 /EmployeeData/Executive

# Set the owner of the folders to their respective department group
chown -R :HR /EmployeeData/HR
chown -R :IT /EmployeeData/IT
chown -R :Finance /EmployeeData/Finance
chown -R :Executive /EmployeeData/Executive
chown -R :Administrative /EmployeeData/Administrative
chown -R :Call\ Centre /EmployeeData/Call\ Centre

# Count the number of folders created
num_folders=$(find /EmployeeData -type d | wc -l)

# Display a message to the user with the number of folders created
echo "$num_folders folders were created under /EmployeeData."

