Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1053A4374
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhFKN4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:56:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40020 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhFKN4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:34 -0400
Date:   Fri, 11 Jun 2021 13:54:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YVJMdU9IBR9sxmR9TZmhLwlFKltw5coAXmonIOUAIkA=;
        b=XAi93wKPm6SB0+A9WPPbbgo3xTdTYK5mpErOsZB832q6ddmYXZQNW/6Y2dCqJPUqijez2M
        8YtnCNSVKjuoFVb22alH9iORKJfWAHF1DkSXCPPjkmo++GhM+cYq/cAZN946Xa4kcbKx13
        BO8dJ5uF7WCTGHC/limHhu2K4gA6orHnLneljsc+RxrBZKkRS/ZBfkZ/45OkkCUe46YxlB
        +UNKECPEc49s9VbzGjJq1IsPuSgOHgZiZ1Qwpx9i6At9EVfj5fNe78C/u/C1oms/dGj/7v
        5tQXDWLjv/9wWo3xBwvCIeThKwWSX27PggjZJ3KiDrRc5i8hMXN6WUcueVDg3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YVJMdU9IBR9sxmR9TZmhLwlFKltw5coAXmonIOUAIkA=;
        b=By8r+q5fq+Rau2fWncZdwPmOGVAaeFRJhzgtbRnlbWJ2dCk1DJs06QpjgkawH65Rc/DP7q
        2BiPhJ3SqNGnF/Bg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Add generic_handle_domain_irq() helper
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341967477.19906.1865117073767373222.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     8240ef50d4864325b346e40bb9d30cda9f22102d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/8240ef50d4864325b346e40bb9d30cda9f22102d
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 12 May 2021 13:45:52 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:19 +01:00

genirq: Add generic_handle_domain_irq() helper

Provide generic_handle_domain_irq() as a pendent to handle_domain_irq()
for non-root interrupt controllers

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdesc.h |  2 ++
 kernel/irq/irqdesc.c    | 19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 2971eb7..0f226c6 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -170,6 +170,8 @@ int generic_handle_irq(unsigned int irq);
 int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
 			bool lookup, struct pt_regs *regs);
 
+int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq);
+
 static inline int handle_domain_irq(struct irq_domain *domain,
 				    unsigned int hwirq, struct pt_regs *regs)
 {
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 684c5b7..6179d5b 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -661,7 +661,24 @@ EXPORT_SYMBOL_GPL(generic_handle_irq);
 
 #ifdef CONFIG_HANDLE_DOMAIN_IRQ
 /**
- * __handle_domain_irq - Invoke the handler for a HW irq belonging to a domain
+ * generic_handle_domain_irq - Invoke the handler for a HW irq belonging
+ *                             to a domain, usually for a non-root interrupt
+ *                             controller
+ * @domain:	The domain where to perform the lookup
+ * @hwirq:	The HW irq number to convert to a logical one
+ *
+ * Returns:	0 on success, or -EINVAL if conversion has failed
+ *
+ */
+int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
+{
+	return handle_irq_desc(irq_resolve_mapping(domain, hwirq));
+}
+EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
+
+/**
+ * __handle_domain_irq - Invoke the handler for a HW irq belonging to a domain,
+ *                       usually for a root interrupt controller
  * @domain:	The domain where to perform the lookup
  * @hwirq:	The HW irq number to convert to a logical one
  * @lookup:	Whether to perform the domain lookup or not
