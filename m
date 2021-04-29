Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51C636E54D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbhD2HAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:00:31 -0400
Received: from mail-vi1eur05on2055.outbound.protection.outlook.com ([40.107.21.55]:56627
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237447AbhD2HAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:00:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOs5tc9tPGARcNWv1dNBwiLXmfQX6iszeHNI43YXAvBPlKE/6IxTnznMhHzOrruU2IJAls2+ONSftUe7AnUNtb9rqMvahsGZKnCtql52Nm7biegRRyAbtJhlW4TpEEOZASoHs9nlpaapm3yN8vcIiWXEcWzelYiYMVzusAIcBoGCif2gdH3ifjPmKYB7K0oJNkU8LKuCwcbv6P+FboscDhRoAvm8q72ccMnZs+HCRGk0vLOGVFyvUNOC07h/iPuZAxYftDxOvCclRRM20W9K8MA6Hm0i9muXSiXSO8KRTx0jQqfJ4ZPv25ljoWI0cKN9qWCOr2KdaLsP3IhDjh1/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1f+Qunlsir5qWbv5njsoGllEEToCJYtPIul9+hHO7eo=;
 b=jMHMpDxlE5B4Nrl8i8rCaZATbOD225TF+atpFQAtSf3tTTd4SCIY4eM8xEv5l7z45Z19Ra+HPy0D91Lo9IJrrAla2k0Yy/ttnxbZq+bjNS+Zk82dEFcuC3G3KvWySDDASrriu8D9qvKJwNpHhyga6/N6ygarWgBUnvRTEURTc6xV2Zd271dd+LToAwvMDdTDQIhowJOjc28FPEQcMrO35s8uHQyXUtOffl+/kR3bI2EYBFTYBLkvbChCRP8wOKgIVLHUaW6P/iX6jqXAA6UPR3o5rlRUEDCiJGhu8bn1jWcgoMXNMhMOhRSHk6MB2SUT/BRsweKgP1+vNiqC2ZVoeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1f+Qunlsir5qWbv5njsoGllEEToCJYtPIul9+hHO7eo=;
 b=Il3QsT4lxLn928XMq4GQ76LeE6coq/CdVNsDYRvUDId1CTkCBFjPYShLuSb9u6zxBkldV75245raMZC9aEYHsxKhFpVZiAJo3AZQr6/xfj0fYiOgz7L8A9jN3VBIt6vxMFNLMXwLhSDVXwiu77aJV4pz8QKvbT7+QfjsnZeJXdg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5468.eurprd04.prod.outlook.com (2603:10a6:10:86::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 06:59:39 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.023; Thu, 29 Apr 2021
 06:59:39 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com
Subject: [PATCH 06/16] soc: imx: gpcv2: add runtime PM support for power-domains
Date:   Thu, 29 Apr 2021 15:30:40 +0800
Message-Id: <20210429073050.21039-7-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Thu, 29 Apr 2021 06:59:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 987293ba-39b5-4c8c-9a2f-08d90adc5b61
X-MS-TrafficTypeDiagnostic: DB7PR04MB5468:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5468E2CCE9B543A2587BE7BDC95F9@DB7PR04MB5468.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DibhZkSB8uX8TINSuuv8KdTPrOPVMXjbGtfzpfJAgt5q1ASjLiBA3JKHYzJNblMvpT3Q1kK338pTHbA75e2dThBaWUihwNrzgbs7I0Ha6K+adSnIO+rCuVikNJWdv5hvLNHGHkknUAuPA7CFmYlMOzC19qQHS/RxarqTTYgRqi6DcFOCEklvwhwGm2IkcX+V1UjrKLS+U7sil/VmTxsFbkhdLBMRJ7aqtkvtRHohd1934hP7HWyFRQpItdxGdoA2GU8/f1mFOrVSXP6gr0AFar7o4L5mtpHbKzCgqhMcFjKLT5U2m3kVkfkfUWmAxm45NiMrGb6tA0qmo7yCk2N30nQ2X/gV7ErUhYeJQfMMcQ1NNmEVNkV9N+GZA8D42u4W6wDt0R71nL81h5JwKOUwVxU89YDnmUal7Zbw4LlWwdd3rCPTfKDwun8ABY5DyBjvzMhu9Eo3dU+/6C/khpm7mHNoptd267WA1gYRt5itdMKcLYkg1mgZzsTx3dFunsd1s6HR24xw/AGnb8laZ4iYR8T/r2R9lqoO2yEGYv9yZZYFc6W3qD6VclmN3rliupL6iI1y8PDc/K1MV9QklLHoljR0rh6aQmGaSpkD/MhIwkfTLa5HO303TyUAqDnS/sJ6bCV5X7e2/4PAmzZcVyvKSoQkL1ysiVAk/4BduWFUtvg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(2906002)(8936002)(4326008)(52116002)(38100700002)(38350700002)(6666004)(956004)(6512007)(83380400001)(8676002)(66946007)(66476007)(16526019)(2616005)(1076003)(6506007)(186003)(6486002)(66556008)(7416002)(478600001)(5660300002)(26005)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?K8fmMoJXrgs3E0a0wkJ8Oc+PBVnjeyeLHSrBjKHVOKNgU5nW8aJtjL3u2/QY?=
 =?us-ascii?Q?2UUjhl4QypW9/p9T+o1bv+2B+M1+SRxbTcpym2WgEjyuxH3aywLgSrkQmi9s?=
 =?us-ascii?Q?AzqgkA0DiKgd5jJAdHO8d1PiONak751r+29YLATjJx76VosdXTRjWSj+dcM8?=
 =?us-ascii?Q?QMODPWzhh3lRI4kDscWi1bxDMAH/iZFFiktilRw8Xb0aFhluLEp96w/VcRN5?=
 =?us-ascii?Q?gmKOcR1uCbFo8IswqQX5pB2VFCcCkzWaf6lUFCkiqxCeV1dkMV5Ggs/XAxi3?=
 =?us-ascii?Q?4hR7/TpJ/c1JoTcMgxv8/FCSToalPS6C51fVZdXaeYJbRFKG6WwK0yMhajWV?=
 =?us-ascii?Q?KUsrEzmX5/lJVTWCDeJGPQtr/3ZNm67C9ZQNXyxjBJdy85cerC2OjCn8AOfq?=
 =?us-ascii?Q?ShAVCs5bCmnDBj3fVERN5s2VWPe6UJkSEG2uY5mIB4KqjropuD3PhGhS3bvY?=
 =?us-ascii?Q?02IYeO3pCn4/nu16RW2NvL2FKpt3LOSbz5igg7F5pC7rBNcGjxAqro0qeeIV?=
 =?us-ascii?Q?3wWzza/NAYOILWCrG+RON3v3YcqLvM5STFTAFmM+HrMa/6JXtTYGzPo/vZVy?=
 =?us-ascii?Q?yegnXYAww94X6ASzfTf6onGbOyswWfskPqLzZ0mFDVopDdjNxmu0U1FqlqWb?=
 =?us-ascii?Q?IMCRZDImkwYNlgQUtlGWT6YNMSsLeDWhtOUXBZnFNF2l2bcupFYn8CdtOOoh?=
 =?us-ascii?Q?JZa7bXYEZF/Qy7xFgaxrFjpVD5yUUegPSnqWIBiri3AL2rg1s8PBmfbQapL2?=
 =?us-ascii?Q?HLiTLiZ1vVaoeSrE3cOQRIULCFj2QOKb5nn0pyGHyD/kPIJBVIaaWvN1Ksqx?=
 =?us-ascii?Q?w2HHbTNTKwKmNYp+TakADynwujFZGofmoZWKS7HFwVhJLoY8Mpi5X8LfTD/X?=
 =?us-ascii?Q?fgK7CF7+wjCx/ZghLLI5qm/LoumKA2Olxh7v3+XkOtYY35mnGOSHxiZ+cjOQ?=
 =?us-ascii?Q?rLipRWhexpuyjKWAOlTONwYQ641TaRQN7GzH8OT6G0kK1Lkq6e5cQLYw4+EU?=
 =?us-ascii?Q?Q1zeoFoVNWzjsTzZNVtOr7wpxQ3LQCxqPm8DseJlaIlkE1WSLe19EWNeFcPo?=
 =?us-ascii?Q?LJvE5ebIFe9K5SuVzQxX2drvLGNggCsOjm79/k7BiwiC8gvkdpfYLCgHSs4u?=
 =?us-ascii?Q?lUYsXmeJ2r8Iem1qbdt59DKMA1dF7Waq67Qr/tAbxpgum/eBOqO8j/DA9FIb?=
 =?us-ascii?Q?RUZMBvWjxC4yAGIWdl63ZYAqQu1OGkWAh/vmmosqFYj6m61SV7Pi8ERZ0aqM?=
 =?us-ascii?Q?vrxfpGECCislAO1xz28M8s0NH7ODPeCoFpw7vxGH/CvhXIomdHi5ARTNYt3p?=
 =?us-ascii?Q?3irsE4R4kAC0yrcYUMtAHVyN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987293ba-39b5-4c8c-9a2f-08d90adc5b61
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:59:39.3651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfdsM7ja41voJg3iL6hq7TtHLNXJITznfUcbyYz3L5fpiQwj4Z/JurT8+/LK5N/cYoZtqDWiAfSK1UW3sM7QGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This allows to nest domains into other power domains and have the
parent domain powered up/down as required by the child domains.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/soc/imx/gpcv2.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index d27025e37a9e..87165619a689 100644
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
+	if (ret) {
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
 
@@ -200,6 +207,8 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 out_regulator_disable:
 	if (!IS_ERR(domain->regulator))
 		regulator_disable(domain->regulator);
+out_put_pm:
+	pm_runtime_put(domain->dev);
 
 	return ret;
 }
@@ -262,6 +271,8 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
 		}
 	}
 
+	pm_runtime_put(domain->dev);
+
 	return 0;
 
 out_clk_disable:
@@ -519,6 +530,8 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 		return dev_err_probe(domain->dev, domain->num_clks,
 				     "Failed to get domain's clocks\n");
 
+	pm_runtime_enable(domain->dev);
+
 	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
 			   domain->bits.map, domain->bits.map);
 
@@ -542,6 +555,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 out_domain_unmap:
 	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
 			   domain->bits.map, 0);
+	pm_runtime_disable(domain->dev);
 
 	return ret;
 }
@@ -556,6 +570,8 @@ static int imx_pgc_domain_remove(struct platform_device *pdev)
 	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
 			   domain->bits.map, 0);
 
+	pm_runtime_disable(domain->dev);
+
 	return 0;
 }
 
-- 
2.30.0

