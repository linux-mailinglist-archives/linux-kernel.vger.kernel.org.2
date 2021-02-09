Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BB5314C88
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhBIKHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:07:00 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:31782 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231228AbhBIKAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:00:02 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZdZl5Sshz9tx47;
        Tue,  9 Feb 2021 10:56:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id XqCcVlM1H0OG; Tue,  9 Feb 2021 10:56:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZdZl4jMYz9tx43;
        Tue,  9 Feb 2021 10:56:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A3CDE8B7D8;
        Tue,  9 Feb 2021 10:56:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id stecV0MbMvs5; Tue,  9 Feb 2021 10:56:32 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E6008B7D6;
        Tue,  9 Feb 2021 10:56:32 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2AC4867342; Tue,  9 Feb 2021 09:56:32 +0000 (UTC)
Message-Id: <823e89dcd3b6002dc595ba2a071ba63b7cf619dc.1612864003.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612864003.git.christophe.leroy@csgroup.eu>
References: <cover.1612864003.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 08/41] powerpc/32: Reconcile interrupts in C
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Feb 2021 09:56:32 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for this to be in asm anymore,
use the new interrupt entry wrapper.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/interrupt.h |  4 ++
 arch/powerpc/kernel/entry_32.S       | 58 ----------------------------
 2 files changed, 4 insertions(+), 58 deletions(-)

diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index 4badb3e51c19..24671c43f930 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -16,6 +16,10 @@ struct interrupt_state {
 
 static inline void interrupt_enter_prepare(struct pt_regs *regs, struct interrupt_state *state)
 {
+#ifdef CONFIG_PPC32
+	if (regs->msr & MSR_EE)
+		trace_hardirqs_off();
+#endif
 	/*
 	 * Book3E reconciles irq soft mask in asm
 	 */
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 9312634085ba..53fb16f21b07 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -202,22 +202,6 @@ transfer_to_handler_cont:
 	lwz	r9,4(r9)		/* where to go when done */
 #if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
 	mtspr	SPRN_NRI, r0
-#endif
-#ifdef CONFIG_TRACE_IRQFLAGS
-	/*
-	 * When tracing IRQ state (lockdep) we enable the MMU before we call
-	 * the IRQ tracing functions as they might access vmalloc space or
-	 * perform IOs for console output.
-	 *
-	 * To speed up the syscall path where interrupts stay on, let's check
-	 * first if we are changing the MSR value at all.
-	 */
-	tophys_novmstack r12, r1
-	lwz	r12,_MSR(r12)
-	andi.	r12,r12,MSR_EE
-	bne	1f
-
-	/* MSR isn't changing, just transition directly */
 #endif
 	mtspr	SPRN_SRR0,r11
 	mtspr	SPRN_SRR1,r10
@@ -244,48 +228,6 @@ transfer_to_handler_cont:
 _ASM_NOKPROBE_SYMBOL(transfer_to_handler)
 _ASM_NOKPROBE_SYMBOL(transfer_to_handler_cont)
 
-#ifdef CONFIG_TRACE_IRQFLAGS
-1:	/* MSR is changing, re-enable MMU so we can notify lockdep. We need to
-	 * keep interrupts disabled at this point otherwise we might risk
-	 * taking an interrupt before we tell lockdep they are enabled.
-	 */
-	lis	r12,reenable_mmu@h
-	ori	r12,r12,reenable_mmu@l
-	LOAD_REG_IMMEDIATE(r0, MSR_KERNEL)
-	mtspr	SPRN_SRR0,r12
-	mtspr	SPRN_SRR1,r0
-	rfi
-#ifdef CONFIG_40x
-	b .	/* Prevent prefetch past rfi */
-#endif
-
-reenable_mmu:
-	/*
-	 * We save a bunch of GPRs,
-	 * r3 can be different from GPR3(r1) at this point, r9 and r11
-	 * contains the old MSR and handler address respectively,
-	 * r0, r4-r8, r12, CCR, CTR, XER etc... are left
-	 * clobbered as they aren't useful past this point.
-	 */
-
-	stwu	r1,-32(r1)
-	stw	r9,8(r1)
-	stw	r11,12(r1)
-	stw	r3,16(r1)
-
-	/* If we are disabling interrupts (normal case), simply log it with
-	 * lockdep
-	 */
-1:	bl	trace_hardirqs_off
-	lwz	r3,16(r1)
-	lwz	r11,12(r1)
-	lwz	r9,8(r1)
-	addi	r1,r1,32
-	mtctr	r11
-	mtlr	r9
-	bctr				/* jump to handler */
-#endif /* CONFIG_TRACE_IRQFLAGS */
-
 #ifndef CONFIG_VMAP_STACK
 /*
  * On kernel stack overflow, load up an initial stack pointer
-- 
2.25.0

