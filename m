Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DE63E343D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhHGJLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:11:50 -0400
Received: from mail-eopbgr30084.outbound.protection.outlook.com ([40.107.3.84]:17378
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231719AbhHGJLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:11:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmfgBnhok48ZIA3YKya3bNEx1lUqEJn3Jah3jVQiArOMvhvonaNpSgZktZKHyNHXod4vJ4T3F0lN8kuntLZNk+IU9bDZZycLekklgEPChWyffRfb18AkPDiE9dUx5NTwUyQHUujhZD9l3HWKw6bqe2LHPN/AbrDgtJsU/xAnQ8FiBZdoP3P2puBALp4cI7kcDc4wwhO9S6Nh2sxnOhuqiDbzzmHXk/oE0vEvmaSYIk6rWMG6YNhrY+tD2jXHIdaHP3lM12+ipyrg1Da5jqNoGQ+hfWi2O8Uocw10BdTcr4FPxzq076fVRdZESSoYYDosDb5RRNEDbmVLViQUmDNhdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tg/qxm/PJWJYoqV6IUCRVO8dAE/coBzZ7K21hRtWHI=;
 b=JNbjhblMvFfImiprN3mxM/T2I4j4F+AT9txyHjWWQgUdGVp9OPF5H48lFMrX9XL/mX/sE3xFWEkDnDP7fM49ZwXtsoNgj6/M7ZZe7aV3BkMy9e+WTuX9zN6i8eD9rutg40jOFu9P78/zCeQbQX/GTJ7KXwBR48ETVINwb3qVHxTdnA7G8yFR54SX4Nrav1z28Huav7ZV6EPih/p31TI8ljft9MyfN0gmT7rRGk7AWEqwX76p/BdpcoZnXL+A5RAJxPBU98k+e+5toE/Rr/kAJfy9vqusP3nrPd7SeH5GRLUbkqV+Y2xF5MOr4pupAbaMvAHGf2f4hI6S6WZirxIvQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tg/qxm/PJWJYoqV6IUCRVO8dAE/coBzZ7K21hRtWHI=;
 b=BZNqMDEGyxF/u6s3e77XTwinZzYTwlcNgJkwGtMoL/Ifmrcp9DJ0AS6TUPgt/G8DRljJkCzT1xKLhxxz9+JMUr9J2e6PnJ/Mw+XWaxBKfTfHcETFRqC05h4QivQt6vQygmFKhMiEbmQo4TT26TA+3O6T/Ny8oAje+JA8QJU9PnQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.18; Sat, 7 Aug
 2021 09:11:24 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4394.019; Sat, 7 Aug 2021
 09:11:24 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/3] arm64: dts: imx8m: drop interrupt-affinity for pmu
