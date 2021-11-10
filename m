Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F308C44BE61
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhKJKT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhKJKTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:19:08 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFB3C06120A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4Bovc66uj1aFFzHXYMb0tblfMRVWeJGQtWqhJBUFMhs=; b=SyHCTxCoVHgLvGFOVZP3q9hoX0
        GX4sRpcILzFFPTr8iYQH3wkIoGIMfeA+yfzI5DcqxqRkJmmTUHPT+/TxZvHNldizBDgnJdOX/C4pi
        F/AZCuUV9DWGKuyePjy4aqqehc/wTVB3gMD11yevwYtqmEpbYGUYnlSPDCf9kJXEeXLGPzQMMnEHE
        QjIb84SSB/q7AiQz9kWRTIW4rn/WOr38aENWb2M7h3xTUH4Dbk5em9im/Ww4pRntiKKxoqje1q4f5
        XQNaGN0dWsXdlLdQ+hFWWt6M2LroshVyYwK0R8ciQ6czdIPeX6/2m/tboLEjn3UcHM3QUns1QnIHV
        EM8TxJHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkkeH-00FFpk-4H; Wed, 10 Nov 2021 10:16:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ABCBC300C9D;
        Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7393020165536; Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Message-ID: <20211110101325.303890153@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Nov 2021 11:01:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH v2 07/23] x86,extable: Extend extable functionality
References: <20211110100102.250793167@infradead.org>
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

Also add a few flags into the type word, specifically CLEAR_AX and
CLEAR_DX which clear the return and extended return register.

Notes:
 - due to the % in our register names it's hard to make it more
   generally usable as arm64 did.
 - the s16 is far larger than used in these patches, future extentions
   can easily shrink this to get more bits.
 - without the bitfield fix this will not compile, because: 0xFF > -1
   and we can't even extract the TYPE field.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/asm.h                 |   33 ++++++++++++++
 arch/x86/include/asm/extable.h             |    6 +-
 arch/x86/include/asm/extable_fixup_types.h |   24 ++++++++++
 arch/x86/include/asm/insn-eval.h           |    2 
 arch/x86/lib/insn-eval.c                   |   66 ++++++++++++++++++-----------
 arch/x86/mm/extable.c                      |   40 +++++++++++++++--
 arch/x86/net/bpf_jit_comp.c                |    2 
 7 files changed, 141 insertions(+), 32 deletions(-)

--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -152,6 +152,31 @@
 
 #else /* ! __ASSEMBLY__ */
 
+asm(
+"	.macro extable_type_reg type:req reg:req\n"
+"	.set found, 0\n"
+"	.set regnr, 0\n"
+"	.irp rs,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,r15\n"
+"	.ifc \\reg, %\\rs\n"
+"	.set found, found+1\n"
+"	.long \\type + (regnr << 8)\n"
+"	.endif\n"
+"	.set regnr, regnr+1\n"
+"	.endr\n"
+"	.set regnr, 0\n"
+"	.irp rs,eax,ecx,edx,ebx,esp,ebp,esi,edi,r8d,r9d,r10d,r11d,r12d,r13d,r14d,r15d\n"
+"	.ifc \\reg, %\\rs\n"
+"	.set found, found+1\n"
+"	.long \\type + (regnr << 8)\n"
+"	.endif\n"
+"	.set regnr, regnr+1\n"
+"	.endr\n"
+"	.if (found != 1)\n"
+"	.error \"extable_type_reg: bad register argument\"\n"
+"	.endif\n"
+"	.endm\n"
+);
+
 # define _ASM_EXTABLE_TYPE(from, to, type)			\
 	" .pushsection \"__ex_table\",\"a\"\n"			\
 	" .balign 4\n"						\
@@ -160,6 +185,14 @@
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
--- a/arch/x86/include/asm/extable.h
+++ b/arch/x86/include/asm/extable.h
@@ -21,7 +21,7 @@
  */
 
 struct exception_table_entry {
-	int insn, fixup, type;
+	int insn, fixup, data;
 };
 struct pt_regs;
 
