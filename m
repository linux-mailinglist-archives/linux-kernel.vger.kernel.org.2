Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE7E432010
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 16:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhJROmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 10:42:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35154 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbhJROmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:42:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B4ADE1F42DD3
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     a.hajda@samsung.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2] dt-bindings: display/bridge: tc358764: Convert to YAML binding
Date:   Mon, 18 Oct 2021 16:40:03 +0200
Message-Id: <20211018144003.878345-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Toshiba TC358764 txt documentation to YAML.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
Note: dtbs_check on exynos5250-arndale.dts will give some warnings after
      applying this patch: since the preferred way is to have 'ports',
      this warning was ignored.
      I have no Exynos5250 board, so the dts fix is left to someone who
      is able to test on the real hw.

 .../display/bridge/toshiba,tc358764.txt       | 35 -------
 .../display/bridge/toshiba,tc358764.yaml      | 94 +++++++++++++++++++
 2 files changed, 94 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
 create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
deleted file mode 100644
index 8f9abf28a8fa..000000000000
--- a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-TC358764 MIPI-DSI to LVDS panel bridge
-
-Required properties:
-  - compatible: "toshiba,tc358764"
-  - reg: the virtual channel number of a DSI peripheral
-  - vddc-supply: core voltage supply, 1.2V
-  - vddio-supply: I/O voltage supply, 1.8V or 3.3V
-  - vddlvds-supply: LVDS1/2 voltage supply, 3.3V
-  - reset-gpios: a GPIO spec for the reset pin
-
-The device node can contain following 'port' child nodes,
-according to the OF graph bindings defined in [1]:
-  0: DSI Input, not required, if the bridge is DSI controlled
-  1: LVDS Output, mandatory
-
-[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
-
-Example:
-
-	bridge@0 {
-		reg = <0>;
-		compatible = "toshiba,tc358764";
-		vddc-supply = <&vcc_1v2_reg>;
-		vddio-supply = <&vcc_1v8_reg>;
-		vddlvds-supply = <&vcc_3v3_reg>;
-		reset-gpios = <&gpd1 6 GPIO_ACTIVE_LOW>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		port@1 {
-			reg = <1>;
-			lvds_ep: endpoint {
-				remote-endpoint = <&panel_ep>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.yaml
new file mode 100644
index 000000000000..815eedb9094f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/toshiba,tc358764.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba TC358764 MIPI-DSI to LVDS bridge
+
+maintainers:
+  - Andrzej Hajda <a.hajda@samsung.com>
+
+description: |
+  The TC358764 is bridge device which converts MIPI DSI or MIPI DPI to DP/eDP.
+
+properties:
+  compatible:
+    enum:
+      - toshiba,tc358764
+
+  reg:
+    description: Virtual channel number of a DSI peripheral
+    maxItems: 1
+
+  reset-gpios:
+    description: GPIO connected to the reset pin.
+    maxItems: 1
+
+  vddc-supply:
+    description: Core voltage supply, 1.2V
+
+  vddio-supply:
+    description: I/O voltage supply, 1.8V or 3.3V
+
+  vddlvds-supply:
+    description: LVDS1/2 voltage supply, 3.3V
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Video port for MIPI DSI input, if the bridge DSI controlled
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Video port for LVDS output (panel or connector).
+
+    required:
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - vddc-supply
+  - vddio-supply
+  - vddlvds-supply
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      bridge@0 {
+        compatible = "toshiba,tc358764";
+        reg = <0>;
+        vddc-supply = <&vcc_1v2_reg>;
+        vddio-supply = <&vcc_1v8_reg>;
+        vddlvds-supply = <&vcc_3v3_reg>;
+        reset-gpios = <&gpd1 6 GPIO_ACTIVE_LOW>;
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          port@1 {
+            reg = <1>;
+            lvds_ep: endpoint {
+              remote-endpoint = <&panel_ep>;
+            };
+          };
+        };
+      };
+    };
+
+...
-- 
2.33.0

