Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBC13738BE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 12:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhEEKnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 06:43:51 -0400
Received: from mail-db8eur05on2046.outbound.protection.outlook.com ([40.107.20.46]:58624
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232832AbhEEKnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 06:43:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDUT5q8xD0qrkaNqzywECd9xbYBHKtPne+hRCITfJ916Y2H+r2slA2QbuSaVcjitRKqtmPWzKHe6DyfsR4S8pCYtlvt3iIrGJUrkvz81pRhIMGXM6Z2kZYWGv6xXF9ibcFAGVGL4HcWGmHikP5cwVi6EOeAY1zFQo+cjTiRcQTF40XM87Xp/tFGEDmQgGrsVcVxNtR8UGnIyziksAPdDuTL0egNhqyrolRUyhvNTqvXxPrJ0i3CP2eIR5T9wL8/qeTKs2MCAnT2fjzdbUs1JsPLKM3fb9CGB9+EWECSjhI1EvUc84we9QSXR6CH2VpBNCqJit7ke4xhJTRFV1tGrVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr1DsEpzAfmu8pK502bguevhldaWtYtOpsQxzKMNYOk=;
 b=RUhzYsfAjwbDLbWvkK+SrBF2DKlXsvJMy8+NOkioVYRz+tpYmBbyAVKUyMu3175GULA9tMcg6tzQs79E0hvOkCi2y9jIaGvxMRINlUFXhy3xgqU10Y5F/V/bN9I6qn5H8g5XMi4aMls8/4KenoJ6ydRSRN91g0ZrIMRdyin4Mn3FvhVs0Qq6AwGAS5tJmBp48iOSaYXuFVMW+rHSV9+gjEdfHL1FKN5LAIGaokPwGc8TBuwaF/RoIzVMgcFcA/r9zYlWlMICYgToZj7zDfP8fTMHK8M/f1H+sIa3ANnJED/c6yO9g2r+quvt96bOYmhJ0Zypm/RlxH8C1ACYjCPR7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr1DsEpzAfmu8pK502bguevhldaWtYtOpsQxzKMNYOk=;
 b=3PQFei9CCtnspZ6C9vzZJnWMOEi++w5K58JOrHCbSl2Wsfi26MbhI7/OsKoYQdANGMZR9cmsxjSDBF25WQDEopIEj8JNlUOMFOXOjfOs1bD3X1JflsfQDh/Hxa8ikY64flmaWeLqwvJQYEPNusQWCOh70QPNKYl0u0By5scjacd8xzGJJQil3+DokmN4lLOgz8miC/vjV1Y28VVcVyBW4dwZbw7sC8dPsOgsUihqkLJaZp9XFEp5VXREmtOkJqcCHr0dbWoZfiVe63+LWe0VL7ZenXNEbOMtShVFkw4BKYNbtCQDsjthdAV1UD9Dl9cMLcJUqZfyBT+s9iNcOsDsAA==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
 by HE1PR06MB3948.eurprd06.prod.outlook.com (2603:10a6:7:95::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 10:42:32 +0000
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::9ca0:8dd:38d7:c7d4]) by HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::9ca0:8dd:38d7:c7d4%7]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 10:42:32 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>
Subject: [PATCH v4 4/4] nvmem: snvs_lpgpr: support two bytes NVMEM cell size
Date:   Wed,  5 May 2021 13:42:21 +0300
Message-Id: <43cc83f7c8e2e3f5ba131b3c76ca7e30cd7e0f15.1620211180.git.nandor.han@vaisala.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1620211180.git.nandor.han@vaisala.com>
References: <cover.1620211180.git.nandor.han@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [193.143.230.131]
X-ClientProxiedBy: HE1P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::33)
 To HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (193.143.230.131) by HE1P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 10:42:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcb6a091-a292-48f9-c115-08d90fb27c7d
