include console.inc

COMMENT *
   Ввод целого числа и вывод суммы его цифр
*

.data
   X   dd  ?
   Sum db ?; Сумма цифр

MaxLongint equ 80000000h

.code
lea eax,[eax+00h]
   mov esi,0FFFF0000h
   outnumln esi,,b
   add si,1
   outnumln esi,,b
   newline
   mov eax,0FFFF0000h
   outnumln eax,,b
   mov ax,2
   outnumln eax,,b
exit
   mov eax,es:X
   mov eax,cs:X
   mov eax,ss:X
   db  26h,36h,2Eh
   mov eax,X
Start:
   GotoXY 10,10
   Pause    'Начнём, пожалуй...'
   ConsoleTitle "   Ввод целого числа, вывод суммы его цифр"

Begin:
   clrscr
   newline 2
   mov   Sum,0
   outstr 'Введите целое X='
   inintln X
OutFlags
   jnc   @L
   cmp   X,0
   jne   @F
   outstrln 'Плохая лексема числа !'
   jmp   Next
@@:
   outstrln 'Слишком большое число!'
   jmp   Next
@L:jnz   @F
   pushfd
   outstrln 'Введено число меньше нуля! ZF=1'
   popfd
@@:jns   @F
   outstrln 'Плохой конец лексемы целого числа!'
@@:mov   ebx,10
   mov   eax,X
L: cdq
   idiv  ebx
L1:neg   edx
   js    L1; edx:=abs(edx)
   add   Sum,dl; Sum:=Sum+цифра
   cmp   eax,0
   jne   L
   outwordln Sum,,"Сумма цифр="

Next:
   MsgBox "Конец программы",                            \
          <"Желаете ещё раз?",13,10,"Или НЕ желаете?">, \
          MB_YESNO+MB_ICONQUESTION
   cmp   eax,IDYES
   je    Begin

   exit
   end Start