Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27583A268F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhFJIXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:23:11 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:48679 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFJIW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:22:59 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id CB78820008;
        Thu, 10 Jun 2021 08:20:59 +0000 (UTC)
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
Subject: [PATCH v23 09/18] dt-binding: memory: pl353-smc: Convert to yaml
Date:   Thu, 10 Jun 2021 10:20:31 +0200
Message-Id: <20210610082040.2075611-10-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
References: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert this binding file to yaml schema.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../memory-controllers/arm,pl353-smc.yaml     | 131 ++++++++++++++++++
 .../bindings/memory-controllers/pl353-smc.txt |  45 ------
 2 files changed, 131 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml b/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
new file mode 100644
index 000000000000..7a63c85ef8c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/arm,pl353-smc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM PL353 Static Memory Controller (SMC) device-tree bindings
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+  - Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
+
+description:
+  The PL353 Static Memory Controller is a bus where you can connect two kinds
+  of memory interfaces, which are NAND and memory mapped interfaces (such as
+  SRAM or NOR).
+
+# We need a select here so we don't match all nodes with 'arm,primecell'
+select:
+  properties:
+    compatible:
+      contains:
+        const: arm,pl353-smc-r2p1
+  required:
+    - compatible
+
+properties:
+  $nodename:
+    pattern: "^memory-controller@[0-9a-f]+$"
+
+  compatible:
+    items:
+      - const: arm,pl353-smc-r2p1
+      - const: arm,primecell
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 1
+
+  reg:
+    items:
+      - description:
+          Configuration registers for the host and sub-controllers.
+          The three chip select regions are defined in 'ranges'.
+
+  clocks:
+    items:
+      - description: clock for the memory device bus
+      - description: main clock of the SMC
+
+  clock-names:
+    items:
+      - const: memclk
+      - const: apb_pclk
+
+  ranges:
+    minItems: 1
+    maxItems: 3
+    description: |
+      Memory bus areas for interacting with the devices. Reflects
+      the memory layout with four integer values following:
+      <cs-number> 0 <offset> <size>
+    items:
+      - description: NAND bank 0
+      - description: NOR/SRAM bank 0
+      - description: NOR/SRAM bank 1
+
+  interrupts: true
+
+patternProperties:
+  "@[0-3],[a-f0-9]+$":
+    type: object
+    description: |
+      The child device node represents the controller connected to the SMC
+      bus. The controller can be a NAND controller or a pair of any memory
+      mapped controllers such as NOR and SRAM controllers.
+
+    properties:
+      compatible:
+        description:
+          Compatible of memory controller.
+
+      reg:
+        items:
+          - items:
+              - description: |
+                  Chip-select ID, as in the parent range property.
+                minimum: 0
+                maximum: 2
+              - description: |
+                  Offset of the memory region requested by the device.
+              - description: |
+                  Length of the memory region requested by the device.
+
+    required:
+      - compatible
+      - reg
+
+required:
+  - compatible
+  - reg
+  - clock-names
+  - clocks
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
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
diff --git a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
deleted file mode 100644
index ba6a5426f62b..000000000000
--- a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
+++ /dev/null
@@ -1,45 +0,0 @@
-Device tree bindings for ARM PL353 static memory controller
-
-PL353 Static Memory Controller is a bus where you can connect two kinds
-of memory interfaces: NAND and memory mapped interfaces (such as SRAM or NOR).
-
-Required properties:
-- compatible		: Should be "arm,pl353-smc-r2p1", "arm,primecell".
-- reg			: SMC controller and sub-controllers configuration
-			  registers.
-- clock-names		: List of input clock names - "memclk", "apb_pclk"
-			  (See clock bindings for details).
-- clocks		: Clock phandles (see clock bindings for details).
-- address-cells		: Must be 2.
-- size-cells		: Must be 1.
-- ranges		: Memory bus areas for interacting with the devices.
-			  Encodes CS to memory region association.
-
-The child device node represents the controller connected to the SMC
-bus. Only one between: NAND controller, NOR controller and SRAM controller
-is allowed in a single system.
-
-Required device node properties:
-
-- reg:			Contains the chip-select id, the offset and the length
-			of the memory region requested by the device.
-
-Example:
-	smcc: memory-controller@e000e000 {
-		compatible = "arm,pl353-smc-r2p1", "arm,primecell";
-		clock-names = "memclk", "apb_pclk";
-		clocks = <&clkc 11>, <&clkc 44>;
-		reg = <0xe000e000 0x1000>;
-		#address-cells = <2>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0xe1000000 0x1000000 /* Nand CS region */
-			  0x1 0x0 0xe2000000 0x2000000 /* SRAM/NOR CS0 region */
-			  0x2 0x0 0xe4000000 0x2000000>; /* SRAM/NOR CS1 region */
-
-		nfc0: nand-controller@0,0 {
-			compatible = "arm,pl353-nand-r2p1";
-			reg = <0 0 0x1000000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-	};
-- 
2.27.0

