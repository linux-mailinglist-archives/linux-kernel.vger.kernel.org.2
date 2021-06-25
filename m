Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173AF3B47FC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 19:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhFYRIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 13:08:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhFYRIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 13:08:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 359B36194F;
        Fri, 25 Jun 2021 17:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624640778;
        bh=NAKKCTeJb45XE5n4uj+YdLAUxfdg1u9VkJy96LztvwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FE4ZiFueQTmP0sV1CLYwCffrJyfD5qECIEUJApZucW/b6N+LnnB1PiDMCh072D0lF
         Myy4aN2ZBodn0WPvvmdtSmnkAoIoUtmmxjq6G4SW2x5c4comArPvj1Upb9z0ev+U/f
         Xi4/38snXoI0Hxo42f7s2W2TYc0GwgU6Git138EjldYbw61OhUXcodpoYWeA3GXftb
         pjFwdf2H1zVXX8lrip65I9TYEcCN0ylgL/XZnPZLxXyb4QjDK5r5lceCO2p+djE9Oi
         41h3EGKhKavd13RV3A2arlGICl0PgclYQONDyFkI0hwOkAEfmnwoL23ImObRJZl9Cm
         T7w06q2A/dWQg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lwpHU-004mvm-4w; Fri, 25 Jun 2021 19:06:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>, Axel Lin <axel.lin@ingics.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v9 2/5] regulator: hi6421v600-regulator: fix platform drvdata
Date:   Fri, 25 Jun 2021 19:06:11 +0200
Message-Id: <ef0ff659a875b91b454df12b57888f2b473877fa.1624640087.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624640087.git.mchehab+huawei@kernel.org>
References: <cover.1624640087.git.mchehab+huawei@kernel.org>
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

While here, drop the unused fields there.

Fixes: 50e629362e1f ("regulator: hi6421v600: Fix setting wrong driver_data")

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/regulator/hi6421v600-regulator.c    | 26 +++++++++------------
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c |  2 +-
 include/linux/mfd/hi6421-spmi-pmic.h        |  9 +++----
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index 9b162c0555c3..49d83350435c 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -16,15 +16,13 @@
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
@@ -231,7 +228,7 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
 {
 	struct device *pmic_dev = pdev->dev.parent;
 	struct regulator_config config = { };
-	struct hi6421_spmi_reg_priv *priv;
+	struct hi6421_spmi_reg_info *sreg;
 	struct hi6421_spmi_reg_info *info;
 	struct device *dev = &pdev->dev;
 	struct hi6421_spmi_pmic *pmic;
@@ -247,18 +244,17 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
 	if (WARN_ON(!pmic))
 		return -ENODEV;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	sreg = devm_kzalloc(dev, sizeof(*sreg), GFP_KERNEL);
+	if (!sreg)
 		return -ENOMEM;
 
-	mutex_init(&priv->enable_mutex);
-	platform_set_drvdata(pdev, priv);
+	sreg->enable_mutex = &pmic->enable_mutex;
 
 	for (i = 0; i < ARRAY_SIZE(regulator_info); i++) {
 		info = &regulator_info[i];
 
 		config.dev = pdev->dev.parent;
-		config.driver_data = info;
+		config.driver_data = sreg;
 		config.regmap = pmic->regmap;
 
 		rdev = devm_regulator_register(dev, &info->desc, &config);
diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 0b5686655954..6864a19f3218 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -40,7 +40,7 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
 	if (IS_ERR(ddata->regmap))
 		return PTR_ERR(ddata->regmap);
 
-	ddata->dev = dev;
+	mutex_init(&ddata->enable_mutex);
 
 	dev_set_drvdata(&pdev->dev, ddata);
 
diff --git a/include/linux/mfd/hi6421-spmi-pmic.h b/include/linux/mfd/hi6421-spmi-pmic.h
index e5b8dbf828b6..a72b2797a997 100644
--- a/include/linux/mfd/hi6421-spmi-pmic.h
+++ b/include/linux/mfd/hi6421-spmi-pmic.h
@@ -16,10 +16,11 @@
 #include <linux/regmap.h>
 
 struct hi6421_spmi_pmic {
-	struct resource				*res;
-	struct device				*dev;
-	void __iomem				*regs;
-	struct regmap				*regmap;
+	/* Serialize regulator enable logic */
+	struct mutex	enable_mutex;
+
+	/* SPMI register regmap */
+	struct regmap	*regmap;
 };
 
 #endif		/* __HISI_PMIC_H */
-- 
2.31.1

