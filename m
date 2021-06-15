Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353683A7913
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 10:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhFOIfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 04:35:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23497 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231193AbhFOIfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:35:37 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G41mj0mBDzB8nN;
        Tue, 15 Jun 2021 10:33:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D0bhppiUnCbn; Tue, 15 Jun 2021 10:33:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G41mg5w40zB8hP;
        Tue, 15 Jun 2021 10:33:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B9B2E8B7A5;
        Tue, 15 Jun 2021 10:33:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vWn6E5pBcIEZ; Tue, 15 Jun 2021 10:33:23 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7F8438B7B5;
        Tue, 15 Jun 2021 10:33:23 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5BA0966264; Tue, 15 Jun 2021 08:33:23 +0000 (UTC)
Message-Id: <65529943d40f82efb3a9c0d1ab4cdd542f0ca163.1623745949.git.christophe.leroy@csgroup.eu>
In-Reply-To: <8071cd2e2f2bdc0711e6ac435dff4a09ff21fee2.1623745949.git.christophe.leroy@csgroup.eu>
References: <8071cd2e2f2bdc0711e6ac435dff4a09ff21fee2.1623745949.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 3/5] powerpc/interrupt: Interchange
 prep_irq_for_{kernel_enabled/user}_exit()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 15 Jun 2021 08:33:23 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prep_irq_for_user_exit() is a superset of
prep_irq_for_kernel_enabled_exit(). In order to allow refactoring in
following patch, interchange the two. This will allow
prep_irq_for_user_exit() to call a renamed version of
prep_irq_for_kernel_enabled_exit().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/interrupt.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index b9558372adc0..9780c26f19cf 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -46,27 +46,28 @@ static inline bool exit_must_hard_disable(void)
  * This should be called with local irqs disabled, but if they were previously
  * enabled when the interrupt handler returns (indicating a process-context /
  * synchronous interrupt) then irqs_enabled should be true.
+ *
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
@@ -74,28 +75,26 @@ static notrace __always_inline bool prep_irq_for_user_exit(void)
 	return true;
 }
 
-/*
- * restartable is true then EE/RI can be left on because interrupts are handled
- * with a restart sequence.
- */
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

