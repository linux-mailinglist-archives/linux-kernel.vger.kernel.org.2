Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336A83F1439
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 09:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbhHSHPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 03:15:50 -0400
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:2630
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235859AbhHSHPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 03:15:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEehg5Vrea4fMB0PXLQBlqU9LPCnzrvIkGUrIeJ35MXteXGFl0svjZ8D+XTknSZNjX0W+3Nto9XbRSSuTB/pto6mni3sUCJVeN8VzQ0tCHaXrBtkpLfIfOquhodezZkVqPNzKk6QnJFotu9kK/lVhi5VQPlYdVl2G5tWhg/3NhmkO2QPAsqJbVrwHhIMv/ce8c5CZQDXGiyVcbvHBEg/Xn5qdtFUTFNj4YRSGzIgKrd5zdbaOqSKnxW3s63Lq6Bt4PzuqX6dEfEyec82U2ehyoELBa/oEfWQC9XERg2vOwb7WbUYWlM+YCdqcrY3VagjoiORpC3J+mB15UWC9oJ4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjfKyTe2dL21I/SQPi6y5VWifBC//4auoZApzsOugv8=;
 b=UsofQqeWWReKiN5eqRR7amvxUrKsQUQy5xJTz3AZ5RC+q9ICYJ6Sdppwj2eZrgoM5dlb3e617NixItNaJ5cNl5ClPAos70ZefWduI9ohR1bgywicpnRjO/yfFv5AIi/ojBrr4owp8yAwDL6RfX3p24OFZaFCYU4KvBkyxhPorZMmJZr/gDJhefzJrDyxm9CJpsZ/OPqk4lovP8QW0Dkkl7TYs94RCOPnmPUY0JSKiywgIx32+GMuF3nSF2uVFsSziZbTWXhpZfyiHq47j5ArcMGoY/pAHAFyLbHWBS2LCfMNeVhwpd9sNoz2kzxOGZK68dgem2eg73w22H30e5aMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjfKyTe2dL21I/SQPi6y5VWifBC//4auoZApzsOugv8=;
 b=LNd3cf+q0IclY+WHak/YqrSIlxDkwOAjjm3e3GHUyTv9VqpO+THZOEeDFrZ7ekbkk24mcMGGh0Z0T8p+TWB6BUDH5OuKrsymEkcdCns8jlLBPJpMuDKoQ2vViEBmyrF12c62X2kOUhaEChEayuF4l7Hw9ArHydnCWXkZh8wVNio=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR0401MB2304.eurprd04.prod.outlook.com (2603:10a6:800:29::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Thu, 19 Aug
 2021 07:15:07 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::d010:8002:44b8:117b]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::d010:8002:44b8:117b%7]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 07:15:07 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     robh@kernel.org, l.stach@pengutronix.de, galak@kernel.crashing.org,
        shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 2/3] arm: dts: imx: fix the schema check errors
