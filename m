Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A320F443433
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbhKBQ77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbhKBQ7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:59:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A8DC061226
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:57:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o8so6419451edc.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zSwjERU+mHTwJoAySbsl/JOKehwDXt/v3TeUwkBDMGI=;
        b=py6HTfCTnDkxtn0ykNf5PEKoW3vdv0nbW3B/DaPT/FszWBTXuWbR58G2VPsQUfFSOj
         bQ3A77X+X5IuwYyz/5A1wisFR++fqIbdT3b9xnKxXruGPRDwkoLd+qS4g1P3R5YaUhV5
         HtZObW1SSSjYqFI1NhXi7ZrBhDh9dIWGYHiAuXYgHOV7B+8ju7KFcsjJc4wurjuDW3PP
         l0GXq6Gt3dx6PAI5hR10cAs1i8rh9I9D7j9/v/laZ1cDGSBdjeGmuB/ISxxXoiIBB4OF
         QWFqAvQNdWVZkz3C7pkP0PODFh4lbepsaNhe0BrBt6UfDsoABaPsXR1tc5SAGspveAqC
         4hiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSwjERU+mHTwJoAySbsl/JOKehwDXt/v3TeUwkBDMGI=;
        b=EVALMbheIFFyAPSn5TwAEicFnD+JDRpqmLPa67M7epYRaagEhnH4274pEWK9kfbRJ3
         lK555BrYOcxzHdxNvLwxP5Kht8O4L5YShSGpFWUlDuQMcVKLMfEhwoG5XK1h0cUPA+aP
         gKLyGf6IBbM0zGLzYyY+M9ocVPMOOBzqsKxgAabaaqVqGKUqVui7PnsXjT4LEj1uw9VN
         KvDf8Di8jdjR46PWEGUrMfJbPyGor9EK4xO+HewHCESt/1A4YyLTK4rQSjPhAJN5KMHe
         eHBmgOl04PVvdj3OIqYfzS1HYneZNAxynTVmCLN3QmKK/lXrdS3bkILRalDeMaxuojwA
         pTnw==
X-Gm-Message-State: AOAM530ECJn46lZRMO2KBUfhFNWTBXHHouOl55yRqb+HBrbws/R/lkym
        NAN0oCPqTrXSN4iCKK8qnTNZ8A==
X-Google-Smtp-Source: ABdhPJx4qaQ02Go3aooNMsU/M22JRPUOhGKnkGtsXxFgQ5IrjTwm89VBTgXAGrOZfRWHnRresPVkrw==
X-Received: by 2002:a17:907:7752:: with SMTP id kx18mr46696577ejc.276.1635872231070;
        Tue, 02 Nov 2021 09:57:11 -0700 (PDT)
Received: from fedora.. (cpezg-94-253-144-183-cbl.xnet.hr. [94.253.144.183])
        by smtp.googlemail.com with ESMTPSA id i22sm10816297edu.93.2021.11.02.09.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:57:10 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, lee.jones@linaro.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch,
        andy.shevchenko@gmail.com
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v7 5/6] dt-bindings: mfd: Add Delta TN48M CPLD drivers bindings
Date:   Tue,  2 Nov 2021 17:56:56 +0100
Message-Id: <20211102165657.3428995-5-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211102165657.3428995-1-robert.marko@sartura.hr>
References: <20211102165657.3428995-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documents for the Delta TN48M CPLD drivers.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v7:
* Update bindings to reflect driver updates

Changes in v3:
* Include bindings for reset driver

Changes in v2:
* Implement MFD as a simple I2C MFD
* Add GPIO bindings as separate
---
 .../bindings/gpio/delta,tn48m-gpio.yaml       | 39 ++++++++
 .../bindings/mfd/delta,tn48m-cpld.yaml        | 90 +++++++++++++++++++
 .../bindings/reset/delta,tn48m-reset.yaml     | 35 ++++++++
 3 files changed, 164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/delta,tn48m-reset.yaml

diff --git a/Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml b/Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
new file mode 100644
index 000000000000..e3e668a12091
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
@@ -0,0 +1,39 @@
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
+  Delta TN48M has an onboard Lattice CPLD that is used as an GPIO expander.
+  It provides 12 pins in total, they are input-only or ouput-only type.
+
+properties:
+  compatible:
+    enum:
+      - delta,tn48m-gpo
+      - delta,tn48m-gpi
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
index 000000000000..f6967c1f6235
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
+  It is also being used as a GPIO expander and reset controller
+  for the switch MAC-s and other peripherals.
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
+                compatible = "delta,tn48m-gpo";
+                reg = <0x31>;
+                gpio-controller;
+                #gpio-cells = <2>;
+            };
+
+            gpio@3a {
+                compatible = "delta,tn48m-gpi";
+                reg = <0x3a>;
+                gpio-controller;
+                #gpio-cells = <2>;
+            };
+
+            gpio@40 {
+                compatible = "delta,tn48m-gpi";
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
2.33.1

