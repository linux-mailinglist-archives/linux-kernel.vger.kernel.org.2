Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAE544763A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 23:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbhKGWSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 17:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbhKGWSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 17:18:01 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3C7C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 14:15:18 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id bq14so13975020qkb.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 14:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=X5oMc4U0HqNOuSEIIO5YmO/jyPSOHRF2iW9CUgKZimc=;
        b=cJl1k5Lx2mdb4RhFh4XhY2EYQrwgCalRCKb5Xp3GzaypCwK7xkGacjC8WF8oRepnBm
         j3W0EQpQ98nLBMNYTgwngJL8If7g8DyhRmhU1P+0sL09ssI/dqgyZTcxDRvUv6OvIpCX
         5JeU7rvP3MFuvsUodrtfNSnYo1FaJ/e/CgrlLDZxZS7u6TOI/Mlb5FecP+AKtW9siUYx
         yl4ZpFcYgQO31HLskCs4UXWdEb712WLhNXd0JEBRqVBezVglCvo2nkiIc/FlO5lKer83
         qdMXzEDg28y4Z1RZ+XYPtbAHfMZsajld/fJYNgeKnZMv44oA266UjgnEycz8+feb8I23
         OLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=X5oMc4U0HqNOuSEIIO5YmO/jyPSOHRF2iW9CUgKZimc=;
        b=apsn5pbLLHGmdH7grshl+zj21SHfUJaXx5Py1mroyUOWF/qze6ZkwjR4gmh6J5JNNk
         xr9Ab6sJNkaE8giIlGgWyOihokPzIlgCYpX2DsqcC9sshHfB5tUUIPJ9XPyCpasIL9mA
         j/2kZVKWCfpFVxEuPVfa0T9OPEmz142hFTPEmLSj1mg6X4E2wpn9dNQW8r091PUx1LB2
         2PgIbHK6tjCfEPIZaVtdl4pOlO7vg6R0RulaVNfWeSigoRCDfjUJlcwWIHykt/vuxH28
         9z936Yeq8/nIyxuEeFFS2JvoyW7czdnHwoGurjWIwGsKtZsZZAjPygBExnI/k1U9/tfX
         V2jg==
X-Gm-Message-State: AOAM531bsd1aULGttc+s5qYgPZLZcoFe66NDzvByCRak+8NJA6/bAKTR
        +OJryMhXLcmu/aC6FBEiIzYDQRoQm61Y5Q==
X-Google-Smtp-Source: ABdhPJw3H3Es0vUHgOslNfSb+Z5NM97cqU/KXHGLZXuaWzdSe+expJZ7ASWnM7x/0D2HC+6IRVvh2g==
X-Received: by 2002:a37:e206:: with SMTP id g6mr2540086qki.61.1636323317207;
        Sun, 07 Nov 2021 14:15:17 -0800 (PST)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id o5sm8648913qkl.50.2021.11.07.14.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 14:15:16 -0800 (PST)
Date:   Sun, 7 Nov 2021 19:15:13 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: hi655x-pmic: Replace legacy gpio interface for gpiod
 interface
Message-ID: <YYhP8aWRHgUymgA9@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Considering the current transition of the GPIO subsystem, remove all
dependencies of the legacy GPIO interface (linux/gpio.h and linux
/of_gpio.h) and replace it with the descriptor-based GPIO approach.

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/mfd/hi655x-pmic.c       | 27 ++++++++-------------------
 include/linux/mfd/hi655x-pmic.h |  4 +++-
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
index 6909d075d017..a58e42ddcd0c 100644
--- a/drivers/mfd/hi655x-pmic.c
+++ b/drivers/mfd/hi655x-pmic.c
@@ -9,14 +9,13 @@
  * Fei  Wang <w.f@huawei.com>
  */
 
-#include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/hi655x-pmic.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -94,7 +93,6 @@ static int hi655x_pmic_probe(struct platform_device *pdev)
 	int ret;
 	struct hi655x_pmic *pmic;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	void __iomem *base;
 
 	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
@@ -120,21 +118,12 @@ static int hi655x_pmic_probe(struct platform_device *pdev)
 
 	hi655x_local_irq_clear(pmic->regmap);
 
-	pmic->gpio = of_get_named_gpio(np, "pmic-gpios", 0);
-	if (!gpio_is_valid(pmic->gpio)) {
-		dev_err(dev, "Failed to get the pmic-gpios\n");
-		return -ENODEV;
-	}
-
-	ret = devm_gpio_request_one(dev, pmic->gpio, GPIOF_IN,
-				    "hi655x_pmic_irq");
-	if (ret < 0) {
-		dev_err(dev, "Failed to request gpio %d  ret = %d\n",
-			pmic->gpio, ret);
-		return ret;
-	}
+	pmic->gpio = devm_gpiod_get_optional(dev, "pmic", GPIOD_IN);
+	if (IS_ERR(pmic->gpio))
+		return dev_err_probe(dev, PTR_ERR(pmic->gpio),
+				"Failed to request hi655x pmic-gpio");
 
-	ret = regmap_add_irq_chip(pmic->regmap, gpio_to_irq(pmic->gpio),
+	ret = regmap_add_irq_chip(pmic->regmap, gpiod_to_irq(pmic->gpio),
 				  IRQF_TRIGGER_LOW | IRQF_NO_SUSPEND, 0,
 				  &hi655x_irq_chip, &pmic->irq_data);
 	if (ret) {
@@ -149,7 +138,7 @@ static int hi655x_pmic_probe(struct platform_device *pdev)
 			      regmap_irq_get_domain(pmic->irq_data));
 	if (ret) {
 		dev_err(dev, "Failed to register device %d\n", ret);
-		regmap_del_irq_chip(gpio_to_irq(pmic->gpio), pmic->irq_data);
+		regmap_del_irq_chip(gpiod_to_irq(pmic->gpio), pmic->irq_data);
 		return ret;
 	}
 
@@ -160,7 +149,7 @@ static int hi655x_pmic_remove(struct platform_device *pdev)
 {
 	struct hi655x_pmic *pmic = platform_get_drvdata(pdev);
 
-	regmap_del_irq_chip(gpio_to_irq(pmic->gpio), pmic->irq_data);
+	regmap_del_irq_chip(gpiod_to_irq(pmic->gpio), pmic->irq_data);
 	mfd_remove_devices(&pdev->dev);
 	return 0;
 }
diff --git a/include/linux/mfd/hi655x-pmic.h b/include/linux/mfd/hi655x-pmic.h
index af5d97239c0d..6a012784dd1b 100644
--- a/include/linux/mfd/hi655x-pmic.h
+++ b/include/linux/mfd/hi655x-pmic.h
@@ -12,6 +12,8 @@
 #ifndef __HI655X_PMIC_H
 #define __HI655X_PMIC_H
 
+#include <linux/gpio/consumer.h>
+
 /* Hi655x registers are mapped to memory bus in 4 bytes stride */
 #define HI655X_STRIDE                   4
 #define HI655X_BUS_ADDR(x)              ((x) << 2)
@@ -53,7 +55,7 @@ struct hi655x_pmic {
 	struct resource *res;
 	struct device *dev;
 	struct regmap *regmap;
-	int gpio;
+	struct gpio_desc *gpio;
 	unsigned int ver;
 	struct regmap_irq_chip_data *irq_data;
 };
-- 
2.31.1

