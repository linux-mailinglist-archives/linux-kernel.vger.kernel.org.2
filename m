Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CD53A4379
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhFKN5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:57:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40008 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhFKN4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:36 -0400
Date:   Fri, 11 Jun 2021 13:54:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419677;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uMvuQILzEU/YuqWY/j2b92rV8m1VMnn53DePK3Io3l8=;
        b=kIN4O1rnCSkgKFGNpvf5r2JnXcv+DOpLsctUmgC09kWXn0EGAcWP0irbyQ1PyXBYn2Rv2O
        fN9FkwYLGoIcjClpZKDvVzLIw5UsAxuhsr2rYTt6CJgKA3/bAKyeqap7U0B9yM9CfDLy9m
        JmWKIIcoTWhiDVHiXVBbCU6DU0Cg6/LbOiHhUcMZ3DxVABXXsvfqPnSNB2Hp3p92vLVJxQ
        +X4LPeuIT3edmviOLVmTQ9wZmT5XZUw+bjMnksC7Qz90q72b/5y3Lg7T058VOP4jglyGoM
        +DL14HTgyOSabGh33y4ZSgkcO2v/tT8tudYRkjT6j2gGomWpsiPuEllhiArYbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419677;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uMvuQILzEU/YuqWY/j2b92rV8m1VMnn53DePK3Io3l8=;
        b=2zUZUgfK50LHf71lWDqhJDOmovDnqkgE0WYERC9KKWW+noxSFsEouKM/UdVNs7KfOY1+wy
        ACgC4cEwzmBW33Cg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Protect the linear revmap with RCU
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341967699.19906.3242958007782554792.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     d4a45c68dc81f9117ceaff9f058d5fae674181b9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d4a45c68dc81f9117ceaff9f058d5fae674181b9
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 05 Apr 2021 12:57:27 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:18 +01:00

irqdomain: Protect the linear revmap with RCU

It is pretty odd that the radix tree uses RCU while the linear
portion doesn't, leading to potential surprises for the users,
depending on how the irqdomain has been created.

Fix this by moving the update of the linear revmap under
the mutex, and the lookup under the RCU read-side lock.

The mutex name is updated to reflect that it doesn't only
cover the radix-tree anymore.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h |  5 ++--
 kernel/irq/irqdomain.c    | 49 +++++++++++++++++---------------------
 2 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 340cc04..2b696c9 100644
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
index 7a4e388..8fbadee 100644
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
@@ -504,13 +504,12 @@ static void irq_domain_clear_mapping(struct irq_domain *domain,
 	if (irq_domain_is_nomap(domain))
 		return;
 
-	if (hwirq < domain->revmap_size) {
-		domain->revmap[hwirq] = NULL;
-	} else {
-		mutex_lock(&domain->revmap_tree_mutex);
+	mutex_lock(&domain->revmap_mutex);
+	if (hwirq < domain->revmap_size)
+		rcu_assign_pointer(domain->revmap[hwirq], NULL);
+	else
 		radix_tree_delete(&domain->revmap_tree, hwirq);
-		mutex_unlock(&domain->revmap_tree_mutex);
-	}
+	mutex_unlock(&domain->revmap_mutex);
 }
 
 static void irq_domain_set_mapping(struct irq_domain *domain,
@@ -520,13 +519,12 @@ static void irq_domain_set_mapping(struct irq_domain *domain,
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
 
 static void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
@@ -911,12 +909,12 @@ unsigned int irq_find_mapping(struct irq_domain *domain,
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
@@ -1499,18 +1497,17 @@ static void irq_domain_fix_revmap(struct irq_data *d)
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
