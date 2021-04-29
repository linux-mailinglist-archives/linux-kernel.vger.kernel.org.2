Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7411736EC19
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240588AbhD2OIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:08:34 -0400
Received: from mail-db8eur05on2062.outbound.protection.outlook.com ([40.107.20.62]:22880
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240555AbhD2OI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:08:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqg1zNyXat2vOI2YVluwqKhkVbB/TX5AGuTKVpCbpESK5EO7oOGhSazpASBXVwNFMb0XA22Oic7749kPxF35Q0o3oP6Rit5hZWFKxdIQGh2uB4cpd06E1Z9KorZOOqWJpcrALcsVwlINBbwQbDXu/IaRUGQx+JKp50RkfPxfrlLtd1NTv052Xxdjc7RA1Xpjzfu5pyLLczSmADbOxQj/lOLm9PImyZdhSWpqrU/YsRunCJL3iHlk2FbfO/VgBQKxLunaFwdNW9f89+o3TaW6rgbW69V3zDRPZ70Fu7cTIda98b/2HKQeWPrDfRVl1sjgcuXs6w6NwOoM99tl7lw/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr1DsEpzAfmu8pK502bguevhldaWtYtOpsQxzKMNYOk=;
 b=M2N58Pu/7MEiggAHnycBMfm9Ib9Ov76L+mgrDMLTdKSeySIlbdNkFLmSm9VShpVQITxtsKX+wDiFJkrDHeBvI2IHTd+yuBGBLU4SbKAOCiUHPEQflBLUUqBI8q3By+3qZnGSHRIQx2INQNDVUIzKjZjGArdAOSetizvPkIqDW/UbJZLxnkmK9o3Oyh/JzQaFPxPCLdgbW6+WixrEAG0tOS3nsz8TX9tiRPuIUZhDSittXJeZDksI0VqSIJWbyAPv2PNjOLlHCLYNLSmzVBskQT/1cKLt6sd0p134tDAt4sy4w20qVsC5SP5V1s9w8CDWEu7r3i2hJHo7nNsXzSYP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr1DsEpzAfmu8pK502bguevhldaWtYtOpsQxzKMNYOk=;
 b=Cmg5IxqfJqq+sBVaCDCTOmiB2TuDiADkk7ZwIN1zGEzFxAimSudBUsSAk/gjkSXPZsU2BEIIPMOyrJdF4wHIf6b8zegXAlIXzpsIELW8jup8Q5pd+ClTAF4Fc8erwD4Qjj0QGptGPy/8vstN6jF5Ht2yqTZh4R8A3ZUyp2EnyJv8Cn7fhri+S7V+cyuY4jxKh5VX2xuHEXTkTkkMm2LdjnP+6FbcNLaCizzm/H2LIDVjNBMSVIrJn3c5cMGotyY4zS1FJXbv4s3eMl3Cz5ZFVjoWm/MpoCt+WB6/HYA8MfljY+/x0gOYwbYIDFywH+hyPFoYeoMYQVokdm9goV/X2g==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
 by HE1PR0601MB2315.eurprd06.prod.outlook.com (2603:10a6:3:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Thu, 29 Apr
 2021 14:07:36 +0000
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d]) by HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d%5]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 14:07:36 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>
Subject: [PATCH v3 4/4] nvmem: snvs_lpgpr: support two bytes NVMEM cell size
Date:   Thu, 29 Apr 2021 17:07:25 +0300
Message-Id: <a6974253ec43a7b848eb6e3a735383a37f28db35.1619704986.git.nandor.han@vaisala.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619704986.git.nandor.han@vaisala.com>
References: <cover.1619704986.git.nandor.han@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [176.93.24.30]
X-ClientProxiedBy: HE1PR0902CA0016.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::26) To HE1PR0602MB3449.eurprd06.prod.outlook.com
 (2603:10a6:7:8a::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.vaisala.com (176.93.24.30) by HE1PR0902CA0016.eurprd09.prod.outlook.com (2603:10a6:3:e5::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Thu, 29 Apr 2021 14:07:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ff6d365-4bca-4d2a-7fc2-08d90b1823f1
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2315:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0601MB23156E880B7B5E6A72949CE8855F9@HE1PR0601MB2315.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mLQIs3RT9AJa1EPonfV47Z+c/fBawSMeqiXrrDnHFldn/JXSiHC0DQY2cLeo6r4QNf5gVEuK5mPYS9fPsJD524NjjfqLLjg3ToXecUZYZs9rW4Q8Adb6Dai5NHBHxJZ1BJUCt9hQE/vUzGHgmKX84ODGbGH55xSxrHPG3y8TzQpF156taQAQ3vTu13e2/ZmNO0th/ICGj6KqYxSVijpkVRFTb04/4cEn1TFu15YOlt+6L+6TnlFBLxbwFQo1Vbm8LjdrtRw6Quo4m7rR46ndUgK8aYH4VQIBJxNm8rwcWSHRtO2Za5XDXfZLp8d2fx90T5+IEF0gdUKFxnSX6o2wQ2cdeeTp66Vf0/KkXIwLRGpUmXXTzCIOm7mOpDvbCVU/wnr9/5+/gj6uckHC78uHUfcbXYLo84UX7elqkQ/XV+AEko+D4QC4cGFQkPqZuoH7zy+GBQx+VaSz+2c9H0vCgNhgfdQ7JMsLeQafsdnhPlhhABZZ6ctrhNrg0IyS0A0+3gi2e/wLJX31CD2Ljc+IvvdeCa/HKHLjNEuecGa48SX343fHXsATzsJl+g2a1aN2f6UjZzsMawvow1Psv5tt5QHx+Mi7Y3naADwnrUKR+ebHno5/wrLXeCdFtDoryhjoRousjCyJijslmTgnyL9lkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3449.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39850400004)(366004)(83380400001)(86362001)(6486002)(36756003)(4326008)(2906002)(956004)(38350700002)(52116002)(38100700002)(8676002)(107886003)(44832011)(7696005)(2616005)(6666004)(16526019)(26005)(5660300002)(66476007)(316002)(66946007)(186003)(66556008)(478600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yFkeqeiEFfwEl2uchhzrvaXvo2yw/WyVY48fz4vsozhYPstilM9VlUMFtlbE?=
 =?us-ascii?Q?WG8iO335ON/qND65ty3E9Wn3lgEAEh2yB4Dd/mXt5X7Ug4ZGGGdKDzls+YXf?=
 =?us-ascii?Q?jua/M4ye5auV33rL4lj5FBMSLliwzbqQ9J1pD0zRwccNQnTzNHqhBAjI6Ov8?=
 =?us-ascii?Q?ANVZn2IVzDgXr5qCAPdq6SowCx3kv7G38Xs3yApsNhutZcAgpVIq6CR0dE5o?=
 =?us-ascii?Q?V+DiTQDEOJfxbM/5k1pJxioqK4D/wMio+Z8o48LcrqPDBn2sIb5XvgmKJ5s+?=
 =?us-ascii?Q?8rh66kNinOJkCmz58OIFqwVnPvvheMxMPUcg0Co0OWlFBVop/3JlAC/Lk2JQ?=
 =?us-ascii?Q?kFZVGkf276MfBpwqE3MMWNJBIJFq371jL7d4YVMITwqdySG4OLD8nWuSOxaZ?=
 =?us-ascii?Q?6qRjHNEH4gVB2/huWqe8nv7oBDP1DEX2YVbknv3gcMqmBQWo0oeZlIM8sFev?=
 =?us-ascii?Q?Mj5s+nbhx53NTApPhrhIuZq96uQvGRWlqgoygxyZ0HhWVPyZT/wE7vLRaT1J?=
 =?us-ascii?Q?Ypv6zz/gJYxGsLyJgPnMDMDOW3SWlsPYMwik6DeyCArZK4g8E1D3By9t3Td3?=
 =?us-ascii?Q?WW8okQAnc4zscS7JppT6N84Kmfwddd0+28O0gwiVJG7erfi7y64DTVDh2yr6?=
 =?us-ascii?Q?9YPA8B2lF/QfaHisLpDCY3NcxrNq/vzc71BaBP5n/gKF3RgNYzxR+p7dWNmG?=
 =?us-ascii?Q?eV9cJA6zRbBvedfv922m68wlbZDpgSqmUZIXKs5bJhUapP5tKmXqRPWlHBEZ?=
 =?us-ascii?Q?+vMPGeZtfNNNdaH1IMHckc5Mt9AUuXE3ODZhG+XCeNbupMIhO1qIhzE/V2op?=
 =?us-ascii?Q?v5okgXk4RTsVfY6XOsD3rCCf1dTY3dWPHdJEfp2Iff/H6MnQBckDucJkwNGM?=
 =?us-ascii?Q?cpMSL5F600qlQbCA4/KGomyqpLVFk2YjfOFVXTfqALmnLiHCXsB5+LTLnWlC?=
 =?us-ascii?Q?w+nSPTcTqEGlFzJwD6U7BNYTE3NzX5nDf2dOIItuH0+4q5H7DoWXThL1DP7E?=
 =?us-ascii?Q?O8Z9EYc38cgTwjqr0au3549CF37HKJfkGtKtx2p+ZMrPyhjbme0MtXJDsTEq?=
 =?us-ascii?Q?khstaScjUX4Lp7khqcrAXiQBWCin6HBQFkWPcoDrXi1zqP4yV5Bddcpol5tQ?=
 =?us-ascii?Q?Yi06040TCX9E/xlS4oP/KgFiOVFBawZxyJtzlFF7fEm78ui03iZrsdMgX8eN?=
 =?us-ascii?Q?MKrxMMnvAkqQbLUfCsOgxXSlNRwkaKu68MEjd9FvhQHU/8qgKRY30bndexCB?=
 =?us-ascii?Q?sSQUjEPLQiXQfhoHryIRGI+IbC8b2suhe0Xe/k4uU5tIQwr6EIfvVh5ej2Fr?=
 =?us-ascii?Q?NlAWfu4otyOIzaGQ0+MtUy1j?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff6d365-4bca-4d2a-7fc2-08d90b1823f1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3449.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 14:07:36.1464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZORgdbGQKxpvB6+iQQb2oi7VSOaunZwHbAgjGoyP3uReTUhZi0/Ek/K0vRPYh+YN1sc86OtAO1kuTQVTRQtnug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2315
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

