Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A8F32CF8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbhCDJXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237426AbhCDJWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:22:39 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A24CC061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 01:21:59 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b15so6167176pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 01:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5rqX3oISXCRcG3SDYtERKxsOzMD4aRyBT5O+WgeLhRw=;
        b=fWkzNOJETrckU74xDmRsKDLDtsJLxQRGZNuaJLloXyBfmmfpWRU9fKQOeR5IHtITRL
         RSHzLQEOXWqDqQPPettK0WLYVFhqXce4dA7jn1I38GQbKfGhXp+jd7PmYZnY7P0x3cJ4
         CIVMXXW8j5EXbHQoXp0xDgwVlcyXB9umBP38g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5rqX3oISXCRcG3SDYtERKxsOzMD4aRyBT5O+WgeLhRw=;
        b=ZKv2O2JEl3bER56VsBW86AtpvLoiHc3BQkjrMy/gjYLow0cGFK3u4QZNZV6UdKOcXn
         NCnNe73WVyAvNoXmn5MQg4o6cs0ngIIe9/0wi78enhAxLgTfaAy+8K2u/z8yKkqo30Vg
         dKQat23oYCXZtHHn+/qouvl27QZ0S4iI6I5h0E3S8NH2HV9yjIrk6/sD6c3O5Y3zKMx8
         FKY71oXApyTKNOs59A0l880EKTA5/6OKNARqdRts9pQK7ESp4DvVZOKrpwbbAD11fP0d
         jgXRN7yoljfI404zxYdx9n5pr6Pb7q6hQMzgkCOqMJ9R5BOjnw5kpTgRmE/2UNPojZSs
         tZWg==
X-Gm-Message-State: AOAM531Q8NVolxOhr42Pwpddtam2/65wLDuO+EarEyYse2eJz95TzIHI
        VTdSrfDgqORFP0DKfaWf/Z2j2A==
X-Google-Smtp-Source: ABdhPJz881CCYGH780UwEgnivv1z/1mmBBu93Cn0k7MDpBPNgmSOsOVD5JVOIpZ0o8bHGdTrrbsmhA==
X-Received: by 2002:a17:90b:3809:: with SMTP id mq9mr3193659pjb.32.1614849718804;
        Thu, 04 Mar 2021 01:21:58 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([103.161.30.228])
        by smtp.gmail.com with ESMTPSA id 14sm27326981pfy.55.2021.03.04.01.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 01:21:58 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Robert Foss <robert.foss@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 1/2] dt-bindings: display: bridge: Add Chipone ICN6211 bindings
Date:   Thu,  4 Mar 2021 14:51:32 +0530
Message-Id: <20210304092133.21717-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ICN6211 is MIPI-DSI to RGB Converter bridge from Chipone.

It has a flexible configuration of MIPI DSI signal input and
produces RGB565, RGB666, RGB888 output format.

Add dt-bingings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4:
- fixed Laurent comments
- added regulators
- replace reset with EN
- fixed warnings pointed by Robert
Changes for v3:
- updated to new dt-bindings style

 .../display/bridge/chipone,icn6211.yaml       | 99 +++++++++++++++++++
 MAINTAINERS                                   |  5 +
 2 files changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
new file mode 100644
index 000000000000..62c3bd4cb28d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/chipone,icn6211.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Chipone ICN6211 MIPI-DSI to RGB Converter bridge
+
+maintainers:
+  - Jagan Teki <jagan@amarulasolutions.com>
+
+description: |
+  ICN6211 is MIPI-DSI to RGB Converter bridge from chipone.
+
+  It has a flexible configuration of MIPI DSI signal input and
+  produce RGB565, RGB666, RGB888 output format.
+
+properties:
+  compatible:
+    enum:
+      - chipone,icn6211
+
+  reg:
+    maxItems: 1
+    description: virtual channel number of a DSI peripheral
+
+  enable-gpios:
+    description: Bridge EN pin, chip is reset when EN is low.
+
+  vdd1-supply:
+    description: A 1.8V/2.5V/3.3V supply that power the MIPI RX.
+
+  vdd2-supply:
+    description: A 1.8V/2.5V/3.3V supply that power the PLL.
+
+  vdd3-supply:
+    description: A 1.8V/2.5V/3.3V supply that power the RGB output.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Video port for MIPI DSI input
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Video port for MIPI DPI output (panel or connector).
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - enable-gpios
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      bridge@0 {
+        compatible = "chipone,icn6211";
+        reg = <0>;
+        enable-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* LCD-RST: PL5 */
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          port@0 {
+            reg = <0>;
+
+            bridge_in_dsi: endpoint {
+              remote-endpoint = <&dsi_out_bridge>;
+            };
+          };
+
+          port@1 {
+            reg = <1>;
+
+            bridge_out_panel: endpoint {
+              remote-endpoint = <&panel_out_bridge>;
+            };
+          };
+        };
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 9d241b832aae..065cbdc889d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5529,6 +5529,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/boe,himax8279d.yaml
 F:	drivers/gpu/drm/panel/panel-boe-himax8279d.c
 
+DRM DRIVER FOR CHIPONE ICN6211 MIPI-DSI to RGB CONVERTER BRIDGE
+M:	Jagan Teki <jagan@amarulasolutions.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
+
 DRM DRIVER FOR FARADAY TVE200 TV ENCODER
 M:	Linus Walleij <linus.walleij@linaro.org>
 S:	Maintained
-- 
2.25.1

