Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2244457D8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhKDRES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhKDREJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:04:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B54C06120B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 10:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=8aomfjWhistjLgrDa1i8qBQQpOyqGO8peYAdf8uuD38=; b=SXCHuQjvkn0gixQM9aI7HJT6Ci
        U/jbJFpik6qEZvf72liz0AuBQyIA5z8soXlfmuRK7HuyDAMJ/vJIpiZKM/iU63UsUxhFIQibHleEX
        GaZn+2CE3OelcWb3WwdX1BA60X+O6ZHveLhMb9wiP8ORQe1agnL4/HJ/HXjMkbNg6jbCSB1RR6fIq
        iVnuLCVkwz9PIxKxfeOuDAKGc8LrJqnbRBWO9bpq6Wi0kqgpWWOJRBLZ2An0PiXCHXb0JbBOjh3r5
        4EO6OJa5VRSv0DHWjORJpiplH9QxjkvX2KOaJTKnwSwyhJp1cv0HPi5+gC+GMCEozN1+sfTu1Eo5U
        4BcP8kzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mig2X-0060FX-AC; Thu, 04 Nov 2021 16:57:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 520A33010C2;
        Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2AD282DD49FBA; Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Message-ID: <20211104165524.925401847@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Nov 2021 17:47:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [RFC][PATCH 07/22] x86,extable: Extend extable functionality
References: <20211104164729.226550532@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to remove further .fixup usage, extend the extable
infrastructure to take additional information from the extable entry
sites.

Specifically add _ASM_EXTABLE_TYPE_REG() and EX_TYPE_IMM_REG that
extend the existing _ASM_EXTABLE_TYPE() by taking an additional
register argument and encoding that and an s16 immediate into the
existing s32 type field. This limits the actual types to the first
byte, 255 seem plenty.

Also add a few flags into the type word, specifically CLR_AX and
CLR_DX which clear the return and extended return register.

Notes:
 - due to the % in our register names it's hard to make it more
   generally usable as arm64 did.
 - the s16 is far larger than used in these patches, future extentions
   can easily shrink this to get more bits.
 - without the bitfield fix this will not compile, because: 0xFF > -1
   and we can't even extract the TYPE field.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/asm.h                 |   27 +++++++++++++
 arch/x86/include/asm/extable_fixup_types.h |   14 ++++++
 arch/x86/mm/extable.c                      |   59 +++++++++++++++++++++++++++--
 3 files changed, 96 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -152,6 +152,25 @@
 
 #else /* ! __ASSEMBLY__ */
 
+asm(
+"	.macro extable_type_reg type:req reg:req\n"
+"	.set regnr, 0\n"
+"	.irp rs,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,r15\n"
+"	.ifc \\reg, %\\rs\n"
+"	.long \\type + (regnr << 8)\n"
+"	.endif\n"
+"	.set regnr, regnr+1\n"
+"	.endr\n"
+"	.set regnr, 0\n"
+"	.irp rs,eax,ecx,edx,ebx,esp,ebp,esi,edi,r8d,r9d,r10d,r11d,r12d,r13d,r14d,r15d\n"
+"	.ifc \\reg, %\\rs\n"
+"	.long \\type + (regnr << 8)\n"
+"	.endif\n"
+"	.set regnr, regnr+1\n"
+"	.endr\n"
+"	.endm\n"
+);
+
 # define _ASM_EXTABLE_TYPE(from, to, type)			\
 	" .pushsection \"__ex_table\",\"a\"\n"			\
 	" .balign 4\n"						\
@@ -160,6 +179,14 @@
 	" .long " __stringify(type) " \n"			\
 	" .popsection\n"
 
+# define _ASM_EXTABLE_TYPE_REG(from, to, type, reg)				\
+	" .pushsection \"__ex_table\",\"a\"\n"					\
+	" .balign 4\n"								\
+	" .long (" #from ") - .\n"						\
+	" .long (" #to ") - .\n"						\
+	"extable_type_reg reg=" __stringify(reg) ", type=" __stringify(type) " \n"\
+	" .popsection\n"
+
 /* For C file, we already have NOKPROBE_SYMBOL macro */
 
 /*
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -2,6 +2,19 @@
 #ifndef _ASM_X86_EXTABLE_FIXUP_TYPES_H
 #define _ASM_X86_EXTABLE_FIXUP_TYPES_H
 
+#define EX_TYPE_REG_SHIFT		8
+#define EX_TYPE_FLAG_SHIFT		12
+#define EX_TYPE_IMM_SHIFT		16
+
+#define EX_TYPE_FLAG(flag)		((flag) << EX_TYPE_FLAG_SHIFT)
+#define EX_TYPE_IMM(imm)		((imm) << EX_TYPE_IMM_SHIFT)
+
+/* flags */
+#define EX_FLAG_CLR_AX			EX_TYPE_FLAG(1)
+#define EX_FLAG_CLR_DX			EX_TYPE_FLAG(2)
+#define EX_FLAG_CLR_AX_DX		EX_TYPE_FLAG(3)
+
+/* types */
 #define	EX_TYPE_NONE			 0
 #define	EX_TYPE_DEFAULT			 1
 #define	EX_TYPE_FAULT			 2
