Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11FA374C69
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 02:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhEFAeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 20:34:16 -0400
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:44676
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230236AbhEFAeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 20:34:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMo5myKfbR+gnsEWEdcRSjNvJUf7F3YN+SkAVNKAcmKYQ9DIwxHW6Zj/Op8f4hAXZD4//CIzJuejDHeuS/ymnLAYRPmGflkykNnJz6/G44Ohspim3fBnYKXuMy3lr/iaR7p4JpelmeHtqFPRRN3wYUB8o3csLEXrwNvVdUXBGsy4n76Mam4kKMQZde+hkNDIigGjEqiLEBnZkVMbZPFLqQ4H1PmUlzXqlvmlo4IZ8jgztoGA25knZLcVCC0lU6ilgmfxkYaizZwGKOvseRp2x/uQtZc1emIOZ0SQD/Etv2TO+FIHxo2ZsByqWK/ET4+H5BqQNrHpON881xj4JceDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7+Zv4gz8BeNScjIZFS/TAvZShU1paVfL4jFrmQcdUY=;
 b=WhYeLFBDJ7I5xF07NS76BHafymUBsMw7LUDwJewvZj8dJpXNhCl9vITqZL9oJ8gXsAsWVKzw+3WySmX5oHu+SGnqKJzEVaHIVE0bkCvBhb2ApV/dU9eIMCuLhB0/VsmdOlh8iLpvLS7uPnKE9LFWmC6mUfqjiPQR4QHmUbpZan97OM1aew/6ugGJKLKhzoXCmP3/PV33/xOei+c2Fj683/Lgfci2SoYUr5T5Fw4Bd7P+ZZrvNQzKdxebma3nAdTBNt6JGsd7KTvl+dJwppBodkP9heAe6cqMsBHUCGNFJJio0vnMiWSF7fEdsl+hYpIHjfauJkPPNO4NAXnyil9piw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7+Zv4gz8BeNScjIZFS/TAvZShU1paVfL4jFrmQcdUY=;
 b=gMglgxpBPmGaJNrp9rnGoYzA2Ea7qVF66jldKtrL5CHy3EJFbSBYeCqYcruLyXBGoNa+nICrepet+i1O0s3Mg5504v0awI+lZN0NwM8mLuiLfFzm1p0/mAEhogpgzDSpBafXg90Hul4qKjMuHnD5DhC/Mb3/L9z9aGJ4wK+AReU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7884.eurprd04.prod.outlook.com (2603:10a6:10:1f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Thu, 6 May
 2021 00:33:07 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 00:33:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 07/13] soc: imx: gpcv2: allow domains without power-sequence control
