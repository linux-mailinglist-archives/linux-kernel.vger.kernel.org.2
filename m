Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677FB377A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhEJDao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:30:44 -0400
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:46470
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230356AbhEJDak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:30:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnWgQznYn029CgH0JXt7YOGQRBpiwm5HeCR95SP1E7/yBOy7B67Zl0z6nlfNn+T9YsCZBeendsT2bik7/lYlVpRzZ6pWQscFVAhYQFcLEdgASPgTPGsVEk+w/mXKoGGJattHJK21lKI2itSJeR9nauSZAmoG4ZeHfLU2XZEiGoENX6wkmpT3hX3rbMbmsuo7TiqmOTLi3KfAfHdzO62c1a+34WYL2xcTGOEfNVQMb2D8+HHkk74D+ydwtwaxNNi1HES1mkKz/+Xs7ZbSAFWf8PGY9fkGVtJbe3EjA4kVrBibnFVYTfXC57RPRl7cRg/C4ckVB3Twr5z0Id+IbhiDLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjlRWO8cOUoxrFGQ/W9cviGeigU8Ax/aVi0piZhgup4=;
 b=OHI484MjMOosU30pZ2cGe0dsp5vdtRxx225eamI38OUTEOfJsYy6NLnZHHAutXtyQ82GeJLXm9tmOxDaalT0+kdsTiZtLTpsl2mqN5nSBEwM4w115RTPp6cwKmZezBUeN6f/N44qoGLEfewmm8KZ1sZt7HUjYJxpLq5H4Yuj7JAq626eioDFGbvCVrNdzhpDHKrYs2COfPBoTxUCesmwaGr0YKHpqMsUXWDSdeUDBedDeW/yfJEQsG7muvqjGDcOhhyGltDR1jDrvs+NO3KSmU+VkqHhQ9r1bQ0OoOae7SCjtcHMVwoG7bKOVzl1mRrsxFlL9AYPyD5AwZZz1GylwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjlRWO8cOUoxrFGQ/W9cviGeigU8Ax/aVi0piZhgup4=;
 b=cFm+6EMm/ZVlAO+Buf/2ThI6k4ZI/o3VOIh0qDjgt/MOs51CbLlE1BSYojr+uCuEedNkYlyF6SN0YLQl+FxQz0xFnF9aU9bPeqYuoP61+m7mqmhe4YyILbDE3stjRPElrjyE5nxQ6gSbPYk92j3seJZx4Y2/ylqJZX9ftQAXs4Q=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4091.eurprd04.prod.outlook.com (2603:10a6:5:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 03:29:34 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 03:29:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 06/13] soc: imx: gpcv2: add runtime PM support for power-domains
