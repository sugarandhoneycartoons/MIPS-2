# This code works fine in QtSpim simulator
.data
	string: .word 4
	
.text
	
	main: 
		#gets the input from the user

		la $a0, string
    	la $a1, string
    	li $v0, 8
    	syscall

		move $t3, $zero #this will be the "total" variable and it will have a value of zero
		la $t0, string #loads the string to this address