Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55AE3907CA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbhEYRfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:35:24 -0400
Received: from foss.arm.com ([217.140.110.172]:33104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234044AbhEYRe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:34:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B19EC1516;
        Tue, 25 May 2021 10:33:27 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B477E3F792;
        Tue, 25 May 2021 10:33:26 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [RFC PATCH v2 10/10] irqchip/gic-v3: Convert to handle_strict_flow_irq()
Date:   Tue, 25 May 2021 18:32:55 +0100
Message-Id: <20210525173255.620606-11-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210525173255.620606-1-valentin.schneider@arm.com>
References: <20210525173255.620606-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the proper infrastructure is in place, convert the irq-gic-v3 chip
to use handle_strict_flow_irq() along with IRQCHIP_AUTOMASKS_FLOW.

For EOImode=1, the Priority Drop is moved from gic_handle_irq() into
chip->irq_ack(). This effectively pushes the EOIR write down into
->handle_irq(), but doesn't change its ordering wrt the irqaction
handling.

The EOImode=1 irqchip also gains IRQCHIP_EOI_THREADED, which allows the
->irq_eoi() call to be deferred to the tail of ONESHOT IRQ threads. This
means a threaded ONESHOT IRQ can now be handled entirely without a single
chip->irq_mask() call.

Despite not having an Active state, LPIs are made to use
handle_strict_flow_irq() as well. This lets them re-use
gic_eoimode1_chip.irq_ack() as Priority Drop, rather than special-case them
in gic_handle_irq().

EOImode=0 handling remains unchanged.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index af11396996e3..c2677c5353a4 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -626,8 +626,6 @@ static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
 	if (irqs_enabled)
 		nmi_enter();
 
-	if (static_branch_likely(&supports_deactivate_key))
-		gic_write_eoir(irqnr);
 	/*
 	 * Leave the PSR.I bit set to prevent other NMIs to be
 	 * received while handling this one.
@@ -663,9 +661,11 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 		gic_arch_enable_irqs();
 	}
 
-	if (static_branch_likely(&supports_deactivate_key))
-		gic_write_eoir(irqnr);
-	else
+	/*
+	 * eoimode1 will give us an isb in handle_domain_irq(), before
+	 * handle_irq_event().
+	 */
+	if (!static_branch_likely(&supports_deactivate_key))
 		isb();
 
 	if (handle_domain_irq(gic_data.domain, irqnr, regs)) {
@@ -1276,6 +1276,7 @@ static struct irq_chip gic_eoimode1_chip = {
 	.name			= "GICv3",
 	.irq_mask		= gic_eoimode1_mask_irq,
 	.irq_unmask		= gic_unmask_irq,
+	.irq_ack                = gic_eoi_irq,
 	.irq_eoi		= gic_eoimode1_eoi_irq,
 	.irq_set_type		= gic_set_type,
 	.irq_set_affinity	= gic_set_affinity,
@@ -1288,7 +1289,9 @@ static struct irq_chip gic_eoimode1_chip = {
 	.ipi_send_mask		= gic_ipi_send_mask,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE |
-				  IRQCHIP_MASK_ON_SUSPEND,
+				  IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_AUTOMASKS_FLOW |
+				  IRQCHIP_EOI_THREADED,
 };
 
 static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
@@ -1312,7 +1315,9 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	case SPI_RANGE:
 	case ESPI_RANGE:
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
-				    handle_fasteoi_irq, NULL, NULL);
+				    static_branch_likely(&supports_deactivate_key) ?
+				    handle_strict_flow_irq : handle_fasteoi_irq,
+				    NULL, NULL);
 		irq_set_probe(irq);
 		irqd_set_single_target(irqd);
 		break;
@@ -1321,7 +1326,9 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		if (!gic_dist_supports_lpis())
 			return -EPERM;
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
-				    handle_fasteoi_irq, NULL, NULL);
+				    static_branch_likely(&supports_deactivate_key) ?
+				    handle_strict_flow_irq : handle_fasteoi_irq,
+				    NULL, NULL);
 		break;
 
 	default:
-- 
2.25.1

