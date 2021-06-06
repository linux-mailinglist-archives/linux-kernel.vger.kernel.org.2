Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC3F39CF11
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFFMpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhFFMpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23DCC061787
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:43:48 -0700 (PDT)
Date:   Sun, 06 Jun 2021 12:43:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=q9v/cuSXsPM0mPJhuhAR343/5fZMxBvALAtDhokhFZA=;
        b=qLvRH40WOkn2W352BhXpE4U42bMQtQCG+BrS0CFY098r8059zyOtMduf8rB1BUS9TksNSH
        eF0D+xdiknULFtTpjoTdWoOE913GQlThLxVDroNi84PvUCyAHPTBx7ifr7P8vOkQHgNoWy
        +4W0x2AUnPI/jZxOmke3+LVArtgVUcEJZIz34O/zhtyY6DBkx8VsaldSNbWK1tSYZv6ksP
        ylwuhUScd6aDb9QLz7y2/5uaUIhnyuExd73m0iFBgpiCMmAvlxjbdM51BX9HPDxF76ZNvf
        nxADhLYm5kPDgPS4yHeBiGvpThSx75sAzLJ+6lK8PyWA7j6Q/lKjv0GeXsPLfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=q9v/cuSXsPM0mPJhuhAR343/5fZMxBvALAtDhokhFZA=;
        b=GgdImiX1T3NuNEg+hgXJ9EG27KbZ8Leu7hq0CQGw2SqIbU5q/3zXgrKwf8b+SeemRsF9Ev
        GTxLwQGoNwOL03Cg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Add generic_handle_domain_irq() helper
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298342562.29796.8215575084721137387.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     a5195903ffc6702ea6d90ea53f724cb78750b5c7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a5195903ffc6702ea6d90ea53f724cb78750b5c7
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 12 May 2021 13:45:52 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 17:35:36 +01:00

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
