Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660ED36C0CC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbhD0I1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 04:27:46 -0400
Received: from mail-db8eur05on2089.outbound.protection.outlook.com ([40.107.20.89]:21985
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235073AbhD0I1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:27:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zv84owXkaD+etwqAhRgz4L2Sw4YzLfSGAUrH3uvoNCTT+AwoXsVCLwTfWxThGvTFxPpvkzG27m7lauzwiW8VYTu4j2QvQju/2VKTUddShXuQuotqD9wlT0yEoPalY5j39Ap5juTDwmrFMTLoIyz5+NvgTYWhZZ1EFmR8SbIA2pP4LGDAlNAhFzpunwOtJ3K706SC3waLwvMqmFJ9pgQmAOf5liNwDjfULEd3jDTyjPM/kxbVx1xnuavTUEU4wNZYWhmLKdvO/zebzH1ikZa6t3nDX1/uVKBIRvplqh3iRgT/vh/S0pv6RFmYtInjtN/xZM6uzujiaUVWFWWLTOQ3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr1DsEpzAfmu8pK502bguevhldaWtYtOpsQxzKMNYOk=;
 b=AAANNW5jvbMp6jPNVFLQ3ADDkzQEFczjnVQXG6u5I+VcUYVI0pi0vzqqIBdQIXLJxrV4DiFo3YU76UKJ4mMhtUfkAoy2hlT8wE+S0/QG6Vcqfljh+fW0VNC86wKVw16ytDjJ7TecgBSknEVop+PFJp8RZMzi8AedQEuiLkQG6iF0Tu2UU6OGGyNaR4Dq5fXhvb7meV2rWecKtYV5TVUF7HJrXIY3byDdjhvWirQWoHTyzJRD65ZBUuSj/9nlA8PNqbMFAci2JSdorciOv/nSrWcM+OhBNOa9bp+jD+sJKiCUyugy3dCGgyyB9hRU1Eh4Ck55f8GhZFs4rb7zp1j0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr1DsEpzAfmu8pK502bguevhldaWtYtOpsQxzKMNYOk=;
 b=nU6OxKGIZxExentCnO5lXMF/P4VaXzPN8su0WtHKnQO4sIj5JltXqYXG9h/Ix5biCcf1xvq8MXt6Zh49AxMQlKDLyOYHeXzXJXrkAIjXJDM8hm7y4nsX3W32LBhiTujsihkwKBTvRlW0PdfhE1uz1YJChk8NevtwPim7P0QJxQV45cmjqNWpIT6JH3sJQhqW4a925/fBkxlFbG+jIAqTDJiyd80PjOkbCqINTwXhKNyKSP1FBfZq1BHo/IbREayRsUNai8tVy9NehqEhetnvC+IRBL/XNyT8GhLY4p43uW+ONpj8AUsjgw8NLbAcY+eujuglaThlgk/n1JRfGDvjWQ==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
 by HE1PR0601MB2315.eurprd06.prod.outlook.com (2603:10a6:3:93::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Tue, 27 Apr
 2021 08:26:53 +0000
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d]) by HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::3969:c39b:252e:ae3d%5]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 08:26:53 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>
Subject: [PATCH 4/4] nvmem: snvs_lpgpr: support two bytes NVMEM cell size
Date:   Tue, 27 Apr 2021 11:26:34 +0300
Message-Id: <f9d45694636d7cd16fc339f8abeaa1106ed244bb.1619511801.git.nandor.han@vaisala.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619511801.git.nandor.han@vaisala.com>
References: <cover.1619511801.git.nandor.han@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [37.136.150.171]
X-ClientProxiedBy: HE1PR05CA0162.eurprd05.prod.outlook.com
 (2603:10a6:7:28::49) To HE1PR0602MB3449.eurprd06.prod.outlook.com
 (2603:10a6:7:8a::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.vaisala.com (37.136.150.171) by HE1PR05CA0162.eurprd05.prod.outlook.com (2603:10a6:7:28::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend Transport; Tue, 27 Apr 2021 08:26:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1515da7e-4334-4d0c-8c5f-08d90956360d
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2315:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0601MB2315E1739BA8711939BF3B7185419@HE1PR0601MB2315.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J9rn1ZBHKbUG2sIs1KAM52T6FTCwwI/U/5KAj0y352SiKQesRXRkSMaA090ZQ2Ccc5OMayz6BILWM+6JcKOYP8GWnCiook9upPbb6YERKLul6ThceubtBikE6NCDl0KWoQTt0Rm8K5IqnP2HoElsjia1ukcGlCscp/9OIcE08C2xGxUOw2QdyyU3QdaTKh6hD9wOV6E+v2XzVsmP+WBNEr6ZRfhIFKPjQmyJwYSNiz0tSyHoyKMtGoQc+hXGZA+YXce/RjuSlxSAToUY71D0qJH9qGvply6OuN9uI/+WQNEmq9Jl5izaI7GVuDEYCMaLHPWQSWc5iZ3O9xFjrRESk25N008VOpGsiFYy0AYbyqHwfLpxMhoAA0aU/zHCgtvFE02yjYIDGzQpDXBdwyVMZ91fR2vu4CxFHIOtuGzQdwyLb70Hjvt+gtWBYBOGtey7s7iIR4ZBnYM7/GXyRpwdk51FHg3NNVB6xlfDn71DscdyiCfIv2hu7U+uBgyCWp7Ad4C6oiQQlDXhdvxkHmSpNUD5Behob1NLaA6dtG0GFsqu5f/hPJuKrX0YroIZImhv9fx0wMdA6RXjROBA3T5Dn3qLi3IUUQF6RLFXLzrYSzZD/KJ0XrROsISkakwTBJK58FchtPFZbUrr3f7sijVNBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3449.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(39850400004)(346002)(136003)(66556008)(66476007)(5660300002)(44832011)(478600001)(26005)(6486002)(107886003)(16526019)(186003)(6666004)(2616005)(316002)(36756003)(956004)(2906002)(4326008)(83380400001)(38350700002)(38100700002)(8676002)(8936002)(52116002)(66946007)(86362001)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0Q9Ke7D0R62CMJOk5r87b3euF7tZZNuGFPj1vvlz35c1B6TJP2IJS8khA+GW?=
 =?us-ascii?Q?Z7WvmK9BYSTMZGwyrXbuozQgZkmhUM3u92Sj4WK3dSYizyxjB9EC8YB2R+pJ?=
 =?us-ascii?Q?p/kA4FjkgDghE5aXBXjBjJAC1lih/Hdh1js5npFXHV/C051cHXy4JL6fgJXm?=
 =?us-ascii?Q?RGKCPsCQRFCeludsWOU+JUl04Uyq8/ygJIq38YxZiVR55dcHV4TGcO/2kxsK?=
 =?us-ascii?Q?mX7IdHYfGJsBZMHVZoejt23jet7FPzXDd7+QTii3VP7n8ha2TS8nIWsttAcy?=
 =?us-ascii?Q?CGXsuJaaUs9wArvNRZNZe5OvabEMfGixgQwhWuRIGvTdFlcnLl/1KW6+XhZC?=
 =?us-ascii?Q?Uxf8D4OjoBE8H1FHtRs20NCIOOaqbq6qB/XBQOZBgm8aOkzClb286Q5uqOoz?=
 =?us-ascii?Q?kode58m5X8i+Y5mJKeO6DjymankwY9TQX66lzIhvxaXinjXZoc05JbggNN+K?=
 =?us-ascii?Q?VAnLR0Yl6BtBqCu1yW6PR88VVKg0f2CDZg2wsNM2I2s8XwS+lWfNfk1JD3n1?=
 =?us-ascii?Q?AnufK366/RlF/ftScao6GDz4anBGzB6ay0s3Vz0dLveLB4Bk2LBggANCwgDQ?=
 =?us-ascii?Q?AKOj1KXP0RfcjXBLNo6pAECPeQPMFFa7yTYUinJOXkSn2M6YPG9ec3leNDeR?=
 =?us-ascii?Q?NG/iwqS1i4kQi5R+NtPAi9iCbvo1q4y40XNvnRhdQWs02hyf3GaZgyc1IOEM?=
 =?us-ascii?Q?Fxb08H9PFKjsskDMA7JJx9fZwVfqmYiiHtPQpflBc6yVrNLprdWoKCaR3gIz?=
 =?us-ascii?Q?W38zrzSo4/4Fuo77LOzLexM8wsyN0TOFE/PEKbaVNkscsCZc7fJ3/xQWXE4/?=
 =?us-ascii?Q?oA2rmCKdWcLy7H8pmBzLqPzf2OgfHoBPP5QSAusDtnnhl2Pj8mFpFr7KAMHS?=
 =?us-ascii?Q?X/Wr7jucBF4FvyE+bIuPSR8PtLjxE6L09s6vbkMA6pD1Hj/8PwBqkIWn84Sy?=
 =?us-ascii?Q?d+Rhpt1n5HoWkMywHJvA6fXVHhDxbPrxNsDvwPARTDRFJJ7umxB+Doh+gbKu?=
 =?us-ascii?Q?H0ZkxEJ6d6FQTUPf2FQnLYMD7SJN8hTU7Ij+vKI+fsmmlwzvwaNXybKgV33r?=
 =?us-ascii?Q?OL0HNYi+/gJlhibgylO7d1NrQIL04R0ocWKQd2uuf7jsOuCdAr66ORkaa3/s?=
 =?us-ascii?Q?HmwIRhHtuSgEO3oi1ribcTxqYamecd0ErHGecJZozfN1GXz0p1D+74n8VE3u?=
 =?us-ascii?Q?aZuaZQ+orKwY9i1bRK23IvqyKTngldgPdiVTiD9O28yP5EFYNZx1shz+9RJw?=
 =?us-ascii?Q?0bTpPb5ioKacs5+mky11CGhZNbl/wd2Gncv6m0qX0GAoZ9OgncpwXDEFUau3?=
 =?us-ascii?Q?F0avPzbHJgG0cXpmtrICqf++?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1515da7e-4334-4d0c-8c5f-08d90956360d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3449.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 08:26:52.9760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpBeZTaosqjwR5qqP5Rxf7OD1231ceiU6rnDZ3MPB8eUBzr8U1UOC7hbxoG9DTLceXa3MF+gPjHYLw1slnr3Ew==
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

