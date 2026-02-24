.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB "ENTER HEX: $"
    MSG2 DB 10,13,"YOU ENTERED: $"
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display prompt
    MOV AH, 9
    LEA DX, MSG1
    INT 21H

    XOR BX, BX         ; Clear BX to store result
    MOV CL, 4          ; Shift count for nibbles
     
INPUT_LOOP:
    MOV AH, 1          ; Read character
    INT 21H 
    CMP AL, 13         ; Check for Enter key
    JE END_INPUT
  
    ; Convert ASCII to binary value
    CMP AL, '9'
    JLE DIGIT
    CMP AL, 'F'
    JLE UPPERCASE
    CMP AL, 'f'
    JLE LOWERCASE
    JMP INVALID

DIGIT:
    CMP AL, '0'
    JL INVALID
    SUB AL, '0'        ; Convert '0'-'9' to 0-9
    JMP STORE

UPPERCASE:
    SUB AL, 'A'-10     ; Convert 'A'-'F' to 10-15
    JMP STORE

LOWERCASE:
    SUB AL, 'a'-10     ; Convert 'a'-'f' to 10-15

STORE:
    SHL BX, CL         ; Shift left to make room
    OR BL, AL          ; Add the new nibble
    JMP INPUT_LOOP

INVALID:
    ; Handle invalid input (you could add error handling here)
    JMP INPUT_LOOP

END_INPUT:        
    ; Display result message
    MOV AH, 9
    LEA DX, MSG2
    INT 21H

    ; Display the hex digits
    MOV CX, 4          ; 4 nibbles to display
    MOV DL, BH         ; Start with high byte
    SHR DL, 1          ; Get first nibble
    SHR DL, 1
    SHR DL, 1
    SHR DL, 1

PRINT_LOOP:
    ; Convert nibble to ASCII
    CMP DL, 9
    JLE PRINT_DIGIT
    ADD DL, 'A'-10     ; Convert 10-15 to 'A'-'F'
    JMP PRINT_CHAR

PRINT_DIGIT:
    ADD DL, '0'        ; Convert 0-9 to '0'-'9'

PRINT_CHAR:
    MOV AH, 2
    INT 21H            ; Display character
    
    ; Get next nibble
    ROL BX, 1 
    ROL BX, 1
    ROL BX, 1
    ROL BX, 1         ; Rotate next nibble into position
    MOV DL, BL
    AND DL, 0FH        ; Isolate nibble
    
    LOOP PRINT_LOOP

EXIT:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN