Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9B43DAA20
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhG2R2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:28:37 -0400
Received: from foss.arm.com ([217.140.110.172]:53650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232249AbhG2R2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:28:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 390C01FB;
        Thu, 29 Jul 2021 10:28:22 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 824783F73D;
        Thu, 29 Jul 2021 10:28:21 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 2/2] irqchip/gic-v3: Fix selection of partition domain for EPPIs
Date:   Thu, 29 Jul 2021 17:27:48 +0000
Message-Id: <20210729172748.28841-3-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729172748.28841-1-james.morse@arm.com>
References: <20210729172748.28841-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
I'm not aware of a platform affected by this. If wanted as a fix, the
tag would be:
Fixes: 5f51f803826e ("irqchip/gic-v3: Add EPPI range support")

(and merge both patches)
---
 drivers/irqchip/irq-gic-v3.c | 48 ++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b24f0a9d2876..8b6e9b2fc621 100644
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
-- 
2.30.2

