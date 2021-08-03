Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C418D3DE8EA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhHCIvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:51:23 -0400
Received: from mail-bn8nam11on2048.outbound.protection.outlook.com ([40.107.236.48]:30273
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234768AbhHCIvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:51:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQcw5ffu744LogvHu1/1BYZkZ+E6Lc2grrd+TX3vo80YZomLwZoIjXXLoGaCOTtEuMdsXEvRoPbQ9Yq/XFdRzURT/Ak3Ap6gu5sZ9y4wkc53Te5mBBpCx9DiIVEiY0xmY4DVQvayGPRLBEOV70C1Uf5VN+KcbiUvzawDV/qS44Wsul68kPLWPOpcFgsBGsnYncIptVmBa89oL5Vz9NrkfIzv5vtj8e1eFSRX/AEwMGGc5Eqnigg49Yf1pkyxP4QOcfVI4TcYCcNajC76JVpcb3aiaFrXHT+gjMNtKgurePCaznfAT5TAbclhzh0Ht8uaVL7Ffm0nfFtru8WGiFBukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AO7yUfjXTPeJmOG/GmFDEiCyag57fyPk4LIaD+0E9YU=;
 b=WE7HRIliWPArQZVJEtC/i5Mg9ROlmiwT3SdOBNoGe1gISnzMo0Uv8QdjfoGhhL3PtqzporDAIPaKllqab9NykrKbBsr4xy18zamwPDLeQ+WiKknEZpygl1m+Su1KvGhAuM/EA8lMphEqjwX9zmOg09OEwuy2Qd51fs6CkoDubQ6FkvyXsFVZoTwWW3QpjRnGiVVGPx9cOArK57RDhUioW+yM9ZoUQLhk5u6oV0Q1Fep/f5rQp9mm/5NkhhZGlrfxwGxgIWAYKTna3u4QsNEKmAUkbY9YDAQfz9KlpdM1zCjODoMtbVNyimB+gxdhmQ8bpLw806eANxXVFepwYe4SaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AO7yUfjXTPeJmOG/GmFDEiCyag57fyPk4LIaD+0E9YU=;
 b=cu198HaPUAt4ApQ3gt/iezsCWfGXlA3S1DnJDFW/KGX16UIh0nBWhoL2oNfpYzjN+yw2s8Ryj63cjq2SxAJP+MqYmix4XjvK5BoD37kkQkChdzomL6SnVPE7tB0piqTq/lRBIL7+Rmv8E7ptN0rGYZkc3bDUOl+c+mpaiqeFdK4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN9PR03MB6090.namprd03.prod.outlook.com (2603:10b6:408:11b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 08:50:50 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::5ced:deaa:371e:f124]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::5ced:deaa:371e:f124%9]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 08:50:50 +0000
