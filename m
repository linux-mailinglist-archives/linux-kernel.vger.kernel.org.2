Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D224B424F16
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 10:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240537AbhJGIVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 04:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240573AbhJGIVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 04:21:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D034C061746;
        Thu,  7 Oct 2021 01:19:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 17CF71F44EF4
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, ajaykumar.rs@samsung.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] dt-bindings: display/bridge: ps8622: Convert to YAML binding
Date:   Thu,  7 Oct 2021 10:19:30 +0200
Message-Id: <20211007081930.84653-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Parade PS8622 eDP/DP to LVDS bridge documentation to YAML.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../display/bridge/parade,ps8622.yaml         | 102 ++++++++++++++++++
 .../bindings/display/bridge/ps8622.txt        |  31 ------
 2 files changed, 102 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/parade,ps8622.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/bridge/ps8622.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/parade,ps8622.yaml b/Documentation/devicetree/bindings/display/bridge/parade,ps8622.yaml
new file mode 100644
index 000000000000..dda9ceeac60c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/parade,ps8622.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/parade,ps8622.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Parade PS8622 eDP/DP to LVDS bridge
+
+maintainers:
+  - Ajay Kumar <ajaykumar.rs@samsung.com>
+
+properties:
+  compatible:
+    enum:
+      - parade,ps8622
+      - parade,ps8625
+
+  reg:
+    description: I2C address of the bridge
+    maxItems: 1
+
+  lane-count:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: Number of DP lanes to use
+    maxItems: 1
+
+  use-external-pwm:
+    type: boolean
+    description: Backlight controlled by an external PWM
+
+  sleep-gpios:
+    description: GPIO connected to the PD_ signal.
+    maxItems: 1
+
+  reset-gpios:
+    description: GPIO connected to the RST_ signal.
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Video port for LVDS output
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Video port for eDP input
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - sleep-gpios
+  - reset-gpios
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c1 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      bridge@48 {
+        compatible = "parade,ps8622";
+        reg = <0x48>;
+        lane-count = <1>;
+        sleep-gpios = <&gpc3 5 GPIO_ACTIVE_HIGH>;
+        reset-gpios = <&gpy7 7 GPIO_ACTIVE_HIGH>;
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          port@0 {
+            reg = <0>;
+            bridge_out: endpoint {
+              remote-endpoint = <&panel_in>;
+            };
+          };
+
+          port@1 {
+            reg = <1>;
+            bridge_in: endpoint {
+              remote-endpoint = <&dp_out>;
+            };
+          };
+        };
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/display/bridge/ps8622.txt b/Documentation/devicetree/bindings/display/bridge/ps8622.txt
deleted file mode 100644
index c989c3807f2b..000000000000
--- a/Documentation/devicetree/bindings/display/bridge/ps8622.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-ps8622-bridge bindings
-
-Required properties:
-	- compatible: "parade,ps8622" or "parade,ps8625"
-	- reg: first i2c address of the bridge
-	- sleep-gpios: OF device-tree gpio specification for PD_ pin.
-	- reset-gpios: OF device-tree gpio specification for RST_ pin.
-
-Optional properties:
-	- lane-count: number of DP lanes to use
-	- use-external-pwm: backlight will be controlled by an external PWM
-	- video interfaces: Device node can contain video interface port
-			    nodes for panel according to [1].
-
-[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
-
-Example:
-	lvds-bridge@48 {
-		compatible = "parade,ps8622";
-		reg = <0x48>;
-		sleep-gpios = <&gpc3 6 1 0 0>;
-		reset-gpios = <&gpc3 1 1 0 0>;
-		lane-count = <1>;
-		ports {
-			port@0 {
-				bridge_out: endpoint {
-					remote-endpoint = <&panel_in>;
-				};
-			};
-		};
-	};
-- 
2.33.0

