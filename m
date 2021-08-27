Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C783F94DA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 09:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244426AbhH0HGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 03:06:08 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59664 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244353AbhH0HGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 03:06:04 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E345E1A07E5;
        Fri, 27 Aug 2021 09:05:13 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7F0DD1A1B37;
        Fri, 27 Aug 2021 09:05:13 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1BF1C183AC8B;
        Fri, 27 Aug 2021 15:05:12 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     robh@kernel.org, l.stach@pengutronix.de, galak@kernel.crashing.org,
        shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2 1/3] dt-bindings: PCI: imx6: convert the imx pcie controller to dtschema
Date:   Fri, 27 Aug 2021 14:42:58 +0800
Message-Id: <1630046580-19282-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630046580-19282-1-git-send-email-hongxing.zhu@nxp.com>
References: <1630046580-19282-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the fsl,imx6q-pcie.txt into a schema.
- ranges property should be grouped by region, with no functional
  changes.
- only one propert is allowed in the compatible string, remove
  "snps,dw-pcie".

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../bindings/pci/fsl,imx6q-pcie.txt           | 100 ---------
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 202 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 203 insertions(+), 101 deletions(-)
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
index 000000000000..2911e565b260
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -0,0 +1,202 @@
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
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
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
+    items:
+      - description: PCIe bridge clock.
+      - description: PCIe bus clock.
+      - description: PCIe PHY clock.
+      - description: Additional required clock entry for imx6sx-pcie,
+          imx8mq-pcie.
+
+  clock-names:
+    minItems: 3
+    items:
+      - const: pcie
+      - const: pcie_bus
+      - const: pcie_phy
+      - const: pcie_inbound_axi for imx6sx-pcie, pcie_aux for imx8mq-pcie
+
+  num-lanes:
+    const: 1
+
+  fsl,imx7d-pcie-phy:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: A phandle to an fsl,imx7d-pcie-phy node. Additional
+      required properties for imx7d-pcie and imx8mq-pcie.
+
+  power-domains:
+    items:
+      - description: The phandle pointing to the DISPLAY domain for
+          imx6sx-pcie, to PCIE_PHY power domain for imx7d-pcie and
+          imx8mq-pcie.
+      - description: The phandle pointing to the PCIE_PHY power domains
+          for imx6sx-pcie.
+
+  power-domain-names:
+    items:
+      - const: pcie
+      - const: pcie_phy
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

