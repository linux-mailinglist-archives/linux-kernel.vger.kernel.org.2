Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6668E39CF19
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhFFMqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhFFMpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91736C061787
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:43:50 -0700 (PDT)
Date:   Sun, 06 Jun 2021 12:43:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983429;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bgLVDJlRvyuF00yQQ1vm2obnhf6GOWQ8EFFZgoXfMBM=;
        b=4kz+/Lwl9Wj0X4GxT5DLTIas9+ePeR1PN6VxkJAl0pgN78eKo1zf8Z5/M9gh/dvJazwV/q
        wZZNuGaozd6t1lLJ1qEjFlqxNZV7t4BdEOM/8KT1TzHC6KBUgCqryuOfhPHbixLNLYALrB
        B/+BQ37/8HakAWDEhK5eixyJNjq4JRwRHXPvvtrv5yfHH0bLDEfPzPkU1U7w7h39zTCOVr
        zjnhsaMfFq9/65CuYhPeUtgMGJ3hw91bawx80ynbb8iCRXempQPkcBpM2ALa+hehXB3z8r
        sqURCuxts5YGe+R5ts+RsJE0I/ckLGJFZHiGw/G5XapTmWqug1ZzUV/pe+cBtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983429;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bgLVDJlRvyuF00yQQ1vm2obnhf6GOWQ8EFFZgoXfMBM=;
        b=9u3QfkJ+w/AuHlANIkN6FumJDjw3TeKO/jhbyIQIB0pCdWh3w1CQ5nsgztCrx8sBXuVyOE
        UUhr55zdq+KdywDQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Cache irq_data instead of a
 virq number in the revmap
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298342858.29796.10196050370394731030.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     fb48c79010d17b4cfb0ea9b25625efa359c5d9da
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/fb48c79010d17b4cfb0ea9b25625efa359c5d9da
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 05 Apr 2021 11:46:53 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 14:34:49 +01:00

irqdomain: Cache irq_data instead of a virq number in the revmap

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
index 0916cf9..340cc04 100644
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
index cdcb198..7a4e388 100644
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
