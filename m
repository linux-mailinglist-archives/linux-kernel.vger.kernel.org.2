Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44A332A461
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578055AbhCBKfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:35:18 -0500
Received: from foss.arm.com ([217.140.110.172]:48358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382775AbhCBKP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:15:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D338513A1;
        Tue,  2 Mar 2021 02:12:31 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9BDA33F70D;
        Tue,  2 Mar 2021 02:12:30 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st,
        mark.rutland@arm.com, maz@kernel.org, tglx@linutronix.de,
        will@kernel.org
Subject: [PATCHv2 5/8] arm64: irq: rework root IRQ handler registration
Date:   Tue,  2 Mar 2021 10:12:08 +0000
Message-Id: <20210302101211.2328-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210302101211.2328-1-mark.rutland@arm.com>
References: <20210302101211.2328-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we accidentally unmask IRQs before we've registered a root IRQ
handler, handle_arch_irq will be NULL, and the IRQ exception handler
will branch to a bogus address.

To make this easier to debug, this patch initialises handle_arch_irq to
a default handler which will panic(), making such problems easier to
debug. When we add support for FIQ handlers, we can follow the same
approach.

When we add support for a root FIQ handler, it's possible to have root
IRQ handler without an root FIQ handler, and in theory the inverse is
also possible. To permit this, and to keep the IRQ/FIQ registration
logic similar, this patch removes the panic in the absence of a root IRQ
controller. Instead, set_handle_irq() logs when a handler is registered,
which is sufficient for debug purposes.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Hector Martin <marcan@marcan.st>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/irq.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index ad63bd50fa7b..2fe0b535de30 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -71,14 +71,20 @@ static void init_irq_stacks(void)
 }
 #endif
 
-void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
+static void default_handle_irq(struct pt_regs *regs)
+{
+	panic("IRQ taken without a root IRQ handler\n");
+}
+
+void (*handle_arch_irq)(struct pt_regs *) __ro_after_init = default_handle_irq;
 
 int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 {
-	if (handle_arch_irq)
+	if (handle_arch_irq != default_handle_irq)
 		return -EBUSY;
 
 	handle_arch_irq = handle_irq;
+	pr_info("Root IRQ handler: %ps\n", handle_irq);
 	return 0;
 }
 
@@ -87,8 +93,6 @@ void __init init_IRQ(void)
 	init_irq_stacks();
 	init_irq_scs();
 	irqchip_init();
-	if (!handle_arch_irq)
-		panic("No interrupt controller found.");
 
 	if (system_uses_irq_prio_masking()) {
 		/*
-- 
2.11.0

