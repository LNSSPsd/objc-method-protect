.section __TEXT,__text,regular,pure_instructions
.p2align 2
.globl __protect_method_internal, "#ava%sl1"

__protect_method_internal:
	sub sp,sp,#48
	stp x29,x30,[sp,#32]
	stp x21,x22,[sp,#16]
	str x23,[sp,#8]
	mov x21,x0
	mov x22,x1
	mov x23,x2
	adrp x15,"#ava%sl1"@PAGE
	ldr x15,[x15,"#ava%sl1"@PAGEOFF]
	cbnz x15,L_protect_method.cont
	bl Linit_method_protect
L_protect_method.cont:
	mov x0,x21
	mov x1,x22
	bl _class_getMethodImplementation
	mov x2,x0
	mov x0,x21
	mov x1,x22
	mov x21,x2
	mov x2,x23
	adrp x3,str_atype@PAGE
	add x3,x3,str_atype@PAGEOFF
	bl _class_replaceMethod
	mov x0,x21
	ldr x23,[sp,#8]
	ldp x21,x22,[sp,#16]
	ldp x29,x30,[sp,#32]
	add sp,sp,#48
	ret

Linit_method_protect:
	sub sp,sp,#32
	stp x29,x30,[sp,#16]
	stp x19,x20,[sp]
	mov x0,xzr
	bl __dyld_get_image_vmaddr_slide
	mov x20,x0
	adrp x0,seg_text@PAGE
	add x0,x0,seg_text@PAGEOFF
	adrp x1,sect_text@PAGE
	add x1,x1,sect_text@PAGEOFF
	bl _getsectbyname
	ldp x16,x15,[x0,#32]
	adrp x14,"#ava%sl1"@PAGE
	add x14,x14,"#ava%sl1"@PAGEOFF
	add x16,x16,x20
	stp x16,x15,[x14]
	ldp x19,x20,[sp]
	ldp x29,x30,[sp,#16]
	add sp,sp,#32
	ret

.section __TEXT,__cstring,cstring_literals
str_atype:
	.asciz "@:"
seg_text:
	.asciz "__TEXT"
sect_text:
	.asciz "__text"
.section __DATA,__common
"#ava%sl1":
	.quad 0
	.quad 0
