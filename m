Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF10F3EA738
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbhHLPN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:13:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59096 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhHLPNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:13:25 -0400
Date:   Thu, 12 Aug 2021 15:12:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628781179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qJ8Z+AS/sRJ66qy+cBafkJzZdx35s1ynwjHScI0cJ20=;
        b=J19wYoVCU7HGWNlOTE90Idu5N9/b5JXAHpcEhYwbJOin1BQgXp/j1mQ7MuXgwhFHTmEZWz
        +tiOnUpyk6gyEYPQCmwM+B7RcTRBATqvqdUX9g4WY21AbqsPQVGmqUTgPMv/L3RnKvyfMp
        HKUVKLZ5YASG+FRDB/SNlHIh5FV7fxGmEDG5EqXZOUWDENn4F2uvg51odDL9k+P6lD9SKe
        XtCWHk0i9eW4p7ZjuRPA3dmeHYPD8Kt/FfqvoCNZGw13K6n2Mx0xbme/tcSk/cs0kc+QcO
        YOVojOFu7pnC47jlnjYMvVYG3aOzRmXKH3xVb79tpRnwJqh0b0Wz5TA+OR0nVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628781179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qJ8Z+AS/sRJ66qy+cBafkJzZdx35s1ynwjHScI0cJ20=;
        b=PqosPAe3hi187vE2HoYGeQUL/UQKCGEvB2axw1VM95NJyb4/3UymfguYZhxDmL2yGrYCYZ
        2qW9DPlAIkbub4Aw==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic: Convert to handle_strict_flow_irq()
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210629125010.458872-13-valentin.schneider@arm.com>
References: <20210629125010.458872-13-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <162878117829.395.12484715958128066494.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     5bd8e3224b617caa4b628d6c7a06ba8f72174064
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/5bd8e3224b617caa4b628d6c7a06ba8f72174064
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 29 Jun 2021 13:50:09 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 15:48:21 +01:00

irqchip/gic: Convert to handle_strict_flow_irq()

Now that the proper infrastructure is in place, convert the irq-gic chip to
use handle_strict_flow_irq() along with IRQCHIP_AUTOMASKS_FLOW.

For EOImode=1, the Priority Drop is moved from gic_handle_irq() into
chip->irq_ack(). This effectively pushes the EOI write down into
->handle_irq(), but doesn't change its ordering wrt the irqaction
handling.

The EOImode=1 irqchip also gains IRQCHIP_EOI_THREADED, which allows the
->irq_eoi() call to be deferred to the tail of ONESHOT IRQ threads. This
means a threaded ONESHOT IRQ can now be handled entirely without a single
chip->irq_mask() call.

EOImode=0 handling remains unchanged.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210629125010.458872-13-valentin.schneider@arm.com
---
 drivers/irqchip/irq-gic.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index d329ec3..c88d8cc 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -344,8 +344,6 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 		if (unlikely(irqnr >= 1020))
 			break;
 
-		if (static_branch_likely(&supports_deactivate_key))
-			writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
 		isb();
 
 		/*
@@ -1009,7 +1007,9 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		break;
 	default:
 		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
-				    handle_fasteoi_irq, NULL, NULL);
+				    static_branch_likely(&supports_deactivate_key) ?
+				    handle_strict_flow_irq : handle_fasteoi_irq,
+				    NULL, NULL);
 		irq_set_probe(irq);
 		irqd_set_single_target(irqd);
 		break;
@@ -1113,8 +1113,16 @@ static void gic_init_chip(struct gic_chip_data *gic, struct device *dev,
 
 	if (use_eoimode1) {
 		gic->chip.irq_mask = gic_eoimode1_mask_irq;
+		gic->chip.irq_ack = gic_eoi_irq;
 		gic->chip.irq_eoi = gic_eoimode1_eoi_irq;
 		gic->chip.irq_set_vcpu_affinity = gic_irq_set_vcpu_affinity;
+
+		/*
+		 * eoimode0 shouldn't expose FLOW_MASK because the priority
+		 * drop is undissociable from the deactivation, and we do need
+		 * the priority drop to happen within the flow handler.
+		 */
+		gic->chip.flags |= IRQCHIP_AUTOMASKS_FLOW | IRQCHIP_EOI_THREADED;
 	}
 
 	if (gic == &gic_data[0]) {
