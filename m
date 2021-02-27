Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19093326ECE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 20:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhB0Ttv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 14:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhB0Tt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 14:49:27 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF76C061756;
        Sat, 27 Feb 2021 11:48:46 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l22so428079wme.1;
        Sat, 27 Feb 2021 11:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3zBUcE8OjRKKFCJPCaa9dvaEFr+ZbWy6syWrW42zrkM=;
        b=ElpvCLN33e1rbeNfDApJ1zLinkN0r+DOzXBhsWyUYT7IeCwVS8VvZxawLzKZVb/VU2
         PPWjQVT0P4WZtluJhgCUFN8T4f4Euz7RNekVpUbeOxJfYf80kxRa1gYQVLb5BAOwGXbF
         H4KU9QfQ4I5WxK0PulbFVfiXo7CeNJ0pgz/4k0gYNDVQeZPmiNVssBJzr8fZmu1jSxwJ
         +0e3BeG0t0vQaBffyKvDLdkDQdTQPbzhIol49wCbgXUAsYREFtYkDRfHICw0N2nAYn1I
         lBGUcm8b1w2HCW59t7GqLb/cgVsPAuwIYSdgGM5OUTAJ4KATNTkfRgunfTUYSUmDMlBF
         9AgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3zBUcE8OjRKKFCJPCaa9dvaEFr+ZbWy6syWrW42zrkM=;
        b=WBuVAQjEbi7N6WkfhMALXLEfKqPz+5RwgMHcpFP4OFIf2cHJZoLQK5tUW507rw5XPC
         50IJGy2o24J2QPXovBA1xO4gC9hljP7oUDiJQfVDCUOZf2N6R+sRX6FunwB9iQa8zY0z
         tmznZu4O5kgqzmy5eOXLq9vnYyuic7FKkaiSL4IvmXLUZ56DcRiQvJr4on/bn0A1z3wT
         Ku50TiEJVBlL0ThUPIVMp8ihDBm4QpmzWbPIQJxLdophVyFr66oqCbaT09MQrmlRMZpW
         63Bpbac2PLXL10+Y6yfWjCo4etKVWbi34B4UfkNOzae2eLD4N4FrMaMQvoX0eeHrtFFx
         1Eug==
X-Gm-Message-State: AOAM531C12c15dmmhqWRgom+8bpw/2yP//hHJBhfJml4YGpPVd65pL0b
        RTFeQlMiAZdhPFIef64JOYI=
X-Google-Smtp-Source: ABdhPJzcJEXURqsycE6wWUh8pCHWGTK8K6WYqwE3tFWUrfI4Dy8SosuMEG4rTXkMvh7khYbYvORHhw==
X-Received: by 2002:a05:600c:2048:: with SMTP id p8mr8590325wmg.170.1614455325418;
        Sat, 27 Feb 2021 11:48:45 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700289c166d32b9da85.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:289c:166d:32b9:da85])
        by smtp.gmail.com with ESMTPSA id f9sm12453123wro.77.2021.02.27.11.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 11:48:45 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robert.foss@linaro.org, airlied@linux.ie, daniel@ffwll.ch,
        a.hajda@samsung.com, robh+dt@kernel.org, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/2] dt-bindings: display: bridge: Add documentation for LT8912B
Date:   Sat, 27 Feb 2021 20:48:35 +0100
Message-Id: <20210227194836.1848753-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210227194836.1848753-1-adrien.grassein@gmail.com>
References: <20210227194836.1848753-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lontium LT8912B is a DSI to HDMI bridge.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../display/bridge/lontium,lt8912b.yaml       | 102 ++++++++++++++++++
 MAINTAINERS                                   |   5 +
 2 files changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
new file mode 100644
index 000000000000..735d0233a7d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/lontium,lt8912b.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lontium LT8912B MIPI to HDMI Bridge
+
+maintainers:
+  - Adrien Grassein <adrien.grassein@gmail.com>
+
+description: |
+  The LT8912B is a bridge device which convert DSI to HDMI
+
+properties:
+  compatible:
+    enum:
+      - lontium,lt8912b
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO connected to active high RESET pin.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Primary MIPI port for MIPI input
+
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes: true
+
+            required:
+              - data-lanes
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: |
+          HDMI port, should be connected to a node compatible with the
+          hdmi-connector binding.
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
+    i2c4 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      hdmi-bridge@48 {
+        compatible = "lontium,lt8912b";
+        reg = <0x48>;
+        reset-gpios = <&max7323 0 GPIO_ACTIVE_LOW>;
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          port@0 {
+            reg = <0>;
+
+            hdmi_out_in: endpoint {
+              data-lanes = <0 1 2 3>;
+              remote-endpoint = <&mipi_dsi_out>;
+            };
+          };
+
+          port@1 {
+              reg = <1>;
+
+              endpoint {
+                  remote-endpoint = <&hdmi_in>;
+              };
+          };
+        };
+      };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 16ada1a4b751..6366b8eac3f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10460,6 +10460,11 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
 F:	drivers/hid/hid-lg-g15.c
 
+LONTIUM LT8912B MIPI TO HDMI BRIDGE
+M:	Adrien Grassein <adrien.grassein@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
+
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
 M:	Sathya Prakash <sathya.prakash@broadcom.com>
 M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
-- 
2.25.1

