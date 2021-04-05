Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEB03541C3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 13:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbhDELoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 07:44:16 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:35751 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbhDELoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 07:44:15 -0400
Received: by mail-lj1-f182.google.com with SMTP id a1so12421394ljp.2;
        Mon, 05 Apr 2021 04:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tvlxvoM/ceZyS3fn/ULDmNExtuJEsyCbDCkjjvxhBxc=;
        b=JFJNwat3UkJrWqRtmjNv5CUjrzv8kBuI/a2j1QlTZ5ZltTUFnrevLgv7d6uKn4sw0/
         qWRgaJZ6QwXhXdNoxRZoUufyGZEnqOqOCYB1Ke3+AmCcMjzj0hhxjLazrbYA+1focI74
         oRI9p7gQQn/I+8DeO32RuR2rur0VOHKMofGb8HdFNd8YpS8/n0GTqFkm4bPUHSEEkslr
         xrLDHBV0glnlU6r+gsKmvuPhbCjjFlcNjObfSWweh5dkiguRd/MSe64PinkfIeunDnFt
         ArcHDwLJwRWgPZcfnwqxk803WImuj6200YypZNVXB7R5t6M4jjzJFeGem4dOiTmX93Y8
         rjzw==
X-Gm-Message-State: AOAM532aAhDmlQ2d+dtgv1PeiqTwjZg0nHccnG744qd6adlxp5TAvd+Q
        NVmCZw+KWEkUtdZpItDl/Ss=
X-Google-Smtp-Source: ABdhPJw7Ui+MsrvFY0zc3GzqeMTHCI2MTRXXcWBnYBDcTIbNKu4a3z6yiVGrc0dEBF/0VRRQFWGcDA==
X-Received: by 2002:a2e:5747:: with SMTP id r7mr16009161ljd.227.1617623046527;
        Mon, 05 Apr 2021 04:44:06 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::6])
        by smtp.gmail.com with ESMTPSA id z10sm1750377lfa.201.2021.04.05.04.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 04:44:05 -0700 (PDT)
Date:   Mon, 5 Apr 2021 14:44:00 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [PATCH v6 12/16] regulator: bd718x7, bd71828: Use ramp-delay helper
Message-ID: <0c833e368fb1be2e9bcd9caa5c930b223e348052.1617616855.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1617616855.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617616855.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic regamp ramp-delay helper function instead of implementing own.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
No changes since v4
 drivers/regulator/bd71828-regulator.c | 51 ++++++++---------------
 drivers/regulator/bd718x7-regulator.c | 60 ++++++++++++---------------
 2 files changed, 45 insertions(+), 66 deletions(-)

diff --git a/drivers/regulator/bd71828-regulator.c b/drivers/regulator/bd71828-regulator.c
index 6b12e963ed8f..a4f09a5a30ca 100644
--- a/drivers/regulator/bd71828-regulator.c
+++ b/drivers/regulator/bd71828-regulator.c
@@ -90,38 +90,7 @@ static const struct linear_range bd71828_ldo_volts[] = {
 	REGULATOR_LINEAR_RANGE(3300000, 0x32, 0x3f, 0),
 };
 
