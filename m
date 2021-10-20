Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BA04352F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 20:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhJTSto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 14:49:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54636 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhJTSta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:49:30 -0400
Date:   Wed, 20 Oct 2021 18:47:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634755635;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+PwM5jodu23n7ePPQzUdNvb7957Stx5i5eTltdjZAU=;
        b=tJexK1i7o/0PkTW8AsJrVROwq4QLgUL+8HPzyYyrQ17wfgMHjpA58Vr0dcvblJBn9CBVF6
        ctgoFcxofCHCKvgHto4gN2aYESc6GeOVIEYfwG12AueGM9u4Z1/ab2lHEhKiLRWegqnyMr
        NsTOmaVTCqVn+beXWNMq/8v81NdUGr31k0uGytkV1mj9UDzejuEG+uNgczlaOQCYyz3R0g
        DMOJBRqa2Lj9ZalqoGxWIqyC3rd3T5wvb2CZ3kmdLKd50m1w+yxT/6Al+zT1Mr5ETAsF7X
        WqwDLXjsglqnPxuxddBdCkirv+62+VUVze3TF84adiBDsez0YAQ/1gFhcUFc1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634755635;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+PwM5jodu23n7ePPQzUdNvb7957Stx5i5eTltdjZAU=;
        b=tVHA7BUh3p82LB189tLdFmx4YtLluKdPcX8sCmIHKiJbr5GCOmFxEEMKRh72XGFFTsrwj2
        h9DuXQL/LJtUN7AA==
From:   "irqchip-bot for Cai Huoqing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-ts4800: Make use of the
 helper function devm_platform_ioremap_resource()
Cc:     Cai Huoqing <caihuoqing@baidu.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20210908105708.1729-1-caihuoqing@baidu.com>
References: <20210908105708.1729-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Message-ID: <163475563405.25758.9973716221865327375.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     2687bf8d0d34e70a986e0303702deac491689a38
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/2687bf8d0d34e70a986e0303702deac491689a38
Author:        Cai Huoqing <caihuoqing@baidu.com>
AuthorDate:    Wed, 08 Sep 2021 18:57:07 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 19 Oct 2021 11:23:44 +01:00

irqchip/irq-ts4800: Make use of the helper function devm_platform_ioremap_resource()

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210908105708.1729-1-caihuoqing@baidu.com
---
 drivers/irqchip/irq-ts4800.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index 34337a6..f032db2 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -93,15 +93,13 @@ static int ts4800_ic_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct ts4800_irq_data *data;
 	struct irq_chip *irq_chip;
-	struct resource *res;
 	int parent_irq;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->base = devm_ioremap_resource(&pdev->dev, res);
+	data->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
 
