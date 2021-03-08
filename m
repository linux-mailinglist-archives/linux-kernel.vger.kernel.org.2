Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16E3330D1A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhCHMGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhCHMGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:06:01 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CF1C06175F;
        Mon,  8 Mar 2021 04:06:00 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so3642894wmj.1;
        Mon, 08 Mar 2021 04:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cM2++3M/eSEEuJa4YLSTVFheZ1nQSnnZ10I2ItxhVuk=;
        b=PUE4zEyZW80Drx5CxrktnlR2mjH9p2cgwpHRmcZjxtSY1LyJvOs9MM5exCJ6oVkjyS
         5aXj/C1t5/m16Zp0kJjChV2FfZj7P3yJSUYB/EICdRiwhQUInKzcLUFnaa1m9b9sGLkb
         KlEJxOuEOgMZUHJ5ksvSlDd5/TFv38RK+uKBiDSD2U60d6bAXIJNMiHaVmFsjHA+DGD4
         YD13n8M2XtC4ls7m8ffT8zFUYaCUYe/odBUoLG5PiI7gapbpmQAy8YtXPWL8fNFyVGqx
         LW1kCvXqUkX/6OplZwA7jb6m+C+4LY7JkJkPSR+Fa3A/sSPDtaYCyniT/eouDhAbR2fp
         96OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cM2++3M/eSEEuJa4YLSTVFheZ1nQSnnZ10I2ItxhVuk=;
        b=a+pRdlsrUYyc0HYHO1n0gAMKEAIl1R8v2Oj3wOTXSfointnXM/7gAerMuR73xTIhCj
         3OeiIHk8LODoHfXglrLJneoFo8gaVzdCeftFISo/tKbVYzbTuVgE99vzxm4O6bBKQ9yu
         53wbJNDWf28l+yNUi/L/pVj44Wm1hE8o9qFU6uABbOcjNPT5UtjBY3RExWX7DT40b2Vc
         Igra0SeFQIqmYO56vhns0L2+veDbsqkTPTDYsJXUsJpq8MUaLHygSPQ786lAcCx9OjyB
         SVGsDxu3tArHqeSz3XDZ/prtNKrd1TAr8/EUwP2gr7QPIOlSWy+HZkPNUBW1/brlMhXj
         ZYZw==
X-Gm-Message-State: AOAM530PUi4Rfwx1CVBuMn9xAp1UuM1doC8SZrdkGVyre4hzMCiYcmbx
        dbFJO3qSaQ3WsnyfAVvnNwU=
X-Google-Smtp-Source: ABdhPJwXjMy3Srs/pdETswKGAsjrXKUht4cVZ2laZ3oyV24mkSCSGdxt6ZwMr3ZCZzLN51aB5Ijf8w==
X-Received: by 2002:a05:600c:350e:: with SMTP id h14mr6334144wmq.4.1615205159581;
        Mon, 08 Mar 2021 04:05:59 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270095bc7625808eade0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:95bc:7625:808e:ade0])
        by smtp.gmail.com with ESMTPSA id r7sm19031803wre.25.2021.03.08.04.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 04:05:59 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robert.foss@linaro.org, airlied@linux.ie, daniel@ffwll.ch,
        a.hajda@samsung.com, robh+dt@kernel.org, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/2] dt-bindings: display: bridge: Add documentation for LT8912B
Date:   Mon,  8 Mar 2021 13:05:54 +0100
Message-Id: <20210308120555.252524-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308120555.252524-1-adrien.grassein@gmail.com>
References: <20210308120555.252524-1-adrien.grassein@gmail.com>
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
index 9095d182deaf..719f633c8a28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10462,6 +10462,11 @@ S:	Maintained
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