@@ -31,8 +31,8 @@ struct pt_regs;
 	do {							\
 		(a)->fixup = (b)->fixup + (delta);		\
 		(b)->fixup = (tmp).fixup - (delta);		\
-		(a)->type = (b)->type;				\
-		(b)->type = (tmp).type;				\
+		(a)->data = (b)->data;				\
+		(b)->data = (tmp).data;				\
 	} while (0)
 
 extern int fixup_exception(struct pt_regs *regs, int trapnr,
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -2,6 +2,29 @@
 #ifndef _ASM_X86_EXTABLE_FIXUP_TYPES_H
 #define _ASM_X86_EXTABLE_FIXUP_TYPES_H
 
+/*
+ * Our IMM is signed, as such it must live at the top end of the word. Also,
+ * since C99 hex constants are of ambigious type, force cast the mask to 'int'
+ * so that FIELD_GET() will DTRT and sign extend the value when it extracts it.
+ */
+#define EX_DATA_TYPE_MASK		((int)0x000000FF)
+#define EX_DATA_REG_MASK		((int)0x00000F00)
+#define EX_DATA_FLAG_MASK		((int)0x0000F000)
+#define EX_DATA_IMM_MASK		((int)0xFFFF0000)
+
+#define EX_DATA_REG_SHIFT		8
+#define EX_DATA_FLAG_SHIFT		12
+#define EX_DATA_IMM_SHIFT		16
+
+#define EX_DATA_FLAG(flag)		((flag) << EX_DATA_FLAG_SHIFT)
+#define EX_DATA_IMM(imm)		((imm) << EX_DATA_IMM_SHIFT)
+
+/* flags */
+#define EX_FLAG_CLEAR_AX		EX_DATA_FLAG(1)
+#define EX_FLAG_CLEAR_DX		EX_DATA_FLAG(2)
+#define EX_FLAG_CLEAR_AX_DX		EX_DATA_FLAG(3)
+
+/* types */
 #define	EX_TYPE_NONE			 0
 #define	EX_TYPE_DEFAULT			 1
 #define	EX_TYPE_FAULT			 2
@@ -20,5 +43,6 @@
 #define	EX_TYPE_FAULT_MCE_SAFE		13
 
 #define	EX_TYPE_POP_ZERO		14
+#define	EX_TYPE_IMM_REG			15 /* reg := (long)imm */
 
 #endif
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -15,6 +15,8 @@
 #define INSN_CODE_SEG_OPND_SZ(params) (params & 0xf)
 #define INSN_CODE_SEG_PARAMS(oper_sz, addr_sz) (oper_sz | (addr_sz << 4))
 
+int pt_regs_offset(struct pt_regs *regs, int regno);
+
 bool insn_has_rep_prefix(struct insn *insn);
 void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs);
 int insn_get_modrm_rm_off(struct insn *insn, struct pt_regs *regs);
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -412,32 +412,39 @@ static short get_segment_selector(struct
 #endif /* CONFIG_X86_64 */
 }
 
