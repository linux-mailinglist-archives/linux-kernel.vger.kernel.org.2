Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3E63A4378
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhFKN5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:57:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40048 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhFKN4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:35 -0400
Date:   Fri, 11 Jun 2021 13:54:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419677;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LtW+xPX0za6us5QPvVlaZ+Y8mQCqrUEd5Vzl1XShWHU=;
        b=DSp1BIW7nFFr8DjC2NJFnJgwJ21dhONlVu0FwyubFk2EAmie91rL+CnFHHKwDmJsnYIMhk
        EgcYFlxbxRsFk5VkdlAD1AS0OOGtvsjl9KKERUlmMP8LMAXYRFWRVezw51OaTIxV1cU9XF
        W6/Pj6+eZhAMPyun9M/aiDPlX81UKb4/szYtcIQOrOZRDZaYy/yZfTYiJb2QOWZ17sR6jQ
        vsg5vedzutnPwZyNrfZTR0n6QTjaAtyLcGFhkBxsaTIJXmO4ZBf6Jie/NEZ/1S8G3bcVP7
        Yz54PP8ukQgeVADVDRJwU+BcR25TyP9bHouAgaQiFLPqzhW4BYPzzd4KLmArCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419677;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LtW+xPX0za6us5QPvVlaZ+Y8mQCqrUEd5Vzl1XShWHU=;
        b=h+LyenL9bY4LVoIsBjebkbGXLcGhRi8DK6eDPfz2vX0b6HxUpdKgp5XyuH8kcCNExlF+Nh
        IgMxQO/oFpQ307Aw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Introduce irq_resolve_mapping()
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341967655.19906.11759844373966672584.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     d22558dd0a6c888b1829f9d3a0a627e330e27585
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d22558dd0a6c888b1829f9d3a0a627e330e27585
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 04 May 2021 14:00:13 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:18 +01:00

irqdomain: Introduce irq_resolve_mapping()

Rework irq_find_mapping() to return an both an irq_desc pointer,
optionally the virtual irq number, and rename the result to
__irq_resolve_mapping(). a new helper called irq_resolve_mapping()
is provided for code that doesn't need the virtual irq number.

irq_find_mapping() is also rewritten in terms of __irq_resolve_mapping().

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h | 23 +++++++++++++++++++++--
 kernel/irq/irqdomain.c    | 28 ++++++++++++++++++++--------
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 2b696c9..23e4ee5 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -41,6 +41,7 @@ struct fwnode_handle;
 struct irq_domain;
 struct irq_chip;
 struct irq_data;
+struct irq_desc;
 struct cpumask;
 struct seq_file;
 struct irq_affinity_desc;
@@ -401,13 +402,31 @@ static inline unsigned int irq_create_mapping(struct irq_domain *host,
 	return irq_create_mapping_affinity(host, hwirq, NULL);
 }
 
+extern struct irq_desc *__irq_resolve_mapping(struct irq_domain *domain,
+					      irq_hw_number_t hwirq,
+					      unsigned int *irq);
+
+static inline struct irq_desc *irq_resolve_mapping(struct irq_domain *domain,
+						   irq_hw_number_t hwirq)
+{
+	return __irq_resolve_mapping(domain, hwirq, NULL);
+}
+
 /**
  * irq_find_mapping() - Find a linux irq from a hw irq number.
  * @domain: domain owning this hardware interrupt
  * @hwirq: hardware irq number in that domain space
  */
-extern unsigned int irq_find_mapping(struct irq_domain *host,
-				     irq_hw_number_t hwirq);
+static inline unsigned int irq_find_mapping(struct irq_domain *domain,
+					    irq_hw_number_t hwirq)
+{
+	unsigned int irq;
+
+	if (__irq_resolve_mapping(domain, hwirq, &irq))
+		return irq;
+
+	return 0;
+}
 
 static inline unsigned int irq_linear_revmap(struct irq_domain *domain,
 					     irq_hw_number_t hwirq)
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8fbadee..51c483c 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -884,29 +884,34 @@ void irq_dispose_mapping(unsigned int virq)
 EXPORT_SYMBOL_GPL(irq_dispose_mapping);
 
 /**
- * irq_find_mapping() - Find a linux irq from a hw irq number.
+ * __irq_resolve_mapping() - Find a linux irq from a hw irq number.
  * @domain: domain owning this hardware interrupt
  * @hwirq: hardware irq number in that domain space
+ * @irq: optional pointer to return the Linux irq if required
+ *
+ * Returns the interrupt descriptor.
  */
-unsigned int irq_find_mapping(struct irq_domain *domain,
-			      irq_hw_number_t hwirq)
+struct irq_desc *__irq_resolve_mapping(struct irq_domain *domain,
+				       irq_hw_number_t hwirq,
+				       unsigned int *irq)
 {
+	struct irq_desc *desc = NULL;
 	struct irq_data *data;
 
 	/* Look for default domain if necessary */
 	if (domain == NULL)
 		domain = irq_default_domain;
 	if (domain == NULL)
-		return 0;
+		return desc;
 
 	if (irq_domain_is_nomap(domain)) {
 		if (hwirq < domain->revmap_size) {
 			data = irq_domain_get_irq_data(domain, hwirq);
 			if (data && data->hwirq == hwirq)
-				return hwirq;
+				desc = irq_data_to_desc(data);
 		}
 
-		return 0;
+		return desc;
 	}
 
 	rcu_read_lock();
@@ -915,10 +920,17 @@ unsigned int irq_find_mapping(struct irq_domain *domain,
 		data = rcu_dereference(domain->revmap[hwirq]);
 	else
 		data = radix_tree_lookup(&domain->revmap_tree, hwirq);
+
+	if (likely(data)) {
+		desc = irq_data_to_desc(data);
+		if (irq)
+			*irq = data->irq;
+	}
+
 	rcu_read_unlock();
-	return data ? data->irq : 0;
+	return desc;
 }
-EXPORT_SYMBOL_GPL(irq_find_mapping);
+EXPORT_SYMBOL_GPL(__irq_resolve_mapping);
 
 /**
  * irq_domain_xlate_onecell() - Generic xlate for direct one cell bindings
