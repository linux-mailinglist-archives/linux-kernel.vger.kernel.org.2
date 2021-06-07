Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D9739DC91
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhFGMgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:36:41 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:37470 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhFGMgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:36:40 -0400
Received: by mail-ej1-f45.google.com with SMTP id ce15so26383301ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 05:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZ6xGzQ1fYucC28Sy5XBR8mgxxxOu3bU8otSn6/V0po=;
        b=TgI4Cu5SPON4WNs1EmHW+248N49eyi9oRJH4ZlIuxlG//5BDF4jZq5zfVX1kOohkhM
         3TDpk0w5A3yDci5wci2Ku5lC7SZ9gYLd+AcMDjmmvT/bgVURerVXfGycHyz0aBFDHVtR
         T45m4BSgaI+uW9vAEOzchPgd3kvbE1nEzC/Y/+uja56reSfAtZTf97+dyEH/lykjZAqQ
         GPL6bPHfc09riFRm4BkQDNHHtF4TyUvkGGcGGE+hKhixazHamt5BQGjFFAxNLYahmmUF
         4+rQsenN6lMd5SmLDqW6Ay9ajIAT0cvHbLIHL70AwP1zqXitIxtw4HhfezZhhqafGuIc
         2S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZ6xGzQ1fYucC28Sy5XBR8mgxxxOu3bU8otSn6/V0po=;
        b=ZFUIW9Y5IpN49sbPiW3pX4DyB8rpcXpz653lndMKFy/AEKT0lP5lrCerp43ouTCyQ1
         ybUUYWVPueKo72uKc9T3N5PGCcyr8xd6ekt6vPTYZ6Wh2A5WsLFLlPTcaF8TsHw6I8iB
         H5kgmdxZCtWoujlhJxXdiNqIrv20D+X/LyUqm7w3zrTc+P/LLUxTHa+NU7+Baj78lktu
         2tla6zC+H7QLDtKzpLoz9oVXZz+PEWCkJ94oA4yBRsvhE2SIYPKRsYg4RgvzU2ViHoqx
         wiJLpiL5u6R3rcGe8regfqVztKXamMm0jUdUKOjz9wAZG61CFQKIUNjLUZIBt1ddXrfJ
         hb9A==
X-Gm-Message-State: AOAM5337LSCM3NAmwXkTDx68KcPUDJe1QL9sz/Z6U5vhUWlOC2iKmwe7
        QeYr1VwDew0924VjiBN98icZSA==
X-Google-Smtp-Source: ABdhPJy0qKoM8onF2du/9N/B1Bf2a42GUvc5I6XkDfEHIusaDxHNzd+/wr9IrGdeGr267mtTA/hAkw==
X-Received: by 2002:a17:906:318b:: with SMTP id 11mr17400125ejy.395.1623069215603;
        Mon, 07 Jun 2021 05:33:35 -0700 (PDT)
Received: from localhost.localdomain (dh207-96-76.xnet.hr. [88.207.96.76])
        by smtp.googlemail.com with ESMTPSA id f18sm6471000ejz.119.2021.06.07.05.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 05:33:35 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, lee.jones@linaro.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, jmp@epiphyte.org, pmenzel@molgen.mpg.de,
        buczek@molgen.mpg.de, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v6 5/6] dt-bindings: mfd: Add Delta TN48M CPLD drivers bindings
Date:   Mon,  7 Jun 2021 14:33:16 +0200
Message-Id: <20210607123317.3242031-5-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210607123317.3242031-1-robert.marko@sartura.hr>
References: <20210607123317.3242031-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documents for the Delta TN48M CPLD drivers.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v3:
* Include bindings for reset driver

Changes in v2:
* Implement MFD as a simple I2C MFD
* Add GPIO bindings as separate

 .../bindings/gpio/delta,tn48m-gpio.yaml       | 42 +++++++++
 .../bindings/mfd/delta,tn48m-cpld.yaml        | 90 +++++++++++++++++++
 .../bindings/reset/delta,tn48m-reset.yaml     | 35 ++++++++
 3 files changed, 167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/delta,tn48m-reset.yaml