-static int get_reg_offset(struct insn *insn, struct pt_regs *regs,
-			  enum reg_type type)
+static const int pt_regoff[] = {
+	offsetof(struct pt_regs, ax),
+	offsetof(struct pt_regs, cx),
+	offsetof(struct pt_regs, dx),
+	offsetof(struct pt_regs, bx),
+	offsetof(struct pt_regs, sp),
+	offsetof(struct pt_regs, bp),
+	offsetof(struct pt_regs, si),
+	offsetof(struct pt_regs, di),
+#ifdef CONFIG_X86_64
+	offsetof(struct pt_regs, r8),
+	offsetof(struct pt_regs, r9),
+	offsetof(struct pt_regs, r10),
+	offsetof(struct pt_regs, r11),
+	offsetof(struct pt_regs, r12),
+	offsetof(struct pt_regs, r13),
+	offsetof(struct pt_regs, r14),
+	offsetof(struct pt_regs, r15),
+#endif
+};
+
+int pt_regs_offset(struct pt_regs *regs, int regno)
 {
+	if ((unsigned)regno < ARRAY_SIZE(pt_regoff))
+		return pt_regoff[regno];
+	return -EDOM;
+}
+
+static int get_regno(struct insn *insn, enum reg_type type)
+{
+	int nr_registers = ARRAY_SIZE(pt_regoff);
 	int regno = 0;
 
-	static const int regoff[] = {
-		offsetof(struct pt_regs, ax),
-		offsetof(struct pt_regs, cx),
-		offsetof(struct pt_regs, dx),
-		offsetof(struct pt_regs, bx),
-		offsetof(struct pt_regs, sp),
-		offsetof(struct pt_regs, bp),
-		offsetof(struct pt_regs, si),
-		offsetof(struct pt_regs, di),
-#ifdef CONFIG_X86_64
-		offsetof(struct pt_regs, r8),
-		offsetof(struct pt_regs, r9),
-		offsetof(struct pt_regs, r10),
-		offsetof(struct pt_regs, r11),
-		offsetof(struct pt_regs, r12),
-		offsetof(struct pt_regs, r13),
-		offsetof(struct pt_regs, r14),
-		offsetof(struct pt_regs, r15),
-#endif
-	};
-	int nr_registers = ARRAY_SIZE(regoff);
 	/*
 	 * Don't possibly decode a 32-bit instructions as
 	 * reading a 64-bit-only register.
@@ -505,7 +512,18 @@ static int get_reg_offset(struct insn *i
 		WARN_ONCE(1, "decoded an instruction with an invalid register");
 		return -EINVAL;
 	}
-	return regoff[regno];
+	return regno;
+}
+
+static int get_reg_offset(struct insn *insn, struct pt_regs *regs,
+			  enum reg_type type)
+{
+	int regno = get_regno(insn, type);
+
+	if (regno < 0)
+		return regno;
+
+	return pt_regs_offset(regs, regno);
 }
 
 /**
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -2,12 +2,25 @@
 #include <linux/extable.h>
 #include <linux/uaccess.h>
 #include <linux/sched/debug.h>
+#include <linux/bitfield.h>
 #include <xen/xen.h>
 
 #include <asm/fpu/api.h>
 #include <asm/sev.h>
 #include <asm/traps.h>
 #include <asm/kdebug.h>
+#include <asm/insn-eval.h>
+
+static inline unsigned long *pt_regs_nr(struct pt_regs *regs, int nr)
+{
+	int reg_offset = pt_regs_offset(regs, nr);
+	static unsigned long __dummy;
+
+	if (WARN_ON_ONCE(reg_offset < 0))
+		return &__dummy;
+
+	return (unsigned long *)((unsigned long)regs + reg_offset);
+}
 
 static inline unsigned long
 ex_fixup_addr(const struct exception_table_entry *x)
@@ -15,10 +28,15 @@ ex_fixup_addr(const struct exception_tab
 	return (unsigned long)&x->fixup + x->fixup;
 }
 
-static bool ex_handler_default(const struct exception_table_entry *fixup,
+static bool ex_handler_default(const struct exception_table_entry *e,
 			       struct pt_regs *regs)
 {
-	regs->ip = ex_fixup_addr(fixup);
+	if (e->data & EX_FLAG_CLEAR_AX)
+		regs->ax = 0;
+	if (e->data & EX_FLAG_CLEAR_DX)
+		regs->dx = 0;
+
+	regs->ip = ex_fixup_addr(e);
 	return true;
 }
 
@@ -111,17 +129,25 @@ static bool ex_handler_pop_zero(const st
 	return ex_handler_default(fixup, regs);
 }
 
+static bool ex_handler_imm_reg(const struct exception_table_entry *fixup,
+			       struct pt_regs *regs, int reg, int imm)
+{
+	*pt_regs_nr(regs, reg) = (long)imm;
+	return ex_handler_default(fixup, regs);
+}
+
 int ex_get_fixup_type(unsigned long ip)
 {
 	const struct exception_table_entry *e = search_exception_tables(ip);
 
-	return e ? e->type : EX_TYPE_NONE;
+	return e ? FIELD_GET(EX_DATA_TYPE_MASK, e->data) : EX_TYPE_NONE;
 }
 
 int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 		    unsigned long fault_addr)
 {
 	const struct exception_table_entry *e;
+	int type, reg, imm;
 
 #ifdef CONFIG_PNPBIOS
 	if (unlikely(SEGMENT_IS_PNP_CODE(regs->cs))) {
@@ -141,7 +167,11 @@ int fixup_exception(struct pt_regs *regs
 	if (!e)
 		return 0;
 
-	switch (e->type) {
+	type = FIELD_GET(EX_DATA_TYPE_MASK, e->data);
+	reg  = FIELD_GET(EX_DATA_REG_MASK,  e->data);
+	imm  = FIELD_GET(EX_DATA_IMM_MASK,  e->data);
+
+	switch (type) {
 	case EX_TYPE_DEFAULT:
 	case EX_TYPE_DEFAULT_MCE_SAFE:
 		return ex_handler_default(e, regs);
@@ -170,6 +200,8 @@ int fixup_exception(struct pt_regs *regs
 		break;
 	case EX_TYPE_POP_ZERO:
 		return ex_handler_pop_zero(e, regs);
+	case EX_TYPE_IMM_REG:
+		return ex_handler_imm_reg(e, regs, reg, imm);
 	}
 	BUG();
 }
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1291,7 +1291,7 @@ st:			if (is_imm8(insn->off))
 				}
 				ex->insn = delta;
 
-				ex->type = EX_TYPE_BPF;
+				ex->data = EX_TYPE_BPF;
 
 				if (dst_reg > BPF_REG_9) {
 					pr_err("verifier error\n");


