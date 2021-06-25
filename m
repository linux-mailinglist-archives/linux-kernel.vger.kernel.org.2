Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910623B42E3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFYMNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:13:19 -0400
Received: from aposti.net ([89.234.176.197]:43538 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhFYMNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:13:18 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] dt-bindings: display/panel: Add Innolux EJ030NA
Date:   Fri, 25 Jun 2021 13:10:44 +0100
Message-Id: <20210625121045.81711-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the Innolux EJ030NA panel, which is a 320x480 3.0" 4:3
24-bit TFT LCD panel with non-square pixels and a delta-RGB 8-bit
interface.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../display/panel/innolux,ej030na.yaml        | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,ej030na.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/innolux,ej030na.yaml b/Documentation/devicetree/bindings/display/panel/innolux,ej030na.yaml
new file mode 100644
index 000000000000..cda36c04e85c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/innolux,ej030na.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/innolux,ej030na.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Innolux EJ030NA 3.0" (320x480 pixels) 24-bit TFT LCD panel
+
+description: |
+  The panel must obey the rules for a SPI slave device as specified in
+  spi/spi-controller.yaml
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: innolux,ej030na
+
+  backlight: true
+  port: true
+  power-supply: true
+  reg: true
+  reset-gpios: true
+
+required:
+  - compatible
+  - reg
+  - power-supply
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "innolux,ej030na";
+            reg = <0>;
+
+            spi-max-frequency = <10000000>;
+
+            reset-gpios = <&gpe 4 GPIO_ACTIVE_LOW>;
+            power-supply = <&lcd_power>;
+
+            backlight = <&backlight>;
+
+            port {
+                panel_input: endpoint {
+                    remote-endpoint = <&panel_output>;
+                };
+            };
+        };
+    };
-- 
2.30.2

