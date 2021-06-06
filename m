Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138AE39CF16
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFFMp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:45:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35034 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhFFMpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:39 -0400
Date:   Sun, 06 Jun 2021 12:43:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983427;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CsWi2NXx/zzsD0siq7I87SCM4wR+ntVH4vQ29f+EyZU=;
        b=JQ3ebf5p0RY9U4Mz6Ro9OAMG3B/DjcN46ahU+P0j3ekZ0MTYqYR8jsmJ8Px4zcdYk74LDF
        h8XEJxMl2Qx9nrnyF8PexNxAa7IkRYWk7F3i98zXGqOWBQX7JGUIgd6mDwsUAEJqGTc1fM
        K+hPwMMNtLA6/QJQT5J5vlPfiI91IBawsFLTAV53geEpzqTkLG08b2bgmpUnzOGqv1KpaV
        6LUjyZB9pfd8eyeVZqSPvrdWnJVRu0+Cu/A1gcVack9GJ/r6HyYmz34C1YeFF3hSl2FOx2
        FY0e2Qa7Bivvw+bD+KK6HlPP1GqhMpCa16in9ZiQI+2PJErGWJKPHwADMNSW1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983427;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CsWi2NXx/zzsD0siq7I87SCM4wR+ntVH4vQ29f+EyZU=;
        b=jG1JKMhUqf1PJiWIzzul8pFOn9bTxYgvW7Yq8cxPg9Hirki15j0MCqn2iZkq82WeRmPDcq
        KarEq6jx5YAxn2AQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Use irq_resolve_mapping() to
 implement __handle_domain_irq() and co
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298342683.29796.7142738277768084602.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     23568360ce3fb1a095466409b77338b0f5d6ec6f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/23568360ce3fb1a095466409b77338b0f5d6ec6f
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 04 May 2021 14:24:37 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 17:35:36 +01:00

genirq: Use irq_resolve_mapping() to implement __handle_domain_irq() and co

In order to start reaping the benefits of irq_resolve_mapping(),
start using it in __handle_domain_irq() and handle_domain_nmi().

This involves splitting generic_handle_irq() to be able to directly
provide the irq_desc.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdesc.h |  1 +-
 kernel/irq/irqdesc.c    | 60 +++++++++++++++++++++++-----------------
 2 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index df46512..cdd1cf8 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -158,6 +158,7 @@ static inline void generic_handle_irq_desc(struct irq_desc *desc)
 	desc->handle_irq(desc);
 }
 
+int handle_irq_desc(struct irq_desc *desc);
 int generic_handle_irq(unsigned int irq);
 
 #ifdef CONFIG_HANDLE_DOMAIN_IRQ
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 4a617d7..684c5b7 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -632,14 +632,8 @@ void irq_init_desc(unsigned int irq)
 
 #endif /* !CONFIG_SPARSE_IRQ */
 
-/**
- * generic_handle_irq - Invoke the handler for a particular irq
- * @irq:	The irq number to handle
- *
- */
-int generic_handle_irq(unsigned int irq)
+int handle_irq_desc(struct irq_desc *desc)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
 	struct irq_data *data;
 
 	if (!desc)
@@ -652,6 +646,17 @@ int generic_handle_irq(unsigned int irq)
 	generic_handle_irq_desc(desc);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(handle_irq_desc);
+
+/**
+ * generic_handle_irq - Invoke the handler for a particular irq
+ * @irq:	The irq number to handle
+ *
+ */
+int generic_handle_irq(unsigned int irq)
+{
+	return handle_irq_desc(irq_to_desc(irq));
+}
 EXPORT_SYMBOL_GPL(generic_handle_irq);
 
 #ifdef CONFIG_HANDLE_DOMAIN_IRQ
@@ -668,27 +673,32 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
 			bool lookup, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	unsigned int irq = hwirq;
+	struct irq_desc *desc;
 	int ret = 0;
 
 	irq_enter();
 
-#ifdef CONFIG_IRQ_DOMAIN
-	if (lookup)
-		irq = irq_find_mapping(domain, hwirq);
-#endif
-
-	/*
-	 * Some hardware gives randomly wrong interrupts.  Rather
-	 * than crashing, do something sensible.
-	 */
-	if (unlikely(!irq || irq >= nr_irqs)) {
-		ack_bad_irq(irq);
-		ret = -EINVAL;
+	if (likely(IS_ENABLED(CONFIG_IRQ_DOMAIN) && lookup)) {
+		/* The irqdomain code provides boundary checks */
+		desc = irq_resolve_mapping(domain, hwirq);
 	} else {
-		generic_handle_irq(irq);
+		/*
+		 * Some hardware gives randomly wrong interrupts.  Rather
+		 * than crashing, do something sensible.
+		 */
+		if (unlikely(!hwirq || hwirq >= nr_irqs)) {
+			ack_bad_irq(hwirq);
+			desc = NULL;
+		} else {
+			desc = irq_to_desc(hwirq);
+		}
 	}
 
+	if (likely(desc))
+		handle_irq_desc(desc);
+	else
+		ret = -EINVAL;
+
 	irq_exit();
 	set_irq_regs(old_regs);
 	return ret;
@@ -709,7 +719,7 @@ int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
 		      struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	unsigned int irq;
+	struct irq_desc *desc;
 	int ret = 0;
 
 	/*
@@ -717,14 +727,14 @@ int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
 	 */
 	WARN_ON(!in_nmi());
 
-	irq = irq_find_mapping(domain, hwirq);
+	desc = irq_resolve_mapping(domain, hwirq);
 
 	/*
 	 * ack_bad_irq is not NMI-safe, just report
 	 * an invalid interrupt.
 	 */
-	if (likely(irq))
-		generic_handle_irq(irq);
+	if (likely(desc))
+		handle_irq_desc(desc);
 	else
 		ret = -EINVAL;
 
