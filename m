Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0E63FEDFF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344714AbhIBMuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234254AbhIBMuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:50:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D7E061057;
        Thu,  2 Sep 2021 12:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630586954;
        bh=0GQl4VoiOkvJs4i1BDrRnWf88kBhXHT0+mS0tM2uYHY=;
        h=From:To:Cc:Subject:Date:From;
        b=O7ub/LHaVbnVE/g/0fUqftAkZ4e2JtyiAqhnNifnWeC5SGQ5EbNsMhfYTUyIFa9zF
         kNTMiooJCqNvl9fNlj+KhBs0twCQhx33JQVEO6r0ZtFA0AcD91s50L81Oh17gPyEtW
         mR2ZofBSSfgvmMNpmgG9yJkkAIR7Jv/XmM12prGSLMMpyrotgDvoCXPjwmENLIGxnD
         Ss2AVeD4VrsH3peT0rmzbaPhN+9zMquuB9uKsDyguV3Isq8d0oulngxVHo0P2ZFfRb
         DkD3u4YOcaNvUUoyrGRENj6gaprEjzoa3iBMwBZKNr5GDrF/yOadbTmWEeZfUheagZ
         FVNGvT4cEH/kA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mLm9Y-000B2u-CK; Thu, 02 Sep 2021 14:49:12 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mfd: hi6421-spmi-pmic: cleanup drvdata
Date:   Thu,  2 Sep 2021 14:47:48 +0200
Message-Id: <1828cb783b1ebca0b98bf0b3077d8701adb228f7.1630586862.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are lots of fields at struct hi6421_spmi_pmic that aren't
used. In a matter of fact, only regmap is needed.

So, drop the struct as a hole, and set just the regmap as
the drvdata.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/mfd/hi6421-spmi-pmic.c           | 16 +++++----------
 drivers/misc/hi6421v600-irq.c            |  9 ++++-----
 drivers/regulator/hi6421v600-regulator.c | 10 +++++-----
 include/linux/mfd/hi6421-spmi-pmic.h     | 25 ------------------------
 4 files changed, 14 insertions(+), 46 deletions(-)
 delete mode 100644 include/linux/mfd/hi6421-spmi-pmic.h

diff --git a/drivers/mfd/hi6421-spmi-pmic.c b/drivers/mfd/hi6421-spmi-pmic.c
index 4f136826681b..c9c0c3d7011f 100644
--- a/drivers/mfd/hi6421-spmi-pmic.c
+++ b/drivers/mfd/hi6421-spmi-pmic.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/mfd/core.h>
-#include <linux/mfd/hi6421-spmi-pmic.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -30,19 +29,14 @@ static const struct regmap_config regmap_config = {
 static int hi6421_spmi_pmic_probe(struct spmi_device *sdev)
 {
 	struct device *dev = &sdev->dev;
+	struct regmap *regmap;
 	int ret;
-	struct hi6421_spmi_pmic *ddata;
-	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
-	if (!ddata)
-		return -ENOMEM;
 
-	ddata->regmap = devm_regmap_init_spmi_ext(sdev, &regmap_config);
-	if (IS_ERR(ddata->regmap))
-		return PTR_ERR(ddata->regmap);
+	regmap = devm_regmap_init_spmi_ext(sdev, &regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
-	ddata->dev = dev;
-
-	dev_set_drvdata(&sdev->dev, ddata);
+	dev_set_drvdata(&sdev->dev, regmap);
 
 	ret = devm_mfd_add_devices(&sdev->dev, PLATFORM_DEVID_NONE,
 				   hi6421v600_devs, ARRAY_SIZE(hi6421v600_devs),
diff --git a/drivers/misc/hi6421v600-irq.c b/drivers/misc/hi6421v600-irq.c
index 08535e97ff43..1c763796cf1f 100644
--- a/drivers/misc/hi6421v600-irq.c
+++ b/drivers/misc/hi6421v600-irq.c
@@ -10,7 +10,6 @@
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/mfd/hi6421-spmi-pmic.h>
 #include <linux/module.h>
 #include <linux/of_gpio.h>
 #include <linux/platform_device.h>
@@ -220,7 +219,7 @@ static int hi6421v600_irq_probe(struct platform_device *pdev)
 	struct platform_device *pmic_pdev;
 	struct device *dev = &pdev->dev;
 	struct hi6421v600_irq *priv;
-	struct hi6421_spmi_pmic *pmic;
+	struct regmap *regmap;
 	unsigned int virq;
 	int i, ret;
 
@@ -229,8 +228,8 @@ static int hi6421v600_irq_probe(struct platform_device *pdev)
 	 * which should first set drvdata. If this doesn't happen, hit
 	 * a warn on and return.
 	 */
-	pmic = dev_get_drvdata(pmic_dev);
-	if (WARN_ON(!pmic))
+	regmap = dev_get_drvdata(pmic_dev);
+	if (WARN_ON(!regmap))
 		return -ENODEV;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -238,7 +237,7 @@ static int hi6421v600_irq_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->dev = dev;
-	priv->regmap = pmic->regmap;
+	priv->regmap = regmap;
 
 	spin_lock_init(&priv->lock);
 
diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index 662d87ae61cb..4671678f6b19 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -9,8 +9,8 @@
 // Guodong Xu <guodong.xu@linaro.org>
 
 #include <linux/delay.h>
-#include <linux/mfd/hi6421-spmi-pmic.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
@@ -237,7 +237,7 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
 	struct hi6421_spmi_reg_priv *priv;
 	struct hi6421_spmi_reg_info *info;
 	struct device *dev = &pdev->dev;
-	struct hi6421_spmi_pmic *pmic;
+	struct regmap *regmap;
 	struct regulator_dev *rdev;
 	int i;
 
@@ -246,8 +246,8 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
 	 * which should first set drvdata. If this doesn't happen, hit
 	 * a warn on and return.
 	 */
-	pmic = dev_get_drvdata(pmic_dev);
-	if (WARN_ON(!pmic))
+	regmap = dev_get_drvdata(pmic_dev);
+	if (WARN_ON(!regmap))
 		return -ENODEV;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -261,7 +261,7 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
 
 		config.dev = pdev->dev.parent;
 		config.driver_data = priv;
-		config.regmap = pmic->regmap;
+		config.regmap = regmap;
 
 		rdev = devm_regulator_register(dev, &info->desc, &config);
 		if (IS_ERR(rdev)) {
diff --git a/include/linux/mfd/hi6421-spmi-pmic.h b/include/linux/mfd/hi6421-spmi-pmic.h
deleted file mode 100644
index e5b8dbf828b6..000000000000
--- a/include/linux/mfd/hi6421-spmi-pmic.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Header file for device driver Hi6421 PMIC
- *
- * Copyright (c) 2013 Linaro Ltd.
- * Copyright (C) 2011 Hisilicon.
- * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd
- *
- * Guodong Xu <guodong.xu@linaro.org>
- */
-
-#ifndef	__HISI_PMIC_H
-#define	__HISI_PMIC_H
-
-#include <linux/irqdomain.h>
-#include <linux/regmap.h>
-
-struct hi6421_spmi_pmic {
-	struct resource				*res;
-	struct device				*dev;
-	void __iomem				*regs;
-	struct regmap				*regmap;
-};
-
-#endif		/* __HISI_PMIC_H */
-- 
2.31.1

