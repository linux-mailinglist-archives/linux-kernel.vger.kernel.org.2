Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F04338D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhCLMut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:50:49 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:24267 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229891AbhCLMuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:50:15 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Dxlys3JPyz9ttBX;
        Fri, 12 Mar 2021 13:50:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Z38vK4_hwXur; Fri, 12 Mar 2021 13:50:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Dxlys2Rf0z9ttBS;
        Fri, 12 Mar 2021 13:50:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6BDC28B813;
        Fri, 12 Mar 2021 13:50:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id skjrZY-fzJZt; Fri, 12 Mar 2021 13:50:13 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A68938B764;
        Fri, 12 Mar 2021 13:50:12 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7FAE8675C9; Fri, 12 Mar 2021 12:50:12 +0000 (UTC)
Message-Id: <73291fb9dc9ec58182c27a40dfc3db204e3f4024.1615552866.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615552866.git.christophe.leroy@csgroup.eu>
References: <cover.1615552866.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 03/41] powerpc/40x: Change CRITICAL_EXCEPTION_PROLOG macro
 to a gas macro
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 12 Mar 2021 12:50:12 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change CRITICAL_EXCEPTION_PROLOG macro to a gas macro to
remove the ugly ; and \ on each line.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_40x.S | 71 +++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 383238a98f77..9cef423d574b 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -100,42 +100,43 @@ _ENTRY(saved_ksp_limit)
  * Instead we use a couple of words of memory at low physical addresses.
  * This is OK since we don't support SMP on these processors.
  */
-#define CRITICAL_EXCEPTION_PROLOG					     \
-	stw	r10,crit_r10@l(0);	/* save two registers to work with */\
-	stw	r11,crit_r11@l(0);					     \
-	mfcr	r10;			/* save CR in r10 for now	   */\
-	mfspr	r11,SPRN_SRR3;		/* check whether user or kernel    */\
-	andi.	r11,r11,MSR_PR;						     \
-	lis	r11,critirq_ctx@ha;					     \
-	tophys(r11,r11);						     \
-	lwz	r11,critirq_ctx@l(r11);					     \
-	beq	1f;							     \
-	/* COMING FROM USER MODE */					     \
-	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
-	lwz	r11,TASK_STACK-THREAD(r11); /* this thread's kernel stack */\
-1:	addi	r11,r11,THREAD_SIZE-INT_FRAME_SIZE; /* Alloc an excpt frm  */\
-	tophys(r11,r11);						     \
-	stw	r10,_CCR(r11);          /* save various registers	   */\
-	stw	r12,GPR12(r11);						     \
-	stw	r9,GPR9(r11);						     \
-	mflr	r10;							     \
-	stw	r10,_LINK(r11);						     \
-	mfspr	r12,SPRN_DEAR;		/* save DEAR and ESR in the frame  */\
-	stw	r12,_DEAR(r11);		/* since they may have had stuff   */\
-	mfspr	r9,SPRN_ESR;		/* in them at the point where the  */\
-	stw	r9,_ESR(r11);		/* exception was taken		   */\
-	mfspr	r12,SPRN_SRR2;						     \
-	stw	r1,GPR1(r11);						     \
-	mfspr	r9,SPRN_SRR3;						     \
-	stw	r1,0(r11);						     \
-	tovirt(r1,r11);							     \
-	rlwinm	r9,r9,0,14,12;		/* clear MSR_WE (necessary?)	   */\
-	stw	r0,GPR0(r11);						     \
-	lis	r10, STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */\
-	addi	r10, r10, STACK_FRAME_REGS_MARKER@l;			     \
-	stw	r10, 8(r11);						     \
-	SAVE_4GPRS(3, r11);						     \
+.macro CRITICAL_EXCEPTION_PROLOG
+	stw	r10,crit_r10@l(0)	/* save two registers to work with */
+	stw	r11,crit_r11@l(0)
+	mfcr	r10			/* save CR in r10 for now	   */
+	mfspr	r11,SPRN_SRR3		/* check whether user or kernel    */
+	andi.	r11,r11,MSR_PR
+	lis	r11,critirq_ctx@ha
+	tophys(r11,r11)
+	lwz	r11,critirq_ctx@l(r11)
+	beq	1f
+	/* COMING FROM USER MODE */
+	mfspr	r11,SPRN_SPRG_THREAD	/* if from user, start at top of   */
+	lwz	r11,TASK_STACK-THREAD(r11) /* this thread's kernel stack */
+1:	addi	r11,r11,THREAD_SIZE-INT_FRAME_SIZE /* Alloc an excpt frm  */
+	tophys(r11,r11)
+	stw	r10,_CCR(r11)		/* save various registers	   */
+	stw	r12,GPR12(r11)
+	stw	r9,GPR9(r11)
+	mflr	r10
+	stw	r10,_LINK(r11)
+	mfspr	r12,SPRN_DEAR		/* save DEAR and ESR in the frame  */
+	stw	r12,_DEAR(r11)		/* since they may have had stuff   */
+	mfspr	r9,SPRN_ESR		/* in them at the point where the  */
+	stw	r9,_ESR(r11)		/* exception was taken		   */
+	mfspr	r12,SPRN_SRR2
+	stw	r1,GPR1(r11)
+	mfspr	r9,SPRN_SRR3
+	stw	r1,0(r11)
+	tovirt(r1,r11)
+	rlwinm	r9,r9,0,14,12		/* clear MSR_WE (necessary?)	   */
+	stw	r0,GPR0(r11)
+	lis	r10, STACK_FRAME_REGS_MARKER@ha /* exception frame marker */
+	addi	r10, r10, STACK_FRAME_REGS_MARKER@l
+	stw	r10, 8(r11)
+	SAVE_4GPRS(3, r11)
 	SAVE_2GPRS(7, r11)
+.endm
 
 	/*
 	 * State at this point:
-- 
2.25.0

