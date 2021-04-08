Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AB43588BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhDHPoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:44:19 -0400
Received: from foss.arm.com ([217.140.110.172]:52136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231907AbhDHPoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:44:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25FE811D4;
        Thu,  8 Apr 2021 08:44:02 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 24BCE3F694;
        Thu,  8 Apr 2021 08:44:01 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [RFC PATCH 02/10] genirq: Define irq_ack() and irq_eoi() helpers
Date:   Thu,  8 Apr 2021 16:43:18 +0100
Message-Id: <20210408154326.3988781-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408154326.3988781-1-valentin.schneider@arm.com>
References: <20210408154326.3988781-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly-added IRQCHIP_AUTOMASKS_FLOW flag requires some additional
bookkeeping around chip->{irq_ack, irq_eoi}() calls. Define wrappers around
those chip callbacks to drive the IRQD_IRQ_FLOW_MASKED state of an IRQ when
the chip has the IRQCHIP_AUTOMASKS_FLOW flag.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/irq/chip.c      | 16 ++++++++++++++++
 kernel/irq/internals.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 18c3b0e1568a..046b4486c88c 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -408,6 +408,22 @@ void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu)
 	cpumask_clear_cpu(cpu, desc->percpu_enabled);
 }
 
+void ack_irq(struct irq_desc *desc)
+{
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
+
+	if (desc->irq_data.chip->flags & IRQCHIP_AUTOMASKS_FLOW)
+		irq_state_set_flow_masked(desc);
+}
+
+void eoi_irq(struct irq_desc *desc)
+{
+	desc->irq_data.chip->irq_eoi(&desc->irq_data);
+
+	if (desc->irq_data.chip->flags & IRQCHIP_AUTOMASKS_FLOW)
+		irq_state_clr_flow_masked(desc);
+}
+
 static inline void mask_ack_irq(struct irq_desc *desc)
 {
 	if (desc->irq_data.chip->irq_mask_ack) {
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index b6c1cceddec0..090bd7868845 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -87,6 +87,8 @@ extern void irq_enable(struct irq_desc *desc);
 extern void irq_disable(struct irq_desc *desc);
 extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
 extern void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu);
+extern void irq_ack(struct irq_desc *desc);
+extern void irq_eoi(struct irq_desc *desc);
 extern void mask_irq(struct irq_desc *desc);
 extern void unmask_irq(struct irq_desc *desc);
 extern void unmask_threaded_irq(struct irq_desc *desc);
-- 
2.25.1