diff --git a/Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml b/Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
new file mode 100644
index 000000000000..aca646aecb12
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/delta,tn48m-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Delta Networks TN48M CPLD GPIO controller
+
+maintainers:
+  - Robert Marko <robert.marko@sartura.hr>
+
+description: |
+  This module is part of the Delta TN48M multi-function device. For more
+  details see ../mfd/delta,tn48m-cpld.yaml.
+
+  GPIO controller module provides GPIO-s for the SFP slots.
+  It is split into 3 controllers, one output only for the SFP TX disable
+  pins, one input only for the SFP present pins and one input only for
+  the SFP LOS pins.
+
+properties:
+  compatible:
+    enum:
+      - delta,tn48m-gpio-sfp-tx-disable
+      - delta,tn48m-gpio-sfp-present
+      - delta,tn48m-gpio-sfp-los
+
+  reg:
+    maxItems: 1
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+required:
+  - compatible
+  - reg
+  - "#gpio-cells"
+  - gpio-controller
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml b/Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
new file mode 100644
index 000000000000..2c6e2adf73ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/delta,tn48m-cpld.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Delta Networks TN48M CPLD controller
+
+maintainers:
+  - Robert Marko <robert.marko@sartura.hr>
+
+description: |
+  Lattice CPLD onboard the TN48M switches is used for system
+  management.
+
+  It provides information about the hardware model, revision,
+  PSU status etc.
+
+  It is also being used as a GPIO expander for the SFP slots and
+  reset controller for the switch MAC-s and other peripherals.
+
+properties:
+  compatible:
+    const: delta,tn48m-cpld
+
+  reg:
+    description:
+      I2C device address.
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+patternProperties:
+  "^gpio(@[0-9a-f]+)?$":
+    $ref: ../gpio/delta,tn48m-gpio.yaml
+
+  "^reset-controller?$":
+    $ref: ../reset/delta,tn48m-reset.yaml
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cpld@41 {
+            compatible = "delta,tn48m-cpld";
+            reg = <0x41>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            gpio@31 {
+                compatible = "delta,tn48m-gpio-sfp-tx-disable";
+                reg = <0x31>;
+                gpio-controller;
+                #gpio-cells = <2>;
+            };
+
+            gpio@3a {
+                compatible = "delta,tn48m-gpio-sfp-present";
+                reg = <0x3a>;
+                gpio-controller;
+                #gpio-cells = <2>;
+            };
+
+            gpio@40 {
+                compatible = "delta,tn48m-gpio-sfp-los";
+                reg = <0x40>;
+                gpio-controller;
+                #gpio-cells = <2>;
+            };
+
+            reset-controller {
+              compatible = "delta,tn48m-reset";
+              #reset-cells = <1>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/reset/delta,tn48m-reset.yaml b/Documentation/devicetree/bindings/reset/delta,tn48m-reset.yaml
new file mode 100644
index 000000000000..0e5ee8decc0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/delta,tn48m-reset.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/delta,tn48m-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Delta Networks TN48M CPLD reset controller
+
+maintainers:
+  - Robert Marko <robert.marko@sartura.hr>
+
+description: |
+  This module is part of the Delta TN48M multi-function device. For more
+  details see ../mfd/delta,tn48m-cpld.yaml.
+
+  Reset controller modules provides resets for the following:
+  * 88F7040 SoC
+  * 88F6820 SoC
+  * 98DX3265 switch MAC-s
+  * 88E1680 PHY-s
+  * 88E1512 PHY
+  * PoE PSE controller
+
+properties:
+  compatible:
+    const: delta,tn48m-reset
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - "#reset-cells"
+
+additionalProperties: false
-- 
2.31.1

