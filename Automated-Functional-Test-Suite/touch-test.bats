#Written by Scott McKay
#Wednesday, September 26th, 2018
#Automated testing for `touch` command in bash.

#Set-up I: Verify files were created, names and extensions are correct, and no duplicates
@test "Basic file creation" {
	run rm -rf testing_folder
	run mkdir testing_folder
	run touch testing_folder/file1.txt
	run touch testing_folder/file1.txt
	run touch testing_folder/file1.odt
	answer=$(ls testing_folder/ | xargs)
	echo "Test 1 output is: $answer" >&3
	[ "$answer" = "file1.odt file1.txt" ]
	run rm -rf testing_folder
}

@test "Hidden file creation" {
	run rm -rf testing_folder
	run mkdir testing_folder
	run touch testing_folder/.hidden_file.txt
	answer=$(ls -a testing_folder/ | xargs)
	echo "Test 2 output is: $answer" >&3
	[ "$answer" = ". .. .hidden_file.txt" ]
	run rm -rf testing_folder

}

@test "File creation with space(s) in name" {
	run rm -rf testing_folder
	run mkdir testing_folder
	run touch testing_folder/"file with spaces.txt"
	answer=$(ls -l testing_folder/ | xargs)
	#If statement ensures that only a signle file, and no directories were created.
	if [[ $answer = *"-rwxrwxrwx"* && $answer = *"file with spaces.txt"* ]]; then
		answer="pass"
	fi
	echo "Test 3 output is: $answer" >&3
	[ "$answer" = "pass" ]
	run rm -rf testing_folder
}

#Set-up II: Verify that `touch -c <filename.extension>` does not create a file.
@test "Abort file creation with -c operator" {
	run rm -rf testing_folder
	run mkdir testing_folder
	run touch -c testing_folder/nofile.txt
	answer=$(ls -l testing_folder/)
	echo "Test 4 output is: $answer" >&3
	[ "$answer" = "total 0" ]
	run rm -rf testing_folder
}

#Set-up III: Verify that file has correct date format
@test "File creation with in-bounds date" {
	run rm -rf testing_folder
	run mkdir testing_folder
	run touch -d 09/04/1995 testing_folder/scott.txt
	answer=$(date --utc --reference=testing_folder/scott.txt +%D)
	echo "Test 5 output is: $answer" >&3
	[ "$answer" = "09/04/95" ]
	run rm -rf testing_folder
}

@test "File creation with out-of-bounds date" {
	run rm -rf testing_folder
	run mkdir testing_folder
	run touch -d 00/00/0000 testing_folder/file.txt
	[ "$status" -eq 1 ]
	run rm -rf testing_folder
}
