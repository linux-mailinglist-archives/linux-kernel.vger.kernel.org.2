Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8273A437A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhFKN5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:57:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40016 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbhFKN4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:36 -0400
Date:   Fri, 11 Jun 2021 13:54:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419678;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=930WaPPqG6b5v1juL6lPVyiAduC26UVic3w+MaCYw5k=;
        b=m8CY52KCG8jXpf5xfL6bQRWstli4ZgswENB7dZc3N2oei8M9TANbbLhjyY7VAsLOwKzPXM
        zCY7ggzFHB/FV10808pR4el2ffD3Izrq9ukrBSMDLv/wLC0/uiRCKMx0ZEHqseKobUlNkp
        nNiN5KRwwdzhmTfvmMeegZnDWI5NjbFoHsdlyVkEBc5ygT8MhvKI34LxXEvebFQnNhFBg8
        TKsHl+YIR5z39yZUZdvkKRAdH2WEfnEezBiCcJ2IkywIEf3ycIDJqxEJR+e0Hkay99cCbe
        ggUgQbJT0uiTJAUV3W0Ab+QNi2oGWNSNGoIrBCmXfinIYeFdRKfrMPi/s29dmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419678;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=930WaPPqG6b5v1juL6lPVyiAduC26UVic3w+MaCYw5k=;
        b=pQHTMT2tjx+xJis68mygS+TD1PC8mMZeLfVshcLvR2D/Ad9awDtt3U6jjPek1sQgeht56u
        HmboNbfX+aC8RMCw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Cache irq_data instead of a
 virq number in the revmap
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341967748.19906.10241922676882648860.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     48b15a7921d60680babe59f64e127816585a585c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/48b15a7921d60680babe59f64e127816585a585c
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 05 Apr 2021 11:46:53 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:18 +01:00

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
