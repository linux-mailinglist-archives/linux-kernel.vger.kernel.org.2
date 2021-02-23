Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E0B322493
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 04:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhBWDP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 22:15:26 -0500
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:56033
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230014AbhBWDPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 22:15:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9Rpn0wOiJ20Icd5a3ohP17SIe2cV0mA9+UvgZfotK7n1QXDr+UEuM3ar8axyJMWvPx7nDGIM5q9l8j2/J6vgsFLC7G1EMvAcclKzl662oSqVAL1aOoPw04WkAWH+rzwvKmYnurDUfrYexKJI8Kv96gqtvap9hOdo7j1nvqckNDsri9KHYjWPdyFUjasswITr8025HBfrn+DdCm5oreAKCCrahli+G37Y1ORTLzm7tfcJFRrV2SwEUb3/Y5El2PCghPP8X9prEB+r6zVrX74rFEMrVNgJcrO7dmWLeJtIRfKCbmEBTSufQ0K6HdJsT8bQqXD3DkwwTZ9tYukUWBV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HM649bWL11klou6BsSpee10RhSO1obvR6A4QgHc1DSg=;
 b=iCJJm37ahieTwNjGBhC3QYypYdbOuoPqHsYELHHP9Rj1d7rvFbje+spVmfUcZ+f8KP6NUBC/Iq2tiLmGVaMSeEFWTXYiJ6Xb46Gkbg1PUTESmX+2klTRH7pFoTavXHQD0Bw2fB/c8JAmJbuRC8e4PBliIRxd6qKrKnR2jlURD8hipn80BgdAulguUcE5JY8UylSDLM1HziiIukaS8Z8Q59+Yb6QKddQ+YXBDE6gg2v4fw1FypkkgzvBgD5nXVWCaTyTgKl/h2YSFm+9O4wpVqJezgw0/eb1X3UbUKCVZXelc8TSMReYpGyZMfEItiqJIMF0tEJbhcFI9o4qvFOucAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HM649bWL11klou6BsSpee10RhSO1obvR6A4QgHc1DSg=;
 b=JDtIRMyIqYZMrRzODG+4ol190CoQ8tj+70JsqDqNwNaLmx/JQ9nAxOULJtIeR+ftgKI3WERkMkF9HKucos7yy2LjqNkmxOIB0FWlSdUPx8v74bI9f5NoVTmcEpzh7/EOGJp8vzEvKn+PzU9gbGU4J/8PLLB1jrE/7+w3Cvu2XDg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR04MB6453.eurprd04.prod.outlook.com (2603:10a6:20b:d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Tue, 23 Feb
 2021 03:14:33 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::394e:4132:3afd:7d94]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::394e:4132:3afd:7d94%3]) with mapi id 15.20.3868.032; Tue, 23 Feb 2021
 03:14:33 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: imx8m: add pmu node
