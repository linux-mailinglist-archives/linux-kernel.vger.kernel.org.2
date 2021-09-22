Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D9E414B18
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbhIVNyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbhIVNyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:54:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9125C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:53:22 -0700 (PDT)
Date:   Wed, 22 Sep 2021 13:53:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632318801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CH7tsAmJeh0xqRYIxsRQC+QLRbdM8LPzw0YzELw0bic=;
        b=ebtJeBOMVXXBMCePMUjG5Mci34PMoVJk+vki7qfiazYM52NTYyraWXKNWlISNjJkwtDXbk
        ElLqkk6RyOtOIGiyQMkUvNlAyk9uJWFfjQdYxrzc3GuF0FLnM1dwEF1/NSYarGyrDFZkvl
        8gVpLIy7uJL9Ey0YCOADRcBivRmnBjm0ksk114IAgl8/Fbk7F/8S5gQqsTMCl9G8XcQDwV
        lzRgVvRSWIJ7khuqPDB/LArBBdL+GSUvvJ9vYLYjEgLlz3IeCnGcfbDbiOhHvbFVADY1Np
        eylnk6jUGMRn/7yqCR+/mV+Q4XwHf8BrjLgsiHEDAkH4gIR3kSJm/Eaorqpv1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632318801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CH7tsAmJeh0xqRYIxsRQC+QLRbdM8LPzw0YzELw0bic=;
        b=W88mLVFc+05TBsVG/w0bAp+Q7YQYTPGR+SK5M9crJ2lbnakB6YSg5XjqimX9SbACi4pCjC
        NXryRoQetoJYZsDw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/gic: Work around broken Renesas
 integration
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <CAMuHMdV+Ev47K5NO8XHsanSq5YRMCHn2gWAQyV-q2LpJVy9HiQ@mail.gmail.com>
References: <CAMuHMdV+Ev47K5NO8XHsanSq5YRMCHn2gWAQyV-q2LpJVy9HiQ@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <163231880052.25758.17370626929263049968.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     b78f26926b17cc289e4f16b63363abe0aa2e8efc
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/b78f26926b17cc289e4f16b63363abe0aa2e8efc
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 10 Sep 2021 18:29:25 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 22 Sep 2021 14:44:25 +01:00

irqchip/gic: Work around broken Renesas integration

Geert reported that the GIC driver locks up on a Renesas system
since 005c34ae4b44f085 ("irqchip/gic: Atomically update affinity")
fixed the driver to use writeb_relaxed() instead of writel_relaxed().

As it turns out, the interconnect used on this system mandates
32bit wide accesses for all MMIO transactions, even if the GIC
architecture specifically mandates for some registers to be byte
accessible. Gahhh...

Work around the issue by crudly detecting the offending system,
and falling back to an inefficient RMW+lock implementation.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/CAMuHMdV+Ev47K5NO8XHsanSq5YRMCHn2gWAQyV-q2LpJVy9HiQ@mail.gmail.com
---
 drivers/irqchip/irq-gic.c | 52 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index d329ec3..5f22c9d 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -107,6 +107,8 @@ static DEFINE_RAW_SPINLOCK(cpu_map_lock);
 
 #endif
 
+static DEFINE_STATIC_KEY_FALSE(needs_rmw_access);
+
 /*
  * The GIC mapping of CPU interfaces does not necessarily match
  * the logical CPU numbering.  Let's use a mapping as returned
@@ -774,6 +776,25 @@ static int gic_pm_init(struct gic_chip_data *gic)
 #endif
 
 #ifdef CONFIG_SMP
+static void rmw_writeb(u8 bval, void __iomem *addr)
+{
+	static DEFINE_RAW_SPINLOCK(rmw_lock);
+	unsigned long offset = (unsigned long)addr & 3UL;
+	unsigned long shift = offset * 8;
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&rmw_lock, flags);
+
+	addr -= offset;
+	val = readl_relaxed(addr);
+	val &= ~GENMASK(shift + 7, shift);
+	val |= bval << shift;
+	writel_relaxed(val, addr);
+
+	raw_spin_unlock_irqrestore(&rmw_lock, flags);
+}
+
 static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 			    bool force)
 {
@@ -788,7 +809,10 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
 		return -EINVAL;
 
-	writeb_relaxed(gic_cpu_map[cpu], reg);
+	if (static_branch_unlikely(&needs_rmw_access))
+		rmw_writeb(gic_cpu_map[cpu], reg);
+	else
+		writeb_relaxed(gic_cpu_map[cpu], reg);
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
 	return IRQ_SET_MASK_OK_DONE;
@@ -1375,6 +1399,30 @@ static bool gic_check_eoimode(struct device_node *node, void __iomem **base)
 	return true;
 }
 
+static bool gic_enable_rmw_access(void *data)
+{
+	/*
+	 * The EMEV2 class of machines has a broken interconnect, and
+	 * locks up on accesses that are less than 32bit. So far, only
+	 * the affinity setting requires it.
+	 */
+	if (of_machine_is_compatible("renesas,emev2")) {
+		static_branch_enable(&needs_rmw_access);
+		return true;
+	}
+
+	return false;
+}
+
+static const struct gic_quirk gic_quirks[] = {
+	{
+		.desc		= "broken byte access",
+		.compatible	= "arm,pl390",
+		.init		= gic_enable_rmw_access,
+	},
+	{ },
+};
+
 static int gic_of_setup(struct gic_chip_data *gic, struct device_node *node)
 {
 	if (!gic || !node)
@@ -1391,6 +1439,8 @@ static int gic_of_setup(struct gic_chip_data *gic, struct device_node *node)
 	if (of_property_read_u32(node, "cpu-offset", &gic->percpu_offset))
 		gic->percpu_offset = 0;
 
+	gic_enable_of_quirks(node, gic_quirks, gic);
+
 	return 0;
 
 error:
