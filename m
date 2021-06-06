Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE98539CF15
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhFFMpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:45:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35032 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhFFMpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:39 -0400
Date:   Sun, 06 Jun 2021 12:43:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983428;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=a/qey5VSXHGn6QXpxSaX7QbdEKKNYhU547eQ7paDc5Q=;
        b=07kHlz1C3ajL07wLjKwfqO5maYSr2ZtYAzYieRe4gIRaW8WqStZoEwuNvwfroBCEhQwHqV
        3yaEZww4CO4/lNWA6Djam6CRA8ts1J21fDjExKUnfr9/9rvlZOMbCWBfEjK3+nlUYN0mwu
        pVbSTdFbhI85zDZG1m4CbdKBGcCicC1pePyr9q8mVtUNA6RkCytgmbdoTWf+MM7Rv/A/mh
        8xTVEzneR9UK1D5LXk16iVuPbJ6S70BOidCCHDPYZGBpY7V1c30BnM4vkeNZ8qvxxGWVzR
        ThvJMx4KkLtfompioKF1FeAAAW+bCODOTlXAm7qwq8MzsQ9UgzQSREcbyTTTng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983428;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=a/qey5VSXHGn6QXpxSaX7QbdEKKNYhU547eQ7paDc5Q=;
        b=3o+Jj9HxJGnXjaa8AuC/6im9wgTPazahz8e9gvH7D8NMQx91o4H1jS5kBbMfZYAcXKgJIS
        ma8ORjTNycdV8JAQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Introduce irq_resolve_mapping()
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298342725.29796.5624405969623096364.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     c24b101789faab2e325b6d48171524f5337a72cf
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c24b101789faab2e325b6d48171524f5337a72cf
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 04 May 2021 14:00:13 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 17:35:36 +01:00

irqdomain: Introduce irq_resolve_mapping()

Rework irq_find_mapping() to return an both an irq_desc pointer,
optionally the virtual irq number, and rename the result to
__irq_resolve_mapping(). a new helper called irq_resolve_mapping()
is provided for code that doesn't need the virtual irq number.

irq_find_mapping() is also rewritten in terms of __irq_resolve_mapping().

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h | 25 ++++++++++++++++++++++---
 kernel/irq/irqdomain.c    | 28 ++++++++++++++++++++--------
 2 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 2b696c9..5b7de06 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -31,7 +31,8 @@
 #define _LINUX_IRQDOMAIN_H
 
 #include <linux/types.h>
-#include <linux/irqhandler.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
 #include <linux/of.h>
 #include <linux/mutex.h>
 #include <linux/radix-tree.h>
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
index 8e55bb8..012d6bf 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -876,29 +876,34 @@ void irq_dispose_mapping(unsigned int virq)
 EXPORT_SYMBOL_GPL(irq_dispose_mapping);
 
 /**
- * irq_find_mapping() - Find a linux irq from a hw irq number.
+ * irq_resolve_mapping() - Find a linux irq from a hw irq number.
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
@@ -907,10 +912,17 @@ unsigned int irq_find_mapping(struct irq_domain *domain,
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
