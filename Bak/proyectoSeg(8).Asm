format PE GUI 4.0
entry inicio

include 'Win32a.inc'

ventana_1	equ		1
ventana_2   equ		2
salir_btn	equ		1000
IDC_TAB1	equ		1008
cdXPos      EQU  128         ; Constante double X-Posici�n de la ventana(esq sup izqda)
cdYPos      EQU  128         ; Constante double Y-Posici�n de la ventana(esq sup izqda)
cdXSize     EQU  320         ; Constante double X-tama�o de la ventana
cdYSize     EQU  200         ; Constante double Y-tama�o de la ventana
cdColFondo	EQU  COLOR_BTNFACE+1
cdVIcono	EQU	 IDI_APPLICATION
cdVCursor   EQU  IDC_ARROW

cdVBarTipo  EQU  NULL              ; Normal, con icono
cdVBtnTipo  EQU  WS_VISIBLE+WS_DLGFRAME+WS_SYSMENU    ; Normal s�lo con bot�n cerrar
; cdVBtnTipo     EQU  WS_OVERLAPPEDWINDOW                ; Normal s�lo con los tres botones
; Constantes para la subventana del texto
cdVCarText  EQU  WS_CHILD + WS_VISIBLE + SS_CENTER

section '.data' data readable writeable

Ist  dd 0
pWnd dd 0
hdc  dd 0 
cdPosx  dd 100
cdPosy	dd 100
cdSix	dd 600
cdSi	dd 500
NombreClase db 'EXP01',0
msgCabecera db 'Titulo de ventana',0
MsgError	TCHAR	'carga inicial fallida.',0
wMsg	MSG
wc      WNDCLASS 0,WndProc,0,0,NULL,NULL,NULL,cdColFondo,NULL,NombreClase
ps		PAINTSTRUCT
CommandLine DD ?
rectangulo RECT 0,0,0,0
rectan2    RECT 0,0,0,0
coord1 	POINT 150,30
coord2 	POINT 170,60
coord3 	POINT 120,60
brocha LOGBRUSH 
ulb    LOGBRUSH 
uhBrush  dd 1
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
	;circulo
	cmp eax,1009
	je mArrC
	cmp eax,1008
	je mAbaC
	cmp eax,1010
	je mIzqC
	cmp eax,1011
	je mDerC
	;triangulo
	cmp eax,1012
	je mArrT
	cmp eax,1013
	je mIzqT
	cmp eax,1014
	je mDerT
	cmp eax,1015
	je mAbaT
	cmp eax,1016
	je fond1
	cmp eax,1017
	je fond2
	cmp eax,1018
	je fond3
	cmp eax,1019
	je col1
	cmp eax,1020
	je col2
	cmp eax,1021
	je col3
	cmp eax,1022
	je diaArD
	cmp eax,1023
	je diaAbD
	cmp eax,1024
	je diaAriz
	cmp eax,1025
	je diaAbiz
	xor eax,eax
	jmp finish
	
salir:
	invoke SendMessage,[hWnd],WM_CLOSE,0,0
	mov eax,1
	jmp finish
drawRec:
	;trate de crear una nueva ventana
	;invoke GetModuleHandle,0   ;como creo obtengo el controlador para crear nueva ventana
	;mov [wc.hInstance],eax
	;mov [wc.lpfnWndProc],WndProc
	;mov [wc.hbrBackground],COLOR_BTNFACE+1
	;invoke GetCommandLine
	;mov [CommandLine],EAX
	;stdcall WinMain,[wc.hInstance],NULL,NULL, SW_SHOWNORMAL ;me lleva al error 
	;invoke ExitProcess,[wMsg.wParam]   ;esto se supone que sale del programa
	;;////////////////////
	mov [rectangulo.left],30
	mov [rectangulo.right],50
	add [rectangulo.right],50
	
	mov [rectangulo.top],50
	mov [rectangulo.bottom],50
	add [rectangulo.bottom],50
	
	mov [rectan2.right],650
	;add [rectan2.top],200
	mov [rectan2.bottom],290
	invoke GetDC,[pWnd]
	mov [hdc],eax
	invoke CreateSolidBrush,000h
	invoke FillRect,[hdc],rectan2,eax
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
	;cambiar color de fondo
	stdcall CambiaColorFondo, 000h,[hdc] ;cambia la brocha a color negro
	
	invoke CreateSolidBrush,0FFh ;cambia el color de relleno
	invoke FillRect,[hdc],rectangulo,eax
	
	mov eax,1
	jmp finish