Date:   Tue, 3 Aug 2021 16:50:43 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: sy8824x: Enable REGCACHE_FLAT
Message-ID: <20210803165043.042ec24d@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0008.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::21) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BY5PR16CA0008.namprd16.prod.outlook.com (2603:10b6:a03:1a0::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19 via Frontend Transport; Tue, 3 Aug 2021 08:50:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ca9c704-7831-4933-adf0-08d9565bcb6d
X-MS-TrafficTypeDiagnostic: BN9PR03MB6090:
X-Microsoft-Antispam-PRVS: <BN9PR03MB60902D710EC1E3A92016615DEDF09@BN9PR03MB6090.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vd/027NtDIXwS47R2i/3YVYYipaCt8aXhX7PveudllELwDLGxn4OvN70OODGmZzDlKJtjdNqE/yuUZ+byvwdI/RL8EZc0KW4D/XWx/8lB1EO5o/Dw2E5ugZC+1yOSioAhXm4n7IgB4A8mO/yl7/lBpVrEY+wAUUfJtvWafuxtIKUt8T9sEliGhU+Pwy9bLkREu+kDtFq0XEy3KAz0REsS5HIkprgxFX45k8fjp9HC33o9IO5mF9J8EM+xoW2iRW8Vb3XGoWNTIBTGJDa50h4pZQBfiObSYA4wonPknI+uLTPKPrFWvrM/cSmkkEs/FgbUjO0Ezk8cw311cqr2tLRa1yImg9vQMsBr7k4n/FH9gaki1p6LxshpYXSCTOVcKdPW0u3jFFKxkBemfISd6qhKMZ02vQLu7mGe+VowCvqpbGuGL0Yz7+ci94c2VBPO7qSiEGyBzZs6CxHcXd/j/zmhNaNOQ/5tDUEAIz0bxLlkfnjVk9/UGsylVkj0LsX6NsdUT3+hQeso5crQfSWj5dHTnjBDI+nJnYI6N3iFVIOIpSxS8C2Mnbiu+Jzc8yItBzQJYAl1+vFQ8wfjDhT/n4e5YjFU4KWW0QbdI/Ut52saP5ugZtV6pVbX4CQrpcaxSgYxQbwriY2eucY9f8+PbmWZ+x5dJ1VNM/rZ0zMeeZ9cke0tCii5KPNDEMmIjnCeQ5/smQg03ry2zy2ND1pMZqWdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39850400004)(396003)(136003)(366004)(55016002)(956004)(86362001)(316002)(110136005)(38100700002)(38350700002)(8676002)(1076003)(5660300002)(83380400001)(6666004)(478600001)(186003)(9686003)(7696005)(6506007)(26005)(2906002)(4326008)(66556008)(8936002)(52116002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IVUGgT0qn+yNorqrE1PiOl1zFKFbCTc4Zl2o4TD+N9lLBKvqSYWr22UmI5oa?=
 =?us-ascii?Q?pHB3H30DQvvrOoJgohSKs810gMWraj29dQ89P5Lk2Q9pXuwvV1m1UChW0I0B?=
 =?us-ascii?Q?lI+1fHnyWCC/GGgcx3G3X4jNs6qC3mvS68axy0FxXdvK+bqMIHkeX861iJNi?=
 =?us-ascii?Q?qlsNIoa0e3H4Tx8UQb2G3/dfNYw1qyKDND36biS4Lgou2xuvCPlRUUXEtKJU?=
 =?us-ascii?Q?hTmoahZ44e30nTeDS+WFiucqq+fflJ5ckEV5UQBS0NSYVGfzBBVKgIH9PQUl?=
 =?us-ascii?Q?YQQSd2AMGgoKw9E/yvM9875Wa+AhAscW9wNbhh35ZhYUGvBsKnW7bdfvShWJ?=
 =?us-ascii?Q?v0ji/Dwry5d1/WrKUt/GQUa0LXQNIQqMoMOTObOewU8faYwvwEJUP9MAWPFn?=
 =?us-ascii?Q?sUzHP74J2YCVZgvsZ6QM3MefzJOC6zkfGLKgRCZVCGZMhhZnuiN7XMwk2RMD?=
 =?us-ascii?Q?1ZfMwQupQ859CDWaPo6RDjjNhUB1JgcU9nnd1ScdH+MzjVoyG1J9plpCGRPi?=
 =?us-ascii?Q?l9o3pkTQBrvhe3Ky0BI3U0GdoW7d+Po6Hh/zutGMEh7TyQsKqEsrFuP0t3uL?=
 =?us-ascii?Q?AYqSbfIHQL7m5SLHcAhVGw6zDnWEmipzpvM7UMu99uQx8RLeby1PlW1L/iPa?=
 =?us-ascii?Q?TzTAgKn0W3WJP8JptARr7Hd2PcC00/fbVF4g8BP6S7lrEmswcf1UBI+p58/j?=
 =?us-ascii?Q?fsB/9tV6gMhPIVxNnYZI5w/gFwmGheL6LoNBc7FDOpZuwgSO8yM19eexLx3s?=
 =?us-ascii?Q?3uzsjwlH/2chOJAeyIqi8WLgegcVDSVW9Wy8D4hIOLr5h2jV5msVBSDx7t4r?=
 =?us-ascii?Q?xNiVHNrclRZSv83d73t4JrHlpfjUeRivLizpW0qQnzyw22/cSxUGY3epo6jq?=
 =?us-ascii?Q?NDifD8aGT84CLlo1A6+6FWXPA5fxg+QlW7Zko7nBfayDSJB/uhEw+EDisyf+?=
 =?us-ascii?Q?AxVHIC9Ky1lwu3tyAXq6BG3KSFhhv7tzSNOHCzoKuhOnLK48OkhSEZ2jZsa2?=
 =?us-ascii?Q?3Ez/Oi/OCahvzAixIr7/WRwuUsfWkUNL8xt/d48b/LTVAoUvChlKFevPMqGE?=
 =?us-ascii?Q?kkriEw8Ch2S95a8EwAFf+UESm5ztEN+m/AbM+wF0g3UupPdvLSs5asanyIHD?=
 =?us-ascii?Q?t5lKtVDyIO35NMbJnehqYsKjWJZsdRwoqKFxIs8LLmJpzxdlfY4KSehJCMt1?=
 =?us-ascii?Q?Jbdw61gU0cLRyjyGX6/oA050Advmx15VexRRJNCL/NVoLRaTwAJCDqooQ6P6?=
 =?us-ascii?Q?FrT1en/3ghdH+sThPfWiEychwWl+fXwSsTx/O8mRxOfQrIql3wZnYO8KGFC7?=
 =?us-ascii?Q?DwD4drAwB2mktQ2s66kSU60H?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca9c704-7831-4933-adf0-08d9565bcb6d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 08:50:50.6054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pymS3ZRcacL3Mv20KRrj71LiF6kcKntkWLiG75fJPQ8P4gyEuU0GWL+cNgXln7S2fSs/PbS3cGTKHm8FvvUc/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable regmap cache to reduce i2c transactions and corresponding
interrupts if regulator is accessed frequently. Since the register map
is small -- there's only one register in sy8824c and sy8824e, there
are only two registers in sy20276 and sy20278, so we use a FLAT regmap
cache.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/sy8824x.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/sy8824x.c b/drivers/regulator/sy8824x.c
index 62d243f3b904..5e915cf307b3 100644
--- a/drivers/regulator/sy8824x.c
+++ b/drivers/regulator/sy8824x.c
@@ -25,6 +25,7 @@ struct sy8824_config {
 	unsigned int vsel_min;
 	unsigned int vsel_step;
 	unsigned int vsel_count;
+	const struct regmap_config *config;
 };
 
 struct sy8824_device_info {
@@ -110,6 +111,15 @@ static int sy8824_regulator_register(struct sy8824_device_info *di,
 static const struct regmap_config sy8824_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
+	.num_reg_defaults_raw = 1,
+	.cache_type = REGCACHE_FLAT,
+};
+
+static const struct regmap_config sy20276_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.num_reg_defaults_raw = 2,
+	.cache_type = REGCACHE_FLAT,
 };
 
 static int sy8824_i2c_probe(struct i2c_client *client)
@@ -134,7 +144,7 @@ static int sy8824_i2c_probe(struct i2c_client *client)
 	di->dev = dev;
 	di->cfg = of_device_get_match_data(dev);
 
-	regmap = devm_regmap_init_i2c(client, &sy8824_regmap_config);
+	regmap = devm_regmap_init_i2c(client, di->cfg->config);
 	if (IS_ERR(regmap)) {
 		dev_err(dev, "Failed to allocate regmap!\n");
 		return PTR_ERR(regmap);
@@ -160,6 +170,7 @@ static const struct sy8824_config sy8824c_cfg = {
 	.vsel_min = 762500,
 	.vsel_step = 12500,
 	.vsel_count = 64,
+	.config = &sy8824_regmap_config,
 };
 
 static const struct sy8824_config sy8824e_cfg = {
@@ -169,6 +180,7 @@ static const struct sy8824_config sy8824e_cfg = {
 	.vsel_min = 700000,
 	.vsel_step = 12500,
 	.vsel_count = 64,
+	.config = &sy8824_regmap_config,
 };
 
 static const struct sy8824_config sy20276_cfg = {
@@ -178,6 +190,7 @@ static const struct sy8824_config sy20276_cfg = {
 	.vsel_min = 600000,
 	.vsel_step = 10000,
 	.vsel_count = 128,
+	.config = &sy20276_regmap_config,
 };
 
 static const struct sy8824_config sy20278_cfg = {
@@ -187,6 +200,7 @@ static const struct sy8824_config sy20278_cfg = {
 	.vsel_min = 762500,
 	.vsel_step = 12500,
 	.vsel_count = 64,
+	.config = &sy20276_regmap_config,
 };
 
 static const struct of_device_id sy8824_dt_ids[] = {
-- 
2.32.0

