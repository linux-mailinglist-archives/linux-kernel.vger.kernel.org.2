Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9FF3B1176
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 03:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhFWBzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 21:55:48 -0400
Received: from mx.socionext.com ([202.248.49.38]:1626 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhFWBzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 21:55:48 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 23 Jun 2021 10:53:30 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id C8386205902A;
        Wed, 23 Jun 2021 10:53:30 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 23 Jun 2021 10:53:30 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 2A593B62AB;
        Wed, 23 Jun 2021 10:53:30 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] dt-bindings: reset: Convert UniPhier glue reset to json-schema
Date:   Wed, 23 Jun 2021 10:53:28 +0900
Message-Id: <1624413208-17562-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the UniPhier peripheral glue reset binding to DT schema format.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../reset/socionext,uniphier-glue-reset.yaml       | 88 ++++++++++++++++++++++
 .../devicetree/bindings/reset/uniphier-reset.txt   | 61 ---------------
 2 files changed, 88 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.yaml
 delete mode 100644 Documentation/devicetree/bindings/reset/uniphier-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.yaml b/Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.yaml
new file mode 100644
index 0000000..29e4a90
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/socionext,uniphier-glue-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier peripheral core reset in glue layer
+
+description: |
+  Some peripheral core reset belongs to its own glue layer. Before using
+  this core reset, it is necessary to control the clocks and resets to
+  enable this layer. These clocks and resets should be described in each
+  property.
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+properties:
+  compatible:
+    enum:
+      - socionext,uniphier-pro4-usb3-reset
+      - socionext,uniphier-pro5-usb3-reset
+      - socionext,uniphier-pxs2-usb3-reset
+      - socionext,uniphier-ld20-usb3-reset
+      - socionext,uniphier-pxs3-usb3-reset
+      - socionext,uniphier-pro4-ahci-reset
+      - socionext,uniphier-pxs2-ahci-reset
+      - socionext,uniphier-pxs3-ahci-reset
+
+  reg:
+    maxItems: 1
+
+  "#reset-cells":
+    const: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    oneOf:
+      - items:           # for Pro4, Pro5
+          - const: gio
+          - const: link
+      - items:           # for others
+          - const: link
+
+  resets:
+    minItems: 1
+    maxItems: 2
+
+  reset-names:
+    oneOf:
+      - items:           # for Pro4, Pro5
+          - const: gio
+          - const: link
+      - items:           # for others
+          - const: link
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#reset-cells"
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
+        usb_rst: reset@0 {
+            compatible = "socionext,uniphier-ld20-usb3-reset";
+            reg = <0x0 0x4>;
+            #reset-cells = <1>;
+            clock-names = "link";
+            clocks = <&sys_clk 14>;
+            reset-names = "link";
+            resets = <&sys_rst 14>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
deleted file mode 100644
index 88e06e5..0000000
--- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
+++ /dev/null
@@ -1,61 +0,0 @@
-UniPhier glue reset controller
-
-
-Peripheral core reset in glue layer
------------------------------------
-
-Some peripheral core reset belongs to its own glue layer. Before using
-this core reset, it is necessary to control the clocks and resets to enable
-this layer. These clocks and resets should be described in each property.
-
-Required properties:
-- compatible: Should be
-    "socionext,uniphier-pro4-usb3-reset" - for Pro4 SoC USB3
-    "socionext,uniphier-pro5-usb3-reset" - for Pro5 SoC USB3
-    "socionext,uniphier-pxs2-usb3-reset" - for PXs2 SoC USB3
-    "socionext,uniphier-ld20-usb3-reset" - for LD20 SoC USB3
-    "socionext,uniphier-pxs3-usb3-reset" - for PXs3 SoC USB3
-    "socionext,uniphier-pro4-ahci-reset" - for Pro4 SoC AHCI
-    "socionext,uniphier-pxs2-ahci-reset" - for PXs2 SoC AHCI
-    "socionext,uniphier-pxs3-ahci-reset" - for PXs3 SoC AHCI
-- #reset-cells: Should be 1.
-- reg: Specifies offset and length of the register set for the device.
-- clocks: A list of phandles to the clock gate for the glue layer.
-	According to the clock-names, appropriate clocks are required.
-- clock-names: Should contain
-    "gio", "link" - for Pro4 and Pro5 SoCs
-    "link"        - for others
-- resets: A list of phandles to the reset control for the glue layer.
-	According to the reset-names, appropriate resets are required.
-- reset-names: Should contain
-    "gio", "link" - for Pro4 and Pro5 SoCs
-    "link"        - for others
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
-		usb_rst: reset@0 {
-			compatible = "socionext,uniphier-ld20-usb3-reset";
-			reg = <0x0 0x4>;
-			#reset-cells = <1>;
-			clock-names = "link";
-			clocks = <&sys_clk 14>;
-			reset-names = "link";
-			resets = <&sys_rst 14>;
-		};
-
-		regulator {
-			...
-		};
-
-		phy {
-			...
-		};
-		...
-	};
-- 
2.7.4

