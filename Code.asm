.model small
.stack 500h
.data 
 
wc      db 0ah,0dh,'WELCOME TO TIC TAC TOE GAME$' 
line    db 0ah,0dh,'===========================$' 
pak     db 0ah,0dh,'press any key to continue...$'
r       db 0ah,0dh,'game rules:$'
r1      db 0ah,0dh, '1. players will take turns.$'
r2      db 0ah,0dh,'2. player 1 will start the game.$'
r3      db 0ah,0dh,'3. player 1 will set "x" and player 2 will set "o".$'
r4      db 0ah,0dh,'4. the board is marked with cell numbers.$'
r5      db 0ah,0dh,'5. enter cell number to place your mark.$'
r6      db 0ah,0dh,'6. set 3 of your marks horizontally, vertically or diagonally to win.$'
r7      db 'good luck!$'

pc1 db ' (x)$'
pc2 db ' (o)$'

l1 db '   |   |   $'
l2 db '-----------$'
n1 db ' | $'

c1 db '1$'
c2 db '2$'
c3 db '3$'
c4 db '4$'
c5 db '5$'
c6 db '6$'
c7 db '7$'
c8 db '8$'
c9 db '9$'

player db 50, '$'
moves db 0
done db 0
dr db 0

inp db , ':: enter cell no. : $'
tkn db 'this cell is taken! press any key...$'

cur db 88

w1 db 'player $'
w2 db ' won the game!$'
drw db 'the game is a tie!$'

tra db 'want to play again? (y/n): $'
wi db  'wrong input! press any key...   $'

emp db '                                        $'


