Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8E13101F3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhBEA7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:59:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44124 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbhBEA6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:58:38 -0500
Message-Id: <20210204211154.713523041@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612486676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4VJeWyJpe77kXVPW+/iyQrnaQZ3oZEO8LSpWVIR4vPY=;
        b=RSTFK4iN26NJXstT7ZwnKYXp0DF4LQRltWXEsHqFuObQdfikG2ekIzXkj0Kd3asiUdkYq2
        A9YsWFNRyhgI1ebk4bbe81LV7C+XEoiedTANNDSCfN6QiWF1BPrZtanh+2fgJGbWWpHFU7
        hJPnIn+8d3cOiFxfOEhmf/Fpbp2aVqsQo2Tw1Wt09VSnlFvohL25NB4WDN6N1ZfnSsMVLo
        unzKLG6lv7AdZKsoKJ6obE2luDDx4FnpbFM1zJfyeBQn5artkq2rAL8hILm88lkS+TJiMj
        MGWEsZPhT0ahglpgw7SY7nVxMCXaxEGW1g235UtKD0wde3V14M0AFxMhJqSTVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612486676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4VJeWyJpe77kXVPW+/iyQrnaQZ3oZEO8LSpWVIR4vPY=;
        b=L8d6aSoqotDeqN07D/6+v8PDlNsEucKPx8RShucaFX6LPz9QihJfbhuETOaXnClCQsZT1+
        LNY1NzPIemNmzDAg==
Date:   Thu, 04 Feb 2021 21:49:09 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 06/12] x86/entry: Convert system vectors to irq stack macro
References: <20210204204903.350275743@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To inline the stack switching and to prepare for enabling
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK provide a macro template for system
vectors and device interrupts and convert the system vectors over to it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S        |    1 
 arch/x86/include/asm/idtentry.h  |    2 
 arch/x86/include/asm/irq_stack.h |   93 +++++++++++++++++++++++++++------------
 3 files changed, 66 insertions(+), 30 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -762,7 +762,6 @@ SYM_CODE_END(.Lbad_gs)
  * rdx: Function argument (can be NULL if none)
  */
 SYM_FUNC_START(asm_call_on_stack)
-SYM_INNER_LABEL(asm_call_sysvec_on_stack, SYM_L_GLOBAL)
 SYM_INNER_LABEL(asm_call_irq_on_stack, SYM_L_GLOBAL)
 	/*
 	 * Save the frame pointer unconditionally. This allows the ORC
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -237,10 +237,8 @@ static void __##func(struct pt_regs *reg
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
-	irq_enter_rcu();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_sysvec_on_irqstack_cond(__##func, regs);			\
-	irq_exit_rcu();							\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
 }									\
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -111,14 +111,69 @@
 #define assert_arg_type(arg, proto)					\
 	static_assert(__builtin_types_compatible_p(typeof(arg), proto))
 
+/*
+ * Macro to invoke system vector and device interrupt C handlers.
+ */
+#define call_on_irqstack_cond(func, regs, asm_call, constr, c_args...)	\
+{									\
+	/*								\
+	 * User mode entry and interrupt on the irq stack do not	\
+	 * switch stacks. If from user mode the task stack is empty.	\
+	 */								\
+	if (user_mode(regs) || __this_cpu_read(hardirq_stack_inuse)) {	\
+		irq_enter_rcu();					\
+		func(c_args);						\
+		irq_exit_rcu();						\
+	} else {							\
+		/*							\
+		 * Mark the irq stack inuse _before_ and unmark _after_	\
+		 * switching stacks. Interrupts are disabled in both	\
+		 * places. Invoke the stack switch macro with the call	\
+		 * sequence which matches the above direct invocation.	\
+		 */							\
+		__this_cpu_write(hardirq_stack_inuse, true);		\
+		__call_on_irqstack(func, asm_call, constr);		\
+		__this_cpu_write(hardirq_stack_inuse, false);		\
+	}								\
+}
+
+/*
+ * Function call sequence for __call_on_irqstack() for system vectors.
+ *
+ * Note that irq_enter_rcu() and irq_exit_rcu() do not use the input
+ * mechanism because these functions are global and cannot be optimized out
+ * when compiling a particular source file which uses one of these macros.
+ *
+ * The argument (regs) does not need to be pushed or stashed in a callee
+ * saved register to be safe vs. the irq_enter_rcu() call because the
+ * clobbers already prevent the compiler from storing it in a callee
+ * clobbered register. As the compiler has to preserve @regs for the final
+ * call to idtentry_exit() anyway, it's likely that it does not cause extra
+ * effort for this asm magic.
+ */
+#define ASM_CALL_SYSVEC							\
+	"call irq_enter_rcu				\n"		\
+	"movq	%[__arg1], %%rdi			\n"		\
+	"call %P[__func]				\n"		\
+	"call irq_exit_rcu				\n"
+
+#define SYSVEC_CONSTRAINTS	, [__arg1] "r" (regs)
+
+#define run_sysvec_on_irqstack_cond(func, regs)				\
+{									\
+	assert_function_type(func, void (*)(struct pt_regs *));		\
+	assert_arg_type(regs, struct pt_regs *);			\
+									\
+	call_on_irqstack_cond(func, regs, ASM_CALL_SYSVEC,		\
+			      SYSVEC_CONSTRAINTS, regs);		\
+}
+
 static __always_inline bool irqstack_active(void)
 {
 	return __this_cpu_read(hardirq_stack_inuse);
 }
 
 void asm_call_on_stack(void *sp, void (*func)(void), void *arg);
