Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE6A3B4596
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFYOeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:34:12 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:2655 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhFYOeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:34:09 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GBKFb71t6z9tTY;
        Fri, 25 Jun 2021 16:31:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MZKXEZKOzaUZ; Fri, 25 Jun 2021 16:31:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GBKFZ68RWz9sxY;
        Fri, 25 Jun 2021 16:31:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C59AF8B80C;
        Fri, 25 Jun 2021 16:31:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qbNbyz1k0DR5; Fri, 25 Jun 2021 16:31:46 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8BB438B7FF;
        Fri, 25 Jun 2021 16:31:46 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5EFE06635D; Fri, 25 Jun 2021 14:31:46 +0000 (UTC)
Message-Id: <52531029563c1fc823b790058e799d0ca71b028c.1624631463.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/interrupt: Also use exit_must_hard_disable() on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 25 Jun 2021 14:31:46 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce #ifdefs a bit by making exit_must_hard_disable() return
true on PPC32.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/interrupt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index cee12f2fd459..1b4a99ecb7e5 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -33,10 +33,10 @@ static inline bool exit_must_hard_disable(void)
 {
 	return static_branch_unlikely(&interrupt_exit_not_reentrant);
 }
-#elif defined(CONFIG_PPC64)
+#else
 static inline bool exit_must_hard_disable(void)
 {
-	return false;
+	return IS_ENABLED(CONFIG_PPC32);
 }
 #endif
 
@@ -56,12 +56,10 @@ static notrace __always_inline bool prep_irq_for_enabled_exit(bool restartable)
 	/* This must be done with RI=1 because tracing may touch vmaps */
 	trace_hardirqs_on();
 
-#ifdef CONFIG_PPC32
-	__hard_EE_RI_disable();
-#else
 	if (exit_must_hard_disable() || !restartable)
 		__hard_EE_RI_disable();
 
+#ifdef CONFIG_PPC64
 	/* This pattern matches prep_irq_for_idle */
 	if (unlikely(lazy_irq_pending_nocheck())) {
 		if (exit_must_hard_disable() || !restartable) {
-- 
2.25.0

