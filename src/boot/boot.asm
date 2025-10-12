global start
extern kmain

MB_MAGIC equ 0x1BADB002
MB_FLAGS equ 0x00
MB_CHECKSUM equ -(MB_MAGIC + MB_FLAGS)

section .multiboot
    dd MB_MAGIC
    dd MB_FLAGS
    dd MB_CHECKSUM

section .text
start:
    cli
    mov esp, stack_space
    call kmain
    hlt

section .bss
resb 8192
stack_space:

