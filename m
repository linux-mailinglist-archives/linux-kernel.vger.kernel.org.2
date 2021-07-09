Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342C63C26FD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 17:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhGIPnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 11:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhGIPng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 11:43:36 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD165C0613DD;
        Fri,  9 Jul 2021 08:40:52 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 37so10373449pgq.0;
        Fri, 09 Jul 2021 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=K6Ra4499Mv5TDI0Yujb+kPloT8dTaxT+C+3Nfx0tGRU=;
        b=tZ+kgNVX7F9xWyl4VsETCatrus1w1gcL488iCXEx0a2VYpTgBFvQJHW3vahlwYPkvT
         KFIqrH2ngtXXR/+FbjU8iKEtbuhcry1OxKRlsAhdJvc9FL5mz6HJKw7yzvz/8JrCJw26
         1h+0DONBygf+cK4VC27HER4ItJyNgupGwdd4RkRZMTJ5BPh8YFlZRh21knqjKrUgbu9p
         wzrCCiCJGxSU8IoB5UX8BrOcZFlAK5xT3FUqBj9E6nZ+BIa5KkSv1ftABVdIuSOnBCi4
         3ZeqlbeZS8/bN/h1vWoQ3BnIj6nnyyry8SDzA3ZIpRTZIM9XzJZeFdXsAmoKSghuT3Jf
         VvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K6Ra4499Mv5TDI0Yujb+kPloT8dTaxT+C+3Nfx0tGRU=;
        b=d21Hmrr6QikyoXSN2BsaaYMiyD5Q8McUQs963OiZxRvIagKDpI5zKEMQAtgW6s4XsV
         URdC8tIu3xyzJpdP5j5XEuYILKjp8miv+hyKfVe50ROmddAmUafCKBE3uarptzbGbD4q
         NvobQDgW4ZDMJpFptCNHE5ZgspSHlZFjqfC1V8CNh9Ky9UTgdLeg+Tl/lokIQ+XPXtc2
         PQtBPgDDK7uYIZ3oJtOWBk4nZDzmpHRgbuNFimy33jlNCubY1/MwzKtcGPHLW65tPpf1
         TahOJu2/ZxO11snhEaThpBT9TKO+DGsGT+81aiBfMqo6fa7dnlbP9yfEs8m+FdX5ceNC
         81IA==
X-Gm-Message-State: AOAM5321SbdAiserO9nqsA2aVl/Egcf3F1XE7HzOuJRYt1u1JU/ModWr
        Auy6uf3+O3nL96u6IhLRV6w=
X-Google-Smtp-Source: ABdhPJwXKC+Xxq70U/k0mS05+8YwvZnKSh5InxSGPB2kqu1d8PUK3mHvkObnoQcG8Kt1tBPhFshzbA==
X-Received: by 2002:a63:3383:: with SMTP id z125mr38677501pgz.26.1625845252227;
        Fri, 09 Jul 2021 08:40:52 -0700 (PDT)
Received: from localhost.localdomain (1-171-0-5.dynamic-ip.hinet.net. [1.171.0.5])
        by smtp.gmail.com with ESMTPSA id g11sm8314703pgj.3.2021.07.09.08.40.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jul 2021 08:40:50 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, devicetree@vger.kernel.org
Subject: [PATCH 1/2] regulator: rtq6752: Add binding document for Richtek RTQ6752
Date:   Fri,  9 Jul 2021 23:40:35 +0800
Message-Id: <1625845236-30285-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add binding document for Richtek RTQ6752.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../regulator/richtek,rtq6752-regulator.yaml       | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml
new file mode 100644
index 00000000..641840e
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtq6752-regulator.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rtq6752-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RTQ6752 TFT LCD Voltage Regulator
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RTQ6752 is an I2C interface pgorammable power management IC. It includes
+  two synchronous boost converter for PAVDD, and one synchronous NAVDD
+  buck-boost. The device is suitable for automotive TFT-LCD panel.
+
+properties:
+  compatible:
+    enum:
+      - richtek,rtq6752
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description: |
+      A connection of the chip 'enable' gpio line. If not provided, treat it as
+      external pull up.
+    maxItems: 1
+
+  regulators:
+    type: object
+    $ref: regulator.yaml#
+
+    patternProperties:
+      "^(p|n)avdd$":
+        type: object
+        $ref: regulator.yaml#
+        description: |
+          regulator description for pavdd and navdd.
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rtq6752@6b {
+        compatible = "richtek,rtq6752";
+        status = "okay";
+        reg = <0x6b>;
+        enable-gpios = <&gpio26 2 0>;
+
+        regulators {
+          pavdd {
+            regulator-name = "rtq6752-pavdd";
+            regulator-min-microvolt = <5000000>;
+            regulator-max-microvolt = <7300000>;
+            regulator-boot-on;
+          };
+          navdd {
+            regulator-name = "rtq6752-navdd";
+            regulator-min-microvolt = <5000000>;
+            regulator-max-microvolt = <7300000>;
+            regulator-boot-on;
+          };
+        };
+      };
+    };
-- 
2.7.4

