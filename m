Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FBE311B23
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhBFEuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:50:50 -0500
Received: from inva021.nxp.com ([92.121.34.21]:60526 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhBFD22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:28:28 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1C9C120014B;
        Sat,  6 Feb 2021 00:50:51 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B1D2120016E;
        Sat,  6 Feb 2021 00:50:50 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id CF96640011;
        Fri,  5 Feb 2021 16:50:49 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 03/15] dt-bindings: memory: fsl: convert ifc binding to yaml schema
Date:   Fri,  5 Feb 2021 17:47:22 -0600
Message-Id: <20210205234734.3397-4-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20210205234734.3397-1-leoyang.li@nxp.com>
References: <20210205234734.3397-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the txt binding to yaml format and add description.  Also
updated the recommended node name to ifc-bus to align with the
simple-bus node name requirements.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 .../bindings/memory-controllers/fsl/ifc.txt   |  82 ----------
 .../bindings/memory-controllers/fsl/ifc.yaml  | 140 ++++++++++++++++++
 2 files changed, 140 insertions(+), 82 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
deleted file mode 100644
index 89427b018ba7..000000000000
--- a/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
+++ /dev/null
@@ -1,82 +0,0 @@
-Integrated Flash Controller
-
-Properties:
-- name : Should be ifc
-- compatible : should contain "fsl,ifc". The version of the integrated
-               flash controller can be found in the IFC_REV register at
-               offset zero.
-
-- #address-cells : Should be either two or three.  The first cell is the
-                   chipselect number, and the remaining cells are the
-                   offset into the chipselect.
-- #size-cells : Either one or two, depending on how large each chipselect
-                can be.
-- reg : Offset and length of the register set for the device
-- interrupts: IFC may have one or two interrupts.  If two interrupt
-              specifiers are present, the first is the "common"
-              interrupt (CM_EVTER_STAT), and the second is the NAND
-              interrupt (NAND_EVTER_STAT).  If there is only one,
-              that interrupt reports both types of event.
-
-- little-endian : If this property is absent, the big-endian mode will
-                  be in use as default for registers.
-
-- ranges : Each range corresponds to a single chipselect, and covers
-           the entire access window as configured.
-
-Child device nodes describe the devices connected to IFC such as NOR (e.g.
-cfi-flash) and NAND (fsl,ifc-nand). There might be board specific devices
-like FPGAs, CPLDs, etc.
-
-Example:
-
-	ifc@ffe1e000 {
-		compatible = "fsl,ifc", "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <1>;
-		reg = <0x0 0xffe1e000 0 0x2000>;
-		interrupts = <16 2 19 2>;
-		little-endian;
-
-		/* NOR, NAND Flashes and CPLD on board */
-		ranges = <0x0 0x0 0x0 0xee000000 0x02000000
-			  0x1 0x0 0x0 0xffa00000 0x00010000
-			  0x3 0x0 0x0 0xffb00000 0x00020000>;
-
-		flash@0,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "cfi-flash";
-			reg = <0x0 0x0 0x2000000>;
-			bank-width = <2>;
-			device-width = <1>;
-
-			partition@0 {
-				/* 32MB for user data */
-				reg = <0x0 0x02000000>;
-				label = "NOR Data";
-			};
-		};
-
-		flash@1,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,ifc-nand";
-			reg = <0x1 0x0 0x10000>;
-
-			partition@0 {
-				/* This location must not be altered  */
-				/* 1MB for u-boot Bootloader Image */
-				reg = <0x0 0x00100000>;
-				label = "NAND U-Boot Image";
-				read-only;
-			};
-		};
-
-		cpld@3,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,p1010rdb-cpld";
-			reg = <0x3 0x0 0x000001f>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml
new file mode 100644
index 000000000000..d37cae66b027
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml
@@ -0,0 +1,140 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/fsl/ifc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: FSL/NXP Integrated Flash Controller
+
+maintainers:
+  - Li Yang <leoyang.li@nxp.com>
+
+description: |
+  NXP's integrated flash controller (IFC) is an advanced version of the
+  enhanced local bus controller which includes similar programming and signal
+  interfaces with an extended feature set. The IFC provides access to multiple
+  external memory types, such as NAND flash (SLC and MLC), NOR flash, EPROM,
+  SRAM and other memories where address and data are shared on a bus.
+
+allOf:
+  - $ref: /schemas/simple-bus.yaml#
+
+properties:
+  $nodename:
+    pattern: "^ifc-bus@[0-9a-f]+$"
+
+  compatible:
+    contains:
+      const: fsl,ifc
+
+  "#address-cells":
+    enum: [2, 3]
+    description: |
+      Should be either two or three.  The first cell is the chipselect
+      number, and the remaining cells are the offset into the chipselect.
+
+  "#size-cells":
+    enum: [1, 2]
+    description: |
+      Either one or two, depending on how large each chipselect can be.
+
+  reg:
+    maxItems: 1
+    description: |
+        Offset and length of the register set for the device.
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+    description: |
+      IFC may have one or two interrupts.  If two interrupt specifiers are
+      present, the first is the "common" interrupt (CM_EVTER_STAT), and the
+      second is the NAND interrupt (NAND_EVTER_STAT).  If there is only one,
+      that interrupt reports both types of event.
+
+  little-endian:
+    description: |
+      If this property is absent, the big-endian mode will be in use as default
+      for registers.
+
+  ranges:
+    description: |
+      Each range corresponds to a single chipselect, and covers the entire
+      access window as configured.
+
+patternProperties:
+  "^.*@[a-f0-9]+(,[a-f0-9]+)+$":
+    type: object
+    description: |
+      Child device nodes describe the devices connected to IFC such as NOR (e.g.
+      cfi-flash) and NAND (fsl,ifc-nand). There might be board specific devices
+      like FPGAs, CPLDs, etc.
+
+    required:
+      - compatible
+      - reg
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        ifc-bus@ffe1e000 {
+            compatible = "fsl,ifc", "simple-bus";
+            #address-cells = <2>;
+            #size-cells = <1>;
+            reg = <0x0 0xffe1e000 0 0x2000>;
+            interrupts = <16 2 19 2>;
+            little-endian;
+
+            /* NOR, NAND Flashes and CPLD on board */
+            ranges = <0x0 0x0 0x0 0xee000000 0x02000000>,
+                     <0x1 0x0 0x0 0xffa00000 0x00010000>,
+                     <0x3 0x0 0x0 0xffb00000 0x00020000>;
+
+            flash@0,0 {
+                #address-cells = <1>;
+                #size-cells = <1>;
+                compatible = "cfi-flash";
+                reg = <0x0 0x0 0x2000000>;
+                bank-width = <2>;
+                device-width = <1>;
+
+                partition@0 {
+                    /* 32MB for user data */
+                    reg = <0x0 0x02000000>;
+                    label = "NOR Data";
+                };
+            };
+
+            flash@1,0 {
+                #address-cells = <1>;
+                #size-cells = <1>;
+                compatible = "fsl,ifc-nand";
+                reg = <0x1 0x0 0x10000>;
+
+                partition@0 {
+                    /* This location must not be altered  */
+                    /* 1MB for u-boot Bootloader Image */
+                    reg = <0x0 0x00100000>;
+                    label = "NAND U-Boot Image";
+                    read-only;
+                };
+            };
+
+            cpld@3,0 {
+                #address-cells = <1>;
+                #size-cells = <1>;
+                compatible = "fsl,p1010rdb-cpld";
+                reg = <0x3 0x0 0x000001f>;
+            };
+        };
+    };
-- 
2.17.1

