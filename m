Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CD33907C6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhEYRfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:35:11 -0400
Received: from foss.arm.com ([217.140.110.172]:33076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233922AbhEYRex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:34:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC6081692;
        Tue, 25 May 2021 10:33:22 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF75F3F73B;
        Tue, 25 May 2021 10:33:21 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [RFC PATCH v2 06/10] genirq: Don't mask IRQ within flow handler if IRQ is flow-masked
Date:   Tue, 25 May 2021 18:32:51 +0100
Message-Id: <20210525173255.620606-7-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210525173255.620606-1-valentin.schneider@arm.com>
References: <20210525173255.620606-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mask_irq() lets an IRQ with IRQD_IRQ_FLOW_MASKED set be further masked via
chip->irq_mask(). This is necessary for unhandled IRQs as we want to keep
them masked beyond eoi_irq() (which clears IRQD_IRQ_FLOW_MASKED).

This is however not necessary in paths that do end up handling the IRQ and
are bounded by a final eoi_irq() - this is the case for chips with
IRQCHIP_AUTOMASKS_FLOW and IRQCHIP_EOI_THREADED.

Make handle_strict_flow_irq() leverage IRQCHIP_AUTOMASKS_FLOW and issue an
ack_irq() rather than a mask_ack_irq() when possible.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/irq/chip.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 699e70b51aae..c2ca6b748987 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -896,6 +896,12 @@ void handle_edge_eoi_irq(struct irq_desc *desc)
 }
 #endif
 
+/*
+ * AUTOMASKS_FLOW tells us ack/eoi handle the masking, EOI_THREADED tells us
+ * that masking will persist until irq_finalize_oneshot()
+ */
+#define ONESHOT_AUTOMASK_FLAGS (IRQCHIP_AUTOMASKS_FLOW | IRQCHIP_EOI_THREADED)
+
 /**
  *	handle_strict_flow_irq - irq handler for strict controllers
  *	@desc:	the interrupt description structure for this irq
@@ -909,10 +915,9 @@ void handle_strict_flow_irq(struct irq_desc *desc)
 	struct irq_chip *chip = desc->irq_data.chip;
 
 	raw_spin_lock(&desc->lock);
-	mask_ack_irq(desc);
 
 	if (!irq_may_run(desc))
-		goto out;
+		goto out_mask;
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
 
@@ -922,10 +927,20 @@ void handle_strict_flow_irq(struct irq_desc *desc)
 	 */
 	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
 		desc->istate |= IRQS_PENDING;
-		goto out;
+		goto out_mask;
 	}
 
 	kstat_incr_irqs_this_cpu(desc);
+	/*
+	 * Masking is required if IRQ is ONESHOT and we can't rely on the
+	 * flow-masking persisting down to irq_finalize_oneshot()
+	 * (in the IRQ thread).
+	 */
+	if ((desc->istate & IRQS_ONESHOT) &&
+	    ((chip->flags & ONESHOT_AUTOMASK_FLAGS) != ONESHOT_AUTOMASK_FLAGS))
+		mask_ack_irq(desc);
+	else
+		ack_irq(desc);
 
 	handle_irq_event(desc);
 
@@ -933,7 +948,8 @@ void handle_strict_flow_irq(struct irq_desc *desc)
 
 	raw_spin_unlock(&desc->lock);
 	return;
-out:
+out_mask:
+	mask_ack_irq(desc);
 	/*
 	 * XXX: this is where IRQCHIP_EOI_IF_HANDLED would be checked, but
 	 * it's conceptually incompatible with this handler (it breaks the
-- 
2.25.1

