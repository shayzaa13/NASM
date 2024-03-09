section .data
    promptstr db 'enter string: ', 0xa
    lenstr equ $ - promptstr
    promptchar db 'enter xor character: ', 0xa
    lenchar equ $ - promptchar
    promptres db 'result: ', 0xa
    lenres equ $ - promptres

section .bss
    string resb 50
    key resb 1
    temp resb 1

section .text
    global _start

_start:
    ; prompting for  string
    mov eax, 4             
    mov ebx, 1 
    mov ecx, promptstr
    mov edx, lenstr
    int 0x80

    ; reading the input string
    mov eax, 3  
    mov ebx, 0
    mov ecx, string       
    mov edx, 50     
    int 0x80

    ; prompting for key character
    mov eax, 4           
    mov ebx, 1         
    mov ecx, promptchar     
    mov edx, lenchar       
    int 0x80

    ; reading the key character
    mov eax, 3             
    mov ebx, 0           
    mov ecx, key            
    mov edx, 1         
    int 0x80

;   printing resukt pretext
    mov eax, 4      
    mov ebx, 1    
    mov ecx, promptres 
    mov edx, lenres      
    int 0x80   

    ; encryption loop
    mov esi, string

    xor_loop:
        mov edx, 0
        mov dl, byte [esi]   
        xor dl, byte [key]

        mov [ecx], edx
        
        mov eax, 4      
        mov ebx, 1    
        mov edx, 1       
        int 0x80

        inc esi           
        cmp byte [esi], 0  

    jnz xor_loop       

    ; adding a newline at the end
    mov eax, 4            
    mov ebx, 1        
    mov ecx, 0xa  
    mov edx, 1         
    int 0x80

    ; exit
    mov eax, 1     
    mov ebx, 0       
    int 0x80