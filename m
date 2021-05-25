Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC143907C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhEYRfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:35:21 -0400
Received: from foss.arm.com ([217.140.110.172]:33096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234020AbhEYRe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:34:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BA9B169C;
        Tue, 25 May 2021 10:33:26 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7F9343F792;
        Tue, 25 May 2021 10:33:25 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [RFC PATCH v2 09/10] irqchip/gic: Convert to handle_strict_flow_irq()
Date:   Tue, 25 May 2021 18:32:54 +0100
Message-Id: <20210525173255.620606-10-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210525173255.620606-1-valentin.schneider@arm.com>
References: <20210525173255.620606-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/irqchip/irq-gic.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index b1d9c22caf2e..4919478c3e41 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -344,8 +344,6 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 		if (unlikely(irqnr >= 1020))
 			break;
 
-		if (static_branch_likely(&supports_deactivate_key))
-			writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
 		isb();
 
 		/*
@@ -1012,7 +1010,9 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
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
@@ -1116,8 +1116,16 @@ static void gic_init_chip(struct gic_chip_data *gic, struct device *dev,
 
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
-- 
2.25.1