@@ -20,5 +33,6 @@
 #define	EX_TYPE_FAULT_MCE_SAFE		13
 
 #define EX_TYPE_POP_SEG			14
+#define EX_TYPE_IMM_REG			15 /* reg := (long)imm */
 
 #endif
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -2,6 +2,7 @@
 #include <linux/extable.h>
 #include <linux/uaccess.h>
 #include <linux/sched/debug.h>
+#include <linux/bitfield.h>
 #include <xen/xen.h>
 
 #include <asm/fpu/api.h>
@@ -9,16 +10,47 @@
 #include <asm/traps.h>
 #include <asm/kdebug.h>
 
+static inline unsigned long *pt_regs_nr(struct pt_regs *regs, int nr)
+{
+	/* because having pt_regs in machine order was too much to ask */
+	switch (nr) {
+	case 0:		return &regs->ax;
+	case 1:		return &regs->cx;
+	case 2:		return &regs->dx;
+	case 3:		return &regs->bx;
+	case 4:		return &regs->sp;
+	case 5:		return &regs->bp;
+	case 6:		return &regs->si;
+	case 7:		return &regs->di;
+#ifdef CONFIG_X86_64
+	case 8:		return &regs->r8;
+	case 9:		return &regs->r9;
+	case 10:	return &regs->r10;
+	case 11:	return &regs->r11;
+	case 12:	return &regs->r12;
+	case 13:	return &regs->r13;
+	case 14:	return &regs->r14;
+	case 15:	return &regs->r15;
+#endif
+	default:	return NULL;
+	}
+}
+
 static inline unsigned long
 ex_fixup_addr(const struct exception_table_entry *x)
 {
 	return (unsigned long)&x->fixup + x->fixup;
 }
 
-static bool ex_handler_default(const struct exception_table_entry *fixup,
+static bool ex_handler_default(const struct exception_table_entry *e,
 			       struct pt_regs *regs)
 {
-	regs->ip = ex_fixup_addr(fixup);
+	if (e->type & EX_FLAG_CLR_AX)
+		regs->ax = 0;
+	if (e->type & EX_FLAG_CLR_DX)
+		regs->dx = 0;
+
+	regs->ip = ex_fixup_addr(e);
 	return true;
 }
 
@@ -106,17 +138,30 @@ static bool ex_handler_pop_seg(const str
 	return ex_handler_default(fixup, regs);
 }
 
+static bool ex_handler_imm_reg(const struct exception_table_entry *fixup,
+			       struct pt_regs *regs, int reg, int imm)
+{
+	*pt_regs_nr(regs, reg) = (long)imm;
+	return ex_handler_default(fixup, regs);
+}
+
+#define EX_TYPE_MASK	0x000000FF
+#define EX_REG_MASK	0x00000F00
+#define EX_FLAG_MASK	0x0000F000
+#define EX_IMM_MASK	0xFFFF0000
+
 int ex_get_fixup_type(unsigned long ip)
 {
 	const struct exception_table_entry *e = search_exception_tables(ip);
 
-	return e ? e->type : EX_TYPE_NONE;
+	return e ? FIELD_GET(EX_TYPE_MASK, e->type) : EX_TYPE_NONE;
 }
 
 int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 		    unsigned long fault_addr)
 {
 	const struct exception_table_entry *e;
+	int type, reg, imm;
 
 #ifdef CONFIG_PNPBIOS
 	if (unlikely(SEGMENT_IS_PNP_CODE(regs->cs))) {
@@ -136,7 +181,11 @@ int fixup_exception(struct pt_regs *regs
 	if (!e)
 		return 0;
 
-	switch (e->type) {
+	type = FIELD_GET(EX_TYPE_MASK, e->type);
+	reg  = FIELD_GET(EX_REG_MASK,  e->type);
+	imm  = FIELD_GET(EX_IMM_MASK,  e->type);
+
+	switch (type) {
 	case EX_TYPE_DEFAULT:
 	case EX_TYPE_DEFAULT_MCE_SAFE:
 		return ex_handler_default(e, regs);
@@ -165,6 +214,8 @@ int fixup_exception(struct pt_regs *regs
 		break;
 	case EX_TYPE_POP_SEG:
 		return ex_handler_pop_seg(e, regs);
+	case EX_TYPE_IMM_REG:
+		return ex_handler_imm_reg(e, regs, reg, imm);
 	}
 	BUG();
 }


