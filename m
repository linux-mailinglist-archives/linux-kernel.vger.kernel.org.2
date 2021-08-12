Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A013EA739
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbhHLPNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237868AbhHLPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:13:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE53EC0617AE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:13:02 -0700 (PDT)
Date:   Thu, 12 Aug 2021 15:12:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628781178;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L6Aq/2J2qO3uYUwXLq8NisCxczqndr2Nn2xJ8dL4WtY=;
        b=OT6tB5kxcFs0/iff0m8EQ82iIxHPtIXhhaIbzX3ZpBBIs2zkDmF4Q4RbVtqj+D4Xoy0oYj
        Al3xhiKx/4zlLyZiFtAVsCIDldMB6QeTlaIO+dQkoO0YHepv7z2zxOl+Fdihh3yjS8Z4IJ
        TI3iNvUJr9KJN+G4qR7O2HXi/FY/s3NDwwuZuH3ZpEVfI+352+mLwL3Jfv5efmvSYIC4Mq
        Vm2TELX094ti1CmUg+CDdpIG0FUiOg6HNSqDS/XcUoZoxDMjlUK7HscjOFRyLyUbJiYh5G
        4Ar/jB1/7sYD2vocvA10rAgeUNqqR48t0w2pbzdtJVpBFRY5jUhvl5EnNeJjjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628781178;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L6Aq/2J2qO3uYUwXLq8NisCxczqndr2Nn2xJ8dL4WtY=;
        b=EKrqs8Vh7cvOnN3W3W9eo5gu82eEaBNLrRvZYl1fMvzYD2CgTvcbStZBrTi4JlYfGO4BGu
        hCV3gqBeEPaSY+Dg==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3: Convert to
 handle_strict_flow_irq()
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210629125010.458872-14-valentin.schneider@arm.com>
References: <20210629125010.458872-14-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <162878117761.395.4737067549372035469.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     3359fcab48b0467497883863e2e5538605c51c4a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3359fcab48b0467497883863e2e5538605c51c4a
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 29 Jun 2021 13:50:10 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 15:48:21 +01:00

irqchip/gic-v3: Convert to handle_strict_flow_irq()

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
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210629125010.458872-14-valentin.schneider@arm.com
---
 drivers/irqchip/irq-gic-v3.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index cdffffc..00bbb4d 100644
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
@@ -697,9 +695,11 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
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
@@ -1310,6 +1310,7 @@ static struct irq_chip gic_eoimode1_chip = {
 	.name			= "GICv3",
 	.irq_mask		= gic_eoimode1_mask_irq,
 	.irq_unmask		= gic_unmask_irq,
+	.irq_ack                = gic_eoi_irq,
 	.irq_eoi		= gic_eoimode1_eoi_irq,
 	.irq_set_type		= gic_set_type,
 	.irq_set_affinity	= gic_set_affinity,
@@ -1322,7 +1323,9 @@ static struct irq_chip gic_eoimode1_chip = {
 	.ipi_send_mask		= gic_ipi_send_mask,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE |
-				  IRQCHIP_MASK_ON_SUSPEND,
+				  IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_AUTOMASKS_FLOW |
+				  IRQCHIP_EOI_THREADED,
 };
 
 static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
@@ -1346,7 +1349,9 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
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
@@ -1355,7 +1360,9 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		if (!gic_dist_supports_lpis())
 			return -EPERM;
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
-				    handle_fasteoi_irq, NULL, NULL);
+				    static_branch_likely(&supports_deactivate_key) ?
+				    handle_strict_flow_irq : handle_fasteoi_irq,
+				    NULL, NULL);
 		break;
 
 	default:
