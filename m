Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C67E40377C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351401AbhIHKFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:05:09 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:3824
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345759AbhIHKEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:04:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoQ6bi/fXSi6pdpvpyvCfQt/YRolUN34KBgtFRW06hGaV5LEyp9oTyScgIfGRlVWg5W/wLPlP6Nq5fn1IaQuDNP3zRKsIjWmta59MxAx9QCORBTzznOUxQ+DJINo76qvlQqRP0QFoUn01t2BLs1dz9LDhi+GwS/rfjt98/kvzJ2jcvDUcnw7ISNsh2/pU5qTrCJs/9f9av92uwMdADccsO/ohOvKxvFW1ZvXAOa7VaToZGRSWmiYrEta7d7T2xlvW+rmGvt7piP9gwtVTzz8YvGwQAEB7zuFYTV5vP6R4ntzGX+WpDglmR8guLiCmYisjJ0wHXws80yTQTnvsF6xEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xPd0T8X36HrsNg3vw5kvSnuqk2oEYo8T3/LqfwdTLJg=;
 b=ZDZwhQdn1ctAeVwt4xyBgVXY13C4ZbXJkSfDw/Z9cWvvmLpiDkWUweLxIE93uvUdYYpferyLTVYyJMNfc3sipuTT3TnPtcDV1PMK+0xWhxx2ZnLI8FQnek4SDNLslVbS1TXXf1lWWk9Z7j5DRkImZXdQfYZ6lsGYogeanCy/Kxqt4owjsOhvPD6Ga9i00NTjRiDOKo6j+RQTY0DzQvmPc4WmHGrJ5eSM42hO47L5K2OSyWPfNusVH2bfa2XStSFtXgUPgraZJFsIGdExa+R+u6EAYn8l5JaoQmIAF860DtbgTUc2DYS8hLZJLvkrAAsRTe2XEtr20AES8VP1gPh6Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPd0T8X36HrsNg3vw5kvSnuqk2oEYo8T3/LqfwdTLJg=;
 b=d2aN/HyML1UbrwYDfghbaiDbgwPAdTucdDC1ylxsYPAIBwErvK/RqM557hDuNARctlSGnmg6+8TQL9is3obWmEtQYFYroUws7gEHKXOBITFjxTxI5xgJ+lDy7DIasFv9NisE6JaKYtCm3ZBTkPPeRqbW+ufodIzxKA3svhsXHe4=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB5786.eurprd04.prod.outlook.com (2603:10a6:10:a8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 10:03:15 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::5d5a:30b0:2bc2:312f%9]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 10:03:15 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] nvmem: core: add nvmem cell post processing callback
