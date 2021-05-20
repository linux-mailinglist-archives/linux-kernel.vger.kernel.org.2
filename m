Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE2238B4C6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbhETRAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234162AbhETQ7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:59:05 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AF6D613CC;
        Thu, 20 May 2021 16:57:42 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ljlgg-002d7b-T8; Thu, 20 May 2021 17:38:19 +0100
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
Subject: [PATCH 20/39] irqdomain: Protect the linear revmap with RCU
Date:   Thu, 20 May 2021 17:37:32 +0100
Message-Id: <20210520163751.27325-21-maz@kernel.org>
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

It is pretty odd that the radix tree uses RCU while the linear
portion doesn't, leading to potential surprises for the users,
depending on how the irqdomain has been created.

Fix this by moving the update of the linear revmap under
the mutex, and the lookup under the RCU read-side lock.

The mutex name is updated to reflect that it doesn't only
cover the radix-tree anymore.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h |  5 +++--
 kernel/irq/irqdomain.c    | 38 ++++++++++++++++++--------------------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 340cc04611dd..2b696c9bcaaf 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -151,6 +151,7 @@ struct irq_domain_chip_generic;
  * Revmap data, used internally by irq_domain
  * @revmap_size: Size of the linear map table @revmap[]
  * @revmap_tree: Radix map tree for hwirqs that don't fit in the linear map
+ * @revmap_mutex: Lock for the revmap
  * @revmap: Linear table of irq_data pointers
  */
 struct irq_domain {
@@ -173,8 +174,8 @@ struct irq_domain {
 	irq_hw_number_t hwirq_max;
 	unsigned int revmap_size;
 	struct radix_tree_root revmap_tree;
-	struct mutex revmap_tree_mutex;
-	struct irq_data *revmap[];
+	struct mutex revmap_mutex;
+	struct irq_data __rcu *revmap[];
 };
 
 /* Irq domain flags */
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index ed2ffffc6fc6..8e55bb8c3073 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -213,7 +213,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
-	mutex_init(&domain->revmap_tree_mutex);
+	mutex_init(&domain->revmap_mutex);
 	domain->ops = ops;
 	domain->host_data = host_data;
 	domain->hwirq_max = hwirq_max;
@@ -505,13 +505,12 @@ static void irq_domain_set_mapping(struct irq_domain *domain,
 	if (irq_domain_is_nomap(domain))
 		return;
 
-	if (hwirq < domain->revmap_size) {
-		domain->revmap[hwirq] = irq_data;
-	} else {
-		mutex_lock(&domain->revmap_tree_mutex);
+	mutex_lock(&domain->revmap_mutex);
+	if (hwirq < domain->revmap_size)
+		rcu_assign_pointer(domain->revmap[hwirq], irq_data);
+	else
 		radix_tree_insert(&domain->revmap_tree, hwirq, irq_data);
-		mutex_unlock(&domain->revmap_tree_mutex);
-	}
+	mutex_unlock(&domain->revmap_mutex);
 }
 
 static void irq_domain_clear_mapping(struct irq_domain *domain,
@@ -902,12 +901,12 @@ unsigned int irq_find_mapping(struct irq_domain *domain,
 		return 0;
 	}
 
+	rcu_read_lock();
 	/* Check if the hwirq is in the linear revmap. */
 	if (hwirq < domain->revmap_size)
-		return domain->revmap[hwirq]->irq;
-
-	rcu_read_lock();
-	data = radix_tree_lookup(&domain->revmap_tree, hwirq);
+		data = rcu_dereference(domain->revmap[hwirq]);
+	else
+		data = radix_tree_lookup(&domain->revmap_tree, hwirq);
 	rcu_read_unlock();
 	return data ? data->irq : 0;
 }
@@ -1490,18 +1489,17 @@ static void irq_domain_fix_revmap(struct irq_data *d)
 	if (irq_domain_is_nomap(d->domain))
 		return;
 
+	/* Fix up the revmap. */
+	mutex_lock(&d->domain->revmap_mutex);
 	if (d->hwirq < d->domain->revmap_size) {
 		/* Not using radix tree */
-		d->domain->revmap[d->hwirq] = d;
-		return;
+		rcu_assign_pointer(d->domain->revmap[d->hwirq], d);
+	} else {
+		slot = radix_tree_lookup_slot(&d->domain->revmap_tree, d->hwirq);
+		if (slot)
+			radix_tree_replace_slot(&d->domain->revmap_tree, slot, d);
 	}
-
-	/* Fix up the revmap. */
-	mutex_lock(&d->domain->revmap_tree_mutex);
-	slot = radix_tree_lookup_slot(&d->domain->revmap_tree, d->hwirq);
-	if (slot)
-		radix_tree_replace_slot(&d->domain->revmap_tree, slot, d);
-	mutex_unlock(&d->domain->revmap_tree_mutex);
+	mutex_unlock(&d->domain->revmap_mutex);
 }
 
 /**
-- 
2.30.2

