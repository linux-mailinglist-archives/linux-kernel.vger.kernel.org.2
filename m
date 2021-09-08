Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B232E403AA9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351772AbhIHNbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349430AbhIHNa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:30:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721E9C061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 06:29:20 -0700 (PDT)
Message-ID: <20210908132525.211958725@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631107759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=mDA6g7qazqRg7HO3UBVtb/MKn1RO/TlabXmoxr3DgxY=;
        b=bAdJQQrHXntmFxvdOSS9Ld3ulA+Dkrblsf6mgeOGra60JDdAeMc9ISHilb/koxfiWPyKVO
        pY5rasnED/Y6GdO1u7vZ1o6uxXzs0BJ4OECu9DduCBps+A0RcoWv3ZuympNzovhdP27b61
        1nt1YD+0OgjSziVmXfTcBWy5VQwpM15FU5yOmEidvzp+v+DJqFOg+OlrF1LkSktUWcWAaA
        +UFAVe7VVXG7l65Jum55rRrjp8Kg43atZIi60nwTZ7Y0oDd2YgCiD5SNOkZZ++uZEtDRaU
        1JdXvEf3VxaAs2SPBeuNoJmUggHHYoM4DoBv8dtMjlnTdFqpGy+l0V8392D7oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631107759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=mDA6g7qazqRg7HO3UBVtb/MKn1RO/TlabXmoxr3DgxY=;
        b=uVnVdR13jRckoQMG3xQNRqg7QIlLMOFkFjApmq61iNKZ91Dbha+JZ1gLodAWAPvrmXEFdm
        zHXk9CM+YM7T3+CA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch V3 05/20] x86/extable: Rework the exception table mechanics
References: <20210908130922.118265849@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  8 Sep 2021 15:29:18 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The exception table entries contain the instruction address, the fixup
address and the handler address. All addresses are relative. Storing the
handler address has a few downsides:

 1) Most handlers need to be exported
 
 2) Handlers can be defined everywhere and there is no overview about the
    handler types

 3) MCE needs to check the handler type to decide whether an in kernel #MC
    can be recovered. The functionality of the handler itself is not in any
    way special, but for these checks there need to be separate functions
    which in the worst case have to be exported.

    Some of these 'recoverable' exception fixups are pretty obscure and
    just reuse some other handler to spare code. That obfuscates e.g. the
    #MC safe copy functions. Cleaning that up would require more handlers
    and exports

Rework the exception fixup mechanics by storing a fixup type number instead
of the handler address and invoke the proper handler for each fixup
type. Also teach the extable sort to leave the type field alone.

This makes most handlers static except for special cases like the MCE
MSR fixup and the BPF fixup. This allows to add more types for cleaning up
the obscure places without adding more handler code and exports.

There is a marginal code size reduction for a production config and it
removes _eight_ exported symbols.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
V2: New patch
---
 arch/x86/include/asm/asm.h                 |   22 ++---
 arch/x86/include/asm/extable.h             |   44 ++++++----
 arch/x86/include/asm/extable_fixup_types.h |   19 ++++
 arch/x86/include/asm/fpu/internal.h        |    4 
 arch/x86/include/asm/msr.h                 |    4 
 arch/x86/include/asm/segment.h             |    2 
 arch/x86/kernel/cpu/mce/core.c             |   24 -----
 arch/x86/kernel/cpu/mce/internal.h         |   10 --
 arch/x86/kernel/cpu/mce/severity.c         |   21 ++--
 arch/x86/mm/extable.c                      |  123 ++++++++++++-----------------
 arch/x86/net/bpf_jit_comp.c                |   11 --
 scripts/sorttable.c                        |    4 
 12 files changed, 133 insertions(+), 155 deletions(-)

--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -122,14 +122,17 @@
 
 #ifdef __KERNEL__
 
+# include <asm/extable_fixup_types.h>
+
 /* Exception table entry */
 #ifdef __ASSEMBLY__
-# define _ASM_EXTABLE_HANDLE(from, to, handler)			\
+
+# define _ASM_EXTABLE_TYPE(from, to, type)			\
 	.pushsection "__ex_table","a" ;				\
 	.balign 4 ;						\
 	.long (from) - . ;					\
 	.long (to) - . ;					\