Date:   Thu,  6 May 2021 09:04:34 +0800
Message-Id: <20210506010440.7016-8-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 6 May 2021 00:33:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afb9b3e3-abc8-4b5d-555c-08d9102684b0
X-MS-TrafficTypeDiagnostic: DBBPR04MB7884:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7884C6F9B2F054A53CCE4B05C9589@DBBPR04MB7884.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Btb+mv5ukdmc+M2wLfR/xrirp7YWY9R5c9iMlZ9DEJjqeH6AkKo4EhyOvhN3qGLaWq6nx6bnm7S01jBXM9C48I66X6wWCTggKD4toeCWk6ntlqYE7LT8vQTXi0BF+OBE8elE2+SR0WQGce61oTlUCmx/fXf3UiJ997EY8MspdJINaq7pileDJxFpafM6dxVKrz8ngzU+vKgqsibieeeO2suZXMMWPxHeSZMxXy10AMr+Mfsay1IXEzzqFdTkmAsGCjE5rFBKrQw2XWxhZ58J6091s7HQiLn3Clc3e9cLpVr4RxP904eiW44DUQUjz79THAgUxH0QfF9sZiE9ZinzYjOJuHbFBVqnKaLO+5IstbXB7Idns/8J041tzMiCnZkqFLEFuUhBQ+0PJVvZQRUywtbiKXkdswffWOhqllJvTILr/Gtyo3yfeY0b3DJuigqFFRwsZpru2f5Wzs8kdBdnR7XHjqFgl024PNBBRKmt9q8rp7aHFnrDLn3BNqXGi8nqJ/3tF+YngqIcOME44DhIFEPvfQ2lB3AzRUrjzpSISuE5tKUpcpkOwv+8FGtka/EQQVYPwRF15XJKNc95sM5vIcGVIxfRFqO2NX0r5aJvMCuipNPeP+GlZ6JkoVJ3jCKYqx3b0LixOk4mKQQyptugpoO2rLhyyV3zqkjX9HHhSmg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(52116002)(186003)(6666004)(5660300002)(6512007)(478600001)(2906002)(1076003)(26005)(6506007)(16526019)(6486002)(83380400001)(956004)(8936002)(86362001)(8676002)(38350700002)(316002)(38100700002)(66946007)(66476007)(2616005)(66556008)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7Fs/2aGZT2ARViQlQaoEJ7PcxI9E9dzFmntFQnTw2JymJezYCLgC9lRQnyXm?=
 =?us-ascii?Q?JLI/DDrP2DoSEF696AkFZsD+uV8a4+i2SQ5lmNtZIRbOwLVegvmWEcNcG4ao?=
 =?us-ascii?Q?eI82H+tqG/6rk3Q6QO1rBUn+CWlP6H4gp2mHCKTNE2bHb2HDTfOsWuJ4ibr9?=
 =?us-ascii?Q?4GmmPZFZEO4fGgT6vIQ1K62y7UTcolEaRnENWLwa+J3FhyjLlcjajqn4ar+m?=
 =?us-ascii?Q?pCrTphYacbMxWX46tQ7i/Be+pjONjQ2siz3V53gCSeMukn7uK1ZBgFsXwD3L?=
 =?us-ascii?Q?08K21gSzBbXKIe0SjELvQIrzGhWV90sWIzvHxKqnfyLRui049ZUlFrsRP9gK?=
 =?us-ascii?Q?xi0uS+Q7YJd2jbWbcxNttFZP2CQ5rhkLEMRGfpDvo2JdAfDoaI1+bkH8dV9G?=
 =?us-ascii?Q?LM+7R++7lNQ461hpKngW1CzrH+YiWKCdnziCpSlHE/qx9Dqgx3e0O5xhK/6M?=
 =?us-ascii?Q?/xjtpPWmfVCVI87uyEjwlFQf0+yqh6E7Z4RUIT4d+Ib8pAPrqJYRj2w8+AnD?=
 =?us-ascii?Q?Phyi5/5yKZxRRzDGCzEJ0nnt0nXmOgQ18peZUWXmrS8mvL/5UECOnT2Prl2/?=
 =?us-ascii?Q?yEoRyZgAUzLq2MhNarcOtp2qIpjxQLbRy/COW+wy2VrhDIG4438Dpeuk3wPL?=
 =?us-ascii?Q?nq8ZhAzqRo2XJYrJwiDj9GxLqxFvYmIWMiEU6uVB9Z+M2iLRAm1/lt7tP4IX?=
 =?us-ascii?Q?9g57p3HJ2omoWer3t8iyUHhdYTh93fytmqqvZV2OqFRuAU7uWJxfuE3NShJC?=
 =?us-ascii?Q?dEgLJ39h2P/FSVledohSJEs5d4A24+1Hf7attul2BVhW60sRYOKTcdYch4gy?=
 =?us-ascii?Q?6OJku3tsHOclq0E1xdkbP0oK6GKpGYZX8S3AiSR9JKVXn2zoC7ODacEc/9P7?=
 =?us-ascii?Q?DCBFdGXf0FzFgHWcH1pHwEJ7uAb+PtX1YT22VvK/c2m4Alxn50G1TFzlFgBS?=
 =?us-ascii?Q?fjFBQMkN8j1YTyo8GgTzPB1Dv7YcUhJUNnXTSdVk3zeJhKDgZR7/FS/0H0hu?=
 =?us-ascii?Q?xdvioBeL4OvXBnrlfojPo/V2VljOxJjxI95CYUhsV+YRSNTvhIum6WFP36K4?=
 =?us-ascii?Q?3oim32P/nkNfdlUnSnOuTn7bIzspfmg4rQDXSQiA8SiSLETAMzKlW221PtMB?=
 =?us-ascii?Q?gLnwNUDU3fgx6SNryF37z+outLbGqrW1OmHQk2JHwjskcoXv7xcwleU3OMPV?=
 =?us-ascii?Q?6tR/qnetbieJGqEf2Rt1neSxvvw30IuMrfxOAj03+BE5TkzIjsA/WyibVO1c?=
 =?us-ascii?Q?ip2zV289k4SKy4+pd3kNBAYKeFMmeP8lTVJ6c/P0tp4xwfUDVQ2W5TFDy2wX?=
 =?us-ascii?Q?YdO+QKR/AMcEOV0yR/r0mzJc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb9b3e3-abc8-4b5d-555c-08d9102684b0
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 00:33:07.3374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HV5mEZq/3QzcDZQVZeV8OBQBfAd90Fj6B4ZE5glYbUrHPGwoSgZr33feAGBmRbatts/1u6F10VeQWfrChxwYWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7884
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Some of the PGC domains only control the handshake with the ADB400
and don't have any power sequence controls. Make such domains work
by allowing the pxx and map bits to be empty and skip all actions
using those controls.

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 89 +++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 40 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index bfea8560cb64..0428f0eddee0 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -163,24 +163,27 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 		goto out_regulator_disable;
 	}
 
