# User-Privilege-Management-System
User Privilege Management System for Linux based user using Shell Scripting


A bash shell script that takes the information below as input on the command line as
arguments or reading interactively from the user if the input isn’t provided on the command line
as an argument. Both methods need to be supported.

● User ID or username (either should be accepted as valid input - both are not allowed to
be given in the same run of your script)

○ Must validate the UID or username as one that exists on this system (check in
/etc/passwd)

○ Exit with a descriptive error message if it does not exist

● Group ID or group name (either should be accepted as valid input - both are not allowed
to be given in the same run of your script)

○ Must validate the GID or group name as one that exists on the system and that
the user provided is a member of that group

○ Exit with a descriptive error message if it does not exist

● Absolute path of the directory to search in

○ Must validate the path to ensure the directory exists

○ Exit with a descriptive error message if it does not exist
