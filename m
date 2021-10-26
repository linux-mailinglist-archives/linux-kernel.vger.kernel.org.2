Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B85443AFCF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbhJZKSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:18:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60682 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhJZKSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:18:22 -0400
Date:   Tue, 26 Oct 2021 10:15:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635243358;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fK+Y+XR+j37UjagiN6sdtp7X6NSqmCw+m90JAJxE4SI=;
        b=tBvRtr8amT022Pvpw5Lu9v9vA2EnHXvDg9dZ7VdmDpxNcdZWyJ3fz8BztQ+kWwhhro8yNd
        DB1lcrdjgz5sn4dRYQStWm8rKQ4QYI18DtRCYjbekErU2rZpU05QLyul6ckGVncZCvUqLn
        XrE66kH+iDraBzLQfjKF0KnH8Z7Q9Fq9lPe/Oh0OxD0pDp1scXoidmfEEjBvUo6tRVOPqL
        MMVnA5PvVzGsXQ6hyaSxV3cWmYGcCQpK9kVMKI4KVXjXUJYncyQ7mFavxgGMgBFPnqlF/u
        jjNbcnY0GWhjAlzkpoauAV4PzQzavLRqsKnZrI5T0IIrKqlggNXrhD1u6WZYcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635243358;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fK+Y+XR+j37UjagiN6sdtp7X6NSqmCw+m90JAJxE4SI=;
        b=Sp9qRf5NH4QrYRKdcLz6lNd660tXfH1yMQNlplrKXVqFZKIuuZQfYgo82gd5sLNZaquGdZ
        HiD/JIqdH54lcLCw==
From:   "irqchip-bot for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irq: remove CONFIG_HANDLE_DOMAIN_IRQ_IRQENTRY
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Message-ID: <163524335748.626.3488572113627349556.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     5aecc243776e89b0c462edd0a589030baba99ef8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/5aecc243776e89b0c462edd0a589030baba99ef8
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 20 Oct 2021 15:49:03 +01:00
Committer:     Mark Rutland <mark.rutland@arm.com>
CommitterDate: Tue, 26 Oct 2021 10:13:30 +01:00

irq: remove CONFIG_HANDLE_DOMAIN_IRQ_IRQENTRY

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
index 5677a84..7041698 100644
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
