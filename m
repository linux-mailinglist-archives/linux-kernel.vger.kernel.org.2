Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666B0366A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 13:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbhDULw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 07:52:57 -0400
Received: from mail-vi1eur05on2055.outbound.protection.outlook.com ([40.107.21.55]:58080
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238139AbhDULwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 07:52:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTejhXLF+JOhk2jH8zeIB8w/DXmv01umCZfy6mFSxiMtGMAYm+Zq+U0ecxJPW5Qnj4vssu3xAH19Fuf/HKCA4QK1qazzNu5ZGO5V2brg3iKV2FXsgEk7Raugyhv3iPSsfzxQp2yM47Ui6WzGFJyEwqY5uszySccrwmDb192Ei8Ssvw/ghtq6+lEvrV9f0DmF/56iQPD97laTCjhjiCq2Ctb+SzYsjNOG067qfKHw+/fvqz9ElDmpKDwy72UcvWDBIzCPiDX0O0DyoP6IMN6DhWR0lq+PGqltec+Tl70Wrf3fWLKAGJTEi5uf14QRo2m0mUglOvQTJ3bkzir3EUMqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Em8QZ+uM0DN0YJnaaQUcVFGVh6J8MjfG7D5QCRjX/nU=;
 b=BFplRTdx/e4h0VPa1GzU9GNWX8U3Tm3OprVrbmbiUFdczLdAzpFnFehAyehCoao6+7E+RTj1HLInjKS+bRJ0CQkbrqzF6tfpcUrI/pMw5JTJ2qHabIQWPQbecvCQL57hJkKLT/l6EazQYPJKaPGantHpXlja1xwnDRYAM+lPOYL0E6D8gfdG5kIgI6MZ4tkBiAYsLss5EF38eVzU8dlKftrDDaB4eejcpUAgBLqT9MMtTU6ymVP7Z7d5nacCfWzANgf3bxps2Mvs3gIvDVOVWAKadmtTgRbHDA8f5leAHmuBu55zfARpxmOg3mXbDm6ddHrXvDIt5Fx4h62/ceMsOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=diasemi.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=diasemi.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Em8QZ+uM0DN0YJnaaQUcVFGVh6J8MjfG7D5QCRjX/nU=;
 b=UI/jQ1X2CwrYTaiapn+fl2GOyseemsCwBVGQtGHH28NnDSc7yQvM1uCI/UBK4hG5yN+zNUO8B4ScmLl80Avo9EtV1WF711nl8JUqesBMmusqseYG+nkt322nLVQ+UvcirLMETKLEmBg7dzScrdAVDNXFuqWcYpyiM/UJeVVJOYs=
Received: from AM6P194CA0010.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::23)
 by DB7PR10MB2524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Wed, 21 Apr
 2021 11:52:18 +0000
Received: from VE1EUR02FT023.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:90:cafe::6c) by AM6P194CA0010.outlook.office365.com
 (2603:10a6:209:90::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Wed, 21 Apr 2021 11:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; vger.kernel.org; dkim=none
 (message not signed) header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT023.mail.protection.outlook.com (10.152.12.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Wed, 21 Apr 2021 11:52:17 +0000
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.498.0; Wed, 21 Apr 2021 13:52:16 +0200
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 9C1BC80007F; Wed, 21 Apr 2021 11:52:16 +0000 (UTC)
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Wed, 21 Apr 2021 11:52:16 +0000
Subject: [PATCH V2] regulator: da9121: automotive variants identity fix
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Message-ID: <20210421115216.9C1BC80007F@slsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0027a5f7-2d0f-47ee-cb5b-08d904bbe9cb
X-MS-TrafficTypeDiagnostic: DB7PR10MB2524:
X-Microsoft-Antispam-PRVS: <DB7PR10MB25244993078FB17241675819A7479@DB7PR10MB2524.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1zUR6u5OjH6vyrIY+wshhRQ9mzBwi2hVMOsFOPBs9lwf5iVOfZXI7rx+597KG755Nq+X2GMDoNXNTHPcnnkAngBZaqhwmPpo3pMsEotTlENQIBwQO+ZsLrDUWqUQEtWKyfRPDM+fafA4zm1IW3K60iM6hFmZpporO2/mDS6C2zVHTCUoTyYPxe4NT5Fzmax8d7iixV1hLJ+B7UjBrl5obtszy4JReroHvq5eP3fnKFjyHirN+5w1OucQFntj2yZvtlFBiWyDZhY7r/25jreAx8QkBGxonJFcrfl+U30fVRJEn+9Ymtbu7ETWMEJ3wKB6xPlFCjW4jFCEyDEpRYzE3oe+5e8BoF7OkGKVoMbygt18mT0qafD9ffQVboB9Yy8zcWWoGlNB0/kP9k2lsgM5u6v7FhPGCZk8hHsaEYPGTspPVKWGfUU5G4lCTgSIvcm+sm8QcfWxy8Ci+8WzMiV7Ar3pqLGqFKB3FuI2Q/59c2q3Z0gUHZjpgmulyrc1R5OuPtH1uxvWzrfcn0WH2zZK1pAK7wH7xVzbCvbqe00jdYZvgxbHmE1bsFRzkq2gy0/0FKdFfmUGTEl96AolHz6yt31mzCeqwplc3F91RXvlmB7AxXKsNIR7lG7i0wGTdraONUkvurkk+VHQ9cGSZjcuvzy6pHjsLYa68hVywZuQCEhS/czL7nUtdh/6eFX6gBS
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39850400004)(46966006)(36840700001)(336012)(83380400001)(426003)(8676002)(47076005)(82310400003)(2906002)(186003)(4326008)(36860700001)(1076003)(33656002)(70206006)(8936002)(478600001)(107886003)(42186006)(316002)(6266002)(54906003)(26005)(6916009)(70586007)(82740400003)(356005)(5660300002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 11:52:17.4882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0027a5f7-2d0f-47ee-cb5b-08d904bbe9cb
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT023.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2524
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

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 80 ++++++++++++++++++----------
 drivers/regulator/da9121-regulator.h | 13 +++++
 2 files changed, 65 insertions(+), 28 deletions(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index a2ede7d7897e..0ccf3caf41d2 100644
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
+	case DA9121_TYPE_DA9220:
+	case DA9121_TYPE_DA9132:
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

