.MODEL  SMALL
.STACK  100H
.DATA
MSG1 DB  "ENTER NUMBER: $"
MSG2 DB  10,13,"IT IS EVEN POSITIVE $"
MSG3 DB  10,13,"IT IS EVEN  NEGATIVE $"
MSG4 DB  10,13,"IT IS ODD POSTIVE $"
MSG5 DB  10,13,"IT IS ODD NEGATIVE $"
.CODE
MAIN PROC
MOV AX, @DATA
MOV DS, AX
        
MOV AH, 9
LEA DX, MSG1
INT 21H
        
MOV AH, 1
INT 21H
MOV BL, AL
        
SHR BL, 1
JC  ODD_
JMP EVEN_

EVEN_:
SHL BX, 1
JC  ENEG
JMP EPOS
            
  EPOS:
  MOV AH, 9
  LEA DX, MSG2
  INT 21H
  JMP EXIT
            
  ENEG:
  MOV AH, 9
  LEA DX, MSG3
  INT 21H
  JMP EXIT
            
ODD_:
SHL  BX, 1
JC   ONEG
JMP  OPOS  
           
  OPOS:
  MOV AH, 9
  LEA DX, MSG4
  INT 21H 
  JMP EXIT
            
  ONEG: 
  MOV AH, 9
  LEA DX, MSG5
  INT 21H
  JMP EXIT    
            
EXIT:
MOV AH, 4CH
INT 21H
            
MAIN ENDP
END MAIN

