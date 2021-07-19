Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2034A3CCC47
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 04:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbhGSCeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 22:34:21 -0400
Received: from mx.socionext.com ([202.248.49.38]:30034 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234253AbhGSCeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 22:34:16 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 19 Jul 2021 11:31:16 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 7924F2021260;
        Mon, 19 Jul 2021 11:31:16 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 19 Jul 2021 11:31:16 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 36CF5B633F;
        Mon, 19 Jul 2021 11:31:16 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>
Subject: [PATCH v2 2/2] dt-bindings: nvmem: Convert UniPhier eFuse bindings to json-schema
Date:   Mon, 19 Jul 2021 11:31:04 +0900
Message-Id: <1626661864-15473-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626661864-15473-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1626661864-15473-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the UniPhier eFuse binding to DT schema format.

Cc: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/nvmem/socionext,uniphier-efuse.yaml   | 95 ++++++++++++++++++++++
 .../devicetree/bindings/nvmem/uniphier-efuse.txt   | 49 -----------
 2 files changed, 95 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt

diff --git a/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
new file mode 100644
index 0000000..2578e39
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/socionext,uniphier-efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier eFuse bindings
+
+maintainers:
+  - Keiji Hayashibara <hayashibara.keiji@socionext.com>
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  "#address-cells": true
+  "#size-cells": true
+
+  compatible:
+    const: socionext,uniphier-efuse
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    // The UniPhier eFuse should be a subnode of a "soc-glue" node.
+
+    soc-glue@5f900000 {
+        compatible = "simple-mfd";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x5f900000 0x2000>;
+
+        efuse@100 {
+            compatible = "socionext,uniphier-efuse";
+            reg = <0x100 0x28>;
+        };
+
+        efuse@200 {
+            compatible = "socionext,uniphier-efuse";
+            reg = <0x200 0x68>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            /* Data cells */
+            usb_rterm0: trim@54,4 {
+                reg = <0x54 1>;
+                bits = <4 2>;
+            };
+            usb_rterm1: trim@55,4 {
+                reg = <0x55 1>;
+                bits = <4 2>;
+            };
+            usb_rterm2: trim@58,4 {
+                reg = <0x58 1>;
+                bits = <4 2>;
+            };
+            usb_rterm3: trim@59,4 {
+                reg = <0x59 1>;
+                bits = <4 2>;
+            };
+            usb_sel_t0: trim@54,0 {
+                reg = <0x54 1>;
+                bits = <0 4>;
+            };
+            usb_sel_t1: trim@55,0 {
+                reg = <0x55 1>;
+                bits = <0 4>;
+            };
+            usb_sel_t2: trim@58,0 {
+                reg = <0x58 1>;
+                bits = <0 4>;
+            };
+            usb_sel_t3: trim@59,0 {
+                reg = <0x59 1>;
+                bits = <0 4>;
+            };
+            usb_hs_i0: trim@56,0 {
+                reg = <0x56 1>;
+                bits = <0 4>;
+            };
+            usb_hs_i2: trim@5a,0 {
+                reg = <0x5a 1>;
+                bits = <0 4>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt b/Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt
deleted file mode 100644
index eccf490..0000000
--- a/Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-= UniPhier eFuse device tree bindings =
-
-This UniPhier eFuse must be under soc-glue.
-
-Required properties:
-- compatible: should be "socionext,uniphier-efuse"
-- reg: should contain the register location and length
-
-= Data cells =
-Are child nodes of efuse, bindings of which as described in
-bindings/nvmem/nvmem.txt
-
-Example:
-
-	soc-glue@5f900000 {
-		compatible = "socionext,uniphier-ld20-soc-glue-debug",
-			     "simple-mfd";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x5f900000 0x2000>;
-
-		efuse@100 {
-			compatible = "socionext,uniphier-efuse";
-			reg = <0x100 0x28>;
-		};
-
-		efuse@200 {
-			compatible = "socionext,uniphier-efuse";
-			reg = <0x200 0x68>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			/* Data cells */
-			usb_mon: usb-mon@54 {
-				reg = <0x54 0xc>;
-			};
-		};
-	};
-
-= Data consumers =
-Are device nodes which consume nvmem data cells.
-
-Example:
-
-	usb {
-		...
-		nvmem-cells = <&usb_mon>;
-		nvmem-cell-names = "usb_mon";
-	}
-- 
2.7.4

