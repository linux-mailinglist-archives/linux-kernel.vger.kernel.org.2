Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BBA313957
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 17:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhBHQZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 11:25:58 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:40977 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233380AbhBHPM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:12:57 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZ8bM5MSSz9vBnL;
        Mon,  8 Feb 2021 16:10:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id yShiOCm5DS7v; Mon,  8 Feb 2021 16:10:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZ8bM4Vlrz9tyNx;
        Mon,  8 Feb 2021 16:10:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E57698B7BA;
        Mon,  8 Feb 2021 16:10:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NJm3ITcA0tbc; Mon,  8 Feb 2021 16:10:28 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B00C18B7B2;
        Mon,  8 Feb 2021 16:10:28 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A72396733E; Mon,  8 Feb 2021 15:10:28 +0000 (UTC)
Message-Id: <ba073ad67bd971a88ce331b65d6655523b54c794.1612796617.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612796617.git.christophe.leroy@csgroup.eu>
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v5 09/22] powerpc/syscall: Make interrupt.c buildable on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  8 Feb 2021 15:10:28 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow building interrupt.c on PPC32, ifdef out specific PPC64
code or use helpers which are available on both PP32 and PPC64

Modify Makefile to always build interrupt.o

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v5:
- Also for interrupt exit preparation
- Opted out kuap related code, ppc32 keeps it in ASM for the time being
---
 arch/powerpc/kernel/Makefile    |  4 ++--
 arch/powerpc/kernel/interrupt.c | 31 ++++++++++++++++++++++++-------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 26ff8c6e06b7..163755b1cef4 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -57,10 +57,10 @@ obj-y				:= cputable.o syscalls.o \
 				   prom.o traps.o setup-common.o \
 				   udbg.o misc.o io.o misc_$(BITS).o \
 				   of_platform.o prom_parse.o firmware.o \
-				   hw_breakpoint_constraints.o
+				   hw_breakpoint_constraints.o interrupt.o
 obj-y				+= ptrace/
 obj-$(CONFIG_PPC64)		+= setup_64.o \
-				   paca.o nvram_64.o note.o interrupt.o
+				   paca.o nvram_64.o note.o
 obj-$(CONFIG_COMPAT)		+= sys_ppc32.o signal_32.o
 obj-$(CONFIG_VDSO32)		+= vdso32_wrapper.o
 obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index d6be4f9a67e5..2dac4d2bb1cf 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -39,7 +39,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
 		BUG_ON(!(regs->msr & MSR_RI));
 	BUG_ON(!(regs->msr & MSR_PR));
 	BUG_ON(!FULL_REGS(regs));
-	BUG_ON(regs->softe != IRQS_ENABLED);
+	BUG_ON(arch_irq_disabled_regs(regs));
 
 #ifdef CONFIG_PPC_PKEY
 	if (mmu_has_feature(MMU_FTR_PKEY)) {
@@ -65,7 +65,9 @@ notrace long system_call_exception(long r3, long r4, long r5,
 			isync();
 	} else
 #endif
+#ifdef CONFIG_PPC64
 		kuap_check_amr();
+#endif
 
 	account_cpu_user_entry();
 
@@ -77,7 +79,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
 	 * frame, or if the unwinder was taught the first stack frame always
 	 * returns to user with IRQS_ENABLED, this store could be avoided!
 	 */
-	regs->softe = IRQS_ENABLED;
+	irq_soft_mask_regs_set_state(regs, IRQS_ENABLED);
 
 	local_irq_enable();
 
@@ -151,6 +153,7 @@ static notrace inline bool __prep_irq_for_enabled_exit(bool clear_ri)
 		__hard_EE_RI_disable();
 	else
 		__hard_irq_disable();
+#ifdef CONFIG_PPC64
 	if (unlikely(lazy_irq_pending_nocheck())) {
 		/* Took an interrupt, may have more exit work to do. */
 		if (clear_ri)
@@ -162,7 +165,7 @@ static notrace inline bool __prep_irq_for_enabled_exit(bool clear_ri)
 	}
 	local_paca->irq_happened = 0;
 	irq_soft_mask_set(IRQS_ENABLED);
-
+#endif
 	return true;
 }
 
