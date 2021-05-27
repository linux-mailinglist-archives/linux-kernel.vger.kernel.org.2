Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511D83926CB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 07:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhE0FP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 01:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbhE0FPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 01:15:51 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362DBC061574;
        Wed, 26 May 2021 22:14:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k5so2073399pjj.1;
        Wed, 26 May 2021 22:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=69dcfTu5Rod0MWZh6A/dLucdJd56m6mON5Jg30AVkEw=;
        b=ZerdkHAiFtuXv7GhELtNt1zIuw02exnSjnKN5h5dW6+oMhTwDHbc96dLRmNOW871qY
         H0uCNGHRCO2r3IwMnOuflFgfUd2oKl2ltSSJG7qZdx2ToGHK/XmTrRJ06XfMO6ZNq10z
         GFQ+EhO7sO53v8pjM1rYL97weR4fvnXJ6csz2fOpg3rfuu4EBTf6dgGh7VXRbH9xUkb3
         v8pTFXXmJ0Yb34sRqw7gm/xaRYpZFIKejd28l9XkKqDaDXg4ZwypBPDyXXkMddpJBJcZ
         bif6YOxK9bdAyO6Rlns0LTBdrdZCe60dE1rhdMK4FQVnNfFaG4Cg5nu5TRx9rGbUG3vu
         JFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=69dcfTu5Rod0MWZh6A/dLucdJd56m6mON5Jg30AVkEw=;
        b=q+zPVmuyQiWLIUIX8o+3LZy3dchaLBdX35wEJzzjr4CBZEtmzlLK4EPU5sSVhynI4Y
         z9H6AL1HwAQKlDktFpR4dMjLzrY1WbbVPkqPBTAUEkblV2Sqr4J8w8QaU9cZ3HKB+HXJ
         UiOvr32HKks7HXz4ykbs8u+dYBtWcvY/wxSGjXtseNODLcgAIpRydi5AFZ/nxaxJgzDs
         j7nmudZsZasv4SWv7fvz7dUKFYGXvDhHpLrI4Ei/9ayxHpL4+GbtoGcXG2o91AknY+hH
         Ag15zbk0sJhnbREoO/u0T3+AbLHR1/xLt/LUN4Eo0xnjBEvgC/wbDRVNFdIBGCUY7T3S
         RQsw==
X-Gm-Message-State: AOAM5306E5axmBoZo2eSwHa0w6B7nq+CIgfk/p4XCqCnAmEnGm2gYI+4
        AFmQqXl8FYUVKe/NOAln0Nc=
X-Google-Smtp-Source: ABdhPJz7WTL1GRH7P66Tsj7yNG7KLXa+p8CKTLEsMfhfQ/VXJZLl1yPkq0yJKUK2DUme2u0UCho49w==
X-Received: by 2002:a17:902:bc44:b029:fd:ea73:a2d0 with SMTP id t4-20020a170902bc44b02900fdea73a2d0mr1761022plz.3.1622092458494;
        Wed, 26 May 2021 22:14:18 -0700 (PDT)
Received: from localhost.localdomain (1-171-23-132.dynamic-ip.hinet.net. [1.171.23.132])
        by smtp.gmail.com with ESMTPSA id cu2sm706424pjb.43.2021.05.26.22.14.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 22:14:17 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] regulator: rt6245: Add the binding document for Richtek RT6245
Date:   Thu, 27 May 2021 13:14:08 +0800
Message-Id: <1622092449-21461-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add the binding document for Richtek RT6245.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
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

