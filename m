Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65288456FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 14:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbhKSNtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 08:49:18 -0500
Received: from mail-dm6nam12on2075.outbound.protection.outlook.com ([40.107.243.75]:4128
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235524AbhKSNtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:49:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vxv/HtcmjSDNhT8EIwlgwsb+V3QjsHVZz/K4M/M/Tb2FUNkCwCQxN/bDnyB6LuR6Pi+WX/V265reqMWjedrgmaZh976RLgeQ0WqgYdo0pDaBBz+5f53Fzw8ZzoVtbCiqsl8mKmwAWfWkMGWFrqbRfOHulJXqPv1aDGB89Rbch61DFeK5VMfCipkTQcGP6rwFbacCDoqycV6q5v5W/BpyOYfBKf+81gD6QTmN7xFarI3NGY0CKUWGIGQQ+/T1JPHfEIW+VQnBm0JelIfJZdkEsZtq58VF6vBJ3mVSAaOcO74S5R6+apa+gtGSsH5NFAoESSYsgXwKX+kj2LqRYULw0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrSZgZZYXCfLNEryAeRITgqbQoKNoHF/FlU/O7fNMSw=;
 b=DZG8jAeBDPDkL+F+7TSs8Bi4cDpLlg2grxB1q1C9GuPEVJ35eHMyiMZix06X4SwwZMSNSlczcWeUdg6l6lMNxX0euAM3MQjXb9jw40dzIFA3s/9KROPBS+YkPKdjC6dMhnBY2ytGZmdLo4Z0gHz/F8nxaFWzGpPEwbE1cx+0UoDz9L+3jAeNIBXafB7iSCEfLT3jBc8xY/q7EZEduHhB0mnnwkuqo8dYDh3Bes/CO6Y9URzUygVM4nNEl2Ja8/bvdbeAmrffbSVdREZdaFQZEPAv9rrw2nXUXnppK3LgkYoYkISJzKGLgyC7ETEn87WCismmoJkHI45YrattHvOmJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrSZgZZYXCfLNEryAeRITgqbQoKNoHF/FlU/O7fNMSw=;
 b=COZgd956+JzHZDKhmi4j1yhQX9sosVLBFbkpGgEO8Qb90KbsPgxaqBXfEBoPiUfVM3waRSlFgZp9HPvadJVEIQoPlniwa4OEnzlgLN11DAWUscagMxbgGoxqJbxy0G0k2cR/JHk6tOzoDKNrwKap3h2tENp3eTetkUjMmjiL0k4=
Received: from DS7PR06CA0013.namprd06.prod.outlook.com (2603:10b6:8:2a::13) by
 BN6PR02MB3234.namprd02.prod.outlook.com (2603:10b6:405:65::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Fri, 19 Nov 2021 13:46:13 +0000
Received: from DM3NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::bb) by DS7PR06CA0013.outlook.office365.com
 (2603:10b6:8:2a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Fri, 19 Nov 2021 13:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT057.mail.protection.outlook.com (10.13.5.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 13:46:13 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 19 Nov 2021 05:46:11 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 19 Nov 2021 05:46:11 -0800
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Received: from [172.23.64.8] (port=38273 helo=xhdvnc108.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1mo4DS-0006h0-Sn; Fri, 19 Nov 2021 05:46:11 -0800
Received: by xhdvnc108.xilinx.com (Postfix, from userid 16987)
        id 14856604A7; Fri, 19 Nov 2021 19:16:10 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <manish.narani@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>
Subject: [PATCH] dt-bindings: usb: dwc3-xilinx: Convert USB DWC3 bindings
Date:   Fri, 19 Nov 2021 19:16:08 +0530
Message-ID: <1637329568-31756-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3aab792-3783-4549-07db-08d9ab62f3a7
X-MS-TrafficTypeDiagnostic: BN6PR02MB3234:
X-Microsoft-Antispam-PRVS: <BN6PR02MB3234A503FF2DFB214DE3A236C19C9@BN6PR02MB3234.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ym+nmTCGVQz6xtYv6e0T/kZzsMA26ANVQP1UJVcxkbOQMRig4Yv0P+8CPyV1bDOkc/017PvyrVMTr06KB/bFcn/+io6FMAANBgRLIFqQPmwN8ftfdjSZG/ryMpaDCHlKXcpAJrTRTIjusvYzPcvWCxg+SPHZVhEb3ccaeSSU4MoZxvnIGAa3xURPd1Kz4e8TjTP3SgKrHblTljXL86O3hCS1jk3iKbjKFkuJ8EC10yXtZzdVUAZwdePtCK4+6pqQ93gN9r6XH50WszmjFRfBZu/tCk1lr5nbJ1o8Rxr8jEObp3MrIoVWCIIC/Ba/OPeUpWArRw/0cIIuK9In/q9pWBNJYsvr+ZSAq/ZCkbDP2Yajb6+9jPEky+ck+ZwfBDcmpPiGDhTg9+vq5fGHol0zVO6JAyroG8tZT3wdte7HIpv5I7lJ7VJYQquAf28DGThAcULier+5UQytDUOJn2YMgU4k5px4SmS5FU1y+ajuOBcx68RXQ38pBT1dj7J8p2e86fTJs4Wwn7ogR0P9bMfJ46dhZ02PBHXDFxd4WeUXplxRAEccYooiFF/qi4Yba7+e55AU/WrxO1gtDp0pVsRwAtB9He3V6tFF/mwFBLFWsGKMs1WjkntUS6advRzn0UhMyh87dIIz4SizIu2U2dmbwFcjk4FyiG1KzrdKTy0G2XTe/WdygzF6ajuhWaHPuhNnhIqX7SNKvAS80GpIU9YfrxiuscW8McL+xyEU670aqkEhv57yQErxU3tibnbCMxODvvYCPSYdfWUNgzslmsaZJie65GOw82NsysL6enQeBUSJMOzfSbJ7ZJ7ci1u+zcYPuy54DbS34kDCeQuZqXzk3KWmaCZPsKIFVhguFfEqlY4=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(4326008)(36860700001)(47076005)(70586007)(26005)(82310400003)(42186006)(426003)(7049001)(356005)(2906002)(336012)(107886003)(7636003)(6266002)(186003)(8936002)(83380400001)(8676002)(70206006)(110136005)(54906003)(2616005)(36756003)(508600001)(44832011)(5660300002)(966005)(316002)(36906005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 13:46:13.1680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3aab792-3783-4549-07db-08d9ab62f3a7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3234
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert USB DWC3 bindings to DT schema format using json-schema.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../devicetree/bindings/usb/dwc3-xilinx.txt        |  56 ----------
 .../devicetree/bindings/usb/dwc3-xilinx.yaml       | 119 +++++++++++++++++++++
 2 files changed, 119 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
 create mode 100644 Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml

diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
deleted file mode 100644
index 04813a4..00000000
--- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Xilinx SuperSpeed DWC3 USB SoC controller
-
-Required properties:
-- compatible:	May contain "xlnx,zynqmp-dwc3" or "xlnx,versal-dwc3"
-- reg:		Base address and length of the register control block
-- clocks:	A list of phandles for the clocks listed in clock-names
-- clock-names:	Should contain the following:
-  "bus_clk"	 Master/Core clock, have to be >= 125 MHz for SS
-		 operation and >= 60MHz for HS operation
-
-  "ref_clk"	 Clock source to core during PHY power down
-- resets:	A list of phandles for resets listed in reset-names
-- reset-names:
-  "usb_crst"	 USB core reset
-  "usb_hibrst"	 USB hibernation reset
-  "usb_apbrst"	 USB APB reset
-
-Required child node:
-A child node must exist to represent the core DWC3 IP block. The name of
-the node is not important. The content of the node is defined in dwc3.txt.
-
-Optional properties for snps,dwc3:
-- dma-coherent:	Enable this flag if CCI is enabled in design. Adding this
-		flag configures Global SoC bus Configuration Register and
-		Xilinx USB 3.0 IP - USB coherency register to enable CCI.
-- interrupt-names: Should contain the following:
-  "dwc_usb3"	USB gadget mode interrupts
-  "otg"		USB OTG mode interrupts
-  "hiber"	USB hibernation interrupts
-
-Example device node:
-
-		usb@0 {
-			#address-cells = <0x2>;
-			#size-cells = <0x1>;
-			compatible = "xlnx,zynqmp-dwc3";
-			reg = <0x0 0xff9d0000 0x0 0x100>;
-			clock-names = "bus_clk", "ref_clk";
-			clocks = <&clk125>, <&clk125>;
-			resets = <&zynqmp_reset ZYNQMP_RESET_USB1_CORERESET>,
-				 <&zynqmp_reset ZYNQMP_RESET_USB1_HIBERRESET>,
-				 <&zynqmp_reset ZYNQMP_RESET_USB1_APB>;
-			reset-names = "usb_crst", "usb_hibrst", "usb_apbrst";
-			ranges;
-
-			dwc3@fe200000 {
-				compatible = "snps,dwc3";
-				reg = <0x0 0xfe200000 0x40000>;
-				interrupt-names = "dwc_usb3", "otg", "hiber";
-				interrupts = <0 65 4>, <0 69 4>, <0 75 4>;
-				phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
-				phy-names = "usb3-phy";
-				dr_mode = "host";
-				dma-coherent;
-			};
-		};
diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
new file mode 100644
index 00000000..193c69a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/dwc3-xilinx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx SuperSpeed DWC3 USB SoC controller
+
+maintainers:
+  - Manish Narani <manish.narani@xilinx.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - xlnx,zynqmp-dwc3
+          - xlnx,versal-dwc3
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    enum: [ 1, 2 ]
+
+  "#size-cells":
+    enum: [ 1, 2 ]
+
+  ranges: true
+
+  power-domains:
+    description: specifies a phandle to PM domain provider node
+    maxItems: 1
+
+  clocks:
+    description:
+      A list of phandle and clock-specifier pairs for the clocks
+      listed in clock-names.
+    items:
+      - description: Master/Core clock, has to be >= 125 MHz
+          for SS operation and >= 60MHz for HS operation.
+      - description: Clock source to core during PHY power down.
+
+  clock-names:
+    items:
+      - const: bus_clk
+      - const: ref_clk
+
+  resets:
+    description:
+      A list of phandles for resets listed in reset-names.
+
+    items:
+      - description: USB core reset
+      - description: USB hibernation reset
+      - description: USB APB reset
+
+  reset-names:
+    items:
+      - const: usb_crst
+      - const: usb_hibrst
+      - const: usb_apbrst
+
+# Required child node:
+
+patternProperties:
+  "^usb@[0-9a-f]+$":
+    $ref: snps,dwc3.yaml#
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - power-domains
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/dma/xlnx-zynqmp-dpdma.h>
+    #include <dt-bindings/power/xlnx-zynqmp-power.h>
+    #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
+    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
+    #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
+    #include <dt-bindings/phy/phy.h>
+    axi {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        usb@0 {
+            #address-cells = <0x2>;
+            #size-cells = <0x2>;
+            compatible = "xlnx,zynqmp-dwc3";
+            reg = <0x0 0xff9d0000 0x0 0x100>;
+            clocks = <&zynqmp_clk USB0_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
+            clock-names = "bus_clk", "ref_clk";
+            power-domains = <&zynqmp_firmware PD_USB_0>;
+            resets = <&zynqmp_reset ZYNQMP_RESET_USB1_CORERESET>,
+                     <&zynqmp_reset ZYNQMP_RESET_USB1_HIBERRESET>,
+                     <&zynqmp_reset ZYNQMP_RESET_USB1_APB>;
+            reset-names = "usb_crst", "usb_hibrst", "usb_apbrst";
+            ranges;
+
+            usb@fe200000 {
+                compatible = "snps,dwc3";
+                reg = <0x0 0xfe200000 0x0 0x40000>;
+                interrupt-names = "dwc_usb3";
+                interrupts = <0 65 4>;
+                phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
+                phy-names = "usb3-phy";
+                dr_mode = "host";
+                dma-coherent;
+            };
+        };
+    };
-- 
2.1.1

