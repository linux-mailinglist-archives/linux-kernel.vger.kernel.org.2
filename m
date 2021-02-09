Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8EE315CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhBJCIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:08:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55320 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbhBJAyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:54:19 -0500
Message-Id: <20210210002512.972714001@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612918416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=yYOyT1XbJecONWmUfOAoCgrTpWtuCwgNtJCTdnPbsy4=;
        b=N2DnTaIgBUCGZUg9mtGNKKQM3nExe2ZORurb9HSlZLV521nbJLVkV9Lu1BXKa17PILpG0C
        NJTWBp8r9LVMIpilZRuYGF4spj4PdheaQv1YRYHsOpdhCFHrkGfa1E+C15fU1mbwkM4TKR
        /kijKww89n5eT8imnZkzrJNGugKx/8ti73U0RBr5T3JGg+OETdosEuKhEONkXPPO6iNdv3
        hVPJi1XLXls+0xkwQZxMw0Ha6UWl+Qn2ygm57L6hhMrTSr9EOfpUBNMzF7kRlscoC8yEtl
        T+MNuimpDUXZ1AtuKkLGM4QlpJD8hphrw4+vuKz4DeImFyszOpbc4xXc7ovTdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612918416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=yYOyT1XbJecONWmUfOAoCgrTpWtuCwgNtJCTdnPbsy4=;
        b=Xu24ZD1zOxUniOz0MdXZSCLyXTi6s+T6UGOm4Tr8yOuAItt4VMUiX5FY57f9cqEvivMvFx
        Tg0cyXlEutk3sxAg==
Date:   Wed, 10 Feb 2021 00:40:50 +0100
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
Subject: [patch V2 09/13] x86/softirq: Remove indirection in do_softirq_own_stack()
References: <20210209234041.127454039@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Use the new inline stack switching and remove the old ASM indirect call
implementation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>

---
 arch/x86/entry/entry_64.S        |   39 -----------------------------
 arch/x86/include/asm/irq_stack.h |   52 ++++++++++++---------------------------
 arch/x86/kernel/irq_64.c         |    2 -
 3 files changed, 17 insertions(+), 76 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -756,45 +756,6 @@ SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
 SYM_CODE_END(.Lbad_gs)
 	.previous
 
-/*
- * rdi: New stack pointer points to the top word of the stack
- * rsi: Function pointer
- * rdx: Function argument (can be NULL if none)
- */
-SYM_FUNC_START(asm_call_on_stack)
-	/*
-	 * Save the frame pointer unconditionally. This allows the ORC
-	 * unwinder to handle the stack switch.
-	 */
-	pushq		%rbp
-	mov		%rsp, %rbp
-
-	/*
-	 * The unwinder relies on the word at the top of the new stack
-	 * page linking back to the previous RSP.
-	 */
-	mov		%rsp, (%rdi)
-	mov		%rdi, %rsp
-	/* Move the argument to the right place */
-	mov		%rdx, %rdi
-
-1:
-	.pushsection .discard.instr_begin
-	.long 1b - .
-	.popsection
-
-	CALL_NOSPEC	rsi
-
-2:
-	.pushsection .discard.instr_end
-	.long 2b - .
-	.popsection
-
-	/* Restore the previous stack pointer from RBP. */
-	leaveq
-	ret
-SYM_FUNC_END(asm_call_on_stack)
-
 #ifdef CONFIG_XEN_PV
 /*
  * A note on the "critical region" in our callback handler.
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -185,20 +185,23 @@
 			      IRQ_CONSTRAINTS, regs, vector);		\
 }
 
-static __always_inline bool irqstack_active(void)
-{
-	return __this_cpu_read(hardirq_stack_inuse);
-}
-
-void asm_call_on_stack(void *sp, void (*func)(void), void *arg);
+#define ASM_CALL_SOFTIRQ						\
+	"call %P[__func]				\n"
 
-static __always_inline void __run_on_irqstack(void (*func)(void))
-{
-	void *tos = __this_cpu_read(hardirq_stack_ptr);
-
-	__this_cpu_write(hardirq_stack_inuse, true);
-	asm_call_on_stack(tos, func, NULL);
-	__this_cpu_write(hardirq_stack_inuse, false);
+/*
+ * Macro to invoke __do_softirq on the irq stack. Contrary to the above
+ * the only check which is necessary is whether the interrupt stack is
+ * in use already.
+ */
+#define run_softirq_on_irqstack_cond()					\
+{									\
+	if (__this_cpu_read(hardirq_stack_inuse)) {			\
+		__do_softirq();						\
+	} else {							\
+		__this_cpu_write(hardirq_stack_inuse, true);		\
+		call_on_irqstack(__do_softirq, ASM_CALL_SOFTIRQ);	\
+		__this_cpu_write(hardirq_stack_inuse, false);		\
+	}								\
 }
 
 #else /* CONFIG_X86_64 */
@@ -219,29 +222,6 @@ static __always_inline void __run_on_irq
 	irq_exit_rcu();							\
 }
 
-static inline bool irqstack_active(void) { return false; }
-static inline void __run_on_irqstack(void (*func)(void)) { }
 #endif /* !CONFIG_X86_64 */
 
-static __always_inline bool irq_needs_irq_stack(struct pt_regs *regs)
-{
-	if (IS_ENABLED(CONFIG_X86_32))
-		return false;
-	if (!regs)
-		return !irqstack_active();
-	return !user_mode(regs) && !irqstack_active();
-}
-
-
-static __always_inline void run_on_irqstack_cond(void (*func)(void),
-						 struct pt_regs *regs)
-{
-	lockdep_assert_irqs_disabled();
-
-	if (irq_needs_irq_stack(regs))
-		__run_on_irqstack(func);
-	else
-		func();
-}
-
 #endif
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -76,5 +76,5 @@ int irq_init_percpu_irqstack(unsigned in
 
 void do_softirq_own_stack(void)
 {
-	run_on_irqstack_cond(__do_softirq, NULL);
+	run_softirq_on_irqstack_cond();
 }

