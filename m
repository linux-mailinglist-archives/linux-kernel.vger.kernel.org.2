Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF61B39105A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhEZGK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhEZGKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:10:23 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9A0C061574;
        Tue, 25 May 2021 23:08:51 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 69so94223plc.5;
        Tue, 25 May 2021 23:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=69dcfTu5Rod0MWZh6A/dLucdJd56m6mON5Jg30AVkEw=;
        b=fdPLe3tOK3w22cmU+MYHsdGF93lhq4iTe4kCT6dVltpvkkWv15shn1v4m7LviCWjHT
         WOdhbl1Lx8PH54MWa9vBEACwhIr6aNjKtdK7iughruD0glz/VU+oQBiEeaiSF/beOxIi
         6rXYX9sU1OqcH/DVbnL/Mud/vc9DOFTZuPd8PBMJSsCFLTsiujJnSZYr295NNRMU38vX
         Xz8+ZIMHQBp9Nddzogb8CsEO4x5yg3LFfkom9bITPUR5JWGYJkBbuzKEu5JCqqwin1JT
         oq4Wk/FUfGvpBfV5iRyfV8c2aHjy42h26uH992ZVb4wiwx/rpb9HHgu64W9aJuqdJ9Je
         NS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=69dcfTu5Rod0MWZh6A/dLucdJd56m6mON5Jg30AVkEw=;
        b=tOHEp+NGf8ze3zkUJX1zQ20l7rOOjrM7J8ps2crcppnO1hYKVSHifqVmFDpmbgYKdr
         0WBNSaKwKCul47L9mb/GC2Vj7SaDupofyCVzCnOqacC4hU/GbSCDBp+32rryDGFwIM1c
         zXKjlpxj0WvW0U/ruhXf0yz8BJYjYEHcOe7R7AVWGeQOIJSKR6tJkskwbd2qm9LbBkZl
         L6PULlVjIyyHNiR3E6PsL8LfEojdc++UDa5F8lpmnc1kT55PQq4AKcBwyYg/Tzs65HFf
         KoHUnea+sb0Uq/jx9FVpqqyjYnh4hfF/3NzPm+/uEj5YEjn7td/T6LTUeSa8kHicRLAi
         eGwg==
X-Gm-Message-State: AOAM533bPoP+PjS1ox3etgy7FkjyclRb4G3eBpfbtxwILEhlZff5f0yC
        yz0o/CVYJZTYZEE7LaheDdnNKEbAxHs=
X-Google-Smtp-Source: ABdhPJzd0fT5UdmZNdQpyxPjccEMhqPfoDamF8Wtd8976wNsdw3nCKtCFnQ6PXJYxFkWnynfzgN3nQ==
X-Received: by 2002:a17:90a:4205:: with SMTP id o5mr27908436pjg.140.1622009331220;
        Tue, 25 May 2021 23:08:51 -0700 (PDT)
Received: from localhost.localdomain (1-171-3-30.dynamic-ip.hinet.net. [1.171.3.30])
        by smtp.gmail.com with ESMTPSA id n12sm14098915pjk.48.2021.05.25.23.08.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 May 2021 23:08:50 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        cy_huang@richtek.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v1 1/2] regulator: rt6245: Add the binding document for Richtek RT6245
Date:   Wed, 26 May 2021 14:08:40 +0800
Message-Id: <1622009321-15157-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622009321-15157-1-git-send-email-u0084500@gmail.com>
References: <1622009321-15157-1-git-send-email-u0084500@gmail.com>
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

