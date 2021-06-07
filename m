Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B25B39DEC6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhFGOcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhFGOcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:32:03 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D593CC061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 07:30:11 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k5so9986650pjj.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=heUcwk6RLkDmJ0M6ypyJnPOAPSW1cdec38S8tqQPi9A=;
        b=Whp1cP/7IEt7+ZtE2SrMd7D74YEK/JRoo/7HV0YOIhT7WM3/UE6c1mDLP4InpYPEzr
         JnyjaVhpq0+LIrmrUXTjW048OFiHf/gYlPLzzbGqfCiVic/HK5I1vvBEgWE2k+BC+s+L
         NbDuhtPLCOlPteA2Cn30G+k2bUk77P7POqT9bMT5mjZCxp8LmTNZcF7zYmgdob6ugoiZ
         xUJT3jrpTpeDfowRKNd64UMXHqhzHAGQp2qQ1GvkIDI7NE+18F0cYNcy81NRmHQmwKwS
         ajVC32H6Sk7Z0++4XG2qZBr+dSsk8Xwk98EwHbq4unFdPfYatXNBAzd8C8+WBngYRv3h
         qjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=heUcwk6RLkDmJ0M6ypyJnPOAPSW1cdec38S8tqQPi9A=;
        b=RWDx0eNWp1/c2L+1MAoz+tGPf2MA6G3jnPbwmvxpHwByQljKBP1HY6CwU+8ixmbMoP
         +cj/wXCi153o+m7nL6+Pr8yVA7se+O+CzH9wEVjmc7QC/w6G0qKCLg0SWp65dBSO8H1G
         WfbAoWal84JEj9FVH7DwZJNC/q2txeZ4ghwFHh0cDqQBamdL1odM8Mv4mbhMs19yR4f4
         E1z198UeRbqS9FlSzudCFS86gFSWPf2uv+ECRMsWKtx0yxIbatbfzcOcstNPovcpkjYw
         QEu5SETODnVkGScVdumkZBg/WjxMUfYAj9iro6X82u4Rvtz6GVi8i9iAZk6BBJpv54Dq
         tYFw==
X-Gm-Message-State: AOAM532+vTg68rA+32pEfw0PQeUQ2fKBDeLlz+l2TTFCx6rn7pNienoO
        MUf5coW9ITVtJ4UD+81VCv45dA==
X-Google-Smtp-Source: ABdhPJxz+pJ/HKElGJqRpPnxGdQBgTf44ggdGNGpVs3soKlPEM0fp600QP5/C28IOJvjhWY+2ClrPg==
X-Received: by 2002:a17:90b:3e89:: with SMTP id rj9mr20148520pjb.114.1623076211180;
        Mon, 07 Jun 2021 07:30:11 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id m5sm9203560pgl.75.2021.06.07.07.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:30:10 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-power@fi.rohmeurope.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: bd71815: Get rid of struct bd71815_pmic
Date:   Mon,  7 Jun 2021 22:30:02 +0800
Message-Id: <20210607143002.1600017-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The content of bd71815_regulators is never changed, no need to duplicate
it, thus remove descs[BD71815_REGULATOR_CNT].
The *regmap, *dev and *rdev[BD71815_REGULATOR_CNT] are not really needed.
The *gps is unused.

Thus the struct bd71815_pmic can be removed.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/bd71815-regulator.c | 57 +++++++++------------------
 1 file changed, 19 insertions(+), 38 deletions(-)

diff --git a/drivers/regulator/bd71815-regulator.c b/drivers/regulator/bd71815-regulator.c
index 4dd21ac24ddf..16edd9062ca9 100644
--- a/drivers/regulator/bd71815-regulator.c
+++ b/drivers/regulator/bd71815-regulator.c
@@ -28,14 +28,6 @@ struct bd71815_regulator {
 	const struct rohm_dvs_config *dvs;
 };
 
