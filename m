Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAECC387AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349977AbhEROVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349960AbhEROVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:21:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91C5C061573;
        Tue, 18 May 2021 07:19:42 -0700 (PDT)
Received: from guri.fritz.box (unknown [IPv6:2a02:810a:880:f54:8085:99d1:d3e8:47cc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 72A291F42B08;
        Tue, 18 May 2021 15:19:40 +0100 (BST)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     megous@megous.com, linux-usb@vger.kernel.org, a.hajda@samsung.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        enric.balletbo@collabora.com, drinkcat@chromium.org,
        hsinyi@chromium.org, kernel@collabora.com, dafna3@gmail.com,
        dafna.hirschfeld@collabora.com, robh+dt@kernel.org
Subject: [PATCH v6 RESEND 1/2] dt-bindings: display: add google,cros-ec-anx7688.yaml
Date:   Tue, 18 May 2021 16:19:26 +0200
Message-Id: <20210518141927.24795-2-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210518141927.24795-1-dafna.hirschfeld@collabora.com>
References: <20210518141927.24795-1-dafna.hirschfeld@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ChromeOS EC ANX7688 is a display bridge that converts HDMI 2.0 to
DisplayPort 1.3 Ultra-HDi (4096x2160p60). It is an Analogix ANX7688 chip
which is connected to and operated by the ChromeOS Embedded Controller
(See google,cros-ec.yaml). It is accessed using I2C tunneling through
the EC and therefore its node should be a child of an EC I2C tunnel node
(See google,cros-ec-i2c-tunnel.yaml).

ChromOS EC ANX7688 is found on Acer Chromebook R13 (elm)

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bridge/google,cros-ec-anx7688.yaml        | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml b/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml
new file mode 100644
index 000000000000..9f7cc6b757cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/google,cros-ec-anx7688.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ChromeOS EC ANX7688 HDMI to DP Converter through Type-C Port
+
+maintainers:
+  - Nicolas Boichat <drinkcat@chromium.org>
+  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
+
+description: |
+  ChromeOS EC ANX7688 is a display bridge that converts HDMI 2.0 to
+  DisplayPort 1.3 Ultra-HDi (4096x2160p60). It is an Analogix ANX7688 chip
+  which is connected to and operated by the ChromeOS Embedded Controller
+  (See google,cros-ec.yaml). It is accessed using I2C tunneling through
+  the EC and therefore its node should be a child of an EC I2C tunnel node
+  (See google,cros-ec-i2c-tunnel.yaml).
+
+properties:
+  compatible:
+    const: google,cros-ec-anx7688
+
+  reg:
+    maxItems: 1
+    description: I2C address of the device.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Video port for HDMI input.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: USB Type-c connector.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c_tunnel_b: i2c-tunnel1 {
+        compatible = "google,cros-ec-i2c-tunnel";
+        google,remote-bus = <1>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        anx7688: anx7688@2c {
+            compatible = "google,cros-ec-anx7688";
+            reg = <0x2c>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                port@0 {
+                    reg = <0>;
+                    anx7688_in: endpoint {
+                        remote-endpoint = <&hdmi0_out>;
+                    };
+                };
+                port@1 {
+                    reg = <1>;
+                    anx7688_out: endpoint {
+                        remote-endpoint = <&typec_connector>;
+                    };
+                };
+            };
+        };
+    };
+
-- 
2.17.1

