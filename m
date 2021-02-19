Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F8D31F884
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 12:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhBSLld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 06:41:33 -0500
Received: from foss.arm.com ([217.140.110.172]:34264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230428AbhBSLkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 06:40:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9352D13A1;
        Fri, 19 Feb 2021 03:39:46 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5D0E73F694;
        Fri, 19 Feb 2021 03:39:45 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st,
        mark.rutland@arm.com, maz@kernel.org, tglx@linutronix.de,
        will@kernel.org
Subject: [PATCH 5/8] arm64: irq: add a default handle_irq panic function
Date:   Fri, 19 Feb 2021 11:39:01 +0000
Message-Id: <20210219113904.41736-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210219113904.41736-1-mark.rutland@arm.com>
References: <20210219113904.41736-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we accidentally unmask IRQs before we've registered an IRQ
controller, handle_arch_irq will be NULL, and the IRQ exception handler
will branch to a bogus address.

To make this easier to debug, this patch initialises handle_arch_irq to
a default handler which will panic(), making such problems easier to
debug. When we add support for FIQ handlers, we can follow the same
approach.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Hector Martin <marcan@marcan.st>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/irq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index ad63bd50fa7b..00bcf37aa0ea 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -71,11 +71,16 @@ static void init_irq_stacks(void)
 }
 #endif
 
-void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
+void default_handle_irq(struct pt_regs *regs)
+{
+	panic("IRQ taken without a registered IRQ controller\n");
+}
+
+void (*handle_arch_irq)(struct pt_regs *) __ro_after_init = default_handle_irq;
 
 int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 {
-	if (handle_arch_irq)
+	if (handle_arch_irq != default_handle_irq)
 		return -EBUSY;
 
 	handle_arch_irq = handle_irq;
@@ -87,7 +92,7 @@ void __init init_IRQ(void)
 	init_irq_stacks();
 	init_irq_scs();
 	irqchip_init();
-	if (!handle_arch_irq)
+	if (handle_arch_irq == default_handle_irq)
 		panic("No interrupt controller found.");
 
 	if (system_uses_irq_prio_masking()) {
-- 
2.11.0