diaArD:
	invoke CreateSolidBrush,000h		;tratar de limpiar 
	invoke FillRect,[hdc],rectangulo,eax
	;dibujamos de nuevo
	sub [rectangulo.bottom],20 ;SUBE 
	add [rectangulo.right],20 ;va a la derecha 
	add [rectangulo.left],20
	sub [rectangulo.top],20	;sube arriba pero no borra lo dibujado
	
	invoke GetDC,[pWnd]
	mov [hdc],eax
	;cambiar color de fondo
	stdcall CambiaColorFondo, 000h,[hdc] ;cambia la brocha a color negro
	
	invoke CreateSolidBrush,0FFh ;cambia el color de relleno
	invoke FillRect,[hdc],rectangulo,eax
	
	mov eax,1
	jmp finish
	
diaAbD:
	invoke CreateSolidBrush,000h		;tratar de limpiar 
	invoke FillRect,[hdc],rectangulo,eax
	;dibujamos de nuevo
	add [rectangulo.bottom],20 ;SUBE 
	add [rectangulo.right],20 ;va a la derecha 
	add [rectangulo.left],20
	add [rectangulo.top],20	;sube arriba pero no borra lo dibujado
	
	invoke GetDC,[pWnd]
	mov [hdc],eax
	;cambiar color de fondo
	stdcall CambiaColorFondo, 000h,[hdc] ;cambia la brocha a color negro
	
	invoke CreateSolidBrush,0FFh ;cambia el color de relleno
	invoke FillRect,[hdc],rectangulo,eax
	
	mov eax,1
	jmp finish
	
diaAriz:
diaAbiz:
	
movAb:
	invoke CreateSolidBrush,000h		;tratar de limpiar 
	invoke FillRect,[hdc],rectangulo,eax
	;dibujamos de nuevo
	add [rectangulo.bottom],10 ;baja 
	add [rectangulo.top],10	;baja abajo 
	
	invoke GetDC,[pWnd]
	mov [hdc],eax
	;cambiar color de fondo
	
	
	invoke CreateSolidBrush,0FFh
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

	invoke CreateSolidBrush,0FFh
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
	
	;sub [corCir1.x],10
	;sub [corCir2.x],10
	;stdcall CambiaColorFondo, 000h,[hdc]
	;invoke Ellipse,[hdc],[corCir1.x],[corCir1.y],[corCir2.x],[corCir2.y] 
	
	
	invoke CreateSolidBrush,0FFh
	invoke FillRect,[hdc],rectangulo,eax
	
	mov eax,1
	jmp finish

;movimiento Circulo
mArrC:
	stdcall CambiaColorFondo, 000h,[hdc] ;cambia la brocha a color negro
	invoke Ellipse,[hdc],[corCir1.x],[corCir1.y],[corCir2.x],[corCir2.y] ;sobreescribimos ante
	
	invoke GetDC,[pWnd]
	mov [hdc],eax
	stdcall CambiaColorFondo, 0ffh,[hdc] ;cambia la brocha a color negro
		;fig Circulo
	sub [corCir1.y],10
	sub [corCir2.y],10
	invoke Ellipse,[hdc],[corCir1.x],[corCir1.y],[corCir2.x],[corCir2.y] 
	
	mov eax,1
	jmp finish
mAbaC:
	stdcall CambiaColorFondo, 000h,[hdc] ;cambia la brocha a color negro
	invoke Ellipse,[hdc],[corCir1.x],[corCir1.y],[corCir2.x],[corCir2.y] ;sobreescribimos ante
	invoke GetDC,[pWnd]
	mov [hdc],eax
		;cambiar color de fondo
	stdcall CambiaColorFondo, 0ffh,[hdc]
	;figura circulo
	add [corCir1.y],10
	add [corCir2.y],10
	invoke Ellipse,[hdc],[corCir1.x],[corCir1.y],[corCir2.x],[corCir2.y] 

	mov eax,1
	jmp finish
