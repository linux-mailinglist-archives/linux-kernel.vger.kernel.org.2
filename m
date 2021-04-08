Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D413588C0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhDHPo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:44:29 -0400
Received: from foss.arm.com ([217.140.110.172]:52192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232056AbhDHPoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:44:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42F38D6E;
        Thu,  8 Apr 2021 08:44:08 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 428A13F694;
        Thu,  8 Apr 2021 08:44:07 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [RFC PATCH 07/10] genirq, irq-gic-v3: Make NMI flow handlers use ->irq_ack() if available
Date:   Thu,  8 Apr 2021 16:43:23 +0100
Message-Id: <20210408154326.3988781-8-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408154326.3988781-1-valentin.schneider@arm.com>
References: <20210408154326.3988781-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subsequent patches will make the gic-v3 irqchip use an ->irq_ack()
callback. As a preparation, make the NMI flow handlers call said callback
if it is available.

Since this departs from the fasteoi scheme of only issuing a suffix
->eoi(), rename the NMI flow handlers.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 drivers/irqchip/irq-gic-v3.c |  4 ++--
 include/linux/irq.h          |  4 ++--
 kernel/irq/chip.c            | 25 ++++++++++++++-----------
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 94b89258d045..242a8fc5ec86 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -484,10 +484,10 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 		/* Setting up PPI as NMI, only switch handler for first NMI */
 		if (!refcount_inc_not_zero(&ppi_nmi_refs[idx])) {
 			refcount_set(&ppi_nmi_refs[idx], 1);
-			desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
+			desc->handle_irq = handle_percpu_devid_nmi;
 		}
 	} else {
-		desc->handle_irq = handle_fasteoi_nmi;
+		desc->handle_irq = handle_nmi;
 	}
 
 	gic_irq_set_prio(d, GICD_INT_NMI_PRI);
diff --git a/include/linux/irq.h b/include/linux/irq.h
index b605f0929d97..c39f46e37487 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -667,8 +667,8 @@ extern void handle_percpu_devid_irq(struct irq_desc *desc);
 extern void handle_bad_irq(struct irq_desc *desc);
 extern void handle_nested_irq(unsigned int irq);
 
-extern void handle_fasteoi_nmi(struct irq_desc *desc);
-extern void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc);
+extern void handle_nmi(struct irq_desc *desc);
+extern void handle_percpu_devid_nmi(struct irq_desc *desc);
 
 extern int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg);
 extern int irq_chip_pm_get(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 1add0b4f0662..ea077333d676 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -748,18 +748,16 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 EXPORT_SYMBOL_GPL(handle_fasteoi_irq);
 
 /**
- *	handle_fasteoi_nmi - irq handler for NMI interrupt lines
+ *	handle_nmi - irq handler for NMI interrupt lines
  *	@desc:	the interrupt description structure for this irq
  *
  *	A simple NMI-safe handler, considering the restrictions
  *	from request_nmi.
  *
- *	Only a single callback will be issued to the chip: an ->eoi()
- *	call when the interrupt has been serviced. This enables support
- *	for modern forms of interrupt handlers, which handle the flow
- *	details in hardware, transparently.
+ *      An ->ack() callback will be issued before servicing the interrupt,
+ *      followed by an ->eoi() call.
  */
-void handle_fasteoi_nmi(struct irq_desc *desc)
+void handle_nmi(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irqaction *action = desc->action;
@@ -768,6 +766,9 @@ void handle_fasteoi_nmi(struct irq_desc *desc)
 
 	__kstat_incr_irqs_this_cpu(desc);
 
+	if (chip->irq_ack)
+		chip->irq_ack(&desc->irq_data);
+
 	trace_irq_handler_entry(irq, action);
 	/*
 	 * NMIs cannot be shared, there is only one action.
@@ -778,7 +779,7 @@ void handle_fasteoi_nmi(struct irq_desc *desc)
 	if (chip->irq_eoi)
 		chip->irq_eoi(&desc->irq_data);
 }
-EXPORT_SYMBOL_GPL(handle_fasteoi_nmi);
+EXPORT_SYMBOL_GPL(handle_nmi);
 
 /**
  *	handle_edge_irq - edge type IRQ handler
@@ -1027,14 +1028,13 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 }
 
 /**
- * handle_percpu_devid_fasteoi_nmi - Per CPU local NMI handler with per cpu
+ * handle_percpu_devid_nmi - Per CPU local NMI handler with per cpu
  *				     dev ids
  * @desc:	the interrupt description structure for this irq
  *
- * Similar to handle_fasteoi_nmi, but handling the dev_id cookie
- * as a percpu pointer.
+ * Similar to handle_nmi, but handling the dev_id cookie as a percpu pointer.
  */
-void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc)
+void handle_percpu_devid_nmi(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irqaction *action = desc->action;
@@ -1043,6 +1043,9 @@ void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc)
 
 	__kstat_incr_irqs_this_cpu(desc);
 
+	if (chip->irq_ack)
+		chip->irq_ack(&desc->irq_data);
+
 	trace_irq_handler_entry(irq, action);
 	res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
 	trace_irq_handler_exit(irq, action, res);
-- 
2.25.1

