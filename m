Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6981E3CC259
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 11:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhGQKCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 06:02:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233004AbhGQKBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 06:01:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD05B613EB;
        Sat, 17 Jul 2021 09:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626515903;
        bh=hEDyKMft1tTRZgm72hCGwNbegTN44LPfnvf2ahJ5RTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lclozRcOCaOHpAawMoM5N3jMMQ37qh8FXIChJ8EwLXUTt+n1Z0pkbfXJ4IhmqdK7y
         V5WMlIc8RvmYTclOkc6vIq5LYyAi14et391LtPQMC2072Qx+orkMIQz6TEDI5Oflky
         K0V9Ig0IX1K4P/PgVz6YxS6RTzqxXoyCyhVw/+ywikTA1R/9+JWTyNCNjro2lCScVN
         4qKcxs8n0hxSQGqu3Y0E4JY/kdhhi3K1gtibSYiDbEGJOXkCb1BpsrGvJDNfKmHD2h
         jHhfQ1PKrvslxr7098ZRy5mo9zXfMdLSTDy4cUV8BTNRapNlhMBimhWegxnz4e5JBV
         rToL9pBLfC8iA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m4h5R-0007KG-W0; Sat, 17 Jul 2021 11:58:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v14 5/9] staging: hi6421-spmi-pmic: cleanup drvdata
Date:   Sat, 17 Jul 2021 11:58:16 +0200
Message-Id: <723edefbb2e9ce0b70d9c7bce95f288e3ea1f5b1.1626515862.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626515862.git.mchehab+huawei@kernel.org>
References: <cover.1626515862.git.mchehab+huawei@kernel.org>
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

While here, add a missing dot at the Huawei's copyrights.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/misc/hi6421v600-irq.c               |  9 ++++----
 drivers/regulator/hi6421v600-regulator.c    | 10 ++++-----
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 16 +++++--------
 include/linux/mfd/hi6421-spmi-pmic.h        | 25 ---------------------
 4 files changed, 14 insertions(+), 46 deletions(-)
 delete mode 100644 include/linux/mfd/hi6421-spmi-pmic.h

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
index 916d4e1f9061..23cdf90944e9 100644
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
diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 4f136826681b..c9c0c3d7011f 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
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