@@ -216,7 +219,9 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 
 	CT_WARN_ON(ct_state() == CONTEXT_USER);
 
+#ifdef CONFIG_PPC64
 	kuap_check_amr();
+#endif
 
 	regs->result = r3;
 
@@ -309,7 +314,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 
 	account_cpu_user_exit();
 
-#ifdef CONFIG_PPC_BOOK3S /* BOOK3E not yet using this */
+#ifdef CONFIG_PPC_BOOK3S_64 /* BOOK3E and ppc32 not using this */
 	/*
 	 * We do this at the end so that we do context switch with KERNEL AMR
 	 */
@@ -318,7 +323,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 	return ret;
 }
 
-#ifdef CONFIG_PPC_BOOK3S /* BOOK3E not yet using this */
+#ifndef CONFIG_PPC_BOOK3E_64 /* BOOK3E not yet using this */
 notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs, unsigned long msr)
 {
 #ifdef CONFIG_PPC_BOOK3E
@@ -333,14 +338,16 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs, unsigned
 		BUG_ON(!(regs->msr & MSR_RI));
 	BUG_ON(!(regs->msr & MSR_PR));
 	BUG_ON(!FULL_REGS(regs));
-	BUG_ON(regs->softe != IRQS_ENABLED);
+	BUG_ON(arch_irq_disabled_regs(regs));
 	CT_WARN_ON(ct_state() == CONTEXT_USER);
 
 	/*
 	 * We don't need to restore AMR on the way back to userspace for KUAP.
 	 * AMR can only have been unlocked if we interrupted the kernel.
 	 */
+#ifdef CONFIG_PPC64
 	kuap_check_amr();
+#endif
 
 	local_irq_save(flags);
 
@@ -407,7 +414,9 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs, unsigned
 	/*
 	 * We do this at the end so that we do context switch with KERNEL AMR
 	 */
+#ifdef CONFIG_PPC64
 	kuap_user_restore(regs);
+#endif
 	return ret;
 }
 
@@ -419,7 +428,9 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 	unsigned long *ti_flagsp = &current_thread_info()->flags;
 	unsigned long flags;
 	unsigned long ret = 0;
+#ifdef CONFIG_PPC64
 	unsigned long amr;
+#endif
 
 	if (IS_ENABLED(CONFIG_PPC_BOOK3S) && unlikely(!(regs->msr & MSR_RI)))
 		unrecoverable_exception(regs);
@@ -432,7 +443,9 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 	if (TRAP(regs) != 0x700)
 		CT_WARN_ON(ct_state() == CONTEXT_USER);
 
+#ifdef CONFIG_PPC64
 	amr = kuap_get_and_check_amr();
+#endif
 
 	if (unlikely(*ti_flagsp & _TIF_EMULATE_STACK_STORE)) {
 		clear_bits(_TIF_EMULATE_STACK_STORE, ti_flagsp);
@@ -441,7 +454,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 
 	local_irq_save(flags);
 
-	if (regs->softe == IRQS_ENABLED) {
+	if (!arch_irq_disabled_regs(regs)) {
 		/* Returning to a kernel context with local irqs enabled. */
 		WARN_ON_ONCE(!(regs->msr & MSR_EE));
 again:
@@ -458,8 +471,10 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 	} else {
 		/* Returning to a kernel context with local irqs disabled. */
 		__hard_EE_RI_disable();
+#ifdef CONFIG_PPC64
 		if (regs->msr & MSR_EE)
 			local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
+#endif
 	}
 
 
@@ -472,7 +487,9 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 	 * which would cause Read-After-Write stalls. Hence, we take the AMR
 	 * value from the check above.
 	 */
+#ifdef CONFIG_PPC64
 	kuap_kernel_restore(regs, amr);
+#endif
 
 	return ret;
 }
-- 
2.25.0

