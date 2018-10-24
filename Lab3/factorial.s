.data
n: .word 8

.text
main:
	la t0, n
    lw a0, 0(t0)
    jal ra, factorial
    
    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result
    
    addi a0, x0, 10
    ecall # Exit

factorial:
	# YOUR CODE HERE
	 addi x2,x2,-16 #move the pointer
	 sw   x0,8(x2) 
	 sw   x10,0(x2)
	 addi x6,x10,-1 #n-1
	 bge  x6,x0,Label1 #if n is greater than 1
	 addi x10,x0,1 
	 addi x2,x2,16 #pop
	 jalr x0,0(x1) #return val
     
    	 Label1: 
      	 addi x10,x10,-1 #n-1
	 jal  x1,factorial #factorial of next number
	 add  x5,x10,x0 #put factorial in x5
	 lw   x10,0(x2) #restore pointer
	 lw   x1,8(x2) 
	 addi x2,x2,16
	 mul  x10,x10,x5 #multiply n-1 factorial by n
	 jalr x0,0(x1) #return 


