Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F84543B01F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbhJZKij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbhJZKhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:37:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E06AC061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 03:35:26 -0700 (PDT)
Date:   Tue, 26 Oct 2021 10:35:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635244525;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jeii7+x1141B+qMGkLOoZv6i8kUE0Igd00tNSG4uWgM=;
        b=AqJ8rFbPla+b73O0xYGxtPMTF0poqEbUiL69ALpqr0xeFs9eZDq5vzXA9iRHf4GGyyw03J
        J2qwnTnH0ftdJ0L5+aw3uCsKG2ZNbpQcYzqW8AY2V5P5diGczFiFWRAJ/790gfEz8nReiz
        +1wWJQkck+G1YoIHhlQnOJJsDyVWWUpBHkTZ7Q0gHY1TDoJGm2PZf997YrtEhVMzQTgdYW
        IMI2LFQnEDYkVBEBv6xR9cSNJeZHbMwoh5/gPvxQ43wf18T6EMaWlMRKOjzhQMO4tWygqq
        xFGNDbvdhMMCkaKfmXoMjYLESsI0IJtpt/h1jOwWqKHF6/7h3AKC/+MqqRZyxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635244525;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jeii7+x1141B+qMGkLOoZv6i8kUE0Igd00tNSG4uWgM=;
        b=IkRUQa4ZNGGeqTp81W2iHoek/X/3jzm/eNey07K0boLYFfPXr9miBHeiCGwjV1J9L8r123
        1DIM3Ry2gI6X38DA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/mips-gic: Get rid of the reliance
 on irq_cpu_online()
Cc:     Marc Zyngier <maz@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>, tglx@linutronix.de
In-Reply-To: <20211021170414.3341522-3-maz@kernel.org>
References: <20211021170414.3341522-3-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163524452417.626.12306893748856642843.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     dd098a0e031928cf88c89f7577d31821e1f0e6de
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/dd098a0e031928cf88c89f7577d31821e1f0e6de
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 21 Oct 2021 18:04:13 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 26 Oct 2021 11:19:38 +01:00

irqchip/mips-gic: Get rid of the reliance on irq_cpu_online()

The MIPS GIC driver uses irq_cpu_online() to go and program the
per-CPU interrupts. However, this method iterates over all IRQs
in the system, despite only 3 per-CPU interrupts being of interest.

Let's be terribly bold and do the iteration ourselves. To ensure
mutual exclusion, hold the gic_lock spinlock that is otherwise
taken while dealing with these interrupts.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Link: https://lore.kernel.org/r/20211021170414.3341522-3-maz@kernel.org
---
 drivers/irqchip/irq-mips-gic.c | 37 +++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 54c7092..d02b05a 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -381,24 +381,35 @@ static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
 	spin_unlock_irqrestore(&gic_lock, flags);
 }
 
-static void gic_all_vpes_irq_cpu_online(struct irq_data *d)
+static void gic_all_vpes_irq_cpu_online(void)
 {
-	struct gic_all_vpes_chip_data *cd;
-	unsigned int intr;
+	static const unsigned int local_intrs[] = {
+		GIC_LOCAL_INT_TIMER,
+		GIC_LOCAL_INT_PERFCTR,
+		GIC_LOCAL_INT_FDC,
+	};
+	unsigned long flags;
+	int i;
 
-	intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
-	cd = irq_data_get_irq_chip_data(d);
+	spin_lock_irqsave(&gic_lock, flags);
 
-	write_gic_vl_map(mips_gic_vx_map_reg(intr), cd->map);
-	if (cd->mask)
-		write_gic_vl_smask(BIT(intr));
+	for (i = 0; i < ARRAY_SIZE(local_intrs); i++) {
+		unsigned int intr = local_intrs[i];
+		struct gic_all_vpes_chip_data *cd;
+
+		cd = &gic_all_vpes_chip_data[intr];
+		write_gic_vl_map(mips_gic_vx_map_reg(intr), cd->map);
+		if (cd->mask)
+			write_gic_vl_smask(BIT(intr));
+	}
+
+	spin_unlock_irqrestore(&gic_lock, flags);
 }
 
 static struct irq_chip gic_all_vpes_local_irq_controller = {
 	.name			= "MIPS GIC Local",
 	.irq_mask		= gic_mask_local_irq_all_vpes,
 	.irq_unmask		= gic_unmask_local_irq_all_vpes,
-	.irq_cpu_online		= gic_all_vpes_irq_cpu_online,
 };
 
 static void __gic_irq_dispatch(void)
@@ -477,6 +488,10 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	intr = GIC_HWIRQ_TO_LOCAL(hwirq);
 	map = GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin;
 
+	/*
+	 * If adding support for more per-cpu interrupts, keep the the
+	 * array in gic_all_vpes_irq_cpu_online() in sync.
+	 */
 	switch (intr) {
 	case GIC_LOCAL_INT_TIMER:
 		/* CONFIG_MIPS_CMP workaround (see __gic_init) */
@@ -663,8 +678,8 @@ static int gic_cpu_startup(unsigned int cpu)
 	/* Clear all local IRQ masks (ie. disable all local interrupts) */
 	write_gic_vl_rmask(~0);
 
-	/* Invoke irq_cpu_online callbacks to enable desired interrupts */
-	irq_cpu_online();
+	/* Enable desired interrupts */
+	gic_all_vpes_irq_cpu_online();
 
 	return 0;
 }
