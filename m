Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4658C3324CD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhCIMJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:09:51 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:39142 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230319AbhCIMJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:09:35 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DvvCK2HQDz9tyjQ;
        Tue,  9 Mar 2021 13:09:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id l45W7vZ1yY_R; Tue,  9 Mar 2021 13:09:33 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DvvCK1Vxgz9tyjG;
        Tue,  9 Mar 2021 13:09:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8DA2F8B7FC;
        Tue,  9 Mar 2021 13:09:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id yMtfVgOyw_Mo; Tue,  9 Mar 2021 13:09:34 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 100848B800;
        Tue,  9 Mar 2021 13:09:34 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E80FA67555; Tue,  9 Mar 2021 12:09:33 +0000 (UTC)
Message-Id: <5cbd0cb65293c3c6d98a0ca41edfad73fd005e84.1615291471.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615291471.git.christophe.leroy@csgroup.eu>
References: <cover.1615291471.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 08/43] powerpc/40x: Prepare normal exception handler for
 enabling MMU early
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Mar 2021 12:09:33 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure normal exception handler are able to manage stuff with
MMU enabled. For that we use CONFIG_VMAP_STACK related code
allthough there is no intention to really activate CONFIG_VMAP_STACK
on powerpc 40x for the moment.

40x uses SPRN_DEAR instead of SPRN_DAR and SPRN_ESR instead of
SPRN_DSISR. Take it into account in common macros.

40x MSR value doesn't fit on 15 bits, use LOAD_REG_IMMEDIATE() in
common macros that will be used also with 40x.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_32.S |  2 +-
 arch/powerpc/kernel/head_32.h  | 15 ++++++++++++++-
 arch/powerpc/kernel/head_40x.S | 17 ++++++-----------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 8528b4c7f9d3..535c55f4393a 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -162,7 +162,7 @@ transfer_to_handler:
 	li	r12,-1			/* clear all pending debug events */
 	mtspr	SPRN_DBSR,r12
 	lis	r11,global_dbcr0@ha
-	tophys(r11,r11)
+	tophys_novmstack r11,r11
 	addi	r11,r11,global_dbcr0@l
 #ifdef CONFIG_SMP
 	lwz	r9,TASK_CPU(r2)
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 5d4706c14572..ac6b391f1493 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -22,9 +22,17 @@
 #ifdef CONFIG_VMAP_STACK
 	mfspr	r10, SPRN_SPRG_THREAD
 	.if	\handle_dar_dsisr
+#ifdef CONFIG_40x
+	mfspr	r11, SPRN_DEAR
+#else
 	mfspr	r11, SPRN_DAR
+#endif
 	stw	r11, DAR(r10)
+#ifdef CONFIG_40x
+	mfspr	r11, SPRN_ESR
+#else
 	mfspr	r11, SPRN_DSISR
+#endif
 	stw	r11, DSISR(r10)
 	.endif
 	mfspr	r11, SPRN_SRR0
@@ -61,7 +69,7 @@
 
 .macro EXCEPTION_PROLOG_2 handle_dar_dsisr=0
 #ifdef CONFIG_VMAP_STACK
-	li	r11, MSR_KERNEL & ~(MSR_IR | MSR_RI) /* can take DTLB miss */
+	LOAD_REG_IMMEDIATE(r11, MSR_KERNEL & ~(MSR_IR | MSR_RI)) /* can take DTLB miss */
 	mtmsr	r11
 	isync
 	mfspr	r11, SPRN_SPRG_SCRATCH2
@@ -158,8 +166,13 @@
 
 .macro save_dar_dsisr_on_stack reg1, reg2, sp
 #ifndef CONFIG_VMAP_STACK
+#ifdef CONFIG_40x
+	mfspr	\reg1, SPRN_DEAR
+	mfspr	\reg2, SPRN_ESR
+#else
 	mfspr	\reg1, SPRN_DAR
 	mfspr	\reg2, SPRN_DSISR
+#endif
 	stw	\reg1, _DAR(\sp)
 	stw	\reg2, _DSISR(\sp)
 #endif
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 1468f38c3860..4bf0aee858eb 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -221,11 +221,8 @@ _ENTRY(saved_ksp_limit)
  * if they can't resolve the lightweight TLB fault.
  */
 	START_EXCEPTION(0x0300,	DataStorage)
-	EXCEPTION_PROLOG
-	mfspr	r5, SPRN_ESR		/* Grab the ESR, save it */
-	stw	r5, _ESR(r11)
-	mfspr	r4, SPRN_DEAR		/* Grab the DEAR, save it */
-	stw	r4, _DEAR(r11)
+	EXCEPTION_PROLOG handle_dar_dsisr=1
+	save_dar_dsisr_on_stack	r4, r5, r11
 	EXC_XFER_LITE(0x300, handle_page_fault)
 
 /*
@@ -244,17 +241,15 @@ _ENTRY(saved_ksp_limit)
 
 /* 0x0600 - Alignment Exception */
 	START_EXCEPTION(0x0600, Alignment)
-	EXCEPTION_PROLOG
-	mfspr	r4,SPRN_DEAR		/* Grab the DEAR and save it */
-	stw	r4,_DEAR(r11)
+	EXCEPTION_PROLOG handle_dar_dsisr=1
+	save_dar_dsisr_on_stack r4, r5, r11
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_STD(0x600, alignment_exception)
 
 /* 0x0700 - Program Exception */
 	START_EXCEPTION(0x0700, ProgramCheck)
-	EXCEPTION_PROLOG
-	mfspr	r4,SPRN_ESR		/* Grab the ESR and save it */
-	stw	r4,_ESR(r11)
+	EXCEPTION_PROLOG handle_dar_dsisr=1
+	save_dar_dsisr_on_stack r4, r5, r11
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_STD(0x700, program_check_exception)
 
-- 
2.25.0

