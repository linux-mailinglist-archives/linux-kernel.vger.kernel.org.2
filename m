Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2487F3903A3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbhEYOP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhEYOO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:14:57 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D514C06135A
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 07:12:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so13246298pjv.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l525rQdtMKgJC2QHlcaGy8/6xWUZVmYEO6fo+fS0hgo=;
        b=OHjcaoCLFnqKw77MftpRUp+LI6D1UHaZZdDEoksdd1/EybnO8eWMbDovnF5Liq2dT0
         4P+kERDpWcEPegzT5rCgI+XDKNib4/Qv8LQMOToub7nVYowOnS+j0JCCZVImLn1Y6w5m
         macdxRwu6rPtqKzK9WVAsy/ayH6zclru8YY6oNW4e50mEKIppPDgX5bgpIgu5MGPi2rF
         HIzX6ucvrHOeGw0SL7chmTjGJ/tTqcZ5kHTxcCfTdW351G+Z/ZpLhqBj/WWmy5FNFKv2
         TF4pFhdJkpfpCm8wZM+9BYzt5ZQhy7RubyrnKS50OB0dT4ILseHg0xfm39vcV8PEdiuV
         jvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l525rQdtMKgJC2QHlcaGy8/6xWUZVmYEO6fo+fS0hgo=;
        b=sDTDEoWx9438+OZHZlTEfSwywEctJk65DZ0vPJIZxUBVJj/MpQNw4886EQ30XhWHZ6
         +bc19Uo7Bzx9kFESuPnK9GnVJcH8RKC60Ms8FPpQObGCNrd3NjtR6RxQoj1987B/Cuys
         EoyCAHDE8D8rY/2j9D3AD3EA6j1Qxe1YbSuiTOjiagsa8i5ujf1Y+Y2XV+XQX8l8XHrH
         PSHE+BCWBzdxvOWE0DXPrrNf0n57nl2v3wdtj7drBrjye9wDnK2fmxEFZ8FXRa0mvB1S
         hcGKWGE4SXBho7KoUc6jLIIwoTkoeArk8TbLYYiaxP0IaCsvqfzJTVN5FVpX0pGzvAku
         hGhg==
X-Gm-Message-State: AOAM530vlFX9zm2HLihic5wdChAC3XuhwEq6LOF7zDBA4q4ae0P0LK1m
        z0RGYD72IoSnvb+LHpwoPUpjbdmnqf5Y6ykw
X-Google-Smtp-Source: ABdhPJyKdkQuUv964T0+fargSfHMC9FgpS76Y+4pTsBZ80pOiY5lHTFr//F1k4mmMz4ucJsyuscWAQ==
X-Received: by 2002:a17:90a:b78d:: with SMTP id m13mr5057426pjr.177.1621951933034;
        Tue, 25 May 2021 07:12:13 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id g72sm13689867pfb.33.2021.05.25.07.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 07:12:12 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Zhong <zyw@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2] regulator: rk808: Convert to use regulator_set_ramp_delay_regmap
Date:   Tue, 25 May 2021 22:12:03 +0800
Message-Id: <20210525141203.2562884-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set_ramp_delay_regmap instead of open-coded.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
v2: Fix warning: unused variable 'rk808_buck_config_regs'  reported by 
kernel test robot.
 drivers/regulator/rk808-regulator.c | 116 ++++++++++++----------------
 1 file changed, 51 insertions(+), 65 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index e926c1a85846..127dc2e2e690 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -158,13 +158,6 @@ struct rk808_regulator_data {
 	struct gpio_desc *dvs_gpio[2];
 };
 
-static const int rk808_buck_config_regs[] = {
-	RK808_BUCK1_CONFIG_REG,
-	RK808_BUCK2_CONFIG_REG,
-	RK808_BUCK3_CONFIG_REG,
-	RK808_BUCK4_CONFIG_REG,
-};
-
 static const struct linear_range rk808_ldo3_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(800000, 0, 13, 100000),
 	REGULATOR_LINEAR_RANGE(2500000, 15, 15, 0),
