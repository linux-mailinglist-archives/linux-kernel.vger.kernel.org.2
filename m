Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D6438DB41
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 15:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhEWNgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 09:36:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35618 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhEWNgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 09:36:00 -0400
Date:   Sun, 23 May 2021 13:33:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621776873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ec4GN0iTIjeHM84szuj+Gg+efZ+RFr2aA2qOiDbGVU4=;
        b=G5i2ScM74S3Wsr0HNAhXjDmvCxbMpHrlCDgh/+tfpSxxfzjBpfIrgt6decK4tMoJ0dLp5r
        2fhnvGPCjkHeKw8iDoxe2AdIr93xJExQYSdHZW4B5loHy8auF3UNVRDkDXJ6Qo18iQOjRQ
        KjyGgL2LRZUzaB4P5cO+fXwzVo+dIOrxazful6koEJJfDrldEnDZM1ByPrxmxWSpHND0zi
        O3cRyKH9duq0ZJG2TSBgwmAnXX9B70IUM5Un4UfGPoXePsNkeTi77Mn71grJszTZgWWcfN
        LWLWcQ00r6jG8dh4152xxRHMeMTVyz0+fRcGOaKPjmjWRm9YT63lDukYAmZ1YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621776873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ec4GN0iTIjeHM84szuj+Gg+efZ+RFr2aA2qOiDbGVU4=;
        b=TbIAHepZZHgdTPOpz5WrRFK7lOGBQhxnPPq9mRyWTaGRskptIjhwyLHOK36pM1azACDfjq
        Yh1klOsOPCqFA1DQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v5.13-rc3
Message-ID: <162177682324.10917.7221704858691713254.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-05-23

up to:  b4764905ea5b: Merge tag 'irqchip-fixes-5.13-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

A few fixes for irqchip drivers:

 - Allocate interrupt descriptors correctly on Mainstone PXA when
   SPARSE_IRQ is enabled; otherwise the interrupt association fails.

 - Make the APPLE AIC chip driver depend on APPLE.

 - Remove redundant error output on devm_ioremap_resource() failure.

Thanks,

	tglx

------------------>
Geert Uytterhoeven (1):
      irqchip/apple-aic: APPLE_AIC should depend on ARCH_APPLE

Marc Zyngier (1):
      ARM: PXA: Fix cplds irqdesc allocation when using legacy mode

Zhen Lei (1):
      irqchip: Remove redundant error printing


 arch/arm/mach-pxa/pxa_cplds_irqs.c | 7 ++++++-
 drivers/irqchip/Kconfig            | 2 +-
 drivers/irqchip/irq-mvebu-icu.c    | 4 +---
 drivers/irqchip/irq-mvebu-sei.c    | 4 +---
 drivers/irqchip/irq-stm32-exti.c   | 4 +---
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa_cplds_irqs.c b/arch/arm/mach-pxa/pxa_cplds_irqs.c
index ec0d9b094744..bddfc7cd5d40 100644
--- a/arch/arm/mach-pxa/pxa_cplds_irqs.c
+++ b/arch/arm/mach-pxa/pxa_cplds_irqs.c
@@ -121,8 +121,13 @@ static int cplds_probe(struct platform_device *pdev)
 		return fpga->irq;
 
 	base_irq = platform_get_irq(pdev, 1);
-	if (base_irq < 0)
+	if (base_irq < 0) {
 		base_irq = 0;
+	} else {
+		ret = devm_irq_alloc_descs(&pdev->dev, base_irq, base_irq, CPLDS_NB_IRQ, 0);
+		if (ret < 0)
+			return ret;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	fpga->base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b90e825df7e1..62543a4eccc0 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -596,7 +596,7 @@ config IRQ_IDT3243X
 config APPLE_AIC
 	bool "Apple Interrupt Controller (AIC)"
 	depends on ARM64
-	default ARCH_APPLE
+	depends on ARCH_APPLE || COMPILE_TEST
 	help
 	  Support for the Apple Interrupt Controller found on Apple Silicon SoCs,
 	  such as the M1.
diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 91adf771f185..090bc3f4f7d8 100644
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
index 18832ccc8ff8..3a7b7a7f20ca 100644
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
index b9db90c4aa56..4704f2ee5797 100644
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

