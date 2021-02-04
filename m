Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418793101F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhBEBAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 20:00:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44128 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbhBEA6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:58:40 -0500
Message-Id: <20210204211154.806028730@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612486677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=W4FWqg5l8XQNkOJWuZA3ZlZ+0A4CxLT3tc6YxuaczMY=;
        b=1gLtu6Dx30oHwryoNRwY3H0WTtyg5SSmFVKT8mxIGTY3NVuogGqyVjl+4RhcPp7IsGBtDt
        xToeHHsI9y3VFKEUsCSqF222REgP/eq769B8gT6YVx6xHFO/Ggx7StJUDjhw6kRr6VfMYn
        Xoh7f822MCFX97Syavf66WXJ8D6YMgvwoX7fNRX+NktBCYR28YkiFjcGMnpiO+f1SHHky4
        Wac9DBDZLrD2TA5ayR2eNYlxgg8lFvRnp1ru99plvA354rriewUW2CaMowJuTFygOMw/Fy
        /yaqF+PF+gRHtzD2xGjoB6Oj5zfVet9cgiH1m1kea+PToSpZf9p86ERJ0MteIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612486677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=W4FWqg5l8XQNkOJWuZA3ZlZ+0A4CxLT3tc6YxuaczMY=;
        b=dFg8PWGjjB+166b6iER1DbTs4kD5FDmMjyT6HEXJuuFzmolTuUqlY3lVcxz4GebGKbDjUU
        xbAiDb4daZOCVzBw==
Date:   Thu, 04 Feb 2021 21:49:10 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 07/12] x86/entry: Convert device interrupts to inline stack switching
References: <20210204204903.350275743@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert device interrupts to inline stack switching by replacing the
existing macro implementation with the new inline version. Tweak the
function signature of the actual handler function to have the vector
argument as u32. That allows the inline macro to avoid extra intermediates
and lets the compiler be smarter about the whole thing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
@@ -168,14 +168,35 @@
 			      SYSVEC_CONSTRAINTS, regs);		\
 }
 
+/*
+ * As in ASM_CALL_SYSVEC above the clobbers force the compiler to store
+ * @regs and @vector in callee saved registers.
+ */
+#define ASM_CALL_IRQ							\
+	"call irq_enter_rcu				\n"		\
+	"movq	%[__arg1], %%rdi			\n"		\
+	"movl	%[__arg2], %%esi			\n"		\
+	"call %P[__func]				\n"		\
+	"call irq_exit_rcu				\n"
+
+#define IRQ_CONSTRAINTS	, [__arg1] "r" (regs), [__arg2] "r" (vector)
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
@@ -186,17 +207,6 @@ static __always_inline void __run_on_irq
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
@@ -207,10 +217,16 @@ static __always_inline void
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
@@ -234,16 +250,4 @@ static __always_inline void run_on_irqst
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

