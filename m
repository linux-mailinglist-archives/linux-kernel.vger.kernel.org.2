Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D646A391079
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhEZGOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbhEZGOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:14:52 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48430C061574;
        Tue, 25 May 2021 23:13:20 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id m190so75700pga.2;
        Tue, 25 May 2021 23:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=69dcfTu5Rod0MWZh6A/dLucdJd56m6mON5Jg30AVkEw=;
        b=bB7HCxKQ/O2P1eV233GGZpu1PGtZa3vSijw4+k6fy7YFBiLzqhoCcmNa37ViXSBaHc
         0FWf0PtxxCxUo8UnhWTmb6AD0HFF3hlIKM/qr9QeSUdawjDnUEZ9G+4w1iqJpyB+dxO6
         Qux8L3ONsxsWzKNA23O8PvzGzZ/mASpjRuKSYf1cwsfJgatOCtKwLZ71HdEzN3lRLzpO
         rY0Zw0xniQnQUjK67Dq641Au8z4P5pyaEc76ySucJmPi+wVpfM0a4xhaKO8NJwDtYWeN
         OLx8FLYEd0YUanY5Y9cn7UrRT/erg+bb2dCF7EklTnwM9v8AzhMsQX4rIhq2n4Bj3smx
         8PnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=69dcfTu5Rod0MWZh6A/dLucdJd56m6mON5Jg30AVkEw=;
        b=kDdciyFmiotDxe83fQ7MoH4JFS5M/QLWOiwNKZ2G5KL6/l0ALtwOAlVpEwInmaV9xt
         z/rJtygCpEdUFMozcHdEOmi6kRS6PZQwvkgBPU4wHdC8AfSRbzb7F7BcvuoS4+CLYyJJ
         LD8PNh7DE86EEvgv7ooNCKfzUWXNySNRyHbgQqWgZRLm64dTxKGdTu8JHpZCJLnLQrQW
         qzGtoY07E4lfVi6FBD7zNuhvXQ9dS62MlR5rWLX/NtjQkNu23H4bBBSrRhfcsnFAYimq
         iVovaz1ETh9LmufNKOremHAtepfcZK7xry9AGg1vG2lQJXDXgz/Sp9hDFTXIJ3TEL/xa
         SrKg==
X-Gm-Message-State: AOAM531w75S3IZd/1lImNIx3APBE2CRcQ9XIb45s65ioHJZdDeP5Sdyo
        /9/SLsZZPuvn2MFCH//EN98=
X-Google-Smtp-Source: ABdhPJyE2cflnST4gffTZdWw+CO2OxjusuQppwUuCJAxekq7NVYrawUfE3cKT1VmzFcFmTZWEHUnjg==
X-Received: by 2002:a62:ae19:0:b029:2d9:11cf:5da7 with SMTP id q25-20020a62ae190000b02902d911cf5da7mr34234067pff.18.1622009599724;
        Tue, 25 May 2021 23:13:19 -0700 (PDT)
Received: from localhost.localdomain (1-171-3-30.dynamic-ip.hinet.net. [1.171.3.30])
        by smtp.gmail.com with ESMTPSA id f14sm14496249pjq.50.2021.05.25.23.13.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 May 2021 23:13:19 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 1/2] regulator: rt6245: Add the binding document for Richtek RT6245
Date:   Wed, 26 May 2021 14:12:57 +0800
Message-Id: <1622009578-15577-1-git-send-email-u0084500@gmail.com>
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

