Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C5B39B88F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFDL77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhFDL76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:59:58 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62734C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 04:58:12 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id l1so7710211pgm.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 04:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K3tnnsTYL2fMn05CikOvb7zxEykYQg4m0Hbaz0LMYTI=;
        b=jE49HBBvu3acO6dFHc4AhE4D8Ec3P/uiwzI2EtrH3k1OiiKpZtkGvQJMZ6Ak2Az+lJ
         PDu2JrwA5C3IzYcxDGzAHF5KaZZoKHbW8QXZC6BEfv9WLjUsGAm9XEKEX1xu0m3rPYI9
         5AhzDluiRFvBH5qbUQBQeO6PK7WxvTkUQfAjXjNxYS3x9NsCddtg+DuSMCeZWuLwRnKC
         q39r6RnYRspM1b+GM5YqsegZOYZXmV3XacnzGsgCXEqgmY1pYWEz4FWI4ON3OqhMHHA3
         CcMHYhpBR2BoXBF6Wr78YfyYxO6W8zklPOv3kYH7DPgZZ0ch27BtoTVZsldqLde9HJcm
         nWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K3tnnsTYL2fMn05CikOvb7zxEykYQg4m0Hbaz0LMYTI=;
        b=Fnz0AapW+lgN/5Ore0SWGa8alRzr9CEzm1M41ECnl/GdvtcZsmlbABCd9vzty1zpD6
         lLgou22JiRxXsvCnKAj6l53miRubYV/DA2MpWR3ohPRwQoA3hCadVQWgBJBhXHEgRFmv
         EejvRcncQs5hs1g7wGCS41KMcWEpo/QPh1Siu2lMAqLbliqwqRuFJUbExtVBdTZ1uH6k
         4/BSVZCQMq6rmTMs1b07O97rSS0TGGpBzYpZQOtjKGTtF405uq2hgdh7EUF0Q1RZUUy9
         kSItRKRn+3Ke2DOQSv6hdSyTtw6Kvqlm6F3S083trF5RbtWTLSrg1P3gJEj87scsc4zP
         z08w==
X-Gm-Message-State: AOAM530dbZqy7tmV0vliMJUpeBwkydnSMw7uXlmgafcUfAoKddn3luxL
        QnnbbOIJCoAWwKYmZlGLas/wcg==
X-Google-Smtp-Source: ABdhPJzn5f6Ff9D+X6ZkBlqpRmokS5a/o38xoKLhJ4c1fpMmrr5+eyobC/fV5gp+MUE5GwcLfVOIvg==
X-Received: by 2002:a05:6a00:ac9:b029:2de:a06d:a52f with SMTP id c9-20020a056a000ac9b02902dea06da52fmr4486744pfl.4.1622807891730;
        Fri, 04 Jun 2021 04:58:11 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id h6sm4534516pjs.15.2021.06.04.04.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 04:58:11 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bernhard Walle <bernhard@bwalle.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: ltc3589: Convert to use regulator_set_ramp_delay_regmap
Date:   Fri,  4 Jun 2021 19:58:03 +0800
Message-Id: <20210604115803.1260976-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set_ramp_delay_regmap instead of open-coded

LTC3589_LINEAR_REG() no longer call LTC3589_REG() now.
Only LTC3589_LINEAR_REG() needs to set go_bit, thus remove go_bit
parameter from LTC3589_REG() macro.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/ltc3589.c | 73 +++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c
index 38f7ccb63b52..5e0b669c3a01 100644
--- a/drivers/regulator/ltc3589.c
+++ b/drivers/regulator/ltc3589.c
@@ -54,6 +54,11 @@
 #define LTC3589_VCCR_SW3_GO		BIT(4)
 #define LTC3589_VCCR_LDO2_GO		BIT(6)
 
