# This code works fine in QtSpim simulator
.data
    invalid_message: .asciiz "Invalid input\n"
	string: .word 4
	
.text
	
	main: 
		#gets the input from the user

		la $a0, string
    	la $a1, string
    	li $v0, 8
    	syscall
		
		move $t3, $zero #this will be the "total" variable and it will have a value of zero
		move $t5, $zero #this is the character count variable
		la $t0, string #loads the string to this address
		
	loop:
		lb $t2, ($t0) # loads a byte into $t2
		beqz $t2, endloop #if $t2 is equal to zero, go to endloop
		beq $t2, ' ', space_and_extra
		j str2int

	space_and_extra:
		addi $t0, $t0, 1 #moves through the loop by 1
		addi $t5, $t5, 1 #adds 1 to variable count

		beq $t5, 5, invalid_input #if t5 is less than 5 then t6 is 1
		
		j loop #jumps back to the loop function
        
    invalid_input:
		la $a0, invalid_message #These lines print out "invalid input"
        li $v0, 4
		syscall
        
        li $v0, 10 #ends the program
        syscall

	str2int:
		#$t4 is acting as a boolian of sorts
		slt $t4, $t2, '0' #check if value is less than ascii value of 0
		beq $t4, 1, space_and_extra #check if t4 is one. if one then go to loop
		slt $t4, $t2, 0x3A #check if value is less than ascii value of :.
		beq $t4, 1, numbers #if t4 is one then go to numbers
		
		slt $t4, $t2, 'A' #check if value is less than ascii value of A
		beq $t4, 1, space_and_extra #check if t4 is one. if one then go to loop
		slt $t4, $t2, '[' #check if value is less than ascii value of [.
		beq $t4, 1, big_letters #if t4 is one then go to big_letters
		
		slt $t4, $t2, 'a' #check if value is less than ascii value of a
		beq $t4, 1, space_and_extra #check if t4 is one. if one then go to loop
		slt $t4, $t2, '{' #check if value is less than ascii value of {.
		beq $t4, 1, little_letters #if t4 is one then go to little_letters
		j space_and_extra #if value is not useful then go to space_and_extra

	big_letters:
		addi $t2, $t2, -55 #convert $t2 to a number + 10 to be added to the sum $t3 ($t2 - 65 or $t2 - 0x37)
		add $t3, $t3, $t2 #adds the value of $t2 into the "total" variable
		j space_and_extra

	little_letters:
		addi $t2, $t2, -87 #convert $t2 to a number + 10 to be added to the sum $t3 ($t2 - 97 or $t2 - 0x57)
		add $t3, $t3, $t2 #adds the value of $t2 into the "total" variable
		j space_and_extra
		
	numbers:
		addi $t2, $t2, -48 #convert $t2 to a number to be added to the sum $t3 ($t2 - 48 or $t2 - 0x30)
		add $t3, $t3, $t2 #adds the value of $t2 into the "total" variable
		j space_and_extra 

	is_blank:
		#check if there have been any nonblank characters as this function is not useful otherwise
		add $t7, $zero, 0
		beqz $s0, space_and_extra
		add $s1, $zero, 1
		j space_and_extra

	is_nonblank:
		add $t7, $zero, 1
		add $s0, $zero, 1
		beq $s1, 1, invalid_input
		j space_and_extra
		
	endloop:
		#this is going to print the total
		li $v0, 1 
		move $a0, $t3
		syscall

#tells it that this is the end of main and ends the program
li $v0, 10 
syscall