; process
; void __FASTCALL__ get_ifconfig_inet(in_addr_t *addr);
XLIB get_ifconfig_inet
LIB libspectranet

	include "spectranet.asm"
.get_ifconfig_inet
	ex de, hl
	HLCALL GET_IFCONFIG_INET_ROM
	ret

