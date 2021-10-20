Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B0D4352F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 20:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhJTStx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 14:49:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54636 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhJTStb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:49:31 -0400
Date:   Wed, 20 Oct 2021 18:47:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634755636;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dclZaAXFJJ9XqiYF9swNaJb9Rn5CR+3cLGoGFADflzU=;
        b=aKVZVYgQvecs0hHZh0TmMhaxpok/CDt/kDh0s8Mv55NGvIgl4dZ9R/OPZNlmSri9KJKW6v
        bu2h2aLN+2xiSQmhNFpCFAWbiPKKGeCoC07uwF7FHg12qU0M9JhNy4F+2oHbNLjgO1jbVe
        XJ/6767HNjC0rNb6u0WHdh7yq29HZ/8aVf3Yn/otTgUGqoRwTjsCIAFRNJBoKTswA8L0cs
        zXCUcnY9An1qtqL0MLdEl1aygeK6jQSbjfaiWoUqNySX2MDv8n8JASDMh7Nqd12fs/2V3b
        JyVsBNA4nYCXGgyT+qVif/s6qdVJ8vu2XzLIqqKdTgweXrWXwAFqoa52vygyRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634755636;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dclZaAXFJJ9XqiYF9swNaJb9Rn5CR+3cLGoGFADflzU=;
        b=wvM4ULYPr2syfnUuDWRCKjGe9gCE3POL2m7blfhM0e/SOD0I8tTbWWjouNvblYG4xzWfUH
        V3X1I3K3xE1v2LAg==
From:   "irqchip-bot for Cai Huoqing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-mvebu-icu: Make use of the
 helper function devm_platform_ioremap_resource()
Cc:     Cai Huoqing <caihuoqing@baidu.com>, Andrew Lunn <andrew@lunn.ch>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210908105653.1627-1-caihuoqing@baidu.com>
References: <20210908105653.1627-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Message-ID: <163475563540.25758.2588530833263075881.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     0c1479a66359c6955cd973c9e225d7ee5d6c71aa
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/0c1479a66359c6955cd973c9e225d7ee5d6c71aa
Author:        Cai Huoqing <caihuoqing@baidu.com>
AuthorDate:    Wed, 08 Sep 2021 18:56:52 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 19 Oct 2021 11:22:34 +01:00

irqchip/irq-mvebu-icu: Make use of the helper function devm_platform_ioremap_resource()

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210908105653.1627-1-caihuoqing@baidu.com
---
 drivers/irqchip/irq-mvebu-icu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 090bc3f..3e7297f 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -347,7 +347,6 @@ builtin_platform_driver(mvebu_icu_subset_driver);
 static int mvebu_icu_probe(struct platform_device *pdev)
 {
 	struct mvebu_icu *icu;
-	struct resource *res;
 	int i;
 
 	icu = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_icu),
@@ -357,8 +356,7 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 
 	icu->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	icu->base = devm_ioremap_resource(&pdev->dev, res);
+	icu->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(icu->base))
 		return PTR_ERR(icu->base);
 
