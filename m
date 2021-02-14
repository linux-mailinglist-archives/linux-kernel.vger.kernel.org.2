Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D585A31B1B4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 18:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhBNRy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 12:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhBNRyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 12:54:19 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA438C0613D6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 09:53:39 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d26so2829534pfn.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 09:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/pwXbJYXJ/XEybu75dwMk2OD1xq/y6MntgB8eUFgtCM=;
        b=Ke27OPgqd7Xm+2DvA6biiNBQqcB7WOB1Pf1acOXZZffpCWn2ZP+qJcXh9ksmIPNiI8
         0YzBEqDP40R0edRJQWbMtX7+JcDhtlU7oSs0NiQOvoROCILKOf7iqQ6xdJAPwS6KnNnT
         b5tdvxLFJHwh2nAf+0I197VKBJDW7uxR58LI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/pwXbJYXJ/XEybu75dwMk2OD1xq/y6MntgB8eUFgtCM=;
        b=Ksm0jMk1OuINAyKvKuZzr2aPFZ4B2RZBS1fzOL0esYKPjyFEukbnbwrhS+sLTfXU2q
         yCRy7SS+9S3aRclqpiU7dFMmferm9GtEtFFqgAJCQ0M51UWr1t29z1JBKzhTVIVKfhwx
         htH3JHp9LXbCw3xgH1jbBPAtsqm3nktcOTXW6UjMA7ZkwHqD9OHVmHGc7/p+v4gubSk7
         YXEjzlza45bFBiS314dx/bcBag7eySFA3PbxuBgDl26IE01oelmiPOEnrpey4x2xbVJy
         0Dd0AnoBJ2vvx0hi4gRvd7NjYD8ppsIyPHNViFk+BA/mDB1t3irFIQU0y6HqWkowGtew
         rJ9g==
X-Gm-Message-State: AOAM532YjIZZRTBeIwLw46GnoRUebR+1IibFYdsDli8tkrJjjoLpjqFO
        45mBPXMF74JiKXTnRYWBdJS4Zg==
X-Google-Smtp-Source: ABdhPJxPpuCp8VeWMJFfHNYkSYT/BDlow0ANd3LBdQeBXx9d/b6U2FYcI1KwPG27rotwu9YDzN/BNA==
X-Received: by 2002:aa7:9549:0:b029:1df:14f8:1e2d with SMTP id w9-20020aa795490000b02901df14f81e2dmr12043592pfq.55.1613325219228;
        Sun, 14 Feb 2021 09:53:39 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([45.249.78.214])
        by smtp.gmail.com with ESMTPSA id h17sm15094443pfr.200.2021.02.14.09.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 09:53:38 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 1/2] dt-bindings: display: bridge: Add bindings for Chipone ICN6211
Date:   Sun, 14 Feb 2021 23:22:10 +0530
Message-Id: <20210214175211.105107-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ICN6211 is MIPI-DSI to RGB Convertor bridge from Chipone.

It has a flexible configuration of MIPI DSI signal input and
produce RGB565, RGB666, RGB888 output format.

Add dt-bingings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- updated to new dt-bindings style

 .../display/bridge/chipone,icn6211.yaml       | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
new file mode 100644
index 000000000000..13764f13fe46
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
@@ -0,0 +1,90 @@
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
+  ICN6211 is MIPI-DSI to RGB Convertor bridge from chipone.
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
+  reset-gpios:
+    description: GPIO connected for the reset pin
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
+  - reset-gpios
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
+        reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* LCD-RST: PL5 */
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          bridge_in: port@0 {
+            reg = <0>;
+
+            bridge_out_dsi: endpoint {
+              remote-endpoint = <&dsi_out_bridge>;
+            };
+          };
+
+          bridge_out: port@1 {
+            reg = <1>;
+
+            bridge_out_panel: endpoint {
+              remote-endpoint = <&panel_out_bridge>;
+            };
+          };
+        };
+      };
+    };
-- 
2.25.1

