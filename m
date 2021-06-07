Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABFD39D90E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhFGJue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:50:34 -0400
Received: from mail-vi1eur05on2062.outbound.protection.outlook.com ([40.107.21.62]:20832
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230291AbhFGJuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:50:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e24aY0c2SUSLvSzXHMRsgUW+DZgdHrlfTfYMERhPU65KUEdATnAEeu47908imJXg6yBgZMyEZ60tySTmKUFW+NBB0Jx2Irv86Rh2A1O7q3bfflma6+V2TZF0DeKnFBfEv7wWDv5CH4yUwHw8XhFkMz8HjQuF5aMd1eIJED/OCf6oq6Ckl0HQix2pYqhyEveLmC9LOoJf5QMCUF6U9oNJrZF0AuKoCjoIJSpTU1JbsxakwJ4lGUJuwOrH8RlyTM5gHdVuKzjAgMiIQlr1HY6aNhyrtMKt2aoe7rOoc4en3lLrJe3TuQPcWIHFKCwww7auecmX0DRDwA5XfUYpbYg5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8s8ghtUoAFmi2gYuKJf0mlYNsTkypDILieyuYZLLlE=;
 b=OkKJe9Odiwi1+msPRb8//DsX0Rh4GMpt6sEa4rrDzcDsgihXf1ctREU5vSKDOSmo0VyA7W4BWT4icwqeghlQ69mrIQ5t/A87WyWJO4d9F5e/7Mz+bjyKXLqJzdN5RuXKtOoZXZ2qwbm8m735raKEYdgEBPGt1st5Pkvstawoe+vLUOpGankSoTc9vb6Zbk5VF3kXrmGBvY1zLj86pXJ8u2KGoQcbBLlESH9pOEC5RN9iBceihupo4A6K5i//AW4VXPnJY/jZ+APc4ZiNxr82B8GjBYMNS/JdQq/vPH9EsFp3/gIP5osGBdA60fB4k9OXLkbzixLU8ihspqdKUyJCnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8s8ghtUoAFmi2gYuKJf0mlYNsTkypDILieyuYZLLlE=;
 b=IFPY5azTAR7IR2BL6qjb1nVqHentwbDSySLOcexhZXZeWVQXECGoKdA9l17OqP9w6tNOtciFy30uobw5xgxBvqxWeq5VFLiu9HkXh/H3zqkOjwyPj1s4Sx/FokX972KZdiB6pq4wkhx25piGJbBaCtp+ISv9p8hrmfVOTyEYrCk=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB5231.eurprd04.prod.outlook.com (2603:10a6:803:5a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 09:48:39 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::bcfe:215c:1b66:6011]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::bcfe:215c:1b66:6011%4]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 09:48:39 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     alice.guo@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, kernel@pengutronix.de,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: imx8mx: move soc device into ocotp
