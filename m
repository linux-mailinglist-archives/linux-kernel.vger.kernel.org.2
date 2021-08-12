Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C0E3EA741
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbhHLPOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:14:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59144 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237905AbhHLPN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:13:29 -0400
Date:   Thu, 12 Aug 2021 15:13:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628781183;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w2rnuiEvzjOsgWYxMNSCVAXMs+Tw4JTNQpwt6qoA5HY=;
        b=vm6fu7r01sPTyUrZsD8BFekCboxp0/sO5DjzeK333R5blASnv117rYonJj/qJva1hvZHgh
        auagUZ6pLgN/4bmqzpfSnolZGloPfvHSYKqJtdfVgVdn3Yuc7fZDpDom4SqvSzgeLooVn/
        GPrWTT5CLer3KE8K2Jdp/pmj70j2FcyNSputxWCdzoUBBbE/7bG8dlu7v1kIJWpXNTcSQT
        8vqVQMG3dDuyXMjkNmGv6b3OK+zsf/ARUq4nXDD4avsXgJyARncnw7YjiO+BYpeFS+RyS0
        6JbSVXzj8aBeHF0dYZIKlOqJMkTZN88P1gQ6ihkntszaZgbgEkj5Y5cuWW8EMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628781183;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w2rnuiEvzjOsgWYxMNSCVAXMs+Tw4JTNQpwt6qoA5HY=;
        b=UDFLbw+xrq2l6zPKqlsnrX09qGnSJuyMuJL5io4Evbrp+QefpKLQMuEIY64puuNQmzPBHi
        3v0+8Z9up0o6UABw==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Add handle_strict_flow_irq() flow handler
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210629125010.458872-5-valentin.schneider@arm.com>
References: <20210629125010.458872-5-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <162878118280.395.16422884377783289280.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     9d76bea7b1b4d664ff1f165c783b70c5bbaaf23b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9d76bea7b1b4d664ff1f165c783b70c5bbaaf23b
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 29 Jun 2021 13:50:01 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 15:48:20 +01:00

genirq: Add handle_strict_flow_irq() flow handler

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
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210629125010.458872-5-valentin.schneider@arm.com
---
 include/linux/irq.h |  1 +-
 kernel/irq/chip.c   | 48 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index ef17924..3707592 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -663,6 +663,7 @@ extern void handle_edge_irq(struct irq_desc *desc);
 extern void handle_edge_eoi_irq(struct irq_desc *desc);
 extern void handle_simple_irq(struct irq_desc *desc);
 extern void handle_untracked_irq(struct irq_desc *desc);
+extern void handle_strict_flow_irq(struct irq_desc *desc);
 extern void handle_percpu_irq(struct irq_desc *desc);
 extern void handle_percpu_devid_irq(struct irq_desc *desc);
 extern void handle_bad_irq(struct irq_desc *desc);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 4d3bde5..699e70b 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -897,6 +897,54 @@ out_eoi:
 #endif
 
 /**
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
+/**
  *	handle_percpu_irq - Per CPU local irq handler
  *	@desc:	the interrupt description structure for this irq
  *
