  .data
        Hello: .asciiz "======>Bem-vindo ao progama de busca sequêncial<=====\n"
	Introduction: .asciiz "*****Digite 10 valores para serem armazenados no vetor*****\n"
	number: .asciiz "Digite o "
	c_number: .asciiz "° numero\n"
	Text: .asciiz "O vetor digitado foi: \n"
	sp: .asciiz " "	
	Search: .asciiz "\nDigite um numero a ser procurado: \n"	
	Get: .asciiz "\n O número "
	Get_2: .asciiz " FOI encontrado no vetor na posição "
	Get_3: .asciiz " !!!\n"
	N_Get: .asciiz " NÃO FOI encontrado no vetor !\n"
	#.align 2
	alloc: .space 4
.text
	li $v0,4                  
	la $a0, Hello         
	syscall                  
	
	li $v0,4                 
	la $a0, Introduction     
	syscall                

	
	la $s0, alloc          

	    
        jal get_numbers
	
	
	
	li $v0,4
	la $a0, Text
	syscall
	
	jal print_vector
	

	li $v0,4
	la $a0, Search
	syscall
	
	li $v0, 5
	syscall
	move $s1, $v0
	

	
	move $a0, $s1
	jal search_number
	
	j End
  
  
get_numbers:
	li $t0, 0
	
        Loop: 
	
	sle $t1, $t0, 10
	
	bne $t1, 1, Out_get_numbers
	
	li $v0,4
	la $a0, number
	syscall
	
	addi $t2, $t0,1
	
	
	li $v0,1
	move $a0, $t2
	syscall
	
	li $v0,4
	la $a0, c_number
	syscall
	
	
	li $v0, 5
	syscall
	move $t2, $v0
	
	sll $t3, $t0,2
	add $t3, $t3, $s0
	sw $t2, 0($t3)
	
	addi $t0, $t0,1
	
	j Loop
	
  	Out_get_numbers:
  	jr $ra
  	
print_vector:
        li $t0, 0
        
	Show_arr: 
	sle $t1, $t0, 9
	
	bne $t1, 1, Out_print_vector
	
	sll $t2, $t0,2
	add $t2, $s0,$t2
	
	lw $t3, ($t2)
	
	li $v0,1  
	move $a0, $t3
	syscall 
	
        li $v0,4
	la $a0, sp
	syscall
	
	addi $t0, $t0,1
	
	j Show_arr
	
	Out_print_vector:
	jr $ra
	
search_number:
	li $t0, 0
	
	move $s1, $a0
	li $t4,0
	
	Search_in:
	
	sle $t1, $t0, 9
	
	bne $t1, 1, Test
	
	sll $t3, $t0,2
	add $t3, $s0,$t3
	lw $t2, ($t3)
	
	beq $t2, $s1, Found
	
	addi $t0, $t0,1
	
	j Search_in
	
	Test:
	beq $t1,$t4, Not_Found
	
	j Out_Search_Number
	
	Found:
	li $v0,4
	la $a0, Get
	syscall
	
	li $v0,1
	move $a0, $s1
	syscall
	
	li $v0,4
	la $a0, Get_2
	syscall
	
	addi $t0, $t0,1
	
	li $v0,1
	move $a0, $t0
	syscall
	
	li $v0,4
	la $a0, Get_3
	syscall
	
	li $t4,1
	j Search_in
	
	Not_Found:
	li $v0,4
	la $a0, Get
	syscall
	
	li $v0,1
	move $a0, $s1
	syscall
	
	li $v0,4
	la $a0, N_Get
	syscall

	j Out_Search_Number
	
	Out_Search_Number:
	jr $ra
End:
