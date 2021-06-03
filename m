Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C98399A5D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 07:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhFCGAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 02:00:37 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:36796 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhFCGAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 02:00:36 -0400
Received: by mail-pg1-f175.google.com with SMTP id 27so4313559pgy.3;
        Wed, 02 Jun 2021 22:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QetTe23X5TPQkNrYDlbxVAPrJ9y0TClGWiUzKSBW6Ew=;
        b=JdHjzURGOxNx++fns8rcjfLf0rbaewJKsqwFesEB/scwePgW8+JcGQRlKScjsFziK7
         kpbJ/LWN+2W0hNpkr1Ghi59ZMNB90vbwJHaiKGVEjw+8SActUmynQVS3jsJsYISxVNB1
         4/sq4mLxFHJN0O+zPYppyR69DLfXJBdh8leq9MrFBeZqho98xjQXnOklcHShuDNySpwW
         Cl/adyxub08kZxtBfQFty/K4/OYEnad+bFQYKxMn3t1nH6QB1ORHzvBmM3uGsGBFnVcG
         JIo8Bj2dunzFoOr/cQObnlNPpDJKjf1EcK9OG/XO0XRI9x3NWhzZsCabvKDuE8yDh9d0
         Pdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QetTe23X5TPQkNrYDlbxVAPrJ9y0TClGWiUzKSBW6Ew=;
        b=sGRYsSoxrP/NqxipRlbszeLQEbXwjTkcDDt92eRH81esw46shb1b5ZqCOkQx/w+5/i
         imMWE7SNxo7o4WMWV0KWV3rBnXOCbfMGfrQvsg9CZWx+xt7469r/MobZqAdz2Ct4rjKq
         0cumFC4/xmAz+FhpGPBVptvdt35m5XdSzU57PGBTcivrqLHoEU/vM5pgFyisf/2/tlMj
         lWLITrrJHDovNSGQO11kt3SmD0WmXHHWDtYsFbECn60C9toL0dZ6/nFQJr1cFbTPGSdB
         PY5huvQl6ykfaSkgEfarAGjEKgHBpknbSG5tsO4Ksocu6AGeqIkrBdPSPTxG7qUJvoey
         kXtA==
X-Gm-Message-State: AOAM530vTcK8FGUc16rgijYbwMy4r4A+Wb4XlnLrGSIgH/mkL4iXw6Ge
        LZHfJot3GnBEYGrTlIWSf2k=
X-Google-Smtp-Source: ABdhPJwAlZQoOx3CC1AvnjPJapvu9/8AJqFDmKqrPcU98j1WvT26EFSvsEa94fZOZh67zVGUul2DCA==
X-Received: by 2002:a65:568c:: with SMTP id v12mr38470142pgs.88.1622699855913;
        Wed, 02 Jun 2021 22:57:35 -0700 (PDT)
Received: from localhost.localdomain (1-171-7-242.dynamic-ip.hinet.net. [1.171.7.242])
        by smtp.gmail.com with ESMTPSA id v6sm1207267pfi.46.2021.06.02.22.57.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jun 2021 22:57:35 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] regulator: rt6245: Add the binding document for Richtek RT6245
Date:   Thu,  3 Jun 2021 13:57:23 +0800
Message-Id: <1622699844-19203-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add the binding document for Richtek RT6245.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
since v3
- Add Reviewed-by string in patch description.
---
 .../regulator/richtek,rt6245-regulator.yaml        | 89 ++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt6245-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt6245-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt6245-regulator.yaml
new file mode 100644
index 00000000..796ceac
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt6245-regulator.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rt6245-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT6245 High Current Voltage Regulator
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RT6245 is a high-performance, synchronous step-down converter
+  that can deliver up to 14A output current with an input supply
+  voltage range of 4.5V to 17V.
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt6245
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description: |
+      A connection of the chip 'enable' gpio line. If not provided,
+      it will be treat as a default-on power.
+    maxItems: 1
+
+  richtek,oc-level-select:
+    $ref: "/schemas/types.yaml#/definitions/uint8"
+    enum: [0, 1, 2, 3]
+    description: |
+      Over current level selection. Each respective value means the current
+      limit 8A, 14A, 12A, 10A. If this property is missing then keep in
+      in chip default.
+
+  richtek,ot-level-select:
+    $ref: "/schemas/types.yaml#/definitions/uint8"
+    enum: [0, 1, 2]
+    description: |
+      Over temperature level selection. Each respective value means the degree
+      150'c, 130'c, 170'c. If this property is missing then keep in chip
+      default.
+
+  richtek,pgdly-time-select:
+    $ref: "/schemas/types.yaml#/definitions/uint8"
+    enum: [0, 1, 2, 3]
+    description: |
+      Power good signal delay time selection. Each respective value means the
+      delay time 0us, 10us, 20us, 40us. If this property is missing then keep
+      in chip default.
+
+
+  richtek,switch-freq-select:
+    $ref: "/schemas/types.yaml#/definitions/uint8"
+    enum: [0, 1, 2]
+    description: |
+      Buck switch frequency selection. Each respective value means 400KHz,
+      800KHz, 1200KHz. If this property is missing then keep in chip default.
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rt6245@34 {
+        compatible = "richtek,rt6245";
+        status = "okay";
+        reg = <0x34>;
+        enable-gpios = <&gpio26 2 0>;
+
+        regulator-name = "rt6245-regulator";
+        regulator-min-microvolt = <437500>;
+        regulator-max-microvolt = <1387500>;
+        regulator-boot-on;
+      };
+    };
-- 
2.7.4

