Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693A43324F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhCIMKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:10:52 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:19680 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231320AbhCIMKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:10:03 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DvvCs0Npnz9tyjK;
        Tue,  9 Mar 2021 13:10:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OgPIwJULqqkn; Tue,  9 Mar 2021 13:10:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DvvCr6Xk7z9tyjF;
        Tue,  9 Mar 2021 13:10:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3834A8B803;
        Tue,  9 Mar 2021 13:10:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5fYriQPE8WFA; Tue,  9 Mar 2021 13:10:02 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 052708B802;
        Tue,  9 Mar 2021 13:10:02 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D505367559; Tue,  9 Mar 2021 12:10:01 +0000 (UTC)
Message-Id: <aeab3516eefd34fd9fd81fa85d99af17df5dccbf.1615291474.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615291471.git.christophe.leroy@csgroup.eu>
References: <cover.1615291471.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 35/43] powerpc/32: Save remaining registers in exception
 prolog
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Mar 2021 12:10:01 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save non volatile registers, XER, CTR, MSR and NIP in exception prolog.

Also assign proper value to r2 and r3 there.

For now, recalculate thread pointer in prepare_transfer_to_handler.
It will disappear once KUAP is ported to C.

And remove the comment which is now completely wrong.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_32.S | 25 +++----------------------
 arch/powerpc/kernel/head_32.h  | 12 ++++++++++++
 2 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 289f111a5ac7..8fe1c3fdfa6e 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -48,29 +48,11 @@
  */
 	.align	12
 
-/*
- * This code finishes saving the registers to the exception frame
- * and jumps to the appropriate handler for the exception, turning
- * on address translation.
- * Note that we rely on the caller having set cr0.eq iff the exception
- * occurred in kernel mode (i.e. MSR:PR = 0).
- */
 	.globl	prepare_transfer_to_handler
 prepare_transfer_to_handler:
-	SAVE_NVGPRS(r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	stw	r2,GPR2(r11)
-	stw	r12,_NIP(r11)
-	stw	r9,_MSR(r11)
-	andi.	r2,r9,MSR_PR
-	mfctr	r12
-	mfspr	r2,SPRN_XER
-	stw	r12,_CTR(r11)
-	stw	r2,_XER(r11)
-	mfspr	r12,SPRN_SPRG_THREAD
-	tovirt(r12, r12)
+	andi.	r0,r9,MSR_PR
+	addi	r12, r2, THREAD
 	beq	2f			/* if from user, fix up THREAD.regs */
-	addi	r2, r12, -THREAD
 	stw	r3,PT_REGS(r12)
 #ifdef CONFIG_PPC_BOOK3S_32
 	kuep_lock r11, r12
@@ -79,8 +61,7 @@ prepare_transfer_to_handler:
 
 	/* if from kernel, check interrupted DOZE/NAP mode */
 2:
-	kuap_save_and_lock r11, r12, r9, r2, r6
-	addi	r2, r12, -THREAD
+	kuap_save_and_lock r11, r12, r9, r5, r6
 #if defined(CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
 	lwz	r12,TI_LOCAL_FLAGS(r2)
 	mtcrf	0x01,r12
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index ba20bfabdf63..267479072495 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -117,6 +117,18 @@ _ASM_NOKPROBE_SYMBOL(\name\()_virt)
 	stw	r10,_TRAP(r1)
 	SAVE_4GPRS(3, r1)
 	SAVE_2GPRS(7, r1)
+	SAVE_NVGPRS(r1)
+	stw	r2,GPR2(r1)
+	stw	r12,_NIP(r1)
+	stw	r9,_MSR(r1)
+	mfctr	r0
+	mfspr	r10,SPRN_XER
+	mfspr	r2,SPRN_SPRG_THREAD
+	stw	r0,_CTR(r1)
+	tovirt(r2, r2)
+	stw	r10,_XER(r1)
+	addi	r2, r2, -THREAD
+	addi	r3,r1,STACK_FRAME_OVERHEAD
 .endm
 
 .macro prepare_transfer_to_handler
-- 
2.25.0

