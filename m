Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11B138E63A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhEXMHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhEXMHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:07:17 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8815C06138A
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 05:05:49 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x7so8671506wrt.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 05:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSikriGY8WxnD/HvwIHFkiIuj1QNzjOxk1k9wUWdYDc=;
        b=kdjX4LaXBUMzusDS7bfBuzNlSGjp91t5RXFOlJq2aJFBnw/x01MzTS/KIPmW4zm6mh
         Jpi6GIinJN6feaBAML0vAM7CnfDijG1Xc+A3ekhCWSM7z1EYrEMmQ8pOjy+t4eJxAA3J
         J4uYpF48/PRKBN4/rJFVlEfoEliqJCvpTrcD+b3+m5eNDLGG1J1eQR+zPJ5swOqTnhk3
         40VqKjQGIn4uKppjHlde0GJqHMh4QihNNuaFPiSh8vGqzictkatP8qDhdSKvEDic4d+K
         uZ1t3zUeNyICHiwKVYpljn8E1giFPsZYu+SSNs6zUKuWoUBqksQyTaMWIF1uSjr221mr
         bKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSikriGY8WxnD/HvwIHFkiIuj1QNzjOxk1k9wUWdYDc=;
        b=HrmQcykaR8iqZ4vG4WmpjsEIbTNN9OeoiGkHf98ikroyvkQzxD2/IHt7aeVs6h9PLP
         CwMIAWPUqULcjHx8rVfP7pwxvSS+WlrNgF8dYsl16/T8XWaNa6x2u14fcebdHaIb8LzT
         gBUsn0fngiRPnaWm4Lqgn5a4v1VHwcTKHuiYk7nXuXWm/jypDAO2LTdsr8+Y8FXoBVOA
         AV3FgPIPGpRq0qBge1DnjtReYroEee2ZcT0s7aqisBES8cQu6K1nLw+PERV4a3KopFm3
         Qd42XAQWiV0sicXTFin7IdWNOsMkmffPhGm2vSKQyWT0PYpQjzsL8I3T139cMJ0swjpf
         e5jQ==
X-Gm-Message-State: AOAM533lxQpfjxJCFKDgEYm7y5WqvMN3P/INkrkx/Zmc54fvaARO4I1V
        IcYvXxmGIsqtxYIofiKh3YCf0g==
X-Google-Smtp-Source: ABdhPJxsxqXT3b6O4xVF+Wt+m1QGBD7G4gRM4JPeXkZBtgChfsei9VrOJKPzjeYgrsngJ7fIbZ3VYg==
X-Received: by 2002:a05:6000:1145:: with SMTP id d5mr22270356wrx.404.1621857948390;
        Mon, 24 May 2021 05:05:48 -0700 (PDT)
Received: from localhost.localdomain ([188.252.220.224])
        by smtp.googlemail.com with ESMTPSA id b10sm14342856wrr.27.2021.05.24.05.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 05:05:48 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, lee.jones@linaro.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, jmp@epiphyte.org, pmenzel@molgen.mpg.de,
        buczek@molgen.mpg.de, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 3/4] dt-bindings: mfd: Add Delta TN48M CPLD drivers bindings
Date:   Mon, 24 May 2021 14:05:38 +0200
Message-Id: <20210524120539.3267145-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524120539.3267145-1-robert.marko@sartura.hr>
References: <20210524120539.3267145-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documents for the Delta TN48M CPLD drivers.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Implement MFD as a simple I2C MFD
* Add GPIO bindings as separate

 .../bindings/gpio/delta,tn48m-gpio.yaml       | 42 ++++++++++
 .../bindings/mfd/delta,tn48m-cpld.yaml        | 81 +++++++++++++++++++
 2 files changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml

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
index 000000000000..055e09129f86
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
@@ -0,0 +1,81 @@
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
+  It is also being used as a GPIO expander for the SFP slots.
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
+        };
+    };
-- 
2.31.1