-	.long (handler) - . ;					\
+	.long type ;						\
 	.popsection
 
 # ifdef CONFIG_KPROBES
@@ -143,13 +146,13 @@
 # endif
 
 #else /* ! __ASSEMBLY__ */
-# define _EXPAND_EXTABLE_HANDLE(x) #x
-# define _ASM_EXTABLE_HANDLE(from, to, handler)			\
+
+# define _ASM_EXTABLE_TYPE(from, to, type)			\
 	" .pushsection \"__ex_table\",\"a\"\n"			\
 	" .balign 4\n"						\
 	" .long (" #from ") - .\n"				\
 	" .long (" #to ") - .\n"				\
-	" .long (" _EXPAND_EXTABLE_HANDLE(handler) ") - .\n"	\
+	" .long " __stringify(type) " \n"			\
 	" .popsection\n"
 
 /* For C file, we already have NOKPROBE_SYMBOL macro */
@@ -165,17 +168,16 @@ register unsigned long current_stack_poi
 #endif /* __ASSEMBLY__ */
 
 #define _ASM_EXTABLE(from, to)					\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
+	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_DEFAULT)
 
 #define _ASM_EXTABLE_UA(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
+	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_UACCESS)
 
 #define _ASM_EXTABLE_CPY(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_copy)
+	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_COPY)
 
 #define _ASM_EXTABLE_FAULT(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
-
+	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_FAULT)
 
 #endif /* __KERNEL__ */
 
--- a/arch/x86/include/asm/extable.h
+++ b/arch/x86/include/asm/extable.h
@@ -1,12 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_X86_EXTABLE_H
 #define _ASM_X86_EXTABLE_H
+
+#include <asm/extable_fixup_types.h>
+
 /*
- * The exception table consists of triples of addresses relative to the
- * exception table entry itself. The first address is of an instruction
- * that is allowed to fault, the second is the target at which the program
- * should continue. The third is a handler function to deal with the fault
- * caused by the instruction in the first field.
+ * The exception table consists of two addresses relative to the
+ * exception table entry itself and a type selector field.
+ *
+ * The first address is of an instruction that is allowed to fault, the
+ * second is the target at which the program should continue.
+ *
+ * The type entry is used by fixup_exception() to select the handler to
+ * deal with the fault caused by the instruction in the first field.
  *
  * All the routines below use bits of fixup code that are out of line
  * with the main instruction path.  This means when everything is well,
@@ -15,7 +21,7 @@
  */
 
 struct exception_table_entry {
-	int insn, fixup, handler;
+	int insn, fixup, type;
 };
 struct pt_regs;
 
@@ -25,21 +31,27 @@ struct pt_regs;
 	do {							\
 		(a)->fixup = (b)->fixup + (delta);		\
 		(b)->fixup = (tmp).fixup - (delta);		\
-		(a)->handler = (b)->handler + (delta);		\
-		(b)->handler = (tmp).handler - (delta);		\
+		(a)->type = (b)->type;				\
+		(b)->type = (tmp).type;				\
 	} while (0)
 
-enum handler_type {
-	EX_HANDLER_NONE,
-	EX_HANDLER_FAULT,
-	EX_HANDLER_UACCESS,
-	EX_HANDLER_OTHER
-};
-
 extern int fixup_exception(struct pt_regs *regs, int trapnr,
 			   unsigned long error_code, unsigned long fault_addr);
 extern int fixup_bug(struct pt_regs *regs, int trapnr);
-extern enum handler_type ex_get_fault_handler_type(unsigned long ip);
+extern int ex_get_fixup_type(unsigned long ip);
 extern void early_fixup_exception(struct pt_regs *regs, int trapnr);
 
+#ifdef CONFIG_X86_MCE
+extern void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr);
+#else
+static inline void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr) { }
+#endif
+
+#if defined(CONFIG_BPF_JIT) && defined(CONFIG_X86_64)
+bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs);
+#else
+static inline bool ex_handler_bpf(const struct exception_table_entry *x,
+				  struct pt_regs *regs) { return false; }
+#endif
+
 #endif
