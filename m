Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B69C38B4B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhETQ6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233806AbhETQ6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:58:39 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72A10613C1;
        Thu, 20 May 2021 16:57:17 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ljlge-002d7b-8T; Thu, 20 May 2021 17:38:16 +0100
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
Subject: [PATCH 18/39] irqdomain: Cache irq_data instead of a virq number in the revmap
Date:   Thu, 20 May 2021 17:37:30 +0100
Message-Id: <20210520163751.27325-19-maz@kernel.org>
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

Caching a virq number in the revmap is pretty inefficient, as
it means we will need to convert it back to either an irq_data
or irq_desc to do anything with it.

It is also a bit odd, as the radix tree does cache irq_data
pointers.

Change the revmap type to be an irq_data pointer instead of
an unsigned int, and preserve the current API for now.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h |  4 ++--
 kernel/irq/irqdomain.c    | 16 +++++++++++-----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 0916cf9c6e20..340cc04611dd 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -151,7 +151,7 @@ struct irq_domain_chip_generic;
  * Revmap data, used internally by irq_domain
  * @revmap_size: Size of the linear map table @revmap[]
  * @revmap_tree: Radix map tree for hwirqs that don't fit in the linear map
- * @revmap: Linear table of hwirq->virq reverse mappings
+ * @revmap: Linear table of irq_data pointers
  */
 struct irq_domain {
 	struct list_head link;
@@ -174,7 +174,7 @@ struct irq_domain {
 	unsigned int revmap_size;
 	struct radix_tree_root revmap_tree;
 	struct mutex revmap_tree_mutex;
-	unsigned int revmap[];
+	struct irq_data *revmap[];
 };
 
 /* Irq domain flags */
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index cdcb1989cd20..7a4e38804487 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -505,7 +505,7 @@ static void irq_domain_clear_mapping(struct irq_domain *domain,
 		return;
 
 	if (hwirq < domain->revmap_size) {
-		domain->revmap[hwirq] = 0;
+		domain->revmap[hwirq] = NULL;
 	} else {
 		mutex_lock(&domain->revmap_tree_mutex);
 		radix_tree_delete(&domain->revmap_tree, hwirq);
@@ -521,7 +521,7 @@ static void irq_domain_set_mapping(struct irq_domain *domain,
 		return;
 
 	if (hwirq < domain->revmap_size) {
-		domain->revmap[hwirq] = irq_data->irq;
+		domain->revmap[hwirq] = irq_data;
 	} else {
 		mutex_lock(&domain->revmap_tree_mutex);
 		radix_tree_insert(&domain->revmap_tree, hwirq, irq_data);
@@ -913,7 +913,7 @@ unsigned int irq_find_mapping(struct irq_domain *domain,
 
 	/* Check if the hwirq is in the linear revmap. */
 	if (hwirq < domain->revmap_size)
-		return domain->revmap[hwirq];
+		return domain->revmap[hwirq]->irq;
 
 	rcu_read_lock();
 	data = radix_tree_lookup(&domain->revmap_tree, hwirq);
@@ -1496,8 +1496,14 @@ static void irq_domain_fix_revmap(struct irq_data *d)
 {
 	void __rcu **slot;
 
-	if (irq_domain_is_nomap(d->domain) || d->hwirq < d->domain->revmap_size)
-		return; /* Not using radix tree. */
+	if (irq_domain_is_nomap(d->domain))
+		return;
+
+	if (d->hwirq < d->domain->revmap_size) {
+		/* Not using radix tree */
+		d->domain->revmap[d->hwirq] = d;
+		return;
+	}
 
 	/* Fix up the revmap. */
 	mutex_lock(&d->domain->revmap_tree_mutex);
-- 
2.30.2

