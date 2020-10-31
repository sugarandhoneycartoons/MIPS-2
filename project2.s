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
			
	loop:
		lb $t2, ($t0) # loads a byte into $t2
		beqz $t2, endloop #if $t2 is equal to zero, go to endloop
		beq $t2, ' ', space_and_extra
		j str2int
		
	space_and_extra:
		addi $t0, $t0, 1 #moves through the loop by 1
		j loop #jumps back to the loop function