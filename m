Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F75D314C6A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhBIKD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:03:28 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:9886 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231167AbhBIJ7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:59:55 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZdZj64w8z9tx46;
        Tue,  9 Feb 2021 10:56:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0jzxpFaLRWjO; Tue,  9 Feb 2021 10:56:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZdZj4H3Xz9tx44;
        Tue,  9 Feb 2021 10:56:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 977868B7D6;
        Tue,  9 Feb 2021 10:56:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BC9h9lNe6oFd; Tue,  9 Feb 2021 10:56:30 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3FDD08B7D4;
        Tue,  9 Feb 2021 10:56:30 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1CF4067342; Tue,  9 Feb 2021 09:56:30 +0000 (UTC)
Message-Id: <2391e6e333c7f2a170244e1d298e1639d6e3159d.1612864003.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612864003.git.christophe.leroy@csgroup.eu>
References: <cover.1612864003.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 06/41] powerpc/40x: Prepare for enabling MMU in
 critical exception prolog
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Feb 2021 09:56:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order the enable MMU early in exception prolog, implement
CONFIG_VMAP_STACK principles in critical exception prolog.

There is no intention to use CONFIG_VMAP_STACK on 40x,
but related code will be used to enable MMU early in exception
in a later patch.

Also address (critirq_ctx-PAGE_OFFSET) directly instead of
using tophys() in order to win one instruction.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_40x.S | 40 +++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 5b337bf49bcb..1468f38c3860 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -89,6 +89,12 @@ _ENTRY(crit_srr0)
 	.space	4
 _ENTRY(crit_srr1)
 	.space	4
+_ENTRY(crit_r1)
+	.space	4
+_ENTRY(crit_dear)
+	.space	4
+_ENTRY(crit_esr)
+	.space	4
 _ENTRY(saved_ksp_limit)
 	.space	4
 
@@ -107,32 +113,60 @@ _ENTRY(saved_ksp_limit)
 	mfspr	r11,SPRN_SRR1
 	stw	r10,crit_srr0@l(0)
 	stw	r11,crit_srr1@l(0)
+#ifdef CONFIG_VMAP_STACK
+	mfspr	r10,SPRN_DEAR
+	mfspr	r11,SPRN_ESR
+	stw	r10,crit_dear@l(0)
+	stw	r11,crit_esr@l(0)
+#endif
 	mfcr	r10			/* save CR in r10 for now	   */
 	mfspr	r11,SPRN_SRR3		/* check whether user or kernel    */
 	andi.	r11,r11,MSR_PR
-	lis	r11,critirq_ctx@ha
-	tophys(r11,r11)
-	lwz	r11,critirq_ctx@l(r11)
+	lis	r11,(critirq_ctx-PAGE_OFFSET)@ha
+	lwz	r11,(critirq_ctx-PAGE_OFFSET)@l(r11)
 	beq	1f
 	/* COMING FROM USER MODE */
 	mfspr	r11,SPRN_SPRG_THREAD	/* if from user, start at top of   */
 	lwz	r11,TASK_STACK-THREAD(r11) /* this thread's kernel stack */
+#ifdef CONFIG_VMAP_STACK
+1:	stw	r1,crit_r1@l(0)
+	addi	r1,r11,THREAD_SIZE-INT_FRAME_SIZE /* Alloc an excpt frm  */
+	LOAD_REG_IMMEDIATE(r11,MSR_KERNEL & ~(MSR_IR | MSR_RI))
+	mtmsr	r11
+	isync
+	lwz	r11,crit_r1@l(0)
+	stw	r11,GPR1(r1)
+	stw	r11,0(r1)
+	mr	r11,r1
+#else
 1:	addi	r11,r11,THREAD_SIZE-INT_FRAME_SIZE /* Alloc an excpt frm  */
 	tophys(r11,r11)
 	stw	r1,GPR1(r11)
 	stw	r1,0(r11)
 	tovirt(r1,r11)
+#endif
 	stw	r10,_CCR(r11)		/* save various registers	   */
 	stw	r12,GPR12(r11)
 	stw	r9,GPR9(r11)
 	mflr	r10
 	stw	r10,_LINK(r11)
+#ifdef CONFIG_VMAP_STACK
+	lis	r9,PAGE_OFFSET@ha
+	lwz	r10,crit_r10@l(r9)
+	lwz	r12,crit_r11@l(r9)
+#else
 	lwz	r10,crit_r10@l(0)
 	lwz	r12,crit_r11@l(0)
+#endif
 	stw	r10,GPR10(r11)
 	stw	r12,GPR11(r11)
+#ifdef CONFIG_VMAP_STACK
+	lwz	r12,crit_dear@l(r9)
+	lwz	r9,crit_esr@l(r9)
+#else
 	mfspr	r12,SPRN_DEAR		/* save DEAR and ESR in the frame  */
 	mfspr	r9,SPRN_ESR		/* in them at the point where the  */
+#endif
 	stw	r12,_DEAR(r11)		/* since they may have had stuff   */
 	stw	r9,_ESR(r11)		/* exception was taken		   */
 	mfspr	r12,SPRN_SRR2
-- 
2.25.0

