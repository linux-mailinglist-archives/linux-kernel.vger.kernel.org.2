Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF632374C66
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 02:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhEFAeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 20:34:06 -0400
Received: from mail-eopbgr20056.outbound.protection.outlook.com ([40.107.2.56]:65344
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230218AbhEFAeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 20:34:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqEHVFTHqaNFuJCP780dPk9GXnBqGVSNp7tQ0sCibr/e4IBePvpilzFDPgkvn3/MdzSMf9XKAt669Iu+s5KTGWmdjsLOqv34qrqAfzDy4VOpgHO2XbMZkCKF2ny7r+H4OmH0/xHXO2Yy4tIk3wtPybf4V1afSrWusP910TNfkwWrFVQdUCMbbGk2BbKOdjgZTGRDhogLjOzWCNj16lVB4LEZRrH2gy7LDIiap/nDEVucZ0ahW697zqy6igXhlTjBy2JWEo16AmgF+msxj/qVNDcFfMWEDBlIUeBSGhGaFilza8IznGA2BTXsFQouIMvyBmOPranQhIRO+NhFZvzdWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyfMB8r6y6e3V9+dQWnesa3DiUzqhYHZf4kj7QTAb04=;
 b=lsBBFCDJGRdPZCTWBoR2+1dgGbYE+N8TEmgv+IpjZ3MfotuszTu/l3VYxjh+Yf+tj+28JghRbC0RBSbKH7Z3J/a+1x+Fm/s9Z+VtobiJo2Qt4M5D5En4F9bbPBtXC2chO+RQTunuH4q2AU+HBFOAOQbEARgDzzBew8X4dhaMnXs8XookF/+vReVp6Z8lTTebG3EIImjYgfpFCL76woEeYKG+x5ZCCv7RIRFsNLMr83JgAQSYbWrNzUbc5wU0CmLaXnbhtxd1+aJQhWJ1+8g5ejzUi15AdIbUa1tleLaLdoIq53A6vGsZLJzxzBRv/92L3pPDmuJrmqrQkwibhnkgug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyfMB8r6y6e3V9+dQWnesa3DiUzqhYHZf4kj7QTAb04=;
 b=XDUeRL0UatMYjc0+Ze9CHQ38iaHY+pDogbUmPMY2d2iW7KtwGOw9GI+PW8q1dMoLH33SmEILGBnMi0aqwHzeabe6z7o1WzRW1h5wP9RCotnEiv4p7CdNUrU56P5o7yyKhfUePHcG66YjgxriqQKQxOxqBQHI62pm72I/1agZfVg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6714.eurprd04.prod.outlook.com (2603:10a6:10:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 00:33:01 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 00:33:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 06/13] soc: imx: gpcv2: add runtime PM support for power-domains
Date:   Thu,  6 May 2021 09:04:33 +0800
Message-Id: <20210506010440.7016-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210506010440.7016-1-peng.fan@oss.nxp.com>
References: <20210506010440.7016-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 6 May 2021 00:32:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89d91e13-68cb-4c03-d508-08d91026811d
X-MS-TrafficTypeDiagnostic: DB8PR04MB6714:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB67142EB3E8B3614B2F5207C8C9589@DB8PR04MB6714.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VEFGGptBTdRuj0qN+pVK+M44Ssa5f+ivy60HTtJOsPYnJiUpm0Km/1wqTE1+Ri4XuJfLLfCM/r8hnubbih5hBCyr6dAr3hBZKJhaPaPAIspUbrGpNeUQklEppr3VJLPew3/MYnJPZu6rNABm7k6aVujHPz4cmb6c8Ij83ZhJU85JW7M2FKBtbaPeY2s7Bezv16YISY+UhjPv79QK6ziUsAhOoRW+dE+pEN505XZ2GcFmlLIBp8O+4xJgWSz//UOJY8XYofhiaBZhtwI//hxdT+6eGMw648lkWYbYV4M0VAIvdvIYng6R32tmmRHgTOUXx0hcrHypZ8VyLjwzLKIf+ji7hrxigpdmJHd99rBVEDcGHANRUofPVA7JeGAXU3wUDl/jKA+0cZpW0XxBW13Wln1LN6cT6yzEwssOxOvvoZXxcKv2YRp1aLRFO3jicNxrgDsbGhaCd3dWtzwSIvFNb/zWpHkqua28m3agQj/u4vB7BcVowrFanIqLJx1JjoS4fpr5IBVcIHmc2rifErl+y6Fc5GJtK6KJhGfEE1qqPdCHKQKb9MhaWs6V7o0CAHCRMNSNFc77W1EW4ds3E7UCjdv7b+R3SjiyeslwkHvCn/DPOD9k9GLkF74lACeYWdc50A8ZIdm1M5/ptxXIDKww8j/6y8MdTmbXE3y1GDL7ZTg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(52116002)(86362001)(2616005)(16526019)(83380400001)(956004)(6506007)(8936002)(5660300002)(7416002)(6512007)(6486002)(316002)(186003)(4326008)(2906002)(6666004)(478600001)(26005)(1076003)(38350700002)(38100700002)(8676002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ARYJzd9hXwJCKVpMHZFCmlM2Q7gdxiXXH+qKmRcDLNGRAH0JXIZFWrdkwKw3?=
 =?us-ascii?Q?gt7oGARD8NBIJD38IQKVquZK9WTeWPH08rf3TnYeWxLWh2G0Nk4eVXDRlk4U?=
 =?us-ascii?Q?AID2kvQ3sKbd4AGTcEZ8WCpg+I4a3wDamzO5qNdWlrhmQvy4TyASR0TJxMrm?=
 =?us-ascii?Q?R8d8eHOhg80JLHks+mJCxxttBu8C66J8y14uS9ysmPsNK8GX3P6KR4mHXBYs?=
 =?us-ascii?Q?xD5bwGlwMGl4j+UWliTqzaiV17k6mEJnRYAyicAZGLnJuGMCVvsD7TzWGO5N?=
 =?us-ascii?Q?FuwMmYc59Tj19pLNVSNH/RRWb2op+OGmi36WOSQlvq/6J86OGbNC8kjVjZbg?=
 =?us-ascii?Q?LVvPF19nMiz4oGRkeOwOYcLwTxls1WUwMWAZOt7W5/ObQhpKR06IMhIxtuJ+?=
 =?us-ascii?Q?ZJfn+JLCdzkrImcIZg24qKQqLhlTBWqTY3wmPFoewwdfy1UgQ+8m/M4hrUBG?=
 =?us-ascii?Q?PmM2albjacV6uSkZFffU+3aoMCTKtj7KyhMKXRMbFC4wdo23JyjYZ9L7IHY5?=
 =?us-ascii?Q?jE5jj2+PdVlcOX5Ay/rdkEyhsDj3GDHkhcQ6Cf4balHRp10bCO/2RVjNbzW3?=
 =?us-ascii?Q?QA5mZ8XrsXyAl0ANGRkw/cwtOSi0+OryWdFutG8mH5mFsiEQ1O3tMwSWMvAm?=
 =?us-ascii?Q?UMDp23zwix/EqfaQqUrao2xQfnvmArw2VyA9PEZIbxwUpEGr6JN91oddri34?=
 =?us-ascii?Q?e+FaGKr0bF8CCJpVsC6HXPIKxG/eqvyvvPKLSVq1ldsjxUQ6E7D1/NesNXGw?=
 =?us-ascii?Q?bfFEZ1aNjAJ18Yqcx4q3K51RCpckJhhxJqtw8Jc4Yv0fCsPgmM0S0S5c61VO?=
 =?us-ascii?Q?EWkJeBmflOqlX/LvP2hOz0bKq7988+PZJLwIJ1dC6LZ066yTA859NRkeSA3Q?=
 =?us-ascii?Q?eIuDIFEO3o374tBHeedIm5NuUG+BLWIRJBM3qkV6ieK6Z3XcvkQD7AOj1tby?=
 =?us-ascii?Q?2MdjtdRIgymusG07Ms5q25U+qkGfD+9939bNd2OBEYO+k8EgoCn5vyduAhcw?=
 =?us-ascii?Q?QGSZdxR/2B0SIiv96B27ga5BMhoQileaaDUukRLO8bkvkWRX/QgsBw4gnGog?=
 =?us-ascii?Q?hAWkNMkLMqiqb4PUX89Elsy2uIwypBECOgW5yUQF1JOkpS4/cVwqBQmztjFX?=
 =?us-ascii?Q?8hMEY7KwesScUXvnr4VTXn5nj2nbakvJtsbEpJrCxEwBL8DaxnbpVrvEr1es?=
 =?us-ascii?Q?nR6qNXuDjYRT0epN9zxKisXmW7LJgpBH7iNMNdbXc8YcR0LRmOEnUx5YXzhW?=
 =?us-ascii?Q?z0F1cxadgOdgvtb9vMYcQ3JgrpKe3naimjNtRav1+LSu7L9oEh4FcR1sW/hf?=
 =?us-ascii?Q?NNMQRlX/RMHZZHYRajRuhOet?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d91e13-68cb-4c03-d508-08d91026811d
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 00:33:01.2982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbkY/iFpY5FgPtfRnGCBpILdbzgbTHrZ+YfUBmblvtpNpBpE7a9Tj73UtJrU63NABzIQsNWMtlKpkT1cxXTy5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6714
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This allows to nest domains into other power domains and have the
parent domain powered up/down as required by the child domains.

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 558b8b8af9af..bfea8560cb64 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -12,6 +12,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sizes.h>
@@ -141,11 +142,17 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 	u32 reg_val;
 	int ret;
 
+	ret = pm_runtime_get_sync(domain->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(domain->dev);
+		return ret;
+	}
+
 	if (!IS_ERR(domain->regulator)) {
 		ret = regulator_enable(domain->regulator);
 		if (ret) {
 			dev_err(domain->dev, "failed to enable regulator\n");
-			return ret;
+			goto out_put_pm;
 		}
 	}
 
@@ -204,6 +211,8 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 out_regulator_disable:
 	if (!IS_ERR(domain->regulator))
 		regulator_disable(domain->regulator);
+out_put_pm:
+	pm_runtime_put(domain->dev);
 
 	return ret;
 }
@@ -266,6 +275,8 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
 		}
 	}
 
+	pm_runtime_put(domain->dev);
+
 	return 0;
 
 out_clk_disable:
@@ -523,6 +534,8 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 		return dev_err_probe(domain->dev, domain->num_clks,
 				     "Failed to get domain's clocks\n");
 
+	pm_runtime_enable(domain->dev);
+
 	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
 			   domain->bits.map, domain->bits.map);
 
@@ -546,6 +559,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 out_domain_unmap:
 	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
 			   domain->bits.map, 0);
+	pm_runtime_disable(domain->dev);
 
 	return ret;
 }
@@ -560,6 +574,8 @@ static int imx_pgc_domain_remove(struct platform_device *pdev)
 	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
 			   domain->bits.map, 0);
 
+	pm_runtime_disable(domain->dev);
+
 	return 0;
 }
 
-- 
2.30.0

