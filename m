Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF68377A81
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhEJDaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:30:17 -0400
Received: from mail-eopbgr140045.outbound.protection.outlook.com ([40.107.14.45]:49683
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230126AbhEJDaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:30:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGeNf1Jejtlzu9f0l0QWjJt6Q8qqxfJTt7lDCyGOyyAS90csCIcBN4z9WgogQF3JGLDZnfhi4ZASul3lj8D4nLKfn813gDJ8nMdEv5LXvrrSfTKEmrI8pmCYrdgB1Z/LmFqtL5Jl9Jw5GrOEJm9fMJBPRlghdwhWtSot7nfCdiz6SC2n5eSyJZy0BpX7j435zKfpvGXjP3QrTJDz/+BEac5B6CoQwBmf5zlAJLlc6msUtQLlB4Vya9ohIqv9lS3lhj9rKfJBvB7vXxS3g4jxPOqcf0F7gy1ywq2rI8dVHTszmvaaIg4pHdTeSnwwRdgBmutwocICQJ5LMI1oD33Tbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/oo5r10HjYifhxk7hRTOy6jWsuKsuFXbXBItk2pEbQ=;
 b=OdkfXsOJia/nJktdvxafUFcapFacYDZxikuIz4xxfu8fVZeLS1cVl2vskWmnsGIH0ikltk7LXEGco+VyNZzqsoOfmf9luGRKK0H5eGOH9YyoRTS7U4YPRxY7ss0gciM6o+pfPEPG039MnawZi59nT308arUIi718aEmjMDdQ89vWzmyLhlyPMXS9f2Hxggkjn8xpBD6XgDgZKQfb7VF4Ca9dGg5BK7/9H/++ZUlKmo8sl6+CAZ5kEYQyyJl72LM25xT6whwP/3n10j9oQTxhcQSoDKfytf1GaN44m0wkYNw6mOUPZV2vOR9qEct96gS0T8CLAlr6TldFvX5kxwjFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/oo5r10HjYifhxk7hRTOy6jWsuKsuFXbXBItk2pEbQ=;
 b=Rum1y1a+vzdpQ+8+ckomR6Vuvl7Zc7FgJf2pvJhnCptTSm68V7+Cpb5UcFJNM5N6SduSz8RcTK2G36ghotut9E1hbyzIxJfhroUyA2Xg/09CODeyNdnCuNcIJAFTRrbyfa81TzGhTPAMIujk2Jby2A3l+xOewFZZ0eZtycrUOGE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4091.eurprd04.prod.outlook.com (2603:10a6:5:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 03:29:09 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 03:29:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com
Subject: [PATCH V3 02/13] soc: imx: gpcv2: move domain mapping to domain driver probe
Date:   Mon, 10 May 2021 12:00:34 +0800
Message-Id: <20210510040045.13225-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210510040045.13225-1-peng.fan@oss.nxp.com>
References: <20210510040045.13225-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 03:29:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 053c5404-5e7b-4964-53b6-08d91363c5e3
X-MS-TrafficTypeDiagnostic: DB7PR04MB4091:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB409108A680458BC3C4E7916AC9549@DB7PR04MB4091.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lKSRnhd/gzQV0qB3z3p+4Marrnrk1bEckPRtLqTP5SMuya6K58X7PUaswrG4uqLxhOp+tiWPyAiY6ImUaz3afmv5b0wfRRuijVHq+3DRi5MGp2GRyYCVNdZaKKrL2R0DjnnVUxOIom4cDzbiMbdpLLTmY4ujTEMCkgf/2YZcGuh2qIBVo0YQK+cFdyi3Z27Z4S7lzFGcer8+8rWcpLctNqfh+XCdYZKYpgCZ3KelkGdoeJfppP5HeTYR8PrqkjbregsOxLv4eKw1UqISoYZboQUNoZfZO5qfqEOGnVcEDPFaijt2A7ouf26x/KxPjthIsc+Em/himyrHpZkZm1CrkbRhhOhL1it3P8ezxIwQIXaE7n9GjTeaP2wSVfyKrV/GSZrIVzZSHB6RVdTAJJL+WBykgIPbGREamjPD6w5cicE01EzEXNLOYnt0yEUmfZqAah4Jb8V6Uld/f+eH6F1YomdYf3dHB2HNjL6JgXkusTMxuBBmunG3lDfePT7OZe/9ldL7kFFkpYNpCYfRYcvFSa0O9JjvEzzsMwC2dbgsh6SCuzhe9sak+UE5ctWEKN5buK77JwnNaZwEEmd2u0ieBGZAa3qw5yvw1B8uVg2ufWrqUFnEBYEBJ7YIZz/KmE5nmhYAU5PCGcnCHjLoaMTahrDbGTa9+eLq0QKzLEo3OXA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(316002)(86362001)(478600001)(4326008)(1076003)(2616005)(956004)(5660300002)(16526019)(6666004)(7416002)(66476007)(38100700002)(83380400001)(6506007)(52116002)(26005)(2906002)(38350700002)(6512007)(6486002)(66556008)(8936002)(186003)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zCXgMGjB8C9QtpG2rw8Jpo+Z5WQDhd91PI3SQRZe36adP2o2MR8xI4tfIlxn?=
 =?us-ascii?Q?mIrn8G689hALecTGNYwcMa4hl7iqGIVhO/uJAOcedKVPQI/YBRXQfW4twc64?=
 =?us-ascii?Q?HYXuC7U9n4yCtKvnX26gZdK4Qgx3xtDxu5b605PKahCuAvTqjRjJY0Z2YCN4?=
 =?us-ascii?Q?NmMGUj0uMaE8eU097hH5SJvDeW+yxAjZaCqZdOckW7RK1CsjenBqTvmM0EB+?=
 =?us-ascii?Q?VXuZPArUJ2sAVIXKwEyQKzyhT2r4W63hhQ/OxdCM12SjetPA1nm9WI+tyce8?=
 =?us-ascii?Q?9D8WeQLxTE1jfLoGrUQVMpSDL1Ksqhv12rEJisIbdDB27HYd29JcNDrF3e+E?=
 =?us-ascii?Q?3w7OFkrmEDGNPR7H67nxOi/4wVfwpv9BLCEr6AbZt/78sbm8iaA7OvB1K/ZY?=
 =?us-ascii?Q?Oj9TranOWU1sHOKhdKzFo3QMBK0DbvbLhICmGVtgBs6GBYagkKxjDHVfzbI8?=
 =?us-ascii?Q?JDB1jk6iTJgeOqzisr8asfg4KdfuqWBAViGHIMOFkQ8DIRxn+I1JeP9lFxBg?=
 =?us-ascii?Q?ZOzjqjIAnJHoymvRARDZKsld2l7fe05J3XIcNIoCz1Uy7OUZ+Vzh7A9PM0I7?=
 =?us-ascii?Q?/ox5O4pYH/a+RDAP8xBTbH8cgjbG0fVDrlOTqOdsrEoyX83ZCXDbus0olKT2?=
 =?us-ascii?Q?GoS5g/oTuAutFU6qmfSawkaNFwCxMCk8N3wYqsYAit7o675MqBAcDJNcduY4?=
 =?us-ascii?Q?wzpIj5kNNi9bq5LEj7bJQyPYWJGYYUIi8FD76BK5hkyVcPrhN4hOdHI+02oy?=
 =?us-ascii?Q?D4+aOiHn6tU/Al7tOdGl7otgJ1mvCR3lr1SWxCEV+HVVTAkzSmVy/QGFhAf8?=
 =?us-ascii?Q?fqUtUNQbakzuKu5+endr6dozDVRbzp2zF1dBo1Lx+TAfqqZIqNfQygXFlc01?=
 =?us-ascii?Q?EIrAe4b1Lxuf5CkCJzANiqI1Hd1DSFgNi3dSFPTi8fntHAjPT22sw/40PXnK?=
 =?us-ascii?Q?xZdB0j8PNvx64JMf8DzQFMVy0lvUF+xrOEic07ayndM/WoFsUY8+ETskA9AO?=
 =?us-ascii?Q?+PYS1dntXU3jHnUDerfV3wSAEWarDUn0ovsw1W30+n1MY2qiuAWcjUDbDcsP?=
 =?us-ascii?Q?9Pe9DcYUTUi5OWHL/lpMPqCdgXza5TMV1UIZlE3Pzzp4G0CVP31XeWLLMa15?=
 =?us-ascii?Q?SloQYLyfemREFZjRJw2VVFactSOPVE/8Eub5OFuccZSrQzdjActFNrPyWVfN?=
 =?us-ascii?Q?4ctNd4uZT3mErDWAIKTZKedASLBld6Lyh+XgvT9mUFQxSvgW8TVskQhckdKQ?=
 =?us-ascii?Q?wlO3je9gO9vPHl4nLArS3FEEdjvHYpAri6s3V/0jT27pdZLNBCRz0Q1l53xL?=
 =?us-ascii?Q?qxgTm48ZQJh7f4PSerb8VdvL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 053c5404-5e7b-4964-53b6-08d91363c5e3
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 03:29:09.4304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McgLotXr8GNeceggz1i6193uQdKHaejQuRfwBcfE6H+GhAVGWu4H7k8ohveHfKYZjCNJipMPG7RIdFDRxZh9Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

As long as the power domain driver is active we want power control
over the domain (which is what the mapping bit requests), so there
is no point in whacking it for every power control action, simply
set the bit in driver probe and clear it when the driver is removed.

Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/soc/imx/gpcv2.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 512e6f4acafd..552d3e6bee52 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -140,14 +140,11 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 	int i, ret = 0;
 	u32 pxx_req;
 
-	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
-			   domain->bits.map, domain->bits.map);
-
 	if (has_regulator && on) {
 		ret = regulator_enable(domain->regulator);
 		if (ret) {
 			dev_err(domain->dev, "failed to enable regulator\n");
-			goto unmap;
+			return ret;
 		}
 	}
 
@@ -203,9 +200,7 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 		/* Preserve earlier error code */
 		ret = ret ?: err;
 	}
-unmap:
-	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
-			   domain->bits.map, 0);
+
 	return ret;
 }
 
@@ -499,10 +494,13 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(domain->dev, ret, "Failed to get domain's clocks\n");
 
+	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+			   domain->bits.map, domain->bits.map);
+
 	ret = pm_genpd_init(&domain->genpd, NULL, true);
 	if (ret) {
 		dev_err(domain->dev, "Failed to init power domain\n");
-		goto out_put_clocks;
+		goto out_domain_unmap;
 	}
 
 	ret = of_genpd_add_provider_simple(domain->dev->of_node,
@@ -516,7 +514,9 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 
 out_genpd_remove:
 	pm_genpd_remove(&domain->genpd);
-out_put_clocks:
+out_domain_unmap:
+	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+			   domain->bits.map, 0);
 	imx_pgc_put_clocks(domain);
 
 	return ret;
@@ -528,6 +528,10 @@ static int imx_pgc_domain_remove(struct platform_device *pdev)
 
 	of_genpd_del_provider(domain->dev->of_node);
 	pm_genpd_remove(&domain->genpd);
+
+	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+			   domain->bits.map, 0);
+
 	imx_pgc_put_clocks(domain);
 
 	return 0;
-- 
2.30.0