X-MS-TrafficTypeDiagnostic: HE1PR06MB3948:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR06MB394893B5422A133722C32DF985599@HE1PR06MB3948.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYDBd0Vwpm1/jxqggPSIQnDcuKR0CmgJW6rt40G792/ZUPOC0l09PfrwG/lpCkY+kMAGbtMMYhW7uNyKuxNIQOm/gNbuP3Ku5IsV3F6IZKDcBXuGTs57nPyZzq4KB+JbgZuca3p33d934nGvQFbKcxs2MW+Wxscb5a8YF2NzJCZxbIU3vu8iIvFHkhf505XZ8Su6uL60QGs++bgUsbMUCj2TD0uCQgg6om/H/l0jVohsY3RJqKkYcckQpHbW2o1cVLsq1aY6mFGAF9tpACxAEWdxDTJJ85vQJCLFaENoYBcp2D4JLPFGJf4SrG6Ya5hTMPxfFA8T27yU1d/stYpNP7Rk0oG2+GFh9194Ac/Ftw16DDJtNH4qYw0a+AQJE1L7QZOdK2zXVtRAH82iBEUYy/CdTGgLsGTYG7wVj74qsKSJVjlOm0c9zT5iGscRF6jbPeu51M7AlnU1BbKwfIWPeGuIWfie1acO5U/OkBpP96/ZvhXBOGRP6IS3ebq8ntAP+CHwDQvBuXs2ud+QjfR8XaIIYZgHLXjcVFzZsMMsvqS4SKKgSGT39/MIPqifeee8wWYCsUfWp5vr0IhFsVmtjyt4GWcQmqvcg+H6O5XDIteeyn8rhEjCAJqPkrwRjAV7HL3pgRRlsq5YXf8aBNYm0q4rHRHIUhkZsv+zRKLbUQO47XY3xSrNsDrhe+MHDTRE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3449.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(136003)(396003)(376002)(346002)(8676002)(107886003)(6486002)(316002)(5660300002)(16526019)(4326008)(86362001)(186003)(8936002)(83380400001)(26005)(38100700002)(38350700002)(2616005)(956004)(478600001)(2906002)(66946007)(6506007)(6666004)(52116002)(66556008)(66476007)(44832011)(36756003)(6512007)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ib0q8RgT00zEVf+sELMK/n2yHro7Y4atcuDuk6knLPLHyZIdkjsl7KqBN8Y+?=
 =?us-ascii?Q?+tMbGJnxjtDnxiJJWITpnEHKCqUPBfAJfIsLWDtlxU0z8Y1N5fEJ5VudwEDV?=
 =?us-ascii?Q?N7zPmb4L0e843YS0NuFyyfOOD6N6C35PoJGtHRrKB+/I4xTZj8wDfbuMfn9l?=
 =?us-ascii?Q?TeV3OyQM1L0lUZilHNe8UrPhNpIE8cCOezbG0SppqFMD/tOw8g/dgf4wilnn?=
 =?us-ascii?Q?0ilNgE+UybQeMC8EaBPvAYTOja2U78W6QrnfjH8kmqKl5B/dYMBISSQ6Bs8Z?=
 =?us-ascii?Q?7zadTjJaMZkAi7G4XXyWVCPH+hURj0WrFkPk7Fc/XfukDmYdMZCFYVZunnRW?=
 =?us-ascii?Q?gAjrC5dNSTgs/2I9kyXSlmOo2hC8bKUXzeLDNxvgwqamqzhWPpJ9+RYM2t4N?=
 =?us-ascii?Q?VWHZLmP6746RkIzf4PUNYthw7NtVfTy5pZ8qoM4r9QTZ5xoplg5Ea0Sb1nFT?=
 =?us-ascii?Q?oF5/Dd0/DlJdyyQ7n8lAXN1pX0Ji6QIdGSfmIhPT27teH2ppSTcCHT6P3M5Z?=
 =?us-ascii?Q?/Ly/TzQEgeL0F30O+24EUrA6Mj4LsZR5lyrXpbei5iytVpbYc51eo4QqhZqb?=
 =?us-ascii?Q?bqT4T2E+qM71yUbJum2b0w4DgRyzDdLd0qrrMDVql503mA2+G4AwnPwSfwHk?=
 =?us-ascii?Q?HKpSmSMaOERE5XrkjaiZcGw4TMdnly77ZM8NXme1urFrd8rbAODQ1JuCu84i?=
 =?us-ascii?Q?+n1exL5HKxpx+NQXNSVcBsYRgS5hNrRPNYvGfdcCbLSIPBBuFWtnac9NSKWY?=
 =?us-ascii?Q?gIhQFbqJY8Wx2LT2kiVFM1wklDSsRPLK8vxjCBkIt7FRghWHHygkjLifuwRZ?=
 =?us-ascii?Q?SDiweJaxbdkUYlmTVY1oJdKjRFIfzo2J1QRTLev0w+xM8qty3cpGpKscuwam?=
 =?us-ascii?Q?F/P/s0jxrWNf4VJ7SdNuBVJEfXPeoEipBG/AfwfixfnslXQacKMSbRLAZVmy?=
 =?us-ascii?Q?lok0nNMwLtu3zdj4+FHTdL6XPVmG2n132d/CzQ1d78F/4HJ0dQ01SZJsjQDO?=
 =?us-ascii?Q?hFI9xkT2brT8T+xjvg/Hjo/WIqO9szQkR79jUORj9YVQlwlu/NbyqPVAqoq1?=
 =?us-ascii?Q?8gdxjsti+HEJjXz4iNWLaFjC+flqaj1o2tfCiWJu2920VxxLFqbOiJ/EVksg?=
 =?us-ascii?Q?J52LbWWZdULLdZ0S5Kd/APMP9STtftfNhuxZgibFZvAG4BMc4FWrBSQQ5+WZ?=
 =?us-ascii?Q?UjGekX6lMDMVIeSOcM1RtYRCgaTEX7znAsjtXXAGKR5WQKsUcOzGjguyccZ+?=
 =?us-ascii?Q?uPS1NfmWiPgwabKTlFTfT85aZ6X+w+GYE7BVmcsFjr8dlVjx/dchZ5VQyXUl?=
 =?us-ascii?Q?Mz7ZbXITv0pHr9WJW4Ciun9e?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb6a091-a292-48f9-c115-08d90fb27c7d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3449.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 10:42:31.8464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RdGs6f9tDE5W48ylac7fSKiHQd1EEUMFZmDfpp2AWAYfyU8KvyWDSlgGy2MDoVAPrcHU6Uus63+duAg3yZ2bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB3948
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some situation is desired to use less than 4 bytes for storing data.
This will allow using the same register for multiple purposes.

