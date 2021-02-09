Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F247A315CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbhBJCLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbhBJAz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:55:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42285C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 16:53:35 -0800 (PST)
Message-Id: <20210210002512.676197354@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612918413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Mw4RVInBYOVJHdSt2MKQ4pRncA8pi9Pk9SurfYN3RFA=;
        b=tr2iVncIQ77tHNc06+tPIa4GF2Y5Pr9+yIxyNn3VSREvncxC50PuyIOIwkyax1BcYohPt/
        5cW2ZEuPWb3LBR+DiMljHOG/1lJh5I0YsuHVlW/XRzJr/PAhPlEssysBNzBtv6n/5gM9Py
        1YL7fx8+kCmEBr4rkvfJX1ZcZeeOAB2w18hF8F3N3Q2MMgcpbiY4w8+Yhw/7Iuth2gES2K
        QYYslMZIqVq21h0MFJyza83yRwqsdGuU3fTALDtrUhCki/Ylkdv4CSZWbZqCruII5nDonY
        0EG6XI/mC1ANrLk5M3Kj6phxnmMccPUD+ZeTlVxcohwXGimmhPZPXmiELzj80w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612918413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Mw4RVInBYOVJHdSt2MKQ4pRncA8pi9Pk9SurfYN3RFA=;
        b=SXmV3nShPaI3mXJQTcqG0wj3ATj+/79OYUipu2v4SMWaBVUQeNSPzFXP4+HDSFRBYLQUbR
        CeeqwDxByat+09Bw==
Date:   Wed, 10 Feb 2021 00:40:47 +0100
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
Subject: [patch V2 06/13] x86/entry: Convert system vectors to irq stack macro
References: <20210209234041.127454039@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

To inline the stack switching and to prepare for enabling
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK provide a macro template for system
vectors and device interrupts and convert the system vectors over to it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
V2: Adopt to underscore removal
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
@@ -105,14 +105,69 @@
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
+		call_on_irqstack(func, asm_call, constr);		\
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
+	"movq	%[arg1], %%rdi				\n"		\
+	"call %P[__func]				\n"		\
+	"call irq_exit_rcu				\n"
+
+#define SYSVEC_CONSTRAINTS	, [arg1] "r" (regs)
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
 
@@ -126,17 +181,6 @@ static __always_inline void __run_on_irq
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
@@ -148,10 +192,17 @@ static __always_inline void
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
@@ -178,18 +229,6 @@ static __always_inline void run_on_irqst
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

