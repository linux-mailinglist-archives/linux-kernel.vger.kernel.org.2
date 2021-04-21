Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598F2366A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 14:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbhDUMDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 08:03:51 -0400
Received: from mail-eopbgr50077.outbound.protection.outlook.com ([40.107.5.77]:9391
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234132AbhDUMDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:03:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXR6k7aBBRQuPSWlR8IaS2Y/WetCWPTJR2TfuStnA34BT+do9ENdhx8fvIZ6NuE/fDMphZb82o0xejOCgCD1VVSG4bmCID8YLSLIzC05ecYzidJrwF4TBmrqz0Zv0W2C5aedQ7ugG4Q7d2+3eDIPp8on8X4RAnS6NKpAzz878N7ioO3OpVSWAAS9fhl/fxA+Wj2haWOGG8D2s5EumL7lylpHxOjv+ru2XP2BZLEk/XaQgAJVBxbdl43ytfFcybv4s0OsZPH2byKbTIkklFQYW3sgV2RMBRBmx7w4wtLs7e7Ly+uUCGXuWB7ofK3Oq85B/8lTuzW9j7+VgkfPHI/MJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyCA8uIVEDcWOMQgQzyl2DEKm034+n8RxmlTv79ssr4=;
 b=LxAqcOz4jN1UncyG8Qm8J7WvQNvsGISXGwnnQpXZ/zzT78lpTNHueNN3A+iQuB0tzyY3A5tG3S0tg648JlcLzK4mV5How8QfgfaTcqTaSZ/ua2Ka7RXFN3A6cLsHAOpgxWcQNtJ2FVkMIhZrPrigVeeQYTvom2idm2amO4wNmXFWrWioVm23Eri0/O9g+AclrekQh+iQXzxPpH+zfzt6Qb8w80WXBPlfw5Ij+FXps392cL340fB1pciwdwmpYE/Vkst1AUsovp2BnQbXZ/nV6vWxuq6MWWtdRbXbZTiUWADthi0LZdgD7z+p0nS4f0DKsWfOZ3UstdcXxa5Fo174Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=diasemi.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=diasemi.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyCA8uIVEDcWOMQgQzyl2DEKm034+n8RxmlTv79ssr4=;
 b=dNqikMAsasu2er7mlpN5DBohQBsVkU43wWZoGJ5rqLOwMHyZXtbhScqVObHghvdqjGkTdArx+vhHYm4K2WV8mnKJxAuY6kgp+pLSAGCf0GLsmc3h/28N4Qc2rhIuVPBbRNo8yjTyq13jVWbTk4RMokIXddjVL5KykRNJUIgEQ+I=
Received: from AM7PR02CA0017.eurprd02.prod.outlook.com (2603:10a6:20b:100::27)
 by AM6PR10MB2200.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:48::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 12:03:10 +0000
Received: from HE1EUR02FT057.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:100:cafe::6d) by AM7PR02CA0017.outlook.office365.com
 (2603:10a6:20b:100::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend
 Transport; Wed, 21 Apr 2021 12:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; vger.kernel.org; dkim=none
 (message not signed) header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 HE1EUR02FT057.mail.protection.outlook.com (10.152.11.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Wed, 21 Apr 2021 12:03:09 +0000
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.498.0; Wed, 21 Apr 2021 14:03:07 +0200
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 DB5B880007F; Wed, 21 Apr 2021 12:03:06 +0000 (UTC)
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Wed, 21 Apr 2021 12:03:06 +0000
Subject: [PATCH V3] regulator: da9121: automotive variants identity fix
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Message-ID: <20210421120306.DB5B880007F@slsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e2e351c-6f58-4c12-f15b-08d904bd6eb4
X-MS-TrafficTypeDiagnostic: AM6PR10MB2200:
X-Microsoft-Antispam-PRVS: <AM6PR10MB2200B0401AE120740DE9ED83A7479@AM6PR10MB2200.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1Ka8cUGo/63ozOcMG2mAKuuHoEIUXruF8i+vxx+6TopmQxK70F1s+4bDg7iLNVC+tGx/JO+gVVKHw6kn4aYlREGz4uD7lzGq/LYm9lMupX4dx2D8IQGaNrRN2HzmFR+1qYstE3C+ws0cRai5oUyWEvDiBI9atSE0kgwbLLHthbPw8Ynqi28OFt1hX6gIQMRNnkjHlb/igD1jfXPDh95yC2F65NCp5y8CEwgQRGkrCHImCMk82AnxSdBFPO7Y4oLk/s/04cle1fBg9Dmgb9vTZSZXayCS2RmY9AIde8OFxnHZlrw6l9HrjLiyYj62YjGYPHjByJEPjTw945bbRXiazMqhj+SnGLOaKzDhCzYxWxNaUJ8a+R3OGun7Doav9dCnibktsxsi/OAtLaGx0xPalSA+ZS2AYOvr2iy3iYNFrvgNrQz0vbnpLiOz6oVTVfnfi62P2YWtLxcGKhnI9s380K6M099PJvKDj/OBEc7uPVQJqMLIfb5QTn97j+imwVgTdfIcxxJjjeWJwPfsnNYufY3ACKWzhbwrdgoYbHHdmbkxRnVdwedjfu1NN4ulLZUEZu3GKAXs/7/o8NGRwQ5SVR53qwCNpo6ummQ7HJGySV95Mt0cel2Cb+baYc5we+k9qfr/YyuWKEATNTZhHmyayHhBe/Fertc50vZ8M/iqiNTuZ1XVv31sFqTWDqSqNdK
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39850400004)(46966006)(36840700001)(1076003)(42186006)(82310400003)(426003)(2906002)(186003)(47076005)(33656002)(5660300002)(6916009)(316002)(478600001)(336012)(107886003)(81166007)(8936002)(83380400001)(8676002)(6266002)(356005)(36860700001)(70206006)(4326008)(26005)(82740400003)(54906003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 12:03:09.8409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2e351c-6f58-4c12-f15b-08d904bd6eb4
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT057.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2200
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes identification of DA913x parts by the DA9121 driver,
where a lack of clarity lead to implementation on the basis that variant
IDs were to be identical to the equivalent rated non-automotive parts.

There is a new emphasis on the DT identity to cope with overlap in these
ID's - this is not considered to be problematic, because projects would
be exclusively using automotive or consumer grade parts.

V2: Fix for TYPE/SUBTYPE error I forgot to commit before generating patch
    (Thanks to Raviteja Narayanam for originally spotting this)
V3: Good grief - messed up again for V2, now got it all the way through

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 80 ++++++++++++++++++----------
 drivers/regulator/da9121-regulator.h | 13 +++++
 2 files changed, 65 insertions(+), 28 deletions(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index a2ede7d7897e..08cbf688e14d 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -40,6 +40,7 @@ struct da9121 {
 	unsigned int passive_delay;
 	int chip_irq;
 	int variant_id;
+	int subvariant_id;
 };
 
 /* Define ranges for different variants, enabling translation to/from
@@ -812,7 +813,6 @@ static struct regmap_config da9121_2ch_regmap_config = {
 static int da9121_check_device_type(struct i2c_client *i2c, struct da9121 *chip)
 {
 	u32 device_id;
-	u8 chip_id = chip->variant_id;
 	u32 variant_id;
 	u8 variant_mrc, variant_vrc;
 	char *type;
@@ -839,22 +839,34 @@ static int da9121_check_device_type(struct i2c_client *i2c, struct da9121 *chip)
 
 	variant_vrc = variant_id & DA9121_MASK_OTP_VARIANT_ID_VRC;
 
-	switch (variant_vrc) {
-	case DA9121_VARIANT_VRC:
-		type = "DA9121/DA9130";
-		config_match = (chip_id == DA9121_TYPE_DA9121_DA9130);
+	switch (chip->subvariant_id) {
+	case DA9121_SUBTYPE_DA9121:
+		type = "DA9121";
+		config_match = (variant_vrc == DA9121_VARIANT_VRC);
 		break;
-	case DA9220_VARIANT_VRC:
-		type = "DA9220/DA9132";
-		config_match = (chip_id == DA9121_TYPE_DA9220_DA9132);
+	case DA9121_SUBTYPE_DA9130:
+		type = "DA9130";
+		config_match = (variant_vrc == DA9130_VARIANT_VRC);
 		break;
-	case DA9122_VARIANT_VRC:
-		type = "DA9122/DA9131";
-		config_match = (chip_id == DA9121_TYPE_DA9122_DA9131);
+	case DA9121_SUBTYPE_DA9220:
+		type = "DA9220";
+		config_match = (variant_vrc == DA9220_VARIANT_VRC);
 		break;
-	case DA9217_VARIANT_VRC:
+	case DA9121_SUBTYPE_DA9132:
+		type = "DA9132";
+		config_match = (variant_vrc == DA9132_VARIANT_VRC);
+		break;
+	case DA9121_SUBTYPE_DA9122:
+		type = "DA9122";
+		config_match = (variant_vrc == DA9122_VARIANT_VRC);
+		break;
+	case DA9121_SUBTYPE_DA9131:
+		type = "DA9131";
+		config_match = (variant_vrc == DA9131_VARIANT_VRC);
+		break;
+	case DA9121_SUBTYPE_DA9217:
 		type = "DA9217";
-		config_match = (chip_id == DA9121_TYPE_DA9217);
+		config_match = (variant_vrc == DA9217_VARIANT_VRC);
 		break;
 	default:
 		type = "Unknown";
@@ -892,15 +904,27 @@ static int da9121_assign_chip_model(struct i2c_client *i2c,
 
 	chip->dev = &i2c->dev;
 
-	switch (chip->variant_id) {
-	case DA9121_TYPE_DA9121_DA9130:
-		fallthrough;
-	case DA9121_TYPE_DA9217:
+	/* Use configured subtype to select the regulator descriptor index and
+	 * register map, common to both consumer and automotive grade variants
+	 */
+	switch (chip->subvariant_id) {
+	case DA9121_SUBTYPE_DA9121:
+	case DA9121_SUBTYPE_DA9130:
+		chip->variant_id = DA9121_TYPE_DA9121_DA9130;
 		regmap = &da9121_1ch_regmap_config;
 		break;
-	case DA9121_TYPE_DA9122_DA9131:
-		fallthrough;
-	case DA9121_TYPE_DA9220_DA9132:
+	case DA9121_SUBTYPE_DA9217:
+		chip->variant_id = DA9121_TYPE_DA9217;
+		regmap = &da9121_1ch_regmap_config;
+		break;
+	case DA9121_SUBTYPE_DA9122:
+	case DA9121_SUBTYPE_DA9131:
+		chip->variant_id = DA9121_TYPE_DA9122_DA9131;
+		regmap = &da9121_2ch_regmap_config;
+		break;
+	case DA9121_SUBTYPE_DA9220:
+	case DA9121_SUBTYPE_DA9132:
+		chip->variant_id = DA9121_TYPE_DA9220_DA9132;
 		regmap = &da9121_2ch_regmap_config;
 		break;
 	}
@@ -975,13 +999,13 @@ static int da9121_config_irq(struct i2c_client *i2c,
 }
 
 static const struct of_device_id da9121_dt_ids[] = {
-	{ .compatible = "dlg,da9121", .data = (void *) DA9121_TYPE_DA9121_DA9130 },
-	{ .compatible = "dlg,da9130", .data = (void *) DA9121_TYPE_DA9121_DA9130 },
-	{ .compatible = "dlg,da9217", .data = (void *) DA9121_TYPE_DA9217 },
-	{ .compatible = "dlg,da9122", .data = (void *) DA9121_TYPE_DA9122_DA9131 },
-	{ .compatible = "dlg,da9131", .data = (void *) DA9121_TYPE_DA9122_DA9131 },
-	{ .compatible = "dlg,da9220", .data = (void *) DA9121_TYPE_DA9220_DA9132 },
-	{ .compatible = "dlg,da9132", .data = (void *) DA9121_TYPE_DA9220_DA9132 },
+	{ .compatible = "dlg,da9121", .data = (void *) DA9121_SUBTYPE_DA9121 },
+	{ .compatible = "dlg,da9130", .data = (void *) DA9121_SUBTYPE_DA9130 },
+	{ .compatible = "dlg,da9217", .data = (void *) DA9121_SUBTYPE_DA9217 },
+	{ .compatible = "dlg,da9122", .data = (void *) DA9121_SUBTYPE_DA9122 },
+	{ .compatible = "dlg,da9131", .data = (void *) DA9121_SUBTYPE_DA9131 },
+	{ .compatible = "dlg,da9220", .data = (void *) DA9121_SUBTYPE_DA9220 },
+	{ .compatible = "dlg,da9132", .data = (void *) DA9121_SUBTYPE_DA9132 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, da9121_dt_ids);
@@ -1011,7 +1035,7 @@ static int da9121_i2c_probe(struct i2c_client *i2c,
 	}
 
 	chip->pdata = i2c->dev.platform_data;
-	chip->variant_id = da9121_of_get_id(&i2c->dev);
+	chip->subvariant_id = da9121_of_get_id(&i2c->dev);
 
 	ret = da9121_assign_chip_model(i2c, chip);
 	if (ret < 0)
diff --git a/drivers/regulator/da9121-regulator.h b/drivers/regulator/da9121-regulator.h
index 3c34cb889ca8..357f416e17c1 100644
--- a/drivers/regulator/da9121-regulator.h
+++ b/drivers/regulator/da9121-regulator.h
@@ -29,6 +29,16 @@ enum da9121_variant {
 	DA9121_TYPE_DA9217
 };
 
+enum da9121_subvariant {
+	DA9121_SUBTYPE_DA9121,
+	DA9121_SUBTYPE_DA9130,
+	DA9121_SUBTYPE_DA9220,
+	DA9121_SUBTYPE_DA9132,
+	DA9121_SUBTYPE_DA9122,
+	DA9121_SUBTYPE_DA9131,
+	DA9121_SUBTYPE_DA9217
+};
+
 /* Minimum, maximum and default polling millisecond periods are provided
  * here as an example. It is expected that any final implementation will
  * include a modification of these settings to match the required
@@ -279,6 +289,9 @@ enum da9121_variant {
 #define DA9220_VARIANT_VRC	0x0
 #define DA9122_VARIANT_VRC	0x2
 #define DA9217_VARIANT_VRC	0x7
+#define DA9130_VARIANT_VRC	0x0
+#define DA9131_VARIANT_VRC	0x1
+#define DA9132_VARIANT_VRC	0x2
 
 /* DA9121_REG_OTP_CUSTOMER_ID */
 
-- 
2.25.1

