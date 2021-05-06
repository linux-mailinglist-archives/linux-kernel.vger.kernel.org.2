Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F87374C5E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 02:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbhEFAdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 20:33:39 -0400
Received: from mail-eopbgr20089.outbound.protection.outlook.com ([40.107.2.89]:19931
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230033AbhEFAdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 20:33:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZADEeQdLglSaL/hYbojkXhGdtBBuV3ZLxckBqBWWD6S9ErUDBphx2pa88nEhO0ix8blVgaKeFc3i2qO+LAn9CUQHYhq9JsYUGVE0BUnJlt1/I5zfiggHw6Pu+S+QsJYD+k8T6QPOfV6YI8quWPw2j6bonxa0AQe5//YjH68mZ0xtulPNg5qPiYRBysxWcBTNkTubPLwEqh+7l0iQgQxeIy/oxWg+ANTZlnKBg2R10LTFVlQa2Emohbg8WSbrLVbbYeXcUeMMUL3DZ3FDc9tcDiPeMQBVIpVGFPvBv51a97CNCEX0RoZSbNjBLz65URZ8lN7eI+09WC88ZzpNohtSjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADvY3uwR0b4YnAaDRJ1VfVXAKRvif228LknCs1wLTJ0=;
 b=VfmUv8TXd5eoXT6Wn4ypRxbKSAKzXVrN6YcD0YMu9COMOoD7eLxikhR9I7vg6n+JzJ3p9c3xMuUZSiox+sgnlVw46Hrn+ypmm3s1SAwWyQ8Fw8nLqseUXkpenspevrj+LmkTm/fbQ/eS2DYTX5xbvnVa5C6kIuHOjXw1NU83adqHARs/ExqFWKhHnbR/Z1YF2gRbkswRaBdHeFworrfvgs/lpYyFccpnRWb76+dRQxAXLasrhdYMaeNDMnNqSqRfWkOQpzEZVk/d/3o+XLU5a9P4xRxB6Suo3SjbvlVZ5ka4tvldVGWE62UNzTAj9PphjQsnm6DzueVl7ZUaNlPw/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADvY3uwR0b4YnAaDRJ1VfVXAKRvif228LknCs1wLTJ0=;
 b=CSX6Sw3ITVDGlxopuMgrtU5Vf9RMyDa8LsrMatsMqGA/CNUgQURliXweRiH6gVFcqrejTAcVVAIx5XBzN05l89UT/N/v007pvsiRnqPPPY+mdWarzKf4q6yfFM9ta0mvNvXkGcnUFiqNA8OXM4skr1muIULuw//2/NXceMP6mEA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6714.eurprd04.prod.outlook.com (2603:10a6:10:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 00:32:38 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 00:32:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com
Subject: [PATCH V2 02/13] soc: imx: gpcv2: move domain mapping to domain driver probe
Date:   Thu,  6 May 2021 09:04:29 +0800
Message-Id: <20210506010440.7016-3-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 6 May 2021 00:32:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52674c07-794e-4e3b-6846-08d910267327
X-MS-TrafficTypeDiagnostic: DB8PR04MB6714:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB671463B873AE39166533C150C9589@DB8PR04MB6714.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lu2fuerzQFj8VSdi9AJuGDiirS6TmuBus/9gpJ4cClv3a8gP3D1xe0fnzzGwWrC9EXVH4XNSAFE+xgXDbWQlabmUTRlyrBUrhDwYe+3hslFMIaDnFc+WLsvZ6J4I2Twl8wo59neUUAO3lSHRWnY2t7pK9TKN5zdDJEFHBGCASQL+AQNa9/MULOF7dUX/2Jq2sfW8yz49IP8pbBo148Q6sYySa4A7K5HHFCyk7ua7KaNDt1Iu8sLFUt5PnAJj7I8qRExLKNBvmV03WNoI+AxS+63zPqq9Y4yBmrJVnc98R7jcHZovWiZk9ILACvFY17BNXoqrE9LdhoGOHYR/VYb8WJvpPRAoPjYTaJo6dJClHqa9lrp+0d4FennUQBjlOypxt73nCNNlVE/lC0eFDz1Hv2/XXRpiSCSyLKX93PpBT/WiiKJxI1CVFk2qWZSGRcX7aa6eEJrJc/mML50ArLYe6NdcnH6wX5DVkUlKRdVJbOnHtQ3AiKIHkDy1Ni/HP86Qz2IeX1arDXlHkPjuiRbJqGvzAsHVUtcqRCojCUJ3kpPytHs7n1lMaGtCb+UADsY0GknPn80VqdqnExrt2otg2d22BhtXlDeCL5amFXt8Pm1RaGn6tX7uiM2L9vb35pGvXlbkb2MXRJTyAENoU/yj6byL/mKgSB3b4gk7G5qLuYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(52116002)(86362001)(2616005)(16526019)(83380400001)(956004)(6506007)(8936002)(5660300002)(7416002)(6512007)(6486002)(316002)(186003)(4326008)(2906002)(6666004)(478600001)(26005)(1076003)(38350700002)(38100700002)(8676002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?a5olukok6RZzZYdsxBopaTnUMiVjGYp04yUOJD0zOiBZ0xFypyiAlBWjJ2b4?=
 =?us-ascii?Q?1UVyx4xIHyO6poabt0HySAxykyoQoqXBhuQ/BriOvNw3DOouWzmVwqMe51Ys?=
 =?us-ascii?Q?dopUaxMewRWOsT5Hit94PqKoTcrgGaukGqkQgzlm8KIPfnOSYC1Ml35N9WKB?=
 =?us-ascii?Q?Tfedl3nGQ5F7rb1Fp45VFR/wippKWty6PF/rglnGGe+sBYmcpoZLD0hTpkih?=
 =?us-ascii?Q?wkF8vx5KKMh3b9NDhrpVrtpnSbbZWTgasWShJ5IvYnlx184M5qXKJ2Dcamn+?=
 =?us-ascii?Q?k1StI8AzG4W7p0+3dqHWvznNt5Sy/c3a9HlpICM74I6HnWL+CrRppsVK0cJd?=
 =?us-ascii?Q?Ia/WkslUeaY07oTTaP3r+6UW5Z6uXqry1bhPMl41Pq3pHPTM9Hrm91OqEWNy?=
 =?us-ascii?Q?DtGI+w0IXmTKAA4t2g8L1Fx8yf12q/Mj3cVrThNoAcn7FzdJUVbpL1pqSBPS?=
 =?us-ascii?Q?1YuxyIpvqiZCSAF4bXJ1lOORrsZKYy/iSGigIPmZH4Ou+b7j3bnU5QzEU5BU?=
 =?us-ascii?Q?3ZRco8/q9LTXnEfo1O+UsOlooAj9/4jKKTSDTybf9mdZNa3i64cuIEJtujmB?=
 =?us-ascii?Q?q3x89HiX4VI3inKaQoHyhn36dH9aiY/oiyOj3ofwOmPPmkuZUvYqgna1r2UL?=
 =?us-ascii?Q?Lve8WX8BicSkYqEy2QFNelbhHnt8UF7ZpjytXB+6aQM5f3ewCbMWn85MS7qj?=
 =?us-ascii?Q?zS+yJdXQycUBbKOjiaXgKNeyfEWOxXhYZ/e5u0L69/VjG9YnrrYPz4HtjBka?=
 =?us-ascii?Q?nzWcVSzJyB5UlhRqCm1lZhB1HWWjWhEcuSAUCIwKVZoQN7JElfzz+9iKUUeH?=
 =?us-ascii?Q?/Vf7M9//u0TXVTdm6HTfcAqpTwvXWjJiuke4DXVZo8h5VRHw9q8gWXVHlwy2?=
 =?us-ascii?Q?uAe7wJMHartOk+QzN4YbH2xY/Io5nVgrs126OxDNW/dGylM1jEDu6YcUjs8V?=
 =?us-ascii?Q?4Rhuc/zPewTuXrYp+DN0IcP47TdalTAWwnhrGELiWNHwkkRE/D4o49m/vGMM?=
 =?us-ascii?Q?Q7JPCF5tWdPXHkhHYFqo3OFRtTN4VL+PqzV7m0bWWups8MAx3hseZt+4aEBA?=
 =?us-ascii?Q?b14tvn81Y3enSOfsmFxlXJWSmXWFEBp8JGuqkY9w5dWbtv5CGBI50gQt+kzY?=
 =?us-ascii?Q?DhN6p/QMnj2ae+bm54aHEarNRDHDlegx3MgBbkchbnAWylBeEd7dSGXOofPB?=
 =?us-ascii?Q?0aqaO5UG/+yP+Z0ezY+8nfLU5HsJK7zB2wyNjbjHxOMoPs1PHHJH83G0sn5M?=
 =?us-ascii?Q?mqeDrUjvyboQFpdxpTEp8Pl7Sg+8qRho+edL1RMhHzg0e9JmJwx9uKj4mnW/?=
 =?us-ascii?Q?CEK1qGCya7U8w41kA3APo/Hc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52674c07-794e-4e3b-6846-08d910267327
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 00:32:37.8179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJ00Ep4Nj0LED5kc/cnI7pm8Zcz/Ir2egiBZYADXvDnmUw/+Vfej0IUUdnwKgNRy6fx0rBWsI7HapHhrpjiUVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6714
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

As long as the power domain driver is active we want power control
over the domain (which is what the mapping bit requests), so there
is no point in whacking it for every power control action, simply
set the bit in driver probe and clear it when the driver is removed.

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