mIzqC:
	stdcall CambiaColorFondo, 000h,[hdc] ;cambia la brocha a color negro
	invoke Ellipse,[hdc],[corCir1.x],[corCir1.y],[corCir2.x],[corCir2.y] ;sobreescribimos ante
	
	invoke GetDC,[pWnd]
	mov [hdc],eax
	;figura circulo
	sub [corCir1.x],10
	sub [corCir2.x],10
	stdcall CambiaColorFondo, 0ffh,[hdc]
	invoke Ellipse,[hdc],[corCir1.x],[corCir1.y],[corCir2.x],[corCir2.y] 
	
	mov eax,1
	jmp finish
mDerC:
	stdcall CambiaColorFondo, 000h,[hdc] ;cambia la brocha a color negro
	invoke Ellipse,[hdc],[corCir1.x],[corCir1.y],[corCir2.x],[corCir2.y] ;sobreescribimos ante	
	invoke GetDC,[pWnd]
	mov [hdc],eax
		;cambiar color de fondo
	stdcall CambiaColorFondo, 0ffh,[hdc] ;en aqui lo cambio a rojo para mas bonito
	;figura circulo
	add [corCir1.x],10
	add [corCir2.x],10
	invoke Ellipse,[hdc],[corCir1.x],[corCir1.y],[corCir2.x],[corCir2.y] 
	mov eax,1
	jmp finish
;movimiento triangulo
mArrT:
	stdcall CambiaColorFondo, 000h,[hdc] ;cambia la brocha a color negro
	invoke Polygon,[hdc],coord1,3
	
	invoke GetDC,[pWnd]
	mov [hdc],eax
	;add [coord1.x],20		;crea otro triangulo
	sub [coord1.y],20
	sub [coord2.y],20
	;add [coord3.x],30
	sub [coord3.y],20
	invoke Polygon,[hdc],coord1,3
	mov eax,1
	jmp finish
mAbaT:
	stdcall CambiaColorFondo, 000h,[hdc] ;cambia la brocha a color negro
	invoke Polygon,[hdc],coord1,3
	
	invoke GetDC,[pWnd]
	mov [hdc],eax
	;figura de triangulo	
	add [coord1.y],20
	add [coord2.y],20
	add [coord3.y],20
	invoke Polygon,[hdc],coord1,3  ;esto lo dibuja
	mov eax,1
	jmp finish
mIzqT:
	stdcall CambiaColorFondo, 000h,[hdc] ;cambia la brocha a color negro
	invoke Polygon,[hdc],coord1,3
	
	invoke GetDC,[pWnd]
	mov [hdc],eax
	;figura de triangulo
	sub [coord1.x],20
	sub [coord2.x],20
	sub [coord3.x],20
	invoke Polygon,[hdc],coord1,3  ;esto lo dibuja
	mov eax,1
	jmp finish
mDerT:
	stdcall CambiaColorFondo, 000h,[hdc] ;cambia la brocha a color negro
	invoke Polygon,[hdc],coord1,3
	
	invoke GetDC,[pWnd]
	mov [hdc],eax
	;figura de triangulo	
	add [coord1.x],20
	add [coord2.x],20
	add [coord3.x],20
	invoke Polygon,[hdc],coord1,3  ;esto lo dibuja
	mov eax,1
	jmp finish

drawCir:
	;invoke DialogBoxParam,eax,ventana_2,0,DlgProc,0  ;esto deberia crear ventana
	invoke GetDC,[pWnd]
	mov [hdc],eax	
	
	mov [rectan2.right],650
	mov [rectan2.bottom],290
	
	invoke CreateSolidBrush,000h
	invoke FillRect,[hdc],rectan2,eax
					
	stdcall CambiaColorFondo, 0ffh,[hdc] ;cambia la brocha a color negro
	
	invoke Ellipse,[hdc],[corCir1.x],[corCir1.y],[corCir2.x],[corCir2.y]  ;trato de poner nro const
	
	mov eax,1
	jmp finish
	
drawTrian:
	invoke GetDC,[pWnd]
	mov [hdc],eax
	
	mov [rectan2.right],650
	mov [rectan2.bottom],290
	
	invoke CreateSolidBrush,000h
	invoke FillRect,[hdc],rectan2,eax
	
	;stdcall CambiaColorFondo, 0ffh,[hdc]
	invoke Polygon,[hdc],coord1,3
	invoke CreateSolidBrush,0ffh
	invoke    CreateBrushIndirect, brocha
	mov 	[brocha.lbStyle],eax
	invoke FillRgn,[hdc],coord1,ulb
	
	
	;invoke SetPolyFillMode,[hdc],ALTERNATE
	;invoke CreateSolidBrush,0BBh
	;invoke FillRect,[hdc],Polygon,eax 
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
	
