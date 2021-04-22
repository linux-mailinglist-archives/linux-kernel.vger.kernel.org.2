Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EB83682FC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbhDVPIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236577AbhDVPIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:08:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30BEC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 08:07:38 -0700 (PDT)
Date:   Thu, 22 Apr 2021 15:07:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619104056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pZMP+AcRLzYMs2hW56tXxzSy71po+zf8PGjMOHhgswc=;
        b=R7RwgCIXkxcqXWKDNRt7OMsjUKFPhMX9AOxGJ44RAteEBglWnL8FhjHjd8zMYjSBi3qsA2
        ZBCiGC9h51/wXM24IlMSMhYEs88U2ScF5ZQi1Hi2PKQLcJ8rDiU9sq9sS1ZqLx7VdnWhrs
        fO15AOzdM4qL5YhwkRpbZWZorrfyXCAW0pcWokp7EtttFEd0xoUFXL8HtbXw+DnSBQUMzZ
        C4tVRKZzYKFbj0W9Xx6Sxm14jDHpgSJedgErxFzGGTqzQTw1LQpjY9sd1hDhYsmCwQT8Jv
        poxBlEq5XQYiVJ0EQgnpZiAoPlUXwwDSVWRkcAu8O9isee2x2fvNaW5pcKRbnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619104056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pZMP+AcRLzYMs2hW56tXxzSy71po+zf8PGjMOHhgswc=;
        b=eLWs2bTBh+H0S5K0NWv1WLEBBhhdeQwode+45SbL2JpJBVZP4Pes0ClAL5oBov3CviVzAb
        foVJKqzIJQdxpQBQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Drop references to recusive
 irqdomain setup
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210406093557.1073423-8-maz@kernel.org>
References: <20210406093557.1073423-8-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <161910405559.29796.5639122210270701974.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     817aad5d08d2ee61de7353ecb4593b0df495b12e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/817aad5d08d2ee61de7353ecb4593b0df495b12e
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 06 Apr 2021 10:35:55 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 22 Apr 2021 15:55:22 +01:00

irqdomain: Drop references to recusive irqdomain setup

It was never completely implemented, and was removed a long time
ago. Adjust the documentation to reflect this.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210406093557.1073423-8-maz@kernel.org
---
 kernel/irq/irqdomain.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 24a3cef..6ab428f 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1659,12 +1659,10 @@ void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs)
 
 /**
  * irq_domain_alloc_irqs_parent - Allocate interrupts from parent domain
+ * @domain:	Domain below which interrupts must be allocated
  * @irq_base:	Base IRQ number
  * @nr_irqs:	Number of IRQs to allocate
  * @arg:	Allocation data (arch/domain specific)
- *
- * Check whether the domain has been setup recursive. If not allocate
- * through the parent domain.
  */
 int irq_domain_alloc_irqs_parent(struct irq_domain *domain,
 				 unsigned int irq_base, unsigned int nr_irqs,
@@ -1680,11 +1678,9 @@ EXPORT_SYMBOL_GPL(irq_domain_alloc_irqs_parent);
 
 /**
  * irq_domain_free_irqs_parent - Free interrupts from parent domain
+ * @domain:	Domain below which interrupts must be freed
  * @irq_base:	Base IRQ number
  * @nr_irqs:	Number of IRQs to free
- *
- * Check whether the domain has been setup recursive. If not free
- * through the parent domain.
  */
 void irq_domain_free_irqs_parent(struct irq_domain *domain,
 				 unsigned int irq_base, unsigned int nr_irqs)