Date:   Thu, 19 Aug 2021 15:14:07 +0800
Message-Id: <20210819071408.3856475-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210819071408.3856475-1-hongxing.zhu@nxp.com>
References: <20210819071408.3856475-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0105.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::31) To VI1PR04MB5853.eurprd04.prod.outlook.com
 (2603:10a6:803:e3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0105.apcprd01.prod.exchangelabs.com (2603:1096:3:15::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 07:15:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8039a54-8a47-49b0-b23e-08d962e112e2
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB23043637C22041BDD077A7D28CC09@VI1PR0401MB2304.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ga990pvDXiCOXoSAfFQKjVlk3Xq+OmuP9ZI+CtpUmbtummaar9BEWMdgG3BORwbmz74Ei4c7wZPigcYKJZohTd9usc1/6UlpeJ1eN1KWPxuBEpwTapHRLFXDCkYQqysZeUQxUezlWmnYVKd4Aul1B6ZaBIj959Gp/AGHGRyOZ+yOOM0HY9/HLHMYnxyBd0DS0iobWaHi+cu4nBjR+hh7YkRaIp1T933h/hblJ1xOuaH2RyXWqzw4QgCaO9+ZVgHWyB0vBk9mgjsFyB3SVG+RfJRMhVhCvz1jM4WzEOfTn1+pvLDcQ8pBr5F4qy/i+DBaNXodD43f89F5y0PRcrc00Be5Asvup0focRRupj8DFH9IbkIR+H2IBhB2cNhmgcIBENSsb2sqIYAoA4ZzqQX2T2bosc/cwK0pJtvRfYSrH6ARrJsErWdBQq8c0cclaobe8mgtW6LgRha2YkVmFrIKJmQ1pHl9gy6MJ1e5g1E4BXkoZkQIY3+AlASxV/CUdth2MatgwSRPzurxKWQpGUFzMQCMGy1wkvOpQFBdzXy1nrMUmFa1wnKSE01kNS+cnH9FG3I8nv0f2XZFJR7B/MRlJm1RaU20hzzVNuvyvXXRawToWC8Ul3FPyhpfezCCbwZUIvFfRXYo+XDcBVtJJcSFRC7qqcaWN7InTVdRlo97EEKUT8IlQ3GAkAGD2P0z4mSUX//7ZEVqeBiDQqjgOqPFtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(6512007)(86362001)(66946007)(66476007)(6486002)(5660300002)(1076003)(66556008)(36756003)(956004)(186003)(26005)(6506007)(38100700002)(38350700002)(316002)(83380400001)(478600001)(52116002)(8676002)(4326008)(2616005)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cGf7Z5IbFeWJKNBiDqNjRmXYPIg/lGZL/CDGvvkM/RpJKCqFgo68zh6WCkye?=
 =?us-ascii?Q?B8aALKbGUnlOqkadA8QRycLD77gkfeEJ719wruGeMDYzT8lg3W+D3472G+dU?=
 =?us-ascii?Q?mW1M7+kfsUOJoncT90wL8ICUYMd0FAzoMafcoPo9w71i3VPzHxmhl5il41Jt?=
 =?us-ascii?Q?76Fht3ZYa5P/Q3XNYR80OI0ts/ofohsSeteCCcZWBT0H3rr0v4FAVHOYeKHW?=
 =?us-ascii?Q?iICAvLXFEpZG3EI3f5qNtLUd9QZ2vk69nVNKDdLesnIiDAQ9JDmJSthvBJmr?=
 =?us-ascii?Q?j3AbgrMH8haWBJywxdpNQ1NgC172gDBLhLKtFPiZyNHxj5wYRDerYjDEp98t?=
 =?us-ascii?Q?ZgCfGBbUocbpYpki4ftl7zaztHDAuItjk827SenO5FlFlugs6zfdLLoyIMA1?=
 =?us-ascii?Q?+hOYAuAGdfIkVY+Wy5RayhLodZ8DzKMw7uksibtd+YbeBhIEmcdOvAMQR5R8?=
 =?us-ascii?Q?67FfEeyMepitYPOqvqilhz3fKeVKJ4u6oPCI7QYFnj+7/DHBwfy0BtHd2oVN?=
 =?us-ascii?Q?SF/cH4/RJ6gTWRBqil+PM86LbjG0fr0ouhobzWLwiS7WvAFW11DcpuZSQlUP?=
 =?us-ascii?Q?BOMsSUqkcoM9O9M8lyKGG75gY/4yQsLwpEoxKsxR58xQnWiU2i9YPgwxcK1Q?=
 =?us-ascii?Q?8NGpgDbUoiTJA1WigKMQV34Gyowh4RiYRM45NPFbWv2npP+eRqYSQt7tUWG9?=
 =?us-ascii?Q?O2KeHdwSd1bgQ17o5ztDh6VgZszUJU283u68QJ2gQ+Q9PcNj0uRfSjDw29TM?=
 =?us-ascii?Q?c/dd0oHHcjyvNbyaBtfKa5lEgwz4F+H6NJvXs0J/xLQNCCrlXj2UPYYc3l0A?=
 =?us-ascii?Q?DiRbJhgoWhBdpivkIjBXUKGxbGPJ3EmpCVAKyuGKf6GojPDa0oaV+VfZlQ0d?=
 =?us-ascii?Q?n3YnDxkYLeBXL5waKNQzS9rWJ+JpQaY0odyFaWXAdiEZjg0Eadz1O4sLOVIW?=
 =?us-ascii?Q?QIx3qLPbqkg3kS7M5sF9IFTbdJEcXKfkEtN6X5hdWmeRLcinGVklDyO62Sx+?=
 =?us-ascii?Q?ngkNJCpkgnUi4ScJLeNcIb3kKFjg0OgCXaaVkwR3y//X3F75s0t+yyM10XkL?=
 =?us-ascii?Q?Jccl2CwX6EvWkFUtm2t9VSfhFz7bowQ1iZBiRMR8PEuTtVY4hrpZPj5h6tSw?=
 =?us-ascii?Q?5U3kEYyaybkXbXeViz4UVIDxqBJ2bbopKSjl8RS2ywau3lQhVpIqyy7cBmUw?=
 =?us-ascii?Q?fTdggLwVVAdUtqSRhmgsSbesoZJa2gZdXk5eVY6cqGwLfjFSoi/Esvis+8xH?=
 =?us-ascii?Q?4D8vIi+/TmeDMUgeuSA/nhDYaXS2thOHcJXm66ZzQXmwPatipAxpYG7IKHyc?=
 =?us-ascii?Q?tIiNhjUskFRuJqJkg8AyoUXE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8039a54-8a47-49b0-b23e-08d962e112e2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 07:15:07.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oTJI87ErA7KcoKepATjdpXSL7dl53jm/m+85KZ47czqmhMbszQk6fhbgbryj6DKqbqE2TOOaba+YSfomtmeSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2304
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- the ranges should be aligned to $ref: /schemas/pci/pci-bus.yaml#
- num-viewport is required, add it in imx6sx.dtsi.
- only one propert is allowed in the compatible string, remove
  "snps,dw-pcie".

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 6 +++---
 arch/arm/boot/dts/imx6qp.dtsi  | 2 +-
 arch/arm/boot/dts/imx6sx.dtsi  | 7 ++++---
 arch/arm/boot/dts/imx7d.dtsi   | 6 +++---
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 82e01ce026ea..cb43c72806a1 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -264,7 +264,7 @@ L2: cache-controller@a02000 {
 		};
 
 		pcie: pcie@1ffc000 {
-			compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
+			compatible = "fsl,imx6q-pcie";
 			reg = <0x01ffc000 0x04000>,
 			      <0x01f00000 0x80000>;
 			reg-names = "dbi", "config";
@@ -272,8 +272,8 @@ pcie: pcie@1ffc000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			bus-range = <0x00 0xff>;
-			ranges = <0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
-				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0 0          0x01f80000 0 0x00010000>, /* downstream I/O */
+				 <0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
 			num-viewport = <4>;
 			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
index b310f13a53f2..050365513836 100644
--- a/arch/arm/boot/dts/imx6qp.dtsi
+++ b/arch/arm/boot/dts/imx6qp.dtsi
@@ -110,5 +110,5 @@ &mmdc0 {
 };
 
 &pcie {
-	compatible = "fsl,imx6qp-pcie", "snps,dw-pcie";
+	compatible = "fsl,imx6qp-pcie";
 };
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 8516730778df..0324f9e17389 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -1395,16 +1395,17 @@ pwm8: pwm@22b0000 {
 		};
 
 		pcie: pcie@8ffc000 {
-			compatible = "fsl,imx6sx-pcie", "snps,dw-pcie";
+			compatible = "fsl,imx6sx-pcie";
 			reg = <0x08ffc000 0x04000>, <0x08f00000 0x80000>;
 			reg-names = "dbi", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
 			bus-range = <0x00 0xff>;
-			ranges = <0x81000000 0 0          0x08f80000 0 0x00010000 /* downstream I/O */
-				  0x82000000 0 0x08000000 0x08000000 0 0x00f00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0 0          0x08f80000 0 0x00010000>, /* downstream I/O */
+				 <0x82000000 0 0x08000000 0x08000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
+			num-viewport = <4>;
 			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index b0bcfa9094a3..0cb8c8df87ef 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -164,7 +164,7 @@ fec2: ethernet@30bf0000 {
 	};
 
 	pcie: pcie@33800000 {
-		compatible = "fsl,imx7d-pcie", "snps,dw-pcie";
+		compatible = "fsl,imx7d-pcie";
 		reg = <0x33800000 0x4000>,
 		      <0x4ff00000 0x80000>;
 		reg-names = "dbi", "config";
@@ -172,8 +172,8 @@ pcie: pcie@33800000 {
 		#size-cells = <2>;
 		device_type = "pci";
 		bus-range = <0x00 0xff>;
-		ranges = <0x81000000 0 0          0x4ff80000 0 0x00010000   /* downstream I/O */
-			  0x82000000 0 0x40000000 0x40000000 0 0x0ff00000>; /* non-prefetchable memory */
+		ranges = <0x81000000 0 0          0x4ff80000 0 0x00010000>, /* downstream I/O */
+			 <0x82000000 0 0x40000000 0x40000000 0 0x0ff00000>; /* non-prefetchable memory */
 		num-lanes = <1>;
 		num-viewport = <4>;
 		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