.code
main proc
    
    mov ax, @data
    mov ds, ax
                
                
        lea dx, wc
        mov ah, 9
        int 21h  
        
        lea dx, line
        mov ah, 9
        int 21h



        lea dx, r
        mov ah, 9
        int 21h


        lea dx, r1   
        mov ah, 9
        int 21h



        lea dx, r2   
        mov ah, 9
        int 21h


        lea dx, r3   
        mov ah, 9
        int 21h


        lea dx, r4  
        mov ah, 9
        int 21h


        lea dx, r5  
        mov ah, 9
        int 21h


        lea dx, r6
        mov ah, 9
        int 21h


       lea dx, r7
       mov ah, 9
       int 21h
                   
        lea dx, line
        mov ah, 9
        int 21h
                 
        lea dx, pak
        mov ah, 9
        int 21h         
       

        mov ah, 7   
        int 21h 
        
        jmp init

       
    init: 
           
            mov player, 50     
            mov moves, 0  
            mov done, 0
            mov dr, 0 
            
            mov c1, 49
            mov c2, 50
            mov c3, 51
            mov c4, 52
            mov c5, 53
            mov c6, 54
            mov c7, 55
            mov c8, 56
            mov c9, 57
                                                  
            jmp plrchange



    victory:
    
            
            lea dx, w1
            mov ah, 9
            int 21h
            
            lea dx, player
            mov ah, 9
            int 21h
            
            lea dx, w2
            mov ah, 9
            int 21h
            
              
                mov ah, 2
                mov dh, 17
                mov dl, 28 
                int 10h 
                 
                
            lea dx, pak  
            mov ah, 9
            int 21h
            
            mov ah, 7   
            int 21h    
            
            jmp tryagain 
            
             

    draw:
            lea dx, drw
			mov ah, 9
			int 21h 
				
			 mov ah, 2
			  mov dh, 17
			  mov dl, 28 
			 int 10h
				
			lea dx, pak 
			mov ah, 9
			int 21h
			
			mov ah, 7   
			int 21h	   
			
			jmp tryagain                      




    check:   
        
        check1:  
            mov al, c1
            mov bl, c2 
            mov cl, c3
            
            cmp al, bl
            jne check2
            
            cmp bl, cl
            jne check2
            
            mov done, 1
            jmp board
            
        check2:   
            mov al, c4
            mov bl, c5 
            mov cl, c6
            
            cmp al, bl
            jne check3
            
            cmp bl, cl
            jne check3
            
          
            mov done, 1
            jmp board
            
           
       check3:  
            mov al, c7
            mov bl, c8 
            mov cl, c9
            
            cmp al, bl
            jne check4
            
            cmp bl, cl
            jne check4 
            
            mov done, 1
            jmp board
            
             
       check4:   
            mov al, c1   
            mov bl, c4 
            mov cl, c7
            
            cmp al, bl
            jne check5
            
            cmp bl, cl
            jne check5
        
            mov done, 1
            jmp board
        
       
       check5:   
            mov al, c2
            mov bl, c5 
            mov cl, c8
            
            cmp al, bl
            jne check6
            
            cmp bl, cl
            jne check6
        
            mov done, 1
            jmp board
            
       
       check6:   
            mov al, c3
            mov bl, c6 
            mov cl, c9
            
            cmp al, bl
            jne check7
            
            cmp bl, cl
            jne check7
        
            mov done, 1
            jmp board
            
        
        check7:  
            mov al, c1
            mov bl, c5 
            mov cl, c9
            
            cmp al, bl
            jne check8
            
            cmp bl, cl
            jne check8
        
            mov done, 1
            jmp board  
            
        
        check8: 
            mov al, c3
            mov bl, c5 
            mov cl, c7
            
            cmp al, bl
            jne drawcheck
            
            cmp bl, cl
            jne drawcheck
            
            mov done, 1
            jmp board  
            
            
            
    drawcheck:  
       
            mov al, moves
            cmp al, 9
            jb plrchange
            
            mov dr, 1
            jmp board
            
            jmp tryagain
       
      
    plrchange:
                         
        cmp player, 49
        je p2
        cmp player, 50
        je p1
        
        p1:
            mov player, 49
            mov cur, 88
            jmp board
             
        p2:
            mov player, 50
            mov cur, 79
            jmp board


    board: 
    
             
        mov ax,0600h 
        mov bh,07h 
        mov cx,0000h 
        mov dx,184fh 
        int 10h
    
       
        mov ah, 2
        mov bh, 0
        mov dh, 6
        mov dl, 30
        int 10h   
        
    lea dx, l1
    mov ah, 9
    int 21h 
     
        
        mov ah, 2
        mov dh, 7
        mov dl, 30 
        int 10h
    
    mov ah, 2
    mov dl, 32
    int 21h

    
    lea dx, c1
    mov ah, 9
    int 21h 
    
    lea dx, n1
    mov ah, 9
    int 21h
    
   
    
    lea dx, c2
    mov ah, 9
    int 21h
    
    lea dx, n1
    mov ah, 9
    int 21h
    
   
    
    lea dx, c3
    mov ah, 9
    int 21h
     
        mov ah, 2
        mov dh, 8
        mov dl, 30 
        int 10h 
     
    
    lea dx, l2
    mov ah, 9
    int 21h 
    

       
        mov ah, 2
        mov dh, 9
        mov dl, 30 
        int 10h
    
    lea dx, l1
    mov ah, 9
    int 21h 
    
 
        mov ah, 2
        mov dh, 10
        mov dl, 30 
        int 10h
    
    mov ah, 2
    mov dl, 32
    int 21h
    
    
    lea dx, c4
    mov ah, 9
    int 21h 
    
    lea dx, n1
    mov ah, 9
    int 21h
    
    
    
    lea dx, c5
    mov ah, 9
    int 21h
    
    lea dx, n1
    mov ah, 9
    int 21h
    
   
    
    lea dx, c6
    mov ah, 9
    int 21h
    

        mov ah, 2
        mov dh, 11
        mov dl, 30 
        int 10h
        
    lea dx, l1
    mov ah, 9
    int 21h 
 
       
        mov ah, 2
        mov dh, 12
        mov dl, 30 
        int 10h 
     
    
    lea dx, l2
    mov ah, 9
    int 21h 
    

       
        mov ah, 2
        mov dh, 13
        mov dl, 30 
        int 10h
    
    lea dx, l1
    mov ah, 9
    int 21h 
    

       
        mov ah, 2
        mov dh, 14
        mov dl, 30 
        int 10h 
    
    mov ah, 2
    mov dl, 32
    int 21h   
    
         

    
    lea dx, c7
    mov ah, 9
    int 21h 
    
    lea dx, n1
    mov ah, 9
    int 21h
    
   
    
    lea dx, c8
    mov ah, 9
    int 21h
    
    lea dx, n1
    mov ah, 9
    int 21h
    
   
    
    lea dx, c9
    mov ah, 9
    int 21h
    

        mov ah, 2
        mov dh, 15
        mov dl, 30 
        int 10h 
     
    
    lea dx, l1
    mov ah, 9
    int 21h
     
       
        mov ah, 2
        mov dh, 16
        mov dl, 20 
        int 10h
    
    
    cmp done, 1
    je victory
    
    cmp dr, 1
    je draw
     

    input:
    
    lea dx, w1
    mov ah, 9
    int 21h
    
    mov ah, 2
    mov dl, player
    int 21h
    
    cmp player, 49
    je pl1
    
        lea dx, pc2
        mov ah, 9
        int 21h
        jmp takeinput
    
    
        pl1:
            lea dx, pc1
            mov ah, 9
            int 21h 
            
            jmp takeinput 
            
    
    takeinput:  
    
    lea dx, inp
    mov ah, 9
    int 21h
    
    mov ah, 1
    int 21h 
    
   
    
    inc moves 
     
    mov bl, al 
    sub bl, 48
    
    mov cl, cur 
    
   
    cmp bl, 1
    je  c1u 
    
    cmp bl, 2
    je  c2u
    
    cmp bl, 3
    je  c3u
    
    cmp bl, 4
    je  c4u
    
    cmp bl, 5
    je  c5u
    
    cmp bl, 6
    je  c6u
    
    cmp bl, 7
    je  c7u
    
    cmp bl, 8
    je  c8u
    
    cmp bl, 9
    je  c9u  
     
    
    dec moves 
    
       
        mov ah, 2
        mov dh, 16
        mov dl, 20 
        int 10h 
        
    lea dx, wi  
    mov ah, 9
    int 21h
    
    mov ah, 7   
    int 21h
    
        
        mov ah, 2
        mov dh, 16
        mov dl, 20 
        int 10h
        
    lea dx, emp  
    mov ah, 9
    int 21h  
    
        
        mov ah, 2
        mov dh, 16
        mov dl, 20 
        int 10h
    
    jmp input
    
    
    taken:
        dec moves
             
            mov ah, 2
            mov dh, 16
            mov dl, 20 
            int 10h   
            
        lea dx, tkn   
        mov ah, 9
        int 21h  
        
        mov ah, 7     
        int 21h 
        
           
            mov ah, 2
            mov dh, 16
            mov dl, 20 
            int 10h
            
        lea dx, emp  
        mov ah, 9
        int 21h 
        
            
            mov ah, 2
            mov dh, 16
            mov dl, 20 
            int 10h
        
        jmp input
 
 
        c1u:
            cmp c1, 88 
            je taken 
            
            cmp c1, 79  
            je taken 
            
            mov c1, cl
            jmp check
             
        c2u:
            cmp c2, 88  
            je taken
            cmp c2, 79  
            je taken 
            
            mov c2, cl
            jmp check
        c3u:
            cmp c3, 88  
            je taken
            cmp c3, 79  
            je taken 
            
            mov c3, cl
            jmp check
        c4u: 
            cmp c4, 88  
            je taken
            cmp c4, 79  
            je taken 
            
            mov c4, cl
            jmp check 
        c5u: 
            cmp c5, 88  
            jz taken
            cmp c5, 79  
            jz taken 
            
            mov c5, cl
            jmp check
        c6u:
            cmp c6, 88  
            je taken
            cmp c6, 79  
            je taken 
            
            mov c6, cl
            jmp check
        c7u: 
            cmp c7, 88   
            je taken
            cmp c7, 79   
            je taken 
            
            mov c7, cl
            jmp check 
        c8u: 
            cmp c8, 88   
            je taken
            cmp c8, 79   
            je taken 
            
            mov c8, cl
            jmp check
        c9u:
            cmp c9, 88   
            je taken
            cmp c9, 79   
            je taken 
            
            mov c9, cl
            jmp check


    tryagain:
          
                        
            mov ax,0600h 
            mov bh,07h 
            mov cx,0000h 
            mov dx,184fh 
            int 10h  
            
           
            mov ah, 2
            mov bh, 0    
            mov dh, 10
            mov dl, 24
            int 10h
        
        
    
        lea dx, tra   
        mov ah, 9 
        int 21h
        
        mov ah, 1     
        int 21h
        
        cmp al, 121  
        je init 
        
        cmp al, 89  
        je init
        
       
        
        cmp al, 110  
        je exit
        cmp al, 78   
        je exit  
        
        jmp tryagain     
    

    exit: 
    
    mov ah, 4ch
    int 21h
     
    main endp
end main
