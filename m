Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4823B1173
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 03:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFWByt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 21:54:49 -0400
Received: from mx.socionext.com ([202.248.49.38]:17764 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhFWBys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 21:54:48 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 23 Jun 2021 10:52:31 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 243AF205902A;
        Wed, 23 Jun 2021 10:52:31 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 23 Jun 2021 10:52:31 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 7523BB62AB;
        Wed, 23 Jun 2021 10:52:30 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] dt-bindings: regulator: Convert UniPhier regulator to json-schema
Date:   Wed, 23 Jun 2021 10:52:17 +0900
Message-Id: <1624413137-17453-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the UniPhier regulator binding to DT schema format.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../regulator/socionext,uniphier-regulator.yaml    | 85 ++++++++++++++++++++++
 .../bindings/regulator/uniphier-regulator.txt      | 58 ---------------
 2 files changed, 85 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/socionext,uniphier-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/uniphier-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/socionext,uniphier-regulator.yaml b/Documentation/devicetree/bindings/regulator/socionext,uniphier-regulator.yaml
new file mode 100644
index 0000000..861d5f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/socionext,uniphier-regulator.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/socionext,uniphier-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier regulator controller
+
+description: |
+  This regulator controls VBUS and belongs to USB3 glue layer. Before using
+  the regulator, it is necessary to control the clocks and resets to enable
+  this layer. These clocks and resets should be described in each property.
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+allOf:
+  - $ref: "regulator.yaml#"
+
+# USB3 Controller
+
+properties:
+  compatible:
+    enum:
+      - socionext,uniphier-pro4-usb3-regulator
+      - socionext,uniphier-pro5-usb3-regulator
+      - socionext,uniphier-pxs2-usb3-regulator
+      - socionext,uniphier-ld20-usb3-regulator
+      - socionext,uniphier-pxs3-usb3-regulator
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    oneOf:
+      - items:          # for Pro4, Pro5
+          - const: gio
+          - const: link
+      - items:          # for others
+          - const: link
+
+  resets:
+    minItems: 1
+    maxItems: 2
+
+  reset-names:
+    oneOf:
+      - items:          # for Pro4, Pro5
+          - const: gio
+          - const: link
+      - items:
+          - const: link
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+examples:
+  - |
+    usb-glue@65b00000 {
+        compatible = "simple-mfd";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x65b00000 0x400>;
+
+        usb_vbus0: regulators@100 {
+            compatible = "socionext,uniphier-ld20-usb3-regulator";
+            reg = <0x100 0x10>;
+            clock-names = "link";
+            clocks = <&sys_clk 14>;
+            reset-names = "link";
+            resets = <&sys_rst 14>;
+        };
+    };
+
diff --git a/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt b/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
deleted file mode 100644
index 94fd38b..0000000
--- a/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-Socionext UniPhier Regulator Controller
-
-This describes the devicetree bindings for regulator controller implemented
-on Socionext UniPhier SoCs.
-
-USB3 Controller
----------------
-
-This regulator controls VBUS and belongs to USB3 glue layer. Before using
-the regulator, it is necessary to control the clocks and resets to enable
-this layer. These clocks and resets should be described in each property.
-
-Required properties:
-- compatible: Should be
-    "socionext,uniphier-pro4-usb3-regulator" - for Pro4 SoC
-    "socionext,uniphier-pro5-usb3-regulator" - for Pro5 SoC
-    "socionext,uniphier-pxs2-usb3-regulator" - for PXs2 SoC
-    "socionext,uniphier-ld20-usb3-regulator" - for LD20 SoC
-    "socionext,uniphier-pxs3-usb3-regulator" - for PXs3 SoC
-- reg: Specifies offset and length of the register set for the device.
-- clocks: A list of phandles to the clock gate for USB3 glue layer.
-	According to the clock-names, appropriate clocks are required.
-- clock-names: Should contain
-    "gio", "link" - for Pro4 and Pro5 SoCs
-    "link"        - for others
-- resets: A list of phandles to the reset control for USB3 glue layer.
-	According to the reset-names, appropriate resets are required.
-- reset-names: Should contain
-    "gio", "link" - for Pro4 and Pro5 SoCs
-    "link"        - for others
-
-See Documentation/devicetree/bindings/regulator/regulator.txt
-for more details about the regulator properties.
-
-Example:
-
-	usb-glue@65b00000 {
-		compatible = "socionext,uniphier-ld20-dwc3-glue",
-			     "simple-mfd";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x65b00000 0x400>;
-
-		usb_vbus0: regulators@100 {
-			compatible = "socionext,uniphier-ld20-usb3-regulator";
-			reg = <0x100 0x10>;
-			clock-names = "link";
-			clocks = <&sys_clk 14>;
-			reset-names = "link";
-			resets = <&sys_rst 14>;
-		};
-
-		phy {
-			...
-			phy-supply = <&usb_vbus0>;
-		};
-		...
-	};
-- 
2.7.4

