Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9457338FF60
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhEYKis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhEYKi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:38:26 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F109C06134B
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:36:20 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x188so23268140pfd.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5q0a7RIAbFdOKfwwNAVfPgzNypI9PUi1OPyg/ZVZJ7I=;
        b=WSDnuzglZJ8ilnGmWF5HkQi0y3npgaKOQ/vI6vUVhZNRreRAyaDaLtHKnX2BCHzEcw
         9pwvfckkL0sPejnNkUVJJ5y3B5U7Sswsk8FQZCPSfKirejI/FfA1g8zt/NtEaCkZC69p
         KJW2h/VE33600rY9/Zcn53v3QYPvaE9JKcl1BAR//4RKbOFBW4Lxe0mElPUf1x/7/F6q
         jEvZK34dskElCM7h5kLucvo8HE53YGoV9eDTRXI8ntIQH8PYnByUKHE2vlQQR/cIUuCg
         qHoe2l0cMHczwSHigPVCfdvwvVoHxT12M8sC1Q+Mtb5fPbHZH7716YQ5pmJarF3lxhGl
         CqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5q0a7RIAbFdOKfwwNAVfPgzNypI9PUi1OPyg/ZVZJ7I=;
        b=EicQJnFdZMc20vjsvS9vP1o5pedwbAOuK3ekZGTwZROm+GO2Fw5/4b5OuCkUzXN/Ax
         SEVp/vUnatlF/1WfIBgSz3JmM3nJ9TScOrW84EQRtnXqj+WhdWEv6TdnZbylMhRmgp8Q
         MvaFZLJVvz98vLMxeYOq/RvjLIizx3+mu3UKDtpbKlFAPPdscZ8kpV3Ga0YBgTqWF9m9
         a8C5X6Mo8hpbS6QF6ylyC616WxQ2Q9Jqu75RVH737PsNYVGVpIE29wUetyVclLbE3CUJ
         Ach3oOqM/0tluRNan9QAca2ECW2pEbMYKMRYWpk6HhVFojzlLCEyXImNOsA7A2S+HkeL
         cBzw==
X-Gm-Message-State: AOAM532iGEybAl4v/dOx3TzNojHyyasH7IbOptLucoNL3Rz87tiRq7Qr
        Cf4HStwo3utzCNxMaRzE2C3CCw==
X-Google-Smtp-Source: ABdhPJyTxMvTGTFAkuot7TQDC++RHwKNcc1E94yOdB3qaxiP6GZYL9PKO5+7w6fUpXUA/G3sNO1yVg==
X-Received: by 2002:a63:1c52:: with SMTP id c18mr18634190pgm.258.1621938979518;
        Tue, 25 May 2021 03:36:19 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id f17sm13924868pgi.26.2021.05.25.03.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:36:18 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Zhong <zyw@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: rk808: Convert to use regulator_set_ramp_delay_regmap
Date:   Tue, 25 May 2021 18:34:59 +0800
Message-Id: <20210525103459.2525197-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set_ramp_delay_regmap instead of open-coded.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/rk808-regulator.c | 109 +++++++++++++---------------
 1 file changed, 51 insertions(+), 58 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index e926c1a85846..2362a3696c64 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -215,6 +215,15 @@ static const struct linear_range rk817_buck3_voltage_ranges[] = {
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
@@ -340,62 +349,6 @@ static int rk808_buck1_2_set_voltage_time_sel(struct regulator_dev *rdev,
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
@@ -625,7 +578,7 @@ static const struct regulator_ops rk808_buck1_2_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
-	.set_ramp_delay		= rk808_set_ramp_delay,
+	.set_ramp_delay		= regulator_set_ramp_delay_regmap,
 	.set_suspend_voltage	= rk808_set_suspend_voltage,
 	.set_suspend_enable	= rk808_set_suspend_enable,
 	.set_suspend_disable	= rk808_set_suspend_disable,
@@ -722,7 +675,7 @@ static const struct regulator_ops rk817_buck_ops_range = {
 	.set_mode		= rk8xx_set_mode,
 	.get_mode		= rk8xx_get_mode,
 	.set_suspend_mode	= rk8xx_set_suspend_mode,
-	.set_ramp_delay		= rk817_set_ramp_delay,
+	.set_ramp_delay		= regulator_set_ramp_delay_regmap,
 	.set_suspend_voltage	= rk808_set_suspend_voltage_range,
 	.set_suspend_enable	= rk817_set_suspend_enable,
 	.set_suspend_disable	= rk817_set_suspend_disable,
@@ -814,6 +767,10 @@ static const struct regulator_desc rk808_reg[] = {
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
@@ -830,6 +787,10 @@ static const struct regulator_desc rk808_reg[] = {
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
@@ -910,6 +871,10 @@ static const struct regulator_desc rk809_reg[] = {
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
@@ -929,6 +894,10 @@ static const struct regulator_desc rk809_reg[] = {
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
@@ -948,6 +917,10 @@ static const struct regulator_desc rk809_reg[] = {
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
@@ -967,6 +940,10 @@ static const struct regulator_desc rk809_reg[] = {
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
@@ -1052,6 +1029,10 @@ static const struct regulator_desc rk817_reg[] = {
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
@@ -1071,6 +1052,10 @@ static const struct regulator_desc rk817_reg[] = {
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
@@ -1090,6 +1075,10 @@ static const struct regulator_desc rk817_reg[] = {
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
@@ -1109,6 +1098,10 @@ static const struct regulator_desc rk817_reg[] = {
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