Date:   Tue,  8 Jun 2021 02:05:12 +0800
Message-Id: <1623089112-27069-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To VE1PR04MB6688.eurprd04.prod.outlook.com
 (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0093.apcprd02.prod.outlook.com (2603:1096:4:90::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 09:48:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd028db9-7d91-45ef-7253-08d929996d5c
X-MS-TrafficTypeDiagnostic: VI1PR04MB5231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5231F8ED38DA1454E5EB849089389@VI1PR04MB5231.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BvGdH1oaCdkB4K05fEX9CrBI6WddFV8kmQaf7fhDslWlcVAjbCIajfm+P0Un1ndx037J2Cbxwyg1eIKX5szH8j7ocpVo1rINP2WGCqWwO35h8WVxqq1y90PQbI17b/qRnMCqGJWCXJqvGUVIB1/tRdWIW1AooftCgxSjqfWgLwxInyyKZ2y5YDY6eBLuIG2vnlH4elY38KWIdDsZf5iWsIt1Gz/RnP2j1okK5YeNSoHzek+xI5wFrxW1eqdc453s1eOJXB0pTYUY4wJNNggO2f0Wm0URiJNnuS4uzX7wAPN3T1vnVcblrgFlBXAepfHZQykjIfUoT5mwjHu5W2lswxiEYga7WLMyeWjjbRcpsVoip0oyEpvdqw+6FyS2VVRIx8OPldDak2xGCH4kI9bQC2dJIlJGQKv91KnZ4SaH6oMCqwycx0VTWBBUxmAlVnslP8tzWfaHnLWeeuXlKTIq9k2EjfiHSks4noDri/ABm7QxvCNx/x/8yKXPrk4OJMW2sIthV/CXUSObWLrgEJHmcJA5a22HJV1+GaGiLdd00xkv0JIrDWeKVogN55dyWDm2Xo5xXtj3nj+fKwO1RvlqPrbmUOfiDsTsHhUa6HLyEmCXwf9Wv9XE+O7rkkcf76iSkpGSgrFbKwGf9efXrrFGhfZB8x40bwjlGw3cRNRXaVBLGGMYEUDyOv/DV+LWF/hw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(26005)(8676002)(16526019)(6512007)(6486002)(36756003)(38350700002)(38100700002)(5660300002)(478600001)(6666004)(2906002)(8936002)(6636002)(316002)(4326008)(66556008)(66946007)(86362001)(52116002)(83380400001)(956004)(2616005)(66476007)(6506007)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+qK5ZuVmEP5eVLPoSQ+NUApbcjjCOm8LOt/4ocghWzGF4NUJcCuD4J4GEBA5?=
 =?us-ascii?Q?hDj3vL3yAar4WPP+H2Dc9BJaWxpkNEs9mnakVsfFMl6d6F5b/hcHDHQA5Ots?=
 =?us-ascii?Q?B77hTpNlhCnzcZraaOzg7sbqAsZtu1AIsnThpVLG3FCU6PKqmVoKE5Nb50wz?=
 =?us-ascii?Q?Xyo4fNx+Bkt3Fh4PWDz7fd7oATb6GVmQGFF/0XNngUBUIadXXNgVmQIz4kN2?=
 =?us-ascii?Q?Vy+Wy0HCng+Wx3NqGkJ2jI6TMKGSM1q7jcZKlYBHYMPJ5YlBIzrZW1MzA9iH?=
 =?us-ascii?Q?h1W25bP/kxRFHgkiwztw+1k5Ad3bbbzv2cRHTbNppFw5ReN34bDTnzMFT8b/?=
 =?us-ascii?Q?m9+LIDzgmVLUuByVGKBvRY55VSK8qHRoWQjABKMqCUAUGgfd+/kxF+EMRkwL?=
 =?us-ascii?Q?hB+NxfPI9gIJlw3Vx+bHNESrO+kReVMXIY8q51sUBS+uoMpOEu/kgX1Js228?=
 =?us-ascii?Q?oOXrXop7aFSdNPwEeGyVCoT/LtjgN7TRHoPggt6d2qGJ/sHZJJjI7XGx1X0o?=
 =?us-ascii?Q?IJ2Uqr/dKj/dQLysl8aQaqC7WDNWaOyRgPs7Psjb4QkiDXsX0xCdWKdDORrh?=
 =?us-ascii?Q?c6cpooiSy+AD76c0ZDWcm17w0C+eF9yx5sv4AOHPSsWHfr/wFF6Ti7Z3TaEP?=
 =?us-ascii?Q?kDZ/uQI+PQI70gr1NCBt0ec0dWS1416ooE13l9RtsqGrraAW0UO6DCRIVMrm?=
 =?us-ascii?Q?4yl2rAgnJv2SfqP9XBhnfBcqSnV/esytEUv95HKS9ms7RfK6W3YaZi3RdQwf?=
 =?us-ascii?Q?0uN30sRhNcI4tg0VLXE0XGzDqO/Xxw3z/gpCo2TtaMozGc29p1UVKMKlgWGC?=
 =?us-ascii?Q?EabuKsvfSp9Yhb8u1kTxRqtbjQR+C4vhlZ+jrbjbbaEsEy8qdJvI9uXNUisO?=
 =?us-ascii?Q?a1mZQ1eEEwgeJVrKaMSg55XawYdOvFbwzaxthOLrHU47NBciFo2biL9PdNv5?=
 =?us-ascii?Q?06NP/GFoZPpww4Oe+cdyulRGtci91BI7yAWLfX09fbnd5SsKvPpLyVftyYgw?=
 =?us-ascii?Q?GSKR7vtlI4etW+lWVou63s4U7D4G5mBqa3BtW90c6UWhzeGRJ2mrsjNeSNx2?=
 =?us-ascii?Q?WhKbUBaICaQFO3BRmHJ/G2wsXCgj/YPv+9gfOHuap7mX71YQBg9d/aKByEKc?=
 =?us-ascii?Q?EvAgoSHbGUuGlezsY4B4y9IYaEBLUuFhWjvZNoYDRMRengymC+oqNlp4JHHc?=
 =?us-ascii?Q?qGC7p/XIEWzam3RktNskx8tIrmdPoMKu83i4gG9I8bsgubkwTmsnDnZscI+i?=
 =?us-ascii?Q?DUQaChxw1JdYOs266KPuSYcSFGxNCUTUyo19t9gSgOsCLJKJfHQmly7/dMGS?=
 =?us-ascii?Q?K7phHeYx+/wAPPxPXTBoHkaN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd028db9-7d91-45ef-7253-08d929996d5c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 09:48:39.4674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RoqkrXzntExs9T/q+K4ScpGg7SnhG+9FlxOYx6AHpCWtWGIXc3yoloKoMbVUPbVmQEwC76gfhp0g2JWQ4elIiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5231
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move soc device into ocotp device node instead of the parent device
of the all devices which located in 'soc@0', otherwise, all probed
children devices will be reorder to dmp_list again once 'imx8mx-soc'
device defered probed, which may break driver's suspend/resume sequence,
such as imx_spdif and fsl_spdif, hence the later would suspended before
the former as below and endless interrupt may never be handled since
clock has been disabled already in the later.

[    1.930598] calling  fsl_spdif_driver_init+0x0/0x20 @ 1
[    1.955712] initcall fsl_spdif_driver_init+0x0/0x20 returned 0 after 24512 usecs
[    1.981963] calling  imx_spdif_driver_init+0x0/0x20 @ 1
[    1.986600] initcall imx_spdif_driver_init+0x0/0x20 returned 0 after 4509 usecs
[    2.901408]   #0: imx-spdif
[   21.151529] fsl-spdif-dai 30090000.spdif: calling platform_pm_suspend+0x0/0x70 @ 470, parent: 30000000.bus
[   21.161189] fsl-spdif-dai 30090000.spdif: platform_pm_suspend+0x0/0x70 returned 0 after 0 usecs
[   21.474311] imx-spdif sound-spdif: calling platform_pm_suspend+0x0/0x70 @ 470, parent: platform
[   21.483024] imx-spdif sound-spdif: platform_pm_suspend+0x0/0x70 returned 0 after 9 usecs

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 12 ++++++++----
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 13 +++++++++----
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 13 +++++++++----
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 12 ++++++++----
 4 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index e7648c3..9ef0554 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -257,13 +257,11 @@
 	};
 
 	soc@0 {
-		compatible = "fsl,imx8mm-soc", "simple-bus";
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
 		dma-ranges = <0x40000000 0x0 0x40000000 0xc0000000>;
-		nvmem-cells = <&imx8mm_uid>;
-		nvmem-cell-names = "soc_unique_id";
 
 		aips1: bus@30000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
@@ -522,7 +520,7 @@
 			};
 
 			ocotp: efuse@30350000 {
-				compatible = "fsl,imx8mm-ocotp", "syscon";
+				compatible = "fsl,imx8mm-ocotp", "syscon", "simple-mfd";
 				reg = <0x30350000 0x10000>;
 				clocks = <&clk IMX8MM_CLK_OCOTP_ROOT>;
 				/* For nvmem subnodes */
@@ -540,6 +538,12 @@
 				fec_mac_address: mac-address@90 {
 					reg = <0x90 6>;
 				};
+
+				imx8mm_soc: imx8mm-soc {
+					compatible = "fsl,imx8mm-soc";
+					nvmem-cells = <&imx8mm_uid>;
+					nvmem-cell-names = "soc_unique_id";
+				};
 			};
 
 			anatop: anatop@30360000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index d4231e0..f82905c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -241,13 +241,11 @@
 	};
 
 	soc@0 {
-		compatible = "fsl,imx8mn-soc", "simple-bus";
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
 		dma-ranges = <0x40000000 0x0 0x40000000 0xc0000000>;
-		nvmem-cells = <&imx8mn_uid>;
-		nvmem-cell-names = "soc_unique_id";
 
 		aips1: bus@30000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
@@ -528,7 +526,8 @@
 			};
 
 			ocotp: efuse@30350000 {
-				compatible = "fsl,imx8mn-ocotp", "fsl,imx8mm-ocotp", "syscon";
+				compatible = "fsl,imx8mn-ocotp", "fsl,imx8mm-ocotp", "syscon",
+						"simple-mfd";
 				reg = <0x30350000 0x10000>;
 				clocks = <&clk IMX8MN_CLK_OCOTP_ROOT>;
 				#address-cells = <1>;
@@ -545,6 +544,12 @@
 				fec_mac_address: mac-address@90 {
 					reg = <0x90 6>;
 				};
+
+				imx8mn_soc: imx8mn-soc {
+					compatible = "fsl,imx8mn-soc";
+					nvmem-cells = <&imx8mn_uid>;
+					nvmem-cell-names = "soc_unique_id";
+				};
 			};
 
 			anatop: anatop@30360000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9f7c7f5..d113691 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -220,12 +220,10 @@
 	};
 
 	soc@0 {
-		compatible = "fsl,imx8mp-soc", "simple-bus";
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
-		nvmem-cells = <&imx8mp_uid>;
-		nvmem-cell-names = "soc_unique_id";
 
 		aips1: bus@30000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
@@ -341,7 +339,8 @@
 			};
 
 			ocotp: efuse@30350000 {
-				compatible = "fsl,imx8mp-ocotp", "fsl,imx8mm-ocotp", "syscon";
+				compatible = "fsl,imx8mp-ocotp", "fsl,imx8mm-ocotp", "syscon",
+						"simple-mfd";
 				reg = <0x30350000 0x10000>;
 				clocks = <&clk IMX8MP_CLK_OCOTP_ROOT>;
 				/* For nvmem subnodes */
@@ -359,6 +358,12 @@
 				eth_mac1: mac-address@90 {
 					reg = <0x90 6>;
 				};
+
+				imx8mp_soc: imx8mp-soc {
+					compatible = "fsl,imx8mp-soc";
+					nvmem-cells = <&imx8mp_uid>;
+					nvmem-cell-names = "soc_unique_id";
+				};
 			};
 
 			anatop: anatop@30360000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 91df9c5..8cfbc77 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -287,13 +287,11 @@
 	};
 
 	soc@0 {
-		compatible = "fsl,imx8mq-soc", "simple-bus";
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
 		dma-ranges = <0x40000000 0x0 0x40000000 0xc0000000>;
-		nvmem-cells = <&imx8mq_uid>;
-		nvmem-cell-names = "soc_unique_id";
 
 		bus@30000000 { /* AIPS1 */
 			compatible = "fsl,aips-bus", "simple-bus";
@@ -554,7 +552,7 @@
 			};
 
 			ocotp: efuse@30350000 {
-				compatible = "fsl,imx8mq-ocotp", "syscon";
+				compatible = "fsl,imx8mq-ocotp", "syscon", "simple-mfd";
 				reg = <0x30350000 0x10000>;
 				clocks = <&clk IMX8MQ_CLK_OCOTP_ROOT>;
 				#address-cells = <1>;
@@ -571,6 +569,12 @@
 				fec_mac_address: mac-address@90 {
 					reg = <0x90 6>;
 				};
+
+				imx8mq_soc: imx8mq-soc {
+					compatible = "fsl,imx8mq-soc";
+					nvmem-cells = <&imx8mq_uid>;
+					nvmem-cell-names = "soc_unique_id";
+				};
 			};
 
 			anatop: syscon@30360000 {
-- 
2.7.4

