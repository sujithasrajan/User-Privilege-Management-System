
#!/bin/bash

echo "LINUX PROJECT"

#Parsing Command line Arguements

user=$1
group=$2
path=$3

#Checks if the user input is command line arguement or interactive input

if test -z "$user"
then
	read -p "Enter a Valid Username or UID:" user
	echo $user
fi

#CHECKS IF UID/USERNAME IS VALID

#Checks if the input is number - UID
#Checks if the UID is Valid
if [[ "$user" =~ ^[0-9]+$ ]];
then
	uid=$(cut -d : -f 3 /etc/passwd | grep -w $user)

	if [[ $uid == $user ]];
	then
	echo "$uid exist. Valid Input"
	#Using the UID from the user finding the Username
	username_value=$(awk -v val=$user -F ":" '$3==val{print $1}' /etc/passwd)

	else
	echo "$uid does not exist. Invalid Input"
	exit 1
	fi
#Else Checks if the USERNAME is Valid
else
	user_name=$(cut -d : -f 1 /etc/passwd | grep -w $user)

	if [[ $user_name == $user ]];
	then
	echo "$user_name exist. Valid input"
	username_value=$user

	else
	echo "$user_name does not exist. Invalid Input"
	exit 1
	fi
fi

if test -z "$group"
then
	read -p "Enter a Valid group_name or GID:" group
fi

#CHECKS IF THE GROUPNAME/GID IS VALID

#Checks if input is number - GID
#Checks if GID is Valid

if [[ "$group" =~ ^[0-9]+$ ]];
then
	gid_value=$group
        gid=$(cut -d : -f 4 /etc/passwd | grep -w $group)

        if [[ $gid == $group ]];
        then
        echo "$gid exist. Valid Input"
	#Using the GID from the user to find the Groupname
	groupname_value=$(awk -v val=$group -F ":" '$3==val{print $1}' /etc/group)

        else
        echo "$gid does not exist. Invalid Input"
        exit 1
        fi

#Checks if the GROUPNAME iS Valid

else
        group_name=$(cut -d : -f 1 /etc/group | grep -w $group)

        if [[ $group_name == $group ]];
        then
        echo "$group_name exist. Valid input"
	groupname_value=$group

        else
        echo "$group_name does not exist. Invalid Input"
	exit 1
        fi
fi

#---------------------------------------------------------------------------------------------------------------------------------------

#Checking if the user inputed PATH Exists

if test -z "$path"
then
	read -p "enter the path to check its validity: " path
fi

if [ -d "$path" ];
then
	echo "The path exists in the system"
else
	echo "Invalid path. EXIT 1 Triggered"
	exit 1
fi


echo "" > executables.txt

#IFS File storing the ls - al output
touch test.txt
ls -l $path > test.txt

#Read the test.txt file using IFS and store values in the given variables with space delimiter

while IFS=" " read -r perm hardlink usernm groupnm fsize month date times filename
do
#Check if user owns the file
	if [[ "$username_value" == "$usernm" ]];
	then
#Check if the user has execuatble permissions if yes : add UY , else add : UN
		if [[ "$perm" == ???"x"* ]];
		then
			echo "$path/$filename $perm $usernm $groupnm $fsize $month $date $times $filename :UY" >> executables.txt
		else
			echo "$path/$filename $perm $usernm $groupnm $fsize $month $date $times $filename :UN" >> executables.txt
		fi
#Check the group owns the file

	else
		if [[ "$groupname_value" == "$groupnm" ]];
		then
			if [[ "$perm" == ??????"x"* ]];
			then
                        	echo "$path/$filename $perm $usernm $groupnm $fsize $month date $times $filename :GY" >> executables.txt
			else
                        	echo "$path/$filename $perm $usernm $groupnm $fsize $month $date $times $filename :GN" >> executables.txt
			fi
		else
 			if [[ "$perm" == ?????????"x" ]];
			then
                        	echo "$path/$filename $perm $usernm $groupnm $fsize $month $date $times $filename :OY" >> executables.txt
			else
                        	echo "$path/$filename $perm $usernm $groupnm $fsize $month $date $times $filename :ON" >> executables.txt
			fi
		fi

echo >> executables.txt
fi
done < test.txt

echo "Check the executables.txt file"
trap "rm -r test.txt" EXIT
UPMS.sh
