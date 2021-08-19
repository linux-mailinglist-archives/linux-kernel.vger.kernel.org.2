Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A9A3F1436
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 09:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhHSHPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 03:15:44 -0400
Received: from mail-am6eur05on2080.outbound.protection.outlook.com ([40.107.22.80]:58753
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229909AbhHSHPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 03:15:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECbmWRVSE+E7eYZLFWta/7cFXnm6JghaIWDcm8yG5pWNPY0B0g2EHUpTpb5iA9Cv54jJmVbfznk70FCsLk4rJZ1+jdg3ce6ZefkpAVwwc3i6UmIGl+MPulVY2IPcXUkeDRgHcJZTXyDSTSVQ230usyg89crMnuCzIzl4IfCNbbOaqT2kW7sBZ0AefbowSHaODfMrcah1ILNzxfqdxnkwDIFaiuoygmvI3UH4A3DSc4IiEbZzazt+fLEr7OGpFVbCZVUDLhESP5XAUsrv/hfLpmA7OVC2qbx6Xjf+AQqhJpDSVeEdJXHi3Gz7cgKKCm7zhCABM+D3HKiwbmYNRIln0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fI6CYmdm7MjxN3m5zMC6h75249eIUGa2WMZcBabKh3g=;
 b=MNMwJAgJ6DfQ2A+8UcT69ZFk4c/URajPoYO54Tu5Rj3oJ+fPNYTF0DkxD7CTKjlgcf3to8F9FO4fOQL75y4Jiw/Fsj0jFME0TnpnykgIWUJmJasgUFS70bXdCSGvDczFTciIEGlBflKbSZxX1yOs2ZqOSjDIjV5JfrwMjZMrf51VblfRyqAo9DrEvJRN2zlmFZk7bBG8r2cs1LPBMvpiaS0nolfZFcZOyKf3BMcOmfbUoDgVKzp/qAUWOuEDjiLFhwqMwQ18TEvDKXTskRBF0YrmqhFmtlP7ztQUlMNgs+0QbNLqklV0j5k31ZnGK6snWS6dPVh+00QgCgy5xxXJFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fI6CYmdm7MjxN3m5zMC6h75249eIUGa2WMZcBabKh3g=;
 b=oOZGKbEzAAzr4HPMHn+B2Qbn31kGm0cEAiR8B+iVQZNLGni8zrn3G4LDGerIgWOBjZAoVkkCa2U1YYsnmqGJcHHOOn4N5iAABT/Xnv8UKw3TZXprWSAtKFLsMFLcUEugJCZRNEjPH3Mf2dUh/LJh/7w/6VKdqcyPOqGO0HFwmi8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR0401MB2512.eurprd04.prod.outlook.com (2603:10a6:800:4e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 07:15:04 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::d010:8002:44b8:117b]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::d010:8002:44b8:117b%7]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 07:15:04 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     robh@kernel.org, l.stach@pengutronix.de, galak@kernel.crashing.org,
        shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 1/3] dt-bindings: PCI: imx6: convert the imx pcie controller to dtschema
