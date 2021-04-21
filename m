Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB7636748D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 23:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245710AbhDUVEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 17:04:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38272 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243802AbhDUVEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 17:04:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 54FCA1F42641
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Joseph Chen <chenjh@rock-chips.com>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 3/3] regulator: fan53555: Add TCS4525 DCDC support
Date:   Wed, 21 Apr 2021 18:03:38 -0300
Message-Id: <20210421210338.43819-3-ezequiel@collabora.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210421210338.43819-1-ezequiel@collabora.com>
References: <20210421210338.43819-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joseph Chen <chenjh@rock-chips.com>

TCS4525 main features:

- 2.7V to 5.5V Input Voltage Range;
- 3MHz Constant Switching Frequency;
- 5A Available Load Current;
- Programmable Output Voltage: 0.6V to 1.4V in 6.25mV Steps;
- PFM/PWM Operation for Optimum Increased Efficiency;

Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
[Ezequiel: Forward port]
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/regulator/fan53555.c | 136 +++++++++++++++++++++++++++++++----
 1 file changed, 122 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index aa426183b6a1..f3918f03aaf3 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -24,6 +24,12 @@
 /* Voltage setting */
 #define FAN53555_VSEL0		0x00
 #define FAN53555_VSEL1		0x01
+
+#define TCS4525_VSEL0		0x11
+#define TCS4525_VSEL1		0x10
+#define TCS4525_TIME		0x13
+#define TCS4525_COMMAND		0x14
+
 /* Control register */
 #define FAN53555_CONTROL	0x02
 /* IC Type */
@@ -49,11 +55,20 @@
 
 #define FAN53555_NVOLTAGES	64	/* Numbers of voltages */
 #define FAN53526_NVOLTAGES	128
+#define TCS4525_NVOLTAGES	127	/* Numbers of voltages */
+
+#define TCS_VSEL_NSEL_MASK	0x7f
+#define TCS_VSEL0_MODE		(1 << 7)
+#define TCS_VSEL1_MODE		(1 << 6)
+
+#define TCS_SLEW_SHIFT		3
+#define TCS_SLEW_MASK		(0x3 < 3)
 
 enum fan53555_vendor {
 	FAN53526_VENDOR_FAIRCHILD = 0,
 	FAN53555_VENDOR_FAIRCHILD,
 	FAN53555_VENDOR_SILERGY,
+	FAN53555_VENDOR_TCS,
 };
 
 enum {
@@ -106,6 +121,11 @@ struct fan53555_device_info {
 	unsigned int mode_mask;
 	/* Sleep voltage cache */
 	unsigned int sleep_vol_cache;
+	/* Slew rate */
+	unsigned int slew_reg;
+	unsigned int slew_mask;
+	unsigned int slew_shift;
+	unsigned int slew_rate;
 };
 
 static int fan53555_set_suspend_voltage(struct regulator_dev *rdev, int uV)
@@ -189,13 +209,37 @@ static const int slew_rates[] = {
 	  500,
 };
 
+static const int tcs_slew_rates[] = {
+	18700,
+	 9300,
+	 4600,
+	 2300,
+};
+
 static int fan53555_set_ramp(struct regulator_dev *rdev, int ramp)
 {
 	struct fan53555_device_info *di = rdev_get_drvdata(rdev);
 	int regval = -1, i;
+	const int *slew_rate_t;
+	int slew_rate_n;
 
-	for (i = 0; i < ARRAY_SIZE(slew_rates); i++) {
-		if (ramp <= slew_rates[i])
+	switch (di->vendor) {
+	case FAN53526_VENDOR_FAIRCHILD:
+	case FAN53555_VENDOR_FAIRCHILD:
+	case FAN53555_VENDOR_SILERGY:
+		slew_rate_t = slew_rates;
+		slew_rate_n = ARRAY_SIZE(slew_rates);
+		break;
+	case FAN53555_VENDOR_TCS:
+		slew_rate_t = tcs_slew_rates;
+		slew_rate_n = ARRAY_SIZE(tcs_slew_rates);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (i = 0; i < slew_rate_n; i++) {
+		if (ramp <= slew_rate_t[i])
 			regval = i;
 		else
 			break;
@@ -206,8 +250,8 @@ static int fan53555_set_ramp(struct regulator_dev *rdev, int ramp)
 		return -EINVAL;
 	}
 
-	return regmap_update_bits(rdev->regmap, FAN53555_CONTROL,
-				  CTL_SLEW_MASK, regval << CTL_SLEW_SHIFT);
+	return regmap_update_bits(rdev->regmap, di->slew_reg,
+				  di->slew_mask, regval << di->slew_shift);
 }
 
 static const struct regulator_ops fan53555_regulator_ops = {
@@ -292,7 +336,9 @@ static int fan53555_voltages_setup_fairchild(struct fan53555_device_info *di)
 			"Chip ID %d not supported!\n", di->chip_id);
 		return -EINVAL;
 	}
-
+	di->slew_reg = FAN53555_CONTROL;
+	di->slew_mask = CTL_SLEW_MASK;
+	di->slew_shift = CTL_SLEW_SHIFT;
 	di->vsel_count = FAN53555_NVOLTAGES;
 
 	return 0;
@@ -312,12 +358,29 @@ static int fan53555_voltages_setup_silergy(struct fan53555_device_info *di)
 			"Chip ID %d not supported!\n", di->chip_id);
 		return -EINVAL;
 	}
