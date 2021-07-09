Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6571B3C202F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 09:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhGIHvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 03:51:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:18015 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231344AbhGIHvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 03:51:39 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GLlfF5f51zB9Bx;
        Fri,  9 Jul 2021 09:48:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JKbD5W_8RL1R; Fri,  9 Jul 2021 09:48:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GLlfF4nlDzB959;
        Fri,  9 Jul 2021 09:48:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 97E2C8B808;
        Fri,  9 Jul 2021 09:48:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Jiz2jmNOe1CP; Fri,  9 Jul 2021 09:48:53 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 64EA78B76A;
        Fri,  9 Jul 2021 09:48:53 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 60C0566400; Fri,  9 Jul 2021 07:48:53 +0000 (UTC)
Message-Id: <37dd7289fc63ef7decdec43ee74fb242d1ac6571.1625816918.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 1/2] powerpc/32s: Do kuep_lock() and kuep_unlock() in assembly
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  9 Jul 2021 07:48:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When interrupt and syscall entries where converted to C, KUEP locking
and unlocking was also converted. It improved performance by unrolling
the loop, and allowed easily implementing boot time deactivation of
KUEP.

However, null_syscall selftest shows that KUEP is still heavy
(361 cycles with KUEP, 210 cycles without).

A way to improve more is to group 'mtsr's together, instead of
repeating 'addi' + 'mtsr' several times.

In order to do that, more registers need to be available. In C, GCC
will always be able to provide the requested number of registers, but
at the cost of saving some data on the stack, which is counter
performant here.

So let's do it in assembly, when we have full control of which
register can be used. It also has the advantage of locking earlier
and unlocking later and it helps GCC generating less tricky code.
The only drawback is to make boot time deactivation less straight
forward and require 'hand' instruction patching.

In syscall entry, there are only 4 registers availables, so
group 'mtsr's by 4.

In interrupt entry, syscall exit and interrupt exist, we can group
by 6, which means 2 groups for a typical config with 12 user segments.

With this change, null_syscall selftest reports 334 cycles. Without
the change it was 361 cycles, that's an 7% reduction.

For the time being, capability to deactive at boot time is disabled.
It will be re-enabled in following patch.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/kup.h      | 16 ---
 arch/powerpc/include/asm/book3s/32/mmu-hash.h | 98 ++++++++++++++++++-
 arch/powerpc/include/asm/interrupt.h          |  6 +-
 arch/powerpc/include/asm/kup.h                |  5 -
 arch/powerpc/kernel/entry_32.S                | 26 +++++
 arch/powerpc/kernel/head_32.h                 |  2 +
 arch/powerpc/kernel/interrupt.c               |  3 -
 arch/powerpc/mm/book3s32/kuep.c               |  7 +-
 8 files changed, 133 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 64201125a287..2e0e87cf7d7a 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -22,22 +22,6 @@ static __always_inline bool kuep_is_disabled(void)
 	return !IS_ENABLED(CONFIG_PPC_KUEP) || static_branch_unlikely(&disable_kuep_key);
 }
 
-static inline void kuep_lock(void)
-{
-	if (kuep_is_disabled())
-		return;
-
-	update_user_segments(mfsr(0) | SR_NX);
-}
-
-static inline void kuep_unlock(void)
-{
-	if (kuep_is_disabled())
-		return;
-
-	update_user_segments(mfsr(0) & ~SR_NX);
-}
-
 #ifdef CONFIG_PPC_KUAP
 
 #include <linux/sched.h>
diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index f5be185cbdf8..e6c90802de03 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -64,7 +64,103 @@ struct ppc_bat {
 #define SR_KP	0x20000000	/* User key */
 #define SR_KS	0x40000000	/* Supervisor key */
 
-#ifndef __ASSEMBLY__
+#ifdef __ASSEMBLY__
+
+#include <asm/asm-offsets.h>
+
+.macro uus_addi sr reg1 reg2 imm
+	.if NUM_USER_SEGMENTS > \sr
+	addi	\reg1,\reg2,\imm
+	.endif
+.endm
+
+.macro uus_mtsr sr reg1
+	.if NUM_USER_SEGMENTS > \sr
+	mtsr	\sr, \reg1
+	.endif
+.endm
+
+.macro update_user_segments_by_4 tmp1 tmp2 tmp3 tmp4
+	uus_addi	1, \tmp2, \tmp1, 0x111
+	uus_addi	2, \tmp3, \tmp1, 0x222
+	uus_addi	3, \tmp4, \tmp1, 0x333
+
+	uus_mtsr	0, \tmp1
+	uus_mtsr	1, \tmp2
+	uus_mtsr	2, \tmp3
+	uus_mtsr	3, \tmp4
+
+	uus_addi	4, \tmp1, \tmp1, 0x444
+	uus_addi	5, \tmp2, \tmp2, 0x444
+	uus_addi	6, \tmp3, \tmp3, 0x444
+	uus_addi	7, \tmp4, \tmp4, 0x444
+
+	uus_mtsr	4, \tmp1
+	uus_mtsr	5, \tmp2
+	uus_mtsr	6, \tmp3
+	uus_mtsr	7, \tmp4
+
+	uus_addi	8, \tmp1, \tmp1, 0x444
+	uus_addi	9, \tmp2, \tmp2, 0x444
+	uus_addi	10, \tmp3, \tmp3, 0x444
+	uus_addi	11, \tmp4, \tmp4, 0x444
+
+	uus_mtsr	8, \tmp1
+	uus_mtsr	9, \tmp2
+	uus_mtsr	10, \tmp3
+	uus_mtsr	11, \tmp4
+
+	uus_addi	12, \tmp1, \tmp1, 0x444
+	uus_addi	13, \tmp2, \tmp2, 0x444
+	uus_addi	14, \tmp3, \tmp3, 0x444
+	uus_addi	15, \tmp4, \tmp4, 0x444
+
+	uus_mtsr	12, \tmp1
+	uus_mtsr	13, \tmp2
+	uus_mtsr	14, \tmp3
+	uus_mtsr	15, \tmp4
+.endm
+
+.macro update_user_segments_by_6 tmp1 tmp2 tmp3 tmp4 tmp5 tmp6
+	uus_addi	1, \tmp2, \tmp1, 0x111
+	uus_addi	2, \tmp3, \tmp1, 0x222
+	uus_addi	3, \tmp4, \tmp1, 0x333
+	uus_addi	4, \tmp5, \tmp1, 0x444
+	uus_addi	5, \tmp6, \tmp1, 0x555
+
+	uus_mtsr	0, \tmp1
+	uus_mtsr	1, \tmp2
+	uus_mtsr	2, \tmp3
+	uus_mtsr	3, \tmp4
+	uus_mtsr	4, \tmp5
+	uus_mtsr	5, \tmp6
+
+	uus_addi	6, \tmp1, \tmp1, 0x666
+	uus_addi	7, \tmp2, \tmp2, 0x666
+	uus_addi	8, \tmp3, \tmp3, 0x666
+	uus_addi	9, \tmp4, \tmp4, 0x666
+	uus_addi	10, \tmp5, \tmp5, 0x666
+	uus_addi	11, \tmp6, \tmp6, 0x666
+
+	uus_mtsr	6, \tmp1
+	uus_mtsr	7, \tmp2
+	uus_mtsr	8, \tmp3
+	uus_mtsr	9, \tmp4
+	uus_mtsr	10, \tmp5
+	uus_mtsr	11, \tmp6
+
+	uus_addi	12, \tmp1, \tmp1, 0x666
+	uus_addi	13, \tmp2, \tmp2, 0x666
+	uus_addi	14, \tmp3, \tmp3, 0x666
+	uus_addi	15, \tmp4, \tmp4, 0x666
+
+	uus_mtsr	12, \tmp1
+	uus_mtsr	13, \tmp2
+	uus_mtsr	14, \tmp3
+	uus_mtsr	15, \tmp4
+.endm
+
+#else
 
 /*
  * This macro defines the mapping from contexts to VSIDs (virtual
diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index d4bdf7d274ac..d4349ca37084 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -139,12 +139,10 @@ static inline void interrupt_enter_prepare(struct pt_regs *regs, struct interrup
 	if (!arch_irq_disabled_regs(regs))
 		trace_hardirqs_off();
 
-	if (user_mode(regs)) {
-		kuep_lock();
+	if (user_mode(regs))
 		account_cpu_user_entry();
-	} else {
+	else
 		kuap_save_and_lock(regs);
-	}
 #endif
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 1df763002726..34ff86e3686e 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -38,11 +38,6 @@ void setup_kuep(bool disabled);
 static inline void setup_kuep(bool disabled) { }
 #endif /* CONFIG_PPC_KUEP */
 
-#ifndef CONFIG_PPC_BOOK3S_32
-static inline void kuep_lock(void) { }
-static inline void kuep_unlock(void) { }
-#endif
-
 #ifdef CONFIG_PPC_KUAP
 void setup_kuap(bool disabled);
 #else
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 0273a1349006..84b51a387e95 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -52,6 +52,16 @@
 #if defined(CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
 	.globl	prepare_transfer_to_handler
 prepare_transfer_to_handler:
+#ifdef CONFIG_PPC_KUEP
+	beq	1f
+
+	mfsr    r4,0
+	rlwinm  r4,r4,0,8,3
+	oris    r4,r4,SR_NX@h
+	update_user_segments_by_6 r4, r5, r6, r7, r8, r9
+	blr
+1:
+#endif
 	/* if from kernel, check interrupted DOZE/NAP mode */
 	lwz	r12,TI_LOCAL_FLAGS(r2)
 	mtcrf	0x01,r12
@@ -93,6 +103,12 @@ transfer_to_syscall:
 	SAVE_4GPRS(3, r1)
 	SAVE_2GPRS(7, r1)
 	addi	r2,r10,-THREAD
+#ifdef CONFIG_PPC_KUEP
+	mfsr    r9,0
+	rlwinm  r9,r9,0,8,3
+	oris    r9,r9,SR_NX@h
+	update_user_segments_by_4 r9, r10, r11, r12
+#endif
 	SAVE_NVGPRS(r1)
 
 	/* Calling convention has r9 = orig r0, r10 = regs */
@@ -110,6 +126,11 @@ ret_from_syscall:
 	cmplwi	cr0,r5,0
 	bne-	2f
 #endif /* CONFIG_PPC_47x */
+#ifdef CONFIG_PPC_KUEP
+	mfsr    r7,0
+	rlwinm  r7,r7,0,8,2
+	update_user_segments_by_6 r7, r8, r9, r10, r11, r12
+#endif
 	lwz	r4,_LINK(r1)
 	lwz	r5,_CCR(r1)
 	mtlr	r4
@@ -273,6 +294,11 @@ interrupt_return:
 	beq	.Lkernel_interrupt_return
 	bl	interrupt_exit_user_prepare
 	cmpwi	r3,0
+#ifdef CONFIG_PPC_KUEP
+	mfsr    r7,0
+	rlwinm  r7,r7,0,8,2
+	update_user_segments_by_6 r7, r8, r9, r10, r11, r12
+#endif
 	bne-	.Lrestore_nvgprs
 
 .Lfast_user_interrupt_return:
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 6b1ec9e3541b..4df20fa73504 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -134,7 +134,9 @@ _ASM_NOKPROBE_SYMBOL(\name\()_virt)
 .macro prepare_transfer_to_handler
 #ifdef CONFIG_PPC_BOOK3S_32
 	andi.	r12,r9,MSR_PR
+#ifndef CONFIG_PPC_KUEP
 	bne	777f
+#endif
 	bl	prepare_transfer_to_handler
 777:
 #endif
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 21bbd615ca41..cd6139003776 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -81,8 +81,6 @@ notrace long system_call_exception(long r3, long r4, long r5,
 {
 	syscall_fn f;
 
-	kuep_lock();
-
 	regs->orig_gpr3 = r3;
 
 	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
@@ -365,7 +363,6 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
 
 	/* Restore user access locks last */
 	kuap_user_restore(regs);
-	kuep_unlock();
 
 	return ret;
 }
diff --git a/arch/powerpc/mm/book3s32/kuep.c b/arch/powerpc/mm/book3s32/kuep.c
index c20733d6e02c..45c9967f9aef 100644
--- a/arch/powerpc/mm/book3s32/kuep.c
+++ b/arch/powerpc/mm/book3s32/kuep.c
@@ -7,8 +7,13 @@ struct static_key_false disable_kuep_key;
 
 void setup_kuep(bool disabled)
 {
+	if (disabled) {
+		pr_info("KUEP cannot be disabled for the time being\n");
+		disabled = false;
+	}
+
 	if (!disabled)
-		kuep_lock();
+		update_user_segments(mfsr(0) | SR_NX);
 
 	if (smp_processor_id() != boot_cpuid)
 		return;
-- 
2.25.0

