# generateAzureIamReport

This script generates the following files.

- A list of custom role including detailed permissions
- A list showing the relationship between users and custom roles

## Install

In Cloud Shell:

````
git clone https://github.com/kongou-ae/generateAzureIamReport.git
cd generateAzureIamReport
````

## Usage

In Cloud Shell:

````
/bin/bash generateIamReport.sh
mv *.tsv  ../clouddrive/
````

And you can download the following files from Azure Files.

- yyyymmdd_customRoleAssignment.tsv
- yyyymmdd_customRoles.tsv 
