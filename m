Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55764338D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhCLMvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:51:12 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:63993 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231749AbhCLMue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:50:34 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DxlzC6w8hz9ttBP;
        Fri, 12 Mar 2021 13:50:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id D3wlSrmf7_fo; Fri, 12 Mar 2021 13:50:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DxlzC5wJ7z9ttDF;
        Fri, 12 Mar 2021 13:50:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A59DC8B812;
        Fri, 12 Mar 2021 13:50:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id v7_WM30atieS; Fri, 12 Mar 2021 13:50:32 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 68E6A8B764;
        Fri, 12 Mar 2021 13:50:32 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 400BB675C9; Fri, 12 Mar 2021 12:50:32 +0000 (UTC)
Message-Id: <73c00f3361ca280ef8fd7814c291bd1f5b6e2081.1615552867.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615552866.git.christophe.leroy@csgroup.eu>
References: <cover.1615552866.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 22/41] powerpc/32: Perform normal function call in
 exception entry
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 12 Mar 2021 12:50:32 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the MMU is re-enabled before calling the transfer function,
we don't need anymore that hack with the address of the handler and
the return function sitting just after the 'bl' to the transfer
fonction, that function is retrieving via a read relative to 'lr'.

Do a regular call to the transfer function, then to the handler,
then branch to the return function.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_32.S   | 14 ++++----------
 arch/powerpc/kernel/head_32.h    |  4 ++--
 arch/powerpc/kernel/head_booke.h |  6 +++---
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index ad1fd33e1126..fb849ef922fb 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -104,7 +104,7 @@ transfer_to_handler:
 #ifdef CONFIG_PPC_BOOK3S_32
 	kuep_lock r11, r12
 #endif
-	b	3f
+	blr
 
 	/* if from kernel, check interrupted DOZE/NAP mode */
 2:
@@ -118,13 +118,7 @@ transfer_to_handler:
 #endif /* CONFIG_PPC_BOOK3S_32 || CONFIG_E500 */
 	.globl transfer_to_handler_cont
 transfer_to_handler_cont:
-3:
-	mflr	r9
-	lwz	r11,0(r9)		/* virtual address of handler */
-	lwz	r9,4(r9)		/* where to go when done */
-	mtctr	r11
-	mtlr	r9
-	bctr				/* jump to handler */
+	blr
 
 #if defined (CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
 4:	rlwinm	r12,r12,0,~_TLF_NAPPING
@@ -404,8 +398,8 @@ fee_restarts:
 	stw	r10,_TRAP(r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	transfer_to_handler_full
-	.long	unrecoverable_exception
-	.long	ret_from_except
+	bl	unrecoverable_exception
+	b	ret_from_except
 #endif
 
 	.globl	ret_from_except_full
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 160ebd573c37..e09585b88ba7 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -190,8 +190,8 @@ _ASM_NOKPROBE_SYMBOL(\name\()_virt)
 	li	r10,trap;					\
 	stw	r10,_TRAP(r11);					\
 	bl	tfer;						\
-	.long	hdlr;						\
-	.long	ret
+	bl	hdlr;						\
+	b	ret
 
 #define EXC_XFER_STD(n, hdlr)		\
 	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, transfer_to_handler_full,	\
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index a127d5e7efb4..3707f49f0b78 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -322,9 +322,9 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 #define EXC_XFER_TEMPLATE(hdlr, trap, msr, tfer, ret)	\
 	li	r10,trap;					\
 	stw	r10,_TRAP(r11);					\
-	bl	tfer;		 				\
-	.long	hdlr;						\
-	.long	ret
+	bl	tfer;						\
+	bl	hdlr;						\
+	b	ret;						\
 
 #define EXC_XFER_STD(n, hdlr)		\
 	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, transfer_to_handler_full, \
-- 
2.25.0

