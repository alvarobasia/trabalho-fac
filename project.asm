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
	li $v0,4                                   # Coloca no registrador $v0 o valor da instrução do sistema 4 para imprimir uma string
	la $a0, Hello                              # Carrega no registrador a frase Hello
	syscall                                    # Faz a chamada ao sistema
	
	li $v0,4                                   # Coloca no registrador $v0 o valor da instrução do sistema 4 para imprimir uma string
	la $a0, Introduction                       # Carrega no registrador a frase Introduction
	syscall                                    # Faz a chamada ao sistema

	
	la $s0, alloc                              # Coloca no registrador $s0 a base para o vetor na memoria principal

	    
        jal get_numbers                            # Vai para linha com a tag get_numbers e guarda a posição de PC couter mais 4
	
	
	
	li $v0,4                                   # Coloca no registrador $v0 o valor da instrução do sistema 4 para imprimir uma string
	la $a0, Text                               # Carrega no registrador a frase Text
	syscall                                    # Faz a chamada ao sistema
	
	jal print_vector                           # Vai para linha com a tag print_vector e guarda a posição de PC couter mais 4
	

	li $v0,4                                   # Coloca no registrador $v0 o valor da instrução do sistema 4 para imprimir uma string
	la $a0, Search                             # Carrega no registrador a frase Search
	syscall                                    # Faz a chamada ao sistema
	
	li $v0, 5                                  # Coloca no registrador $v0 o valor da instrução do sistema 5 para ler um numero inteiro
	syscall                                    # Faz a chamada ao sistema
	move $s1, $v0                              # Move o numero lido para o registrador $s1
	

	
	move $a0, $s1                              # Move o numero de $s1 para registrador $a0 para ser um argumento de função
	jal search_number                          # Vai para linha com a tag search_number e guarda a posição de PC couter mais 4
	
	j End					   # Vai para linha com a tag End
  
  
get_numbers:					   # Linha com a tag get_numbers
	li $t0, 0				   # Coloca o valor 0 em $t0
	
        Loop: 				           # Linha com a tag Loop
	
	sle $t1, $t0, 9			           # Testa de $t0 é menor ou igual a 9, se sim $t1 recebe 1, se não $t1 recebe 0
	
	bne $t1, 1, Out_get_numbers		   # Testa de $t1 é diferente de 1, se sim o fluxo continua se não vai para linha com tag Out_get_numbers
	
	li $v0,4				   # Coloca no registrador $v0 o valor da instrução do sistema 4 para imprimir uma string 
	la $a0, number			           # Carrega no registrador a frase number
	syscall					   # Faz a chamada ao sistema
	
	addi $t2, $t0,1				   # Adiciona 1 a $t0 e coloca o valor no registrador $t2
	
	
	li $v0,1				   # Coloca no registrador $v0 o valor da instrução do sistema 1 para imprimir um numero inteiro 
	move $a0, $t2				   # Move o valor de $t2 para o registrador $a0 para ser imprimido
	syscall					   # Faz a chamada ao sistema
	
	li $v0,4				   # Coloca no registrador $v0 o valor da instrução do sistema 4 para imprimir uma string 
	la $a0, c_number			   # Carrega no registrador a frase c_number
	syscall					   # Faz a chamada ao sistema
	
	
	li $v0, 5				   # Coloca no registrador $v0 o valor da instrução do sistema 5 para ler um numero inteiro
	syscall					   # Faz a chamada ao sistema
	move $t2, $v0				   # Move o numero lido para o registrador $t2
	
	sll $t3, $t0,2				   # Faz um shitf logico a esquerda de 2 bytes em $t0 e armazena no registrador $t3
	add $t3, $s0, $t3			   # Soma o valor de $t3 e $s0 e coloca no registrador $t3
	sw $t2, ($t3)				   # Armazena o valor de $t2 na memoria principal na posição do byte de $t3
	
	addi $t0, $t0,1				   # Adiciona o 1 ao valor de $t0
	
	j Loop					   # Vai para linha com a tag Loop
	
  	Out_get_numbers:		           # Linha com a tag Out_get_numbers
  	jr $ra					   # vai para a PC couter
  	
