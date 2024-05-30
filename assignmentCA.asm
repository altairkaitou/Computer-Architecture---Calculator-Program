.data
	string: .ascii "0123456789+-*/.M^!()"
	string1: .asciiz "\nPlease insert your expression: "
	string2: .asciiz "Result: "
	string3: .asciiz "quit\n"
	string4: .asciiz "You inserted an invalid character in your expression\n"
	newline: .asciiz "\n"
	input_buffer: .space 100
	output_buffer: .space 100
	filename: .asciiz "C:\\Users\\Bao\\Downloads\\CA_Project\\calc_log.txt"
.text
	j Input
	li $s1,0 
Input:
	addi $s7, $s1, 0   #Luu vao s7
	li $s1,0 
	li $v0,4
	la $a0, string1
	syscall
	
	li $s4,0
	li $s5,0 #(
	li $s6,0 #)
	
	la $a0, input_buffer
	li $a1, 100
	li $v0,8
	syscall
	
	la $t0, string
	la $t1, input_buffer
	jal Check
	la $t0, string
	la $t1, input_buffer
	
	jal CheckValidString
	
	j Input
	

Evaluate:
	bne $s5,$s6, Invalid
	la $t1, input_buffer
	li $t3,0
	li $t4,10
	li $s0,10
	j Evaluatex
	

Evaluatex:
	lb $t2,0($t1)
	addi $t1,$t1,1
	beq $t2, 40, Parenthese
	beq $t2, 41, Parenthese
	beq $t2, 77, OperandFirstX
	blt $t2,48, Loop
	beq $t2,94,Loop
	
	
	sub $t2, $t2, 48
	mult $t3,$t4
	mflo $t3
	add $t3,$t3,$t2
	
	j Evaluatex
	
	
OperandFirstX:
	move $s1, $s7
	lb $t2,0($t1)
	beq $t2, 10,Show
	addi $t1,$t1,1
	add $s3,$t2,$0
	
	j Evaluatex 
Loop:
	beq $s1,0,OperandFirst
	beq $s3,43,Add
	beq $s3,45,Sub
	beq $s3,42,Mul
	beq $s3,47,Div
	beq $s3,94,Exp
	beq $s3,33,Factorial
	j Evaluatex
OperandFirst:
	add $s1,$s1,$t3
	li $t3,0
	add $s3,$t2,$0
	beq $t2, 10,Show
	li $t4,10
	j Evaluatex
ShowX:
	li $v0,2
	mov.s $f12,$f0
	syscall
	
	j Input
	
Show:
	beq $s1, 0, ShowX
	li $v0,4
	la $a0,string2
	syscall
	
	li $v0,1
	addi $a0,$s1,0
	syscall
	
	li $v0,4
	la $a0,newline
	syscall
	
	j Input
Add:
	add $s1,$s1,$t3
	jal jump
	beq $t2, 10,Show
	li $t4,10
	li $t3,0
	jal ChDongNgoac
	j Evaluatex
Evaluatexx:
	lb $t2,0($t1)
	addi $t1,$t1,1
	beq $t2,77, OperandFirstX
	blt $t2,48, Loop
	
	
	sub $t2, $t2, 48
	mult $t3,$t4
	mflo $t3
	add $t3,$t3,$t2
	mult $t4,$s0
	mflo $t4
	
	j Evaluatex

Sub:
	sub $s1,$s1,$t3
	jal jump
	beq $t2, 10,Show
	li $t4,10
	li $t3,0
	jal ChDongNgoac
	j Evaluatex
Mul:
	mult $s1,$t3
	mflo $s1
	jal jump
	beq $t2, 10,Show
	li $t4,10
	li $t3,0
	jal ChDongNgoac
	j Evaluatex
Div:
	mtc1 $s1, $f1
	li $s1,0
	mtc1 $t3, $f2
	div.s $f0,$f1,$f2
	jal jump
	beq $t2, 10,Show
	li $t4,10
	li $t3,0
	jal ChDongNgoac
	j Evaluatex
	
#Luy Thua
Exp:
	move $s2,$s1

	j Loop_Exp
Loop_Exp:
	beq $t3,1,Show
	
	mult $s1,$s2
	mflo $s1
	
	addi $t3,$t3,-1
	
	j Loop_Exp
	
	
