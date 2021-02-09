Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F507314CB8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhBIKQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:16:44 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:54863 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230404AbhBIKCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:02:43 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZdZv1PLGz9txgF;
        Tue,  9 Feb 2021 10:56:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 4ARGP-aW_EbP; Tue,  9 Feb 2021 10:56:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZdZv0fHCz9txg8;
        Tue,  9 Feb 2021 10:56:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E13868B7D6;
        Tue,  9 Feb 2021 10:56:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id aZ0gAKJdq_CW; Tue,  9 Feb 2021 10:56:39 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 88DFB8B7D4;
        Tue,  9 Feb 2021 10:56:39 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 65E9767342; Tue,  9 Feb 2021 09:56:39 +0000 (UTC)
Message-Id: <0a9b7795166faa4cb57e59f771944d2bea53cbcf.1612864003.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612864003.git.christophe.leroy@csgroup.eu>
References: <cover.1612864003.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 15/41] powerpc/32: Enable instruction translation at
 the same time as data translation
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Feb 2021 09:56:39 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 40x and 8xx, kernel text is pinned.
On book3s/32, kernel text is mapped by BATs.

Enable instruction translation at the same time as data translation, it
makes things simpler.

In syscall handler, MSR_RI can also be set at the same time because
srr0/srr1 are already saved and r1 is set properly.

On booke, translation is always on, so at the end all PPC32
have translation on early. Just update msr.

Also update comment in power_save_ppc32_restore().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_32.S   | 30 ++++++++++++------------------
 arch/powerpc/kernel/head_32.h    | 13 ++++++++-----
 arch/powerpc/kernel/head_40x.S   | 10 +++++++---
 arch/powerpc/kernel/head_booke.h |  6 ++++--
 4 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 0b6af35acdfd..f244e7846031 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -154,19 +154,11 @@ transfer_to_handler:
 transfer_to_handler_cont:
 3:
 	mflr	r9
-	tovirt(r9, r9)
 	lwz	r11,0(r9)		/* virtual address of handler */
 	lwz	r9,4(r9)		/* where to go when done */
-#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
-	mtspr	SPRN_NRI, r0
-#endif
-	mtspr	SPRN_SRR0,r11
-	mtspr	SPRN_SRR1,r10
+	mtctr	r11
 	mtlr	r9
-	rfi				/* jump to handler, enable MMU */
-#ifdef CONFIG_40x
-	b .	/* Prevent prefetch past rfi */
-#endif
+	bctr				/* jump to handler */
 
 #if defined (CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
 4:	rlwinm	r12,r12,0,~_TLF_NAPPING
