Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EFB43AF09
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhJZJ2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:28:52 -0400
Received: from foss.arm.com ([217.140.110.172]:55760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235135AbhJZJ2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:28:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FDAF1FB;
        Tue, 26 Oct 2021 02:26:10 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D66483F70D;
        Tue, 26 Oct 2021 02:26:07 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     aou@eecs.berkeley.edu, catalin.marinas@arm.com,
        deanbo422@gmail.com, green.hu@gmail.com, guoren@kernel.org,
        jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, maz@kernel.org, nickhu@andestech.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        tsbogend@alpha.franken.de, vgupta@kernel.org,
        vladimir.murzin@arm.com, will@kernel.org
Subject: [PATCH v2 16/17] irq: remove CONFIG_HANDLE_DOMAIN_IRQ_IRQENTRY
Date:   Tue, 26 Oct 2021 10:25:03 +0100
Message-Id: <20211026092504.27071-17-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211026092504.27071-1-mark.rutland@arm.com>
References: <20211026092504.27071-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all users of CONFIG_HANDLE_DOMAIN_IRQ perform the irq entry
work themselves, we can remove the legacy
CONFIG_HANDLE_DOMAIN_IRQ_IRQENTRY behaviour.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/irqdesc.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 5677a849cf1f..7041698a7bff 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -676,31 +676,6 @@ int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
 EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
 
 #ifdef CONFIG_HANDLE_DOMAIN_IRQ
-#ifdef CONFIG_HANDLE_DOMAIN_IRQ_IRQENTRY
-/**
- * handle_domain_irq - Invoke the handler for a HW irq belonging to a domain,
- *                     usually for a root interrupt controller
- * @domain:	The domain where to perform the lookup
- * @hwirq:	The HW irq number to convert to a logical one
- * @regs:	Register file coming from the low-level handling code
- *
- * Returns:	0 on success, or -EINVAL if conversion has failed
- */
-int handle_domain_irq(struct irq_domain *domain,
-		      unsigned int hwirq, struct pt_regs *regs)
-{
-	struct pt_regs *old_regs = set_irq_regs(regs);
-	int ret;
-
-	irq_enter();
-
-	ret = generic_handle_domain_irq(domain, hwirq);
-
-	irq_exit();
-	set_irq_regs(old_regs);
-	return ret;
-}
-#else
 /**
  * handle_domain_irq - Invoke the handler for a HW irq belonging to a domain,
  *                     usually for a root interrupt controller
@@ -728,7 +703,6 @@ int handle_domain_irq(struct irq_domain *domain,
 	set_irq_regs(old_regs);
 	return ret;
 }
-#endif
 
 /**
  * handle_domain_nmi - Invoke the handler for a HW irq belonging to a domain
-- 
2.11.0

