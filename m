Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C40339CF17
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhFFMp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhFFMpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739FCC061767
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:43:50 -0700 (PDT)
Date:   Sun, 06 Jun 2021 12:43:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983428;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qxI8MCb34Ufq6Qmnty9HjU68MaIfg3sJLbhCTLNROCc=;
        b=MgHMZCXvG23Q9UGnlczra+VH06rQuhnbVvtsy5/ZhBffegArctTMZvy9v0ULJZPPuLq77Z
        k27voN3e0TnY6SDht8rOZZiME3eTaHUdpZ1WV+PECj/Wg8SHDLXJMpnTQOZjEXQSPrK8JH
        vbxy9uXyalPx1Cg3kiRkAZJyShgcjKFYGd3zbLBK9ZybJE71iJmceszaeseuqIt7vYtKHP
        f/M55GXsYmX5AWjGV5kV5OWiQJC5GCfpagA1QHG3IOMmpmCQ2iEQib4yzC8l01Vc4t3+Br
        7PbWvwE1/hvs7cu32v8yBlacP2RAaotPoJDxuoWVsTn7kTqTuKvtsjuyFTUKxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983428;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qxI8MCb34Ufq6Qmnty9HjU68MaIfg3sJLbhCTLNROCc=;
        b=PU4Ca97h1ZczejC069eUkJL4kfhYCk/TiNauXUxz8HGHAr4x9rW2kg6UkaYyi/ey2QVswQ
        uGe+jRNk2ORRPbAA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Implement
 irq_domain_clear_mapping() with irq_domain_set_mapping()
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298342811.29796.3416072939038894683.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     ee1a2bc868c73578ae8bbe1107e62af078510c47
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/ee1a2bc868c73578ae8bbe1107e62af078510c47
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 05 Apr 2021 12:56:12 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 14:34:49 +01:00

irqdomain: Implement irq_domain_clear_mapping() with irq_domain_set_mapping()

Now that we only deal with irq_data pointers, it is pretty obvious
that irq_domain_clear_mapping() and irq_domain_set_mapping() are
almost the exact same thing.

Implement one it terms of the other.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 kernel/irq/irqdomain.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 7a4e388..ed2ffff 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -498,21 +498,6 @@ static bool irq_domain_is_nomap(struct irq_domain *domain)
 	       (domain->flags & IRQ_DOMAIN_FLAG_NO_MAP);
 }
 
-static void irq_domain_clear_mapping(struct irq_domain *domain,
-				     irq_hw_number_t hwirq)
-{
-	if (irq_domain_is_nomap(domain))
-		return;
-
-	if (hwirq < domain->revmap_size) {
-		domain->revmap[hwirq] = NULL;
-	} else {
-		mutex_lock(&domain->revmap_tree_mutex);
-		radix_tree_delete(&domain->revmap_tree, hwirq);
-		mutex_unlock(&domain->revmap_tree_mutex);
-	}
-}
-
 static void irq_domain_set_mapping(struct irq_domain *domain,
 				   irq_hw_number_t hwirq,
 				   struct irq_data *irq_data)
@@ -529,6 +514,12 @@ static void irq_domain_set_mapping(struct irq_domain *domain,
 	}
 }
 
+static void irq_domain_clear_mapping(struct irq_domain *domain,
+				     irq_hw_number_t hwirq)
+{
+	irq_domain_set_mapping(domain, hwirq, NULL);
+}
+
 static void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
 {
 	struct irq_data *irq_data = irq_get_irq_data(irq);
