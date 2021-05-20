Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0486838B4D0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbhETRA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239250AbhETQ7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:59:23 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AD5761363;
        Thu, 20 May 2021 16:58:02 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ljlgZ-002d7b-2R; Thu, 20 May 2021 17:38:11 +0100
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
Subject: [PATCH 14/39] irqdomain: Reimplement irq_linear_revmap() with irq_find_mapping()
Date:   Thu, 20 May 2021 17:37:26 +0100
Message-Id: <20210520163751.27325-15-maz@kernel.org>
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

irq_linear_revmap() is supposed to be a fast path for domain
lookups, but it only exposes low-level details of the irqdomain
implementation, details which are better kept private.

The *overhead* between the two is only a function call and
a couple of tests, so it is likely that noone can show any
meaningful difference compared to the cost of taking an
interrupt.

Reimplement irq_linear_revmap() with irq_find_mapping()
in order to preserve source code compatibility, and
rename the internal field for a measure.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h | 22 +++++++++-------------
 kernel/irq/irqdomain.c    |  6 +++---
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 9f884c948739..42b3f7d03a32 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -151,9 +151,9 @@ struct irq_domain_chip_generic;
  * Revmap data, used internally by irq_domain
  * @revmap_direct_max_irq: The largest hwirq that can be set for controllers that
  *                         support direct mapping
- * @revmap_size: Size of the linear map table @linear_revmap[]
+ * @revmap_size: Size of the linear map table @revmap[]
  * @revmap_tree: Radix map tree for hwirqs that don't fit in the linear map
- * @linear_revmap: Linear table of hwirq->virq reverse mappings
+ * @revmap: Linear table of hwirq->virq reverse mappings
  */
 struct irq_domain {
 	struct list_head link;
@@ -177,7 +177,7 @@ struct irq_domain {
 	unsigned int revmap_size;
 	struct radix_tree_root revmap_tree;
 	struct mutex revmap_tree_mutex;
-	unsigned int linear_revmap[];
+	unsigned int revmap[];
 };
 
 /* Irq domain flags */
@@ -394,24 +394,20 @@ static inline unsigned int irq_create_mapping(struct irq_domain *host,
 	return irq_create_mapping_affinity(host, hwirq, NULL);
 }
 
-
 /**
- * irq_linear_revmap() - Find a linux irq from a hw irq number.
+ * irq_find_mapping() - Find a linux irq from a hw irq number.
  * @domain: domain owning this hardware interrupt
  * @hwirq: hardware irq number in that domain space
- *
- * This is a fast path alternative to irq_find_mapping() that can be
- * called directly by irq controller code to save a handful of
- * instructions. It is always safe to call, but won't find irqs mapped
- * using the radix tree.
  */
+extern unsigned int irq_find_mapping(struct irq_domain *host,
+				     irq_hw_number_t hwirq);
+
 static inline unsigned int irq_linear_revmap(struct irq_domain *domain,
 					     irq_hw_number_t hwirq)
 {
-	return hwirq < domain->revmap_size ? domain->linear_revmap[hwirq] : 0;
+	return irq_find_mapping(domain, hwirq);
 }
-extern unsigned int irq_find_mapping(struct irq_domain *host,
-				     irq_hw_number_t hwirq);
+
 extern unsigned int irq_create_direct_mapping(struct irq_domain *host);
 
 extern const struct irq_domain_ops irq_domain_simple_ops;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 6284443b87ec..8bd012253989 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -486,7 +486,7 @@ static void irq_domain_clear_mapping(struct irq_domain *domain,
 				     irq_hw_number_t hwirq)
 {
 	if (hwirq < domain->revmap_size) {
-		domain->linear_revmap[hwirq] = 0;
+		domain->revmap[hwirq] = 0;
 	} else {
 		mutex_lock(&domain->revmap_tree_mutex);
 		radix_tree_delete(&domain->revmap_tree, hwirq);
@@ -499,7 +499,7 @@ static void irq_domain_set_mapping(struct irq_domain *domain,
 				   struct irq_data *irq_data)
 {
 	if (hwirq < domain->revmap_size) {
-		domain->linear_revmap[hwirq] = irq_data->irq;
+		domain->revmap[hwirq] = irq_data->irq;
 	} else {
 		mutex_lock(&domain->revmap_tree_mutex);
 		radix_tree_insert(&domain->revmap_tree, hwirq, irq_data);
@@ -885,7 +885,7 @@ unsigned int irq_find_mapping(struct irq_domain *domain,
 
 	/* Check if the hwirq is in the linear revmap. */
 	if (hwirq < domain->revmap_size)
-		return domain->linear_revmap[hwirq];
+		return domain->revmap[hwirq];
 
 	rcu_read_lock();
 	data = radix_tree_lookup(&domain->revmap_tree, hwirq);
-- 
2.30.2

