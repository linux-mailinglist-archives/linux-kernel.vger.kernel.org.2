Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC9C4369F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 20:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhJUSFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 14:05:38 -0400
Received: from foss.arm.com ([217.140.110.172]:46016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232524AbhJUSF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:05:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2754ED1;
        Thu, 21 Oct 2021 11:03:12 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 107D53F70D;
        Thu, 21 Oct 2021 11:03:09 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     aou@eecs.berkeley.edu, catalin.marinas@arm.com,
        deanbo422@gmail.com, green.hu@gmail.com, guoren@kernel.org,
        jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, maz@kernel.org, nickhu@andestech.com,
        palmer@dabbelt.com, paulmck@kernel.org, paul.walmsley@sifive.com,
        peterz@infradead.org, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        torvalds@linux-foundation.org, tsbogend@alpha.franken.de,
        vgupta@kernel.org, will@kernel.org
Subject: [PATCH 07/15] irq: nds32: avoid CONFIG_HANDLE_DOMAIN_IRQ
Date:   Thu, 21 Oct 2021 19:02:28 +0100
Message-Id: <20211021180236.37428-8-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211021180236.37428-1-mark.rutland@arm.com>
References: <20211021180236.37428-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing HANDLE_DOMAIN_IRQ, have arch/nds32 perform
all the necessary IRQ entry accounting in its entry code.

Currently arch/nds32 is tightly coupled with the ativic32 irqchip, and
while the entry code should logically live under arch/nds32/, moving the
entry logic there makes things more convoluted. So for now, place the
entry logic in the ativic32 irqchip, but separated into a separate
function to make the split of responsibility clear.

In future this should probably use GENERIC_IRQ_MULTI_HANDLER to cleanly
decouple this.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Nick Hu <nickhu@andestech.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincent Chen <deanbo422@gmail.com>
---
 arch/nds32/Kconfig             |  1 -
 drivers/irqchip/irq-ativic32.c | 22 ++++++++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index aea26e739543..4d1421b18734 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -27,7 +27,6 @@ config NDS32
 	select GENERIC_LIB_MULDI3
 	select GENERIC_LIB_UCMPDI2
 	select GENERIC_TIME_VSYSCALL
-	select HANDLE_DOMAIN_IRQ
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_EXIT_THREAD
diff --git a/drivers/irqchip/irq-ativic32.c b/drivers/irqchip/irq-ativic32.c
index 476d6024aaf2..223dd2f97d28 100644
--- a/drivers/irqchip/irq-ativic32.c
+++ b/drivers/irqchip/irq-ativic32.c
@@ -5,11 +5,14 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
+#include <linux/hardirq.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/irqchip.h>
 #include <nds32_intrinsic.h>
 
+#include <asm/irq_regs.h>
+
 unsigned long wake_mask;
 
 static void ativic32_ack_irq(struct irq_data *data)
@@ -103,10 +106,25 @@ static irq_hw_number_t get_intr_src(void)
 		- NDS32_VECTOR_offINTERRUPT;
 }
 
-asmlinkage void asm_do_IRQ(struct pt_regs *regs)
+static void ativic32_handle_irq(struct pt_regs *regs)
 {
 	irq_hw_number_t hwirq = get_intr_src();
-	handle_domain_irq(root_domain, hwirq, regs);
+	generic_handle_domain_irq(root_domain, hwirq);
+}
+
+/*
+ * TODO: convert nds32 to GENERIC_IRQ_MULTI_HANDLER so that this entry logic
+ * can live in arch code.
+ */
+asmlinkage void asm_do_IRQ(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs;
+
+	irq_enter();
+	old_regs = set_irq_regs(regs);
+	ativic32_handle_irq(regs);
+	set_irq_regs(old_regs);
+	irq_exit();
 }
 
 int __init ativic32_init_irq(struct device_node *node, struct device_node *parent)
-- 
2.11.0

