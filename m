Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30930415C6F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 13:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240530AbhIWLC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 07:02:57 -0400
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:54915
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240529AbhIWLCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 07:02:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3XGUbl0w6nRg97NNDnko+pSFJqjJFfNEURAP4c9WFqji1+kfnKf9apU6Z6WFS/FgldPT2a6AqucCm6KnVgH3GNf14B5X/6d3Y08Svp3R+YtwQ/Q3Fmh/nmOkIoJAKg7jmR0WcrXpAbmJS5uf5eEsfa1S42I+A9yQ4pKB2MHZARDafTmnET2SzaHEVRnU4uZ5GhBzAqYRwcN+VyivkGu5SCREJwcSSTkvl+Dnjdlrt1IE9m/2nfiIR4KwnFegt1IjVnEb4/X5IWQovyJ/9ZxC2mgpP5OKUdQAxMAU+jGAV5JoM4Ryfh+JWt2NZqR4Q3WhIIelNEsK1LNtgZXEHg42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XkNim5Upv15BilG6gSXnmwwW9jSE+qvZPNitUH82U5I=;
 b=gL20nIKXAL7LD8rcVucgHTfLrO4L8Cgr3Ky6dIDrjE9u7bGln28KJgZsXvyUVCrkq73Lcwz3pTPJWC33CCzIMYQ7Aag2CSiFk9v0vcn4aDGB47OkmXZlQ4T+HKlb6pTNkApFxTbQY0x3i+63Zs6oG7+AdMJoBtu71fEqCq0hskjQfkoZd8esAaLQl95qOKMSdoHAl+BmUj3GNyi4cH9vf3hKzBvYqR91a8EFU0Uge35IOxJTZYR50nae8gByffQs2Uh28yc/SEotk3uBepsaGNh24A5aLgWBGUaEeEPfrrkioDdirvh1jgEuNg0Ge8WA96HJK2Rc8IFhI4v78XZTDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkNim5Upv15BilG6gSXnmwwW9jSE+qvZPNitUH82U5I=;
 b=L4QZBmVkXFvJXPukdejsM+Ktvaape0wsS5VmBE+3ZpSsOChCKK81jTzhaunMd+yKfVDo/qYELNzamrPY1h18nFSMsBsj4lXmFxcM0H+z+DZaJ5rLOkNiJlgqlsnDIW3ryV9/H/iKshEW/RhOfvFJSBV5H0A+e/UbU72nZMTnv3Q=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBBPR04MB7836.eurprd04.prod.outlook.com (2603:10a6:10:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 11:01:15 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4544.013; Thu, 23 Sep 2021
 11:01:15 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, a.fatoum@pengutronix.de
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 3/6] nvmem: core: add nvmem cell post processing callback
Date:   Thu, 23 Sep 2021 19:01:06 +0800
Message-Id: <20210923110109.29785-4-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210923110109.29785-1-qiangqing.zhang@nxp.com>
References: <20210923110109.29785-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:3:17::16) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0004.apcprd02.prod.outlook.com (2603:1096:3:17::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 11:01:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e60a49c-6d25-4f0e-68b4-08d97e81764e
X-MS-TrafficTypeDiagnostic: DBBPR04MB7836:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB78364FCC934925C9621D4BDDE6A39@DBBPR04MB7836.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ilupEI6iChT0D4t+qCxESwUmQbKEUs/JgzC1O3IzFcJHXBSxUkrNKHj++CEN+6UNavBemSDaZxes6DX5jMLFJt1UjEP9SZQyuXkwbktZyM4E19GkUxEVhI52CpHSquZwvi6y4lV/B8NixRgY0oTYTIA2H4Er0P9RZsTojgLeQ2crCVlmM5kbctwBZh0iNCINYWC93laFvxeD+I5kQjOfekNBhCVrdK9xyfiPg/eZwivr5psPtPSBUMKsgqUgv1rvAj8Fk6w6kE/IH1w+Vfqnxaoz/Md2dDNMC6onQAIuT/0w3OInRvRe/ZzkBS3qkfzF8XYMEs6C7ikmAQstZtkY/uBEj3k2EpLkh6CoF4SFmv1F5O+WzQuKiyifzYByD4evHvVxlssXIRYj6fG7jIFkWxffqaWJ35z9+rjtfYmX3RW+uSnd0N7Ozbn7E/LwqFZlR/4bFtTu1KLY6ekfZN2yiLIReOZDtcAaNnw81XW8/bq2aibiw8PO/CPFT5SKxyNxlTy049jcvgepR5+v0P4bYCpfZT96y5oT5y5UERei7ti9G/1mGy4wffgtpFybzSQe1rXwyFOmVePNqfCjkmRmDi5u3y1bkXObDa62X5rntR1W/mPo3i2ez/6Oy5yqvImG5jZ/d7bAGSws10Lv4NSHv1qntzPa3QU7HRDg8eBHtjlmM/CjhJqYy6u/PN6mVw9XRxaZuUO+qKO3yWOLGgRHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(1076003)(36756003)(8936002)(86362001)(186003)(66946007)(2906002)(6512007)(38100700002)(38350700002)(26005)(8676002)(66476007)(6666004)(6506007)(5660300002)(66556008)(508600001)(2616005)(316002)(83380400001)(956004)(4326008)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qDlUGJroz/yRlhbg81+A8WePwXOlqsxp2PvyesB45g3Cjc/3X7G5/x8MSxbA?=
 =?us-ascii?Q?/T9uBOS64JocTfNiRcrPVDJ2MJtbpbPKw+xs4V4Yuydjl89Us0UPViCdYPO5?=
 =?us-ascii?Q?/x+q9WKfU373H+HRITm4OUHdzf5PBYpc6G+YH1OPEQPExf8BXEyTPUj+KhG0?=
 =?us-ascii?Q?HYUyl356Lc5FGweoKwlQYjRai+a+TDB9zXMcrlEfkCv1meiPR5djXwvzPHLn?=
 =?us-ascii?Q?61CmJdj9vOkpnhYuW9ThK2luRDQY03OfVDR4avoD2WnW9eCZyuTOxyNLnBRO?=
 =?us-ascii?Q?5oF7/DJZDmo46B6FOLs46zzndTF/9zlCjhiz7vo4exdM+qg/a1uCs3eoGMUI?=
 =?us-ascii?Q?qBpiy/9BnTkUyI+pKvNUKqcWc1NN5ETXvxh78ZVM4USFgi46XN7nB+89Ms9Z?=
 =?us-ascii?Q?hTWadbtXW4zsTesp7OANA3mxTuvezkD2CvJqWS3qbp727f0jzSol3Gsphp5c?=
 =?us-ascii?Q?397/vO2fPK+42eJ6zVDJAYWSh2PlJ/w0PXJmJkYZ28gPnp075vWbquZa4PJy?=
 =?us-ascii?Q?Ne2hG/JxMVQRRcuDtOc2VKGJ20kwMUBH+6jD0x9v5cUhQqyiqqpwWXvTPMCQ?=
 =?us-ascii?Q?YMc+1pR5U1HJWIZphTEW4I4tIbJ8R/wMb4BeezRkYoBMcTzCiMC5OLGC/SSv?=
 =?us-ascii?Q?wAe93HGMMMfQOF0AvyYBH2bAYhYrD74Yy3md9pdQoIkN+BNdL7e+KNq/YdKl?=
 =?us-ascii?Q?2b0Xxv+R0/QwYOxYfTLiKhy4DzJG6ZF05ZqQNrrG6Kx1LZ9TK1Mf9IL6sN/r?=
 =?us-ascii?Q?fySz+3MTnVZjdMcieVp4MmmjH2i9M6ThYb76UkAMhSaZTMO0Sdce1YbpABeq?=
 =?us-ascii?Q?Hjs1IXMggrq0eSkDnl8oYL8ekQUzWZX+OxNeC11fH85TORjYQnCmdVoi4pTf?=
 =?us-ascii?Q?HkZngo1ruN39LcPtZdsFigEJFblv57c5mF3LVz+L2HUsYaC0OXwFdv9G5vq0?=
 =?us-ascii?Q?6budI49L7O1DNw9JRJIhFwiPaHsDKd5I8n1xunfpycQkTl3Aue/9TuhQtGQi?=
 =?us-ascii?Q?EmIFHA3cLBNHJA1izC5Fs3YhjPpOyBHJaZrSaKnIxtq3wArx9lGuLXKcb50t?=
 =?us-ascii?Q?RVFiTF2ze6CBw+K11wEUH3qktpIeQf1uySWx3k6t9FqbBD8XORm5J9PnUx0V?=
 =?us-ascii?Q?B/xEuGozjPFGvOeQn3W6orX41Fr5lMI33wwkMTubyEPjVL43p0zfR06G3kBt?=
 =?us-ascii?Q?dyMAOzc5TGSMq8HV1iKk7fzpidyWD3s74iSdkbprh8bVUP+JPGl0BbLUB248?=
 =?us-ascii?Q?LrukQLL6aJcUtEyUsqYB75R1qt/0KVeHDOjblHiUh6ZvUuUOLpSGc8YyuN9Q?=
 =?us-ascii?Q?DfSmRVy56RdvmCYgLCHRJ9ZN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e60a49c-6d25-4f0e-68b4-08d97e81764e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 11:01:15.2218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nllJNar/ApKDLezkzxjXD8Cb2qI3GRFdgolxxyf34pzZtVy3fhvEL6+r1ABcdkl8YnAZE6UQ1toqt5oKx7Tcyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7836
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Some NVMEM providers have certain nvmem cells encoded, which requires
post processing before actually using it.

For example mac-address is stored in either in ascii or delimited or reverse-order.

Having a post-process callback hook to provider drivers would enable them to
do this vendor specific post processing before nvmem consumers see it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/nvmem/core.c           | 9 +++++++++
 include/linux/nvmem-provider.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 23c08dbaf45e..4f81a3adf081 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -38,6 +38,7 @@ struct nvmem_device {
 	unsigned int		nkeepout;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
+	nvmem_cell_post_process_t cell_post_process;
 	struct gpio_desc	*wp_gpio;
 	void *priv;
 };
@@ -797,6 +798,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->type = config->type;
 	nvmem->reg_read = config->reg_read;
 	nvmem->reg_write = config->reg_write;
+	nvmem->cell_post_process = config->cell_post_process;
 	nvmem->keepout = config->keepout;
 	nvmem->nkeepout = config->nkeepout;
 	if (config->of_node)
@@ -1404,6 +1406,13 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 	if (cell->bit_offset || cell->nbits)
 		nvmem_shift_read_buffer_in_place(cell, buf);
 
+	if (nvmem->cell_post_process) {
+		rc = nvmem->cell_post_process(nvmem->priv, cell->type,
+					      cell->offset, buf, cell->bytes);
+		if (rc)
+			return rc;
+	}
+
 	if (len)
 		*len = cell->bytes;
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 104505e9028f..be555bdaf189 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -19,6 +19,9 @@ typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 				void *val, size_t bytes);
 typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
 				 void *val, size_t bytes);
+/* used for vendor specific post processing of cell data */
+typedef int (*nvmem_cell_post_process_t)(void *priv, int type, unsigned int offset,
+					  void *buf, size_t bytes);
 
 enum nvmem_type {
 	NVMEM_TYPE_UNKNOWN = 0,
@@ -62,6 +65,7 @@ struct nvmem_keepout {
  * @no_of_node:	Device should not use the parent's of_node even if it's !NULL.
  * @reg_read:	Callback to read data.
  * @reg_write:	Callback to write data.
+ * @cell_post_process: Callback for vendor specific post processing of cell data
  * @size:	Device size.
  * @word_size:	Minimum read/write access granularity.
  * @stride:	Minimum read/write access stride.
@@ -92,6 +96,7 @@ struct nvmem_config {
 	bool			no_of_node;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
+	nvmem_cell_post_process_t cell_post_process;
 	int	size;
 	int	word_size;
 	int	stride;
-- 
2.17.1

