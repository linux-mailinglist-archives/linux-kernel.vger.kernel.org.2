Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B46314CC2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhBIKSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:18:12 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:49547 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231301AbhBIKCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:02:52 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZdbH0Y32z9txgc;
        Tue,  9 Feb 2021 10:56:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zkxcHpwP2zYc; Tue,  9 Feb 2021 10:56:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZdbG6xN9z9txg8;
        Tue,  9 Feb 2021 10:56:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A81D48B7D6;
        Tue,  9 Feb 2021 10:56:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5hAeB7O0BiEy; Tue,  9 Feb 2021 10:56:59 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 64F8E8B7D4;
        Tue,  9 Feb 2021 10:56:59 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3D1BE67342; Tue,  9 Feb 2021 09:56:59 +0000 (UTC)
Message-Id: <4f10145f3b9278b5f84f3b2576b1aac3a10fb497.1612864004.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612864003.git.christophe.leroy@csgroup.eu>
References: <cover.1612864003.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 34/41] powerpc/32: Set current->thread.regs in C
 interrupt entry
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Feb 2021 09:56:59 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to do that is assembly, do it in C.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/interrupt.h | 4 +++-
 arch/powerpc/kernel/entry_32.S       | 3 +--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index d70c761edc00..550ad1d69a7b 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -20,8 +20,10 @@ static inline void interrupt_enter_prepare(struct pt_regs *regs, struct interrup
 	if (regs->msr & MSR_EE)
 		trace_hardirqs_off();
 
-	if (user_mode(regs))
+	if (user_mode(regs)) {
+		current->thread.regs = regs;
 		account_cpu_user_entry();
+	}
 #endif
 	/*
 	 * Book3E reconciles irq soft mask in asm
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index fd24520b2e0c..71ef5ab84b03 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -59,8 +59,7 @@
 prepare_transfer_to_handler:
 	andi.	r0,r9,MSR_PR
 	addi	r12, r2, THREAD
-	beq	2f			/* if from user, fix up THREAD.regs */
-	stw	r3,PT_REGS(r12)
+	beq	2f
 #ifdef CONFIG_PPC_BOOK3S_32
 	kuep_lock r11, r12
 #endif
-- 
2.25.0