-
+	di->slew_reg = FAN53555_CONTROL;
+	di->slew_reg = FAN53555_CONTROL;
+	di->slew_mask = CTL_SLEW_MASK;
+	di->slew_shift = CTL_SLEW_SHIFT;
 	di->vsel_count = FAN53555_NVOLTAGES;
 
 	return 0;
 }
 
+static int fan53555_voltages_setup_tcs(struct fan53555_device_info *di)
+{
+	di->slew_reg = TCS4525_TIME;
+	di->slew_mask = TCS_SLEW_MASK;
+	di->slew_shift = TCS_SLEW_MASK;
+
+	/* Init voltage range and step */
+	di->vsel_min = 600000;
+	di->vsel_step = 6250;
+	di->vsel_count = TCS4525_NVOLTAGES;
+
+	return 0;
+}
+
 /* For 00,01,03,05 options:
  * VOUT = 0.60V + NSELx * 10mV, from 0.60 to 1.23V.
  * For 04 option:
@@ -329,17 +392,41 @@ static int fan53555_device_setup(struct fan53555_device_info *di,
 	int ret = 0;
 
 	/* Setup voltage control register */
-	switch (pdata->sleep_vsel_id) {
-	case FAN53555_VSEL_ID_0:
-		di->sleep_reg = FAN53555_VSEL0;
-		di->vol_reg = FAN53555_VSEL1;
+	switch (di->vendor) {
+	case FAN53526_VENDOR_FAIRCHILD:
+	case FAN53555_VENDOR_FAIRCHILD:
+	case FAN53555_VENDOR_SILERGY:
+		switch (pdata->sleep_vsel_id) {
+		case FAN53555_VSEL_ID_0:
+			di->sleep_reg = FAN53555_VSEL0;
+			di->vol_reg = FAN53555_VSEL1;
+			break;
+		case FAN53555_VSEL_ID_1:
+			di->sleep_reg = FAN53555_VSEL1;
+			di->vol_reg = FAN53555_VSEL0;
+			break;
+		default:
+			dev_err(di->dev, "Invalid VSEL ID!\n");
+			return -EINVAL;
+		}
 		break;
-	case FAN53555_VSEL_ID_1:
-		di->sleep_reg = FAN53555_VSEL1;
-		di->vol_reg = FAN53555_VSEL0;
+	case FAN53555_VENDOR_TCS:
+		switch (pdata->sleep_vsel_id) {
+		case FAN53555_VSEL_ID_0:
+			di->sleep_reg = TCS4525_VSEL0;
+			di->vol_reg = TCS4525_VSEL1;
+			break;
+		case FAN53555_VSEL_ID_1:
+			di->sleep_reg = TCS4525_VSEL1;
+			di->vol_reg = TCS4525_VSEL0;
+			break;
+		default:
+			dev_err(di->dev, "Invalid VSEL ID!\n");
+			return -EINVAL;
+		}
 		break;
 	default:
-		dev_err(di->dev, "Invalid VSEL ID!\n");
+		dev_err(di->dev, "vendor %d not supported!\n", di->vendor);
 		return -EINVAL;
 	}
 
@@ -362,6 +449,18 @@ static int fan53555_device_setup(struct fan53555_device_info *di,
 		di->mode_reg = di->vol_reg;
 		di->mode_mask = VSEL_MODE;
 		break;
+	case FAN53555_VENDOR_TCS:
+		di->mode_reg = TCS4525_COMMAND;
+
+		switch (pdata->sleep_vsel_id) {
+		case FAN53555_VSEL_ID_0:
+			di->mode_mask = TCS_VSEL1_MODE;
+			break;
+		case FAN53555_VSEL_ID_1:
+			di->mode_mask = TCS_VSEL0_MODE;
+			break;
+		}
+		break;
 	default:
 		dev_err(di->dev, "vendor %d not supported!\n", di->vendor);
 		return -EINVAL;
@@ -378,6 +477,9 @@ static int fan53555_device_setup(struct fan53555_device_info *di,
 	case FAN53555_VENDOR_SILERGY:
 		ret = fan53555_voltages_setup_silergy(di);
 		break;
+	case FAN53555_VENDOR_TCS:
+		ret = fan53555_voltages_setup_tcs(di);
+		break;
 	default:
 		dev_err(di->dev, "vendor %d not supported!\n", di->vendor);
 		return -EINVAL;
@@ -449,6 +551,9 @@ static const struct of_device_id __maybe_unused fan53555_dt_ids[] = {
 	}, {
 		.compatible = "silergy,syr828",
 		.data = (void *)FAN53555_VENDOR_SILERGY,
+	}, {
+		.compatible = "tcs,tcs4525",
+		.data = (void *)FAN53555_VENDOR_TCS
 	},
 	{ }
 };
@@ -554,6 +659,9 @@ static const struct i2c_device_id fan53555_id[] = {
 	}, {
 		.name = "syr828",
 		.driver_data = FAN53555_VENDOR_SILERGY
+	}, {
+		.name = "tcs4525",
+		.driver_data = FAN53555_VENDOR_TCS
 	},
 	{ },
 };
-- 
2.30.0

