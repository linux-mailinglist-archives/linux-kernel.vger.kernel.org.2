Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF91C39CF1A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhFFMqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhFFMpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D145C061767
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:43:51 -0700 (PDT)
Date:   Sun, 06 Jun 2021 12:43:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983430;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7jjLUX4LyDNmDYHG+QbcxrEbJjGMZVFPaEFKb6XCJZY=;
        b=Se/dr/GsbE0qyhcu18sBDtYpZFgKLQ00XVx3hpR2wCJ7X3qxSrvBy/rVENv6FA2hNFPEv0
        x6LUSq01FzkQJw01e62JO058lBzSqrbvsupy5OrBF8RGLJybmWKJJfum5iu3nyjpIPv1zY
        jlYKIFmdXqTlUBQNaLokSz/q7yJ7CGuBlYRkzMbQMqZwcHF50kVJ2bSgMbVzI3pZECHC42
        86lJdYT2UoThNObo+dCgiXRJ3fyJSo8Y2+dmHgvGGDCZgkwQydrS3RgCqDUsG9lpM4d0xw
        VSfPHJNo8IMkXjBq/0pgJpPOYDTVksmnyv67c7aBXFD22hnfpOFOkxW3v6AWIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983430;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7jjLUX4LyDNmDYHG+QbcxrEbJjGMZVFPaEFKb6XCJZY=;
        b=YgPpV7zt7Dsx+mCG29eiiFL7BAK5GHlCOmXHsKN39PpdlC/qyO+kTjol8Gk+gFJLfVy8sz
        OJh8wBf2HlmFztBA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Make normal and nomap
 irqdomains exclusive
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298342951.29796.16598458942752543725.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     bf139be006048b7773c267dbe0c5d168cbead371
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/bf139be006048b7773c267dbe0c5d168cbead371
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 10 Sep 2018 18:33:46 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 14:34:49 +01:00

irqdomain: Make normal and nomap irqdomains exclusive

Direct mappings are completely exclusive of normal mappings, meaning
that we can refactor the code slightly so that we can get rid of
the revmap_direct_max_irq field and use the revmap_size field
instead, reducing the size of the irqdomain structure.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h |  6 ++---
 kernel/irq/irqdomain.c    | 45 +++++++++++++++++++++++++++++---------
 2 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 723495e..0916cf9 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -149,8 +149,6 @@ struct irq_domain_chip_generic;
  * @parent: Pointer to parent irq_domain to support hierarchy irq_domains
  *
  * Revmap data, used internally by irq_domain
- * @revmap_direct_max_irq: The largest hwirq that can be set for controllers that
- *                         support direct mapping
  * @revmap_size: Size of the linear map table @revmap[]
  * @revmap_tree: Radix map tree for hwirqs that don't fit in the linear map
  * @revmap: Linear table of hwirq->virq reverse mappings
@@ -173,7 +171,6 @@ struct irq_domain {
 
 	/* reverse map data. The linear map gets appended to the irq_domain */
 	irq_hw_number_t hwirq_max;
-	unsigned int revmap_direct_max_irq;
 	unsigned int revmap_size;
 	struct radix_tree_root revmap_tree;
 	struct mutex revmap_tree_mutex;
@@ -207,6 +204,9 @@ enum {
 	 */
 	IRQ_DOMAIN_MSI_NOMASK_QUIRK	= (1 << 6),
 
+	/* Irq domain doesn't translate anything */
+	IRQ_DOMAIN_FLAG_NO_MAP		= (1 << 7),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index e0143e6..fa94c86 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -146,6 +146,10 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 
 	static atomic_t unknown_domains;
 
+	if (WARN_ON((size && direct_max) ||
+		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && direct_max)))
+		return NULL;
+
 	domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
 			      GFP_KERNEL, of_node_to_nid(to_of_node(fwnode)));
 	if (!domain)
