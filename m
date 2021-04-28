Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBB436D8E6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 15:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240083AbhD1Nvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 09:51:46 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:34482
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238737AbhD1Nvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 09:51:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVrUQ0WLMBe0k7oOL9i1omnMp67K65nB20LfMfmRBlowr8j7AIToEfetZbeQFaekQNqVmb+nDzsTApPXMPj52rtPegt6mFhFNa8/qAzNMVLFGrhoIvTS4r4yMndGrVSmRIm8pXNZRanqwwnzV7CIDe7RsfL1ybr/Kon27GCudkBQ8LdShuSFk9VAE1TOBV9T2zniRlkgmBlJimrLJ3QNZmEpidbgqWC69g0zsGH2fjH3Vl4aOsxiFFy3MoggFirkRY61Bal6q4IZLAh817/TSa6NdVWO+2dEkH8PQ8o6E6wy3ShfOpl+Z3Th4qg+pspvkbO3ib7MzrojDNXWs3NL4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr1DsEpzAfmu8pK502bguevhldaWtYtOpsQxzKMNYOk=;
 b=VQ5nK1NCGane4xkzHh4NJGnMxe/3Q7Lv63O1a3tn87Ak4L/5YSJu2ZPLmCxgfqSGNxYJoG20NbXJ5D1gxWciYqEnD/n38qzbxsr1CGzWqaFaFyJAUBbEGNCJE8hv6t6OLy+4BH8d64ZhfVYw/EK9W1b1dzbKU/YSI9SKcF07yzDYU4KBwhATXF959msUGwUyMtUHPGtEOeujxg8Un4I2WCPFHvxLJtBIb8F8FWJ3LaB62By7OETr2YIDGlh+2AObOLFZGVpIpbc0Gi2MMCZFYS4q9CgwiTFge6T5+Jzeo4zSuzBVAm6ypT+XS2yBGy+SstOeAeR/Lhbx7pYETk5SRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr1DsEpzAfmu8pK502bguevhldaWtYtOpsQxzKMNYOk=;
 b=yWpMp8KCzrNkhu1QFZdz9ypc6rbCsO8EIckku2MjimEKZgw20SnjeJ0pj3IO/6fLRiokIUzYK2fmTMzobwhJ6P4XPS1Uwp2Tf0dQi98BoX32ASuLAKPUlV+M8qHT3rU7aS35RvzYTwvF/sGTvJXwS72PoA+KVaI0JX8tX3Y1bBBduOuq0ylhyzro+QjOaD1cPZITuGLYHQRnAEWclwzjzTPVxkaj+1WpOYl4FWUDr5aWZeW51B5Pfyn5RqAC4n2XuwBMK1bcSInoaIDZq5lk/JWame/SqhjIIFONQB8/KT7igAWUZqcGLtOetmClPcvKl4DMyQ1ld8aSt8iJKp2G2w==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
 by HE1PR0601MB2361.eurprd06.prod.outlook.com (2603:10a6:3:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Wed, 28 Apr
 2021 13:50:51 +0000
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d]) by HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d%5]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 13:50:51 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>
Subject: [PATCH v2 4/4] nvmem: snvs_lpgpr: support two bytes NVMEM cell size
Date:   Wed, 28 Apr 2021 16:50:41 +0300
Message-Id: <149346ffe06893dc5add7f9a7e901ae03eb940fe.1619617498.git.nandor.han@vaisala.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619617498.git.nandor.han@vaisala.com>
References: <cover.1619617498.git.nandor.han@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [37.136.150.171]
X-ClientProxiedBy: HE1PR0701CA0067.eurprd07.prod.outlook.com
 (2603:10a6:3:64::11) To HE1PR0602MB3449.eurprd06.prod.outlook.com
 (2603:10a6:7:8a::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.vaisala.com (37.136.150.171) by HE1PR0701CA0067.eurprd07.prod.outlook.com (2603:10a6:3:64::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.17 via Frontend Transport; Wed, 28 Apr 2021 13:50:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcbf5714-361e-41b6-bea3-08d90a4ca2c9
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2361:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0601MB236109511D57A512D0B77D9785409@HE1PR0601MB2361.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KRswsThjlCPqu+PwOjSBxC/Vl6gTySLXqXpSehNsxQ5L2qMk2ZO17oSh4qcO3+40GA5T47T7mx4Vbh+3N3JeyWsthX8hERSuiN5GX4TC4M0Ao99lNGH8BwcwKTD0eBZ9tfHC7DkLVBWxsPw9axn80lzqY90SKCjVJY4/3mH5IZGviNYazqebV+3tGX7mkepfOacLzhbYsrcKyJcYICOXtlCXg+10XlnSSbnXajC7D+fbZOmPY85WdswtC/mgXF/qOu+kQyGZoS6rxvlCba0pmDqLDI+ifo4KPCYyOHma0okX20o/7PopXo8Oss7n9F1DqGs5aDdU/xpJRQovo+ofZASF2ihXhgwCnLVn7UodODpkrHjng8G4HzvfgNambPQxQr+sh3bpspkA5/Jh2rLgawVA+yll2wmHzHHV8Bddc6O0kWPwCB4MiJen2dTUDCmGAlbMdeWp8N9GmRgk9v1ykr1VD1+3BUPXRi5ZzizWvvMFeH8d75GGdtZCQsRa3NIcxy7YR+DU3ND1NPpWSFA0QlxQjEki2hJd1ApOguYXiqhjQPVmR0ovHbiSVohV86MaorwHz8U0Uvez5Q5he5UrwAutyEBPm7V8I0KpZJM2L5/m4Qn2wv++d9X7B+p/4G7as4AwWWpZxEJGdiMsfBxpzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3449.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(346002)(396003)(376002)(136003)(5660300002)(2616005)(86362001)(6486002)(66556008)(26005)(2906002)(107886003)(66476007)(44832011)(8676002)(956004)(83380400001)(8936002)(4326008)(186003)(52116002)(316002)(38100700002)(66946007)(36756003)(7696005)(6666004)(16526019)(478600001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/JockMYRf4CB52wc33n6Mm4Yp181jEkm9XsUMqdBSOjEpyOEEPf6bttaM3no?=
 =?us-ascii?Q?E8XpstdUdCOUeY/x1yvVwWdbyTJkfUod1ofB6K3Lwm+GALajRv5VN0utMJGz?=
 =?us-ascii?Q?QvbJxGMj5p/YXz7BqIjqaerrJyJe/GoJgXeBvTOypEMJOv9IRTiN7yF0mgoJ?=
 =?us-ascii?Q?XTiCMjlWhUgHdfox3PAMaODHxGyJr2Jpe62vug7I0jvzA+//8dcktYEcyIeD?=
 =?us-ascii?Q?uDowPO/skO+6AUZTAtqVtLvyf+ziaPSLR4x1UOltSVeFVRA+phq//ROfdjcy?=
 =?us-ascii?Q?4HXGdMP717Gw0TY5+yJOXbzHfhuET6BZzmd8R05R/eKnA6owl6aiOhbSYNsp?=
 =?us-ascii?Q?Llixtvzvhm9q73r/oQpI/VryX+da6p02J6sllGafwpD+FLpG/2ZyKU0YbIAH?=
 =?us-ascii?Q?KtOWvtRHBLGZc4tVrFBxG+GgYM2DrgwBaiYqjGvXGoiYDi+B0fD7xaO/iUKr?=
 =?us-ascii?Q?M8pNje9XBdGQ8wefPuBomTWXANqBvkracRupoUyE7w/5d2BtVgsLuhO2F8d2?=
 =?us-ascii?Q?TfmxV8nKovVbtDNSGE/GCT/KkbTU39ysSJwN/9RVhngZ7cwdx/Q5MLsJwZJf?=
 =?us-ascii?Q?cYO2QxhBBI0t/7f28JFigo1wcHrQBkMycJJ7z7bN00u55QtSjcmcHt7wZQ5V?=
 =?us-ascii?Q?I/h4bKQI9lm4UaHxdFWmQbPT9yJhikXbl3W0nQ8PVEd9sPJn4tvpJM6suqGR?=
 =?us-ascii?Q?+BNn288HpRYb8riB9eZekLD1kaDr6KMq4wI8AgoNMI8E9u9lRWJpVFmyoCDx?=
 =?us-ascii?Q?WmxViJ7Bvdm7uywO5lQeFcuO7qh7BM/YdjEZxjsmZ0PPlQtje/NljSxmCSAD?=
 =?us-ascii?Q?7RphddAOIqBEFmN3mnfd3uoTI3mI9TJNkmwg3srT4RjsFg1mb7Lqo7defXuK?=
 =?us-ascii?Q?Z5YfFTL0hDg0+WuITqOOYMwDmbk8JNXLkV8RlzxGfcdn7sh4NuRgDRTpdz+a?=
 =?us-ascii?Q?zwE1iyJsYHE7akrc8UZE1XuSRxVkLvSJ1CyzxYHglHRM+JSuCFN5gkExkKib?=
 =?us-ascii?Q?0NwWtYqcwVS14obPeWMJCN3KinrEsxfPm6s481c2HPyGU6mnInVrW2CDStWK?=
 =?us-ascii?Q?06kywsw9ZdtXk9B7+CstYK9aP8HUZyLu8DlcKw1QZTVUjrSV6/RT+4JpFf30?=
 =?us-ascii?Q?7EJMif0cnJBQ5CWnb4KXY4XCAbK5VPo7yjXsSzJJumYiJUKHg01oeyaJYu7C?=
 =?us-ascii?Q?rxTtp6sEB9B+iLSr4Ih46YWx22DGt36Gr33G68BoJ39cUeaQ111RjISX/Yxj?=
 =?us-ascii?Q?6JfUrbBKCOSTGL3bkKjmqEFa66H1PZyha4IXBBXVdF8dl5M2o4LsGfNwSuiR?=
 =?us-ascii?Q?IW1IRrmrnZOeo08j6cLemdUj?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbf5714-361e-41b6-bea3-08d90a4ca2c9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3449.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 13:50:51.6687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DVugejwn1rufk7kOajpdlo6rbqW6eHg0b6uZdpwnW+H7CQRlRTKfGc/RHqyE02qJ14et7IDSXbA8mQVjQAkng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2361
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

