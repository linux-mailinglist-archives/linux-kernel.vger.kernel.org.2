Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B873D4DF8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 16:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhGYNYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 09:24:24 -0400
Received: from vps5.brixit.nl ([192.81.221.234]:39406 "EHLO vps5.brixit.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230418AbhGYNYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 09:24:23 -0400
Received: from lexxgentoo.collabio.net (unknown [77.239.252.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vps5.brixit.nl (Postfix) with ESMTPSA id 49A4460906;
        Sun, 25 Jul 2021 14:04:50 +0000 (UTC)
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org (open list:DRM PANEL DRIVERS),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>
Subject: [PATCH 1/2] dt-bindings: panel: Add Samsung S6E3FA2 panel
Date:   Sun, 25 Jul 2021 17:03:37 +0300
Message-Id: <20210725140339.2465677-1-alexeymin@postmarketos.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung S6E3FA2 AMOLED cmd LCD panel is used on Samsung Galaxy
S5 (klte) phone.

Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
---
 .../display/panel/samsung,s6e3fa2.yaml        | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e3fa2.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e3fa2.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e3fa2.yaml
new file mode 100644
index 000000000000..d5628ae81141
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e3fa2.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,s6e3fa2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung s6e3fa2 AMOLED CMD LCD DSI panel
+
+maintainers:
+  - Alexey Minnekhanov <alexeymin@postmarketos.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: samsung,s6e3fa2
+
+  reg: true
+  reset-gpios: true
+  port: true
+
+  iovdd-supply:
+    description: IOVDD regulator
+
+  vddr-supply:
+    description: VDDR regulator
+
+required:
+  - compatible
+  - reset-gpios
+  - iovdd-supply
+  - vddr-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    /* from Samsung Galaxy S5 klte */
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "samsung,s6e3fa2";
+            reg = <0>;
+
+            reset-gpios = <&pma8084_gpios 17 GPIO_ACTIVE_LOW>;
+
+            iovdd-supply = <&pma8084_lvs4>;
+            vddr-supply = <&vreg_panel>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.31.1

