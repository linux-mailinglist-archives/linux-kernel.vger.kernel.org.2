Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AE13EA73E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238462AbhHLPNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237883AbhHLPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:13:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F947C0617AF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:13:03 -0700 (PDT)
Date:   Thu, 12 Aug 2021 15:13:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628781181;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uuUiL3yiyRQ/gc3VHDD9g+NiKKDuSGDSsL0PewhWnmE=;
        b=r5McXeixDeyNn4/OydG31VL0vpInLhlUwNhQkjhUvSWbOs6pAP9TFzGSjjKDBZIcLIVY7e
        mDKx9r0GucyUb8dFige0PKI5S/8zBCDAsE62gLrPxppFPdDeXaeClkdGKQB4SrHKfm8wkI
        9n7V6fOSn9KXSk6pEf3QuWDKLwqyNfIWHUjIdysYN0gTg1wfZJHdRhS7NbYigkBTbk+qkk
        1jDVp+EPXfJpdevG6mtiFB1qq9h5HCGhr8ms6cpTfhZ1zLRdBLCKejYhnqCjUAvbETIYtW
        VDQXrDkIsH9uJcu9Iwc8lwSjQwKj5T6Oh0GL+TEER4z1qK6bXJFBXmTckfJ8YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628781181;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uuUiL3yiyRQ/gc3VHDD9g+NiKKDuSGDSsL0PewhWnmE=;
        b=XO9Mb62bAL7W25hrrbn9AhDTqLUEB/1g7JakTtEMozdQaOCm16hxn/9T2ZymnYqawxy9fv
        IW+9flA4zTe/17Dg==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq, irq-gic-v3: Make NMI flow
 handlers use ->irq_ack() if available
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210629125010.458872-8-valentin.schneider@arm.com>
References: <20210629125010.458872-8-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <162878118109.395.10790736982071982547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     56707bb845f573a1ae2fc3fc57f1ecb4869c7c89
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/56707bb845f573a1ae2fc3fc57f1ecb4869c7c89
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 29 Jun 2021 13:50:04 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 15:48:20 +01:00

genirq, irq-gic-v3: Make NMI flow handlers use ->irq_ack() if available

Subsequent patches will make the gic-v3 irqchip use an ->irq_ack()
callback. As a preparation, make the NMI flow handlers call said callback
if it is available.

Since this departs from the fasteoi scheme of only issuing a suffix
->eoi(), rename the NMI flow handlers.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210629125010.458872-8-valentin.schneider@arm.com
---
 drivers/irqchip/irq-gic-v3.c |  4 ++--
 include/linux/irq.h          |  4 ++--
 kernel/irq/chip.c            | 25 ++++++++++++++-----------
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e0f4deb..cdffffc 100644
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
index 3707592..0b45e42 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -669,8 +669,8 @@ extern void handle_percpu_devid_irq(struct irq_desc *desc);
 extern void handle_bad_irq(struct irq_desc *desc);
 extern void handle_nested_irq(unsigned int irq);
 
-extern void handle_fasteoi_nmi(struct irq_desc *desc);
-extern void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc);
+extern void handle_nmi(struct irq_desc *desc);
+extern void handle_percpu_devid_nmi(struct irq_desc *desc);
 
 extern int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg);
 extern int irq_chip_pm_get(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index c2ca6b7..099bc7e 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -748,18 +748,16 @@ out:
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
@@ -1032,14 +1033,13 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
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
@@ -1048,6 +1048,9 @@ void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc)
 
 	__kstat_incr_irqs_this_cpu(desc);
 
+	if (chip->irq_ack)
+		chip->irq_ack(&desc->irq_data);
+
 	trace_irq_handler_entry(irq, action);
 	res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
 	trace_irq_handler_exit(irq, action, res);
