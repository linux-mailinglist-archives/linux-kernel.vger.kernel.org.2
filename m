Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CD43D1FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 10:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhGVIEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 04:04:01 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49548 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231243AbhGVICd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:02:33 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 825D61A0D1F;
        Thu, 22 Jul 2021 10:42:55 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1FE451A0CFF;
        Thu, 22 Jul 2021 10:42:55 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C2429183ACDC;
        Thu, 22 Jul 2021 16:42:53 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     robh@kernel.org, galak@kernel.crashing.org, shawnguo@kernel.org,
        devicetree@vger.kernel.org
Cc:     l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [RFC 1/2] dt-bindings: PCI: imx6: add fsl,imx6q-pcie.yaml
Date:   Thu, 22 Jul 2021 16:22:34 +0800
Message-Id: <1626942155-9209-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626942155-9209-1-git-send-email-hongxing.zhu@nxp.com>
References: <1626942155-9209-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the fsl,imx6q-pcie.txt into a schema.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 212 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 213 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
new file mode 100644
index 000000000000..b66b681d7ad7
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -0,0 +1,212 @@
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
+    const: fsl,imx6q-pcie
+    const: fsl,imx6sx-pcie
+    const: fsl,imx6qp-pcie
+    const: fsl,imx7d-pcie
+    const: fsl,imx8mq-pcie
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
+    $ref: /schemas/types.yaml#/definitions/phandle
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: Phandle pointing to the DISPLAY domain for imx6sx-pcie,
+          to PCIE_PHY power domain for imx7d-pcie and imx8mq-pcie.
+      - description: Phandle pointing to the PCIE_PHY power domains for
+          imx6sx-pcie.
+
+  power-domain-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: pcie
+      - const: pcie_phy
+
+  resets:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    items:
+      - description: Phandles to PCIe-related reset lines exposed by SRC
+          IP block. Additional required by imx7d-pcie and imx8mq-pcie.
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
+    pcie: pcie@1ffc000 {
+        compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
+        reg = <0x01ffc000 0x04000>,
+              <0x01f00000 0x80000>;
+        reg-names = "dbi", "config";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        bus-range = <0x00 0xff>;
+        ranges = <0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
+                  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
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
index 2c5dc7d20d81..a616e250d846 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14186,6 +14186,7 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
 F:	drivers/pci/controller/dwc/*imx6*
 
 PCI DRIVER FOR FU740
-- 
2.17.1

