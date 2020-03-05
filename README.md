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


Each entry has the following fields. The fields are separated by a colon.

● Absolute path of the file or directory

● Permissions of the file (all permissions in the form they are displayed by the “ls -al”
command)

● Check permissions as the Linux system checks permissions. Start with user, then
group, then other and stop when you find a match.

○ Each line has a single letter (U, G, or O) indicating what is applicable in
this case as well as a Y if execute permission is there for the permission in
question or a N if execute permission is not present.

● Trap exit the script and ensure everything (temporary files, etc.) is cleaned up
properly




# USEFUL TEST CASES

test - below are the file tests

○ Reads a series of options up to a semicolon and returns a value depending upon results

○ -f = tests for existence of a file and that it is a normal file (not directory, not a device file)

○ -ef = files have same device and inode numbers

○ -nt = file1 newer (later modification date) than file2

○ -ot = file1 older than file2

○ -d = file exists and is a directory

○ -e = file exists

○ -h = file exists and is a symbolic link

○ -r = file exists and user can read it

○ -s = file exists and file size is greater than zero

○ -w = file exists and user can write it

○ -x = file exists and user can execute it


● Testing strings

○ -z = zero length string

○ -n = non-zero length string

○ = strings are equal

○ != strings are not equal
