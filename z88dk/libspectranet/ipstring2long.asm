; CALLER linkage for ipstring2long
; int ipstring2long(char *str, in_addr_t *addr);
XLIB ipstring2long
LIB libspectranet
XREF ASMDISP_IPSTRING2LONG_CALLEE

.ipstring2long
	pop bc		; ret addr
	pop de		; in_addr_t *addr
	pop hl		; char *str
	push hl
	push de
	push bc
	jp ipstring2long_callee + ASMDISP_IPSTRING2LONG_CALLEE