-	/* request the domain to power up */
-	regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
-			   domain->bits.pxx, domain->bits.pxx);
-	/*
-	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
-	 * for PUP_REQ/PDN_REQ bit to be cleared
-	 */
-	ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
-				       reg_val, !(reg_val & domain->bits.pxx),
-				       0, USEC_PER_MSEC);
-	if (ret) {
-		dev_err(domain->dev, "failed to command PGC\n");
-		goto out_clk_disable;
-	}
+	if (domain->bits.pxx) {
+		/* request the domain to power up */
+		regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
+				   domain->bits.pxx, domain->bits.pxx);
+		/*
+		 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
+		 * for PUP_REQ/PDN_REQ bit to be cleared
+		 */
+		ret = regmap_read_poll_timeout(domain->regmap,
+					       GPC_PU_PGC_SW_PUP_REQ, reg_val,
+					       !(reg_val & domain->bits.pxx),
+					       0, USEC_PER_MSEC);
+		if (ret) {
+			dev_err(domain->dev, "failed to command PGC\n");
+			goto out_clk_disable;
+		}
 
-	/* disable power control */
-	regmap_clear_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
-			  GPC_PGC_CTRL_PCR);
+		/* disable power control */
+		regmap_clear_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
+				  GPC_PGC_CTRL_PCR);
+	}
 
 	/* request the ADB400 to power up */
 	if (domain->bits.hskreq) {
@@ -245,23 +248,26 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
 		}
 	}
 
-	/* enable power control */
-	regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
-			   GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
-
-	/* request the domain to power down */
-	regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
-			   domain->bits.pxx, domain->bits.pxx);
-	/*
-	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
-	 * for PUP_REQ/PDN_REQ bit to be cleared
-	 */
-	ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
-				       reg_val, !(reg_val & domain->bits.pxx),
-				       0, USEC_PER_MSEC);
-	if (ret) {
-		dev_err(domain->dev, "failed to command PGC\n");
-		goto out_clk_disable;
+	if (domain->bits.pxx) {
+		/* enable power control */
+		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
+				   GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
+
+		/* request the domain to power down */
+		regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
+				   domain->bits.pxx, domain->bits.pxx);
+		/*
+		 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
+		 * for PUP_REQ/PDN_REQ bit to be cleared
+		 */
+		ret = regmap_read_poll_timeout(domain->regmap,
+					       GPC_PU_PGC_SW_PDN_REQ, reg_val,
+					       !(reg_val & domain->bits.pxx),
+					       0, USEC_PER_MSEC);
+		if (ret) {
+			dev_err(domain->dev, "failed to command PGC\n");
+			goto out_clk_disable;
+		}
 	}
 
 	/* Disable reset clocks for all devices in the domain */
@@ -536,8 +542,9 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(domain->dev);
 
-	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
-			   domain->bits.map, domain->bits.map);
+	if (domain->bits.map)
+		regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+				   domain->bits.map, domain->bits.map);
 
 	ret = pm_genpd_init(&domain->genpd, NULL, true);
 	if (ret) {
@@ -557,8 +564,9 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 out_genpd_remove:
 	pm_genpd_remove(&domain->genpd);
 out_domain_unmap:
-	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
-			   domain->bits.map, 0);
+	if (domain->bits.map)
+		regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+				   domain->bits.map, 0);
 	pm_runtime_disable(domain->dev);
 
 	return ret;
@@ -571,8 +579,9 @@ static int imx_pgc_domain_remove(struct platform_device *pdev)
 	of_genpd_del_provider(domain->dev->of_node);
 	pm_genpd_remove(&domain->genpd);
 
-	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
-			   domain->bits.map, 0);
+	if (domain->bits.map)
+		regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+				   domain->bits.map, 0);
 
 	pm_runtime_disable(domain->dev);
 
-- 
2.30.0