Date:   Wed,  8 Sep 2021 18:02:54 +0800
Message-Id: <20210908100257.17833-4-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
References: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0105.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::31) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0105.apcprd01.prod.exchangelabs.com (2603:1096:3:15::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 10:03:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31b81180-6234-407d-3803-08d972afdfc7
X-MS-TrafficTypeDiagnostic: DB8PR04MB5786:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB578667155A181CA37C4A5A12E6D49@DB8PR04MB5786.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5tGx2RboWvuMBSyJ3NfXUr1ceYoUnRyvmFcOMU9t+2ijxPpGek64HLVb/Vss4BJ/yihr3W+M2rWZngCxhPD2+8LPTwQcEQqQAOpKYonk5H0DSXARnRCs9fmQyqlfdDGuebpWo+9X2OL/3NSiXbziWwcnJVn2j1bjYyqPbbj5lKt5AYCsxGFewSF+GqyX9E48hmwNRiv7HIvOtElv4y2z1XlslgoVKc3Bi8lejVrOYi44lwa0r9AD3flaNkWnCfUTQwv3lfV+fRLw3UbmPmmnsmnGcpH3h4BKB9vQuJ0D82JYlBixbheUIGobNjYWtWuDVZVj90P5NStULEHQvMqBrW2L+DDamUYGQhZ7mzvlk+FY0Wit3egvtteZk8utU0mEPCL+6TsbdxoXd2ibSZMopyI+s4XfAgQtbWhX2LcYSCfCsoUdCkyj+ZX3X5KxYT5BN/0qU4srPBrs6iBcJNsROlWMZrNuPdI9K1LTKHq3o/8/+EFKUPQF/8DHnqw4f5/uNhmRcFTvQRb+uQdQSyO7DfW2bue9UVs8rqlWW83RcYzVDm1lnrl6xPfePm0ovg6k0CwZlqRxN+MUdbRZ8NXhC4Z04YWQFvDFzbT68Z46AvakR0nL6BI7NIHbsBsns2bw9vVDG7nqGE40RxjnV/6s9Ao1kn5PVo4RWG8Ap5TarUoWy+dtkEtFokG0EII8Q2EDd/Svti8xMcDhSO6we03dlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(86362001)(8936002)(66556008)(6486002)(8676002)(38100700002)(2616005)(66476007)(956004)(478600001)(38350700002)(66946007)(6506007)(316002)(36756003)(52116002)(26005)(5660300002)(83380400001)(1076003)(6512007)(4326008)(6666004)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?loQoMZ1oTYp2vYGRAuajUH4fEkTuzGdlz0R/w9RCOa95fXnuvPvcqtuclh3+?=
 =?us-ascii?Q?jFXZr8BN0r5HxQbJGa7wovEpxc7R+QA8174jlXsO5Jiqy7t40EZ3sskpCgNy?=
 =?us-ascii?Q?4dx+eIixeFnX5DDnwG+F4uqwqCp0z6uZ2Y+6TOjfbNTyOdXvvWBWA/Q527Yi?=
 =?us-ascii?Q?wh3FxNswGnU/O+ru3O0SL9AOQRUJbO699+mLmeJ3cKmE9fIhMxpwvNEA7GHk?=
 =?us-ascii?Q?q8sO3sAxRNPsYHLYM3c3FgtvIHxSkN3+p4g/n7C5+wHj+FUK5zhSmzjqQyo3?=
 =?us-ascii?Q?CqcByLiiYBEWbt0GLVXwoqX+STuZGbX96N3w81kFXzI+NcGGEbLm4yAErJkZ?=
 =?us-ascii?Q?cN4Os296cJxR7I4h39KeVZxg/H+tnoGB0nX8Ya3p/L49EPNcJFHNxfRdiBbf?=
 =?us-ascii?Q?+TuMOasu3rSr5SXM9hb+06qOtY7E69PsKVRw3EIC1ECIwu+mb7e203flmi33?=
 =?us-ascii?Q?7buVLnnsjxWzQD1mSNQ++D0cdnfpVIfpdMLhE0xhKv0dvdSXTvm2J0a1rDZt?=
 =?us-ascii?Q?3P2k9BcmExmzE9LYxo2jdoK+B3mRyX/kCxYnaX3dGq1BU6UyNU+2Y+5oFuT1?=
 =?us-ascii?Q?qYEgJM4pBHOiMmMiR2hW4tQDBS3F1vxmPKUswDjO2j+q5BActJnLMjBdsGHn?=
 =?us-ascii?Q?09SRxUCeNmIsvtLgb/lWm/WSvRjDtm4xZAIvXpb3QGdYSCaf9M8uHyZTdE6H?=
 =?us-ascii?Q?nYKkcc/Dws5Jvjz1IEpeQXt19iFo+FMh4cRTHiHaPAwDzY6ZYWSFHVBy7Oi5?=
 =?us-ascii?Q?lkQ7yE3FNjzpeUn8SdyM9znYJEcNX+RLt7BmxYf5PTa6/UlM/RXOPL/jfI0E?=
 =?us-ascii?Q?XmJy28+6SYFRAPE1VYZjEPhEs7CF5crGhcu58A4AFa0EjMkyDN02ZHWtzOG8?=
 =?us-ascii?Q?0lH6qjT2fys8CtGMSjK8GZJDxkGiA7XrkkJ235S7d2e7XGq4d5o2b+qzYKdR?=
 =?us-ascii?Q?O0/dbUuuJeWeLMKTIyZWw/mb/dLTtZUvHxBtKZTVTT/WfIThwshnxgsOWhKQ?=
 =?us-ascii?Q?tweoWezIkEH/YzfnRrLfjLPa3C7nlyqP7oosDMtQbWaOls8a5q4bfcrPsu7g?=
 =?us-ascii?Q?Z7jWr8N8MUtnSj/Y2AyumGUy0qID6u6h15IESLAOZ2JwHvCLaWUfc2HuJS/X?=
 =?us-ascii?Q?0PSQR8rTP00SVdzplHP4r1wQhPS94uIxfGDxsGqe0A1c6BabMfB6LOIHTjx0?=
 =?us-ascii?Q?05tWIO7rOuMSz+leakGqbdw16d0gug1zyALd48wNvB3Q8poqNYZ0/JPmXymH?=
 =?us-ascii?Q?Eg63L4sSqSYr4mWRisBtS4mAnOvAX3RPqrQB4brahUhrZroJghXMHOlOfNfo?=
 =?us-ascii?Q?8tBR03Ed9EihPcMT2DV4MOgy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b81180-6234-407d-3803-08d972afdfc7
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 10:03:15.0377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FsvLsP3PjMqbJ96Yubijc7qQ/UNht5rA3zTKYbqhKaSdyaCjlSq4neYPPNzB4zSZqdFG9Oi3IKMyOzY3cenM5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5786
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
index 104505e9028f..d980c79f9605 100644
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
+ * @cell_read_callback: Callback for vendor specific post processing of cell data
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

