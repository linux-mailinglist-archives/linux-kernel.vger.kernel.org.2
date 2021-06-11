Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E123A4373
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhFKN4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:56:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40016 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhFKN4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:33 -0400
Date:   Fri, 11 Jun 2021 13:54:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RG+UJcy4ktq2/nPCL2lVDe1UQ9wpT5HBU7pVdOJ0dto=;
        b=cAv+KjdFPpK5TfALVK42+BWKp+EG58N/AtQP1vEXm+nNFWHXi42Or0zkLpj0vY6OKLQt93
        2a2jxDCLt831TkqULa3dX8BfDIvzjtuOHhGdT2Ds3+c8KTOZpd5lVQ+gp+ykva4Z5LnxYP
        1PUFGVHEiEMpNPzaOMHSuFUwainCY2ILS5XBwp8pTtjacJiih6WkOLm5DmuIIqfzX8QJbs
        bK/J1ig0u65bNFqqDpp4q3f2X9YumlDnrKfVlujoUbQH7G4FWf41Hhdi2Ip48npmir4nTF
        bwCl+PsT4vj/HwYNQKtvZWpgbAjQvtwl54BqXMjCcsx5fOyI5O8JLs0W4ViZmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RG+UJcy4ktq2/nPCL2lVDe1UQ9wpT5HBU7pVdOJ0dto=;
        b=mOb5RM6f8Iu/GZSuSuMmZuJFGc+YxqpzP8XMSh/tYNNacVeUYvFmS5S6O+ZkLPQ2/k5LOY
        oGxtabmRB2SKHvDw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Move non-irqdomain
 handle_domain_irq() handling into ARM's handle_IRQ()
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341967429.19906.10699430357680006437.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     e1c054918c6c7a30a35d2c183ed86600a071cdab
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e1c054918c6c7a30a35d2c183ed86600a071cdab
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 12 May 2021 16:18:15 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:19 +01:00

genirq: Move non-irqdomain handle_domain_irq() handling into ARM's handle_IRQ()

Despite the name, handle_domain_irq() deals with non-irqdomain
handling for the sake of a handful of legacy ARM platforms.

Move such handling into ARM's handle_IRQ(), allowing for better
code generation for everyone else. This allows us get rid of
some complexity, and to rearrange the guards on the various helpers
in a more logical way.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/kernel/irq.c   | 22 +++++++++++++++++++++-
 include/linux/irqdesc.h | 14 ++++----------
 kernel/irq/irqdesc.c    | 30 ++++++++----------------------
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 698b6f6..20ab1e6 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -63,7 +63,27 @@ int arch_show_interrupts(struct seq_file *p, int prec)
  */
 void handle_IRQ(unsigned int irq, struct pt_regs *regs)
 {
-	__handle_domain_irq(NULL, irq, false, regs);
+	struct pt_regs *old_regs = set_irq_regs(regs);
+	struct irq_desc *desc;
+
+	irq_enter();
+
+	/*
+	 * Some hardware gives randomly wrong interrupts.  Rather
+	 * than crashing, do something sensible.
+	 */
+	if (unlikely(!irq || irq >= nr_irqs))
+		desc = NULL;
+	else
+		desc = irq_to_desc(irq);
+
+	if (likely(desc))
+		handle_irq_desc(desc);
+	else
+		ack_bad_irq(irq);
+
+	irq_exit();
+	set_irq_regs(old_regs);
 }
 
 /*
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 0f226c6..59aea39 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -161,24 +161,18 @@ static inline void generic_handle_irq_desc(struct irq_desc *desc)
 int handle_irq_desc(struct irq_desc *desc);
 int generic_handle_irq(unsigned int irq);
 
-#ifdef CONFIG_HANDLE_DOMAIN_IRQ
+#ifdef CONFIG_IRQ_DOMAIN
 /*
  * Convert a HW interrupt number to a logical one using a IRQ domain,
  * and handle the result interrupt number. Return -EINVAL if
  * conversion failed.
  */
-int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
-			bool lookup, struct pt_regs *regs);
-
 int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq);
 
-static inline int handle_domain_irq(struct irq_domain *domain,
-				    unsigned int hwirq, struct pt_regs *regs)
-{
-	return __handle_domain_irq(domain, hwirq, true, regs);
-}
+#ifdef CONFIG_HANDLE_DOMAIN_IRQ
+int handle_domain_irq(struct irq_domain *domain,
+		      unsigned int hwirq, struct pt_regs *regs);
 
-#ifdef CONFIG_IRQ_DOMAIN
 int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
 		      struct pt_regs *regs);
 #endif
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 6179d5b..f4dd518 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -659,7 +659,7 @@ int generic_handle_irq(unsigned int irq)
 }
 EXPORT_SYMBOL_GPL(generic_handle_irq);
 
-#ifdef CONFIG_HANDLE_DOMAIN_IRQ
+#ifdef CONFIG_IRQ_DOMAIN
 /**
  * generic_handle_domain_irq - Invoke the handler for a HW irq belonging
  *                             to a domain, usually for a non-root interrupt
@@ -676,9 +676,10 @@ int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
 }
 EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
 
+#ifdef CONFIG_HANDLE_DOMAIN_IRQ
 /**
- * __handle_domain_irq - Invoke the handler for a HW irq belonging to a domain,
- *                       usually for a root interrupt controller
+ * handle_domain_irq - Invoke the handler for a HW irq belonging to a domain,
+ *                     usually for a root interrupt controller
  * @domain:	The domain where to perform the lookup
  * @hwirq:	The HW irq number to convert to a logical one
  * @lookup:	Whether to perform the domain lookup or not
@@ -686,8 +687,8 @@ EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
  *
  * Returns:	0 on success, or -EINVAL if conversion has failed
  */
-int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
-			bool lookup, struct pt_regs *regs)
+int handle_domain_irq(struct irq_domain *domain,
+		      unsigned int hwirq, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	struct irq_desc *desc;
@@ -695,22 +696,8 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
 
 	irq_enter();
 
-	if (likely(IS_ENABLED(CONFIG_IRQ_DOMAIN) && lookup)) {
-		/* The irqdomain code provides boundary checks */
-		desc = irq_resolve_mapping(domain, hwirq);
-	} else {
-		/*
-		 * Some hardware gives randomly wrong interrupts.  Rather
-		 * than crashing, do something sensible.
-		 */
-		if (unlikely(!hwirq || hwirq >= nr_irqs)) {
-			ack_bad_irq(hwirq);
-			desc = NULL;
-		} else {
-			desc = irq_to_desc(hwirq);
-		}
-	}
-
+	/* The irqdomain code provides boundary checks */
+	desc = irq_resolve_mapping(domain, hwirq);
 	if (likely(desc))
 		handle_irq_desc(desc);
 	else
@@ -721,7 +708,6 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
 	return ret;
 }
 
-#ifdef CONFIG_IRQ_DOMAIN
 /**
  * handle_domain_nmi - Invoke the handler for a HW irq belonging to a domain
  * @domain:	The domain where to perform the lookup
