Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AB23E9F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 09:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbhHLHOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 03:14:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56528 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbhHLHOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 03:14:19 -0400
Date:   Thu, 12 Aug 2021 07:13:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628752433;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LZjMr9lcrESALVOTCko0DoDI3uZ3C/BWxuBQC+wMFM4=;
        b=UmwBOo3nYhSKgN09gIAbB0Di4jMk4Mk9FwPN+TtxAa2/U+bUCSobYSRWskeCb6K8xlqhTD
        4Natw3mcr2OB7MxJ1YXtEvoB29EXMnipLR7E472FzVGI92KfNsourYdMmI/hjgOBIF2iko
        rXntCi5n0+0fb4LRo8c5Pw88cKiwaMpEV0/ih//Z2K/MybLLNXf/hhzUKsJvesM7lUzJNz
        WuP3HVzphUdS1Ob4slc1e0GWIoNrqeZ1XVuVBCMHVU9i+gVOMcYncLDvR2Pz63fFMk5URB
        GoxF0S7qWY/5cruvxbZ6NzuV8z4ydQOsYsbr1KckpMH47JIVM4SrF+zVluo6tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628752433;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LZjMr9lcrESALVOTCko0DoDI3uZ3C/BWxuBQC+wMFM4=;
        b=8e3AonVEEtSBRZ3tfp9KGUlO6kL3DOcQBkMP3QLkDVoo4Of8tPknWVNV/EO7a8QqwtPEjc
        5a6AY2bUGAEINZDQ==
From:   "irqchip-bot for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3: Fix selection of
 partition domain for EPPIs
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210729172748.28841-3-james.morse@arm.com>
References: <20210729172748.28841-3-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162875243281.395.16239622910655623091.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     d753f849bf487faffd05898e6a8e5aa9d146cb50
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d753f849bf487faffd05898e6a8e5aa9d146cb50
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Thu, 29 Jul 2021 17:27:48 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 08:11:03 +01:00

irqchip/gic-v3: Fix selection of partition domain for EPPIs

commit 5f51f803826e ("irqchip/gic-v3: Add EPPI range support") added
GIC_IRQ_TYPE_PARTITION support for EPPI to gic_irq_domain_translate(),
and commit 52085d3f2028 ("irqchip/gic-v3: Dynamically allocate PPI
partition descriptors") made the gic_data.ppi_descs array big enough for
EPPI, but neither gic_irq_domain_select() nor partition_domain_translate()
were updated.

This means partitions are created by partition_create_desc() for the
EPPI range, but can't be registered as they will always match the root
domain and map to the summary interrupt.

Update gic_irq_domain_select() to match PPI and EPPI. The fwspec for
PPI and EPPI both start from 0. Use gic_irq_domain_translate() to find
the hwirq from the fwspec, then convert this to a ppi index.

Reported-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210729172748.28841-3-james.morse@arm.com
---
 drivers/irqchip/irq-gic-v3.c | 48 +++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b24f0a9..8b6e9b2 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1472,10 +1472,34 @@ static void gic_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 	}
 }
 
+static bool fwspec_is_partitioned_ppi(struct irq_fwspec *fwspec,
+				      irq_hw_number_t hwirq)
+{
+	enum gic_intid_range range;
+
+	if (!gic_data.ppi_descs)
+		return false;
+
+	if (!is_of_node(fwspec->fwnode))
+		return false;
+
+	if (fwspec->param_count < 4 || !fwspec->param[3])
+		return false;
+
+	range = __get_intid_range(hwirq);
+	if (range != PPI_RANGE && range != EPPI_RANGE)
+		return false;
+
+	return true;
+}
+
 static int gic_irq_domain_select(struct irq_domain *d,
 				 struct irq_fwspec *fwspec,
 				 enum irq_domain_bus_token bus_token)
 {
+	unsigned int type, ret, ppi_idx;
+	irq_hw_number_t hwirq;
+
 	/* Not for us */
         if (fwspec->fwnode != d->fwnode)
 		return 0;
@@ -1484,16 +1508,19 @@ static int gic_irq_domain_select(struct irq_domain *d,
 	if (!is_of_node(fwspec->fwnode))
 		return 1;
 
+	ret = gic_irq_domain_translate(d, fwspec, &hwirq, &type);
+	if (WARN_ON_ONCE(ret))
+		return 0;
+
+	if (!fwspec_is_partitioned_ppi(fwspec, hwirq))
+		return d == gic_data.domain;
+
 	/*
 	 * If this is a PPI and we have a 4th (non-null) parameter,
 	 * then we need to match the partition domain.
 	 */
-	if (fwspec->param_count >= 4 &&
-	    fwspec->param[0] == 1 && fwspec->param[3] != 0 &&
-	    gic_data.ppi_descs)
-		return d == partition_get_domain(gic_data.ppi_descs[fwspec->param[1]]);
-
-	return d == gic_data.domain;
+	ppi_idx = __gic_get_ppi_index(hwirq);
+	return d == partition_get_domain(gic_data.ppi_descs[ppi_idx]);
 }
 
 static const struct irq_domain_ops gic_irq_domain_ops = {
@@ -1508,7 +1535,9 @@ static int partition_domain_translate(struct irq_domain *d,
 				      unsigned long *hwirq,
 				      unsigned int *type)
 {
+	unsigned long ppi_intid;
 	struct device_node *np;
+	unsigned int ppi_idx;
 	int ret;
 
 	if (!gic_data.ppi_descs)
@@ -1518,7 +1547,12 @@ static int partition_domain_translate(struct irq_domain *d,
 	if (WARN_ON(!np))
 		return -EINVAL;
 
-	ret = partition_translate_id(gic_data.ppi_descs[fwspec->param[1]],
+	ret = gic_irq_domain_translate(d, fwspec, &ppi_intid, type);
+	if (WARN_ON_ONCE(ret))
+		return 0;
+
+	ppi_idx = __gic_get_ppi_index(ppi_intid);
+	ret = partition_translate_id(gic_data.ppi_descs[ppi_idx],
 				     of_node_to_fwnode(np));
 	if (ret < 0)
 		return ret;
