Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D99D356C58
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352361AbhDGMjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352251AbhDGMi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:38:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F1AC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 05:38:17 -0700 (PDT)
Date:   Wed, 07 Apr 2021 12:38:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617799096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=B3SKCj67HtGIUNYrAZNPCY8m73GsrvPOMFZzukOIcSg=;
        b=KjdYw9TLTsd8OEoi02w9CgWFGcbhF8RoEwINKsmv/XmkATeImevbKl5n50E1UPLjsj2052
        djA2IzimrdR/CMVchzz+GJZjJ4zgRitAs6IyZ95yv05P7qgbj2luzvGwCfk1ZZH6qJNZee
        AEz+dL6stkT2rNF7GfJKdjYr45ysjvm/ZBgowvswp3+K+JEqslWZAoN3i0dpq0pmmDYQoA
        VrIbgYcE6/jpybq3L8AyhJ9T5SFUNV6xRUPu6EO1tcyZzbT9f/Bp51JNGo6tLEEO+fzdjO
        l3Zk5OEFrHR5rMp1pzTErvYHdM55W/GLlkPYRDDcQhq+6R07LXR22qoKKAc35g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617799096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=B3SKCj67HtGIUNYrAZNPCY8m73GsrvPOMFZzukOIcSg=;
        b=Sv46Adc6HB59P2vl48uhkz7D8/zFmT4bJbIjMPcEHQB7jaj42fbOIaZZCpUVnClnWpOYLF
        r4skRYx1OyrZoqBw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] sh: intc: Drop the use of
 irq_create_identity_mapping()
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <161779909572.29796.5195363389122714492.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     eef56c3a0492e4c1bc2a081da8f402a26d882489
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/eef56c3a0492e4c1bc2a081da8f402a26d882489
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 02 Apr 2021 15:58:21 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 07 Apr 2021 12:12:52 +01:00

sh: intc: Drop the use of irq_create_identity_mapping()

Instead of playing games with using irq_create_identity_mapping()
and irq_domain_associate(), drop the use of the former and only
use the latter, together with the allocation of the irq_desc
as needed.

It doesn't make the code less awful, but at least the intent
is clearer.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/sh/intc/core.c | 49 +++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index a14684f..ca4f4ca 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -179,6 +179,21 @@ static unsigned int __init save_reg(struct intc_desc_int *d,
 	return 0;
 }
 
+static bool __init intc_map(struct irq_domain *domain, int irq)
+{
+	if (!irq_to_desc(irq) && irq_alloc_desc_at(irq, NUMA_NO_NODE) != irq) {
+		pr_err("uname to allocate IRQ %d\n", irq);
+		return false;
+	}
+
+	if (irq_domain_associate(domain, irq, irq)) {
+		pr_err("domain association failure\n");
+		return false;
+	}
+
+	return true;
+}
+
 int __init register_intc_controller(struct intc_desc *desc)
 {
 	unsigned int i, k, smp;
@@ -311,24 +326,12 @@ int __init register_intc_controller(struct intc_desc *desc)
 	for (i = 0; i < hw->nr_vectors; i++) {
 		struct intc_vect *vect = hw->vectors + i;
 		unsigned int irq = evt2irq(vect->vect);
-		int res;
 
 		if (!vect->enum_id)
 			continue;
 
-		res = irq_create_identity_mapping(d->domain, irq);
-		if (unlikely(res)) {
-			if (res == -EEXIST) {
-				res = irq_domain_associate(d->domain, irq, irq);
-				if (unlikely(res)) {
-					pr_err("domain association failure\n");
-					continue;
-				}
-			} else {
-				pr_err("can't identity map IRQ %d\n", irq);
-				continue;
-			}
-		}
+		if (!intc_map(d->domain, irq))
+			continue;
 
 		intc_irq_xlate_set(irq, vect->enum_id, d);
 		intc_register_irq(desc, d, vect->enum_id, irq);
@@ -345,22 +348,8 @@ int __init register_intc_controller(struct intc_desc *desc)
 			 * IRQ support, each vector still needs to have
 			 * its own backing irq_desc.
 			 */
-			res = irq_create_identity_mapping(d->domain, irq2);
-			if (unlikely(res)) {
-				if (res == -EEXIST) {
-					res = irq_domain_associate(d->domain,
-								   irq2, irq2);
-					if (unlikely(res)) {
-						pr_err("domain association "
-						       "failure\n");
-						continue;
-					}
-				} else {
-					pr_err("can't identity map IRQ %d\n",
-					       irq);
-					continue;
-				}
-			}
+			if (!intc_map(d->domain, irq2))
+				continue;
 
 			vect2->enum_id = 0;
 
