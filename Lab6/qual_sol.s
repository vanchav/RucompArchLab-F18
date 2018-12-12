# quad_sol.s
# This assembly program calculates the integer solutions of a quadratic polynomial.
# Inputs : The coefficients a,b,c of the equation a*x^2 + b*x + c = 0
# Output : The two integer solutions. 
#
# All numbers are 32 bit integers

.globl main

main: 					# Read all inputs and put them in floating point registers.

	li t1, 1           # a=1
    li t3, 2           # c=2, moved 
    li t2, -3          # b=-3
	li s0, 1 		   # Square Root Partial Result, sqrt(D), moved
    li a3, 4		   # moved
	
	# In the following lines all the necessary steps are taken to 
	# calculate the discriminant of the quadratic equation
	# D = b^2 - 4*a*c
	
	mul t4,t2,t2 		# t4 = t2*t2, where t2 holds b
	mul t5,t1,t3 		# t5 = t1*t3, where t1 holds a and t3 holds c
	mul t5,t5,a3 		# Multiply value of s0 with 4, creating 4*a*c
	sub t6,t4,t5 		# Calculate D = b^2-4*a*c
	
	
	# calculating the integer square root by the equation x*x = D
	mv s1,t6 			# Move value in register t6 to register s1 for safety purposes.
	
	sqrtloop:			# calculating the integer square root of D

		mul s2, s0,s0
		bge s2, s1, endsqrt
		addi s0,s0, 1
        j sqrtloop
	
	
	endsqrt:
		neg s2,t2		# calculate -b and save it to s2
        li t0, 2 		# Load constant number to integer register, moved
		mul s5,t1,t0 	# Calculate 2*a and save it to s5, moved
		add s3,s2,s0 	# Calculate -b+sqrt(D) and save it to s3
		sub s4,s2,s0 	# Calculate -b-sqrt(D) and save it to s4
		div s6,s3,s5 	# Calculate first integer solution
		div s7,s4,s5 	# Calculate second integer solution
		
	#Print the calculated solutions.

	li a0, 4			# Load print_string syscall code to register v0 for the 1st result string
	la a1, str1 			# Load actual string to register a0
	ecall
	
	li a0 1			# Load print_int syscall code to register v0 for the 1st result string
	mv a1, s6			# Load actual integer to register a0
	ecall
	
	li a0, 4			# Load print_string syscall code to register v0 for the 1st result string
	la a1, str2			# Load actual string to register a0
	ecall
	
	li a0, 1
	mv a1, s7
	ecall
	
	li a0, 10
	ecall
	
.data
	
	str1: .asciiz "The first integer solution is: "
	
	str2: .asciiz "\nThe second integer solution is: "
