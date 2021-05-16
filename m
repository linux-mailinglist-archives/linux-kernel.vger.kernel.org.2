Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F90381E95
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 14:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhEPMKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 08:10:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46854 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhEPMKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 08:10:30 -0400
Date:   Sun, 16 May 2021 12:09:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621166954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UFKlAanYAnkFeFviPAtz3YLoGT9GoP2a0NlE2ZJSGrs=;
        b=PvmRPMceNkrlq4XEc7skKi6Lqa5bkt2WosD1sL5TIEOalW+rTinDUhNMOWkWH7gAShBkzH
        PYH7UomCIfU/po001uWOn2tSYLsMYuEb2sMKyeVrDDS91cBteZLunbl7Gyz1gJS7ym6dNi
        nlxUPeQSDbxdVAE3brkYyY+lC1SRfBerwuQzuKhTNUm7A+q4pypex17wpf/kVbKTIwF6bn
        Bjo/K1nyFvQ4p+Y/QUW+rO5gaUVIrjM5WcwEW7BHJ00tDpJIqVs7JuBP44ne6FYl8KyJV3
        tFIkimJbDGEaWz+YCmf6i2s5DtZewdd+2j8l9ntiArjjUzzrTiVHPme20zb2/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621166954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UFKlAanYAnkFeFviPAtz3YLoGT9GoP2a0NlE2ZJSGrs=;
        b=L6hdSBGS4XojiVZMhvOLHlVv0cNk5KcNUjmvHxVJn92j+euy+7diYRYvbMZ5II+RTuYa2a
        rGpln8p0Z+fuQWBA==
From:   "irqchip-bot for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip: Remove redundant error printing
Cc:     Hulk Robot <hulkci@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210511125428.6108-2-thunder.leizhen@huawei.com>
References: <20210511125428.6108-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <162116695353.29796.16028086913995368034.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     fbb80d5ad400a12ec67214a0e7e9f9497dc9e615
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/fbb80d5ad400a12ec67214a0e7e9f9497dc9e615
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Tue, 11 May 2021 20:54:28 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 16 May 2021 13:07:18 +01:00

irqchip: Remove redundant error printing

When devm_ioremap_resource() fails, a clear enough error message will be
printed by its subfunction __devm_ioremap_resource(). The error
information contains the device name, failure cause, and possibly resource
information.

Therefore, remove the error printing here to simplify code and reduce the
binary size.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210511125428.6108-2-thunder.leizhen@huawei.com
---
 drivers/irqchip/irq-mvebu-icu.c  | 4 +---
 drivers/irqchip/irq-mvebu-sei.c  | 4 +---
 drivers/irqchip/irq-stm32-exti.c | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 91adf77..090bc3f 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -359,10 +359,8 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	icu->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(icu->base)) {
-		dev_err(&pdev->dev, "Failed to map icu base address.\n");
+	if (IS_ERR(icu->base))
 		return PTR_ERR(icu->base);
-	}
 
 	/*
 	 * Legacy bindings: ICU is one node with one MSI parent: force manually
diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index 18832cc..3a7b7a7 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -384,10 +384,8 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 
 	sei->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sei->base = devm_ioremap_resource(sei->dev, sei->res);
-	if (IS_ERR(sei->base)) {
-		dev_err(sei->dev, "Failed to remap SEI resource\n");
+	if (IS_ERR(sei->base))
 		return PTR_ERR(sei->base);
-	}
 
 	/* Retrieve the SEI capabilities with the interrupt ranges */
 	sei->caps = of_device_get_match_data(&pdev->dev);
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index b9db90c..4704f2e 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -892,10 +892,8 @@ static int stm32_exti_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host_data->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(host_data->base)) {
-		dev_err(dev, "Unable to map registers\n");
+	if (IS_ERR(host_data->base))
 		return PTR_ERR(host_data->base);
-	}
 
 	for (i = 0; i < drv_data->bank_nr; i++)
 		stm32_exti_chip_init(host_data, i, np);
