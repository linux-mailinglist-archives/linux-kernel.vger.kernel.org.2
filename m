Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5FA3B70C0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 12:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbhF2KeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 06:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232842AbhF2KeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 06:34:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8849461DA7;
        Tue, 29 Jun 2021 10:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624962694;
        bh=2gM0F4BfoP4nywCVdtRGNgEuc1jh8O5SlvIv5N1YhaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YVi6JiHU+oLEXWFmZKlNtC+TYA25GtjMAetNDbvyqxmjHwumOjOnmFfrI+TueLFxR
         kdqBpvy5UJzNnpwhvWgOB4J6i+r/lp/D4+Q3Q0I9Vov9HXD8GWwIF7JKq2whc4Ajgx
         PWUcawDPkYjw6Vb9KUD6opqWoOC3J8YfejGtaqeRjxzj950O/Ze1ACS3jHVVGhUCVT
         dsDt4GLRBUbXYqe19qmnyZTGIJuDK6aguzWqY1bYCwZBYB1Z3M8JqyMKCBacVisBWT
         ZekDSB76wr8PuGmS22Qqgw1aHo929ip9ncq00z/33qEmkMpw/2p/8fLfaYIvjspjDe
         HUmBHAfNI507w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lyB1g-00Cx7U-RQ; Tue, 29 Jun 2021 12:31:32 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Axel Lin" <axel.lin@ingics.com>,
        "Lee Jones" <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v10 2/5] regulator: hi6421v600-regulator: fix platform drvdata
Date:   Tue, 29 Jun 2021 12:31:28 +0200
Message-Id: <eed34e8897c79a2ab13573d3da12c86569bca0f6.1624962269.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624962269.git.mchehab+huawei@kernel.org>
References: <cover.1624962269.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform drvdata can't be used inside the regulator driver,
as this is already used by the MFD and SPMI drivers.

So, change the logic to allocate it inside the
struct hi6421_spmi_pmic.

While here, drop the now unused struct and add a missing dot
at the Huawei's copyrights.

Fixes: 50e629362e1f ("regulator: hi6421v600: Fix setting wrong driver_data")

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/misc/hi6421v600-irq.c               |  9 ++--
 drivers/regulator/hi6421v600-regulator.c    | 49 +++++++++++----------
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 18 +++-----
 include/linux/mfd/hi6421-spmi-pmic.h        | 25 -----------
 4 files changed, 35 insertions(+), 66 deletions(-)
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
index 9b162c0555c3..0e78535eca62 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -4,27 +4,25 @@
 //
 // Copyright (c) 2013 Linaro Ltd.
 // Copyright (c) 2011 HiSilicon Ltd.
-// Copyright (c) 2020-2021 Huawei Technologies Co., Ltd
+// Copyright (c) 2020-2021 Huawei Technologies Co., Ltd.
 //
 // Guodong Xu <guodong.xu@linaro.org>
 
 #include <linux/delay.h>
-#include <linux/mfd/hi6421-spmi-pmic.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/spmi.h>
 
-struct hi6421_spmi_reg_priv {
-	/* Serialize regulator enable logic */
-	struct mutex enable_mutex;
-};
-
 struct hi6421_spmi_reg_info {
 	struct regulator_desc	desc;
 	u8			eco_mode_mask;
 	u32			eco_uA;
+
+	/* Serialize regulator enable logic */
+	struct mutex		*enable_mutex;
 };
 
 static const unsigned int ldo3_voltages[] = {
@@ -98,12 +96,11 @@ static const unsigned int ldo34_voltages[] = {
 
 static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 {
-	struct hi6421_spmi_reg_priv *priv;
+	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
 	int ret;
 
-	priv = dev_get_drvdata(rdev->dev.parent);
 	/* cannot enable more than one regulator at one time */
-	mutex_lock(&priv->enable_mutex);
+	mutex_lock(sreg->enable_mutex);
 
 	ret = regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
 				 rdev->desc->enable_mask,
@@ -112,7 +109,7 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 	/* Avoid powering up multiple devices at the same time */
 	usleep_range(rdev->desc->off_on_delay, rdev->desc->off_on_delay + 60);
 
-	mutex_unlock(&priv->enable_mutex);
+	mutex_unlock(sreg->enable_mutex);
 
 	return ret;
 }
@@ -231,11 +228,12 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
 {
 	struct device *pmic_dev = pdev->dev.parent;
 	struct regulator_config config = { };
-	struct hi6421_spmi_reg_priv *priv;
+	struct hi6421_spmi_reg_info *sreg;
 	struct hi6421_spmi_reg_info *info;
 	struct device *dev = &pdev->dev;
-	struct hi6421_spmi_pmic *pmic;
+	struct regmap *regmap;
 	struct regulator_dev *rdev;
+	struct mutex *enable_mutex;
 	int i;
 
 	/*
@@ -243,23 +241,27 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
 	 * which should first set drvdata. If this doesn't happen, hit
 	 * a warn on and return.
 	 */
-	pmic = dev_get_drvdata(pmic_dev);
-	if (WARN_ON(!pmic))
+	regmap = dev_get_drvdata(pmic_dev);
+	if (WARN_ON(!regmap))
 		return -ENODEV;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	mutex_init(&priv->enable_mutex);
-	platform_set_drvdata(pdev, priv);
+	enable_mutex = devm_kzalloc(dev, sizeof(*enable_mutex), GFP_KERNEL);
+	mutex_init(enable_mutex);
 
 	for (i = 0; i < ARRAY_SIZE(regulator_info); i++) {
 		info = &regulator_info[i];
 
+		sreg = devm_kzalloc(dev, sizeof(*sreg), GFP_KERNEL);
+		if (!sreg)
+			return -ENOMEM;
+
+		sreg->enable_mutex = enable_mutex;
+		sreg->eco_mode_mask = regulator_info[i].eco_mode_mask;
+		sreg->eco_uA = regulator_info[i].eco_uA;
+
 		config.dev = pdev->dev.parent;
-		config.driver_data = info;
-		config.regmap = pmic->regmap;
+		config.driver_data = sreg;
+		config.regmap = regmap;
 
 		rdev = devm_regulator_register(dev, &info->desc, &config);
 		if (IS_ERR(rdev)) {
@@ -289,4 +291,3 @@ module_platform_driver(hi6421_spmi_regulator_driver);
 
 MODULE_DESCRIPTION("Hi6421v600 SPMI regulator driver");
 MODULE_LICENSE("GPL v2");
-
diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 0b5686655954..f63ba73c9e33 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -4,11 +4,10 @@
  *
  * Copyright (c) 2013 Linaro Ltd.
  * Copyright (c) 2011 Hisilicon.
- * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd
+ * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd.
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

