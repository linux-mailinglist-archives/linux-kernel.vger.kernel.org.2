Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2C430D3F5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 08:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhBCHN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 02:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhBCHN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 02:13:56 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39786C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 23:13:15 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id q131so16044508pfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 23:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pPNBJfle3Xurh2yorg+OKGACnBT1+DmSPrBjPjKSHHs=;
        b=cV0gh2AOAaP7lDN2Mk79C8+DGnq+j39uYoObpW2dr7VN4nRzXFN+6x9SUB8U5z9pGN
         grJK/V8SmM7joZAcz2a3ZE9ZCxKeo8OPSYDR+l/qJZ8EI/AVMqtmrF6N2zbQ/7HEvoDx
         KQsZIZc56L6oxce83DQxr9Xdcq7LmX5jMIGQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pPNBJfle3Xurh2yorg+OKGACnBT1+DmSPrBjPjKSHHs=;
        b=q66ofJmo3f+to1QnkWuICsIv5q766sXDNATqUDhDeqGTwZn0F453rIepE4BsS1UjIm
         vuw8jYrhf2+GImMSyQvUkO70LYpn0kKgbrUkroxF6NZa8HTmEe0oFqLxATSz0sprYwK4
         /6UcZsX88dnaMMSMJhwgcFl52AqNxAL2MSrGHYaAyOzozmTaRmk2tUv6O9MCV5m+vToq
         uZoR3sgXCIe9coeX0yfwWdm/dm+1H9TRx6WFYgHFHoFdOHVQBCIGyEMyfHwaSWA7Q7M8
         M6D8QEzubEjVAUQNy53qkMXrv4jVJTloMPK8Q3G2Jd4q4WoafdLwmZduV0gpna3wjjR8
         hMmg==
X-Gm-Message-State: AOAM530nD/PB9pVlU60/1oSFQqJSZ48Y7VeoAe8uTXTo2mZn/0rR7ue/
        vrhLMUV6L61nN1xg+KUufFRtjg==
X-Google-Smtp-Source: ABdhPJzQds6f03maiq8U5pfTS4lCHPI5e1ATkEErS6oAKDMSvm64fuBER4Mq1HWlBQtvEuqJPPhQ0A==
X-Received: by 2002:a62:bd05:0:b029:1ab:6d2:5edf with SMTP id a5-20020a62bd050000b02901ab06d25edfmr1920622pff.32.1612336394754;
        Tue, 02 Feb 2021 23:13:14 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([45.249.78.214])
        by smtp.gmail.com with ESMTPSA id c19sm1105823pfc.122.2021.02.02.23.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 23:13:14 -0800 (PST)
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
Subject: [PATCH v2 1/2] dt-bindings: display: bridge: Add documentation for SN65DSI84
Date:   Wed,  3 Feb 2021 12:42:55 +0530
Message-Id: <20210203071256.42050-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SN65DSI84 is a Single Channel DSI to Dual-link LVDS bridge from
Texas Instruments.

SN65DSI83, SN65DSI85 are variants of the same family of bridge
controllers.

Right now the bridge driver is supporting a single link, dual-link
support requires to initiate I2C Channel B registers, so dt-bindings
documented with single link LVDS.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

 .../bindings/display/bridge/ti,sn65dsi84.yaml | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,sn65dsi84.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi84.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi84.yaml
new file mode 100644
index 000000000000..891382a76c1a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi84.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/ti,sn65dsi84.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI SN65DSI84 MIPI DSI to LVDS bridge bindings
+
+maintainers:
+  - Jagan Teki <jagan@amarulasolutions.com>
+
+description: |
+  The SN65DSI84 DSI to FlatLink bridge features a single channel MIPI D-PHY receiver
+  front-end configuration with 4 lanes per channel operating at 1 Gbps per lanes.
+  The bridge decodes MIPI DSI 18bpp RGB666 and 240bpp RG888 packets and converts
+  the formatted video data stream to a FlatLink compatible LVDS output operating
+  at pixel clocks operating from 25 MHx to 154 MHz, offering a Dual-Link LVDS,
+  Single-Link LVDS interface with four data lanes per link.
+
+  https://www.ti.com/product/SN65DSI84
+
+properties:
+  compatible:
+    const: ti,sn65dsi84
+
+  reg:
+    maxItems: 1
+    description: i2c address of the bridge, 0x2c
+
+  enable-gpios:
+    maxItems: 1
+    description: GPIO specifier for bridge enable pin (active high).
+
+  ports:
+    type: object
+    description:
+      A node containing input and output port nodes with endpoint definitions
+      as documented in
+      Documentation/devicetree/bindings/media/video-interfaces.txt
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+      port@0:
+        type: object
+        description: |
+          DSI Input. The remote endpoint phandle should be a
+          reference to a valid mipi_dsi_host device node.
+
+      port@1:
+        type: object
+        description: |
+          Video port for LVDS output (panel or connector).
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
+       #address-cells = <1>;
+       #size-cells = <0>;
+
+       ports {
+           #address-cells = <1>;
+           #size-cells = <0>;
+
+           port@0 {
+               reg = <0>;
+               dsi_in: endpoint {
+                   remote-endpoint = <&ltdc_ep0_out>;
+               };
+           };
+
+           port@1 {
+               reg = <1>;
+               dsi_out: endpoint {
+                   remote-endpoint = <&bridge_in>;
+                   data-lanes = <0 1>;
+               };
+           };
+       };
+    };
+
+    i2c6 {
+       #address-cells = <1>;
+       #size-cells = <0>;
+
+       bridge@2c {
+           compatible = "ti,sn65dsi84";
+           reg = <0x2c>;
+           enable-gpios = <&gpiof 15 GPIO_ACTIVE_HIGH>;
+
+           ports {
+               #address-cells = <1>;
+               #size-cells = <0>;
+
+               port@0 {
+                   reg = <0>;
+                   bridge_in: endpoint {
+                        remote-endpoint = <&dsi_out>;
+                   };
+               };
+
+               port@1 {
+                   reg = <1>;
+                   bridge_out: endpoint {
+                        remote-endpoint = <&panel_in_lvds>;
+                   };
+               };
+           };
+       };
+    };
-- 
2.25.1

