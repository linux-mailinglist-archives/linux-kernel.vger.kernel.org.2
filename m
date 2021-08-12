Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8104A3EA740
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbhHLPNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:13:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59132 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237875AbhHLPN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:13:29 -0400
Date:   Thu, 12 Aug 2021 15:13:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628781182;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBrXdQJHrHv14jlMCVxQ09o/PMH01GRp5d0QHSEUFxM=;
        b=IswOXFXkq+jTBY/jORdAMy74TbqvMTvMG24++YfqGmjl4PTC9WN3AZjWTETJhcqJvSwaEA
        hm3AFUssdaJbUAy8ltPy5Shx5J1PpxpojSzKYrmvnOWqakrDZw9FW67jc8hXNGO3SnPNG8
        VBzNYBwS6+rJiSg5Sc0+cqnQPmy7kAy30Au4KBSdXnsCa2EXyCNuUteAyKMyPIL/ryJ/Gr
        66YP8uF/yVvV5Yr08X5vLHqgmKyKzjFH9eFOVoVoq6BfQ38ZPEyGFQdei1QrkFdYLKyUAq
        Aqrley5R6T2+v8wI2fBx2HaDr+MD0AG/PrVOUrlBg4Tm2mgwVZn7j/Bf8hBVbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628781182;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBrXdQJHrHv14jlMCVxQ09o/PMH01GRp5d0QHSEUFxM=;
        b=lYebG/aI5KVelHKBKjUFj6ENEpiCUPPLtQGZfZz5bu2gJ/vfoq6X9PdDxp0td+xbbP3dQ/
        99RWHEXsSZHjD0BA==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Don't mask IRQ within flow
 handler if IRQ is flow-masked
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210629125010.458872-7-valentin.schneider@arm.com>
References: <20210629125010.458872-7-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <162878118167.395.5608150458715480528.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     32797fe1c8ee8b9ccbefa14ae5540d4f020a3387
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/32797fe1c8ee8b9ccbefa14ae5540d4f020a3387
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 29 Jun 2021 13:50:03 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 15:48:20 +01:00

genirq: Don't mask IRQ within flow handler if IRQ is flow-masked

mask_irq() lets an IRQ with IRQD_IRQ_FLOW_MASKED set be further masked via
chip->irq_mask(). This is necessary for unhandled IRQs as we want to keep
them masked beyond eoi_irq() (which clears IRQD_IRQ_FLOW_MASKED).

This is however not necessary in paths that do end up handling the IRQ and
are bounded by a final eoi_irq() - this is the case for chips with
IRQCHIP_AUTOMASKS_FLOW and IRQCHIP_EOI_THREADED.

Make handle_strict_flow_irq() leverage IRQCHIP_AUTOMASKS_FLOW and issue an
ack_irq() rather than a mask_ack_irq() when possible.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210629125010.458872-7-valentin.schneider@arm.com
---
 kernel/irq/chip.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 699e70b..c2ca6b7 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -896,6 +896,12 @@ out_eoi:
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