-struct bd71815_pmic {
-	struct bd71815_regulator descs[BD71815_REGULATOR_CNT];
-	struct regmap *regmap;
-	struct device *dev;
-	struct gpio_descs *gps;
-	struct regulator_dev *rdev[BD71815_REGULATOR_CNT];
-};
-
 static const int bd7181x_wled_currents[] = {
 	10, 20, 30, 50, 70, 100, 200, 300, 500, 700, 1000, 2000, 3000, 4000,
 	5000, 6000, 7000, 8000, 9000, 10000, 11000, 12000, 13000, 14000, 15000,
@@ -302,14 +294,13 @@ static int bd7181x_led_set_current_limit(struct regulator_dev *rdev,
 
 static int bd7181x_buck12_get_voltage_sel(struct regulator_dev *rdev)
 {
-	struct bd71815_pmic *pmic = rdev_get_drvdata(rdev);
 	int rid = rdev_get_id(rdev);
 	int ret, regh, regl, val;
 
 	regh = BD71815_REG_BUCK1_VOLT_H + rid * 0x2;
 	regl = BD71815_REG_BUCK1_VOLT_L + rid * 0x2;
 
-	ret = regmap_read(pmic->regmap, regh, &val);
+	ret = regmap_read(rdev->regmap, regh, &val);
 	if (ret)
 		return ret;
 
@@ -321,7 +312,7 @@ static int bd7181x_buck12_get_voltage_sel(struct regulator_dev *rdev)
 	 * by BD71815_BUCK_DVSSEL bit
 	 */
 	if ((!(val & BD71815_BUCK_STBY_DVS)) && (!(val & BD71815_BUCK_DVSSEL)))
-		ret = regmap_read(pmic->regmap, regl, &val);
+		ret = regmap_read(rdev->regmap, regl, &val);
 
 	if (ret)
 		return ret;
@@ -335,14 +326,13 @@ static int bd7181x_buck12_get_voltage_sel(struct regulator_dev *rdev)
 static int bd7181x_buck12_set_voltage_sel(struct regulator_dev *rdev,
 					  unsigned int sel)
 {
-	struct bd71815_pmic *pmic = rdev_get_drvdata(rdev);
 	int rid = rdev_get_id(rdev);
 	int ret, val, reg, regh, regl;
 
 	regh = BD71815_REG_BUCK1_VOLT_H + rid*0x2;
 	regl = BD71815_REG_BUCK1_VOLT_L + rid*0x2;
 
-	ret = regmap_read(pmic->regmap, regh, &val);
+	ret = regmap_read(rdev->regmap, regh, &val);
 	if (ret)
 		return ret;
 
@@ -352,7 +342,7 @@ static int bd7181x_buck12_set_voltage_sel(struct regulator_dev *rdev,
 	 * voltages at runtime is not supported by this driver.
 	 */
 	if (((val & BD71815_BUCK_STBY_DVS))) {
-		return regmap_update_bits(pmic->regmap, regh, BD71815_VOLT_MASK,
+		return regmap_update_bits(rdev->regmap, regh, BD71815_VOLT_MASK,
 					  sel);
 	}
 	/* Update new voltage to the register which is not selected now */
@@ -361,12 +351,13 @@ static int bd7181x_buck12_set_voltage_sel(struct regulator_dev *rdev,
 	else
 		reg = regh;
 
-	ret = regmap_update_bits(pmic->regmap, reg, BD71815_VOLT_MASK, sel);
+	ret = regmap_update_bits(rdev->regmap, reg, BD71815_VOLT_MASK, sel);
 	if (ret)
 		return ret;
 
 	/* Select the other DVS register to be used */
-	return regmap_update_bits(pmic->regmap, regh, BD71815_BUCK_DVSSEL, ~val);
+	return regmap_update_bits(rdev->regmap, regh, BD71815_BUCK_DVSSEL,
+				  ~val);
 }
 
 static const struct regulator_ops bd7181x_ldo_regulator_ops = {
@@ -524,7 +515,7 @@ static const struct regulator_ops bd7181x_led_regulator_ops = {
 		.dvs = (_dvs),						\
 	}
 
-static struct bd71815_regulator bd71815_regulators[] = {
+static const struct bd71815_regulator bd71815_regulators[] = {
 	BD71815_BUCK12_REG(buck1, BD71815_BUCK1, BD71815_REG_BUCK1_VOLT_H,
 			   BD71815_REG_BUCK1_MODE, 800000, 2000000, 25000,
 			   &buck1_dvs),
@@ -570,24 +561,16 @@ static struct bd71815_regulator bd71815_regulators[] = {
 
 static int bd7181x_probe(struct platform_device *pdev)
 {
-	struct bd71815_pmic *pmic;
 	struct regulator_config config = {};
 	int i, ret;
 	struct gpio_desc *ldo4_en;
+	struct regmap *regmap;
 
-	pmic = devm_kzalloc(&pdev->dev, sizeof(*pmic), GFP_KERNEL);
-	if (!pmic)
-		return -ENOMEM;
-
-	memcpy(pmic->descs, bd71815_regulators,	sizeof(pmic->descs));
-
-	pmic->dev = &pdev->dev;
-	pmic->regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	if (!pmic->regmap) {
-		dev_err(pmic->dev, "No parent regmap\n");
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap) {
+		dev_err(&pdev->dev, "No parent regmap\n");
 		return -ENODEV;
 	}
-	platform_set_drvdata(pdev, pmic);
 	ldo4_en = devm_gpiod_get_from_of_node(&pdev->dev,
 					      pdev->dev.parent->of_node,
 						 "rohm,vsel-gpios", 0,
@@ -601,23 +584,23 @@ static int bd7181x_probe(struct platform_device *pdev)
 	}
 
 	/* Disable to go to ship-mode */
-	ret = regmap_update_bits(pmic->regmap, BD71815_REG_PWRCTRL,
-				 RESTARTEN, 0);
+	ret = regmap_update_bits(regmap, BD71815_REG_PWRCTRL, RESTARTEN, 0);
 	if (ret)
 		return ret;
 
 	config.dev = pdev->dev.parent;
-	config.regmap = pmic->regmap;
+	config.regmap = regmap;
 
 	for (i = 0; i < BD71815_REGULATOR_CNT; i++) {
-		struct regulator_desc *desc;
+		const struct regulator_desc *desc;
 		struct regulator_dev *rdev;
 
-		desc = &pmic->descs[i].desc;
+		desc = &bd71815_regulators[i].desc;
+
 		if (i == BD71815_LDO4)
 			config.ena_gpiod = ldo4_en;
-
-		config.driver_data = pmic;
+		else
+			config.ena_gpiod = NULL;
 
 		rdev = devm_regulator_register(&pdev->dev, desc, &config);
 		if (IS_ERR(rdev)) {
@@ -626,8 +609,6 @@ static int bd7181x_probe(struct platform_device *pdev)
 				desc->name);
 			return PTR_ERR(rdev);
 		}
-		config.ena_gpiod = NULL;
-		pmic->rdev[i] = rdev;
 	}
 	return 0;
 }
-- 
2.25.1