--- /dev/null
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_EXTABLE_FIXUP_TYPES_H
+#define _ASM_X86_EXTABLE_FIXUP_TYPES_H
+
+#define	EX_TYPE_NONE			 0
+#define	EX_TYPE_DEFAULT			 1
+#define	EX_TYPE_FAULT			 2
+#define	EX_TYPE_UACCESS			 3
+#define	EX_TYPE_COPY			 4
+#define	EX_TYPE_CLEAR_FS		 5
+#define	EX_TYPE_FPU_RESTORE		 6
+#define	EX_TYPE_WRMSR			 7
+#define	EX_TYPE_RDMSR			 8
+#define	EX_TYPE_BPF			 9
+
+#define	EX_TYPE_WRMSR_IN_MCE		10
+#define	EX_TYPE_RDMSR_IN_MCE		11
+
+#endif
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -126,7 +126,7 @@ extern void save_fpregs_to_fpstate(struc
 #define kernel_insn(insn, output, input...)				\
 	asm volatile("1:" #insn "\n\t"					\
 		     "2:\n"						\
-		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_fprestore)	\
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FPU_RESTORE)	\
 		     : output : input)
 
 static inline int fnsave_to_user_sigframe(struct fregs_state __user *fx)
@@ -253,7 +253,7 @@ static inline void fxsave(struct fxregs_
 				 XRSTORS, X86_FEATURE_XSAVES)		\
 		     "\n"						\
 		     "3:\n"						\
-		     _ASM_EXTABLE_HANDLE(661b, 3b, ex_handler_fprestore)\
+		     _ASM_EXTABLE_TYPE(661b, 3b, EX_TYPE_FPU_RESTORE)	\
 		     :							\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -92,7 +92,7 @@ static __always_inline unsigned long lon
 
 	asm volatile("1: rdmsr\n"
 		     "2:\n"
-		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_rdmsr_unsafe)
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_RDMSR)
 		     : EAX_EDX_RET(val, low, high) : "c" (msr));
 
 	return EAX_EDX_VAL(val, low, high);
@@ -102,7 +102,7 @@ static __always_inline void __wrmsr(unsi
 {
 	asm volatile("1: wrmsr\n"
 		     "2:\n"
-		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_wrmsr_unsafe)
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
 		     : : "c" (msr), "a"(low), "d" (high) : "memory");
 }
 
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -339,7 +339,7 @@ static inline void __loadsegment_fs(unsi
 		     "1:	movw %0, %%fs			\n"
 		     "2:					\n"
 
-		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_clear_fs)
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_CLEAR_FS)
 
 		     : : "rm" (value) : "memory");
 }
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -373,7 +373,7 @@ static int msr_to_offset(u32 msr)
 	return -1;
 }
 
-static void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr)
+void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr)
 {
 	if (wrmsr) {
 		pr_emerg("MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
@@ -392,15 +392,6 @@ static void ex_handler_msr_mce(struct pt
 		cpu_relax();
 }
 
-__visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fixup,
-				      struct pt_regs *regs, int trapnr,
-				      unsigned long error_code,
-				      unsigned long fault_addr)
-{
-	ex_handler_msr_mce(regs, false);
-	return true;
-}
-
 /* MSR access wrappers used for error injection */
 static noinstr u64 mce_rdmsrl(u32 msr)
 {
@@ -430,22 +421,13 @@ static noinstr u64 mce_rdmsrl(u32 msr)
 	 */
 	asm volatile("1: rdmsr\n"
 		     "2:\n"
-		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_rdmsr_fault)
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_RDMSR_IN_MCE)
 		     : EAX_EDX_RET(val, low, high) : "c" (msr));
 
 
 	return EAX_EDX_VAL(val, low, high);
 }
 
