Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB873A4377
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhFKN5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhFKN4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08118C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:54:38 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:54:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4XrcOq3Om69M1FsSrJtF7QqLtkqFErnKFWQu64l2NOw=;
        b=DGHhkXEITT9HK2qIN1ObKbYVQ3W75gk+07PP9KCY7nJzST+VACQ2dg3WNdn6hNlfXEdopj
        twE1BSKkzRaXK4MUs4g5ZEzmYLV0UyC8zgZrJy+tmtCVV8qPxTlzwJ+c564qEZKavNbHWv
        DUgbqoGdrBzZmP9VPN+GUw87wwVsDchw0QQX6H9YjBiNvRHfOyYcJpa3nY8hVKQ/2NYLrY
        i+pyrFEyVSP38ccwH4wO52HimxaTkvx0uovVlN2mxwkzowkS2Cw63PlMAzrJ8kFam0sHpL
        tai11GaiMNhTv89DPhYGAR/8TTVK8UfhVKlVij8TmTMrSJWQDLINz1lgfdz1Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4XrcOq3Om69M1FsSrJtF7QqLtkqFErnKFWQu64l2NOw=;
        b=jTExfJ2Kare3EGDm735N/Rnv6DkHPSv7qaBT3bRznR7tHplL1WWfksrJby/aj4LvEcrWk9
        9fIghDZPsbc8BFAA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Use irq_resolve_mapping() to
 implement __handle_domain_irq() and co
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341967610.19906.5883897964445238739.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     a3016b26ee6ee13d5647d701404a7912d4eaea9e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a3016b26ee6ee13d5647d701404a7912d4eaea9e
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 04 May 2021 14:24:37 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:18 +01:00

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
 
