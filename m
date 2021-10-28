Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7F343DC71
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 09:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhJ1Hzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 03:55:32 -0400
Received: from inva021.nxp.com ([92.121.34.21]:32988 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229987AbhJ1Hza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 03:55:30 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5E9A92003D6;
        Thu, 28 Oct 2021 09:53:03 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F0576200388;
        Thu, 28 Oct 2021 09:53:02 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 90073183AC94;
        Thu, 28 Oct 2021 15:53:00 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, galak@kernel.crashing.org, shawnguo@kernel.org
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v4 2/8] dt-bindings: phy: Add imx8 pcie phy driver support
Date:   Thu, 28 Oct 2021 15:27:11 +0800
Message-Id: <1635406037-20900-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635406037-20900-1-git-send-email-hongxing.zhu@nxp.com>
References: <1635406037-20900-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-binding for the standalone i.MX8 PCIe PHY driver.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---
 .../bindings/phy/fsl,imx8-pcie-phy.yaml       | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
new file mode 100644
index 000000000000..b9f89e343b0b
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/fsl,imx8-pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX8 SoC series PCIe PHY Device Tree Bindings
+
+maintainers:
+  - Richard Zhu <hongxing.zhu@nxp.com>
+
+properties:
+  "#phy-cells":
+    const: 0
+
+  compatible:
+    enum:
+      - fsl,imx8mm-pcie-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PHY module clock
+
+  clock-names:
+    items:
+      - const: ref
+
+  resets:
+    items:
+      - description: Phandles to PCIe-related reset lines exposed by SRC
+          IP block.
+
+  reset-names:
+    items:
+      - const: pciephy
+
+  fsl,refclk-pad-mode:
+    description: |
+      Specifies the mode of the refclk pad used. It can be UNUSED(PHY
+      refclock is derived from SoC internal source), INPUT(PHY refclock
+      is provided externally via the refclk pad) or OUTPUT(PHY refclock
+      is derived from SoC internal source and provided on the refclk pad).
+      Refer include/dt-bindings/phy/phy-imx8-pcie.h for the constants
+      to be used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2 ]
+
+  fsl,tx-deemph-gen1:
+    description: Gen1 De-emphasis value (optional required).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+
+  fsl,tx-deemph-gen2:
+    description: Gen2 De-emphasis value (optional required).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+
+  fsl,clkreq-unsupported:
+    type: boolean
+    description: A boolean property indicating the CLKREQ# signal is
+      not supported in the board design (optional)
+
+required:
+  - "#phy-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - fsl,refclk-pad-mode
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mm-clock.h>
+    #include <dt-bindings/phy/phy-imx8-pcie.h>
+    #include <dt-bindings/reset/imx8mq-reset.h>
+
+    pcie_phy: pcie-phy@32f00000 {
+            compatible = "fsl,imx8mm-pcie-phy";
+            reg = <0x32f00000 0x10000>;
+            clocks = <&clk IMX8MM_CLK_PCIE1_PHY>;
+            clock-names = "ref";
+            assigned-clocks = <&clk IMX8MM_CLK_PCIE1_PHY>;
+            assigned-clock-rates = <100000000>;
+            assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_100M>;
+            resets = <&src IMX8MQ_RESET_PCIEPHY>;
+            reset-names = "pciephy";
+            fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
+            #phy-cells = <0>;
+    };
+...
-- 
2.25.1