-__visible bool ex_handler_wrmsr_fault(const struct exception_table_entry *fixup,
-				      struct pt_regs *regs, int trapnr,
-				      unsigned long error_code,
-				      unsigned long fault_addr)
-{
-	ex_handler_msr_mce(regs, true);
-	return true;
-}
-
 static noinstr void mce_wrmsrl(u32 msr, u64 v)
 {
 	u32 low, high;
@@ -470,7 +452,7 @@ static noinstr void mce_wrmsrl(u32 msr,
 	/* See comment in mce_rdmsrl() */
 	asm volatile("1: wrmsr\n"
 		     "2:\n"
-		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_wrmsr_fault)
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR_IN_MCE)
 		     : : "c" (msr), "a"(low), "d" (high) : "memory");
 }
 
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -186,14 +186,4 @@ extern bool amd_filter_mce(struct mce *m
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 #endif
 
-__visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fixup,
-				      struct pt_regs *regs, int trapnr,
-				      unsigned long error_code,
-				      unsigned long fault_addr);
-
-__visible bool ex_handler_wrmsr_fault(const struct exception_table_entry *fixup,
-				      struct pt_regs *regs, int trapnr,
-				      unsigned long error_code,
-				      unsigned long fault_addr);
-
 #endif /* __X86_MCE_INTERNAL_H__ */
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -265,25 +265,24 @@ static bool is_copy_from_user(struct pt_
  */
 static int error_context(struct mce *m, struct pt_regs *regs)
 {
-	enum handler_type t;
-
 	if ((m->cs & 3) == 3)
 		return IN_USER;
 	if (!mc_recoverable(m->mcgstatus))
 		return IN_KERNEL;
 
-	t = ex_get_fault_handler_type(m->ip);
-	if (t == EX_HANDLER_FAULT) {
-		m->kflags |= MCE_IN_KERNEL_RECOV;
-		return IN_KERNEL_RECOV;
-	}
-	if (t == EX_HANDLER_UACCESS && regs && is_copy_from_user(regs)) {
-		m->kflags |= MCE_IN_KERNEL_RECOV;
+	switch (ex_get_fixup_type(m->ip)) {
+	case EX_TYPE_UACCESS:
+	case EX_TYPE_COPY:
+		if (!regs || !is_copy_from_user(regs))
+			return IN_KERNEL;
 		m->kflags |= MCE_IN_KERNEL_COPYIN;
+		fallthrough;
+	case EX_TYPE_FAULT:
+		m->kflags |= MCE_IN_KERNEL_RECOV;
 		return IN_KERNEL_RECOV;
+	default:
+		return IN_KERNEL;
 	}
-
-	return IN_KERNEL;
 }
 
 static int mce_severity_amd_smca(struct mce *m, enum context err_ctx)
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -9,40 +9,25 @@
 #include <asm/traps.h>
 #include <asm/kdebug.h>
 
-typedef bool (*ex_handler_t)(const struct exception_table_entry *,
-			    struct pt_regs *, int, unsigned long,
-			    unsigned long);
-
 static inline unsigned long
 ex_fixup_addr(const struct exception_table_entry *x)
 {
 	return (unsigned long)&x->fixup + x->fixup;
 }
-static inline ex_handler_t
-ex_fixup_handler(const struct exception_table_entry *x)
-{
-	return (ex_handler_t)((unsigned long)&x->handler + x->handler);
-}
 
-__visible bool ex_handler_default(const struct exception_table_entry *fixup,
-				  struct pt_regs *regs, int trapnr,
-				  unsigned long error_code,
-				  unsigned long fault_addr)
+static bool ex_handler_default(const struct exception_table_entry *fixup,
+			       struct pt_regs *regs)
 {
 	regs->ip = ex_fixup_addr(fixup);
 	return true;
 }
-EXPORT_SYMBOL(ex_handler_default);
 
-__visible bool ex_handler_fault(const struct exception_table_entry *fixup,
-				struct pt_regs *regs, int trapnr,
-				unsigned long error_code,
-				unsigned long fault_addr)
+static bool ex_handler_fault(const struct exception_table_entry *fixup,
+			     struct pt_regs *regs, int trapnr)
 {
 	regs->ax = trapnr;
-	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
+	return ex_handler_default(fixup, regs);
 }
-EXPORT_SYMBOL_GPL(ex_handler_fault);
 
 /*
  * Handler for when we fail to restore a task's FPU state.  We should never get
@@ -54,10 +39,8 @@ EXPORT_SYMBOL_GPL(ex_handler_fault);
  * of vulnerability by restoring from the initial state (essentially, zeroing
  * out all the FPU registers) if we can't restore from the task's FPU state.
  */
-__visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
-				    struct pt_regs *regs, int trapnr,
-				    unsigned long error_code,
-				    unsigned long fault_addr)
+static bool ex_handler_fprestore(const struct exception_table_entry *fixup,
+				 struct pt_regs *regs)
 {
 	regs->ip = ex_fixup_addr(fixup);
 
@@ -67,32 +50,23 @@ EXPORT_SYMBOL_GPL(ex_handler_fault);
 	__restore_fpregs_from_fpstate(&init_fpstate, xfeatures_mask_fpstate());
 	return true;
 }
-EXPORT_SYMBOL_GPL(ex_handler_fprestore);
 
-__visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
-				  struct pt_regs *regs, int trapnr,
-				  unsigned long error_code,
-				  unsigned long fault_addr)
+static bool ex_handler_uaccess(const struct exception_table_entry *fixup,
+			       struct pt_regs *regs, int trapnr)
 {
 	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
-	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
+	return ex_handler_default(fixup, regs);
 }
