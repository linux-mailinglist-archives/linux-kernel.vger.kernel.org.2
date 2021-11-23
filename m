Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF2145B031
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 00:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240583AbhKWXb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 18:31:26 -0500
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:54056
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240542AbhKWXbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 18:31:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOPAjpk6SGeOh1KfqfeZGvYBC2e6joKARKO+WbIHRlnoVod3gj7sSexxfrWdGb+mwj1zBS+YhnHWwXmWXPItenGvIZqvqmIu1hkCp15RLWXpWaqeF0fUQOxl6rQcOHcmkEulxNRLK9rYnvghfot4ibBotBKDHcX88t7bwW0Be7oRUdK34OPMk2m/F9Lzwz1RecG3F2+DFQtqWvtIvvv0RoH2+QtvxUikDpkxWoHk5gtv/aXgbCkJNH0rFveehLu2CYgt9bCvKVK4bt4yU/UlXTogTpqnn44VLYa6K3NE735zaU739jJhL48cJ4PEGWVzmkkTSJeO4GGi8uWgb+o25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/ha1+c67a/MkuyNOmBgTKqCP9/lyjvuySmEP/NFFUk=;
 b=F62zlNbZX8MtcHoyPnjRMZVhXplKKMdZFiXwVdKbKdgUVK6dTDDEPTNflNNtrpnpczkAAnU4A/OttVQ2SGk+CZ7/RRIh1CyLtBl4JTIYP6ybOEpdtPDa7IiXqhCNOKHrL4NpQKf+h1gRt0PbPnKeGqPbImdJnlVHUuuhh0Ru/N2Zl4GzaCRangg4MS4GEdjQUmxn5e7oAG34n6lB/Npq1TrBHDkB+zBpVGsNTxYhC/IjSsyiJke/7OeSv8wxMNmq9w6Yux60f3ZnIw01kuKc0qGrH+6o8BUOq5a5a9821wkjG9lNEe4m//17MsZSIJAH8H+ANx7ulsxeJXe68ZV4JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=gmail.com smtp.mailfrom=diasemi.com;
 dmarc=none action=none header.from=diasemi.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/ha1+c67a/MkuyNOmBgTKqCP9/lyjvuySmEP/NFFUk=;
 b=Ha/eYjVQ2Aqw1dDKcmwTJrhVoDdQz2rUT/3tksyTs0gTLx/bmHLqK6I4Ib3yqhvvib1frsYI560Oed1JkE53XPmJ/8W32pD3E/wIeVA5ZchvcN/n7MzkYl8zD8puB7VMQ7bEmaCJIa5fApxzZE86EsHE7bVogVDBPO6F9EZIoh4=
Received: from AM0PR10CA0036.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::16)
 by DU2PR10MB5062.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 23:27:59 +0000
