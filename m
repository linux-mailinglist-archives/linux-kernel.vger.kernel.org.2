Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EF43669F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 13:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbhDULcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 07:32:48 -0400
Received: from mail-db8eur05on2088.outbound.protection.outlook.com ([40.107.20.88]:38592
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233959AbhDULcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 07:32:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0xff6YxttOp+ZOnRlsnO3F7UUXeZes0hgU33tb5uRbO4WGIqTQql3XNcvDtkQyUc2BSZvRPKuuHGlks+cTzUbeBdcITdWq0ZNhHoZ0DcwSidoFFKocYrwBkK6CJGclJkLmiYPTGe+bE7tVxN6AlymjArzjzeLTq6ELstXwJBIcD2gSGicYMxMsjUOzRCEda7tKGVbp2WiGMvFaNPwDc4TNPEXnnHT68ww5a0hBn57GMN8kfXtvOysstPU6deAYQ9+j2Y3F8wa9BAryCQZN6Zj/W74WN/MC3LKxz+SbMFuiSoG70Y0TAoxn4FfqXirhhmXm1nWa6yoVQXucoMTzmTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WB3SLOuYLqOCAv1b6opIazDsGXBCX2LiJmLKQMV+XT8=;
 b=hxc+9puC6U3IkVCurWkWnbHLTxowUbPhrPwVhD8Q5Xbtp3cHw89lzrdYrXyeOOqUoWXASQ/NlKgYdd5WmveUbIHp5VasoMC6FJN29ZeEJHf9lK8nXByzzTJ2CVpzuMoJQ/K1CSj1GJn9mmzmjFpkLIP9sS4NGhsQ8NZV23zGESYYg6mOdzzsAks3YIishvVLfQxcpgF+bPQ5UU58wMN+gPcO0+6qped/Oj9ARWLSFKjzgVis3iinfGZBCkFF+e8HkD8hpD78bDexF5NmKV23+NUQh8RxAnfaZF+s8hErPJNcfKxEhGaSIXWmpbkpoqXTp9mn1fY8mT4TucMjz8+2kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=diasemi.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=diasemi.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WB3SLOuYLqOCAv1b6opIazDsGXBCX2LiJmLKQMV+XT8=;
 b=lsCKxcFxEMf1IEOgBcbdugvskesaXKYLMZNRbc2sX3vY1cMWM9QlqX7++0tbUkIgvGqBcZN5WJAqxxvF0ghG217rCKPus/R6z8fTZOYghMTfJHz2XAlWDp6cFH7HRS//zS3JCC289Gi6W54K/dyKjrf2M3TtNK3WtvQr92+f6/k=
Received: from AM6P191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::23)
 by AM7PR10MB3778.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:179::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Wed, 21 Apr
 2021 11:32:10 +0000
Received: from VE1EUR02FT026.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:8b:cafe::ee) by AM6P191CA0010.outlook.office365.com
 (2603:10a6:209:8b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Wed, 21 Apr 2021 11:32:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; vger.kernel.org; dkim=none
 (message not signed) header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT026.mail.protection.outlook.com (10.152.12.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 11:32:10 +0000
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.498.0; Wed, 21 Apr 2021 13:32:09 +0200
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 D9E6E80007F; Wed, 21 Apr 2021 11:32:08 +0000 (UTC)
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Wed, 21 Apr 2021 11:32:08 +0000
Subject: [PATCH] regulator: da9121: automotive variants identity fix
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Message-ID: <20210421113208.D9E6E80007F@slsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9faad332-8fed-475e-8536-08d904b91a1e
X-MS-TrafficTypeDiagnostic: AM7PR10MB3778:
X-Microsoft-Antispam-PRVS: <AM7PR10MB3778C42599E2B68451E4623DA7479@AM7PR10MB3778.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7bCUcM9Wkt2UqUEqu9hK6nn4Xufp6wCeEIOEjTU67SVQErG5/vkme/KN7nizA4OLuZyfoOQoYf2pGcPb+xWrdx4tZIWP4x2EVaixcDtji093smN+FZHRmrM5PZ9TEW/OJDB8DUzEWfINWNNcdXOySeKNdtJiXEKhVyNGxTTcnkhWimEu+Sy/YLYdQ5vjVK33bpBhNGgTpcpJ/axdYSyfpGxsYmj5LU/NMXn2Xl9WTOj0oX8j0OcJCFvdeANhk+Rsw0EGVib+ih4MP7yNh7BcFMFrQrz1eVzjP75EAFqmtdyzNib5jkaWc4znvEeEUU6FCfxfBK1ZoqdDjY2eZNMPGamubVAlBqBEF8+HLQG+I6NO/GCoSM+qkJSrMGE0QDN0mLvydjEBkDMf13bSJm5peOuM6akvJSdfavK6/XMS3MeTSUa1TYIL7LcWzhRFknUdZvOeU8p1QxH0UNq0vZGuYZhe1hMUhtH4y4nwQjUSyoZFZRVerj28bfx4kDnos42nFLQcW5kIQ+CbTOi2kwKu+ipj5VAA3c/bUtfogSTjPoum3CgXNE/fJ9LK/aVQtgzG47U5uUS3wjgG8mSeAY7XJ3fBIkWbXYm/WcY7ooBspNDITnobBfh6PdNGoeo571pNdMS0miLLiB1KrM5Sxfmc/3wXpuc3MKriGfbDoTvTU2bibMw7pAYmjq18XOtmJqr/
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(376002)(346002)(36840700001)(46966006)(26005)(47076005)(81166007)(36860700001)(5660300002)(107886003)(54906003)(82740400003)(6266002)(42186006)(2906002)(82310400003)(4326008)(6916009)(186003)(33656002)(316002)(8936002)(336012)(356005)(478600001)(8676002)(83380400001)(70206006)(70586007)(1076003)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 11:32:10.0635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9faad332-8fed-475e-8536-08d904b91a1e
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT026.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3778
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

