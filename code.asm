include 'emu8086.inc'    

org 100h

jmp start

msg1            DB  'Enter the amount of money: $'
msg2            DB  'the led is***************: $' 
red             DB  'red$' 
newline         DB  0DH,0AH,'$'   

start: 
LEA    dx,newline  
MOV    ah,09h   
INT    21h 

mov    bx,0 
mov    cx,10h
LEA    dx,msg1  
MOV    ah,09h   
INT    21h

mov    ah, 1
int    21h   
call   parse
mov    ah,0
mov    bx,ax

mov    ah, 1
int    21h   
call   parse
mov    ah,0
mov    dx,ax
mov    ax , bx 
mov    bx , dx
mul    cx
add    bx , ax
               
          

LEA    dx,newline  
MOV    ah,09h   
INT    21h  

mov    dx , 0

cmp   bx , 1h
je    fiv
cmp   bx,  5h
je    half

mov     cx, 393h    ;    004C4B40h = 5,000,000
mov     dx, 8700h
mov     ah, 86h
int     15h    

LEA    dx,newline  
MOV    ah,09h   
INT    21h  

LEA    dx,msg2  
MOV    ah,09h   
INT    21h

LEA    dx,red  
MOV    ah,09h   
INT    21h

jmp     ot
fiv:
mov     cx, 4Ch    ;    004C4B40h = 5,000,000
mov     dx, 4B40h
mov     ah, 86h
int     15h

LEA    dx,newline  
MOV    ah,09h   
INT    21h  

LEA    dx,msg2  
MOV    ah,09h   
INT    21h

LEA    dx,red  
MOV    ah,09h   
INT    21h
 
jmp     ot

half:
mov     cx, 1C9h    ;    004C4B40h = 5,000,000
mov     dx, 0C380h
mov     ah, 86h
int     15h

LEA    dx,newline  
MOV    ah,09h   
INT    21h  

LEA    dx,msg2  
MOV    ah,09h   
INT    21h

LEA    dx,red 
MOV    ah,09h   
INT    21h

jmp     ot
ot:
jmp     start
parse proc near:
cmp    al,48
je     zero
cmp    al,49
je     one
cmp    al,50
je     two
cmp    al,51
je     three
cmp    al,52
je     four
cmp    al,53
je     five
cmp    al,54
je     six
cmp    al,55
je     seven
cmp    al,56
je     eight
cmp    al,57
je     nine

zero: 
mov   al,0h
jmp     out
one: 
mov   al,1h
jmp     out
two: 
mov   al,2h
jmp     out
three: 
mov   al,3h
jmp     out
four: 
mov   al,4h
jmp     out
five: 
mov   al,5h
jmp     out
six: 
mov   al,6h
jmp     out 
seven: 
mov   al,7h
jmp     out
eight: 
mov   al,8h
jmp     out
nine: 
mov   al,9h
jmp     out

out: 
ret
parse endp
DEFINE_GET_STRING 
ret
