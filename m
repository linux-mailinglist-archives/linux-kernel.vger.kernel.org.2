Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C5F39CF1B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhFFMqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:46:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35032 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhFFMpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:41 -0400
Date:   Sun, 06 Jun 2021 12:43:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UfpGv7JI2GCpDAPUVJo1MaN8c0J/K8bRJzM2RUIgoFk=;
        b=f99t2JouErYSLK7uKd8ENfhbL2rbfHDrlqBhoo8RLWb0+j5DrnV24n666iezPGepIN46Le
        WQWsBdBZTaD4beQ6Hd1nM9KzpeZzDhChSSUinbR1j+7QLXo1dQdQtuuXZhZXKSD/Eh0m/b
        r5/mFSyVoh/nSQ3WRdbThxkBOxM05vCTK3CINLmpbVipjKoOGQb0qUA+U2i60BsQxU/nL5
        WgvyduS4iPGyJfjGC6Lxm+2CbW7vRRvrzmvlKpPuiVoOAkBHq9zIglwwvE+d8Z+xUgg5kr
        5GeR2ah4BDH3P//ONwH/E4XapKWxh8m7IuN6LiV1j7aBFikVW6ZNumUSD+I9Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UfpGv7JI2GCpDAPUVJo1MaN8c0J/K8bRJzM2RUIgoFk=;
        b=6dNuk9NQueemTWmPfF+2tmDEse8INSS7v/GMEahosNgY5M3oJWzM8Nc6Q5mMI8c1ktOGD2
        DbKcrSq736XDIYDg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Reimplement
 irq_linear_revmap() with irq_find_mapping()
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298343039.29796.9779726971655731379.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     e19a0c0a7d6f2177183150598ab0419a4388c00d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e19a0c0a7d6f2177183150598ab0419a4388c00d
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 02 Apr 2021 12:50:14 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 14:34:48 +01:00

irqdomain: Reimplement irq_linear_revmap() with irq_find_mapping()

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
index 9f884c9..42b3f7d 100644
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
index 6284443..8bd0122 100644
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
