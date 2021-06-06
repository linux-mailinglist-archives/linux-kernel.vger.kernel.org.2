Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6AE39CF1D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhFFMqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhFFMpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D97CC061789
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:43:51 -0700 (PDT)
Date:   Sun, 06 Jun 2021 12:43:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983429;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3m2eiNVCkZiHYRYPiquBhWUWpDph4U5isohtFd04RSI=;
        b=16kTRstxOw28UhWPhaZ2cBJg+19FG1xd5TQeaLGdG0EnO2HzBJoyDcYS1k1wusAgCPzxBW
        bpUI1hkC4vfe/6OfYZ+CH3p5sQc8Xs13uNJzq4TQAq4s+m0c2jfTQMYZ7NW2Rd5DT5v1U6
        Nhk37caBCv9D9eZMIPMTum1rcMkr6fDSnVKv8VAuWvryxYoB4/rnU/8rLKxtabdJ9ObGeP
        yOdw72JoTiwqqJRt5k7iRT8rWcyUHc6ZrOK7+oRDh88JcpmYoDnMVLm6Kord5xs3nABAXI
        2WOl1iLGSKbN6nW5JJ+Zzblg6KHzWkQmQDVpJhFqn+284qoAoRMib98nbL5nnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983429;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3m2eiNVCkZiHYRYPiquBhWUWpDph4U5isohtFd04RSI=;
        b=TNCpOsAds4oKzfh6ko05B1dBTUAGYD5OTOduqcax6tDYNvMUN+24sw2EWmssnZJ9XVSJzj
        a39vd8HfvEEqoyAQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Use struct_size() helper when
 allocating irqdomain
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298342904.29796.802523073833281893.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     4242255a08578a7b1ac55df9f223d3b23af7d573
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4242255a08578a7b1ac55df9f223d3b23af7d573
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 05 Apr 2021 11:30:51 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 14:34:49 +01:00

irqdomain: Use struct_size() helper when allocating irqdomain

Instead of open-coding the size computation of struct irqdomain,
use the struct_size() helper instead.

This is going to be handy as we change the type of the revmap
array.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index fa94c86..cdcb198 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -150,7 +150,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && direct_max)))
 		return NULL;
 
-	domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
+	domain = kzalloc_node(struct_size(domain, revmap, size),
 			      GFP_KERNEL, of_node_to_nid(to_of_node(fwnode)));
 	if (!domain)
 		return NULL;
