Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CAD314CA0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhBIKNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:13:07 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:35376 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231207AbhBIKCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:02:20 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZdbD65Z5z9txgW;
        Tue,  9 Feb 2021 10:56:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id UaZ8rU5Z4NAB; Tue,  9 Feb 2021 10:56:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZdbD5MRWz9txg8;
        Tue,  9 Feb 2021 10:56:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A1A858B7D6;
        Tue,  9 Feb 2021 10:56:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MBq71Stc_Rs1; Tue,  9 Feb 2021 10:56:57 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 58A7A8B7D4;
        Tue,  9 Feb 2021 10:56:57 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2526567342; Tue,  9 Feb 2021 09:56:57 +0000 (UTC)
Message-Id: <b4df2320aad07b2fe1ea8e10de9a4d5c0186974b.1612864003.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612864003.git.christophe.leroy@csgroup.eu>
References: <cover.1612864003.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 32/41] powerpc/32: Refactor saving of volatile
 registers in exception prologs
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Feb 2021 09:56:57 +0000 (UTC)
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
 arch/powerpc/kernel/head_32.h    | 14 +++++++++-----
 arch/powerpc/kernel/head_40x.S   |  9 +--------
 arch/powerpc/kernel/head_booke.h | 26 +++++++++++++-------------
 3 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 84e6251622e8..12c39178a1d2 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -104,14 +104,18 @@
 	li	r10, MSR_KERNEL		/* can take exceptions */
 	mtmsr	r10			/* (except for mach check in rtas) */
 #endif
-	stw	r0,GPR0(r11)
+	COMMON_EXCEPTION_PROLOG_END \trapno
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
+	stw	r10,_TRAP(r1)
+	SAVE_4GPRS(3, r1)
+	SAVE_2GPRS(7, r1)
 _ASM_NOKPROBE_SYMBOL(\name\()_virt)
 .endm
 
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
index 7c8195ae95c4..7e47b5dfdd9c 100644
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
+	li	r10, trapno
+	stw	r10,_TRAP(r1)
+	SAVE_4GPRS(3, r1)
+	SAVE_2GPRS(7, r1)
+.end
 
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
 
 .macro SAVE_xSRR xSRR
 	mfspr	r0,SPRN_\xSRR\()0
-- 
2.25.0

