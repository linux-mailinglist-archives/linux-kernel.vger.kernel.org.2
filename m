Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0406C3A436E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhFKN4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhFKN4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB44DC0613A2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:54:33 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:54:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=egBrv4KjdJWBLqoAqRV9/lAYkBr95p29vkHSUWO4H/4=;
        b=Ui1koosgZlQYd0gjg79Ycby3od7tnApRLK/FHayacutC0yAnHnnMi/iUipiumVWyRKL7JU
        ogB982TWh04NgMhgK6rRZ7uZG2ktJg+P0ZOCZNAZShgAgR6EqJ8BZh/5LLB6O7MmW3HUB6
        2beLg6B0CcPXRpkY2Ygyy0WqMC/Ljp9b5GdFV9pWjpQLVyGH/8Kn+PEsL8xitBZ8e+Af/r
        4arv4toClSlgpik4FUQxlTlQHxo8OT/6TAc2NCY0Mi9eDcqMpnlSTcNjaEVH0nLC+Dvzis
        XzA5j3G9dvwYXvoTvEiv6LK3ie2NI9X7kRk3+BMS9fNdDpyTk9KwTYTetwQfrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=egBrv4KjdJWBLqoAqRV9/lAYkBr95p29vkHSUWO4H/4=;
        b=jKUqjLySFVvF5C16NLQB5v44XJgOEIcYauLWnBGs5gi4HxSLreGdbjXDSN+c+BoJDXP8M1
        VnqU14f64D0r+XAw==
From:   "irqchip-bot for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/imgpdc: Remove unnecessary oom message
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210609140828.14584-1-thunder.leizhen@huawei.com>
References: <20210609140828.14584-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <162341967160.19906.4370580021015643612.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     e3f389ed3a421f45b46e774b543648ebcab9020a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e3f389ed3a421f45b46e774b543648ebcab9020a
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Wed, 09 Jun 2021 22:08:28 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Jun 2021 14:19:43 +01:00

irqchip/imgpdc: Remove unnecessary oom message

Fixes scripts/checkpatch.pl warning:
WARNING: Possible unnecessary 'out of memory' message

Remove it can help us save a bit of memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210609140828.14584-1-thunder.leizhen@huawei.com
---
 drivers/irqchip/irq-imgpdc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-imgpdc.c b/drivers/irqchip/irq-imgpdc.c
index 698d07f..04efa8e 100644
--- a/drivers/irqchip/irq-imgpdc.c
+++ b/drivers/irqchip/irq-imgpdc.c
@@ -316,10 +316,8 @@ static int pdc_intc_probe(struct platform_device *pdev)
 
 	/* Allocate driver data */
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(&pdev->dev, "cannot allocate device data\n");
+	if (!priv)
 		return -ENOMEM;
-	}
 	raw_spin_lock_init(&priv->lock);
 	platform_set_drvdata(pdev, priv);
 
@@ -356,10 +354,8 @@ static int pdc_intc_probe(struct platform_device *pdev)
 	/* Get peripheral IRQ numbers */
 	priv->perip_irqs = devm_kcalloc(&pdev->dev, 4, priv->nr_perips,
 					GFP_KERNEL);
-	if (!priv->perip_irqs) {
-		dev_err(&pdev->dev, "cannot allocate perip IRQ list\n");
+	if (!priv->perip_irqs)
 		return -ENOMEM;
-	}
 	for (i = 0; i < priv->nr_perips; ++i) {
 		irq = platform_get_irq(pdev, 1 + i);
 		if (irq < 0)
