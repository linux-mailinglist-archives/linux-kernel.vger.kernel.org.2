Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A3C3907C1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhEYRey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:34:54 -0400
Received: from foss.arm.com ([217.140.110.172]:33028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232220AbhEYRer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:34:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2E9B1516;
        Tue, 25 May 2021 10:33:16 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B1F8A3F73B;
        Tue, 25 May 2021 10:33:15 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [RFC PATCH v2 01/10] genirq: Add chip flag to denote automatic IRQ (un)masking
Date:   Tue, 25 May 2021 18:32:46 +0100
Message-Id: <20210525173255.620606-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210525173255.620606-1-valentin.schneider@arm.com>
References: <20210525173255.620606-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some IRQ chips such as the Arm GICs automagically mask / unmask an
IRQ during the handling of said IRQ. This renders further mask / unmask
operations within the flow handlers redundant, which we do want to leverage
as masking by itself is not cheap (Distributor access via MMIO for GICs).

This is different from having a chip->irq_mask_ack() callback as this
masking is:
- inherent to the chip->irq_ack() and *cannot* be omitted
- a *different* masking state than chip->irq_mask() (chip->irq_mask() is
  idempotent, chip->irq_ack() really isn't)

Add a chip flag, IRQCHIP_AUTOMASKS_FLOW, to denote chips with such
behaviour. Add a new IRQ data flag, IRQD_IRQ_FLOW_MASKED, to keep this
flow-induced mask state separate from regular mask / unmask operations
(IRQD_IRQ_MASKED).

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/irq.h    | 10 ++++++++++
 kernel/irq/chip.c      |  5 +++++
 kernel/irq/debugfs.c   |  2 ++
 kernel/irq/internals.h |  5 +++++
 4 files changed, 22 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 8e9a9ae471a6..ef179245a642 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -221,6 +221,8 @@ struct irq_data {
  *				  irq_chip::irq_set_affinity() when deactivated.
  * IRQD_IRQ_ENABLED_ON_SUSPEND	- Interrupt is enabled on suspend by irq pm if
  *				  irqchip have flag IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND set.
+ * IRQD_IRQ_FLOW_MASKED         - Interrupt is masked by ACK. Only EOI can
+ *                                clear this.
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -247,6 +249,7 @@ enum {
 	IRQD_HANDLE_ENFORCE_IRQCTX	= (1 << 28),
 	IRQD_AFFINITY_ON_ACTIVATE	= (1 << 29),
 	IRQD_IRQ_ENABLED_ON_SUSPEND	= (1 << 30),
+	IRQD_IRQ_FLOW_MASKED            = (1 << 31),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -351,6 +354,11 @@ static inline bool irqd_irq_masked(struct irq_data *d)
 	return __irqd_to_state(d) & IRQD_IRQ_MASKED;
 }
 
+static inline bool irqd_irq_flow_masked(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_IRQ_FLOW_MASKED;
+}
+
 static inline bool irqd_irq_inprogress(struct irq_data *d)
 {
 	return __irqd_to_state(d) & IRQD_IRQ_INPROGRESS;
@@ -569,6 +577,7 @@ struct irq_chip {
  * IRQCHIP_SUPPORTS_NMI:              Chip can deliver NMIs, only for root irqchips
  * IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND:  Invokes __enable_irq()/__disable_irq() for wake irqs
  *                                    in the suspend path if they are in disabled state
+ * IRQCHIP_AUTOMASKS_FLOW:            chip->ack() masks and chip->eoi() unmasks
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED			= (1 <<  0),
@@ -581,6 +590,7 @@ enum {
 	IRQCHIP_SUPPORTS_LEVEL_MSI		= (1 <<  7),
 	IRQCHIP_SUPPORTS_NMI			= (1 <<  8),
 	IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND	= (1 <<  9),
+	IRQCHIP_AUTOMASKS_FLOW                  = (1 <<  10),
 };
 
 #include <linux/irqdesc.h>
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 7f04c7d8296e..21a21baa1366 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -173,6 +173,11 @@ static void irq_state_clr_masked(struct irq_desc *desc)
 	irqd_clear(&desc->irq_data, IRQD_IRQ_MASKED);
 }
 
+static void irq_state_clr_flow_masked(struct irq_desc *desc)
+{
+	irqd_clear(&desc->irq_data, IRQD_IRQ_FLOW_MASKED);
+}
+
 static void irq_state_clr_started(struct irq_desc *desc)
 {
 	irqd_clear(&desc->irq_data, IRQD_IRQ_STARTED);
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index e4cff358b437..3ae83622d701 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -58,6 +58,7 @@ static const struct irq_bit_descr irqchip_flags[] = {
 	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_LEVEL_MSI),
 	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_NMI),
 	BIT_MASK_DESCR(IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND),
+	BIT_MASK_DESCR(IRQCHIP_AUTOMASKS_FLOW),
 };
 
 static void
@@ -103,6 +104,7 @@ static const struct irq_bit_descr irqdata_states[] = {
 	BIT_MASK_DESCR(IRQD_IRQ_STARTED),
 	BIT_MASK_DESCR(IRQD_IRQ_DISABLED),
 	BIT_MASK_DESCR(IRQD_IRQ_MASKED),
+	BIT_MASK_DESCR(IRQD_IRQ_FLOW_MASKED),
 	BIT_MASK_DESCR(IRQD_IRQ_INPROGRESS),
 
 	BIT_MASK_DESCR(IRQD_PER_CPU),
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 54363527feea..b6c1cceddec0 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -245,6 +245,11 @@ static inline void irq_state_set_masked(struct irq_desc *desc)
 	irqd_set(&desc->irq_data, IRQD_IRQ_MASKED);
 }
 
+static inline void irq_state_set_flow_masked(struct irq_desc *desc)
+{
+	irqd_set(&desc->irq_data, IRQD_IRQ_FLOW_MASKED);
+}
+
 #undef __irqd_to_state
 
 static inline void __kstat_incr_irqs_this_cpu(struct irq_desc *desc)
-- 
2.25.1

