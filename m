Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B9A3681F0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 15:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbhDVNx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 09:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbhDVNxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:53:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5D2C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 06:53:18 -0700 (PDT)
Date:   Thu, 22 Apr 2021 13:53:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619099597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WcfB3ct4w6zud7H9VLAtgLjAI6Bb4TPdQbUpW8Bitns=;
        b=f9Rf53f5hKNImVvQiV6KrOku6LkbNUpmG4y5oTS5otYVfjMMmz3hA+aJVCOr1Bzi2Lkm19
        dRQKdp92ICMfJsR3EaRMgSRKNkDa7VuJrhWJZ8F1plUeFHsDOFefpc80gDw184KXDxdpdk
        7WabhNHQa9K+j5cyiPUf9UWgpDT4qv5LPnXgNk3KFYhCu5Xarfzs7m6xY+s80UMqFwKgof
        zdv5mlG7LGPYkv+iIlvR/AYE0VmKLqcXpYZ2Bclp7qHITBW+xZfbEBj/MztiD0sjv9NYhU
        rdDHWyEAavHoOhIBkk0EdsLoxieyV1SqcJ2PFmuI2P/FK7dCp4wKWCwmSBaneQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619099597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WcfB3ct4w6zud7H9VLAtgLjAI6Bb4TPdQbUpW8Bitns=;
        b=JUZbSyTCJNs2Nj2/ImIQtIs10w+6eYk7k/jl1dwn3/X0skliPbOAyfqrKeX66kXw5WWOr3
        lBaY99b8+U4YlICg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Get rid of
 irq_create_strict_mappings()
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <161909959669.29796.11320996521266638188.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     941a3d73a4d774abebf8fcc5c0334dec604c6645
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/941a3d73a4d774abebf8fcc5c0334dec604c6645
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 02 Apr 2021 16:02:37 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 22 Apr 2021 14:48:02 +01:00

irqdomain: Get rid of irq_create_strict_mappings()

No user of this helper is left, remove it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h |  3 ---
 kernel/irq/irqdomain.c    | 32 --------------------------------
 2 files changed, 35 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index d2c61de..7a1dd7b 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -415,9 +415,6 @@ static inline unsigned int irq_linear_revmap(struct irq_domain *domain,
 extern unsigned int irq_find_mapping(struct irq_domain *host,
 				     irq_hw_number_t hwirq);
 extern unsigned int irq_create_direct_mapping(struct irq_domain *host);
-extern int irq_create_strict_mappings(struct irq_domain *domain,
-				      unsigned int irq_base,
-				      irq_hw_number_t hwirq_base, int count);
 
 extern const struct irq_domain_ops irq_domain_simple_ops;
 
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 35c5a99..24a3cef 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -703,38 +703,6 @@ unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
 }
 EXPORT_SYMBOL_GPL(irq_create_mapping_affinity);
 
-/**
- * irq_create_strict_mappings() - Map a range of hw irqs to fixed linux irqs
- * @domain: domain owning the interrupt range
- * @irq_base: beginning of linux IRQ range
- * @hwirq_base: beginning of hardware IRQ range
- * @count: Number of interrupts to map
- *
- * This routine is used for allocating and mapping a range of hardware
- * irqs to linux irqs where the linux irq numbers are at pre-defined
- * locations. For use by controllers that already have static mappings
- * to insert in to the domain.
- *
- * 0 is returned upon success, while any failure to establish a static
- * mapping is treated as an error.
- */
-int irq_create_strict_mappings(struct irq_domain *domain, unsigned int irq_base,
-			       irq_hw_number_t hwirq_base, int count)
-{
-	struct device_node *of_node;
-	int ret;
-
-	of_node = irq_domain_get_of_node(domain);
-	ret = irq_alloc_descs(irq_base, irq_base, count,
-			      of_node_to_nid(of_node));
-	if (unlikely(ret < 0))
-		return ret;
-
-	irq_domain_associate_many(domain, irq_base, hwirq_base, count);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(irq_create_strict_mappings);
-
 static int irq_domain_translate(struct irq_domain *d,
 				struct irq_fwspec *fwspec,
 				irq_hw_number_t *hwirq, unsigned int *type)
