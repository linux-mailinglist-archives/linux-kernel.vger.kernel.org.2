Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369E44352F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 20:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhJTStq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 14:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhJTSt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:49:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5829C061753
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 11:47:14 -0700 (PDT)
Date:   Wed, 20 Oct 2021 18:47:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634755633;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DUYfGtlTGOyaxMNt94YJ/NOZzOhR336ZOwCsF4CyhTQ=;
        b=eUw00SpPD4ejfJIUC2YERzUsSp/uY9t7p5ezrvAc0Mw+LE9z7BVhmCapGkTI2FtE1N70qH
        UtgGCKwRMPTx5Zhu9PjzYwj3GVim2YBehAWtXbJM8CbXz2GzIUYXhuT4v29aQT7Pf0+lCf
        UAwB1pfns00OksYILUKIa6KkDVYaEkus7YH1Op0OO/Q0srh5XxnvQRzMszk5XqAOwDLl5f
        yUNsWLFZ55mMpWu333+hkefDQLrQrC1b0JHlws3ZruHS5ARJkw/AphuFPT12dDucdjX5w4
        u9bTo4vdXKprsqn7mFMi0PO0MTgy2VYa++Dsi7+e2DB0avLgra5fPXRKjjmmHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634755633;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DUYfGtlTGOyaxMNt94YJ/NOZzOhR336ZOwCsF4CyhTQ=;
        b=WEr63YEc0TQNEcxBBd8OzypwdZnMsSkKXl8PktniquNh51Fm4PYfA13SCgw60cc6dVLfUD
        v89vB9kZDR5pp9AQ==
From:   "irqchip-bot for Cai Huoqing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/ti-sci-inta: Make use of the
 helper function devm_platform_ioremap_resource()
Cc:     Cai Huoqing <caihuoqing@baidu.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20210908105723.1831-1-caihuoqing@baidu.com>
References: <20210908105723.1831-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Message-ID: <163475563272.25758.17608061297485863064.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     10002f11a0a32681f516efd82df39c747938c23a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/10002f11a0a32681f516efd82df39c747938c23a
Author:        Cai Huoqing <caihuoqing@baidu.com>
AuthorDate:    Wed, 08 Sep 2021 18:57:22 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 19 Oct 2021 11:24:28 +01:00

irqchip/ti-sci-inta: Make use of the helper function devm_platform_ioremap_resource()

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210908105723.1831-1-caihuoqing@baidu.com
---
 drivers/irqchip/irq-ti-sci-inta.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index 97f454e..8eba08d 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -650,7 +650,6 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 	struct device_node *parent_node, *node;
 	struct ti_sci_inta_irq_domain *inta;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	int ret;
 
 	node = dev_of_node(dev);
@@ -694,8 +693,7 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 		return PTR_ERR(inta->global_event);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	inta->base = devm_ioremap_resource(dev, res);
+	inta->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(inta->base))
 		return PTR_ERR(inta->base);
 