Date:   Sat,  7 Aug 2021 17:45:37 +0800
Message-Id: <20210807094537.20290-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210807094537.20290-1-peng.fan@oss.nxp.com>
References: <20210807094537.20290-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:3:17::31) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR02CA0019.apcprd02.prod.outlook.com (2603:1096:3:17::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Sat, 7 Aug 2021 09:11:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c67c54d-081c-4c93-0454-08d959835431
X-MS-TrafficTypeDiagnostic: DB8PR04MB7177:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB717770DAAA7A2F92C394DA4FC9F49@DB8PR04MB7177.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JMplRO/PKk9cy2mqfcwEd1aPR45D8FAU+tB8vSPWgkMB5miifXzBOmeNFzYeciXexZJlGPdnlwMiijbMD0X6k3jlXkbe6xtbOnifn/70zzV9NyDU0mxcZKrv/lHSBJJ9cUyxWSjtwv17zgOfB+BqmR+flIWHjAIDf3JuToV91SHi0mBenaBz8B+5Q4Rp29hltcbpSf5NglZiXttjd2yVSHu2jsaMXnm+4EpAjntJvGG0wQoOoeJ9BZVKuiQJ2mcEgj/kLzKF/kCjgB/N2VJGVLEwhpyYaMbk21OjZ37Rnxgl1lR1+WFkKiA88v75P3O7S8FHA5QbnXdqWjlPaFQfEXof1rSSLo6yo9E0p8wdMoUTCFfD4opUYvMpzLoNwtUDHs4yahccThuiaZzMJUKKJ7L4+kVRxHGZm/lNo9BP4mwMnbalh+RLVlRxzhqd1L30Hyz9kWopyUU8Fes/YcymEQyerCEwZt1/liSUnrknNPDYztbR51TzzyJrphRSs9FvAKSTwDT3MCQF0+KjNud02rA7Z6LtULz9BfNKuo5FOwTXLDavKObprxhUgiY2a7rH79taa1hZqD3myvoKb1M+pkrvFPcMH7ip+dMyVAzItslgW2Q7o32BOpeMr8iaKW9OZQnXSSs3gkqAZH9Nix+P4F1Zy/D01BvplOTJ6t5KM2K2ZLA7Ks8gY0N3im2KtGp7FHvzAFWTHzpTAP8jOnyK5W9lWaLIZrvRIAp0t8lze84=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(956004)(508600001)(66556008)(66476007)(5660300002)(2616005)(8676002)(6486002)(86362001)(52116002)(6506007)(83380400001)(1076003)(4326008)(2906002)(6666004)(38100700002)(8936002)(26005)(186003)(6512007)(316002)(7416002)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DVEZECt9LplCcxNC7QtTYw0k56VtJ1UF1Lqvy8cMjU/rDa08PJ9xOI8QROFA?=
 =?us-ascii?Q?ogkovWsaTyOkxdUoyIWrR3De+TF4WWBfKfp7A7FpnqEJUYiPDyE18LwKVzy9?=
 =?us-ascii?Q?XnCbnkEzr1wElzArXPijJyh7R1pM575IB06c0h1bSaDVNzg+JLaRJmfmj6qB?=
 =?us-ascii?Q?gHSQ99d6b0UZNTBeelMOuhJIYEbUXqYCiP2vz36QY/kcgDMaXpm10hymVlQi?=
 =?us-ascii?Q?4WfDbDQaDdQ5KoBf2mLuWtJ7RqI9iXy/0yrY698rshDsWzBFWMTz1IFMlqwc?=
 =?us-ascii?Q?jvlZBdqwzcXWYe/l+fNcNCWf2mWFyWiZ0IZ5atzltroG6sVeH5TkBWDqM7B6?=
 =?us-ascii?Q?4YdTwPB9kw0zkhu522vFxwQlzrNvt+tnwvpGyNwViC+75hAb5BMaH3HmDsQ+?=
 =?us-ascii?Q?8YyeB/5mFurIvNYnffBFBYGK/oe5gjrM7I982NAs9NS6r3bsS1vTMvWJmMPJ?=
 =?us-ascii?Q?jXxa5Chv6FK2ucKiAcjRRx30aN9qfFseMKnj+D6WqYc5GGxTAwkohrrSyTTk?=
 =?us-ascii?Q?NkJGKdvPhKIXOAIIlOdcAdevo838wGDf6FXhfPqgbGoxS1PCWotcV0ZTcdXI?=
 =?us-ascii?Q?e6ihlKh+InBu5eJo/6DTqTkiIsYjIfc6CmHHgxADs4JT1kTyTruSJObdi/9u?=
 =?us-ascii?Q?54/o9fMdCr8TBig7cityTkz3hJgWSE1VUpwyZkos7cj5TA51NAs9Do2k6YQc?=
 =?us-ascii?Q?PAobvQC0qoYYcDKa9n61E3yX6AOZPn4+ep1W36FuxoeNtaDY1RDSQDNGNVbP?=
 =?us-ascii?Q?+j+5FdV0CTl/lNIpgR4TTxF+szzdyRTq0L1D7clYk79wO3toQP1L5C+DYJCt?=
 =?us-ascii?Q?cXFDODbG/SCilEBTaqyZ0DAiMZ/4DAOPY29XcIkczhyNi9sJemEQTOkvUliz?=
 =?us-ascii?Q?w/DrQIQ8zLDr8JIoqPMTdHN4cSCxbpBCKJMkxAuJXwNMOw0mgfG/vq/X0YJr?=
 =?us-ascii?Q?gtybCkOPsp8jDG7mtko9MqsOEOpwBUb1vDE8JRUDI78EmSRloxF7OXUYRIbh?=
 =?us-ascii?Q?U+QDO2/y+Tca4VCnpVNLm1np9yTYpLTq60ps3QOpYtVWdsYlNrIHsIJbaZhQ?=
 =?us-ascii?Q?eF7Di4CULQ5axqTQqOe5tvZmINJsffMKPJO1yx5bwOsYjK8FwlGhK3h+mhKS?=
 =?us-ascii?Q?smMm1VtUI9SHbpVEaJWL20UI0DKVJq55zImexacmXJoIxtnjHaAckcYrrWxN?=
 =?us-ascii?Q?kOG2pra/rTLom9sNcSdlbCT1ohd/stBHZIKaf2y6P0/5UCdLflTAu9Y1AXCI?=
 =?us-ascii?Q?F6fpRDWiU188woScAcwzDQZrt6RDa5vFwNwh0lKdxl0tocnauuzDHU8pmOO5?=
 =?us-ascii?Q?WzVKZdM/+X7bOGoWly9uXCD1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c67c54d-081c-4c93-0454-08d959835431
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2021 09:11:23.9711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDmoh5X14eIhMR/2dOkVK+8eBliHP/RHodr2BF2XxDre7nH5vCVgJtl/9Mx31Mp44mEsP9osFJ9qlscdee5Y8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8M use PPI for pmu, interrupt-affinity is not needed.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 1 -
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 1 -
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 1 -
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index e878eefd8f78..2f632e8ca388 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -195,7 +195,6 @@ pmu {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_PPI 7
 			     (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-		interrupt-affinity = <&A53_0>, <&A53_1>, <&A53_2>, <&A53_3>;
 	};
 
 	timer {
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index a5822d49c6ed..da6c942fb7f9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -190,7 +190,6 @@ pmu {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_PPI 7
 			     (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-		interrupt-affinity = <&A53_0>, <&A53_1>, <&A53_2>, <&A53_3>;
 	};
 
 	psci {
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index f4eaab3ecf03..7360cb377293 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -139,7 +139,6 @@ pmu {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_PPI 7
 			     (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-		interrupt-affinity = <&A53_0>, <&A53_1>, <&A53_2>, <&A53_3>;
 	};
 
 	psci {
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 91df9c5350ae..5923d15a217b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -193,7 +193,6 @@ pmu {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
-		interrupt-affinity = <&A53_0>, <&A53_1>, <&A53_2>, <&A53_3>;
 	};
 
 	psci {
-- 
2.30.0

