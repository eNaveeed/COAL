.model small
.stack 100h
.data
msg1 db "Enter a letter: $"
msg2 db 10,13,"$"
.code
main proc
mov ax, @data
mov ds, ax

INPUT:
mov ah, 9
lea dx, msg1
int 21h

mov ah,1
int 21h
mov bl, al

cmp bl,97
JGE Exit

Print:
mov ah, 9
lea dx, msg2
int 21h

mov ah,2
mov dl, bl
int 21h

mov ah, 9
lea dx, msg2
int 21h
JMP INPUT

Exit:                                                                                                                       mov ah,4ch
int 21h
MAIN ENDP
END MAIN