-void asm_call_sysvec_on_stack(void *sp, void (*func)(struct pt_regs *regs),
-			      struct pt_regs *regs);
 void asm_call_irq_on_stack(void *sp, void (*func)(struct irq_desc *desc),
 			   struct irq_desc *desc);
 
@@ -132,17 +187,6 @@ static __always_inline void __run_on_irq
 }
 
 static __always_inline void
-__run_sysvec_on_irqstack(void (*func)(struct pt_regs *regs),
-			 struct pt_regs *regs)
-{
-	void *tos = __this_cpu_read(hardirq_stack_ptr);
-
-	__this_cpu_write(hardirq_stack_inuse, true);
-	asm_call_sysvec_on_stack(tos, func, regs);
-	__this_cpu_write(hardirq_stack_inuse, false);
-}
-
-static __always_inline void
 __run_irq_on_irqstack(void (*func)(struct irq_desc *desc),
 		      struct irq_desc *desc)
 {
@@ -154,10 +198,17 @@ static __always_inline void
 }
 
 #else /* CONFIG_X86_64 */
+
+/* System vector handlers always run on the stack they interrupted. */
+#define run_sysvec_on_irqstack_cond(func, regs)				\
+{									\
+	irq_enter_rcu();						\
+	func(regs);							\
+	irq_exit_rcu();							\
+}
+
 static inline bool irqstack_active(void) { return false; }
 static inline void __run_on_irqstack(void (*func)(void)) { }
-static inline void __run_sysvec_on_irqstack(void (*func)(struct pt_regs *regs),
-					    struct pt_regs *regs) { }
 static inline void __run_irq_on_irqstack(void (*func)(struct irq_desc *desc),
 					 struct irq_desc *desc) { }
 #endif /* !CONFIG_X86_64 */
@@ -184,18 +235,6 @@ static __always_inline void run_on_irqst
 }
 
 static __always_inline void
-run_sysvec_on_irqstack_cond(void (*func)(struct pt_regs *regs),
-			    struct pt_regs *regs)
-{
-	lockdep_assert_irqs_disabled();
-
-	if (irq_needs_irq_stack(regs))
-		__run_sysvec_on_irqstack(func, regs);
-	else
-		func(regs);
-}
-
-static __always_inline void
 run_irq_on_irqstack_cond(void (*func)(struct irq_desc *desc), struct irq_desc *desc,
 			 struct pt_regs *regs)
 {

