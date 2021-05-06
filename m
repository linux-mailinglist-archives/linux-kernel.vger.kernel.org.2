Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5395C374C5C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 02:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhEFAde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 20:33:34 -0400
Received: from mail-eopbgr20041.outbound.protection.outlook.com ([40.107.2.41]:56071
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229488AbhEFAdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 20:33:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5o4+i3zxUvAMQqR5jaCCW14d5oHdu4ZZ/yfQEe7nXf5jsnqNKylWRV5Xsxl9fS3JlWcRAvgwjAqJdYGneaiGX9XyFv+PZd+AJ3R/Tw4ZXf8gBnBRyOuu0bjWt14iBFzt/0T6GcYZwmfFcoE4Yc659skEEBGTYNe4xlfb1vnPRrbDor6J6lNwZPZn4E1UHGvjINn4dOMTxs0FZIkFQwvCsEA+exGKgQUJ1LAdyLmgTMc92faVn2LbcEbTGdVAg/+dy3kz9QnRtiBetuw8Wr5zgpjo3QC3JcrPnlNIBSkQR9nQ+EjhXPm850j6liuC46bhlAGD1S22NTh22C6qqZG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sU24wCij+bCWA90Y3hrt6CYeamERlm28szKtI5l3qg=;
 b=lfnSE19wmbF+uwUhtBnNaFQFdOejsoR3hHCzjZ2Ofgv3qkJAYsaU2ixeo8J2jd51+B7Vu53+d4M03+t0b2RvDjXi6t30hAynEYU6UGKbrNpnzZbF2qndUdHBBRui7jaEzKW8Zou6D1jYc+boVmhpEglAXytTRaXW0iwmm4pEh9Q5znvHJYKWe7RRygjd1U26yr3h9S2/nrJh4FV/bGUdsjMkBJPRmWIVULD61uXG/PPGGO+ZqjUGAMYMqnpQp3deVyaiC6ZauRLcguHwYlTm3NidwgsOGPdrxSa35eS06f+PGHJD2n6TliQ58epW/CILpGOuPzxjkQKQcp2XO/KdhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sU24wCij+bCWA90Y3hrt6CYeamERlm28szKtI5l3qg=;
 b=hGXtKpjXiW8jTZ7Twz+7UWLHdFqsfqarz9Q/OxSjN7FQzk86varIMqBv+CUs5zOP2N+80BeF7kEq6hHVinvKda3pm10rkD5pcrGBQIuriWUH9YOdfAcPmHhLNnJ1eH6Q+l/bVJHGDPrSb00j5+5FFTxRLVaLh4oslLMVD2Vlkv0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6714.eurprd04.prod.outlook.com (2603:10a6:10:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 00:32:32 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 00:32:32 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 01/13] soc: imx: gpcv2: move to more ideomatic error handling in probe
Date:   Thu,  6 May 2021 09:04:28 +0800
Message-Id: <20210506010440.7016-2-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 6 May 2021 00:32:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa1b76e4-455f-4456-64da-08d910266fac
X-MS-TrafficTypeDiagnostic: DB8PR04MB6714:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6714412EE2822A18938EE691C9589@DB8PR04MB6714.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qEGDS01sxetlKHvgOK9VKO0Vex89pkefOBt63IflfFwwYUrm4myvfmqqVyJIbdh7I3hvf6gonOmqPZ3ZJmk/Y00eo8FNWURSZ8TbnkLnqas1yDNNQNZxs6x0WkvmQ+P6H26erK4P1vo8QZ4GV2wfCEgy2XX0hAN2I6CWc/+a1lp2PzQq7zkq8JQ3Q7FPQl71EikGYEPKC2rF5W7xnRGwzNbPqB2zQX0Aty6/sm8nfqma+/GsdobI+JvlaugCJ4WPd05I0npn3lygIg2bLOZCeviCHr+Q+I9PZ0PBr1FpH3SftuO+ipsTyy33eg2HnH9aqEIJNZMUPCgmdDRZ3Lg6St34beL0g+yjslqXz/aeOT0Q8tUm6mCA0jkoPRqH3Et/wWUUWX57gr9eZV4PLuOgbe/08ysv2gR6I4earSY2uPh7/CstR+D0I8mwlqcAzQhT/TPMKFYJBl2m0VXOYM9z/YZeSFx5DSWL2GHDerv5ycYErwpgmhpkUX5dt5lVRSJrXiAcNvdoLF3b+qm+wgTHKoAZjFvxKf/hYkd2+QABFyyx1ROxSksh/WR+qrz/8Ryd88elon6z+3dbB7Xo5/D+sPmwYl6PzO8SdE9JsajOH0AfOoftXpzQGh5o2FAuwmGom/jSR+zH02CGu/kfETCTAhfTEUICjJMGeKRgQoICBek=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(52116002)(86362001)(2616005)(16526019)(83380400001)(956004)(6506007)(8936002)(5660300002)(7416002)(6512007)(6486002)(316002)(186003)(4326008)(2906002)(478600001)(26005)(1076003)(38350700002)(38100700002)(8676002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?X+sxRkR3/kmdhxg61nkyUf5OhprK8RXBMfWt11uZ1tK8OqRhddnKkrW7dNZ+?=
 =?us-ascii?Q?+lPkokGMW0g054wBN2E054rUAn7zRCpzH66pFdgqKZ6eI1/uwczW4Rl6tuu6?=
 =?us-ascii?Q?A6KUxNz+D33r3D1bLTc2mtymht7XKWlF2ye08/8Z779WH/8hSsFoOn4QBA66?=
 =?us-ascii?Q?OQiGF4xEzbJ6FK/OWRPfqwzkyexfzWS1WhSoStW1rmzDRfVosQAKGUmhOV8x?=
 =?us-ascii?Q?OR92xnZ32El3ZP95U+q/qttS9IBJj3AlZg9uBsGrIMRyoRKMrf12JUKes59l?=
 =?us-ascii?Q?UlDeW8o9yWfLIsPgYWDLaBnuV/6qXbf087gcSRcE4F2nYW7nWVp9IVQe8wRH?=
 =?us-ascii?Q?OpUvvj5Ey3Q/FESGGFIzvuuJzvCfgiEaWOumWWe+hvUHE7bpJvU9x/XDM88h?=
 =?us-ascii?Q?TEn/P8awSJT7FN9UmqjDmnFC38JN2Ya4Wxr8xYxvVMcX30QWefAaKjmtEhfJ?=
 =?us-ascii?Q?k+HfX/zbyWrJ+NeuZsWaxkMORI3mJeNfj0j3vQlfoJdULVbNWik9MlNVSiHt?=
 =?us-ascii?Q?M4lgMW+omAgBHRAVIx8ps9ZmT3Eh3TlXqLv60wNtMyGgWMr5EyJG33aQdAgH?=
 =?us-ascii?Q?TBF+3yV9iqI1o7OZmhdvHq1NeX5kVH0EcXIBQ9qFTIewzROxkCL0043SDRif?=
 =?us-ascii?Q?KRDf9v+BbDEUR3MUAcH1q3JE5bDDQShy2fQPaCF8zouyrKR0Sy8QlgvoEpdX?=
 =?us-ascii?Q?eqv6lg81hcFwgXXmoJP8STIA8LpjGfe9iocks3CJ7DOYPA1cZ0bTFE4sX7cK?=
 =?us-ascii?Q?Kd53+gYvzuWcUCmqQgn+3HPwnhroexy+3Qusq/S2HObHAAQ5Vs/p20hJ4gti?=
 =?us-ascii?Q?MuB1wic/J+M1BjiyAUfrkd8XRAcVXYVzvRNO1NFo2g1JxLuvJMNw0kvu+yaC?=
 =?us-ascii?Q?KqvTAJqHdVGj/gAJb+CsNlVmW950Y4KrCrCZrmm7ILw2Td4JtEM+3iEv0TPA?=
 =?us-ascii?Q?FJGnWO14P0BiI3BMFdHHa+CN455HHsmL8svesydzzAES5XTiLNnYuo4JZNoY?=
 =?us-ascii?Q?/gDt/Mtqt7NRE8oNOJj0YwCKVGvMIs5oc/dOfWz1f8wY9uPoOoON0xSCbJDZ?=
 =?us-ascii?Q?otbfkaBvjAeaebvGy5LFnQvF3oDJpanHHPbI5Hh66Sn9bLB/ZfHJqGSsrBp2?=
 =?us-ascii?Q?WTJl3Y/FVxSjSa7F9OpfDPAE1dUE+riYk8YcgeA5P+m1bXzV2BLoFdKyY69U?=
 =?us-ascii?Q?aYoPXN+/lNRCy3yA9XJPCrLVOavSSUo+0TDPSj5h0DRj5vnPL7n3HhA1ONAh?=
 =?us-ascii?Q?0JUROTEYWMttu9nV80GVQAzdBe2YoiGZRKmt4+YMmWZJ0fKycLBX7rtbpohX?=
 =?us-ascii?Q?On9LyKqal7sp5JmPHBz6IIbm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1b76e4-455f-4456-64da-08d910266fac
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 00:32:32.1724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9wO72W6NQMrYeB9RMCBABeUE0WcRIkvoFOH9HqcPMp6c5fUCkGX81qIUOiqjuNTScmzXlkILXqbK4BB9dWScA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6714
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Switch to "goto out..." error handling in domain driver probe to
avoid repeating all the error paths.

Reviewed-by: Marek Vasut <marex@denx.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
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