print_vector:					   # Linha com a tag print_vector
        li $t0, 0				   # Coloca o valor 0 em $t0
        
	Show_arr: 				   # Linha com a tag Loop
	sle $t1, $t0, 9				   # Testa de $t0 é menor ou igual a 9, se sim $t1 recebe 1, se não $t1 recebe 0
	
	bne $t1, 1, Out_print_vector	           # Testa de $t1 é diferente de 1, se sim o fluxo continua se não vai para linha com tag Out_print_vector
	
	sll $t2, $t0,2			           # Faz um shitf logico a esquerda de 2 bytes em $t0 e armazena no registrador $t2
	add $t2, $s0,$t2			   # Soma o valor de $t2 e $s0 e coloca no registrador $t2
	
	lw $t3, ($t2)				   # Carrega a informação no vetor com posição em $t2 e coloca em $t3
	
	li $v0,1  				   # Coloca no registrador $v0 o valor da instrução do sistema 1 para imprimir um numero inteiro 
	move $a0, $t3				   # Move o valor de $t3 para o registrador $a0 para ser imprimido
	syscall 				   # Faz a chamada ao sistema
	
        li $v0,4				   # Coloca no registrador $v0 o valor da instrução do sistema 4 para imprimir uma string 
	la $a0, sp				   # Carrega no registrador a frase sp
	syscall					   # Faz a chamada ao sistema
	
	addi $t0, $t0,1				   # Adiciona o 1 ao valor de $t0
	
	j Show_arr				   # Vai para linha com a tag Show_arr
	
	Out_print_vector:			   # Linha com a tag Out_print_vector
	jr $ra					   # vai para a PC couter
	
search_number:					   # Linha com a tag search_number
	li $t0, 0				   # Coloca o valor 0 em $t0
	
	move $s1, $a0				   # Move a valor de $a0 para $s1
	li $t4,0				   # Coloca o valor 0 em $t4
	
	Search_in:				   # Linha com a tag Search_in
	
	sle $t1, $t0, 9				   # Testa de $t0 é menor ou igual a 9, se sim $t1 recebe 1, se não $t1 recebe 0
	
	bne $t1, 1, Test			   # Testa de $t1 é diferente de 1, se sim o fluxo continua se não vai para linha com tag Test	
	
	sll $t3, $t0,2				   # Faz um shitf logico a esquerda de 2 bytes em $t0 e armazena no registrador $t3
	add $t3, $s0,$t3			   # Soma o valor de $t3 e $s0 e coloca no registrador $t3
	lw $t2, ($t3)				   # Carrega a informação no vetor com posição em $t3 e coloca em $t2
	
	beq $t2, $s1, Found			   # Testa se o valor de $t2 é igual ao de $s1 se sim vai para a linha com a tag Found
	
	addi $t0, $t0,1				   # Adiciona o 1 ao valor de $t0
	
	j Search_in				   # Vai para linha com a tag Search_in
	
	Test:					   # Linha com a tag Test
	beq $t1,$t4, Not_Found			   # Testa se o valor de $t1 é igual ao de $t4 se sim vai para a linha com a tag Not_Found
	
	j Out_Search_Number			   # Vai para linha com a tag Out_Search_Number
	
	Found:					   # Linha com a tag Found 
	li $v0,4				   # Coloca no registrador $v0 o valor da instrução do sistema 4 para imprimir uma string 
	la $a0, Get				   # Carrega no registrador a frase Get
	syscall				           # Faz a chamada ao sistema
	
	li $v0,1			           # Coloca no registrador $v0 o valor da instrução do sistema 1 para imprimir um numero inteiro 
	move $a0, $s1				   # Move o valor de $s1 para o registrador $a0 para ser imprimido
	syscall					   # Faz a chamada ao sistema
	
	li $v0,4				   # Coloca no registrador $v0 o valor da instrução do sistema 4 para imprimir uma string 
	la $a0, Get_2			           # Carrega no registrador a frase Get_2
	syscall					   # Faz a chamada ao sistema
	
	addi $t0, $t0,1				   # Adiciona o 1 ao valor de $t0
	
	li $v0,1				   # Coloca no registrador $v0 o valor da instrução do sistema 1 para imprimir um numero inteiro 
	move $a0, $t0				   # Move o valor de $t0 para o registrador $a0 para ser imprimido
	syscall					   # Faz a chamada ao sistema
	
	li $v0,4				   # Coloca no registrador $v0 o valor da instrução do sistema 4 para imprimir uma string 
	la $a0, Get_3				   # Carrega no registrador a frase Get_3
	syscall				           # Faz a chamada ao sistema
	
	li $t4,1				   # Coloca o valor 1 no registrador $t4
	j Search_in				   # Vai para linha com a tag Search_in
	
	Not_Found:				   # Linha com a tag Not_Found 
	li $v0,4				   # Coloca no registrador $v0 o valor da instrução do sistema 4 para imprimir uma string 
	la $a0, Get				   # Carrega no registrador a frase Get
	syscall					   # Faz a chamada ao sistema
	
	li $v0,1  			   	   # Coloca no registrador $v0 o valor da instrução do sistema 1 para imprimir um numero inteiro 
	move $a0, $s1				   # Move o valor de $s1 para o registrador $a0 para ser imprimido
	syscall					   # Faz a chamada ao sistema
		
	li $v0,4			           # Coloca no registrador $v0 o valor da instrução do sistema 4 para imprimir uma string 
	la $a0, N_Get				   # Carrega no registrador a frase N_Get
	syscall				   	   # Faz a chamada ao sistema
		          	
	Out_Search_Number:			   # Linha com a tag Out_Search_Number 
	jr $ra					   # vai para a PC couter
End:						   # Linha com a tag End 
	