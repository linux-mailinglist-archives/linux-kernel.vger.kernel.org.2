Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE35380540
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbhENIaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:30:08 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:37215 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230460AbhENIaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:30:05 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FhMBC17yVz9sbZ;
        Fri, 14 May 2021 10:28:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hLarUM30odUm; Fri, 14 May 2021 10:28:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FhMBC0FJhz9sbQ;
        Fri, 14 May 2021 10:28:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CC7888B7F7;
        Fri, 14 May 2021 10:28:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id nX5bHsORzjHH; Fri, 14 May 2021 10:28:50 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 880E98B7F6;
        Fri, 14 May 2021 10:28:50 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6854D64BE0; Fri, 14 May 2021 08:28:50 +0000 (UTC)
Message-Id: <7ee7f4ff8fdad034dd2d89ed439d72e2966663c3.1620980916.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cd0634769e5fea397411a0f833db52749852c6f8.1620980916.git.christophe.leroy@csgroup.eu>
References: <cd0634769e5fea397411a0f833db52749852c6f8.1620980916.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 2/2] powerpc/interrupt: Use msr instead of regs->msr
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 14 May 2021 08:28:50 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

interrupt_exit_user_prepare() and interrupt_exit_kernel_prepare()
get msr as second parameter from ASM. Use it instead of reading
it again.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/interrupt.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index d896fc6ed0be..9541328a97b1 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -231,8 +231,8 @@ static notrace void booke_load_dbcr0(void)
 #endif
 }
 
-static notrace unsigned long __interrupt_exit_user_prepare(struct pt_regs *regs, unsigned long ret,
-							   bool is_not_scv)
+static notrace unsigned long __interrupt_exit_user_prepare(struct pt_regs *regs, unsigned long msr,
+							   unsigned long ret, bool is_not_scv)
 {
 	unsigned long ti_flags;
 
@@ -281,7 +281,7 @@ static notrace unsigned long __interrupt_exit_user_prepare(struct pt_regs *regs,
 			 * may decide to restore them (to avoid taking an FP
 			 * fault).
 			 */
-			if ((regs->msr & mathflags) != mathflags)
+			if ((msr & mathflags) != mathflags)
 				restore_math(regs);
 		}
 	}
@@ -297,7 +297,7 @@ static notrace unsigned long __interrupt_exit_user_prepare(struct pt_regs *regs,
 	}
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	local_paca->tm_scratch = regs->msr;
+	local_paca->tm_scratch = msr;
 #endif
 
 	booke_load_dbcr0();
@@ -357,17 +357,17 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 		ret |= _TIF_RESTOREALL;
 	}
 
-	return __interrupt_exit_user_prepare(regs, ret, is_not_scv);
+	return __interrupt_exit_user_prepare(regs, regs->msr, ret, is_not_scv);
 }
 
 notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs, unsigned long msr)
 {
 	if (!IS_ENABLED(CONFIG_BOOKE) && !IS_ENABLED(CONFIG_40x))
-		BUG_ON(!(regs->msr & MSR_RI));
-	BUG_ON(!(regs->msr & MSR_PR));
+		BUG_ON(!(msr & MSR_RI));
+	BUG_ON(!(msr & MSR_PR));
 	BUG_ON(arch_irq_disabled_regs(regs));
 
-	return __interrupt_exit_user_prepare(regs, 0, true);
+	return __interrupt_exit_user_prepare(regs, msr, 0, true);
 }
 
 void preempt_schedule_irq(void);
@@ -379,9 +379,9 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 	unsigned long kuap;
 
 	if (!IS_ENABLED(CONFIG_BOOKE) && !IS_ENABLED(CONFIG_40x) &&
-	    unlikely(!(regs->msr & MSR_RI)))
+	    unlikely(!(msr & MSR_RI)))
 		unrecoverable_exception(regs);
-	BUG_ON(regs->msr & MSR_PR);
+	BUG_ON(msr & MSR_PR);
 	/*
 	 * CT_WARN_ON comes here via program_check_exception,
 	 * so avoid recursion.
@@ -400,7 +400,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 
 	if (!arch_irq_disabled_regs(regs)) {
 		/* Returning to a kernel context with local irqs enabled. */
-		WARN_ON_ONCE(!(regs->msr & MSR_EE));
+		WARN_ON_ONCE(!(msr & MSR_EE));
 again:
 		if (IS_ENABLED(CONFIG_PREEMPT)) {
 			/* Return to preemptible kernel context */
@@ -416,14 +416,14 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 		/* Returning to a kernel context with local irqs disabled. */
 		__hard_EE_RI_disable();
 #ifdef CONFIG_PPC64
-		if (regs->msr & MSR_EE)
+		if (msr & MSR_EE)
 			local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
 #endif
 	}
 
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	local_paca->tm_scratch = regs->msr;
+	local_paca->tm_scratch = msr;
 #endif
 
 	/*
-- 
2.25.0