Date:   Mon, 10 May 2021 12:00:38 +0800
Message-Id: <20210510040045.13225-7-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 03:29:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 751cede2-b02b-46ba-1d2e-08d91363d42c
X-MS-TrafficTypeDiagnostic: DB7PR04MB4091:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB409161CD4F637769F5194E94C9549@DB7PR04MB4091.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7lX30uqXixYIcBSyUd4JEAGtAycsTVGVqmI8y7mXUt7i/Yn3IJijB6fJUtlS8X28Ck1WwXKzra5hAvXzONgXebkC5hGfyBSWvV7qqoB/PUjL9aHbz8h4PEfMlxk2E8y9D1WWi7IGLLP/LfxngNCTK+QxHLuU4QU0BpY/R7N9d0Ct8GhroXRctV8t/20X/nPHdXGCowNOwbHCAm9M4ks0IRjldb44ktO9YUSAoYpmuSs4O8NGU5D74Aqsb8yf+HtUF5EUccNkT76nEBI017dAMqMPMAAvHX0aOKt8PANQaJy9lz8LHqvIFLZ5RQwRIthV/ZhC87kF03tZ3Hgk2GUceCIM3/9HbpDe8wW/p0RSjQJ0roK0p+6odLQ9Z1KeJvO80YfGBwJAsHavqBPKH5FqBiMPVLfbQqDWlG9LbWeXG5OwZbp/59XxBymIEw8pZpwvlw773XLI9w463MGRv0Sb1QucXiQwLWyh3Zb6MLVs0sRNjQS6ChGuE1qz7FT8IAx+1w/fAOlfPGr7BFvwQqlGmm43ivVGL5afEOEV2GxFGnohbDP3ziqhCBh3g5mQoVEC5Pj6Ya+6xJfV0Y9GqkZpATvpcgfCWlE3X2eEiOTca5OZoQ4gxxiYiAwD5WRFIuDiLE7w+94WHw9tOTNQUu4hHBJ6+aGO8Y/sOtvMAowohUM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(316002)(86362001)(478600001)(4326008)(1076003)(2616005)(956004)(5660300002)(16526019)(6666004)(7416002)(66476007)(38100700002)(83380400001)(6506007)(52116002)(26005)(2906002)(38350700002)(6512007)(6486002)(66556008)(8936002)(186003)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mS6tw4u9CtSzts5jytjyeb9KR/h7ep7R0P1glIGKM76EuN8DPXYIjAGIo1fX?=
 =?us-ascii?Q?eMrWRnl7pDbObjBxZOhD4i5DQ+GXSCX9ECruR4jDwXDd5+QQTPE37heccPCV?=
 =?us-ascii?Q?LDOZMDdYp8IMGzRRz1YLDqZfhMnAmotJVWgtOeHqVilG2R/u4zHfYNehhpuo?=
 =?us-ascii?Q?RjiOQ5oMVJ00Aw5PNMzU0ZUbGf5nz8HysQvl+9R428otLf3eeYwWKp2d0gYn?=
 =?us-ascii?Q?hzzQmk73Grc1u4MugUaYdEhheWkxSrF+GHwBLOG+4SK4WCMwq/5pp35WvUs9?=
 =?us-ascii?Q?xKck3Ry+y4cGQo+gSF8qeRCUJmUu9cd9Ixgrb0i9Fr8yTS1O1VmTqWM2SxrX?=
 =?us-ascii?Q?FJxKznMn09MpjNVKnJ5IogF/lfwhtszBKMwV3jzMcWCi4t17sk3giwo60OJW?=
 =?us-ascii?Q?bMs4+NTY4UnifMHcTQNbe/iOaUJxvyVDKJRpdcEMcAEbzp+6In9EKhI37RSY?=
 =?us-ascii?Q?h3o9NKW45jIsFS+g5HZe2jmf4c8GZAeAtAIYn0aBPDP8Lb23QWN/pofdTGp0?=
 =?us-ascii?Q?b9WJozgR1kbNodAmrg1hkj2sXQGS8Enh8+rH3rg7KRgVymMk6VkvhoMGZiq8?=
 =?us-ascii?Q?9LJ/Di8p8QkoSPKNPh/my5QHNJ0UUkFl3i/uCvjhOV3NgFCy2OS+3GgGn1kt?=
 =?us-ascii?Q?9UzhmTMK5xYBC6fkr6m3cKIeYykkv3HA5dTNKKMsBw9hiRMjO4oRhYrxS+P5?=
 =?us-ascii?Q?BKdHuebI6VgoR7Jnk1RMDSFazxxKmbzxsPkjTPJxBzgC29bEVssPrkir3XY1?=
 =?us-ascii?Q?wp2iesnqoqv9zXzfKFfLEJuQJVxT+i65fzlDX0fEV8rIxFVJ10ecfwbzsUrb?=
 =?us-ascii?Q?TuMx+QIpIuEZS5PC2FGCt6napF/mD5e06Px7YepH2hAewXguxfNYPwcw7RS6?=
 =?us-ascii?Q?eEzw1BWe3ldnUnIoOHVEuPvIAXNQB6pBZNLU0zFanw7rkEB/gLYEEKRym0ol?=
 =?us-ascii?Q?hcpqw5RVlkmttI4EwyIgbyX2E3A5Z+cCeLJrS8fRfXk+z7SuUMubL+nHcDge?=
 =?us-ascii?Q?CoB9k6WfY1ROJHjRqYaW+MeFXsHI8XGs9N05SJE1gvTCdsaBgTD3gPGh/G46?=
 =?us-ascii?Q?sgvzqpXS4DnuijjG7OSqtcGyG/AhJBF1z9NoFeAQzeUASL3rUFsIlnOl6fUU?=
 =?us-ascii?Q?3dggp01IDbkHaasNeMna3CAHHfQRZWCk+60KcTZbbJABYGGVrp6VxfdvUNuw?=
 =?us-ascii?Q?1TROm76McrALrcOxFytm86WYBnvwaPJDFaYwQjORjEtN7iPtt15VIewT0+wV?=
 =?us-ascii?Q?K+pMlAZgio1atJ2oj50yuV3LKFnjShdkC5tugQPTOwr1F18tadOcgVw37JpK?=
 =?us-ascii?Q?prYiYDSrt0o2aut0w2BJKuQs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751cede2-b02b-46ba-1d2e-08d91363d42c
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 03:29:33.4075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eo5ycuh86G+lAXdQfcZOGiCEmbGls57sS2KvzR8wfsvjDPPRRVKrOk3N235l7njkCjtYtPFPF1jL/piU568BrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This allows to nest domains into other power domains and have the
parent domain powered up/down as required by the child domains.

Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index c449cd0e1499..800287abdbea 100644
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