-static int bd71828_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
-{
-	unsigned int val;
-
-	switch (ramp_delay) {
-	case 1 ... 2500:
-		val = 0;
-		break;
-	case 2501 ... 5000:
-		val = 1;
-		break;
-	case 5001 ... 10000:
-		val = 2;
-		break;
-	case 10001 ... 20000:
-		val = 3;
-		break;
-	default:
-		val = 3;
-		dev_err(&rdev->dev,
-			"ramp_delay: %d not supported, setting 20mV/uS",
-			 ramp_delay);
-	}
-
-	/*
-	 * On BD71828 the ramp delay level control reg is at offset +2 to
-	 * enable reg
-	 */
-	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg + 2,
-				  BD71828_MASK_RAMP_DELAY,
-				  val << (ffs(BD71828_MASK_RAMP_DELAY) - 1));
-}
+static const unsigned int bd71828_ramp_delay[] = { 2500, 5000, 10000, 20000 };
 
 static int buck_set_hw_dvs_levels(struct device_node *np,
 				  const struct regulator_desc *desc,
@@ -185,7 +154,7 @@ static const struct regulator_ops bd71828_dvs_buck_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
-	.set_ramp_delay = bd71828_set_ramp_delay,
+	.set_ramp_delay = regulator_set_ramp_delay_regmap,
 };
 
 static const struct regulator_ops bd71828_ldo_ops = {
@@ -219,6 +188,10 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 			.enable_mask = BD71828_MASK_RUN_EN,
 			.vsel_reg = BD71828_REG_BUCK1_VOLT,
 			.vsel_mask = BD71828_MASK_BUCK1267_VOLT,
+			.ramp_delay_table = bd71828_ramp_delay,
+			.n_ramp_values = ARRAY_SIZE(bd71828_ramp_delay),
+			.ramp_reg = BD71828_REG_BUCK1_MODE,
+			.ramp_mask = BD71828_MASK_RAMP_DELAY,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
@@ -261,6 +234,10 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 			.enable_mask = BD71828_MASK_RUN_EN,
 			.vsel_reg = BD71828_REG_BUCK2_VOLT,
 			.vsel_mask = BD71828_MASK_BUCK1267_VOLT,
+			.ramp_delay_table = bd71828_ramp_delay,
+			.n_ramp_values = ARRAY_SIZE(bd71828_ramp_delay),
+			.ramp_reg = BD71828_REG_BUCK2_MODE,
+			.ramp_mask = BD71828_MASK_RAMP_DELAY,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
@@ -421,6 +398,10 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 			.enable_mask = BD71828_MASK_RUN_EN,
 			.vsel_reg = BD71828_REG_BUCK6_VOLT,
 			.vsel_mask = BD71828_MASK_BUCK1267_VOLT,
+			.ramp_delay_table = bd71828_ramp_delay,
+			.n_ramp_values = ARRAY_SIZE(bd71828_ramp_delay),
+			.ramp_reg = BD71828_REG_BUCK6_MODE,
+			.ramp_mask = BD71828_MASK_RAMP_DELAY,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
@@ -458,6 +439,10 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 			.enable_mask = BD71828_MASK_RUN_EN,
 			.vsel_reg = BD71828_REG_BUCK7_VOLT,
 			.vsel_mask = BD71828_MASK_BUCK1267_VOLT,
+			.ramp_delay_table = bd71828_ramp_delay,
+			.n_ramp_values = ARRAY_SIZE(bd71828_ramp_delay),
+			.ramp_reg = BD71828_REG_BUCK7_MODE,
+			.ramp_mask = BD71828_MASK_RAMP_DELAY,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index 8ff47ea522d6..e61295b30503 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -86,37 +86,7 @@ static const struct regulator_ops BD718XX_HWOPNAME(name) = {	\
  * 10: 2.50mV/usec	10mV 4uS
  * 11: 1.25mV/usec	10mV 8uS
  */
-static int bd718xx_buck1234_set_ramp_delay(struct regulator_dev *rdev,
-					   int ramp_delay)
-{
-	int id = rdev_get_id(rdev);
-	unsigned int ramp_value;
-
-	dev_dbg(&rdev->dev, "Buck[%d] Set Ramp = %d\n", id + 1,
-		ramp_delay);
-	switch (ramp_delay) {
-	case 1 ... 1250:
-		ramp_value = BUCK_RAMPRATE_1P25MV;
-		break;
-	case 1251 ... 2500:
-		ramp_value = BUCK_RAMPRATE_2P50MV;
-		break;
-	case 2501 ... 5000:
-		ramp_value = BUCK_RAMPRATE_5P00MV;
-		break;
-	case 5001 ... 10000:
-		ramp_value = BUCK_RAMPRATE_10P00MV;
-		break;
-	default:
-		ramp_value = BUCK_RAMPRATE_10P00MV;
-		dev_err(&rdev->dev,
-			"%s: ramp_delay: %d not supported, setting 10000mV//us\n",
-			rdev->desc->name, ramp_delay);
-	}
-
-	return regmap_update_bits(rdev->regmap, BD718XX_REG_BUCK1_CTRL + id,
-				  BUCK_RAMPRATE_MASK, ramp_value << 6);
-}
+static const unsigned int bd718xx_ramp_delay[] = { 10000, 5000, 2500, 1250 };
 
 /* These functions are used when regulators are under HW state machine control.
  * We assume PMIC is in RUN state because SW running and able to query the
@@ -378,7 +348,7 @@ static const struct regulator_ops bd71837_buck34_ops_hwctrl = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
-	.set_ramp_delay = bd718xx_buck1234_set_ramp_delay,
+	.set_ramp_delay = regulator_set_ramp_delay_regmap,
 };
 
 /*
@@ -387,7 +357,7 @@ static const struct regulator_ops bd71837_buck34_ops_hwctrl = {
 BD718XX_OPS(bd718xx_dvs_buck_regulator_ops, regulator_list_voltage_linear_range,
 	    NULL, regulator_set_voltage_sel_regmap,
 	    regulator_get_voltage_sel_regmap, regulator_set_voltage_time_sel,
-	    bd718xx_buck1234_set_ramp_delay);
+	    /* bd718xx_buck1234_set_ramp_delay */ regulator_set_ramp_delay_regmap);
 
 /*
  * BD71837 BUCK1/2/3/4
@@ -645,6 +615,10 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.enable_mask = BD718XX_BUCK_EN,
 			.enable_time = BD71847_BUCK1_STARTUP_TIME,
 			.owner = THIS_MODULE,
+			.ramp_delay_table = bd718xx_ramp_delay,
+			.n_ramp_values = ARRAY_SIZE(bd718xx_ramp_delay),
+			.ramp_reg = BD718XX_REG_BUCK1_CTRL,
+			.ramp_mask = BUCK_RAMPRATE_MASK,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
 		.dvs = {
@@ -678,6 +652,10 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.enable_reg = BD718XX_REG_BUCK2_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.enable_time = BD71847_BUCK2_STARTUP_TIME,
+			.ramp_delay_table = bd718xx_ramp_delay,
+			.n_ramp_values = ARRAY_SIZE(bd718xx_ramp_delay),
+			.ramp_reg = BD718XX_REG_BUCK2_CTRL,
+			.ramp_mask = BUCK_RAMPRATE_MASK,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
@@ -985,6 +963,10 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.enable_reg = BD718XX_REG_BUCK1_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.enable_time = BD71837_BUCK1_STARTUP_TIME,
+			.ramp_delay_table = bd718xx_ramp_delay,
+			.n_ramp_values = ARRAY_SIZE(bd718xx_ramp_delay),
+			.ramp_reg = BD718XX_REG_BUCK1_CTRL,
+			.ramp_mask = BUCK_RAMPRATE_MASK,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
@@ -1019,6 +1001,10 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.enable_reg = BD718XX_REG_BUCK2_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.enable_time = BD71837_BUCK2_STARTUP_TIME,
+			.ramp_delay_table = bd718xx_ramp_delay,
+			.n_ramp_values = ARRAY_SIZE(bd718xx_ramp_delay),
+			.ramp_reg = BD718XX_REG_BUCK2_CTRL,
+			.ramp_mask = BUCK_RAMPRATE_MASK,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
@@ -1050,6 +1036,10 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.enable_reg = BD71837_REG_BUCK3_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.enable_time = BD71837_BUCK3_STARTUP_TIME,
+			.ramp_delay_table = bd718xx_ramp_delay,
+			.n_ramp_values = ARRAY_SIZE(bd718xx_ramp_delay),
+			.ramp_reg = BD71837_REG_BUCK3_CTRL,
+			.ramp_mask = BUCK_RAMPRATE_MASK,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
@@ -1079,6 +1069,10 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.enable_reg = BD71837_REG_BUCK4_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
 			.enable_time = BD71837_BUCK4_STARTUP_TIME,
+			.ramp_delay_table = bd718xx_ramp_delay,
+			.n_ramp_values = ARRAY_SIZE(bd718xx_ramp_delay),
+			.ramp_reg = BD71837_REG_BUCK4_CTRL,
+			.ramp_mask = BUCK_RAMPRATE_MASK,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