Date:   Tue, 23 Feb 2021 11:14:45 +0800
Message-Id: <20210223031445.8577-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR04CA0190.apcprd04.prod.outlook.com (2603:1096:4:14::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 03:14:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84659ff7-3b2e-47c3-3ff1-08d8d7a9242e
X-MS-TrafficTypeDiagnostic: AM6PR04MB6453:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB6453BB9213BB3BA0F71027C5A3809@AM6PR04MB6453.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hDhZVfLcH4W1rzBQOKu6WZB5QvmQkmsunJFPgpecmdl5XrB4iRR5FwPftUHrmMsvaZwtd20r1ovMX3S8PEy6H7RInV3zJMmFCcVWv5ET2kYR5MJmSe5UOgZ1InAoO1vPU5IwYRtjbVyn8mtzPs1bA/kgL9oLpy6AadGpR3jaw547nROYplmdCGuyHDqdztn3qx/3+p65AZmiQf4hPKPUUicW04K4cZbvxa6ZVlyLtsg/G0uCf+h2QnC7gcHvf6iYlSe5PBsNZmPhlXsmn4HahK9OK9QH+H58SsSxzEixB8GtSDWCgi9qu9aqi9/91Mk3B9uhHqIDz3kjjCYysvQQezkydENRxVA5RCrG/lQSPIak//jI4hMiPsVHVsTMPt5nZ6b6QisCfwGATx+awxV+oPZagBq86xHN91LfUHcsd0CWO6jqWhcgvKEOvJCzjjY9NpnEs8CtHUoFCv9852aNuMzTv41pWvE0IEDmDfYKcz3LcQfyD1b9n8Bgd93lnYJjnLkIiN9SMO2ov4lhOJ9eeHd1xGX71HU1+Ap/ulusZiNUWSxX4VVy5ikWt4cGi5R2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(1076003)(8936002)(4326008)(8676002)(86362001)(478600001)(6486002)(6512007)(66556008)(52116002)(2906002)(5660300002)(2616005)(66946007)(316002)(66476007)(956004)(16526019)(6506007)(186003)(6666004)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ISPd5Ngos6a8+afFygOAgC6kuRDFxLCTipcapLNWlfvY44ceob0nCANt0Al0?=
 =?us-ascii?Q?Q6iOpqkh52blrToU+Px1TY9EnlcSq1XxsUI1TVOfBlkBq54iXxxuMz+k8Xms?=
 =?us-ascii?Q?NqHmwN79BvzU+DaUlDzOLqBkN6xhaIr0U50Xc7fNYqhByinJkxdwUydsC9zt?=
 =?us-ascii?Q?8YxERc69iwvqvu7htQUJeCK2vfO+Fo6Yxoa3IhDttXZ/zmMuoBtUgYglxlhX?=
 =?us-ascii?Q?zB/VOcFwa6DJ8UMzoD4JAZmFXNoamNDHfoN8b3i3hWRGtcU2A8sCPOlBqFke?=
 =?us-ascii?Q?pS2V6qce+H7F10dilzved59rocpO9tKhel7BgGIgXmEzCNNYF+bC6j6ael3E?=
 =?us-ascii?Q?qqt8xow5P55VjVm2EAAC6dy+HZUiI940A4CoeDPoFRUBR+0HWRV4HgSC0/MA?=
 =?us-ascii?Q?DzqRGGjt9KMPKhGIFjhVlz5IuvtIvnjONj4n6SjtBvlUatLAXkT+S05MbB1Z?=
 =?us-ascii?Q?W9mJoq0xHJxa9go/pHkSijb+1xvKiQFw7ZxUtS9xDVwbcfBb79KbK0HfZI8A?=
 =?us-ascii?Q?x2TlE431YlhmWDxuJWvTeK6apnQOxA7ISd0c0s3IsATg+MY1Zu6QRgRSG56R?=
 =?us-ascii?Q?55hHXDEyobHj0LvOsAGSzoyYPuCoUhip+ji1wquYuFzx6dnab1JAhgaMwsnn?=
 =?us-ascii?Q?q5nmTGVF4iI6vAyroZaR6pHeK1poNpQnndG01obO/dgExuSHYi4qdhkm8O7W?=
 =?us-ascii?Q?BeMtRq4rpX8VU0crIuBSRDPo1l4JJpMqB0cIAwCzTOvmdGb1GqzGB42SRdDP?=
 =?us-ascii?Q?Vm16chwm+dC4QpM2jLljRrBtnqq6cK44oWpOz1VJABTg1wR1LwJBFw7gyiMB?=
 =?us-ascii?Q?26xBlB+Bz/Xja/X0iAZkyxNEBarvFekeSnJ6cuvTPZB8yp7R5X6qL+40fDld?=
 =?us-ascii?Q?Os2OVbh5KPZ91HPjxrblM/dLu1y+Hv0bYOOP45q3f8/NCWg/DH13ol56dySg?=
 =?us-ascii?Q?kD2Yhg9PQZ7I5ek4SYsmqyQ8MtiyE/kJVeP84q1Cpa3iC2I0+XAvMX032rYa?=
 =?us-ascii?Q?8ACXfm17DTb1nA3838FbQH7fh4ucW71wUvaEP9EBGe5KG9Gxsm1JVRxepGWK?=
 =?us-ascii?Q?iRgde17UzGMWPD5NK+TZ2IMYuDKmlio5jMkIkK6CFHSoB/59Fs5WBUEcEL8P?=
 =?us-ascii?Q?a4I2XtNyCX81kdgE1zvE5T9a5zZCZrcqvPb4fDw7csvF8FHrUQaRJzphyO9o?=
 =?us-ascii?Q?hLwzYLUz/px42tiUSFqU+LcN8ehL+ZsJ6LW9FLLr7Weq6zP1UfK96OOEtPSW?=
 =?us-ascii?Q?kHOnim+TzEEkk4j6ng2JbWFwAyhLRSDdFAV40y6OZn+DvoKbvd3hVGrQMgEz?=
 =?us-ascii?Q?6VBkoyI47HGVzR2Acm6Q5muu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84659ff7-3b2e-47c3-3ff1-08d8d7a9242e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 03:14:33.1109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ols9kyd1Ww0V0KMJeEJA5YrQt/p7RLWnr3/lhfjAkB1/B3xrolYdhRSMdBoN+Uh3dSPWyEKLzi/jFKXMe6pTAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6453
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Guo <alice.guo@nxp.com>

Adding pmu node supports to use perf tool to monitor the CPU performance
of the inmate cell when enabling Jailhouse and running dual Linux OS.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk-inmate.dts | 7 +++++++
 arch/arm64/boot/dts/freescale/imx8mn-evk-inmate.dts | 8 ++++++++
 arch/arm64/boot/dts/freescale/imx8mp-evk-inmate.dts | 8 ++++++++
 arch/arm64/boot/dts/freescale/imx8mq-evk-inmate.dts | 7 +++++++
 4 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk-inmate.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk-inmate.dts
index fe9d96131045..6afccc2c140e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk-inmate.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk-inmate.dts
@@ -48,6 +48,13 @@
 		};
 	};

+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7
+			     (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupt-affinity = <&A53_2>, <&A53_3>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk-inmate.dts b/arch/arm64/boot/dts/freescale/imx8mn-evk-inmate.dts
index 584c1fa19f56..f2434ad369dc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk-inmate.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk-inmate.dts
@@ -48,6 +48,14 @@
 		};
 	};

+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 7
+			     (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupt-affinity = <&A53_2>, <&A53_3>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk-inmate.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk-inmate.dts
index 277ef70f2903..be538f510340 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk-inmate.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk-inmate.dts
@@ -48,6 +48,14 @@
 		};
 	};

+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 7
+			     (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupt-affinity = <&A53_2>, <&A53_3>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk-inmate.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk-inmate.dts
index b1db63cdb98c..57e0ab2bf4d3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk-inmate.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk-inmate.dts
@@ -48,6 +48,13 @@
 		};
 	};

+	pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		interrupt-affinity = <&A53_2>, <&A53_3>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
--
2.17.1

