Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6978731F883
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 12:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhBSLlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 06:41:05 -0500
Received: from foss.arm.com ([217.140.110.172]:34212 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhBSLka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 06:40:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEDD512FC;
        Fri, 19 Feb 2021 03:39:44 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 78A8B3F694;
        Fri, 19 Feb 2021 03:39:43 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st,
        mark.rutland@arm.com, maz@kernel.org, tglx@linutronix.de,
        will@kernel.org
Subject: [PATCH 4/8] arm64: don't use GENERIC_IRQ_MULTI_HANDLER
Date:   Fri, 19 Feb 2021 11:39:00 +0000
Message-Id: <20210219113904.41736-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210219113904.41736-1-mark.rutland@arm.com>
References: <20210219113904.41736-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

In subsequent patches we want to allow irqchip drivers to register as
FIQ handlers, with a set_handle_fiq() function. To keep the IRQ/FIQ
paths similar, we want arm64 to provide both set_handle_irq() and
set_handle_fiq(), rather than using GENERIC_IRQ_MULTI_HANDLER for the
former.

This patch adds an arm64-specific implementation of set_handle_irq().
There should be no functional change as a result of this patch.

Signed-off-by: Marc Zyngier <maz@kernel.org>
[Mark: use a single handler pointer]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Hector Martin <marcan@marcan.st>
Cc: James Morse <james.morse@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/Kconfig           |  1 -
 arch/arm64/include/asm/irq.h |  3 +++
 arch/arm64/kernel/irq.c      | 11 +++++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f39568b28ec1..6094214df91b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -108,7 +108,6 @@ config ARM64
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_IPI
-	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index b2b0c6405eb0..8391c6f6f746 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -8,6 +8,9 @@
 
 struct pt_regs;
 
+int set_handle_irq(void (*handle_irq)(struct pt_regs *));
+#define set_handle_irq	set_handle_irq
+
 static inline int nr_legacy_irqs(void)
 {
 	return 0;
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index dfb1feab867d..ad63bd50fa7b 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -71,6 +71,17 @@ static void init_irq_stacks(void)
 }
 #endif
 
+void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
+
+int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
+{
+	if (handle_arch_irq)
+		return -EBUSY;
+
+	handle_arch_irq = handle_irq;
+	return 0;
+}
+
 void __init init_IRQ(void)
 {
 	init_irq_stacks();
-- 
2.11.0

