Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B223B9D0B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 09:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhGBHkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 03:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhGBHkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 03:40:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D838961416;
        Fri,  2 Jul 2021 07:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625211449;
        bh=q0W63OXf1lUOTdOBUZdP3kx7jv8oh+KN3S7N2rQG3b8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZoeiVw5qRFZOF5WzALiVaHLEhetYYoUnh2DHWfuOn339vy/Sgum2u3JlitOjA+Kc
         Ca6Rq2xnyYCfGcaqesiYA8i9nZNeW4mSue/PZicWB3dnJT/LDlhzzvfhVlrGM8aAi+
         WKvcOoWJ40yK8odww4SI+uDwXedwXg+QiMMu8oQ27JnKTqFGCQaS9KTA8daAw9EINu
         UkVE134gOLSzFR6GXFIBgnVMfDnO9WwJUzXO0pI1IC5z9BWDZUrl5y8HzhrlMdWenv
         zgtjEj8ag/yDoFrKhAWcCeu9jwC8TgOdg1j1eqpSh9Ptnu+p55fOCkDNS/Kc616AjU
         DEx6Fag7lZj+A==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lzDjo-000gZv-R9; Fri, 02 Jul 2021 09:37:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Axel Lin" <axel.lin@ingics.com>,
        "Lee Jones" <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v11 4/8] staging: hi6421-spmi-pmic: cleanup drvdata
Date:   Fri,  2 Jul 2021 09:37:19 +0200
Message-Id: <e90ea5dec3aa07a45ead915e01058ddb2b2901e3.1625211021.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625211021.git.mchehab+huawei@kernel.org>
References: <cover.1625211021.git.mchehab+huawei@kernel.org>
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

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/misc/hi6421v600-irq.c               |  9 ++++----
 drivers/regulator/hi6421v600-regulator.c    | 10 ++++-----
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 16 +++++--------
 include/linux/mfd/hi6421-spmi-pmic.h        | 25 ---------------------
 4 files changed, 14 insertions(+), 46 deletions(-)
 delete mode 100644 include/linux/mfd/hi6421-spmi-pmic.h

diff --git a/drivers/misc/hi6421v600-irq.c b/drivers/misc/hi6421v600-irq.c
index 7c1468f0ea01..0c2477480450 100644
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
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pmic_dev->of_node;
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
index 46dc1b856217..f63ba73c9e33 100644
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
 static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
 	int ret;
-	struct hi6421_spmi_pmic *ddata;
-	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
-	if (!ddata)
-		return -ENOMEM;
 
-	ddata->regmap = devm_regmap_init_spmi_ext(pdev, &regmap_config);
-	if (IS_ERR(ddata->regmap))
-		return PTR_ERR(ddata->regmap);
+	regmap = devm_regmap_init_spmi_ext(pdev, &regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
-	ddata->dev = dev;
-
-	dev_set_drvdata(&pdev->dev, ddata);
+	dev_set_drvdata(&pdev->dev, regmap);
 
 	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
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

