format PE GUI 4.0
entry inicio

include 'Win32a.inc'

ventana_1	equ		1
salir_btn	equ		1000

section '.data' data readable writeable

Ist  dd 0
pWnd dd 0
hdc  dd 0 
rectangulo RECT 0,0,0,0
coord1 	POINT 150,30
coord2 	POINT 170,60
coord3 	POINT 120,60


cirx	dd 80
ciry	dd 120
cirx1 	dd 130
ciry1	dd 170
corCir1 POINT 80,120
corCir2 POINT 130,170

section '.code' code readable executable

inicio:
	invoke GetModuleHandle,0
	mov [Ist],eax
	invoke DialogBoxParam,eax,ventana_1,0,DlgProc,0 
fin:
	invoke ExitProcess,0

proc DlgProc,hWnd,uMsg,wParam,lParam
	push edi esi ebx
	
	mov eax,[uMsg]
	cmp	eax,WM_COMMAND
	je	jCOMMAND
	cmp	eax,WM_INITDIALOG
	je	jINITDIALOG
	cmp	eax,WM_CLOSE
	je	jCLOSE
	
	xor eax,eax
	jmp finish

jINITDIALOG:
	mov eax,[hWnd]
	mov [pWnd],eax
	
	mov eax,1
	jmp finish
	
jCOMMAND:
	mov eax,[wParam]
	cmp	eax,salir_btn
	je	salir
	
	cmp	eax,1001
	je	drawRec
	cmp eax,1002
	je drawCir
	cmp eax,1003
	je drawTrian
	cmp eax,1004
	je movArr
	cmp eax,1005
	je movAb
	cmp eax,1006
	je movDer
	cmp eax,1007
	je movIz
	xor eax,eax
	jmp finish
	
salir:
	invoke SendMessage,[hWnd],WM_CLOSE,0,0
	mov eax,1
	jmp finish
drawRec:
	mov [rectangulo.left],30
	mov [rectangulo.right],50
	add [rectangulo.right],50
	
	mov [rectangulo.top],50
	mov [rectangulo.bottom],50
	add [rectangulo.bottom],50
	invoke GetDC,[pWnd]
	mov [hdc],eax
	invoke CreateSolidBrush,0FFh
	invoke FillRect,[hdc],rectangulo,eax
	
	mov eax,1
	jmp finish
	
movArr:
	invoke CreateSolidBrush,000h		;tratar de limpiar 
	invoke FillRect,[hdc],rectangulo,eax
	;dibujamos de nuevo
	sub [rectangulo.bottom],20 ;SUBE 
	
	sub [rectangulo.top],20	;sube arriba pero no borra lo dibujado
	
	
	invoke GetDC,[pWnd]
	mov [hdc],eax
	
	;fig Circulo
	sub [corCir1.y],10
	sub [corCir2.y],10
	invoke Ellipse,[hdc],[corCir1.x],[corCir1.y],[corCir2.x],[corCir2.y] 

	
	;add [coord1.x],20		;crea otro triangulo
	sub [coord1.y],20
	;add [coord2.x],30
	sub [coord2.y],20
	;add [coord3.x],30
	sub [coord3.y],20
	invoke Polygon,[hdc],coord1,3
	invoke CreateSolidBrush,0BBh ;cambia el color de relleno
	invoke FillRect,[hdc],rectangulo,eax
	
	mov eax,1
	jmp finish
movAb:
	invoke CreateSolidBrush,000h		;tratar de limpiar 
	invoke FillRect,[hdc],rectangulo,eax
	;dibujamos de nuevo
	
	;add [rectangulo.bottom],20 ;SUBE 
	
	;add [rectangulo.top],20	;baja abajo 
	
	invoke GetDC,[pWnd]
	mov [hdc],eax
	;figura circulo
	add [corCir1.y],10
	add [corCir2.y],10
	invoke Ellipse,[hdc],[corCir1.x],[corCir1.y],[corCir2.x],[corCir2.y] 

	;figura de triangulo	
	add [coord1.y],20
	;add [coord2.x],30
	add [coord2.y],20
	;add [coord3.x],30
	add [coord3.y],20
	invoke Polygon,[hdc],coord1,3  ;esto lo dibuja
	
	invoke CreateSolidBrush,0BBh
	invoke FillRect,[hdc],rectangulo,eax
	
	mov eax,1
	jmp finish