fond1:
	invoke GetDC,[pWnd]
	mov [hdc],eax
	mov [rectan2.right],650
	mov [rectan2.bottom],290
	
	invoke CreateSolidBrush,010h
	invoke FillRect,[hdc],rectan2,eax
	
	mov eax,1
	jmp finish	
fond2:
	invoke GetDC,[pWnd]
	mov [hdc],eax
	mov [rectan2.right],650
	mov [rectan2.bottom],290
	
	invoke CreateSolidBrush,012h
	invoke FillRect,[hdc],rectan2,eax
	
	mov eax,1
	jmp finish
fond3:
	invoke GetDC,[pWnd]
	mov [hdc],eax
	mov [rectan2.right],650
	mov [rectan2.bottom],290
	
	invoke CreateSolidBrush,017h
	invoke FillRect,[hdc],rectan2,eax
	
	mov eax,1
	jmp finish
col1:		
	invoke GetDC,[pWnd]
	mov [hdc],eax	
	
	;mov [rectan2.right],650
	;mov [rectan2.bottom],290
	
	;invoke CreateSolidBrush,000h
	;invoke FillRect,[hdc],rectan2,eax
					
	stdcall CambiaColorFondo, 0fah,[hdc] ;cambia la brocha a color nose
	
	invoke Ellipse,[hdc],[corCir1.x],[corCir1.y],[corCir2.x],[corCir2.y]  ;trato de poner nro const
	
	mov eax,1
	jmp finish
col2:
	invoke GetDC,[pWnd]
	mov [hdc],eax
		invoke Polygon,[hdc],coord1,3
	invoke CreateSolidBrush,0ffh
	
	mov eax,1
	jmp finish
col3:
	invoke GetDC,[pWnd]
	mov [hdc],eax
	
	invoke CreateSolidBrush,0fbh
	invoke FillRect,[hdc],rectangulo,eax
	
	mov eax,1
	jmp finish	
			
jCLOSE:	
	invoke EndDialog,[hWnd],0
	mov eax,1

	
finish:
	pop ebx esi edi
	ret
endp
proc WinMain uses ebx esi edi, hInst,hPrevInst, CmdLine, CmdShow
	
	invoke LoadIcon,0,cdVIcono
	mov edx,eax
	mov eax,[hInst]
	mov ebx,NombreClase
	mov ecx,WndProc
	mov [wc.hInstance],eax
	mov [wc.lpszClassName],ebx
	mov [wc.lpfnWndProc],ecx
	mov [wc.hIcon],edx
	
	invoke LoadCursor,0,cdVCursor
	mov [wc.hCursor],eax
	
	invoke RegisterClass,wc
	test eax,eax
	jz   error
	;mov [whMain],eax	;esto esta demas
	
	invoke CreateWindowEx,cdVBarTipo,NombreClase,msgCabecera,cdVBarTipo,cdXPos,cdYPos,cdXSize,cdYSize,NULL,NULL,[wc.hInstance],NULL
	
	;invoke ShowWindow,dword hWnd,dword SW_SHOWNORMAL
	;invoke UpdateWindow,dword hWnd
	
	msg_loop:
		invoke GetMessage,wMsg,NULL,0,0
		cmp eax,1
		jb end_loop
		jne msg_loop
		invoke TranslateMessage,wMsg
		invoke DispatchMessage,wMsg
	jmp msg_loop
	
	error:
		invoke MessageBox,NULL,MsgError,NULL,MB_ICONERROR+MB_OK
	end_loop:
		mov eax,[wMsg.wParam]
		ret	
	
	endp

proc  CambiaColorFondo newColor, uhdc
    ;  Prop�sito: Modifica el color de fondo por defecto
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

proc WndProc uses ebx esi edi, hwnd,wmsg,wparam,lparam
	cmp [wmsg],WM_DESTROY
	je  .wmdestroy
	.defwndproc:
	 invoke	  DefWindowProc,[hwnd],[wmsg],[wparam],[lparam]
	 jmp	  .finish
	.wmdestroy:
	 invoke	  PostQuitMessage,0
	 xor	  eax,eax
	.finish:
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
