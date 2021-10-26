Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA7C43AFD1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbhJZKSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:18:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60698 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbhJZKSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:18:24 -0400
Date:   Tue, 26 Oct 2021 10:15:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635243359;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PXDCiqZpVzx0Yd/lrvfUnE39lklRRUocPmHwIiZMipo=;
        b=tf/DdOa/uCCSJ7zJ1MVz5WM9WpwFt/wdRUv9kzmcb/hVPg31zNaEXozVkGGrpcJVvKjAEB
        LzAUr1v8ZM0ep+9yTMUhXrY+dN2256zHtfja1FGl7rPnSvl82cEmSAgGKmRGffeK6mw4vJ
        Xy9Hb8Usx6nlwwZlp9vv2PR5gn2FxW+46lGWoKIRW9lZNUojJ6YV/BudSEaRrR1KsXOcx5
        WYym8Yn+ULall2ZBzN+epK4eA7V4zMr6H68XiToMYYCrZhOdsqmPoaqCz0j4DNVWp9T60r
        IlTMxju/WLql7PKZ3RiMydv1fXSF2tlrI16ouSwvkhI9MkyubvNLZI2V+jujNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635243359;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PXDCiqZpVzx0Yd/lrvfUnE39lklRRUocPmHwIiZMipo=;
        b=6CREFTK/vmUBHNsyQTKwD7E/xCjU/3xuaVnX/bo0L2rxXQPgQ4UNP0MNtLtlk8xxabLT4/
        IxAYuPc5XNY9S2Bg==
From:   "irqchip-bot for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irq: openrisc: perform irqentry in entry code
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Message-ID: <163524335898.626.17588762716963486865.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     418360b23113d62aa99586ada37806b4a7a53afa
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/418360b23113d62aa99586ada37806b4a7a53afa
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 20 Oct 2021 11:31:56 +01:00
Committer:     Mark Rutland <mark.rutland@arm.com>
CommitterDate: Tue, 26 Oct 2021 10:13:28 +01:00

irq: openrisc: perform irqentry in entry code

In preparation for removing HANDLE_DOMAIN_IRQ_IRQENTRY, have
arch/openrisc perform all the irqentry accounting in its entry code. As
arch/openrisc uses GENERIC_IRQ_MULTI_HANDLER, we can use
generic_handle_arch_irq() to do so.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Stafford Horne <shorne@gmail.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/openrisc/Kconfig        | 1 -
 arch/openrisc/kernel/entry.S | 4 ++--
 arch/openrisc/kernel/irq.c   | 5 -----
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index ed783a6..e804026 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -14,7 +14,6 @@ config OPENRISC
 	select OF_EARLY_FLATTREE
 	select IRQ_DOMAIN
 	select HANDLE_DOMAIN_IRQ
-	select HANDLE_DOMAIN_IRQ_IRQENTRY
 	select GPIOLIB
 	select HAVE_ARCH_TRACEHOOK
 	select SPARSE_IRQ
diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index edaa775..59c6d3a 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -569,8 +569,8 @@ EXCEPTION_ENTRY(_external_irq_handler)
 #endif
 	CLEAR_LWA_FLAG(r3)
 	l.addi	r3,r1,0
-	l.movhi	r8,hi(do_IRQ)
-	l.ori	r8,r8,lo(do_IRQ)
+	l.movhi	r8,hi(generic_handle_arch_irq)
+	l.ori	r8,r8,lo(generic_handle_arch_irq)
 	l.jalr r8
 	l.nop
 	l.j    _ret_from_intr
diff --git a/arch/openrisc/kernel/irq.c b/arch/openrisc/kernel/irq.c
index c38fa86..f38e109 100644
--- a/arch/openrisc/kernel/irq.c
+++ b/arch/openrisc/kernel/irq.c
@@ -36,8 +36,3 @@ void __init init_IRQ(void)
 {
 	irqchip_init();
 }
-
-void __irq_entry do_IRQ(struct pt_regs *regs)
-{
-	handle_arch_irq(regs);
-}
