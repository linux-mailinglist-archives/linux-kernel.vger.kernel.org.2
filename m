Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59867366AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 14:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbhDUM2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 08:28:02 -0400
Received: from mail-eopbgr20055.outbound.protection.outlook.com ([40.107.2.55]:44717
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232442AbhDUM2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:28:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeQFAeSS4f+EBPwvTYsxsnpS0Ig2hfV01ChThlyv7KcnA9xOYcdabEoRdEwTRolhko+AxdQ9d55S30C8kzyZpQg1Soo9gARMdieWUYCAr+hUmmgt11wcLiYYHy25xm5oq9/wf1lbwlMUSFSoZllN3jGoSKlVRtOzbC0CzUjhvcYFH6Gr06csNlxw2t3dbeRiAKwDejpu72oeZjFtAsxutr1EjojqXt8DdWOTHY/jo7Bb1+cNMKq72Vof7yQgAlf8ypArF+Kao0oiZleRJ+S94/xhtoOR3SAroPlAUET9civ04ok/9qWUl2MBg3fMiyaMvZgU5UJ4N3jZAFlXazyqZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGx8DOmYWGQGgoqJq2GSiJvv4i5tkXiSgzJXESIn5Xo=;
 b=V3GGeCEKiXFcrQ7GPtdx4+q3vY4dODHttShbOPepRjnNA6lRggn7ULwY8YnhRwKBsI2GiPyE8nW/CK7nBilWnneHe3aKz9YZwIgqF1K3L9CjBF/OyxsRBaaZibfm1JofYtKkZ9olRcC2WYu++KLl45f+x6oan+bkncMXff/6HVmLiKrM1i+pebc7MVr6Aixb0IllDunpyEy3SzUTibqQuiWFpYO/E/J0C+/zHasFWV5XGK6Y5pr1JZ1Ymr9sKxWURBOr27D4isikF4ZUW7KkuDfFkLqY/nyR81QNCAyv5yxogYV22Nqlpfl2jIlfj+OXijFuGOUzxaMfB5nVZO38pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=diasemi.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=diasemi.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGx8DOmYWGQGgoqJq2GSiJvv4i5tkXiSgzJXESIn5Xo=;
 b=BRhE6rINHfpwf/jO+pP4mTrf9A4tbmv+2svU5bFQlyrdyXc/QVcLjQ6CTjSR528c1XiL3CADFSAUkWYVgrdLGBIKl40imYpiJ7JfZh69Zw45SXPVy/r7Z199NR4NFLNFuHEQSQNcqTH0ca9vZ5jHOcvVk6mVtOhlaYDKKp1U1bg=
Received: from AM6PR0202CA0049.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::26) by AM7PR10MB3606.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:131::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Wed, 21 Apr
 2021 12:27:25 +0000
Received: from AM5EUR02FT043.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:3a:cafe::46) by AM6PR0202CA0049.outlook.office365.com
 (2603:10a6:20b:3a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Wed, 21 Apr 2021 12:27:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; vger.kernel.org; dkim=none
 (message not signed) header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT043.mail.protection.outlook.com (10.152.9.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 12:27:25 +0000
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.498.0; Wed, 21 Apr 2021 14:27:24 +0200
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 8CDA180007F; Wed, 21 Apr 2021 12:27:24 +0000 (UTC)
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Wed, 21 Apr 2021 12:27:24 +0000
Subject: [PATCH V4] regulator: da9121: automotive variants identity fix
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Message-ID: <20210421122724.8CDA180007F@slsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8f988a7-a1f9-492e-9432-08d904c0d20b
X-MS-TrafficTypeDiagnostic: AM7PR10MB3606:
X-Microsoft-Antispam-PRVS: <AM7PR10MB3606700B4C3EBD0C4B0F6659A7479@AM7PR10MB3606.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RpDBg4F+3eSkyqPvBExTCYCXz8ycD7pPDFlCwtW+0AvpGlAxscuX/kIe83PBuEMMnqHjJ+GOxaOYQev+mdpKXwkCJppGFykBBd9QvRFfBMmHFwLyHZuPjBRMOKRYKtgaLqafGIfaRoX5ogzOotN/paViyNckcOTdqkMT8c9fI6xy1LmVcIgZeADe0gJtLX/ZBcRe/q5Tluy9flJh2z+RdAc7N93xBFJ1GW6F+8Y61gk6M5BvLC9dDBdGGBheY21mS/s9UEzsvXIEb9u/wU9rosZiI2g/DdkYsLGCUW4uByIzQJa7BUgp620UzETP1UkxhiCPq8CCMluDZnvclv7xhFgOKmYycaBnzdBGEYpOS8qfRag1IrCpFbk8c9gLhbnwsxE4B6y6CJ/nDtlkCbO1J7xDBd0l83F5JbNEWfXNxHg/d6lYBHQDIiY9uQz9FpbXNEoh9mx872JgmXpjveoziZrdKG1ZcwId7yQ/8BR6wRtTpSOQR4qHuKxA2CuTO8W4NPN4XAEygBPVaJ+hede5LEetyl7qPehQjkLHin3ZPJ0JlKkSKJ0KQAmKS57Wadi52q460YvTHHZU6ttdqrm8FIoNWyMlL02szYYpWLMCUgwzjv+Xpfc4tC8JpdLmRvdfUvVhOPIgm14ahc3SdGWko0jOXiotTU7E9TNR7gIWRnm9ytPVbisZu5C/oI6v8L62
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(39850400004)(376002)(136003)(346002)(36840700001)(46966006)(6266002)(4326008)(356005)(82740400003)(42186006)(26005)(6916009)(47076005)(81166007)(70586007)(8936002)(70206006)(1076003)(107886003)(426003)(8676002)(82310400003)(336012)(316002)(54906003)(5660300002)(33656002)(186003)(478600001)(83380400001)(2906002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 12:27:25.1333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f988a7-a1f9-492e-9432-08d904c0d20b
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT043.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3606
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes identification of DA913x parts by the DA9121 driver,
where a lack of clarity lead to implementation on the basis that variant
IDs were to be identical to the equivalent rated non-automotive parts.

There is a new emphasis on the DT identity to cope with overlap in these
ID's - this is not considered to be problematic, because projects would
be exclusively using automotive or consumer grade parts.

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---

V2: Fix for TYPE/SUBTYPE error I forgot to commit before generating patch
    (Thanks to Raviteja Narayanam for originally spotting this)
V3: Good grief - messed up again for V2, now got it all the way through
V4: Fix email formatting for this changelog

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