Date:   Thu, 19 Aug 2021 15:14:06 +0800
Message-Id: <20210819071408.3856475-2-hongxing.zhu@nxp.com>
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
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0105.apcprd01.prod.exchangelabs.com (2603:1096:3:15::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 07:15:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b45ec1f7-9814-4aa0-49e7-08d962e110be
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB25127D3C53742BABB923F6648CC09@VI1PR0401MB2512.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hefp2oAqJ1MsvUVW15ZP/yVVTxTuszVUw94dOPHOj4CMZKL2BlAbASnacr6GDcuCWOGSv0bUWkLC4QR8xGTQcM33twpUFxQmBhHAICqLsiEXCfaz5fsC0+TaB6IEehlmz6BYV+1DjmHjEFl+pn8po2zsNbZ2CGCDcUpzejeevxHLJpLErrmPQiXn9IijlirCcjwNbyTydP5923dIzLH0p1c4zHJqhLuVZiHZmNdwaDwRZbOhbjenOBe1YvF64TWRMdkPKJXM7OvEM34Jt2pIAszYYfIoRSKOu5Vzc9/1PASDaK+bl4gWREWNygRKZHPlYNDeSA4m7avvQDagHZPqjQe5M4x18YLmPTngrXfH8eCvy6q2cMGrFM0fy9L04dWsFwxiYfvLYZ3N2ali6wVO28by+rVK2BHvCr2EFKaeB0teUJvWT/1nBzpTKLGDzpW1yReKLC/zXWCumyGa4mlko2zUbN8ZtfvxRczZvt201xpSSWsmK5pk/ILFlqmEIzzeSESDlRKXLcHZJ1qlSp7Ot4x1xruPFKuI0J113g/RiXE4eCDvx8B50KEZzpncuvewbUIz8qGMLW5brrgWd2+WCZeF2ek7/hJ02ZYymeBNI8qvb4bhTadudmSdFr73iJydSvjZh0xwVs+WWyeYiwKxwGrN77TShI9J4uH5amvTFyVmkLihGqbdAVerzIACPr9xx0FOYDEddc7hxocvsSwB0KAkSMneSB8PHlVYwUv8PVu4fbNRQKhTO5gjuBm9LkFQpJ3F2HHO6D4XMEIMKQDp1SPiPEBt4Tb+gF0iuqPr0yMipJ76/S1L0AjPt4dMEeD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(6512007)(316002)(38100700002)(1076003)(38350700002)(508600001)(2906002)(966005)(30864003)(66556008)(83380400001)(8676002)(6506007)(6486002)(66476007)(52116002)(66946007)(186003)(2616005)(956004)(4326008)(26005)(8936002)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GXTenFEATNVoH6wAlSK6+MHev7grwajCjVxROsxUD+g4MuR2ZKwL+rAghltP?=
 =?us-ascii?Q?UE90X5RUO6T7RRog0YwKzZhNv/rg8Bp2DQrshCI2P6fUyy5xOaMaLBs3QDpn?=
 =?us-ascii?Q?i2ZVhfnoHNfC/Iy036rGLXF+74mRwtNGejB6FogJroIWk8hXpTwrnu8DnPKA?=
 =?us-ascii?Q?KA7+lKskIMY/W7q7GqzDkaam5BklwhzUW8HqfMFQAaDFJPfgnR3cpJDRGVF1?=
 =?us-ascii?Q?CkXtMXTggk4kG0XM0H2a6aOQFC/DRdLe5Xcde6QKuAc6dz2ZQd9qZsuAlaKh?=
 =?us-ascii?Q?kR+PjJTrvIy3nXZqExJ8Nm5KiHY5NSLNdVCI1KXUO9vSoEjpwkJqITUfXUEQ?=
 =?us-ascii?Q?sI+RqAMbrpr0kPrbNXeudJq6z85zm2kSWxhaIO8H1oJorbz4Tu7Nh/X+0B5a?=
 =?us-ascii?Q?EPPIk3C0EVpfLjRTQdCb1unBKd685IbPWFPn0oSHw14mh63Xw1/z8iSloCyn?=
 =?us-ascii?Q?ekjuRC+62R+v9Ts4gIcfHx1mTRjuN1OmJuFFLViCMJRQYUzLSswrYoX2aNJ+?=
 =?us-ascii?Q?Ig/u/vsqdIRAQOHuR+1yvCGIPA9tcOh8bDHfBruz33sID9rnsQpaRRjXd46v?=
 =?us-ascii?Q?OJTbOAAUBrkqTtDcfh2ZAZNjPAvQ44qM8jI0yw9/CsX6JlF8jgw+p48fW2+a?=
 =?us-ascii?Q?r4G6DYtxVzIAqAngob2oVniFPzqc38aFVpkbl4/UJ6pVPNhngZDTSRVEP7jW?=
 =?us-ascii?Q?wKH/buWVNaT1O5dOPjvNFnEQCibYj/WHuRInE+7j4JqXx8Hku8rcIkDg2CN4?=
 =?us-ascii?Q?oKhYgSxb0o0cib2N35/RCXsYqGoyGqOkM3tUHSlzqPKNX0P6fnuoUzLSwTiw?=
 =?us-ascii?Q?kxMgkLjgL7J3YwjPe1WU20RyZSbHps7ygH0c4zLgWPVk4Btf6+j9k38SsxYq?=
 =?us-ascii?Q?Xwv1l7POSslAkkcFs/a7E1YawoZmjS9c+XJmi84Kk4k7W1EWmjhQ7kMOkuY4?=
 =?us-ascii?Q?G1QhiJ7RzQY+eStns2Tj0YlJvWtx20FHyclcuJuAfeYLUiOSc0DQLE8U7bP8?=
 =?us-ascii?Q?GH31ZXtRvt/uY9j1DmS+MdSFRo4Yg8edlDJErvMJYytkf6fuIQLhrB/pz70Q?=
 =?us-ascii?Q?mI2jDewQAq1EHbc9Hji/fJGsSQXWOi0WmIKVAdwJ8mV019rn/QQmbee8AIiq?=
 =?us-ascii?Q?IzD3Up85bqK142Lccvsf3/FrvJLwa4ke/CB7upEVKQXvucixbBzar+xLg5Mn?=
 =?us-ascii?Q?vNQHOXNO+7Z0QiD8ZOwMxq8u1lbEERdcG24H01ShUAE2noK8MXWWke4PTeK2?=
 =?us-ascii?Q?bnMmqn+9YtDbjeOE0/+tedZPVcwRBpgmWkQOk8D08mxLudBdH3sSXUiMp3mG?=
 =?us-ascii?Q?X2xin5s5Mt2MbBOj29vxZqJU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45ec1f7-9814-4aa0-49e7-08d962e110be
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 07:15:04.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HR2KVCQtnSh2w8Kyh955/pf921NFPJhJ22FOVqehfb9YvNvK039x33ueHzvBNSL3GHf3YfJCkvih6L59zK1txw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2512
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the fsl,imx6q-pcie.txt into a schema.
- the ranges should be aligned to $ref: /schemas/pci/pci-bus.yaml#
- only one propert is allowed in the compatible string, remove
  "snps,dw-pcie".

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../bindings/pci/fsl,imx6q-pcie.txt           | 100 ---------
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 207 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 208 insertions(+), 101 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
deleted file mode 100644
index d8971ab99274..000000000000
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ /dev/null
@@ -1,100 +0,0 @@
-* Freescale i.MX6 PCIe interface
-
-This PCIe host controller is based on the Synopsys DesignWare PCIe IP
-and thus inherits all the common properties defined in designware-pcie.txt.
-
-Required properties:
-- compatible:
-	- "fsl,imx6q-pcie"
-	- "fsl,imx6sx-pcie",
-	- "fsl,imx6qp-pcie"
-	- "fsl,imx7d-pcie"
-	- "fsl,imx8mq-pcie"
-- reg: base address and length of the PCIe controller
-- interrupts: A list of interrupt outputs of the controller. Must contain an
-  entry for each entry in the interrupt-names property.
-- interrupt-names: Must include the following entries:
-	- "msi": The interrupt that is asserted when an MSI is received
-- clock-names: Must include the following additional entries:
-	- "pcie_phy"
-
-Optional properties:
-- fsl,tx-deemph-gen1: Gen1 De-emphasis value. Default: 0
-- fsl,tx-deemph-gen2-3p5db: Gen2 (3.5db) De-emphasis value. Default: 0
-- fsl,tx-deemph-gen2-6db: Gen2 (6db) De-emphasis value. Default: 20
-- fsl,tx-swing-full: Gen2 TX SWING FULL value. Default: 127
-- fsl,tx-swing-low: TX launch amplitude swing_low value. Default: 127
-- fsl,max-link-speed: Specify PCI gen for link capability. Must be '2' for
-  gen2, otherwise will default to gen1. Note that the IMX6 LVDS clock outputs
-  do not meet gen2 jitter requirements and thus for gen2 capability a gen2
-  compliant clock generator should be used and configured.
-- reset-gpio: Should specify the GPIO for controlling the PCI bus device reset
-  signal. It's not polarity aware and defaults to active-low reset sequence
-  (L=reset state, H=operation state).
-- reset-gpio-active-high: If present then the reset sequence using the GPIO
-  specified in the "reset-gpio" property is reversed (H=reset state,
-  L=operation state).
-- vpcie-supply: Should specify the regulator in charge of PCIe port power.
-  The regulator will be enabled when initializing the PCIe host and
-  disabled either as part of the init process or when shutting down the
-  host.
-- vph-supply: Should specify the regulator in charge of VPH one of the three
-  PCIe PHY powers. This regulator can be supplied by both 1.8v and 3.3v voltage
-  supplies.
-
-Additional required properties for imx6sx-pcie:
-- clock names: Must include the following additional entries:
-	- "pcie_inbound_axi"
-- power-domains: Must be set to phandles pointing to the DISPLAY and
-  PCIE_PHY power domains
-- power-domain-names: Must be "pcie", "pcie_phy"
-
-Additional required properties for imx7d-pcie and imx8mq-pcie:
-- power-domains: Must be set to a phandle pointing to PCIE_PHY power domain
-- resets: Must contain phandles to PCIe-related reset lines exposed by SRC
-  IP block
-- reset-names: Must contain the following entries:
-	       - "pciephy"
-	       - "apps"
-	       - "turnoff"
-- fsl,imx7d-pcie-phy: A phandle to an fsl,imx7d-pcie-phy node.
-
-Additional required properties for imx8mq-pcie:
-- clock-names: Must include the following additional entries:
-	- "pcie_aux"
-
-Example:
-
-	pcie@01000000 {
-		compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
-		reg = <0x01ffc000 0x04000>,
-		      <0x01f00000 0x80000>;
-		reg-names = "dbi", "config";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		ranges = <0x00000800 0 0x01f00000 0x01f00000 0 0x00080000
-			  0x81000000 0 0          0x01f80000 0 0x00010000
-			  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>;
-		num-lanes = <1>;
-		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "msi";
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0x7>;
-		interrupt-map = <0 0 0 1 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
-		                <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
-		                <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
-		                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clks 144>, <&clks 206>, <&clks 189>;
-		clock-names = "pcie", "pcie_bus", "pcie_phy";
-	};
-
-* Freescale i.MX7d PCIe PHY
-
-This is the PHY associated with the IMX7d PCIe controller.  It's used by the
-PCI-e controller via the fsl,imx7d-pcie-phy phandle.
-
-Required properties:
-- compatible:
-	- "fsl,imx7d-pcie-phy"
-- reg: base address and length of the PCIe PHY controller
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
new file mode 100644
index 000000000000..3503ce3de05d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -0,0 +1,207 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX6 PCIe host controller
+
+maintainers:
+  - Lucas Stach <l.stach@pengutronix.de>
+  - Richard Zhu <hongxing.zhu@nxp.com>
+
+description: |+
+  This PCIe host controller is based on the Synopsys DesignWare PCIe IP
+  and thus inherits all the common properties defined in snps,dw-pcie.yaml.
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx6q-pcie
+      - fsl,imx6sx-pcie
+      - fsl,imx6qp-pcie
+      - fsl,imx7d-pcie
+      - fsl,imx8mq-pcie
+
+  reg:
+    items:
+      - description: Data Bus Interface (DBI) registers.
+      - description: PCIe configuration space region.
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: config
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: builtin MSI controller.
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: msi
+
+  clocks:
+    minItems: 3
+    maxItems: 4
+    items:
+      - description: PCIe bridge clock.
+      - description: PCIe bus clock.
+      - description: PCIe PHY clock.
+      - description: Additional required clock entry for imx6sx-pcie,
+          imx8mq-pcie.
+
+  clock-names:
+    minItems: 3
+    maxItems: 4
+    items:
+      - const: pcie
+      - const: pcie_bus
+      - const: pcie_phy
+      - const: pcie_inbound_axi for imx6sx-pcie, pcie_aux for imx8mq-pcie
+
+  num-lanes:
+    const: 1
+
+  num-viewport:
+    const: 4
+
+  fsl,imx7d-pcie-phy:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: A phandle to an fsl,imx7d-pcie-phy node. Additional
+      required properties for imx7d-pcie and imx8mq-pcie.
+
+  power-domains:
+    maxItems: 2
+    description: The first phandle pointing to the DISPLAY domain for
+      imx6sx-pcie, to PCIE_PHY power domain for imx7d-pcie and imx8mq-pcie.
+      The second phandle pointing to the PCIE_PHY power domains for imx6sx-pcie.
+
+  power-domain-names:
+    maxItems: 2
+
+  resets:
+    maxItems: 3
+    description: Phandles to PCIe-related reset lines exposed by SRC
+      IP block. Additional required by imx7d-pcie and imx8mq-pcie.
+
+  reset-names:
+    items:
+      - const: pciephy
+      - const: apps
+      - const: turnoff
+
+  fsl,tx-deemph-gen1:
+    description: Gen1 De-emphasis value (optional required).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+
+  fsl,tx-deemph-gen2-3p5db:
+    description: Gen2 (3.5db) De-emphasis value (optional required).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+
+  fsl,tx-deemph-gen2-6db:
+    description: Gen2 (6db) De-emphasis value (optional required).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 20
+
+  fsl,tx-swing-full:
+    description: Gen2 TX SWING FULL value (optional required).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 127
+
+  fsl,tx-swing-low:
+    description: TX launch amplitude swing_low value (optional required).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 127
+
+  fsl,max-link-speed:
+    description: Specify PCI Gen for link capability (optional required).
+      Note that the IMX6 LVDS clock outputs do not meet gen2 jitter
+      requirements and thus for gen2 capability a gen2 compliant clock
+      generator should be used and configured.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 3, 4]
+    default: 1
+
+  reset-gpio:
+    description: Should specify the GPIO for controlling the PCI bus device
+      reset signal. It's not polarity aware and defaults to active-low reset
+      sequence (L=reset state, H=operation state) (optional required).
+
+  reset-gpio-active-high:
+    description: If present then the reset sequence using the GPIO
+      specified in the "reset-gpio" property is reversed (H=reset state,
+      L=operation state) (optional required).
+
+  vpcie-supply:
+    description: Should specify the regulator in charge of PCIe port power.
+      The regulator will be enabled when initializing the PCIe host and
+      disabled either as part of the init process or when shutting down
+      the host (optional required).
+
+  vph-supply:
+    description: Should specify the regulator in charge of VPH one of
+      the three PCIe PHY powers. This regulator can be supplied by both
+      1.8v and 3.3v voltage supplies (optional required).
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#address-cells"
+  - "#size-cells"
+  - device_type
+  - bus-range
+  - ranges
+  - num-lanes
+  - num-viewport
+  - interrupts
+  - interrupt-names
+  - "#interrupt-cells"
+  - interrupt-map-mask
+  - interrupt-map
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx6qdl-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pcie: pcie@1ffc000 {
+        compatible = "fsl,imx6q-pcie";
+        reg = <0x01ffc000 0x04000>,
+              <0x01f00000 0x80000>;
+        reg-names = "dbi", "config";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        bus-range = <0x00 0xff>;
+        ranges = <0x81000000 0 0          0x01f80000 0 0x00010000>,
+                 <0x82000000 0 0x01000000 0x01000000 0 0x00f00000>;
+        num-lanes = <1>;
+        num-viewport = <4>;
+        interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "msi";
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 0x7>;
+        interrupt-map = <0 0 0 1 &gpc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 2 &gpc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 3 &gpc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 4 &gpc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks IMX6QDL_CLK_PCIE_AXI>,
+                <&clks IMX6QDL_CLK_LVDS1_GATE>,
+                <&clks IMX6QDL_CLK_PCIE_REF_125M>;
+        clock-names = "pcie", "pcie_bus", "pcie_phy";
+        status = "disabled";
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index f73fef615702..a1e2cc0be9e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14187,7 +14187,7 @@ M:	Lucas Stach <l.stach@pengutronix.de>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
 F:	drivers/pci/controller/dwc/*imx6*
 
 PCI DRIVER FOR FU740
-- 
2.25.1

