# touch Test Procedure

## Basic File Creation

### Set-up I

1. Navigate to an empty directory
2. Run: `touch filename.extension`, creating a regular file.
3. Run: `touch "filenamePart1 filenamePart2 ... filenamePartN.extension"`, creating a file with a space / spaces in the name.
4. Run: `touch .filename.extension"`, creating a hidden file.
5. Run: `touch duplicate.txt`
6. Run: `touch duplicate.txt`
7. Run: `touch duplicate.odt`

### Verification

1. Verify that all files were created.  To see the hidden files run `ls -a`.
        1. Verify that duplicate.txt was not created twice.
        2. Verify that duplicate.odt was created.
2. Verify that the file names are correct.
        1. Verify that files names with spaces in them have spaces
        2. Verify that files names with spaces in them had the double quotes omitted.
3. Verify that the file extensions are correct.

### Set-up II
1. Navigate to (or remain in) the same directory as in Set-up I
2. Run `touch -c filename.extension`

### Verification
1. Verify that no file was created by running `ls`

### Set-up III
1. Navigate to (or remain in) the same directory as in Set-up I
2. Run: `touch -d MM/DD/YYYY filename.extension`
        1. MM/DD/YYYY can be any date.
3. Run: `touch -d 00/00/0000 filename.extension`

#### Verification
1. Verify that file was created with associated date by running `ls -l`
2. Running `touch -d 00/00/0000 filename.extension` should prompt the user with an error: invalid date format '00/00/0000'