movDer:
	invoke CreateSolidBrush,000h		;tratar de limpiar 
	invoke FillRect,[hdc],rectangulo,eax
	
	
	;dibujamos de nuevo
	add [rectangulo.left],20 ;a la derecha 
	
	add [rectangulo.right],20	;va a al izquierda
	invoke GetDC,[pWnd]
	mov [hdc],eax
	;figura circulo
	add [corCir1.x],10
	add [corCir2.x],10
	invoke Ellipse,[hdc],[corCir1.x],[corCir1.y],[corCir2.x],[corCir2.y] 

	;figura de triangulo	
	add [coord1.x],20
	add [coord2.x],20
	add [coord3.x],20
	invoke Polygon,[hdc],coord1,3  ;esto lo dibuja
	
	invoke CreateSolidBrush,0BBh
	invoke FillRect,[hdc],rectangulo,eax
	
	mov eax,1
	jmp finish

movIz:
	invoke CreateSolidBrush,000h		;tratar de limpiar 
	invoke FillRect,[hdc],rectangulo,eax
	;dibujamos de nuevo
	sub [rectangulo.right],20 ;a la derecha 
	
	sub [rectangulo.left],20	;sube arriba pero no borra lo dibujado
	invoke GetDC,[pWnd]
	mov [hdc],eax
	;figura circulo
	sub [corCir1.x],10
	sub [corCir2.x],10
	;stdcall CambiaColorFondo, 000h,[hdc]
	invoke Ellipse,[hdc],[corCir1.x],[corCir1.y],[corCir2.x],[corCir2.y] 
	
	;figura de triangulo
	sub [coord1.x],20
	sub [coord2.x],20
	sub [coord3.x],20
	invoke Polygon,[hdc],coord1,3  ;esto lo dibuja
	
	invoke CreateSolidBrush,0BBh
	invoke FillRect,[hdc],rectangulo,eax
	
	mov eax,1
	jmp finish

drawCir:
	invoke GetDC,[pWnd]
	mov [hdc],eax					;como mover esto
	invoke Ellipse,[hdc],[corCir1.x],[corCir1.y],[corCir2.x],[corCir2.y]  ;trato de poner nro const
	mov eax,1
	jmp finish
	
drawTrian:
	invoke GetDC,[pWnd]
	mov [hdc],eax
	
	invoke Polygon,[hdc],coord1,3
	invoke CreateSolidBrush,0BBh
	invoke FillRect,[hdc],Polygon,eax 
	;invoke    Pie,[hdc],140,85,280,50,140,75,180,75 
	;polygon  ;nro de vertices
	 ;invoke MoveToEx,[hdc],200,40
	 ;invoke LineTo,[hdc],150,90
	 ;invoke LineTo,[hdc],250,90
	 ;invoke LineTo,[hdc],200,40
	 ;invoke CreateSolidBrush,000h
	 ;invoke FillRect,[hdc]
	mov eax,1
	jmp finish	
jCLOSE:	
	invoke EndDialog,[hWnd],0
	mov eax,1

	
finish:
	pop ebx esi edi
	ret
endp

proc  CambiaColorFondo newColor, uhdc
    ;  Propósito: Modifica el color de fondo por defecto
    ;  Entrada  : newColor:DWORD, uhdc:DWORD
    ;  Salida   : Ninguna
    ;  Destruye : Ninguna
    ;LOCAL     ulb:LOGBRUSH
    
    mov       [ulb.lbStyle], BS_SOLID
    mov       eax, [newColor]
    mov       [ulb.lbColor], eax        ; BBGGRR, color
    mov       [ulb.lbHatch], NULL
    invoke    CreateBrushIndirect, ulb
    mov       [uhBrush], eax
    invoke    SelectObject,[uhdc],[uhBrush]     ; Aplicamos el color de fondo
;     mov       [hBrushOld], eax
    ret
endp
section '.idata' import data readable writeable
  ;importamos solo los procedimientos basicos para abrir una ventana
  ;library kernel, 'KERNEL32.DLL',\
	;  user,   'USER32.DLL'

  ;import  kernel,\
	;  GetModuleHandle,'GetModuleHandleA',\
	; ExitProcess,	  'ExitProcess'

 ; import  user,\
	;  DialogBoxParam, 'DialogBoxParamA',\
	;  EndDialog,	  'EndDialog',\
	;  SendMessage,	  'SendMessageA'
  ;otra forma para importar los procedimientos importando archivos INC
  library kernel32,'KERNEL32.DLL',user32,'USER32.DLL',gdi32,'GDI32.DLL'
  include 'api\kernel32.inc'
  include 'api\user32.inc'
  include 'api\gdi32.inc'

section '.rsrc' resource from 'proyectoSeg.res' data readable
