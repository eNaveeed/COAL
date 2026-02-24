.model small
.stack 100h
.data
msg1 db "Enter three initials: $"
msg2 db 10,13,"$"
.code
main proc
mov ax, @data
mov ds, ax

mov ah, 9
lea dx,msg1
int 21h

mov ah,1
int 21h

mov bl, al

mov ah, 1
int 21h

mov cl, al

mov ah, 1
int 21h

mov ch, al

mov ah, 9
lea dx, msg2
int 21h

mov ah,2
mov dl, bl
int 21h

mov ah,9
lea dx, msg2
int 21h

mov ah,2
mov dl, cl
int 21h

mov ah,9
lea dx, msg2
int 21h

mov ah,2
mov dl, ch
int 21h

mov ah,4ch
int 21h

main endp
end main