-EXPORT_SYMBOL(ex_handler_uaccess);
 
-__visible bool ex_handler_copy(const struct exception_table_entry *fixup,
-			       struct pt_regs *regs, int trapnr,
-			       unsigned long error_code,
-			       unsigned long fault_addr)
+static bool ex_handler_copy(const struct exception_table_entry *fixup,
+			    struct pt_regs *regs, int trapnr)
 {
 	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
-	return ex_handler_fault(fixup, regs, trapnr, error_code, fault_addr);
+	return ex_handler_fault(fixup, regs, trapnr);
 }
-EXPORT_SYMBOL(ex_handler_copy);
 
-__visible bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup,
-				       struct pt_regs *regs, int trapnr,
-				       unsigned long error_code,
-				       unsigned long fault_addr)
+static bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup,
+				    struct pt_regs *regs)
 {
 	if (pr_warn_once("unchecked MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
 			 (unsigned int)regs->cx, regs->ip, (void *)regs->ip))
@@ -101,14 +75,11 @@ EXPORT_SYMBOL(ex_handler_copy);
 	/* Pretend that the read succeeded and returned 0. */
 	regs->ax = 0;
 	regs->dx = 0;
-	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
+	return ex_handler_default(fixup, regs);
 }
-EXPORT_SYMBOL(ex_handler_rdmsr_unsafe);
 
-__visible bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixup,
-				       struct pt_regs *regs, int trapnr,
-				       unsigned long error_code,
-				       unsigned long fault_addr)
+static bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixup,
+				    struct pt_regs *regs)
 {
 	if (pr_warn_once("unchecked MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
 			 (unsigned int)regs->cx, (unsigned int)regs->dx,
@@ -116,44 +87,29 @@ EXPORT_SYMBOL(ex_handler_rdmsr_unsafe);
 		show_stack_regs(regs);
 
 	/* Pretend that the write succeeded. */
-	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
+	return ex_handler_default(fixup, regs);
 }
-EXPORT_SYMBOL(ex_handler_wrmsr_unsafe);
 
-__visible bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
-				   struct pt_regs *regs, int trapnr,
-				   unsigned long error_code,
-				   unsigned long fault_addr)
+static bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
+				struct pt_regs *regs)
 {
 	if (static_cpu_has(X86_BUG_NULL_SEG))
 		asm volatile ("mov %0, %%fs" : : "rm" (__USER_DS));
 	asm volatile ("mov %0, %%fs" : : "rm" (0));
-	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
+	return ex_handler_default(fixup, regs);
 }
-EXPORT_SYMBOL(ex_handler_clear_fs);
 
