Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621FE338D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhCLMus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:50:48 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:45173 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229908AbhCLMuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:50:15 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Dxlys5XYNz9ttBY;
        Fri, 12 Mar 2021 13:50:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7-DEaJLS1Aw8; Fri, 12 Mar 2021 13:50:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Dxlys4btwz9ttBS;
        Fri, 12 Mar 2021 13:50:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7CE8B8B764;
        Fri, 12 Mar 2021 13:50:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zcZcn0Kt3Lon; Fri, 12 Mar 2021 13:50:14 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ABFE38B815;
        Fri, 12 Mar 2021 13:50:13 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8651E675C9; Fri, 12 Mar 2021 12:50:13 +0000 (UTC)
Message-Id: <79a93f253d72dc97ac968c9c62b5066960b688ed.1615552866.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615552866.git.christophe.leroy@csgroup.eu>
References: <cover.1615552866.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 04/41] powerpc/40x: Save SRR0/SRR1 and r10/r11 earlier in
 critical exception
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 12 Mar 2021 12:50:13 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to switch MMU on in exception prolog, save
SRR0 and SRR1 earlier.

Also save r10 and r11 into stack earlier to better match with the
normal exception prolog.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_32.S | 9 ---------
 arch/powerpc/kernel/head_40x.S | 8 ++++++++
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 78c430b7f9d9..8528b4c7f9d3 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -107,15 +107,6 @@ _ASM_NOKPROBE_SYMBOL(crit_transfer_to_handler)
 #ifdef CONFIG_40x
 	.globl	crit_transfer_to_handler
 crit_transfer_to_handler:
-	lwz	r0,crit_r10@l(0)
-	stw	r0,GPR10(r11)
-	lwz	r0,crit_r11@l(0)
-	stw	r0,GPR11(r11)
-	mfspr	r0,SPRN_SRR0
-	stw	r0,crit_srr0@l(0)
-	mfspr	r0,SPRN_SRR1
-	stw	r0,crit_srr1@l(0)
-
 	/* set the stack limit to the current stack */
 	mfspr	r8,SPRN_SPRG_THREAD
 	lwz	r0,KSP_LIMIT(r8)
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 9cef423d574b..067ae1302c1c 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -103,6 +103,10 @@ _ENTRY(saved_ksp_limit)
 .macro CRITICAL_EXCEPTION_PROLOG
 	stw	r10,crit_r10@l(0)	/* save two registers to work with */
 	stw	r11,crit_r11@l(0)
+	mfspr	r10,SPRN_SRR0
+	mfspr	r11,SPRN_SRR1
+	stw	r10,crit_srr0@l(0)
+	stw	r11,crit_srr1@l(0)
 	mfcr	r10			/* save CR in r10 for now	   */
 	mfspr	r11,SPRN_SRR3		/* check whether user or kernel    */
 	andi.	r11,r11,MSR_PR
@@ -120,6 +124,10 @@ _ENTRY(saved_ksp_limit)
 	stw	r9,GPR9(r11)
 	mflr	r10
 	stw	r10,_LINK(r11)
+	lwz	r10,crit_r10@l(0)
+	lwz	r12,crit_r11@l(0)
+	stw	r10,GPR10(r11)
+	stw	r12,GPR11(r11)
 	mfspr	r12,SPRN_DEAR		/* save DEAR and ESR in the frame  */
 	stw	r12,_DEAR(r11)		/* since they may have had stuff   */
 	mfspr	r9,SPRN_ESR		/* in them at the point where the  */
-- 
2.25.0

