Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A219936E541
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbhD2HAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:00:03 -0400
Received: from mail-vi1eur05on2056.outbound.protection.outlook.com ([40.107.21.56]:64865
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232511AbhD2HAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:00:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DecZbwKf4oRRFA0Sxgjoz4Vby/Wz5HoRVIi1SIYhTzDq6n+X3IG6ziwznjCLVSDr+GbrTDImA41i1M7PWFbo6NHr4s+UZazFW96djWi807giwY0U8/Ab/4gD3c3XkMwtSuYM7AtoCSHamncw5iynIfHN1K05ww/PUU1t/gzq/0epibGOf+eErTwRQr3SaNyiyFLEKpFEaOdwz5EJc3cRwtOqCxxd4jc5XS5W/OJ94E2B/4co3oVlKf4Zu777zkchuf5q9wKNR9x5u9LMh5aTCJRbQPoJd73mdVSDtvNpVW/NNI12GDsa3RObZ7kM8ydpVp38JaTUOpbT/67QLowJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0M2nSZgAEBwt4XdHnOocGRksY3hFRWrV85V4mkf3QPc=;
 b=NcpkTzKmHOWMZh7ovU17ivB4egM3569Uzu3d7Lh8jxDd9YbyePmOdyfoeSjJr46yrfgoUFhip+01LAx8xwbN1BY6WFlxUrte8sF/K87Z4SwlPL9TqkoyLVUCyNRVefj92qMXbxG/D0Lw57hAW2Nwkmzj9gq89enoB+Gt3VAJI/iKwUZOC/upmQIFJl+ldykYIHfzhUh/nCOFS487gnqm0GxUve/duFta9bn6SLzxp+rdO7UJEGlIKjQt95+3yKrff35aI+qWdfx3ajJJ7poUNbv0vbiGNOvk5lUjY8yugQ9ygjmIRqwvbaEDxlnWJKT18cb6DdHQItHo3I1hdhBa3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0M2nSZgAEBwt4XdHnOocGRksY3hFRWrV85V4mkf3QPc=;
 b=ZxDdxttbcAInHCe6kOtNa57HN6j6nJmjBkEWpfJXXjsjgopwackQy4m3Oa9mRML8E/93AUzIV0HrF1aWE97ysDJN8098VeAowdz6LMmbx7YbKCQ9ewihb9g4sakayWSV2f5fgTFtuOeDDF+jBXm02HJ/v+aHEx0eATzrzBaOeFQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5468.eurprd04.prod.outlook.com (2603:10a6:10:86::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 06:59:10 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 06:59:10 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com
Subject: [PATCH 01/16] soc: imx: gpcv2: move to more ideomatic error handling in probe
Date:   Thu, 29 Apr 2021 15:30:35 +0800
Message-Id: <20210429073050.21039-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210429073050.21039-1-peng.fan@oss.nxp.com>
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR02CA0208.apcprd02.prod.outlook.com
 (2603:1096:201:20::20) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Thu, 29 Apr 2021 06:59:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cbd03d9-b45e-438a-90f8-08d90adc4a33
X-MS-TrafficTypeDiagnostic: DB7PR04MB5468:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5468AEF58FE79B469D02170DC95F9@DB7PR04MB5468.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xo4fOsQYv68abhzfTfP5TOPCcPG9ERq3QlExxZ7G00ZDdsetMR9VyhsL5oBn3DvR7PeQO35YSDbnZbSlh4aCNMqfAKdI/QMQFdVNWVvU4tl6eR9b1553/90eVQW0fZSa+iqRCIS76rQHP5vwBYYgnPucsnfEQ/EYZHFep4HTg1wTO+YKiQdSTRve3cic+xzFSHHzEEvpOtDEQM/O2ppioWbW/AULtlwa4tCo++cSndfRKjtFLLji1JrdvQWFdLWbEUWyW3EUeYEQ81boIlU2KqzDWhTj7Of4aYagD+vWwaOO+aQN+uwnXo8tptr2odhd2BdNCaQfyy56dUhqOZpFwI/7+6mo7CxBTGv5W4V/APyDMtKSe1oTHJumUWetGxnJjt6MRuoLd9e0Sep3bJ+1WQOt++Y1iXxzuJGk1ifPjVkpUMGj+JPzrFtWQDXE2xC4wAPTKz/hWH20PLB7LpMrY8ExXH2DiBwEw57cmDITb+sRZTXcQ426t974ULdwrSUjzeHwOM72QkdE8PtQZg/msfGmUt3QBogEBbwzu+r90EkWAVgD8X4DlN7RwnsoekbSKw+y1R2reK+rupnfSIIdTFzs1OkoPNpdR8qewlC37Ann2k1vsS46p9JEzaxrRz11QZjSX1anojQb4hVuxCfShEy77o/1EOdYNAdL5CMdjaA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(2906002)(8936002)(4326008)(52116002)(38100700002)(38350700002)(6666004)(956004)(6512007)(83380400001)(8676002)(66946007)(66476007)(16526019)(2616005)(1076003)(6506007)(186003)(6486002)(66556008)(7416002)(478600001)(5660300002)(26005)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xjXZj7TuCCA5FVG6Adc3g0Gk4Sv4MPuAMHKWVRRDLD+/2cbrByzfKGQP/rIl?=
 =?us-ascii?Q?nUHk+wbgh1wnrE9fWzAZAJFIY1pPFTrlGxVh/HgYvQsQi2TunQC/kWaeZjUw?=
 =?us-ascii?Q?BDizoWRR2R1YGYRSFiqN9c/8Z4IfNOuYSj1m7x8m4t+uIWWFWAquupcW2ePV?=
 =?us-ascii?Q?TgvKXQ5GrjFUSZlejJN896ztUJQrZaBRZiTIN3JvLfoLjZlGCPUXMQ8fv+Pu?=
 =?us-ascii?Q?Yrpne0VLuoxclB3DRnkfcBIS2Tu6McQPCH/hXzkVfGDGeJfRKEIumBrUK+iF?=
 =?us-ascii?Q?Rh8286M27TbCZIRyKQn/oEzWcG846/FDn9wbRSi0Oi+rwIEKpBiSAN5sUEFi?=
 =?us-ascii?Q?5R6jwtEphTBzRX2DqGfXxKYYFzEeLW57SSPXmkp4me7LzxP9mpVHdVNjMfIz?=
 =?us-ascii?Q?panfXWwrdhnbDvL3PsplPjtAvQASJmWk2WQIdllsrY5YEqQhC4i4mb4kixbY?=
 =?us-ascii?Q?pqaAGssZYQ2FjKskLwZk5A7/4QbzeJeK/RQwpEwvMH7XOb6fOaUNxoe/TUi4?=
 =?us-ascii?Q?opAtmvDi+MSU6HU1N2tP2LjUqgPCBSaNVepb/4QSUSO8OWlou7aD4HbHdrGK?=
 =?us-ascii?Q?WflFX+lPU6LTpiflMjQNPGIWV4JfW0sBzLfRflVmzfyBP4EaBbti0kr5dDC6?=
 =?us-ascii?Q?/tAWKus5BLsae6pjTIrMKh1idl7I6g4KFQUG7U17oFOtqFVScwCrzi/bfVbo?=
 =?us-ascii?Q?cIWRi+XJ51Ku3rXmNFBkeeJSYkf5TiZtJgXeP1lKy1uCvJ7ZaD+pUkJEJm3k?=
 =?us-ascii?Q?ixPR+Wb3hRWJ8OmiaTrQ5Zz3gLN3ojsv4+fUcLoREtMZfhGYUZK/pZjOiiBA?=
 =?us-ascii?Q?9LiZLpewlLjzfa2hb0v9rFXi9YhcKvwg2zuAwhG4dQsPTpCV0r23AKW2dQ+0?=
 =?us-ascii?Q?Fepn0u7nsoGpUCs3ZEdcFEwSNa+DPMQzZKEaayARVuQBMSJTGn0fQGtVj8Bh?=
 =?us-ascii?Q?RZYq8lyUsjACXmS1nHwKAEFPWRiE9P8Suy5wcTJVYGws76WWeFQ3rYL5eRM6?=
 =?us-ascii?Q?UUexZuIb+54CyfROJAcbJD/km9imvAoUDHeJYzMQv/cveblUv3n7YkhB6a0r?=
 =?us-ascii?Q?rHOXUngVVgcFPOVcKQh8RdKiY3XmsiV0lQVhfqRA+KQapO0fgTcM/mMiqvUv?=
 =?us-ascii?Q?pb+TQx/kcge6oFv55EjgHEnjjh0NGr1BVH9s3rqs3cuC3BQZ4w59Q8DErtP0?=
 =?us-ascii?Q?SuJPfXXnEH4nlxxmgSHwbuoMZTVbotwmselNxPMHg5dvAWkzFgYyWUXRY9kZ?=
 =?us-ascii?Q?q2o2nrTWLQ6tg9nFb7a+1g5RDah4fVWhpv48Trg9xRmu+Dr1+Gq8PIsdROYt?=
 =?us-ascii?Q?qW7adkHYDd16BiU8/5InDQ0F?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbd03d9-b45e-438a-90f8-08d90adc4a33
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:59:10.7560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UT5wIPx60TxOSb1Orqm9sCb6waIFSpvP7TkAe7hgImHFByvqzv/Zl/gRxAs+AO2X0ajbZwv5h1v7h09Kk3Xzog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Switch to "goto out..." error handling in domain driver probe to
avoid repeating all the error paths.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Marek Vasut <marex@denx.de>
Tested-by: Adam Ford <aford173@gmail.com>
---
 drivers/soc/imx/gpcv2.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index db7e7fc321b1..512e6f4acafd 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -502,18 +502,23 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 	ret = pm_genpd_init(&domain->genpd, NULL, true);
 	if (ret) {
 		dev_err(domain->dev, "Failed to init power domain\n");
-		imx_pgc_put_clocks(domain);
-		return ret;
+		goto out_put_clocks;
 	}
 
 	ret = of_genpd_add_provider_simple(domain->dev->of_node,
 					   &domain->genpd);
 	if (ret) {
 		dev_err(domain->dev, "Failed to add genpd provider\n");
-		pm_genpd_remove(&domain->genpd);
-		imx_pgc_put_clocks(domain);
+		goto out_genpd_remove;
 	}
 
+	return 0;
+
+out_genpd_remove:
+	pm_genpd_remove(&domain->genpd);
+out_put_clocks:
+	imx_pgc_put_clocks(domain);
+
 	return ret;
 }
 
-- 
2.30.0

