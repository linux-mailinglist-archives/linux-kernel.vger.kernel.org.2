Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DDF39CF18
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhFFMqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhFFMpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70522C061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:43:50 -0700 (PDT)
Date:   Sun, 06 Jun 2021 12:43:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983428;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0i0+dQ/wIIIh2wHdFD8iyz7N0TIwZ0pZsKx27Hp5/24=;
        b=EkPSQE8Fc0x0+I3FdgZIDXYwRQ97ySNc6devKu18zQ2vRWefKFLlikXV6NQhMcTDKB3qiS
        bSbXmegnQ4RTq6doqHHBaUhMKvMLB4aH1js33j5hsJINEDW4C0NetVqHJJ633ztk5p4Ceg
        XW9OsmAc7EbN8RZ/XtRSBbaoop7mcI4HPy0kFgS1KIU8M4u6CXXRjmUOgLgvCZvGre82e1
        JTAD3Zx1Hd/ATscWuL5l92JTQOURyKxr4u26LqA48xSZazSZYmjSCggYyyCbbobt3yZWG1
        DsXtK4HihcwlYwW0dNezShwPcctCdMZYHgd+n0d5QJZ6TF8M0o/+pHXqrc8Dmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983428;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0i0+dQ/wIIIh2wHdFD8iyz7N0TIwZ0pZsKx27Hp5/24=;
        b=+KFa3V3T/t69DS6ICsnTGkLeHZXGkFyiQD/5eoN/C9KmhnG4frtMyik225rYBcIa/6pefo
        4MEbH7aOYYxUrhBw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Protect the linear revmap with RCU
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298342768.29796.9241794621138427749.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     e0f5b5fa10f5bf9cfa547dce21c92dd323daf584
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e0f5b5fa10f5bf9cfa547dce21c92dd323daf584
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 05 Apr 2021 12:57:27 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 14:34:49 +01:00

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
 include/linux/irqdomain.h |  5 +++--
 kernel/irq/irqdomain.c    | 38 ++++++++++++++++++--------------------
 2 files changed, 21 insertions(+), 22 deletions(-)

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
index ed2ffff..8e55bb8 100644
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
