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
		
	str2int:
		#$t4 is acting as a boolian of sorts
		slt $t4, $t2, '0' #check if value is less than ascii value of 0
		beq $t4, 1, space_and_extra #check if t4 is one. if one then go to loop
		slt $t4, $t2, 0x3A #check if value is less than ascii value of :.
		beq $t4, 1, numbers #if t4 is one then go to numbers