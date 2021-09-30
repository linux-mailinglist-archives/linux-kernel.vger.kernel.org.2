Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D10B41DBDC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351724AbhI3OFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:05:44 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:48342
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351565AbhI3OFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:05:43 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 601E340603
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 14:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633010638;
        bh=Cs492Uld1dgt/renKhzvwp/nFhGhdClsztwOexxROyc=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=CAVCbETXxIDvDWCLNHHSALTsP25CmPr0ejJJwXoFViKQtMAXoOQSMk6wYP37LrLXy
         DhWGwPXi8QMQd7WuuY5W/4hVFeF/lQlDLb5hvVU5yLZTXvIphNLthG3Sbv2T7AX/aE
         +JHjdCub2ivb8bMiE+6s7Xg/u6tb5OvOzLqVfWciOltQdzRowr3Pgv8XNMDbibEc9F
         h/taTbwoDqYR6mL2lmt1tmLuZD7zxrUfE0CKg6V94UdEcBuiP+QZCuFWoBAwtroXj3
         BK5heo3H2hCLwiHk4GhQtLrwlc1cyhyzUEXq7P18i5ptxWnb6ceGWjAs0Y2PNziQOy
         YL/+TI/DM1sAw==
Received: by mail-lf1-f69.google.com with SMTP id d22-20020a0565123d1600b003fd0097d747so5741207lfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cs492Uld1dgt/renKhzvwp/nFhGhdClsztwOexxROyc=;
        b=Yu8Hu7khlDaXfoL7xDHYSB2UZZMsKsOuj15Z+eA90E57q3VDjAQP7650fDQ1ucqjeq
         2N9ms+6gnqJruw6hyuXo6e5RWEE/k9WVjT0a0s5AyZ3Rz6yWFC7d+o4ZB75ZmCvpqxZ5
         lgrFTfHO3UNkIcU9zbzY3wENAQIhrYPddCIkdVyLVL0OBPAERdG7T0nCK6s+Z95xGQdp
         CjBq/f8dEpr/xZJj19GFcbcjMym5Wtcnpsq4YpAJErSsu48G6buhqkllGDyzMfBlvo7v
         MoBOjTBY1N5rYjRqmtq3+xkPdn3M8NULxNQe0Ek+KDX9WTYwMol927+pjTy6pcQk9N6W
         QFhw==
X-Gm-Message-State: AOAM531Kgrrh6MnmguH/chsqU5LkgpKbiLFypN62ehNjA0H8uPYmZAVp
        Q3xx85y+kDEavXUJAzgBIrU0bERa61sUUKo51s/gV24hapAaSNTQt4OQFTuyw7cW5I7jqBkQhOu
        ZsnN954aFQWORz4QrWGBJatdviw6MwVwi/XUa3Llb2g==
X-Received: by 2002:a2e:530d:: with SMTP id h13mr6158236ljb.192.1633010637568;
        Thu, 30 Sep 2021 07:03:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwD+1Q+rFkY6iajccNc1tY8rWLhVSgoPoYUZn4jBBkNz7eojB3z0DHwP189TSCCUgWIgs/j/g==
X-Received: by 2002:a2e:530d:: with SMTP id h13mr6158199ljb.192.1633010637245;
        Thu, 30 Sep 2021 07:03:57 -0700 (PDT)
Received: from localhost.localdomain ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id m9sm382166lfb.162.2021.09.30.07.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:03:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] regulator: dt-bindings: maxim,max8952: convert to dtschema
Date:   Thu, 30 Sep 2021 16:03:27 +0200
Message-Id: <20210930140327.196232-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Maxim MAX8952 regulator to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/regulator/max8952.txt |  52 ---------
 .../bindings/regulator/maxim,max8952.yaml     | 109 ++++++++++++++++++
 2 files changed, 109 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/max8952.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max8952.yaml

