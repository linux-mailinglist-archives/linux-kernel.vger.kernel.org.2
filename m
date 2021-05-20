Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B92438B4C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbhETRAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:00:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237996AbhETQ7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:59:16 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2AB66139A;
        Thu, 20 May 2021 16:57:54 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ljlgb-002d7b-NH; Thu, 20 May 2021 17:38:13 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel-team@android.com
Subject: [PATCH 16/39] irqdomain: Make normal and nomap irqdomains exclusive
Date:   Thu, 20 May 2021 17:37:28 +0100
Message-Id: <20210520163751.27325-17-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520163751.27325-1-maz@kernel.org>
References: <20210520163751.27325-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, ley.foon.tan@intel.com, chris@zankel.net, jcmvbkbc@gmail.com, vgupta@synopsys.com, tsbogend@alpha.franken.de, robert.jarzmik@free.fr, linux@armlinux.org.uk, krzysztof.kozlowski@canonical.com, ysato@users.sourceforge.jp, dalias@libc.org, geert@linux-m68k.org, alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch, robdclark@gmail.com, linus.walleij@linaro.org, lee.jones@linaro.org, lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com, bgolaszewski@baylibre.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct mappings are completely exclusive of normal mappings, meaning
that we can refactor the code slightly so that we can get rid of
the revmap_direct_max_irq field and use the revmap_size field
instead, reducing the size of the irqdomain structure.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h |  6 +++---
 kernel/irq/irqdomain.c    | 45 ++++++++++++++++++++++++++++++---------
 2 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 723495ec5a2f..0916cf9c6e20 100644
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
index e0143e640683..fa94c86e47d4 100644
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
-- 
2.30.2