Received: from AM5EUR02FT041.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:150:cafe::54) by AM0PR10CA0036.outlook.office365.com
 (2603:10a6:20b:150::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Tue, 23 Nov 2021 23:27:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT041.mail.protection.outlook.com (10.152.9.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.23 via Frontend Transport; Tue, 23 Nov 2021 23:27:58 +0000
Received: from nbsrvex-01v.diasemi.com (10.1.17.243) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 24 Nov 2021 00:27:58 +0100
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 24 Nov 2021 00:27:58 +0100
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)
        id 0FE2D80007F; Tue, 23 Nov 2021 23:27:58 +0000 (UTC)
Message-ID: <31d387d0a364eef9d5ef72f0adf6d213197a4dfb.1637709844.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1637709844.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1637709844.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 23 Nov 2021 23:27:58 +0000
Subject: [PATCH V3 3/3] regulator: da9121: Add DA914x support
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9077f20-988d-4c3b-bdca-08d9aed8e28e
X-MS-TrafficTypeDiagnostic: DU2PR10MB5062:
X-Microsoft-Antispam-PRVS: <DU2PR10MB5062A70A180DED6168B700FCCB609@DU2PR10MB5062.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7wkl7rcX3xZ2X5QBWAyFqGKxCDlp3kMBGxqkKINxDrUbTAYhQQvdha0eTmX54AF4WfxFGEyHeKZ9yummu8IIlT6ce1HRat+bVg268NE5Fy4N3GgjGBz1YbkdKAzEPqXYZrgNY+yiTgPQgPCDe7foy6Bo6j32iVkiLqcQQMn2lXfTMuDHaT5txhcXSVgcdMEz6NY2kwg4WO5btCdiT9/onUfRlUDJqq/C1JgWipCfOdFYqxOiwjufZXOPCAhBKL5p4U16L0o+uird5kFyGCqkfbOw7T3CnLJjVRsBB4gjmqqTan3kxZz6Xb2eofz6gD/wZJYjcl+NmlZv1k5Mm4bGUCjerOUbT8Mhvoyojff3jW3l2E56Wxbv9sfqCId3lIuPhP41Jgvo1tSI1wlTBXTDvZC6eVIBLjw9giSqmrEuoKgv4TftzD8qIh/1dl5dsP+IB7moINHUkj8/Yi6dbT/RZFj/6bGRixMvLGLTuMlJBnV2fKADLH3l1uEcG23FUFyhW6vjRjtyz3BeVOqMYuYZiCciOjw+iWTHvm/wofVFr1xB/NHO3h4nJpIcPzYcn9I34eZssflqeteKROjYLdV2W0mdLle+SIKf0uoxidWmuyyvUQ7/J93PUW0FnTBWgF3DJygO6lS+Z9YlLjSytvcjoy8icSIDRwDEn41K2r1eB455FHIBBYKA0TsgTBd4NaV6WY1HNpHNFmH4SRQAsAmylSfOi4iT/RC+QYDBgix5nQ=
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(356005)(2616005)(81166007)(5660300002)(36756003)(6266002)(426003)(82310400004)(186003)(336012)(47076005)(54906003)(83380400001)(107886003)(36860700001)(4326008)(8676002)(2906002)(70586007)(8936002)(42186006)(508600001)(86362001)(316002)(26005)(70206006)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 23:27:58.6350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9077f20-988d-4c3b-bdca-08d9aed8e28e
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT041.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB5062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 113 ++++++++++++++++++++++++++-
 drivers/regulator/da9121-regulator.h |  21 ++++-
 2 files changed, 129 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index a5a83b772a85..c497b82fb518 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -86,6 +86,22 @@ static struct da9121_range da9121_3A_1phase_current = {
 	.reg_max = 6,
 };
 
+static struct da9121_range da914x_40A_4phase_current = {
+	.val_min = 14000000,
+	.val_max = 80000000,
+	.val_stp =  2000000,
+	.reg_min = 1,
+	.reg_max = 14,
+};
+
+static struct da9121_range da914x_20A_2phase_current = {
+	.val_min =  7000000,
+	.val_max = 40000000,
+	.val_stp =  2000000,
+	.reg_min = 1,
+	.reg_max = 14,
+};
+
 struct da9121_variant_info {
 	int num_bucks;
 	int num_phases;
@@ -97,6 +113,8 @@ static const struct da9121_variant_info variant_parameters[] = {
 	{ 2, 1, &da9121_3A_1phase_current  },	//DA9121_TYPE_DA9220_DA9132
 	{ 2, 1, &da9121_5A_1phase_current  },	//DA9121_TYPE_DA9122_DA9131
 	{ 1, 2, &da9121_6A_2phase_current  },	//DA9121_TYPE_DA9217
+	{ 1, 4, &da914x_40A_4phase_current },   //DA9121_TYPE_DA9141
+	{ 1, 2, &da914x_20A_2phase_current },   //DA9121_TYPE_DA9142
 };
 
 struct da9121_field {
@@ -253,6 +271,11 @@ static int da9121_set_current_limit(struct regulator_dev *rdev,
 		goto error;
 	}
 
+	if (rdev->desc->ops->is_enabled(rdev)) {
+		ret = -EBUSY;
+		goto error;
+	}
+
 	ret = da9121_ceiling_selector(rdev, min_ua, max_ua, &sel);
 	if (ret < 0)
 		goto error;
@@ -537,11 +560,65 @@ static const struct regulator_desc da9217_reg = {
 	.vsel_mask = DA9121_MASK_BUCK_BUCKx_5_CHx_A_VOUT,
 };
 
+#define DA914X_MIN_MV		500
+#define DA914X_MAX_MV		1000
+#define DA914X_STEP_MV		10
+#define DA914X_MIN_SEL		(DA914X_MIN_MV / DA914X_STEP_MV)
+#define DA914X_N_VOLTAGES	(((DA914X_MAX_MV - DA914X_MIN_MV) / DA914X_STEP_MV) \
+				 + 1 + DA914X_MIN_SEL)
+
+static const struct regulator_desc da9141_reg = {
+	.id = DA9141_IDX_BUCK1,
+	.name = "DA9141",
+	.of_match = "buck1",
+	.of_parse_cb = da9121_of_parse_cb,
+	.owner = THIS_MODULE,
+	.regulators_node = of_match_ptr("regulators"),
+	.of_map_mode = da9121_map_mode,
+	.ops = &da9121_buck_ops,
+	.type = REGULATOR_VOLTAGE,
+	.n_voltages = DA914X_N_VOLTAGES,
+	.min_uV = DA914X_MIN_MV * 1000,
+	.uV_step = DA914X_STEP_MV * 1000,
+	.linear_min_sel = DA914X_MIN_SEL,
+	.vsel_reg = DA9121_REG_BUCK_BUCK1_5,
+	.vsel_mask = DA9121_MASK_BUCK_BUCKx_5_CHx_A_VOUT,
+	.enable_reg = DA9121_REG_BUCK_BUCK1_0,
+	.enable_mask = DA9121_MASK_BUCK_BUCKx_0_CHx_EN,
+	/* Default value of BUCK_BUCK1_0.CH1_SRC_DVC_UP */
+	.ramp_delay = 20000,
+	/* tBUCK_EN */
+	.enable_time = 20,
+};
+
+static const struct regulator_desc da9142_reg = {
+	.id = DA914X_IDX_BUCK1,
+	.name = "DA9142 BUCK1",
+	.of_match = "buck1",
+	.of_parse_cb = da9121_of_parse_cb,
+	.owner = THIS_MODULE,
+	.regulators_node = of_match_ptr("regulators"),
+	.of_map_mode = da9121_map_mode,
+	.ops = &da9121_buck_ops,
+	.type = REGULATOR_VOLTAGE,
+	.n_voltages = DA914X_N_VOLTAGES,
+	.min_uV = DA914X_MIN_MV * 1000,
+	.uV_step = DA914X_STEP_MV * 1000,
+	.linear_min_sel = DA914X_MIN_SEL,
+	.enable_reg = DA9121_REG_BUCK_BUCK1_0,
+	.enable_mask = DA9121_MASK_BUCK_BUCKx_0_CHx_EN,
+	.vsel_reg = DA9121_REG_BUCK_BUCK1_5,
+	.vsel_mask = DA9121_MASK_BUCK_BUCKx_5_CHx_A_VOUT,
+};
+
+
 static const struct regulator_desc *local_da9121_regulators[][DA9121_IDX_MAX] = {
 	[DA9121_TYPE_DA9121_DA9130] = { &da9121_reg, NULL },
 	[DA9121_TYPE_DA9220_DA9132] = { &da9220_reg[0], &da9220_reg[1] },
 	[DA9121_TYPE_DA9122_DA9131] = { &da9122_reg[0], &da9122_reg[1] },
 	[DA9121_TYPE_DA9217] = { &da9217_reg, NULL },
+	[DA9121_TYPE_DA9141] = { &da9141_reg, NULL },
+	[DA9121_TYPE_DA9142] = { &da9142_reg, NULL },
 };
 
 static void da9121_status_poll_on(struct work_struct *work)
@@ -835,7 +912,7 @@ static int da9121_check_device_type(struct i2c_client *i2c, struct da9121 *chip)
 		goto error;
 	}
 
-	if (device_id != DA9121_DEVICE_ID) {
+	if ((device_id != DA9121_DEVICE_ID) && (device_id != DA914X_DEVICE_ID) {
 		dev_err(chip->dev, "Invalid device ID: 0x%02x\n", device_id);
 		ret = -ENODEV;
 		goto error;
@@ -877,6 +954,22 @@ static int da9121_check_device_type(struct i2c_client *i2c, struct da9121 *chip)
 		break;
 	}
 
+	if (device_id == DA914X_DEVICE_ID) {
+		switch (chip->subvariant_id) {
+		case DA9121_SUBTYPE_DA9141:
+			type = "DA9141";
+			config_match = (variant_vrc == DA9141_VARIANT_VRC);
+			break;
+		case DA9121_SUBTYPE_DA9142:
+			type = "DA9142";
+			config_match = (variant_vrc == DA9142_VARIANT_VRC);
+			break;
+		default:
+			type = "Unknown";
+			break;
+		}
+	}
+
 	dev_info(chip->dev,
 		 "Device detected (device-ID: 0x%02X, var-ID: 0x%02X, %s)\n",
 		 device_id, variant_id, type);
@@ -890,8 +983,10 @@ static int da9121_check_device_type(struct i2c_client *i2c, struct da9121 *chip)
 	variant_mrc = (variant_id & DA9121_MASK_OTP_VARIANT_ID_MRC)
 			>> DA9121_SHIFT_OTP_VARIANT_ID_MRC;
 
-	if ((device_id == DA9121_DEVICE_ID) &&
-	    (variant_mrc < DA9121_VARIANT_MRC_BASE)) {
+	if (((device_id == DA9121_DEVICE_ID) &&
+	     (variant_mrc < DA9121_VARIANT_MRC_BASE)) ||
+	    ((device_id == DA914X_DEVICE_ID) &&
+	     (variant_mrc != DA9141_VARIANT_MRC_BASE))) {
 		dev_err(chip->dev,
 			"Cannot support variant MRC: 0x%02X\n", variant_mrc);
 		ret = -EINVAL;
@@ -931,6 +1026,14 @@ static int da9121_assign_chip_model(struct i2c_client *i2c,
 		chip->variant_id = DA9121_TYPE_DA9220_DA9132;
 		regmap = &da9121_2ch_regmap_config;
 		break;
+	case DA9121_SUBTYPE_DA9141:
+		chip->variant_id = DA9121_TYPE_DA9141;
+		regmap = &da9121_1ch_regmap_config;
+		break;
+	case DA9121_SUBTYPE_DA9142:
+		chip->variant_id = DA9121_TYPE_DA9142;
+		regmap = &da9121_2ch_regmap_config;
+		break;
 	}
 
 	/* Set these up for of_regulator_match call which may want .of_map_modes */
@@ -1010,6 +1113,8 @@ static const struct of_device_id da9121_dt_ids[] = {
 	{ .compatible = "dlg,da9131", .data = (void *) DA9121_SUBTYPE_DA9131 },
 	{ .compatible = "dlg,da9220", .data = (void *) DA9121_SUBTYPE_DA9220 },
 	{ .compatible = "dlg,da9132", .data = (void *) DA9121_SUBTYPE_DA9132 },
+	{ .compatible = "dlg,da9141", .data = (void *) DA9121_SUBTYPE_DA9141 },
+	{ .compatible = "dlg,da9142", .data = (void *) DA9121_SUBTYPE_DA9142 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, da9121_dt_ids);
@@ -1084,6 +1189,8 @@ static const struct i2c_device_id da9121_i2c_id[] = {
 	{"da9131", DA9121_TYPE_DA9122_DA9131},
 	{"da9220", DA9121_TYPE_DA9220_DA9132},
 	{"da9132", DA9121_TYPE_DA9220_DA9132},
+	{"da9141", DA9121_TYPE_DA9141},
+	{"da9142", DA9121_TYPE_DA9142},
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, da9121_i2c_id);
diff --git a/drivers/regulator/da9121-regulator.h b/drivers/regulator/da9121-regulator.h
index 357f416e17c1..a328a0bdfa29 100644
--- a/drivers/regulator/da9121-regulator.h
+++ b/drivers/regulator/da9121-regulator.h
@@ -26,7 +26,9 @@ enum da9121_variant {
 	DA9121_TYPE_DA9121_DA9130,
 	DA9121_TYPE_DA9220_DA9132,
 	DA9121_TYPE_DA9122_DA9131,
-	DA9121_TYPE_DA9217
+	DA9121_TYPE_DA9217,
+	DA9121_TYPE_DA9141,
+	DA9121_TYPE_DA9142
 };
 
 enum da9121_subvariant {
@@ -36,7 +38,9 @@ enum da9121_subvariant {
 	DA9121_SUBTYPE_DA9132,
 	DA9121_SUBTYPE_DA9122,
 	DA9121_SUBTYPE_DA9131,
-	DA9121_SUBTYPE_DA9217
+	DA9121_SUBTYPE_DA9217,
+	DA9121_SUBTYPE_DA9141,
+	DA9121_SUBTYPE_DA9142
 };
 
 /* Minimum, maximum and default polling millisecond periods are provided
@@ -70,6 +74,14 @@ enum da9121_subvariant {
 #define DA9121_REG_SYS_GPIO1_1		0x13
 #define DA9121_REG_SYS_GPIO2_0		0x14
 #define DA9121_REG_SYS_GPIO2_1		0x15
+#define DA914x_REG_SYS_GPIO3_0		0x16
+#define DA914x_REG_SYS_GPIO3_1		0x17
+#define DA914x_REG_SYS_GPIO4_0		0x18
+#define DA914x_REG_SYS_GPIO4_1		0x19
+#define DA914x_REG_SYS_ADMUX1_0		0x1A
+#define DA914x_REG_SYS_ADMUX1_1		0x1B
+#define DA914x_REG_SYS_ADMUX2_0		0x1C
+#define DA914x_REG_SYS_ADMUX2_1		0x1D
 #define DA9121_REG_BUCK_BUCK1_0		0x20
 #define DA9121_REG_BUCK_BUCK1_1		0x21
 #define DA9121_REG_BUCK_BUCK1_2		0x22
@@ -276,6 +288,7 @@ enum da9121_subvariant {
 #define DA9121_MASK_OTP_DEVICE_ID_DEV_ID		0xFF
 
 #define DA9121_DEVICE_ID	0x05
+#define DA914x_DEVICE_ID	0x26
 
 /* DA9121_REG_OTP_VARIANT_ID */
 
@@ -293,6 +306,10 @@ enum da9121_subvariant {
 #define DA9131_VARIANT_VRC	0x1
 #define DA9132_VARIANT_VRC	0x2
 
+#define DA914x_VARIANT_MRC_BASE	0x0
+#define DA9141_VARIANT_VRC	0x1
+#define DA9142_VARIANT_VRC	0x2
+
 /* DA9121_REG_OTP_CUSTOMER_ID */
 
 #define DA9121_MASK_OTP_CUSTOMER_ID_CUST_ID		0xFF
-- 
2.25.1

