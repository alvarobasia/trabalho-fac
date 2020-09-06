 .data
	alloc: .space 40
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
.text
	li $v0,4                  
	la $a0, Hello         
	syscall                  
	
	li $v0,4                 
	la $a0, Introduction     
	syscall                

	
	la $t2, alloc          
	li $t1, 0
	    
        jal get_numbers
	
	li $t1, 0
	la $t2, alloc 
	
	
	li $v0,4
	la $a0, Text
	syscall
	
	jal print_vector
	

	li $v0,4
	la $a0, Search
	syscall
	
	li $v0, 5
	syscall
	move $s7, $v0
	
	li $t1, 0
	la $t2, alloc 
	
	move $a0, $s7
	jal search_number
	
	j End
  
  
get_numbers:
        Loop: 
	
	sle $t0, $t1, 9
	
	bne $t0, 1, Out_get_numbers
	
	li $v0,4
	la $a0, number
	syscall
	
	addi $t4, $t1,1
	
	
	li $v0,1
	move $a0, $t4
	syscall
	
	li $v0,4
	la $a0, c_number
	syscall
	
	
	li $v0, 5
	syscall
	move $s7, $v0
	
	sll $s5, $t1,2
	add $s5,$t2,$s5
	
	sw $s7, ($s5)
	
	addi $t1, $t1,1
	
	j Loop
	
  	Out_get_numbers:
  	jr $ra
  	
print_vector:
	Show_arr: 
	sle $t0, $t1, 9
	
	bne $t0, 1, Out_print_vector
	
	sll $s5, $t1,2
	add $s5,$t2,$s5
	
	lw $s3, ($s5)
	
	li $v0,1  
	move $a0, $s3
	syscall 
	
        li $v0,4
	la $a0, sp
	syscall
	
	addi $t1, $t1,1
	j Show_arr
	Out_print_vector:
	jr $ra
	
search_number:
	move $s7, $a0
	li $t8,0
	Search_in:
	sle $t0, $t1, 9
	bne $t0, 1, Test
	sll $s5, $t1,2
	add $s5,$t2,$s5
	lw $s3, ($s5)
	beq $s3, $s7, Found
	addi $t1, $t1,1
	j Search_in
	Test:
	beq $t0,$t8, Not_Found
	j Out_Search_Number
	Found:
	
	li $v0,4
	la $a0, Get
	syscall
	li $v0,1
	move $a0, $s7
	syscall
	li $v0,4
	la $a0, Get_2
	syscall
	addi $t1, $t1,1
	li $v0,1
	move $a0, $t1
	syscall
	li $v0,4
	la $a0, Get_3
	syscall
	li $t8,1
	J Search_in
	
	Not_Found:
	
	li $v0,4
	la $a0, Get
	syscall
	li $v0,1
	move $a0, $s7
	syscall
	li $v0,4
	la $a0, N_Get
	syscall

	J Out_Search_Number
	
	Out_Search_Number:
	jr $ra
End:
