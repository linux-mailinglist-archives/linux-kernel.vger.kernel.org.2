Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9C33A7914
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 10:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhFOIft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 04:35:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23497 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231178AbhFOIfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:35:39 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G41ml04yfzB8nC;
        Tue, 15 Jun 2021 10:33:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VQ1aJTc6i_i3; Tue, 15 Jun 2021 10:33:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G41mh70RgzB8jC;
        Tue, 15 Jun 2021 10:33:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DB2AE8B7AE;
        Tue, 15 Jun 2021 10:33:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HD906iKgInjG; Tue, 15 Jun 2021 10:33:24 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 878028B7A5;
        Tue, 15 Jun 2021 10:33:24 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 661EF66264; Tue, 15 Jun 2021 08:33:24 +0000 (UTC)
Message-Id: <23f37090b43f4d92abbc7781617213518a41cf93.1623745950.git.christophe.leroy@csgroup.eu>
In-Reply-To: <8071cd2e2f2bdc0711e6ac435dff4a09ff21fee2.1623745949.git.christophe.leroy@csgroup.eu>
References: <8071cd2e2f2bdc0711e6ac435dff4a09ff21fee2.1623745949.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 4/5] powerpc/interrupt: Refactor
 prep_irq_for_{user/kernel_enabled}_exit()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 15 Jun 2021 08:33:24 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prep_irq_for_user_exit() is a superset of
prep_irq_for_kernel_enabled_exit().

Rename prep_irq_for_kernel_enabled_exit() as prep_irq_for_enabled_exit()
and have prep_irq_for_user_exit() use it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/interrupt.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 9780c26f19cf..05831d99bf26 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -50,7 +50,7 @@ static inline bool exit_must_hard_disable(void)
  * restartable is true then EE/RI can be left on because interrupts are handled
  * with a restart sequence.
  */
-static notrace __always_inline bool prep_irq_for_kernel_enabled_exit(bool restartable)
+static notrace __always_inline bool prep_irq_for_enabled_exit(bool restartable)
 {
 	/* This must be done with RI=1 because tracing may touch vmaps */
 	trace_hardirqs_on();
@@ -77,29 +77,14 @@ static notrace __always_inline bool prep_irq_for_kernel_enabled_exit(bool restar
 
 static notrace __always_inline bool prep_irq_for_user_exit(void)
 {
-	user_enter_irqoff();
-	/* This must be done with RI=1 because tracing may touch vmaps */
-	trace_hardirqs_on();
-
-#ifdef CONFIG_PPC32
-	__hard_EE_RI_disable();
-#else
-	if (exit_must_hard_disable())
-		__hard_EE_RI_disable();
+	bool ret;
 
-	/* This pattern matches prep_irq_for_idle */
-	if (unlikely(lazy_irq_pending_nocheck())) {
-		if (exit_must_hard_disable()) {
-			local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
-			__hard_RI_enable();
-		}
-		trace_hardirqs_off();
+	user_enter_irqoff();
+	ret = prep_irq_for_enabled_exit(true);
+	if (!ret)
 		user_exit_irqoff();
 
-		return false;
-	}
-#endif
-	return true;
+	return ret;
 }
 
 /* Has to run notrace because it is entered not completely "reconciled" */
@@ -465,7 +450,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 		 * Stack store exit can't be restarted because the interrupt
 		 * stack frame might have been clobbered.
 		 */
-		if (!prep_irq_for_kernel_enabled_exit(unlikely(stack_store))) {
+		if (!prep_irq_for_enabled_exit(unlikely(stack_store))) {
 			/*
 			 * Replay pending soft-masked interrupts now. Don't
 			 * just local_irq_enabe(); local_irq_disable(); because
-- 
2.25.0