diff --git a/Documentation/devicetree/bindings/regulator/max8952.txt b/Documentation/devicetree/bindings/regulator/max8952.txt
deleted file mode 100644
index 866fcdd0f4eb..000000000000
--- a/Documentation/devicetree/bindings/regulator/max8952.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-Maxim MAX8952 voltage regulator
-
-Required properties:
-- compatible: must be equal to "maxim,max8952"
-- reg: I2C slave address, usually 0x60
-- max8952,dvs-mode-microvolt: array of 4 integer values defining DVS voltages
-  in microvolts. All values must be from range <770000, 1400000>
-- any required generic properties defined in regulator.txt
-
-Optional properties:
-- max8952,vid-gpios: array of two GPIO pins used for DVS voltage selection
-- max8952,en-gpio: GPIO used to control enable status of regulator
-- max8952,default-mode: index of default DVS voltage, from <0, 3> range
-- max8952,sync-freq: sync frequency, must be one of following values:
-    - 0: 26 MHz
-    - 1: 13 MHz
-    - 2: 19.2 MHz
-  Defaults to 26 MHz if not specified.
-- max8952,ramp-speed: voltage ramp speed, must be one of following values:
-    - 0: 32mV/us
-    - 1: 16mV/us
-    - 2: 8mV/us
-    - 3: 4mV/us
-    - 4: 2mV/us
-    - 5: 1mV/us
-    - 6: 0.5mV/us
-    - 7: 0.25mV/us
-  Defaults to 32mV/us if not specified.
-- any available generic properties defined in regulator.txt
-
-Example:
-
-	vdd_arm_reg: pmic@60 {
-		compatible = "maxim,max8952";
-		reg = <0x60>;
-
-		/* max8952-specific properties */
-		max8952,vid-gpios = <&gpx0 3 0>, <&gpx0 4 0>;
-		max8952,en-gpio = <&gpx0 1 0>;
-		max8952,default-mode = <0>;
-		max8952,dvs-mode-microvolt = <1250000>, <1200000>,
-						<1050000>, <950000>;
-		max8952,sync-freq = <0>;
-		max8952,ramp-speed = <0>;
-
-		/* generic regulator properties */
-		regulator-name = "vdd_arm";
-		regulator-min-microvolt = <770000>;
-		regulator-max-microvolt = <1400000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
diff --git a/Documentation/devicetree/bindings/regulator/maxim,max8952.yaml b/Documentation/devicetree/bindings/regulator/maxim,max8952.yaml
new file mode 100644
index 000000000000..e4e8c58f6046
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max8952.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/maxim,max8952.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX8952 voltage regulator
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    const: maxim,max8952
+
+  max8952,default-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    description: |
+      index of default DVS voltage
+
+  max8952,dvs-mode-microvolt:
+    minItems: 4
+    maxItems: 4
+    items:
+      minimum: 770000
+      maximum: 1400000
+    description: |
+      Array of 4 integer values defining DVS voltages in microvolts. All values
+      must be from range <770000, 1400000>.
+
+  max8952,en-gpio:
+    maxItems: 1
+    description: |
+      GPIO used to control enable status of regulator
+
+  max8952,ramp-speed:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3, 4, 5, 6, 7]
+    default: 0
+    description: |
+      Voltage ramp speed, values map to:
+       - 0: 32mV/us
+       - 1: 16mV/us
+       - 2: 8mV/us
+       - 3: 4mV/us
+       - 4: 2mV/us
+       - 5: 1mV/us
+       - 6: 0.5mV/us
+       - 7: 0.25mV/us
+      Defaults to 32mV/us if not specified.
+
+  max8952,sync-freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+    default: 0
+    description: |
+      Sync frequency, values map to:
+       - 0: 26 MHz
+       - 1: 13 MHz
+       - 2: 19.2 MHz
+      Defaults to 26 MHz if not specified.
+
+  max8952,vid-gpios:
+    minItems: 2
+    maxItems: 2
+    description: |
+      Array of two GPIO pins used for DVS voltage selection
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - max8952,dvs-mode-microvolt
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@60 {
+            compatible = "maxim,max8952";
+            reg = <0x60>;
+
+            max8952,vid-gpios = <&gpx0 3 GPIO_ACTIVE_HIGH>,
+                                <&gpx0 4 GPIO_ACTIVE_HIGH>;
+            max8952,default-mode = <0>;
+            max8952,dvs-mode-microvolt = <1250000>, <1200000>,
+                                         <1050000>, <950000>;
+            max8952,sync-freq = <0>;
+            max8952,ramp-speed = <0>;
+
+            regulator-name = "VARM_1.2V_C210";
+            regulator-min-microvolt = <770000>;
+            regulator-max-microvolt = <1400000>;
+            regulator-always-on;
+            regulator-boot-on;
+        };
+    };
-- 
2.30.2