+#define LTC3589_VRRCR_SW1_RAMP_MASK	GENMASK(1, 0)
+#define LTC3589_VRRCR_SW2_RAMP_MASK	GENMASK(3, 2)
+#define LTC3589_VRRCR_SW3_RAMP_MASK	GENMASK(5, 4)
+#define LTC3589_VRRCR_LDO2_RAMP_MASK	GENMASK(7, 6)
+
 enum ltc3589_variant {
 	LTC3589,
 	LTC3589_1,
@@ -88,27 +93,9 @@ static const int ltc3589_12_ldo4[] = {
 	1200000, 1800000, 2500000, 3200000,
 };
 
-static int ltc3589_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
-{
-	struct ltc3589 *ltc3589 = rdev_get_drvdata(rdev);
-	int sel, shift;
-
-	if (unlikely(ramp_delay <= 0))
-		return -EINVAL;
-
-	/* VRRCR slew rate offsets are the same as VCCR go bit offsets */
-	shift = ffs(rdev->desc->apply_bit) - 1;
-
-	/* The slew rate can be set to 0.88, 1.75, 3.5, or 7 mV/uS */
-	for (sel = 0; sel < 4; sel++) {
-		if ((880 << sel) >= ramp_delay) {
-			return regmap_update_bits(ltc3589->regmap,
-						  LTC3589_VRRCR,
-						  0x3 << shift, sel << shift);
-		}
-	}
-	return -EINVAL;
-}
+static const unsigned int ltc3589_ramp_table[] = {
+	880, 1750, 3500, 7000
+};
 
 static int ltc3589_set_suspend_voltage(struct regulator_dev *rdev, int uV)
 {
@@ -149,7 +136,7 @@ static const struct regulator_ops ltc3589_linear_regulator_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
-	.set_ramp_delay = ltc3589_set_ramp_delay,
+	.set_ramp_delay = regulator_set_ramp_delay_regmap,
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
 	.set_suspend_voltage = ltc3589_set_suspend_voltage,
 	.set_suspend_mode = ltc3589_set_suspend_mode,
@@ -218,16 +205,13 @@ static int ltc3589_of_parse_cb(struct device_node *np,
 	return 0;
 }
 
-#define LTC3589_REG(_name, _of_name, _ops, en_bit, dtv1_reg, dtv_mask, go_bit)\
+#define LTC3589_REG(_name, _of_name, _ops, en_bit, dtv1_reg, dtv_mask)	\
 	[LTC3589_ ## _name] = {						\
 		.name = #_name,						\
 		.of_match = of_match_ptr(#_of_name),			\
 		.regulators_node = of_match_ptr("regulators"),		\
 		.of_parse_cb = ltc3589_of_parse_cb,			\
 		.n_voltages = (dtv_mask) + 1,				\
-		.min_uV = (go_bit) ? 362500 : 0,			\
-		.uV_step = (go_bit) ? 12500 : 0,			\
-		.ramp_delay = (go_bit) ? 1750 : 0,			\
 		.fixed_uV = (dtv_mask) ? 0 : 800000,			\
 		.ops = &ltc3589_ ## _ops ## _regulator_ops,		\
 		.type = REGULATOR_VOLTAGE,				\
@@ -235,30 +219,49 @@ static int ltc3589_of_parse_cb(struct device_node *np,
 		.owner = THIS_MODULE,					\
 		.vsel_reg = (dtv1_reg),					\
 		.vsel_mask = (dtv_mask),				\
-		.apply_reg = (go_bit) ? LTC3589_VCCR : 0,		\
-		.apply_bit = (go_bit),					\
 		.enable_reg = (en_bit) ? LTC3589_OVEN : 0,		\
 		.enable_mask = (en_bit),				\
 	}
 
 #define LTC3589_LINEAR_REG(_name, _of_name, _dtv1)			\
-	LTC3589_REG(_name, _of_name, linear, LTC3589_OVEN_ ## _name,	\
-		    LTC3589_ ## _dtv1, 0x1f,				\
-		    LTC3589_VCCR_ ## _name ## _GO)
+	[LTC3589_ ## _name] = {						\
+		.name = #_name,						\
+		.of_match = of_match_ptr(#_of_name),			\
+		.regulators_node = of_match_ptr("regulators"),		\
+		.of_parse_cb = ltc3589_of_parse_cb,			\
+		.n_voltages = 32,					\
+		.min_uV = 362500,					\
+		.uV_step = 12500,					\
+		.ramp_delay = 1750,					\
+		.ops = &ltc3589_linear_regulator_ops,			\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = LTC3589_ ## _name,				\
+		.owner = THIS_MODULE,					\
+		.vsel_reg = LTC3589_ ## _dtv1,				\
+		.vsel_mask = 0x1f,					\
+		.apply_reg = LTC3589_VCCR,				\
+		.apply_bit = LTC3589_VCCR_ ## _name ## _GO,		\
+		.enable_reg = LTC3589_OVEN,				\
+		.enable_mask = (LTC3589_OVEN_ ## _name),		\
+		.ramp_reg = LTC3589_VRRCR,				\
+		.ramp_mask = LTC3589_VRRCR_ ## _name ## _RAMP_MASK,	\
+		.ramp_delay_table = ltc3589_ramp_table,			\
+		.n_ramp_values = ARRAY_SIZE(ltc3589_ramp_table),	\
+	}
+
 
 #define LTC3589_FIXED_REG(_name, _of_name)				\
-	LTC3589_REG(_name, _of_name, fixed, LTC3589_OVEN_ ## _name, 0, 0, 0)
+	LTC3589_REG(_name, _of_name, fixed, LTC3589_OVEN_ ## _name, 0, 0)
 
 static const struct regulator_desc ltc3589_regulators[] = {
 	LTC3589_LINEAR_REG(SW1, sw1, B1DTV1),
 	LTC3589_LINEAR_REG(SW2, sw2, B2DTV1),
 	LTC3589_LINEAR_REG(SW3, sw3, B3DTV1),
 	LTC3589_FIXED_REG(BB_OUT, bb-out),
-	LTC3589_REG(LDO1, ldo1, fixed_standby, 0, 0, 0, 0),
+	LTC3589_REG(LDO1, ldo1, fixed_standby, 0, 0, 0),
 	LTC3589_LINEAR_REG(LDO2, ldo2, L2DTV1),
 	LTC3589_FIXED_REG(LDO3, ldo3),
-	LTC3589_REG(LDO4, ldo4, table, LTC3589_OVEN_LDO4, LTC3589_L2DTV2,
-		    0x60, 0),
+	LTC3589_REG(LDO4, ldo4, table, LTC3589_OVEN_LDO4, LTC3589_L2DTV2, 0x60),
 };
 
 static bool ltc3589_writeable_reg(struct device *dev, unsigned int reg)
-- 
2.25.1

