Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BD43588BD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhDHPoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:44:24 -0400
Received: from foss.arm.com ([217.140.110.172]:52158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231964AbhDHPoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:44:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F2E71424;
        Thu,  8 Apr 2021 08:44:04 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8E9F93F694;
        Thu,  8 Apr 2021 08:44:03 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [RFC PATCH 04/10] genirq: Add handle_strict_flow_irq() flow handler
Date:   Thu,  8 Apr 2021 16:43:20 +0100
Message-Id: <20210408154326.3988781-5-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408154326.3988781-1-valentin.schneider@arm.com>
References: <20210408154326.3988781-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GIC family of irqchips have been so far treated as "fasteoi"
chips. As handle_fasteoi_irq() states, this implies:

 *	Only a single callback will be issued to the chip: an ->eoi()
 *	call when the interrupt has been serviced.

However, the GICs have an operating mode (EOImode=1) which requires an
additional chip interaction during the IRQ handling. Said operating mode
already has some uses with virtualization, but could also be leveraged to
slightly optimize ONESHOT IRQs.

This extra interaction is currently hidden away in the drivers, but further
exploiting its effects (see IRQD_IRQ_FLOW_MASKED) requires lifting it from
the driver code into core code. It so happens that it fits the role of
->irq_ack(); unfortunately, the GICs require both callbacks to be strictly
paired with one another: for a given IRQ activation, there must be a single
->irq_ack() followed by a single ->irq_eoi(). No more, no less, and in that
order.

Introduce a new flow handler which guarantees said ack / eoi pairing. Note
that it is strikingly similar to handle_fasteoi_mask_irq() for now, but
will be further modified in later patches

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/irq.h |  1 +
 kernel/irq/chip.c   | 48 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 580b1b6b1799..b605f0929d97 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -661,6 +661,7 @@ extern void handle_edge_irq(struct irq_desc *desc);
 extern void handle_edge_eoi_irq(struct irq_desc *desc);
 extern void handle_simple_irq(struct irq_desc *desc);
 extern void handle_untracked_irq(struct irq_desc *desc);
+extern void handle_strict_flow_irq(struct irq_desc *desc);
 extern void handle_percpu_irq(struct irq_desc *desc);
 extern void handle_percpu_devid_irq(struct irq_desc *desc);
 extern void handle_bad_irq(struct irq_desc *desc);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 936ef247b13d..6c033b0044cb 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -896,6 +896,54 @@ void handle_edge_eoi_irq(struct irq_desc *desc)
 }
 #endif
 
+/**
+ *	handle_strict_flow_irq - irq handler for strict controllers
+ *	@desc:	the interrupt description structure for this irq
+ *
+ *      Ensures strict pairing of ->ack() and ->eoi() for any IRQ passing
+ *      through here. The ->eoi() may be deferred to the tail of the IRQ thread
+ *      for ONESHOT IRQs.
+ */
+void handle_strict_flow_irq(struct irq_desc *desc)
+{
+	struct irq_chip *chip = desc->irq_data.chip;
+
+	raw_spin_lock(&desc->lock);
+	mask_ack_irq(desc);
+
+	if (!irq_may_run(desc))
+		goto out;
+
+	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
+
+	/*
+	 * If it's disabled or no action available then keep it masked and
+	 * get out of here:
+	 */
+	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
+		desc->istate |= IRQS_PENDING;
+		goto out;
+	}
+
+	kstat_incr_irqs_this_cpu(desc);
+
+	handle_irq_event(desc);
+
+	cond_unmask_eoi_irq(desc, chip);
+
+	raw_spin_unlock(&desc->lock);
+	return;
+out:
+	/*
+	 * XXX: this is where IRQCHIP_EOI_IF_HANDLED would be checked, but
+	 * it's conceptually incompatible with this handler (it breaks the
+	 * strict pairing)
+	 */
+	eoi_irq(desc);
+	raw_spin_unlock(&desc->lock);
+}
+EXPORT_SYMBOL_GPL(handle_strict_flow_irq);
+
 /**
  *	handle_percpu_irq - Per CPU local irq handler
  *	@desc:	the interrupt description structure for this irq
-- 
2.25.1

