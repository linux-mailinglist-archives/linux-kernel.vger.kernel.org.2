Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E2D3138F2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 17:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbhBHQKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 11:10:37 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:54509 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231776AbhBHPLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:11:06 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZ8bF14pZz9vBn5;
        Mon,  8 Feb 2021 16:10:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id HfEIVBfFLv08; Mon,  8 Feb 2021 16:10:17 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZ8bF0Jwhz9vBn3;
        Mon,  8 Feb 2021 16:10:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5F07D8B7B3;
        Mon,  8 Feb 2021 16:10:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2RvJnD33wamo; Mon,  8 Feb 2021 16:10:21 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 79A928B7B2;
        Mon,  8 Feb 2021 16:10:21 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 70FA96733E; Mon,  8 Feb 2021 15:10:21 +0000 (UTC)
Message-Id: <412c6c1786922d991bbb89c2ad2e82cffe8ab112.1612796617.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612796617.git.christophe.leroy@csgroup.eu>
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v5 02/22] powerpc/32: Always enable data translation on
 syscall entry
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  8 Feb 2021 15:10:21 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the code can use a stack in vm area, it can also use a
stack in linear space.

Simplify code by removing old non VMAP stack code on PPC32 in syscall.

That means the data translation is now re-enabled early in
syscall entry in all cases, not only when using VMAP stacks.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_32.h    | 23 +----------------------
 arch/powerpc/kernel/head_booke.h |  2 --
 2 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index a2f72c966baf..fdc07beab844 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -118,7 +118,6 @@
 .macro SYSCALL_ENTRY trapno
 	mfspr	r12,SPRN_SPRG_THREAD
 	mfspr	r9, SPRN_SRR1
-#ifdef CONFIG_VMAP_STACK
 	mfspr	r11, SPRN_SRR0
 	mtctr	r11
 	andi.	r11, r9, MSR_PR
@@ -126,30 +125,16 @@
 	lwz	r1,TASK_STACK-THREAD(r12)
 	beq-	99f
 	addi	r1, r1, THREAD_SIZE - INT_FRAME_SIZE
-	li	r10, MSR_KERNEL & ~(MSR_IR | MSR_RI) /* can take DTLB miss */
+	LOAD_REG_IMMEDIATE(r10, MSR_KERNEL & ~(MSR_IR | MSR_RI)) /* can take DTLB miss */
 	mtmsr	r10
 	isync
 	tovirt(r12, r12)
 	stw	r11,GPR1(r1)
 	stw	r11,0(r1)
 	mr	r11, r1
-#else
-	andi.	r11, r9, MSR_PR
-	lwz	r11,TASK_STACK-THREAD(r12)
-	beq-	99f
-	addi	r11, r11, THREAD_SIZE - INT_FRAME_SIZE
-	tophys(r11, r11)
-	stw	r1,GPR1(r11)
-	stw	r1,0(r11)
-	tovirt(r1, r11)		/* set new kernel sp */
-#endif
 	mflr	r10
 	stw	r10, _LINK(r11)
-#ifdef CONFIG_VMAP_STACK
 	mfctr	r10
-#else
-	mfspr	r10,SPRN_SRR0
-#endif
 	stw	r10,_NIP(r11)
 	mfcr	r10
 	rlwinm	r10,r10,0,4,2	/* Clear SO bit in CR */
@@ -157,11 +142,7 @@
 #ifdef CONFIG_40x
 	rlwinm	r9,r9,0,14,12		/* clear MSR_WE (necessary?) */
 #else
-#ifdef CONFIG_VMAP_STACK
 	LOAD_REG_IMMEDIATE(r10, MSR_KERNEL & ~MSR_IR) /* can take exceptions */
-#else
-	LOAD_REG_IMMEDIATE(r10, MSR_KERNEL & ~(MSR_IR|MSR_DR)) /* can take exceptions */
-#endif
 	mtmsr	r10			/* (except for mach check in rtas) */
 #endif
 	lis	r10,STACK_FRAME_REGS_MARKER@ha /* exception frame marker */
@@ -190,7 +171,6 @@
 	li	r12,-1			/* clear all pending debug events */
 	mtspr	SPRN_DBSR,r12
 	lis	r11,global_dbcr0@ha
-	tophys(r11,r11)
 	addi	r11,r11,global_dbcr0@l
 	lwz	r12,0(r11)
 	mtspr	SPRN_DBCR0,r12
@@ -200,7 +180,6 @@
 #endif
 
 3:
-	tovirt_novmstack r2, r2 	/* set r2 to current */
 	lis	r11, transfer_to_syscall@h
 	ori	r11, r11, transfer_to_syscall@l
 #ifdef CONFIG_TRACE_IRQFLAGS
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index bf33af714d11..706cd9368992 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -144,7 +144,6 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 	li	r12,-1			/* clear all pending debug events */
 	mtspr	SPRN_DBSR,r12
 	lis	r11,global_dbcr0@ha
-	tophys(r11,r11)
 	addi	r11,r11,global_dbcr0@l
 #ifdef CONFIG_SMP
 	lwz	r10, TASK_CPU(r2)
@@ -158,7 +157,6 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 	stw	r12,4(r11)
 
 3:
-	tovirt(r2, r2)			/* set r2 to current */
 	lis	r11, transfer_to_syscall@h
 	ori	r11, r11, transfer_to_syscall@l
 #ifdef CONFIG_TRACE_IRQFLAGS
-- 
2.25.0