-enum handler_type ex_get_fault_handler_type(unsigned long ip)
+int ex_get_fixup_type(unsigned long ip)
 {
-	const struct exception_table_entry *e;
-	ex_handler_t handler;
+	const struct exception_table_entry *e = search_exception_tables(ip);
 
-	e = search_exception_tables(ip);
-	if (!e)
-		return EX_HANDLER_NONE;
-	handler = ex_fixup_handler(e);
-	if (handler == ex_handler_fault)
-		return EX_HANDLER_FAULT;
-	else if (handler == ex_handler_uaccess || handler == ex_handler_copy)
-		return EX_HANDLER_UACCESS;
-	else
-		return EX_HANDLER_OTHER;
+	return e ? e->type : EX_TYPE_NONE;
 }
 
 int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 		    unsigned long fault_addr)
 {
 	const struct exception_table_entry *e;
-	ex_handler_t handler;
 
 #ifdef CONFIG_PNPBIOS
 	if (unlikely(SEGMENT_IS_PNP_CODE(regs->cs))) {
@@ -173,8 +129,33 @@ int fixup_exception(struct pt_regs *regs
 	if (!e)
 		return 0;
 
-	handler = ex_fixup_handler(e);
-	return handler(e, regs, trapnr, error_code, fault_addr);
+	switch (e->type) {
+	case EX_TYPE_DEFAULT:
+		return ex_handler_default(e, regs);
+	case EX_TYPE_FAULT:
+		return ex_handler_fault(e, regs, trapnr);
+	case EX_TYPE_UACCESS:
+		return ex_handler_uaccess(e, regs, trapnr);
+	case EX_TYPE_COPY:
+		return ex_handler_copy(e, regs, trapnr);
+	case EX_TYPE_CLEAR_FS:
+		return ex_handler_clear_fs(e, regs);
+	case EX_TYPE_FPU_RESTORE:
+		return ex_handler_fprestore(e, regs);
+	case EX_TYPE_RDMSR:
+		return ex_handler_rdmsr_unsafe(e, regs);
+	case EX_TYPE_WRMSR:
+		return ex_handler_wrmsr_unsafe(e, regs);
+	case EX_TYPE_BPF:
+		return ex_handler_bpf(e, regs);
+	case EX_TYPE_RDMSR_IN_MCE:
+		ex_handler_msr_mce(regs, false);
+		break;
+	case EX_TYPE_WRMSR_IN_MCE:
+		ex_handler_msr_mce(regs, true);
+		break;
+	}
+	BUG();
 }
 
 extern unsigned int early_recursion_flag;
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -827,9 +827,7 @@ static int emit_atomic(u8 **pprog, u8 at
 	return 0;
 }
 
-static bool ex_handler_bpf(const struct exception_table_entry *x,
-			   struct pt_regs *regs, int trapnr,
-			   unsigned long error_code, unsigned long fault_addr)
+bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
 {
 	u32 reg = x->fixup >> 8;
 
@@ -1313,12 +1311,7 @@ st:			if (is_imm8(insn->off))
 				}
 				ex->insn = delta;
 
-				delta = (u8 *)ex_handler_bpf - (u8 *)&ex->handler;
-				if (!is_simm32(delta)) {
-					pr_err("extable->handler doesn't fit into 32-bit\n");
-					return -EFAULT;
-				}
-				ex->handler = delta;
+				ex->type = EX_TYPE_BPF;
 
 				if (dst_reg > BPF_REG_9) {
 					pr_err("verifier error\n");
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -236,7 +236,7 @@ static void x86_sort_relative_table(char
 
 		w(r(loc) + i, loc);
 		w(r(loc + 1) + i + 4, loc + 1);
-		w(r(loc + 2) + i + 8, loc + 2);
+		/* Don't touch the fixup type */
 
 		i += sizeof(uint32_t) * 3;
 	}
@@ -249,7 +249,7 @@ static void x86_sort_relative_table(char
 
 		w(r(loc) - i, loc);
 		w(r(loc + 1) - (i + 4), loc + 1);
-		w(r(loc + 2) - (i + 8), loc + 2);
+		/* Don't touch the fixup type */
 
 		i += sizeof(uint32_t) * 3;
 	}

