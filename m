Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3F13CC253
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 11:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbhGQKBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 06:01:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232615AbhGQKBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 06:01:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFB77613D8;
        Sat, 17 Jul 2021 09:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626515903;
        bh=ggWHEfwiHJDOlJiGKW+44qBgTcyC/lKuf5H/8KiIw0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AnSMYgxTVQHsTF7eSbXeXKeb7asL8AB9F4vJmsFxZaCvDUkv5b+unTw9RCzpxz7S4
         JlqQuzJCnNc2YpHobJoK5HQXITQKvsBBHtkIa97HzJ4NQAvVXXaEhTvMbfpTzJiFAV
         k2LEf5v3UNLU6k0Num7FqdkcQk1VxzTzDOVURi/UAwCjDpaF6QMgSXao6HkIxyunb6
         Yqm76zZJGgrNoxBuVbF8XLTFHz5Jef8JOibw60zjCOZGpEF3WMVVRkIQxavxXIxabj
         PsSqx8CLsuOjFI9qjpEPF5Uo2wR+rg+m4M+Cdf6cgoWXmNr+9er60Oi/fLVUirImS9
         DRmiiwwlRpvZA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m4h5R-0007K3-R5; Sat, 17 Jul 2021 11:58:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Rob Herring <robh@kernel.org>
Subject: [PATCH v14 2/9] staging: hi6421-spmi-pmic: rename GPIO IRQ OF node
Date:   Sat, 17 Jul 2021 11:58:13 +0200
Message-Id: <8b2cad1e9b9904c6a2aaea8786d5e5a39f09ac19.1626515862.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626515862.git.mchehab+huawei@kernel.org>
References: <cover.1626515862.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using the standard name ("gpios"), use "interrupts".

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c    | 18 ++++++------------
 .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml   |  8 +++-----
 include/linux/mfd/hi6421-spmi-pmic.h           |  1 -
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index dd7ff63214d3..61cbd2e62f68 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -218,6 +218,7 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *sdev)
 	struct device *dev = &sdev->dev;
 	struct device_node *np = dev->of_node;
 	struct hi6421_spmi_pmic *ddata;
+	struct platform_device *pdev;
 	unsigned int virq;
 	int ret, i;
 
@@ -233,21 +234,14 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *sdev)
 
 	ddata->dev = dev;
 
-	ddata->gpio = of_get_gpio(np, 0);
-	if (ddata->gpio < 0)
-		return ddata->gpio;
+	pdev = container_of(dev, struct platform_device, dev);
 
-	if (!gpio_is_valid(ddata->gpio))
-		return -EINVAL;
-
-	ret = devm_gpio_request_one(dev, ddata->gpio, GPIOF_IN, "pmic");
-	if (ret < 0) {
-		dev_err(dev, "Failed to request gpio%d\n", ddata->gpio);
-		return ret;
+	ddata->irq = platform_get_irq(pdev, 0);
+	if (ddata->irq < 0) {
+		dev_err(dev, "Error %d when getting IRQs\n", ddata->irq);
+		return ddata->irq;
 	}
 
-	ddata->irq = gpio_to_irq(ddata->gpio);
-
 	hi6421_spmi_pmic_irq_init(ddata);
 
 	ddata->irqs = devm_kzalloc(dev, PMIC_IRQ_LIST_MAX * sizeof(int), GFP_KERNEL);
diff --git a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
index 8e355cddd437..5a3b1cbfd639 100644
--- a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
+++ b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
@@ -34,9 +34,7 @@ properties:
 
   interrupt-controller: true
 
-  gpios:
-    maxItems: 1
-    description: GPIO used for IRQs
+  interrupts: true
 
   regulators:
     type: object
@@ -63,7 +61,6 @@ additionalProperties: false
 
 examples:
   - |
-    /* pmic properties */
 
     pmic: pmic@0 {
       compatible = "hisilicon,hi6421-spmi";
@@ -71,7 +68,8 @@ examples:
 
       #interrupt-cells = <2>;
       interrupt-controller;
-      gpios = <&gpio28 0 0>;
+      interrupt-parent = <&gpio28>;
+      interrupts = <0 0>;
 
       regulators {
         #address-cells = <1>;
diff --git a/include/linux/mfd/hi6421-spmi-pmic.h b/include/linux/mfd/hi6421-spmi-pmic.h
index 2660226138b8..254430c897d6 100644
--- a/include/linux/mfd/hi6421-spmi-pmic.h
+++ b/include/linux/mfd/hi6421-spmi-pmic.h
@@ -22,7 +22,6 @@ struct hi6421_spmi_pmic {
 	spinlock_t				lock;
 	struct irq_domain			*domain;
 	int					irq;
-	int					gpio;
 	unsigned int				*irqs;
 	struct regmap				*regmap;
 };
-- 
2.31.1

