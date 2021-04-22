Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A543682F9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbhDVPIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:08:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39132 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbhDVPIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:08:12 -0400
Date:   Thu, 22 Apr 2021 15:07:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619104056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZGfiGsMRHeJPRueHLZzFQCtIzTmQAPI7W5LlbuhINFk=;
        b=Ih+Fz4gHxmVEG8GjgdYLd/iC0Fx6feodkm3pv6f0N1ztLDQ6Xpe5cEOcGcbEjSJaHlnEoF
        s/84HivOvcJDzMpN2qJK+gZx/8BVcZx37z/+2eLKpR3CIKh/X1CUclv3Xz36COiSYhKpVt
        QHFRqMWobKM8cAM7uIOGoak+sxmnxmSZqElvfhGJF260SmWb4fLAogtz7+TdSwRCa7UJPj
        Nl4n/0/e8btrx5OftXMFK5IbUEihT91dorVSf07ierpFEOV0fkVELw9I3pYuyD5cZ1NZXe
        j8rMKOwyRT4+Uw9biMXOly4V2SnqdjhUacAdGxaDGpo8wm2BXBZfqYh88RrbYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619104056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZGfiGsMRHeJPRueHLZzFQCtIzTmQAPI7W5LlbuhINFk=;
        b=YtnLOJCtpgoXsCHFx4TnvO1o2bYKpomE2erN+VdVmfeZBbCCsL1zd//X2vfPbhYRmEVfyg
        fKTSVCwn9Tnt8DAA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Get rid of
 irq_create_strict_mappings()
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <161910405598.29796.17479991979187463151.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     1a0b05e435544cd53cd3936bdab425d88784b71a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1a0b05e435544cd53cd3936bdab425d88784b71a
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 02 Apr 2021 16:02:37 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 22 Apr 2021 15:55:22 +01:00

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