@@ -444,8 +436,6 @@ fee_restarts:
 	li	r10,-1
 	stw	r10,_TRAP(r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	lis	r10,MSR_KERNEL@h
-	ori	r10,r10,MSR_KERNEL@l
 	bl	transfer_to_handler_full
 	.long	unrecoverable_exception
 	.long	ret_from_except
@@ -945,16 +935,20 @@ _GLOBAL(enter_rtas)
 	mtspr	SPRN_SRR1,r9
 	rfi
 1:
-	li	r0, MSR_KERNEL & ~MSR_IR	/* can take DTLB miss */
-	mtmsr	r0
-	isync
+	lis	r8, 1f@h
+	ori	r8, r8, 1f@l
+	LOAD_REG_IMMEDIATE(r9,MSR_KERNEL)
+	mtspr	SPRN_SRR0,r8
+	mtspr	SPRN_SRR1,r9
+	rfi			/* Reactivate MMU translation */
+1:
 	lwz	r8,INT_FRAME_SIZE+4(r1)	/* get return address */
 	lwz	r9,8(r1)	/* original msr value */
 	addi	r1,r1,INT_FRAME_SIZE
 	li	r0,0
 	stw	r0, THREAD + RTAS_SP(r2)
-	mtspr	SPRN_SRR0,r8
-	mtspr	SPRN_SRR1,r9
-	rfi			/* return to caller */
+	mtlr	r8
+	mtmsr	r9
+	blr			/* return to caller */
 _ASM_NOKPROBE_SYMBOL(enter_rtas)
 #endif /* CONFIG_PPC_RTAS */
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 910f86642eec..88b02bd91e8e 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -63,10 +63,14 @@
 	mtspr	SPRN_DAR, r11	/* Tag DAR, to be used in DTLB Error */
 	.endif
 #endif
-	LOAD_REG_IMMEDIATE(r11, MSR_KERNEL & ~(MSR_IR | MSR_RI)) /* can take DTLB miss */
-	mtmsr	r11
-	isync
+	LOAD_REG_IMMEDIATE(r11, MSR_KERNEL & ~MSR_RI) /* re-enable MMU */
+	mtspr	SPRN_SRR1, r11
+	lis	r11, 1f@h
+	ori	r11, r11, 1f@l
+	mtspr	SPRN_SRR0, r11
 	mfspr	r11, SPRN_SPRG_SCRATCH2
+	rfi
+1:
 	stw	r11,GPR1(r1)
 	stw	r11,0(r1)
 	mr	r11, r1
@@ -94,7 +98,7 @@
 #elif defined(CONFIG_PPC_8xx)
 	mtspr	SPRN_EID, r2		/* Set MSR_RI */
 #else
-	li	r10, MSR_KERNEL & ~MSR_IR /* can take exceptions */
+	li	r10, MSR_KERNEL		/* can take exceptions */
 	mtmsr	r10			/* (except for mach check in rtas) */
 #endif
 	stw	r0,GPR0(r11)
@@ -179,7 +183,6 @@
 #define EXC_XFER_TEMPLATE(hdlr, trap, msr, tfer, ret)		\
 	li	r10,trap;					\
 	stw	r10,_TRAP(r11);					\
-	LOAD_REG_IMMEDIATE(r10, msr);				\
 	bl	tfer;						\
 	.long	hdlr;						\
 	.long	ret
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 7da673ec63ef..55fa99c5085c 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -126,9 +126,13 @@ _ENTRY(crit_esr)
 	lwz	r11,TASK_STACK-THREAD(r11) /* this thread's kernel stack */
 1:	stw	r1,crit_r1@l(0)
 	addi	r1,r11,THREAD_SIZE-INT_FRAME_SIZE /* Alloc an excpt frm  */
-	LOAD_REG_IMMEDIATE(r11,MSR_KERNEL & ~(MSR_IR | MSR_RI))
-	mtmsr	r11
-	isync
+	LOAD_REG_IMMEDIATE(r11, MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)) /* re-enable MMU */
+	mtspr	SPRN_SRR1, r11
+	lis	r11, 1f@h
+	ori	r11, r11, 1f@l
+	mtspr	SPRN_SRR0, r11
+	rfi
+1:
 	lwz	r11,crit_r1@l(0)
 	stw	r11,GPR1(r1)
 	stw	r11,0(r1)
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 4a5f0c9b652b..ff93ed519b3b 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -53,6 +53,8 @@ END_BTB_FLUSH_SECTION
 	mfspr	r11, SPRN_SRR1;		                                     \
 	DO_KVM	BOOKE_INTERRUPT_##intno SPRN_SRR1;			     \
 	andi.	r11, r11, MSR_PR;	/* check whether user or kernel    */\
+	LOAD_REG_IMMEDIATE(r11, MSR_KERNEL)				\
+	mtmsr	r11							\
 	mr	r11, r1;						     \
 	beq	1f;							     \
 	BOOKE_CLEAR_BTB(r11)						\
@@ -192,6 +194,8 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 	DO_KVM	BOOKE_INTERRUPT_##intno exc_level_srr1;		             \
 	BOOKE_CLEAR_BTB(r10)						\
 	andi.	r11,r11,MSR_PR;						     \
+	LOAD_REG_IMMEDIATE(r11, MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE))	\
+	mtmsr	r11							\
 	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
 	lwz	r11, TASK_STACK - THREAD(r11); /* this thread's kernel stack */\
 	addi	r11,r11,EXC_LVL_FRAME_OVERHEAD;	/* allocate stack frame    */\
@@ -282,8 +286,6 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 #define EXC_XFER_TEMPLATE(hdlr, trap, msr, tfer, ret)	\
 	li	r10,trap;					\
 	stw	r10,_TRAP(r11);					\
-	lis	r10,msr@h;					\
-	ori	r10,r10,msr@l;					\
 	bl	tfer;		 				\
 	.long	hdlr;						\
 	.long	ret
-- 
2.25.0

