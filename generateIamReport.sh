#!/bin/bash

createRoleList () {

  json=`az role definition list --custom-role-only --query "[].{roleName:properties.roleName, description:properties.description, permissions:properties.permissions[0].actions[]}"`
  len=$(echo $json | jq length)

  seq=0
  echo -e "seq\troleName\tdescription\tpermission"
  for i in $( seq 0 $(($len - 1)) ); do
    row=$(echo $json | jq .[$i])
    roleName=$(echo $json | jq .[$i].roleName | sed -e 's/"//g')
    description=$(echo $json | jq .[$i].description | sed -e 's/"//g')
    permissions=$(echo $json | jq .[$i].permissions)


    for j in $( seq 0 $(($(echo $permissions | jq length ) - 1))); do
      permission=$(echo $permissions | jq .[$j] | sed -e 's/"//g')
      echo -e "$seq\t$roleName\t$description\t$permission"  
      seq=$((seq+1))
    done
  done

}

az role assignment list --all --query "[].{principalName:properties.principalName, roleDefinitionName:properties.roleDefinitionName, scope:properties.scope}" -o tsv > $(date '+%Y%m%d')_customRoles_tmp.tsv
echo -e "principalName\troleDefinitionName\tscope" | cat - $(date '+%Y%m%d')_customRoles_tmp.tsv > $(date '+%Y%m%d')_customRoles.tsv
rm $(date '+%Y%m%d')_customRoles_tmp.tsv

createRoleList > $(date '+%Y%m%d')_customRoleAssignment.tsv
