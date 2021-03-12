Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F54C338D92
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhCLMu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:50:57 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:17189 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231290AbhCLMuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:50:21 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Dxlyz3tSfz9ttBP;
        Fri, 12 Mar 2021 13:50:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id xyfUZ6UYsAIl; Fri, 12 Mar 2021 13:50:19 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Dxlyz14pwz9ttBL;
        Fri, 12 Mar 2021 13:50:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 28E378B812;
        Fri, 12 Mar 2021 13:50:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id WwPNGlDNCNTS; Fri, 12 Mar 2021 13:50:20 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DE5D08B764;
        Fri, 12 Mar 2021 13:50:19 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B8F57675C9; Fri, 12 Mar 2021 12:50:19 +0000 (UTC)
Message-Id: <6d6b2497115890b90cfa72a2b3ab1da5f78123c2.1615552866.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615552866.git.christophe.leroy@csgroup.eu>
References: <cover.1615552866.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 10/41] powerpc/32: Handle bookE debugging in C in exception
 entry
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 12 Mar 2021 12:50:19 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The handling of SPRN_DBCR0 and other registers can easily
be done in C instead of ASM.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/interrupt.h |  2 ++
 arch/powerpc/kernel/entry_32.S       | 23 -----------------------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index c35368adbe71..861e6eadc98c 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -65,6 +65,8 @@ static inline void interrupt_enter_prepare(struct pt_regs *regs, struct interrup
 	if (user_mode(regs))
 		account_cpu_user_entry();
 #endif
+
+	booke_restore_dbcr0();
 }
 
 /*
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 0f3f1bdd909e..4ffbcf3df72e 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -146,32 +146,9 @@ transfer_to_handler:
 	addi	r2, r12, -THREAD
 	addi	r11,r1,STACK_FRAME_OVERHEAD
 	stw	r11,PT_REGS(r12)
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
-	/* Check to see if the dbcr0 register is set up to debug.  Use the
-	   internal debug mode bit to do this. */
-	lwz	r12,THREAD_DBCR0(r12)
-	andis.	r12,r12,DBCR0_IDM@h
-#endif
 #ifdef CONFIG_PPC_BOOK3S_32
 	kuep_lock r11, r12
 #endif
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
-	beq+	3f
-	/* From user and task is ptraced - load up global dbcr0 */
-	li	r12,-1			/* clear all pending debug events */
-	mtspr	SPRN_DBSR,r12
-	lis	r11,global_dbcr0@ha
-	tophys_novmstack r11,r11
-	addi	r11,r11,global_dbcr0@l
-#ifdef CONFIG_SMP
-	lwz	r9,TASK_CPU(r2)
-	slwi	r9,r9,2
-	add	r11,r11,r9
-#endif
-	lwz	r12,0(r11)
-	mtspr	SPRN_DBCR0,r12
-#endif
-
 	b	3f
 
 2:	/* if from kernel, check interrupted DOZE/NAP mode and
-- 
2.25.0

