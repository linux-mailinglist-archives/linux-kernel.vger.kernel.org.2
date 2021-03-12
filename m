Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA4A338DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhCLMvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:51:35 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:2592 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231849AbhCLMup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:50:45 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DxlzR410sz9ttBX;
        Fri, 12 Mar 2021 13:50:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id yR1C5TxzNG56; Fri, 12 Mar 2021 13:50:43 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DxlzR2LVWz9ttBL;
        Fri, 12 Mar 2021 13:50:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 269F88B813;
        Fri, 12 Mar 2021 13:50:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DGrmgJMMnPmK; Fri, 12 Mar 2021 13:50:44 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CDD2C8B764;
        Fri, 12 Mar 2021 13:50:43 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 97762675C9; Fri, 12 Mar 2021 12:50:43 +0000 (UTC)
Message-Id: <e1c45d2e895e0693c42d2a6840df1105a148efea.1615552867.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615552866.git.christophe.leroy@csgroup.eu>
References: <cover.1615552866.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 33/41] powerpc/32: Refactor saving of volatile registers in
 exception prologs
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 12 Mar 2021 12:50:43 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exception prologs all do the same at the end:
- Save trapno in stack
- Mark stack with exception marker
- Save r0
- Save r3 to r8

Refactor that into a COMMON_EXCEPTION_PROLOG_END macro.
At the same time use r1 instead of r11.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_32.h    | 16 ++++++++++------
 arch/powerpc/kernel/head_40x.S   |  9 +--------
 arch/powerpc/kernel/head_booke.h | 26 +++++++++++++-------------
 3 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 84e6251622e8..ba20bfabdf63 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -104,15 +104,19 @@
 	li	r10, MSR_KERNEL		/* can take exceptions */
 	mtmsr	r10			/* (except for mach check in rtas) */
 #endif
-	stw	r0,GPR0(r11)
+	COMMON_EXCEPTION_PROLOG_END \trapno
+_ASM_NOKPROBE_SYMBOL(\name\()_virt)
+.endm
+
+.macro COMMON_EXCEPTION_PROLOG_END trapno
+	stw	r0,GPR0(r1)
 	lis	r10,STACK_FRAME_REGS_MARKER@ha /* exception frame marker */
 	addi	r10,r10,STACK_FRAME_REGS_MARKER@l
-	stw	r10,8(r11)
+	stw	r10,8(r1)
 	li	r10, \trapno
-	stw	r10,_TRAP(r11)
-	SAVE_4GPRS(3, r11)
-	SAVE_2GPRS(7, r11)
-_ASM_NOKPROBE_SYMBOL(\name\()_virt)
+	stw	r10,_TRAP(r1)
+	SAVE_4GPRS(3, r1)
+	SAVE_2GPRS(7, r1)
 .endm
 
 .macro prepare_transfer_to_handler
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 52b40bf529c6..e1360b88b6cb 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -157,14 +157,7 @@ _ENTRY(crit_esr)
 	mfspr	r12,SPRN_SRR2
 	mfspr	r9,SPRN_SRR3
 	rlwinm	r9,r9,0,14,12		/* clear MSR_WE (necessary?)	   */
-	stw	r0,GPR0(r11)
-	lis	r10, STACK_FRAME_REGS_MARKER@ha /* exception frame marker */
-	addi	r10, r10, STACK_FRAME_REGS_MARKER@l
-	stw	r10, 8(r11)
-	li	r10, \trapno + 2
-	stw	r10,_TRAP(r11)
-	SAVE_4GPRS(3, r11)
-	SAVE_2GPRS(7, r11)
+	COMMON_EXCEPTION_PROLOG_END \trapno + 2
 _ASM_NOKPROBE_SYMBOL(\name\()_virt)
 .endm
 
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index fa566e89f18b..4d583fbef0b6 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -78,14 +78,18 @@ END_BTB_FLUSH_SECTION
 	stw	r1, 0(r11);						     \
 	mr	r1, r11;						     \
 	rlwinm	r9,r9,0,14,12;		/* clear MSR_WE (necessary?)	   */\
-	stw	r0,GPR0(r11);						     \
-	lis	r10, STACK_FRAME_REGS_MARKER@ha;/* exception frame marker */ \
-	addi	r10, r10, STACK_FRAME_REGS_MARKER@l;			     \
-	stw	r10, 8(r11);						     \
-	li	r10, trapno;						     \
-	stw	r10,_TRAP(r11);						     \
-	SAVE_4GPRS(3, r11);						     \
-	SAVE_2GPRS(7, r11)
+	COMMON_EXCEPTION_PROLOG_END trapno
+
+.macro COMMON_EXCEPTION_PROLOG_END trapno
+	stw	r0,GPR0(r1)
+	lis	r10, STACK_FRAME_REGS_MARKER@ha	/* exception frame marker */
+	addi	r10, r10, STACK_FRAME_REGS_MARKER@l
+	stw	r10, 8(r1)
+	li	r10, \trapno
+	stw	r10,_TRAP(r1)
+	SAVE_4GPRS(3, r1)
+	SAVE_2GPRS(7, r1)
+.endm
 
 .macro prepare_transfer_to_handler
 	bl	prepare_transfer_to_handler
@@ -231,11 +235,7 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 	stw	r1,0(r11);						     \
 	mr	r1,r11;							     \
 	rlwinm	r9,r9,0,14,12;		/* clear MSR_WE (necessary?)	   */\
-	li	r10, trapno;						     \
-	stw	r10,_TRAP(r11);						     \
-	stw	r0,GPR0(r11);						     \
-	SAVE_4GPRS(3, r11);						     \
-	SAVE_2GPRS(7, r11)
+	COMMON_EXCEPTION_PROLOG_END trapno
 
 #define SAVE_xSRR(xSRR)			\
 	mfspr	r0,SPRN_##xSRR##0;	\
-- 
2.25.0