Add support for allowing 2 bytes granularity for NVMEM cells.

Signed-off-by: Nandor Han <nandor.han@vaisala.com>
---
 drivers/nvmem/snvs_lpgpr.c | 67 ++++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 6 deletions(-)

diff --git a/drivers/nvmem/snvs_lpgpr.c b/drivers/nvmem/snvs_lpgpr.c
index 35457421314a..44614f3d68f0 100644
--- a/drivers/nvmem/snvs_lpgpr.c
+++ b/drivers/nvmem/snvs_lpgpr.c
@@ -21,6 +21,9 @@
 #define IMX_GPR_SL		BIT(5)
 #define IMX_GPR_HL		BIT(5)
 
+#define REGMAP_FIELD_SIZE 16
+#define REGMAP_FIELDS_PER_REG 2
+
 struct snvs_lpgpr_cfg {
 	int offset;
 	int offset_hplr;
@@ -33,6 +36,7 @@ struct snvs_lpgpr_priv {
 	struct regmap			*regmap;
 	struct nvmem_config		cfg;
 	const struct snvs_lpgpr_cfg	*dcfg;
+	struct regmap_field **reg_fields;
 };
 
 static const struct snvs_lpgpr_cfg snvs_lpgpr_cfg_imx6q = {
@@ -56,6 +60,11 @@ static int snvs_lpgpr_write(void *context, unsigned int offset, void *val,
 	const struct snvs_lpgpr_cfg *dcfg = priv->dcfg;
 	unsigned int lock_reg;
 	int ret;
+	u32 regval;
+	unsigned int field_id;
+
+	if (offset + bytes > dcfg->size)
+		return -EINVAL;
 
 	ret = regmap_read(priv->regmap, dcfg->offset_hplr, &lock_reg);
 	if (ret < 0)
@@ -71,8 +80,16 @@ static int snvs_lpgpr_write(void *context, unsigned int offset, void *val,
 	if (lock_reg & IMX_GPR_HL)
 		return -EPERM;
 
-	return regmap_bulk_write(priv->regmap, dcfg->offset + offset, val,
-				 bytes / priv->cfg.stride);
+	if (bytes == (REGMAP_FIELD_SIZE >> 3)) {
+		regval = *(u16 *)(val);
+		field_id = offset / REGMAP_FIELDS_PER_REG;
+		ret = regmap_field_write(priv->reg_fields[field_id], regval);
+	} else {
+		ret = regmap_bulk_write(priv->regmap, dcfg->offset + offset,
+					val, bytes / priv->cfg.stride);
+	}
+
+	return ret;
 }
 
 static int snvs_lpgpr_read(void *context, unsigned int offset, void *val,
@@ -80,9 +97,27 @@ static int snvs_lpgpr_read(void *context, unsigned int offset, void *val,
 {
 	struct snvs_lpgpr_priv *priv = context;
 	const struct snvs_lpgpr_cfg *dcfg = priv->dcfg;
+	int ret;
+	u32 regval;
+	unsigned int field_id;
 
-	return regmap_bulk_read(priv->regmap, dcfg->offset + offset, val,
-				bytes / priv->cfg.stride);
+	if (offset + bytes > dcfg->size)
+		return -EINVAL;
+
+	if (bytes == (REGMAP_FIELD_SIZE >> 3)) {
+		field_id = offset / REGMAP_FIELDS_PER_REG;
+		ret = regmap_field_read(priv->reg_fields[field_id], &regval);
+		if (ret)
+			return ret;
+
+		*(u16 *)(val) = regval;
+	} else {
+		ret = regmap_bulk_read(priv->regmap, dcfg->offset + offset, val,
+				       bytes / priv->cfg.stride);
+		if (ret)
+			return ret;
+	}
+	return 0;
 }
 
 static int snvs_lpgpr_probe(struct platform_device *pdev)
@@ -94,6 +129,8 @@ static int snvs_lpgpr_probe(struct platform_device *pdev)
 	struct nvmem_config *cfg;
 	struct nvmem_device *nvmem;
 	const struct snvs_lpgpr_cfg *dcfg;
+	int i;
+	int fields_count;
 
 	if (!node)
 		return -ENOENT;
@@ -121,13 +158,31 @@ static int snvs_lpgpr_probe(struct platform_device *pdev)
 	cfg->priv = priv;
 	cfg->name = dev_name(dev);
 	cfg->dev = dev;
-	cfg->stride = 4;
-	cfg->word_size = 4;
+	cfg->stride = 2;
+	cfg->word_size = 2;
 	cfg->size = dcfg->size;
 	cfg->owner = THIS_MODULE;
 	cfg->reg_read  = snvs_lpgpr_read;
 	cfg->reg_write = snvs_lpgpr_write;
 
+	fields_count = priv->dcfg->size / priv->cfg.stride;
+	priv->reg_fields = devm_kzalloc(
+		dev, sizeof(struct regmap_field *) * fields_count, GFP_KERNEL);
+	if (!priv->reg_fields)
+		return -ENOMEM;
+
+	for (i = 0; i < fields_count; i++) {
+		size_t field_start = i * REGMAP_FIELD_SIZE;
+		size_t field_end = field_start + REGMAP_FIELD_SIZE - 1;
+		const struct reg_field field =
+			REG_FIELD(dcfg->offset, field_start, field_end);
+
+		priv->reg_fields[i] =
+			devm_regmap_field_alloc(dev, priv->regmap, field);
+		if (IS_ERR(priv->reg_fields[i]))
+			return PTR_ERR(priv->reg_fields[i]);
+	}
+
 	nvmem = devm_nvmem_register(dev, cfg);
 
 	return PTR_ERR_OR_ZERO(nvmem);
-- 
2.26.3

