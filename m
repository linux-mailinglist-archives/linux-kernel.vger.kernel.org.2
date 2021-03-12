Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0274338DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhCLMvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:51:19 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:15941 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231774AbhCLMuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:50:37 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DxlzH0Cdsz9ttBT;
        Fri, 12 Mar 2021 13:50:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id xmDHT-ixZL3s; Fri, 12 Mar 2021 13:50:34 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DxlzG5Swwz9ttDF;
        Fri, 12 Mar 2021 13:50:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B8F388B813;
        Fri, 12 Mar 2021 13:50:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id H-V_q8h3M6pm; Fri, 12 Mar 2021 13:50:35 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7F5DD8B764;
        Fri, 12 Mar 2021 13:50:35 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 57AF5675C9; Fri, 12 Mar 2021 12:50:35 +0000 (UTC)
Message-Id: <20d52c627303d63e461797df13e6890fc04017d0.1615552867.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615552866.git.christophe.leroy@csgroup.eu>
References: <cover.1615552866.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 25/41] powerpc/32: Don't save thread.regs on interrupt
 entry
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 12 Mar 2021 12:50:35 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 06d67d54741a ("powerpc: make process.c suitable for both
32-bit and 64-bit"), thread.regs is set on task creation, no need to
set it again and again at each interrupt entry as it never change.

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_32.S | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 79311d0bd09b..1e201fc4a590 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -97,10 +97,8 @@ transfer_to_handler:
 	stw	r2,_XER(r11)
 	mfspr	r12,SPRN_SPRG_THREAD
 	tovirt(r12, r12)
-	beq	2f			/* if from user, fix up THREAD.regs */
+	beq	2f
 	addi	r2, r12, -THREAD
-	addi	r11,r1,STACK_FRAME_OVERHEAD
-	stw	r11,PT_REGS(r12)
 #ifdef CONFIG_PPC_BOOK3S_32
 	kuep_lock r11, r12
 #endif
@@ -147,7 +145,6 @@ transfer_to_syscall:
 	/* Calling convention has r9 = orig r0, r10 = regs */
 	addi	r10,r1,STACK_FRAME_OVERHEAD
 	mr	r9,r0
-	stw	r10,THREAD+PT_REGS(r2)
 	bl	system_call_exception
 
 ret_from_syscall:
-- 
2.25.0

