Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA2532F41E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCETjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhCETjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:39:12 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4297DC06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 11:39:02 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id q204so2761045pfq.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 11:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=scaopPjHqYyO9XqSV5iNt3e946s1X2u5SubyWS47cB4=;
        b=IjggSM881BXAAf+eLc0zJ73YYk8+OOKsk6V9RBdfKsr+qm1qT9hRHMZA/We0Hk+oEW
         KrMVbWP0T4eogX3XonoffgNVP/egSJjZO9hvXy5lt+I3tnhSVSh7He1D4fujvvICwWMY
         PWudEZ27lf0Yg0ZJYME88k/N0O1KZnHSiPR2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=scaopPjHqYyO9XqSV5iNt3e946s1X2u5SubyWS47cB4=;
        b=VcyAq4vKeRFXuuxJFggy3K4GrkT6Kv1OEnbVGG8iNDVpLVUoksS5rBqibDpLgR27vN
         0MI94qpgJTyl5WHtS7MlFxF96OC/SD0JytuHzwFHgBxlx0ASdT8q2eVGHiqHwjql3QUP
         +yAflgZTTAPqpaXwoBZjrTH3czE1umDvZqwy1zZKI5tKS086vxb2xcO+4iVuoQ7/cZLO
         fgwNWeLH8o7MyoFlQemQriUlTHuaS3r/tZkKaDL8NYuzjyLFP97ULXZT/1JzgPSxnMXW
         Xj3H94QKQyd/3gZlO1GDg76ble0thylbLu6yWw338nPVT2nbZFL8IP8Pwx8B58/PvO0/
         Ivqg==
X-Gm-Message-State: AOAM532cCpwDVRi6x6aPGVTZd1hl6SaeZvLYjK2S1FkTGkrv8URVQbgg
        jATH8PtvXA2wT/+1mXUA0JeJkQ==
X-Google-Smtp-Source: ABdhPJz7GnJlyRiFJaqnjCYdTcllkXIGTQ6sVqFE7OVOMN9GCvX2fj+eQD9qs/8Xn6HzSgth7LfHYw==
X-Received: by 2002:a65:6a48:: with SMTP id o8mr9919171pgu.424.1614973141813;
        Fri, 05 Mar 2021 11:39:01 -0800 (PST)
Received: from localhost ([2620:15c:202:1:2878:25d1:94cb:a547])
        by smtp.gmail.com with UTF8SMTPSA id w27sm3306671pfq.105.2021.03.05.11.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 11:39:01 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Peter Chen <peter.chen@nxp.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        linux-usb@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v6 1/5] dt-bindings: usb: Add binding for Realtek RTS5411 hub controller
Date:   Fri,  5 Mar 2021 11:38:49 -0800
Message-Id: <20210305113832.v6.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210305193853.2040456-1-mka@chromium.org>
References: <20210305193853.2040456-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Realtek RTS5411 is a USB 3.0 hub controller with 4 ports.

This initial version of the binding only describes USB related
aspects of the RTS5411, it does not cover the option of
connecting the controller as an i2c slave.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v6:
- Realtek binding instead of generic onboard_usb_hub
- added 'companion-hub' property
- added reference to 'usb-device.yaml'
- 'fixed' indentation of compatible entries to keep yamllint happy
- added 'additionalProperties' entry
- updated commit message

Changes in v5:
- updated 'title'
- only use standard USB compatible strings
- deleted 'usb_hub' node
- renamed 'usb_controller' node to 'usb-controller'
- removed labels from USB nodes
- added 'vdd-supply' to USB nodes

Changes in v4:
- none

Changes in v3:
- updated commit message
- removed recursive reference to $self
- adjusted 'compatible' definition to support multiple entries
- changed USB controller phandle to be a node

Changes in v2:
- removed 'wakeup-source' and 'power-off-in-suspend' properties
- consistently use spaces for indentation in example

 .../bindings/usb/realtek,rts5411.yaml         | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/realtek,rts5411.yaml

diff --git a/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
new file mode 100644
index 000000000000..00e9b3d44583
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/realtek,rts5411.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binding for the Realtek RTS5411 USB 3.0 hub controller
+
+maintainers:
+  - Matthias Kaehlcke <mka@chromium.org>
+
+allOf:
+  - $ref: usb-device.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - usbbda,5411
+          - usbbda,411
+
+  vdd-supply:
+    description:
+      phandle to the regulator that provides power to the hub.
+
+  companion-hub:
+    description:
+      phandle to the companion hub on the controller.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    usb-controller {
+        dr_mode = "host";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* 2.0 hub on port 1 */
+        hub_2_0: hub@1 {
+            compatible = "usbbda,5411";
+            reg = <1>;
+            vdd-supply = <&pp3300_hub>;
+            companion-hub = <&hub_3_0>;
+        };
+
+        /* 3.0 hub on port 2 */
+        hub_3_0: hub@2 {
+            compatible = "usbbda,411";
+            reg = <2>;
+            vdd-supply = <&pp3300_hub>;
+            companion-hub = <&hub_2_0>;
+        };
+    };
-- 
2.30.1.766.gb4fecdf3b7-goog

