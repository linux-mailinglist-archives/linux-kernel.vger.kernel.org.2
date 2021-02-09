Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7295315CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbhBJCHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:07:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55268 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbhBJAyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:54:17 -0500
Message-Id: <20210210002512.769728139@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612918414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3UfL5KeYCARcyGb1Kcgjsy38urtkLcOEXNW98dMMqkg=;
        b=KtY3kMI89y5KWkkXIRL/jj0A7zTBo5mI4fw6O7uCu/doeklq3+Yco28dbPjaGCxP31O+mc
        7LpUoH19Zp+fe7ACw+8xE2Yo/2YEjYdAfk3Ght54rLcbwdaB3OfSll8SJV17V7Yrta3jad
        Qei/4t9cjGmBnujFsWJpAXE4vhqyv5xYs6rIF/cSRSvixwo4UM9uG4FVE8PumqVbbnH7MC
        HjqhVmoesKyAhefbVdFA/S4dn0TBKT3pEEk/4LvAWtgyMRtfNdeuk6iKEkA8hxW57gx77x
        u0Nti67vTcjjSiOYJK/HA2nzCjvQVVDYvnv9kw12bci7NGKBjTIek4fbbPBOeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612918414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3UfL5KeYCARcyGb1Kcgjsy38urtkLcOEXNW98dMMqkg=;
        b=y9A3+lK1IVVjVsN85uejAJRAX4G6WmKevg57W49gOc8cZFbPbwyqNAzj2YoxrEI2TR8JEz
        /Ak6LG/rWEEnZ1Dw==
Date:   Wed, 10 Feb 2021 00:40:48 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Subject: [patch V2 07/13] x86/entry: Convert device interrupts to inline stack
 switching
References: <20210209234041.127454039@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Convert device interrupts to inline stack switching by replacing the
existing macro implementation with the new inline version. Tweak the
function signature of the actual handler function to have the vector
argument as u32. That allows the inline macro to avoid extra intermediates
and lets the compiler be smarter about the whole thing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>

---
 arch/x86/entry/entry_64.S        |    1 
 arch/x86/include/asm/idtentry.h  |    9 ++----
 arch/x86/include/asm/irq_stack.h |   58 ++++++++++++++++++++-------------------
 arch/x86/kernel/irq.c            |    2 -
 4 files changed, 36 insertions(+), 34 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -762,7 +762,6 @@ SYM_CODE_END(.Lbad_gs)
  * rdx: Function argument (can be NULL if none)
  */
 SYM_FUNC_START(asm_call_on_stack)
-SYM_INNER_LABEL(asm_call_irq_on_stack, SYM_L_GLOBAL)
 	/*
 	 * Save the frame pointer unconditionally. This allows the ORC
 	 * unwinder to handle the stack switch.
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -187,23 +187,22 @@ static __always_inline void __##func(str
  * has to be done in the function body if necessary.
  */
 #define DEFINE_IDTENTRY_IRQ(func)					\
-static __always_inline void __##func(struct pt_regs *regs, u8 vector);	\
+static void __##func(struct pt_regs *regs, u32 vector);			\
 									\
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
 	irqentry_state_t state = irqentry_enter(regs);			\
+	u32 vector = (u32)(u8)error_code;				\
 									\
 	instrumentation_begin();					\
-	irq_enter_rcu();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
-	__##func (regs, (u8)error_code);				\
-	irq_exit_rcu();							\
+	run_irq_on_irqstack_cond(__##func, regs, vector);		\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
 }									\
 									\
-static __always_inline void __##func(struct pt_regs *regs, u8 vector)
+static noinline void __##func(struct pt_regs *regs, u32 vector)
 
 /**
  * DECLARE_IDTENTRY_SYSVEC - Declare functions for system vector entry points
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -162,14 +162,35 @@
 			      SYSVEC_CONSTRAINTS, regs);		\
 }
 
+/*
+ * As in ASM_CALL_SYSVEC above the clobbers force the compiler to store
+ * @regs and @vector in callee saved registers.
+ */
+#define ASM_CALL_IRQ							\
+	"call irq_enter_rcu				\n"		\
+	"movq	%[arg1], %%rdi				\n"		\
+	"movl	%[arg2], %%esi				\n"		\
+	"call %P[__func]				\n"		\
+	"call irq_exit_rcu				\n"
+
+#define IRQ_CONSTRAINTS	, [arg1] "r" (regs), [arg2] "r" (vector)
+
+#define run_irq_on_irqstack_cond(func, regs, vector)			\
+{									\
+	assert_function_type(func, void (*)(struct pt_regs *, u32));	\
+	assert_arg_type(regs, struct pt_regs *);			\
+	assert_arg_type(vector, u32);					\
+									\
+	call_on_irqstack_cond(func, regs, ASM_CALL_IRQ,			\
+			      IRQ_CONSTRAINTS, regs, vector);		\
+}
+
 static __always_inline bool irqstack_active(void)
 {
 	return __this_cpu_read(hardirq_stack_inuse);
 }
 
 void asm_call_on_stack(void *sp, void (*func)(void), void *arg);
-void asm_call_irq_on_stack(void *sp, void (*func)(struct irq_desc *desc),
-			   struct irq_desc *desc);
 
 static __always_inline void __run_on_irqstack(void (*func)(void))
 {
@@ -180,17 +201,6 @@ static __always_inline void __run_on_irq
 	__this_cpu_write(hardirq_stack_inuse, false);
 }
 
-static __always_inline void
-__run_irq_on_irqstack(void (*func)(struct irq_desc *desc),
-		      struct irq_desc *desc)
-{
-	void *tos = __this_cpu_read(hardirq_stack_ptr);
-
-	__this_cpu_write(hardirq_stack_inuse, true);
-	asm_call_irq_on_stack(tos, func, desc);
-	__this_cpu_write(hardirq_stack_inuse, false);
-}
-
 #else /* CONFIG_X86_64 */
 
 /* System vector handlers always run on the stack they interrupted. */
@@ -201,10 +211,16 @@ static __always_inline void
 	irq_exit_rcu();							\
 }
 
+/* Switches to the irq stack within func() */
+#define run_irq_on_irqstack_cond(func, regs, vector)			\
+{									\
+	irq_enter_rcu();						\
+	func(regs, vector);						\
+	irq_exit_rcu();							\
+}
+
 static inline bool irqstack_active(void) { return false; }
 static inline void __run_on_irqstack(void (*func)(void)) { }
-static inline void __run_irq_on_irqstack(void (*func)(struct irq_desc *desc),
-					 struct irq_desc *desc) { }
 #endif /* !CONFIG_X86_64 */
 
 static __always_inline bool irq_needs_irq_stack(struct pt_regs *regs)
@@ -228,16 +244,4 @@ static __always_inline void run_on_irqst
 		func();
 }
 
-static __always_inline void
-run_irq_on_irqstack_cond(void (*func)(struct irq_desc *desc), struct irq_desc *desc,
-			 struct pt_regs *regs)
-{
-	lockdep_assert_irqs_disabled();
-
-	if (irq_needs_irq_stack(regs))
-		__run_irq_on_irqstack(func, desc);
-	else
-		func(desc);
-}
-
 #endif
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -227,7 +227,7 @@ static __always_inline void handle_irq(s
 				       struct pt_regs *regs)
 {
 	if (IS_ENABLED(CONFIG_X86_64))
-		run_irq_on_irqstack_cond(desc->handle_irq, desc, regs);
+		generic_handle_irq_desc(desc);
 	else
 		__handle_irq(desc, regs);
 }