#Giai Thua
Factorial:
	move $s2,$s1
	addi $s2, $s2, -1
	move $s3,$t2
	j Loop_Factorial
Loop_Factorial:
	beq $s2,1,Show
	
	mult $s1,$s2
	mflo $s1
	addi $s2, $s2, -1
	move $s3,$t2
	j Loop_Factorial
Parenthese:
	beq $t2, 41, MoveCacu
	bne $s4,0,CaculateParenthese
	bne $s1, 0, Parenthesex
	j Evaluatexx
	
MoveCacu:
	beq $s3,43,Add
	beq $s3,45,Sub
	beq $s3,42,Mul
	beq $s3,47,Div
	
Parenthesex:
	move $s4,$s1
	move $t6,$s3
	
	li $s1,0
	
	j Evaluatexx
CaculateParenthese:
	beq $t6,43,AddPar
	beq $t6,45,SubPar
	beq $t6,42,MulPar
	beq $t6,47,DivPar
SubPar:
	sub $s1,$s1,$s4
	j Show
MulPar:
	mult $s1,$s4
	mflo $s1
	j Show	
DivPar:
	mtc1 $s4, $f1
	mtc1 $s1, $f2
	div.s $f0,$f1,$f2
	
	li $s1,0
	
	j Show
AddPar:
	add $s1,$s1,$s4
	j Show


Check:	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	lb $t2, string3
	lb $t3, input_buffer
	beq $t2, $t3, Checkx
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	jr $ra
Checkx:		
	lb $t2, string3 + 1
	lb $t3, input_buffer + 1
	beq $t2, $t3, Checkxx
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	jr $ra
Checkxx:	
	lb $t2, string3 + 2
	lb $t3, input_buffer + 2
	beq $t2, $t3, Checkxxx
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	jr $ra
Checkxxx:		
	lb $t2, string3 + 3
	lb $t3, input_buffer + 3
	beq $t2, $t3, Checkxxxx
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	jr $ra
Checkxxxx:	
	lb $t2, string3 + 4
	lb $t3, input_buffer + 4
	beq $t2, $t3, exit
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	jr $ra
	
CheckValidString:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
    	lb $t2, 0($t1)
    	lb $t7, 1($t1)
    	
    	jal CheckMoNgoac
    	jal CheckDongNgoac
    	jal CheckDau
    	
    	addi $t1,$t1,1
    	beq $t2, 10,Evaluate
    	
    	la $t0, string
    	jal Compare

    	lw $ra, ($sp)
	addiu $sp, $sp, 4
    	
    	bnez $t2, CheckValidString
    	
    	jr $ra
CheckMoNgoac:
	beq $t2,40, CountMoNgoac
	jr $ra
CountMoNgoac:
	addi $s5,$s5,1
	jr $ra
CheckDongNgoac:
	beq $t2,41, CountDongNgoac
	jr $ra
CountDongNgoac:
	addi $s6,$s6,1
	beq $s5,0,Invalid
	jr $ra
CheckDau:
	beq $t2,43,CheckDau2
	beq $t2,45,CheckDau2
	beq $t2,42,CheckDau2
	beq $t2,47,CheckDau2
	beq $t2,94,CheckDau2
	beq $t2,33,CheckDau2
	
	jr $ra
CheckDau2:
	beq $t7,43,Invalid
	beq $t7,45,Invalid
	beq $t7,42,Invalid
	beq $t7,47,Invalid
	beq $t7,94,Invalid
	beq $t7,33,Invalid
	
	jr $ra
Compare:
	lb $t3, 0($t0)
	beqz $t3, Invalid
	addi $t0,$t0,1
	
	bne $t2, $t3, Compare
	
	jr $ra
Invalid:
	li $v0,4
	la $a0,string4
	syscall
	
	j Input
ChDongNgoac:
	beq $t2, 41, ChDongNgoacx
	move $s3,$t2
	jr $ra
ChDongNgoacx:
	lb $t2,0($t1)
	move $s3,$t2
	addi $t1,$t1,1
	j Evaluatex
jump:
	beq $t2,41, jumpx
	
	jr $ra
jumpx:
	bne $s4, 0, jumpxx
	
	jr $ra
jumpxx:
	beq $t2, 41,CaculateParenthese
exit:
    	li $v0, 10 
    	syscall

