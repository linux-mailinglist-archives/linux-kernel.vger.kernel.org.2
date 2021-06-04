Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0FC39BB4D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhFDO6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:58:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:20349 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhFDO6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:58:46 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FxQpM3SdGzBCw3;
        Fri,  4 Jun 2021 16:56:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RlGcyuaZg_td; Fri,  4 Jun 2021 16:56:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FxQpL1MJRzBCvw;
        Fri,  4 Jun 2021 16:56:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 194E98B8A9;
        Fri,  4 Jun 2021 16:56:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id WnHQR8kTYwar; Fri,  4 Jun 2021 16:56:58 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B1A758B8AB;
        Fri,  4 Jun 2021 16:56:57 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 756C564BDB; Fri,  4 Jun 2021 14:56:57 +0000 (UTC)
Message-Id: <3fbef68e1cffc0ebbbad1893e4fb9426b0915039.1622818556.git.christophe.leroy@csgroup.eu>
In-Reply-To: <809d316bf5f1a81acdd69e220c13e716dac24f53.1622818556.git.christophe.leroy@csgroup.eu>
References: <809d316bf5f1a81acdd69e220c13e716dac24f53.1622818556.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 2/4] powerpc/interrupt: Refactor prep_irq_for_user_exit()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  4 Jun 2021 14:56:57 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prep_irq_for_user_exit() is a superset of
prep_irq_for_kernel_enabled_exit().

Refactor it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/interrupt.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 539455c62c5b..b6aa80930733 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -78,29 +78,14 @@ static notrace __always_inline bool prep_irq_for_kernel_enabled_exit(bool restar
  */
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
+	ret = prep_irq_for_kernel_enabled_exit(true);
+	if (!ret)
 		user_exit_irqoff();
 
-		return false;
-	}
-#endif
-	return true;
+	return ret;
 }
 
 /* Has to run notrace because it is entered not completely "reconciled" */
-- 
2.25.0

