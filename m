Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B570C3FC451
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbhHaIae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 04:30:34 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:57101 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240255AbhHaIac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 04:30:32 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GzL2l5Ydhz9sTF;
        Tue, 31 Aug 2021 10:29:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ffasIuKm1dMh; Tue, 31 Aug 2021 10:29:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GzL2l4brwz9sT9;
        Tue, 31 Aug 2021 10:29:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7A5E38B7DD;
        Tue, 31 Aug 2021 10:29:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id I_QUyGcvPMKr; Tue, 31 Aug 2021 10:29:35 +0200 (CEST)
Received: from po18078vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4AC718B7DE;
        Tue, 31 Aug 2021 10:29:35 +0200 (CEST)
Received: by po18078vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 223E66BCA2; Tue, 31 Aug 2021 08:29:35 +0000 (UTC)
Message-Id: <c3f9ec9950394ef939014f7934268e6ee30ca04f.1630398566.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/time: Remove generic_suspend_{dis/en}able_irqs()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 31 Aug 2021 08:29:35 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d75d68cfef49 ("powerpc: Clean up obsolete code relating to
decrementer and timebase") made generic_suspend_enable_irqs() and
generic_suspend_disable_irqs() static.

Fold them into their only caller.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/time.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 934d8ae66cc6..cae8f03a44fe 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -631,8 +631,12 @@ void timer_broadcast_interrupt(void)
 #endif
 
 #ifdef CONFIG_SUSPEND
-static void generic_suspend_disable_irqs(void)
+/* Overrides the weak version in kernel/power/main.c */
+void arch_suspend_disable_irqs(void)
 {
+	if (ppc_md.suspend_disable_irqs)
+		ppc_md.suspend_disable_irqs();
+
 	/* Disable the decrementer, so that it doesn't interfere
 	 * with suspending.
 	 */
@@ -642,23 +646,11 @@ static void generic_suspend_disable_irqs(void)
 	set_dec(decrementer_max);
 }
 
-static void generic_suspend_enable_irqs(void)
-{
-	local_irq_enable();
-}
-
-/* Overrides the weak version in kernel/power/main.c */
-void arch_suspend_disable_irqs(void)
-{
-	if (ppc_md.suspend_disable_irqs)
-		ppc_md.suspend_disable_irqs();
-	generic_suspend_disable_irqs();
-}
-
 /* Overrides the weak version in kernel/power/main.c */
 void arch_suspend_enable_irqs(void)
 {
-	generic_suspend_enable_irqs();
+	local_irq_enable();
+
 	if (ppc_md.suspend_enable_irqs)
 		ppc_md.suspend_enable_irqs();
 }
-- 
2.25.0

