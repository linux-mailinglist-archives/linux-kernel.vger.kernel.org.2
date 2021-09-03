Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4263FFED5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 13:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbhICLTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 07:19:42 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:51003 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240932AbhICLTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 07:19:38 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H1FfN4VPQz9sT5;
        Fri,  3 Sep 2021 13:18:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mJZtaCtZJkad; Fri,  3 Sep 2021 13:18:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H1FfN3WZ1z9sT0;
        Fri,  3 Sep 2021 13:18:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 637378B8E3;
        Fri,  3 Sep 2021 13:18:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id paAqqchCTTBg; Fri,  3 Sep 2021 13:18:36 +0200 (CEST)
Received: from po18078vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 33C148B764;
        Fri,  3 Sep 2021 13:18:36 +0200 (CEST)
Received: by po18078vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 03FC863D74; Fri,  3 Sep 2021 11:18:36 +0000 (UTC)
Message-Id: <b7f73ed02a2e20ac9a143d604030c46d29e8796c.1630667612.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1630667612.git.christophe.leroy@csgroup.eu>
References: <cover.1630667612.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 01/11] powerpc/time: Remove
 generic_suspend_{dis/en}able_irqs()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  3 Sep 2021 11:18:36 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d75d68cfef49 ("powerpc: Clean up obsolete code relating to
decrementer and timebase") made generic_suspend_enable_irqs() and
generic_suspend_disable_irqs() static.

Fold them into their only caller.

Reviewed-by: Daniel Axtens <dja@axtens.net>
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