@@ -213,8 +217,14 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 	domain->ops = ops;
 	domain->host_data = host_data;
 	domain->hwirq_max = hwirq_max;
+
+	if (direct_max) {
+		size = direct_max;
+		domain->flags |= IRQ_DOMAIN_FLAG_NO_MAP;
+	}
+
 	domain->revmap_size = size;
-	domain->revmap_direct_max_irq = direct_max;
+
 	irq_domain_check_hierarchy(domain);
 
 	mutex_lock(&irq_domain_mutex);
@@ -482,9 +492,18 @@ struct irq_domain *irq_get_default_host(void)
 	return irq_default_domain;
 }
 
+static bool irq_domain_is_nomap(struct irq_domain *domain)
+{
+	return IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) &&
+	       (domain->flags & IRQ_DOMAIN_FLAG_NO_MAP);
+}
+
 static void irq_domain_clear_mapping(struct irq_domain *domain,
 				     irq_hw_number_t hwirq)
 {
+	if (irq_domain_is_nomap(domain))
+		return;
+
 	if (hwirq < domain->revmap_size) {
 		domain->revmap[hwirq] = 0;
 	} else {
@@ -498,6 +517,9 @@ static void irq_domain_set_mapping(struct irq_domain *domain,
 				   irq_hw_number_t hwirq,
 				   struct irq_data *irq_data)
 {
+	if (irq_domain_is_nomap(domain))
+		return;
+
 	if (hwirq < domain->revmap_size) {
 		domain->revmap[hwirq] = irq_data->irq;
 	} else {
@@ -629,9 +651,9 @@ unsigned int irq_create_direct_mapping(struct irq_domain *domain)
 		pr_debug("create_direct virq allocation failed\n");
 		return 0;
 	}
-	if (virq >= domain->revmap_direct_max_irq) {
+	if (virq >= domain->revmap_size) {
 		pr_err("ERROR: no free irqs available below %i maximum\n",
-			domain->revmap_direct_max_irq);
+			domain->revmap_size);
 		irq_free_desc(virq);
 		return 0;
 	}
@@ -879,10 +901,14 @@ unsigned int irq_find_mapping(struct irq_domain *domain,
 	if (domain == NULL)
 		return 0;
 
-	if (hwirq < domain->revmap_direct_max_irq) {
-		data = irq_domain_get_irq_data(domain, hwirq);
-		if (data && data->hwirq == hwirq)
-			return hwirq;
+	if (irq_domain_is_nomap(domain)) {
+		if (hwirq < domain->revmap_size) {
+			data = irq_domain_get_irq_data(domain, hwirq);
+			if (data && data->hwirq == hwirq)
+				return hwirq;
+		}
+
+		return 0;
 	}
 
 	/* Check if the hwirq is in the linear revmap. */
@@ -1470,7 +1496,7 @@ static void irq_domain_fix_revmap(struct irq_data *d)
 {
 	void __rcu **slot;
 
-	if (d->hwirq < d->domain->revmap_size)
+	if (irq_domain_is_nomap(d->domain) || d->hwirq < d->domain->revmap_size)
 		return; /* Not using radix tree. */
 
 	/* Fix up the revmap. */
@@ -1830,8 +1856,7 @@ static void
 irq_domain_debug_show_one(struct seq_file *m, struct irq_domain *d, int ind)
 {
 	seq_printf(m, "%*sname:   %s\n", ind, "", d->name);
-	seq_printf(m, "%*ssize:   %u\n", ind + 1, "",
-		   d->revmap_size + d->revmap_direct_max_irq);
+	seq_printf(m, "%*ssize:   %u\n", ind + 1, "", d->revmap_size);
 	seq_printf(m, "%*smapped: %u\n", ind + 1, "", d->mapcount);
 	seq_printf(m, "%*sflags:  0x%08x\n", ind +1 , "", d->flags);
 	if (d->ops && d->ops->debug_show)
