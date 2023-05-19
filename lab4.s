

.section .data

newline:
.ascii "\n\0"

.section .text
.globl _start
_start:

movq %rsp, %rbp




movq 8(%rbp), %rdi

movq $1, %rsi
arg_loop:

    incq %rsi

    movq (%rbp, %rsi, 8), %rdi

    cmpq $0, %rdi

    je env_loop

    pushq %rsi
    pushq %rdi

    popq %rdi

    popq %rsi

    jmp arg_loop

env_loop:

    incq %rsi

    movq (%rbp, %rsi, 8), %rdi

    cmpq $0, %rdi

    je quit_program


    pushq %rsi
    pushq %rdi

    popq %rdi
    call print_string
    movq $newline, %rdi
    call print_string

    popq %rsi

    jmp env_loop

quit_program:
    movq $60, %rax
    movq $0, %rdi
    syscall

.type strlen, @function
strlen:
    pushq %rbp
    movq %rsp, %rbp


    movq $0, %rax


    movq $0, %rcx


    movb (%rdi), %cl

    cmpb $0, %cl
    je end_strlen

strlen_loop:

    incq %rax


    incq %rdi


    movb (%rdi), %cl


    cmpb $0, %cl


    je end_strlen


    jmp strlen_loop

end_strlen:
    leave
    ret

.type print_string, @ function
print_string:
    pushq %rbp
    movq %rsp, %rbp


    pushq %rdi


    call strlen


    movq %rax, %rdx


    popq %rsi

    movq $1, %rax
    movq $1, %rdi




    movq $0, %rax

    leave
    ret
    
