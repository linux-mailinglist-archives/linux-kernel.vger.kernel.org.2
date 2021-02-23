Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5691F322481
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 04:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhBWDI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 22:08:56 -0500
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:10816
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230516AbhBWDIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 22:08:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fifDFzmZVTJksJQfBGlmKOtYblpK0gxDk2rx9swSF9u5o6gS3ckTaLEYs67p1QuuvbR9sV6sBaMdR18PwgN64JPi3EhPnLmCSg0GOU3PaUh8gZIhAWE66Vdgc/PLycpkVtcVoPM4WrP/gQOP/aO2OdIe7z9p5GKWl+w+r7ltjsQ5NYTsPUG/tFjWTTdtD7xV3KsF6SJw/xaVM/ZlxN3atuTLlvbkqPAjpLLfnu8zI/oqex2f2lazt0wODTymqL6//4bjeNg+cHTssVqpkzXQvY3NgfEMVLDHfUMj0aBzoojT1kwAuQQr31ddWnZ/LkO80pB6wNZ+/PtKVJZxKhVhmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HM649bWL11klou6BsSpee10RhSO1obvR6A4QgHc1DSg=;
 b=RfsXT9nuWAPHvLBAtCwqZcZLcgDKkGAMytS0hOROhtGELUrFTKo+WR9Rpu+Gz77Vuh7AGFOiK1SHtLAy36bJ9S4/wVTUYTL30RijrdwvBiedd2jeykeyEQr9cxZhFqLuNTK4B1hSJyvcMkJ3fIOJ1jRVGBMOriXUCDEXPQGJ0hyoWs0twmo969rHaFP1AgbmpCzDcm4K+Y/5KkAT5Wp57Fr+syHhGFUjHJpyxiK327KwnMDLfOPlBuZACdGmghBOUa6BO/7rYxtoyxzzKqTLcXC1LcpaPBCxQD6NtTk1RbJv0M3fJIUcICZR7lujRcGeoVvTdMJEVleFY61jlutL1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HM649bWL11klou6BsSpee10RhSO1obvR6A4QgHc1DSg=;
 b=RXslWn0/Jr5xoBUe+sbIIE8poJAxTQu0VtYN9eIhqhoUND5su3QmXyqvRfl+L005qS6h0J6ITZWy4uvnW5ePk3bAefyMSWUeiYm6HRpPSFFAeatSNl4/qBUlxhLwCVGB3y5d2Z0qze+ykbhIzKydS4VCUWEsenj2tL6YRnJhuzY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR04MB4696.eurprd04.prod.outlook.com (2603:10a6:20b:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 03:07:56 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::394e:4132:3afd:7d94]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::394e:4132:3afd:7d94%3]) with mapi id 15.20.3868.032; Tue, 23 Feb 2021
 03:07:56 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] LF-3434: arm64: dts: imx8m: add pmu node
