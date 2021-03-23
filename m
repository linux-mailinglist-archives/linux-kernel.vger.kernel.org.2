Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB1834675F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhCWSPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbhCWSOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:14:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6FEC061763;
        Tue, 23 Mar 2021 11:14:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so11395132wmj.1;
        Tue, 23 Mar 2021 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZurC22z1J1Ck8IMbpKH5VToEe3ZGD8vbEOndO4vYk/M=;
        b=L1uQZdT2nxXw6hA2r1eVYObHVqQ+CLtezPNGjCYU1cxWF+5mYLk7UBe0xMW9HUZwsK
         oPERvbShcRlcjtxeOsHRTlmR7DTI7E1Y/b2qupRIaZCVk8hTMwUguX1kYzSzuR9kzRyf
         GXMgLTlSpvw0nDJDLe6W+ouO/NCLmoLHNX7jX+SuP5kgrxuM7dPtWi1iAB7uwiveIoip
         kwJZyN8Z9oXyqdYRN37yg47PoFK50741VqiAreJvTqGEJBROPkJoUxZ2UFuUNK6u2LW9
         XNY1ODm2+QFP/gL9Zk/L3Lz/DQZkJ6iFUUXv2hsxqbg4KhNAjqEMwfLk5XqjqmmtVGkL
         eSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZurC22z1J1Ck8IMbpKH5VToEe3ZGD8vbEOndO4vYk/M=;
        b=DBJ9mOFDxuS+tMhiLXEx3U5KlI/3tgiul1KSXjgnUknD6sXPc1AQ2L2jPenhL1cYJh
         yTEXkS5hd+62G6WcWDMzGGczg5hxHl9wGAox+LWlh1ba+iEzQYvppNOAncovy70M5e/j
         i2EkA15iuChXWEiaqm0ZZKgKdBfo0gzr2UknP1lrDWeRDaIrBtw/+fpD/xeInUBZChyW
         O29gDSGo3FzrYW93xN3hhsX/k3w7m9KK0eOMqt85tUi3D/Knjge280/PJFrCTl6X6MmS
         Du0Amf2xBwpkZ0hJIa6vo8n6xgnA/ldyjddXqyKafWwrcnwBtCgJq+F/vSaC5E4C0Exn
         2spw==
X-Gm-Message-State: AOAM530jUUkmUgQxrXgjoCdyfWbiJqDrSwFBe4lQUt6qLwUPuSal4nrm
        FX/YLoM0E4MXDX22HCRRXQk=
X-Google-Smtp-Source: ABdhPJwcVZw5OZy1TmDPh5C68tqaqZmMqSdoghYIyXbzNsLYuyrYPpnrb/6vWEGeoKunLrWeC/hm/w==
X-Received: by 2002:a1c:c206:: with SMTP id s6mr4495682wmf.77.1616523270258;
        Tue, 23 Mar 2021 11:14:30 -0700 (PDT)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700f54ecdc9d152bb4f.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:f54e:cdc9:d152:bb4f])
        by smtp.gmail.com with ESMTPSA id 21sm3484734wme.6.2021.03.23.11.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 11:14:29 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robert.foss@linaro.org, airlied@linux.ie, daniel@ffwll.ch,
        a.hajda@samsung.com, robh+dt@kernel.org, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 1/2] dt-bindings: display: bridge: Add documentation for LT8912B
Date:   Tue, 23 Mar 2021 19:14:22 +0100
Message-Id: <20210323181423.657926-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323181423.657926-1-adrien.grassein@gmail.com>
References: <20210323181423.657926-1-adrien.grassein@gmail.com>
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
index 8c44fd8fd85d..d9a125e5d295 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10526,6 +10526,11 @@ S:	Maintained
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

