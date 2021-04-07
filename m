Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06777356C49
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352290AbhDGMjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:39:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36386 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352238AbhDGMiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:38:25 -0400
Date:   Wed, 07 Apr 2021 12:38:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617799095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=udWhPPfvibfma8+xRCV0yb9foSchk4JDylNnf5hpS5Q=;
        b=w2qMLIUSljx5kQAb9I9gHswm2yRq2p9cGMH5xl0xXmdhJvaH2wijl6qXa4T8OcyJa0scS0
        8HJCaWEEOOi8ebtKeyy4U3Z7HTEQOBJlc++ooZFirlYEZJNNGiV8K5cb+KkPICuJhHnglI
        9Odpsqdmq06/cjuk1WGUioDhVtXiLcCooC5RBUzWuENANjeK4SJWaTD5Q1698LIchXlf+9
        YKTTNFu722DqbFsuy+FOd71/KcfqUoVXJRbM9SyHFJivB/EPjBxjXHrpVQZqO0/yCDIWEb
        3xi2487P3RWXd+vSHzkNqZFmxsj6Zv0Ui3RR6LEA+dkYp+8Aoy15egStjuA6Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617799095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=udWhPPfvibfma8+xRCV0yb9foSchk4JDylNnf5hpS5Q=;
        b=1a/rybJU10k6kVWPxjHZR+DA3BvXS0I/Ov3dSguZYZy4eK8vO2BQJlu09l4vFz3lFBq+k7
        RoOVhDpnMGDCwxDw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] mips: netlogic: Use irq_domain_simple_ops
 for XLP PIC
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <161779909486.29796.7693781970787370824.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     bd781ae53fac31acea9dec594d62a1424952dd4c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/bd781ae53fac31acea9dec594d62a1424952dd4c
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 02 Apr 2021 18:09:49 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 07 Apr 2021 13:25:52 +01:00

mips: netlogic: Use irq_domain_simple_ops for XLP PIC

Use the generic irq_domain_simple_ops structure instead of
a home-grown one.

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/mips/netlogic/common/irq.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
index cf33dd8..c25a2ce 100644
--- a/arch/mips/netlogic/common/irq.c
+++ b/arch/mips/netlogic/common/irq.c
@@ -276,10 +276,6 @@ asmlinkage void plat_irq_dispatch(void)
 }
 
 #ifdef CONFIG_CPU_XLP
-static const struct irq_domain_ops xlp_pic_irq_domain_ops = {
-	.xlate = irq_domain_xlate_onetwocell,
-};
-
 static int __init xlp_of_pic_init(struct device_node *node,
 					struct device_node *parent)
 {
@@ -324,7 +320,7 @@ static int __init xlp_of_pic_init(struct device_node *node,
 
 	xlp_pic_domain = irq_domain_add_legacy(node, n_picirqs,
 		nlm_irq_to_xirq(socid, PIC_IRQ_BASE), PIC_IRQ_BASE,
-		&xlp_pic_irq_domain_ops, NULL);
+		&irq_domain_simple_ops, NULL);
 	if (xlp_pic_domain == NULL) {
 		pr_err("PIC %pOFn: Creating legacy domain failed!\n", node);
 		return -EINVAL;