@@ -215,6 +208,15 @@ static const struct linear_range rk817_buck3_voltage_ranges[] = {
 			       RK817_BUCK3_SEL_CNT, RK817_BUCK1_STP1),
 };
 
+static const unsigned int rk808_buck1_2_ramp_table[] = {
+	2000, 4000, 6000, 10000
+};
+
+/* RK817 RK809 */
+static const unsigned int rk817_buck1_4_ramp_table[] = {
+	3000, 6300, 12500, 25000
+};
+
 static int rk808_buck1_2_get_voltage_sel_regmap(struct regulator_dev *rdev)
 {
 	struct rk808_regulator_data *pdata = rdev_get_drvdata(rdev);
@@ -340,62 +342,6 @@ static int rk808_buck1_2_set_voltage_time_sel(struct regulator_dev *rdev,
 	return regulator_set_voltage_time_sel(rdev, old_selector, new_selector);
 }
 
-static int rk808_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
-{
-	unsigned int ramp_value = RK808_RAMP_RATE_10MV_PER_US;
-	unsigned int reg = rk808_buck_config_regs[rdev_get_id(rdev)];
-
-	switch (ramp_delay) {
-	case 1 ... 2000:
-		ramp_value = RK808_RAMP_RATE_2MV_PER_US;
-		break;
-	case 2001 ... 4000:
-		ramp_value = RK808_RAMP_RATE_4MV_PER_US;
-		break;
-	case 4001 ... 6000:
-		ramp_value = RK808_RAMP_RATE_6MV_PER_US;
-		break;
-	case 6001 ... 10000:
-		break;
-	default:
-		pr_warn("%s ramp_delay: %d not supported, setting 10000\n",
-			rdev->desc->name, ramp_delay);
-	}
-
-	return regmap_update_bits(rdev->regmap, reg,
-				  RK808_RAMP_RATE_MASK, ramp_value);
-}
-
-/*
- * RK817 RK809
- */
-static int rk817_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
-{
-	unsigned int ramp_value = RK817_RAMP_RATE_25MV_PER_US;
-	unsigned int reg = RK817_BUCK_CONFIG_REG(rdev_get_id(rdev));
-
-	switch (ramp_delay) {
-	case 0 ... 3000:
-		ramp_value = RK817_RAMP_RATE_3MV_PER_US;
-		break;
-	case 3001 ... 6300:
-		ramp_value = RK817_RAMP_RATE_6_3MV_PER_US;
-		break;
-	case 6301 ... 12500:
-		ramp_value = RK817_RAMP_RATE_12_5MV_PER_US;
-		break;
-	case 12501 ... 25000:
-		break;
-	default:
-		dev_warn(&rdev->dev,
-			 "%s ramp_delay: %d not supported, setting 25000\n",
-			 rdev->desc->name, ramp_delay);
-	}
-
-	return regmap_update_bits(rdev->regmap, reg,
-				  RK817_RAMP_RATE_MASK, ramp_value);
-}
-
 static int rk808_set_suspend_voltage(struct regulator_dev *rdev, int uv)
 {
 	unsigned int reg;
@@ -625,7 +571,7 @@ static const struct regulator_ops rk808_buck1_2_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
-	.set_ramp_delay		= rk808_set_ramp_delay,
+	.set_ramp_delay		= regulator_set_ramp_delay_regmap,
 	.set_suspend_voltage	= rk808_set_suspend_voltage,
 	.set_suspend_enable	= rk808_set_suspend_enable,
 	.set_suspend_disable	= rk808_set_suspend_disable,
@@ -722,7 +668,7 @@ static const struct regulator_ops rk817_buck_ops_range = {
 	.set_mode		= rk8xx_set_mode,
 	.get_mode		= rk8xx_get_mode,
 	.set_suspend_mode	= rk8xx_set_suspend_mode,
-	.set_ramp_delay		= rk817_set_ramp_delay,
+	.set_ramp_delay		= regulator_set_ramp_delay_regmap,
 	.set_suspend_voltage	= rk808_set_suspend_voltage_range,
 	.set_suspend_enable	= rk817_set_suspend_enable,
 	.set_suspend_disable	= rk817_set_suspend_disable,
@@ -814,6 +760,10 @@ static const struct regulator_desc rk808_reg[] = {
 		.vsel_mask = RK808_BUCK_VSEL_MASK,
 		.enable_reg = RK808_DCDC_EN_REG,
 		.enable_mask = BIT(0),
+		.ramp_reg = RK808_BUCK1_CONFIG_REG,
+		.ramp_mask = RK808_RAMP_RATE_MASK,
+		.ramp_delay_table = rk808_buck1_2_ramp_table,
+		.n_ramp_values = ARRAY_SIZE(rk808_buck1_2_ramp_table),
 		.owner = THIS_MODULE,
 	}, {
 		.name = "DCDC_REG2",
@@ -830,6 +780,10 @@ static const struct regulator_desc rk808_reg[] = {
 		.vsel_mask = RK808_BUCK_VSEL_MASK,
 		.enable_reg = RK808_DCDC_EN_REG,
 		.enable_mask = BIT(1),
+		.ramp_reg = RK808_BUCK2_CONFIG_REG,
+		.ramp_mask = RK808_RAMP_RATE_MASK,
+		.ramp_delay_table = rk808_buck1_2_ramp_table,
+		.n_ramp_values = ARRAY_SIZE(rk808_buck1_2_ramp_table),
 		.owner = THIS_MODULE,
 	}, {
 		.name = "DCDC_REG3",
@@ -910,6 +864,10 @@ static const struct regulator_desc rk809_reg[] = {
 		.enable_mask = ENABLE_MASK(RK817_ID_DCDC1),
 		.enable_val = ENABLE_MASK(RK817_ID_DCDC1),
 		.disable_val = DISABLE_VAL(RK817_ID_DCDC1),
+		.ramp_reg = RK817_BUCK_CONFIG_REG(RK817_ID_DCDC1),
+		.ramp_mask = RK817_RAMP_RATE_MASK,
+		.ramp_delay_table = rk817_buck1_4_ramp_table,
+		.n_ramp_values = ARRAY_SIZE(rk817_buck1_4_ramp_table),
 		.of_map_mode = rk8xx_regulator_of_map_mode,
 		.owner = THIS_MODULE,
 	}, {
@@ -929,6 +887,10 @@ static const struct regulator_desc rk809_reg[] = {
 		.enable_mask = ENABLE_MASK(RK817_ID_DCDC2),
 		.enable_val = ENABLE_MASK(RK817_ID_DCDC2),
 		.disable_val = DISABLE_VAL(RK817_ID_DCDC2),
+		.ramp_reg = RK817_BUCK_CONFIG_REG(RK817_ID_DCDC2),
+		.ramp_mask = RK817_RAMP_RATE_MASK,
+		.ramp_delay_table = rk817_buck1_4_ramp_table,
+		.n_ramp_values = ARRAY_SIZE(rk817_buck1_4_ramp_table),
 		.of_map_mode = rk8xx_regulator_of_map_mode,
 		.owner = THIS_MODULE,
 	}, {
@@ -948,6 +910,10 @@ static const struct regulator_desc rk809_reg[] = {
 		.enable_mask = ENABLE_MASK(RK817_ID_DCDC3),
 		.enable_val = ENABLE_MASK(RK817_ID_DCDC3),
 		.disable_val = DISABLE_VAL(RK817_ID_DCDC3),
+		.ramp_reg = RK817_BUCK_CONFIG_REG(RK817_ID_DCDC3),
+		.ramp_mask = RK817_RAMP_RATE_MASK,
+		.ramp_delay_table = rk817_buck1_4_ramp_table,
+		.n_ramp_values = ARRAY_SIZE(rk817_buck1_4_ramp_table),
 		.of_map_mode = rk8xx_regulator_of_map_mode,
 		.owner = THIS_MODULE,
 	}, {
@@ -967,6 +933,10 @@ static const struct regulator_desc rk809_reg[] = {
 		.enable_mask = ENABLE_MASK(RK817_ID_DCDC4),
 		.enable_val = ENABLE_MASK(RK817_ID_DCDC4),
 		.disable_val = DISABLE_VAL(RK817_ID_DCDC4),
+		.ramp_reg = RK817_BUCK_CONFIG_REG(RK817_ID_DCDC4),
+		.ramp_mask = RK817_RAMP_RATE_MASK,
+		.ramp_delay_table = rk817_buck1_4_ramp_table,
+		.n_ramp_values = ARRAY_SIZE(rk817_buck1_4_ramp_table),
 		.of_map_mode = rk8xx_regulator_of_map_mode,
 		.owner = THIS_MODULE,
 	},
@@ -1052,6 +1022,10 @@ static const struct regulator_desc rk817_reg[] = {
 		.enable_mask = ENABLE_MASK(RK817_ID_DCDC1),
 		.enable_val = ENABLE_MASK(RK817_ID_DCDC1),
 		.disable_val = DISABLE_VAL(RK817_ID_DCDC1),
+		.ramp_reg = RK817_BUCK_CONFIG_REG(RK817_ID_DCDC1),
+		.ramp_mask = RK817_RAMP_RATE_MASK,
+		.ramp_delay_table = rk817_buck1_4_ramp_table,
+		.n_ramp_values = ARRAY_SIZE(rk817_buck1_4_ramp_table),
 		.of_map_mode = rk8xx_regulator_of_map_mode,
 		.owner = THIS_MODULE,
 	}, {
@@ -1071,6 +1045,10 @@ static const struct regulator_desc rk817_reg[] = {
 		.enable_mask = ENABLE_MASK(RK817_ID_DCDC2),
 		.enable_val = ENABLE_MASK(RK817_ID_DCDC2),
 		.disable_val = DISABLE_VAL(RK817_ID_DCDC2),
+		.ramp_reg = RK817_BUCK_CONFIG_REG(RK817_ID_DCDC2),
+		.ramp_mask = RK817_RAMP_RATE_MASK,
+		.ramp_delay_table = rk817_buck1_4_ramp_table,
+		.n_ramp_values = ARRAY_SIZE(rk817_buck1_4_ramp_table),
 		.of_map_mode = rk8xx_regulator_of_map_mode,
 		.owner = THIS_MODULE,
 	}, {
@@ -1090,6 +1068,10 @@ static const struct regulator_desc rk817_reg[] = {
 		.enable_mask = ENABLE_MASK(RK817_ID_DCDC3),
 		.enable_val = ENABLE_MASK(RK817_ID_DCDC3),
 		.disable_val = DISABLE_VAL(RK817_ID_DCDC3),
+		.ramp_reg = RK817_BUCK_CONFIG_REG(RK817_ID_DCDC3),
+		.ramp_mask = RK817_RAMP_RATE_MASK,
+		.ramp_delay_table = rk817_buck1_4_ramp_table,
+		.n_ramp_values = ARRAY_SIZE(rk817_buck1_4_ramp_table),
 		.of_map_mode = rk8xx_regulator_of_map_mode,
 		.owner = THIS_MODULE,
 	}, {
@@ -1109,6 +1091,10 @@ static const struct regulator_desc rk817_reg[] = {
 		.enable_mask = ENABLE_MASK(RK817_ID_DCDC4),
 		.enable_val = ENABLE_MASK(RK817_ID_DCDC4),
 		.disable_val = DISABLE_VAL(RK817_ID_DCDC4),
+		.ramp_reg = RK817_BUCK_CONFIG_REG(RK817_ID_DCDC4),
+		.ramp_mask = RK817_RAMP_RATE_MASK,
+		.ramp_delay_table = rk817_buck1_4_ramp_table,
+		.n_ramp_values = ARRAY_SIZE(rk817_buck1_4_ramp_table),
 		.of_map_mode = rk8xx_regulator_of_map_mode,
 		.owner = THIS_MODULE,
 	},
-- 
2.25.1

