Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D00336E543
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbhD2HAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:00:08 -0400
Received: from mail-db8eur05on2085.outbound.protection.outlook.com ([40.107.20.85]:11425
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237267AbhD2HAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:00:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDFOMtaaeL9/YIUC/qkFfLD+E6wy4UThoqQ237Dog/hF/EHwaob6bDa+e+pnkNAnf/h34Szi/n4EUCMM8HoS8QJiOAYMhalYs0GN2jsz+VSzeDAk5gbbEAtHTVrILyO1A9HSsSaUvt6iE0LZJZ24iPzg8WBQh1Cf7hzUKycDpwyblUqdp4/zhTJSXGOsRORfaiarfm5fjdDYN9vRzIgkAKquqftdrZ1l1spN636pBUCjjmBKpUbrempfOCG8ku8JtB2JrXiMNnuintu77OLOWQjE2Fo7jbC6ajow+0l/LrpzeDYvOEIQfT1BkT6JsqS/FssLdrGBpy8VQgM9IPdERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC7LQN2bjLXeLZ/WIeQhj39T2YZ0qC/FFSLx4nhi2E8=;
 b=fm0wvmRjRG824sKSBWf0G/1GWBYKqoiDZRDEFKw9Qf55hR8mDcMpbz8s7CsVmfpbFy4eXRLvyOq+d0Tr91z/3QaAeE/EH5H2mPooq0c7CfTT2oiDeir9DwzXerOCx3ecdYJDvjc4KPUL5L+GflRhVFbBxgjDykyk0/R2ZjgFdXrZGWsF/pvisqYlC42tKHpH+GNnFIJtOAfVojdAfC1sXLOuQx161F5L5XaBciQe6h9wk2VutfPcFwkR01lgTjwaOmjXMh3ruvt4zsuT4J6RP6ovJt4U5dBWc2ZNV9jlHGzdlh83A1TycGPuucA5s+W/+yD8SD6rCzXj0mZUIZiAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC7LQN2bjLXeLZ/WIeQhj39T2YZ0qC/FFSLx4nhi2E8=;
 b=QsCrpsmRRVOQBztm4hkT+95WEJ1tdfHvYBrZnmhYJppOwjqhbruJvYeX5z94gpouRmVE37t7XQyNTc+ylGNT/Qv0TE7swRqq35B4cTghZZSrrqPcCQenJsthR5OBd685y6jGwqz58Lp0+lr+xrSvehKfztb7rwN8rtgDIbL4KYY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5468.eurprd04.prod.outlook.com (2603:10a6:10:86::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 06:59:16 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 06:59:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com
Subject: [PATCH 02/16] soc: imx: gpcv2: move domain mapping to domain driver probe
Date:   Thu, 29 Apr 2021 15:30:36 +0800
Message-Id: <20210429073050.21039-3-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Thu, 29 Apr 2021 06:59:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e27b32e6-f0c7-47b0-c88e-08d90adc4dba
X-MS-TrafficTypeDiagnostic: DB7PR04MB5468:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5468B0B1251B4CCCF397DBEBC95F9@DB7PR04MB5468.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzL+sOZzVd8rsM34Tc+ZK30jA2QJyvOWvfE/Pb2MuSdkLomEI+bt9SpTYkGcaBpaMo7FLLpZQrHOMoWi83wKqu8GglM1No9zV7ToS/7DxfWi3Kj0f8Spue2CWNwyuftHpFeDIBpiiWZ/3wz72N3PdIKmBSpeXFpMdnMt9FiS9O/gmSwVh5vWjusstv8sNIgEDYJU3v1viALMlRk+3NAMnr96dJbCNykNl9/kiWDyBsKC0DTN9Pu/rcT5KqVyAB1yjWteTOZ8Ucl1GEJ7U8l/s5k4YaE6OJedneQpQdhCDx/CELaZcjOTkiyHgUGLW+nfR/sbccgYuqXOXO6+QkPtU/euhYwIcS/qx7V3jI1kE1rWW+EuqXwrLfLiIa1AFR4tQfqFq2PwmC36GrJIf/QqJ3fWabrSvHhfR2nSwnTeL2aDXcbnKO49s7SRlzSZoz/dTVM2a4ldNv+/ynOBiwJ+rQ2LhUi7CQECwOscdRT0yW1t6C0cMFcAED22LSib8ed5wxoG8Iqz8QJKPqnhLHO7l9bFNT2IYnMOx/nvSmK0qqSA3kO02bKcr4JaP88GXWSyazBpcsxmL9FgTY0058mZIhgGnVrWBSK13rroVQUc88pzBkCkqkegyNGLKTf9E4fg6d2NWBiFhlnr1NZOh++iS6ZhA+Mum0+Cgb6bjp1aSos=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(2906002)(8936002)(4326008)(52116002)(38100700002)(38350700002)(6666004)(956004)(6512007)(83380400001)(8676002)(66946007)(66476007)(16526019)(2616005)(1076003)(6506007)(186003)(6486002)(66556008)(7416002)(478600001)(5660300002)(26005)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wf8uYUp+16dinba1F7uA/de6g2OxXID+S7PgNXX+qKy+oY3ePf0qk1xYlfzq?=
 =?us-ascii?Q?SrYJJaDU4kPlGBur+qHOPJyc9TiI8HW2huHuFpsZOyY7srVUc0zJMbb84/d/?=
 =?us-ascii?Q?VSo3Gix+vXpcKfR2K0xKQUoE1BTLbLbwMy/mF7T78PxCT+ddcvj49r23wSoL?=
 =?us-ascii?Q?ZVUJkOK68SqFBtlKlD6/avF5H7G8oqhpHxKcmKndiNTNaPOGtzlN1ZAF6M52?=
 =?us-ascii?Q?sGObaZsOOMR1O1ZqO10BJNvxdOrDtEHGUK/gkOvRuD5yWCsQgi6J4ZDG1KvE?=
 =?us-ascii?Q?3ymqb6tUHQCvAIlulSqKLSBAHP9kqluKVsHLwNeER+EX02s8dDBKO/ZRsCej?=
 =?us-ascii?Q?NjTjscyV8kaKQ+zGoGUbUblnYAAwPUayPjBenCMZLpK+DDcF/WjrHJFm+5gE?=
 =?us-ascii?Q?DoiXPH2aASS8fIQVBf1HXPyjix0q2p+X0w+0uerhihBMvahnK7PpBl+F3JVW?=
 =?us-ascii?Q?nHmsMLedNifu1UQPQqi0Woz0Tnl/SrvUJZ3GzgbHAWNWOZxc9WNrC/w8OoYx?=
 =?us-ascii?Q?fq+WI15PQCBiG5+yRQXQ0R2xc7DDGke6WiAHut/Sjw/Kmg4WssgvB4+9d7UY?=
 =?us-ascii?Q?IecmooRy52bPg7Fg3hfh1pD4FJMP2nLI0oTFH1pn/ZGabocQN9ATtr/AYHIW?=
 =?us-ascii?Q?s1AGaaNbfG1lDcdoHwAPRn7Fb4YnQr8vN8eODfQsIxEVwXFxrWtY44bdJeKL?=
 =?us-ascii?Q?OrbZwHwn9UEJRQcrSqOszNf+yi8wumlAWAgyEzmB9BGMqRbIPRC4TzLZ9QWh?=
 =?us-ascii?Q?yrVJUVCzSvHlM07cukAwMc9sKMLZTxGylEkeLoqdiO+5vIQvb/0uUCVaIqQu?=
 =?us-ascii?Q?tAQdZ5/00Ysh7R9vlvnLIgBtatwg/SX/g51JWvJfvLXrJnw7HjO4nroWW2NU?=
 =?us-ascii?Q?SBB3oKgx8lz36WNnrDSXBc2WSeff60Oo3BHuBNDoiMVD8ePF0+TC5epOTgIE?=
 =?us-ascii?Q?+4ezt6mE29WBXQglpF9X6iiqhvEqr2ueq84p34+5D+S4ypCLfdkQlUmripvw?=
 =?us-ascii?Q?BEBn6lgmZfiQBohR9jEZ7hKQsML34LZRMw2VCX/pMfpmD0kumnmvcgo6XsXC?=
 =?us-ascii?Q?EHVrJHsXaU0cMlRx5J1EwaOVAVzYYoROd4fwEyZmarvOPf6yPU8XPWqjahxb?=
 =?us-ascii?Q?DfuQa2JejsUM/pKnD6DlZQXnJ+pdyU89l5FOLL7oUnhc0T7obU4YhnzhdYHu?=
 =?us-ascii?Q?ZDQap1yzkMfToSIl991tc87FwFmVKS8RoyeHw+0kSo5JWhHeYx0+QQfLUcq2?=
 =?us-ascii?Q?rZ5FckII+Sh9crXA4SEDVmQ7JUgAXAGHpASICfgSFyRROCqtagi5bTn4d8wj?=
 =?us-ascii?Q?165FSLDHsmNaaL2Bkv9GhpIz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27b32e6-f0c7-47b0-c88e-08d90adc4dba
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:59:16.4924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XoSYUklCoPK1UtCbqho9pLmdHTMFpyyz4LpOYqeMb1w8Olb0eTTpqRrRmkUiNYx7aSiKsftbCmVTLtIQ3Y7ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

As long as the power domain driver is active we want power control
over the domain (which is what the mapping bit requests), so there
is no point in whacking it for every power control action, simply
set the bit in driver probe and clear it when the driver is removed.

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

