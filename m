Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B519E39BB4C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFDO6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:58:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:13922 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhFDO6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:58:44 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FxQpK2098zBCvy;
        Fri,  4 Jun 2021 16:56:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qwonBNXOUaYf; Fri,  4 Jun 2021 16:56:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FxQpK13lkzBCvw;
        Fri,  4 Jun 2021 16:56:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 072048B8A9;
        Fri,  4 Jun 2021 16:56:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id CSYsbmwbHUCr; Fri,  4 Jun 2021 16:56:56 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B2B598B8AB;
        Fri,  4 Jun 2021 16:56:56 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7070764BDB; Fri,  4 Jun 2021 14:56:56 +0000 (UTC)
Message-Id: <809d316bf5f1a81acdd69e220c13e716dac24f53.1622818556.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 1/4] powerpc/interrupt: Interchange
 prep_irq_for_{kernel_enabled/user}_exit()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  4 Jun 2021 14:56:56 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prep_irq_for_user_exit() is a superset of
prep_irq_for_kernel_enabled_exit(). In order to allow refactoring in
following patch, interchange the two as prep_irq_for_user_exit() will
call prep_irq_for_kernel_enabled_exit().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
This series applies on top of Nic's series to speed up interrupt return on 64s

 arch/powerpc/kernel/interrupt.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 74c995a42399..539455c62c5b 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -40,33 +40,27 @@ static inline bool exit_must_hard_disable(void)
 #endif
 
 /*
- * local irqs must be disabled. Returns false if the caller must re-enable
- * them, check for new work, and try again.
- *
- * This should be called with local irqs disabled, but if they were previously
- * enabled when the interrupt handler returns (indicating a process-context /
- * synchronous interrupt) then irqs_enabled should be true.
+ * restartable is true then EE/RI can be left on because interrupts are handled
+ * with a restart sequence.
  */
-static notrace __always_inline bool prep_irq_for_user_exit(void)
+static notrace __always_inline bool prep_irq_for_kernel_enabled_exit(bool restartable)
 {
-	user_enter_irqoff();
 	/* This must be done with RI=1 because tracing may touch vmaps */
 	trace_hardirqs_on();
 
 #ifdef CONFIG_PPC32
 	__hard_EE_RI_disable();
 #else
-	if (exit_must_hard_disable())
+	if (exit_must_hard_disable() || !restartable)
 		__hard_EE_RI_disable();
 
 	/* This pattern matches prep_irq_for_idle */
 	if (unlikely(lazy_irq_pending_nocheck())) {
-		if (exit_must_hard_disable()) {
+		if (exit_must_hard_disable() || !restartable) {
 			local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
 			__hard_RI_enable();
 		}
 		trace_hardirqs_off();
-		user_exit_irqoff();
 
 		return false;
 	}
@@ -75,27 +69,33 @@ static notrace __always_inline bool prep_irq_for_user_exit(void)
 }
 
 /*
- * restartable is true then EE/RI can be left on because interrupts are handled
- * with a restart sequence.
+ * local irqs must be disabled. Returns false if the caller must re-enable
+ * them, check for new work, and try again.
+ *
+ * This should be called with local irqs disabled, but if they were previously
+ * enabled when the interrupt handler returns (indicating a process-context /
+ * synchronous interrupt) then irqs_enabled should be true.
  */
-static notrace __always_inline bool prep_irq_for_kernel_enabled_exit(bool restartable)
+static notrace __always_inline bool prep_irq_for_user_exit(void)
 {
+	user_enter_irqoff();
 	/* This must be done with RI=1 because tracing may touch vmaps */
 	trace_hardirqs_on();
 
 #ifdef CONFIG_PPC32
 	__hard_EE_RI_disable();
 #else
-	if (exit_must_hard_disable() || !restartable)
+	if (exit_must_hard_disable())
 		__hard_EE_RI_disable();
 
 	/* This pattern matches prep_irq_for_idle */
 	if (unlikely(lazy_irq_pending_nocheck())) {
-		if (exit_must_hard_disable() || !restartable) {
+		if (exit_must_hard_disable()) {
 			local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
 			__hard_RI_enable();
 		}
 		trace_hardirqs_off();
+		user_exit_irqoff();
 
 		return false;
 	}
-- 
2.25.0

