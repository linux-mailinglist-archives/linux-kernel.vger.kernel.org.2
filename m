Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEE93A269D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhFJIXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:23:32 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:56117 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhFJIXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:23:15 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 922FD20008;
        Thu, 10 Jun 2021 08:21:16 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Michal Simek <monstr@monstr.eu>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, helmut.grohne@intenta.de,
        Srinivas Goud <sgoud@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v23 17/18] dt-bindings: mtd: pl353-nand: Describe this hardware controller
Date:   Thu, 10 Jun 2021 10:20:39 +0200
Message-Id: <20210610082040.2075611-18-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
References: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a yaml description of this NAND controller which is described as a
subnode of the SMC bus.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/mtd/arm,pl353-nand-r2p1.yaml     | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml

diff --git a/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
new file mode 100644
index 000000000000..5f126bb9b202
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/arm,pl353-nand-r2p1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PL353 NAND Controller device tree bindings
+
+allOf:
+  - $ref: "nand-controller.yaml"
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+  - Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
+
+properties:
+  compatible:
+    items:
+      - const: arm,pl353-nand-r2p1
+
+  reg:
+    items:
+      - items:
+          - description: CS with regard to the parent ranges property
+          - description: Offset of the memory region requested by the device
+          - description: Length of the memory region requested by the device
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    smcc: memory-controller@e000e000 {
+      compatible = "arm,pl353-smc-r2p1", "arm,primecell";
+      reg = <0xe000e000 0x0001000>;
+      clock-names = "memclk", "apb_pclk";
+      clocks = <&clkc 11>, <&clkc 44>;
+      ranges = <0x0 0x0 0xe1000000 0x1000000 /* Nand CS region */
+                0x1 0x0 0xe2000000 0x2000000 /* SRAM/NOR CS0 region */
+                0x2 0x0 0xe4000000 0x2000000>; /* SRAM/NOR CS1 region */
+      #address-cells = <2>;
+      #size-cells = <1>;
+
+      nfc0: nand-controller@0,0 {
+        compatible = "arm,pl353-nand-r2p1";
+        reg = <0 0 0x1000000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+      };
+    };
-- 
2.27.0

