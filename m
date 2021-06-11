Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F8D3A436D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhFKN4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhFKN4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21952C0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:54:33 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:54:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Rdp/SnjI8cBWG61jOIjkomsUEWwuSY8HVbPTc6h7hY=;
        b=Jqzu/Op2R3GI21FZ8jmKh8HVe6nszby313NQ6+Y1JjTML3eFERnaHAG19PFLHfPa9b9cmj
        hbocoVSQQ+thizqMcTilgqZ9zb3ltAUOjXDmxk95/gT5FWlqyvKkwtH0caesHuKSTsoOiv
        AwNaPAuh23BLzxPgfDxesqV3GPFJd208iXvnXJ2w8wzkLwu5scbQjCxWSkqj0060spG9VX
        8mJIr0+vlels2vbrBhRYfvxU5BQrdYRQI59rgrRjGg0DCko4NOP/AcYLZC700iqcNMPpt1
        zVTDmgZ30BmWxAnKywTUd3Jd0dqJJMFOvH8moQlr4DePb5vI+q4DZAvqHzX9kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Rdp/SnjI8cBWG61jOIjkomsUEWwuSY8HVbPTc6h7hY=;
        b=h2oCxHEpjmDkLrELsOP0XN624j97F+CUrbyV7MDo6E9tHgM2shdmk7AlnfkibUR2Tww22b
        ipyMmkZpo+YA4ADA==
From:   "irqchip-bot for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/sun4i: Remove unnecessary oom message
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210609141428.14737-1-thunder.leizhen@huawei.com>
References: <20210609141428.14737-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <162341967047.19906.15413637705106849995.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     75768e391f8947ea8b2e7997af68dbd68814f00c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/75768e391f8947ea8b2e7997af68dbd68814f00c
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Wed, 09 Jun 2021 22:14:28 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Jun 2021 14:19:51 +01:00

irqchip/sun4i: Remove unnecessary oom message

Fixes scripts/checkpatch.pl warning:
WARNING: Possible unnecessary 'out of memory' message

Remove it can help us save a bit of memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210609141428.14737-1-thunder.leizhen@huawei.com
---
 drivers/irqchip/irq-sun4i.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index 9ea9445..8a315d6 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -147,10 +147,8 @@ static int __init sun4i_ic_of_init(struct device_node *node,
 				   struct device_node *parent)
 {
 	irq_ic_data = kzalloc(sizeof(struct sun4i_irq_chip_data), GFP_KERNEL);
-	if (!irq_ic_data) {
-		pr_err("kzalloc failed!\n");
+	if (!irq_ic_data)
 		return -ENOMEM;
-	}
 
 	irq_ic_data->enable_reg_offset = SUN4I_IRQ_ENABLE_REG_OFFSET;
 	irq_ic_data->mask_reg_offset = SUN4I_IRQ_MASK_REG_OFFSET;
@@ -164,10 +162,8 @@ static int __init suniv_ic_of_init(struct device_node *node,
 				   struct device_node *parent)
 {
 	irq_ic_data = kzalloc(sizeof(struct sun4i_irq_chip_data), GFP_KERNEL);
-	if (!irq_ic_data) {
-		pr_err("kzalloc failed!\n");
+	if (!irq_ic_data)
 		return -ENOMEM;
-	}
 
 	irq_ic_data->enable_reg_offset = SUNIV_IRQ_ENABLE_REG_OFFSET;
 	irq_ic_data->mask_reg_offset = SUNIV_IRQ_MASK_REG_OFFSET;