Date:   Tue, 23 Feb 2021 11:08:15 +0800
Message-Id: <20210223030815.8056-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 03:07:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d5ea37d5-6e37-4322-dd16-08d8d7a837af
X-MS-TrafficTypeDiagnostic: AM6PR04MB4696:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB46969E823C186E91A7A69BECA3809@AM6PR04MB4696.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvZsvY+hL/O1O/dOR8423m/ExQqfu/AMGyTVkg35KVElwRktkKgbWDNvYapxP/R0AieJbwabKqOqS02RQ6axdm1EPHI/Zn+1DW0sTpxvITFriVpX3q54B7EEcpWhBCYrejwMgv8oH0dfMNRdvuOshpHaWIBOpKE73VF6LGTqKpTP8jH6bOuKlz7HlpdwKyi2FQUIW57QudRcuHWqHErjTrsa9rBcMY5A8bk+AFbZWHd6aeCaWseKip3g6XaMcaS5XdnBw6gQ/uRh/J1onlEpUajoVEX0PpKgLoV2+TjsjnahUPMZ2xM7RiEwhtoXOyyMv4I+Ns831FX9dFJYWcfQbbcyRitCegGQxXrqJJmI+QA5nLozu/16CdfWTffcMfCspXz9pj0y/nvcXe23cHdTw1WQsi4PYI+OXX7OHarrZ6S9CxHQUAkDGLaD5IEKx/0+2FygoetG/B39zX1r0ADKV5j8AKp7b+Gz9VtMM+64P51DfVDp6BcRz2+82XLnizkz3xk68hT9w4Mo3w2rSMiSGy8ponnLCgl+8vKcz7Z1ZlHtS1Ef8lniQgBtFex2hBB3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(316002)(6486002)(6512007)(2906002)(66476007)(66946007)(2616005)(26005)(478600001)(5660300002)(52116002)(86362001)(6666004)(66556008)(956004)(1076003)(186003)(16526019)(6506007)(8936002)(8676002)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7vfZQ5COit5TZQ6uhfjT/Akng/aE7+7tayZwDrdsjpeMdr5A8dN5ggsnpnNe?=
 =?us-ascii?Q?joDBcu6QYUrtSc9svQG2fhHAzcLoADXqz0/v2HNqF9q1DyVXuS9uIzYW/Cl2?=
 =?us-ascii?Q?ptHfyxILVK03LX/9BNwyAWvZ3TENKpM2HoIHFu8vPVQ0GXgf57D1pxfPMSOW?=
 =?us-ascii?Q?rvPGI+JpIUiohU0XYR09pADSIygg2IeEC4QfqN0H/gISYn7amBjcqu8DU3Qh?=
 =?us-ascii?Q?HNQEHx/iDc0HNSXNeQn4zFGS32KP7bV2cLlgKVoKQsaPBoHh5nt1zWJ97IDj?=
 =?us-ascii?Q?J0uFqHDRltt7GMxi/If+r7c7aWE4SdLOzwqgxBN9/Da8L/JDJWHbEPIrcOJK?=
 =?us-ascii?Q?Ne8r8Wwxp5KZhUnh6eAEhAiqMOw3Cg8dpCG/2Lrg3wCmkfXJrE6iRuC3IlJS?=
 =?us-ascii?Q?wXDhXJp1C+qKoRBHkvyZgSRG6M7LBsce5s+fXPchrm/Em2BaVK4zxCvFXgGV?=
 =?us-ascii?Q?UJhrldAtyxfyrA64FHx8mONE7FCGlJFNPGZnIN6By54vzGjXyWeMacyW7BQy?=
 =?us-ascii?Q?xI6J6BQgqjqbXzU5GAssOUYJmy5eHgE/5hj5kgV8OvgJPF+Q6PE4O8Kg7c5V?=
 =?us-ascii?Q?r0AaLuTPlrFpreRHhOVl4dFxbQU4gJ6vNvFYzsM+UStVZ5dhzxKxQQlra+I4?=
 =?us-ascii?Q?SvheYo1u819RUOHHyb6sXTGAFgee8VQvr8lwwD2aq7HxutGwJOENdJGDHyXS?=
 =?us-ascii?Q?xsbYTKnqP2FAmdQLo13EN5dunIho9GLUnlHPLKMHoz6/LX7j1FCqJjHcXGun?=
 =?us-ascii?Q?0uLc6eP6miEkoYem20F+qiL9nomYsAJWJ9/mGOjIAyoqpt6OgaxT6qAZbvTM?=
 =?us-ascii?Q?+5Bc3rN2i9tyW80ME/zE2vU6yXcevVCevdxtHjoua1T+HMQ9z4ZdnjaLUg7j?=
 =?us-ascii?Q?7V4U3RRn1XgDspADQcxVMO2xLXXZerjq2LeEJPxc5GGXVk870VGx2gx6i8Vn?=
 =?us-ascii?Q?vEXGLhSA+tBNKgz09M94JuhWFBslPqvOMPVITLi9caYQWCXduEAqRUyO4KYk?=
 =?us-ascii?Q?mFAunfFnyU889avUH3cHA+ywKx6oNulHIigoDy2Y0dQg3XyCkJsyKjkBj130?=
 =?us-ascii?Q?Awa6JLxxtI/VbCBRvh6Fyxc9+DBz1ahl2UeBSQhZaEADntFnGFpz+z06gs9T?=
 =?us-ascii?Q?kPT2WxawX/8cfv2E+zkSSoQ9Q/XJmsxqpkmUx57n7kv6Zp3opKdmG7C3ucpe?=
 =?us-ascii?Q?X9+3ZOgib80kAcn2yg9YhTbQvuqPoPt+BT/rTe4pMl8SmG6DvbkuJ8pz3Oyt?=
 =?us-ascii?Q?QGzhrb6AC+YFGWwlb2snKxmRVycKqVyIa4O3fUIOFvJRHQUq5eQk6GGUvbVl?=
 =?us-ascii?Q?EQMYYQxjQfznr912a9zytrhv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ea37d5-6e37-4322-dd16-08d8d7a837af
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 03:07:56.3963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAE3CjcYEywFDzJ6sYmnhUYwz0dbpQUIXlC00XsXPXkiSjFB4w9G/JX9o8UlAlTbvlNTfyHxbgBcBINIhqAI9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4696
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

