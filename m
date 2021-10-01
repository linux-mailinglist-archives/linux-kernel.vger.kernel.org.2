Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB9641E88B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 09:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352604AbhJAHtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 03:49:18 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:37766
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352589AbhJAHtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 03:49:16 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2F39A4028F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 07:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633074452;
        bh=JWVLhql7n5GSpz7ieRWFANGSHvai9cKZeAhbEHy5LV4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=pKbsSpo4e+LtBWTJGh8fy8ml+v81iF0ptApbqi12/AmPxab80eJ3/xSOAQ/AG7ZLg
         ePvDgE8WrdC/BokhTH5Y3aD7b6qk3edCiiNjHOA9RfosR4RXjHYKFMKCLdn/rAThVZ
         JExpMi7RbrPbvmBe5n03JjsUe3WPjZPnC/WG8JybF/hUBEtYn+r4ifgGa8vb8Lvlhx
         gJnl9m77ebN6lPzuspJe2nCDat3I8xEKH0ssWihgyA1+/00qt8OYa2Xt2+LgpuK13v
         kUtHsCG/LR5G/99B5YgGOthd2MzFS5mX7Pv+rFso1UNZSmD+bRT1EYrCoIIyvXN3KQ
         tiKlJGh5i/hbw==
Received: by mail-lf1-f70.google.com with SMTP id c6-20020a05651200c600b003fc6d39efa4so8174476lfp.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 00:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JWVLhql7n5GSpz7ieRWFANGSHvai9cKZeAhbEHy5LV4=;
        b=ExX628ztmI8FRKVWFyuindDOLAf1jEasg5WS/yJ6shaLtTE9OKraFU1VwTyulU1a/G
         Bl0yre7U4LkJmPmsm0n/mDxvkKFVrWPO4gfR/XBQH2RYD19WN3xuygXT8scpgm022tiW
         X6ic/3uqA0czmZKUU2gMEU24Kk6waILeEOMsuRz3HYaZ8EKiBpqWPtqlFdrvo5awcV2S
         5p7S0fydDhTT8oO8aSvFL3zKmy+m8XMZ7y2oz5C3S1HfZIFayQZsXVdOdgqFJ3JKot1U
         7fG5n28UOtnf3Lar0e/UdOTFau+QIIHRX5shpp5Q3DXZ2JZ9vP1qfTRgvF45JupBT2Gq
         WfoA==
X-Gm-Message-State: AOAM532+RLom7XDE+AiKeEOFPEREw38SpP7JU6T7mMJBcZBFa8uzKKvW
        fymE6HEnUDB3JnLK8OfHphxraqQ6pjazB5gL69cij39Bhqnh/VyZQPtp1ffR3EE8YFSn2K1YENx
        4K7MA2dh/SdAGuRctjsfJxe4+yR8rMOe3g2KYw2CNfg==
X-Received: by 2002:a2e:81da:: with SMTP id s26mr10338151ljg.210.1633074451378;
        Fri, 01 Oct 2021 00:47:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyClzNiEh/g07VcT0rFwJEGWKUKBNGWhvQ2DG5HUM0nTAf3yoYeFAEplBDpq3ND39ujGr0AMg==
X-Received: by 2002:a2e:81da:: with SMTP id s26mr10338140ljg.210.1633074451150;
        Fri, 01 Oct 2021 00:47:31 -0700 (PDT)
Received: from localhost.localdomain ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id o21sm644597lfu.81.2021.10.01.00.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 00:47:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH] regulator: dt-bindings: maxim,max8973: convert to dtschema
Date:   Fri,  1 Oct 2021 09:46:54 +0200
Message-Id: <20211001074654.41196-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Maxim MAX8973 regulator to DT schema format.  Extend the
examples with more advanced one for MAX77621 copied from kernel's
nvidia/tegra210-smaug.dts, licensed under GPL-2.0.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/regulator/max8973-regulator.txt  |  52 -------
 .../bindings/regulator/maxim,max8973.yaml     | 140 ++++++++++++++++++
 2 files changed, 140 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/max8973-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max8973.yaml

diff --git a/Documentation/devicetree/bindings/regulator/max8973-regulator.txt b/Documentation/devicetree/bindings/regulator/max8973-regulator.txt
deleted file mode 100644
index c2c68fcc1b41..000000000000
--- a/Documentation/devicetree/bindings/regulator/max8973-regulator.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-* Maxim MAX8973 Voltage Regulator
-
-Required properties:
-
-- compatible:	must be one of following:
-			"maxim,max8973"
-			"maxim,max77621".
-- reg:		the i2c slave address of the regulator. It should be 0x1b.
-
-Any standard regulator properties can be used to configure the single max8973
-DCDC.
-
-Optional properties:
-
--maxim,externally-enable: boolean, externally control the regulator output
-		enable/disable.
--maxim,enable-gpio: GPIO for enable control. If the valid GPIO is provided
-		then externally enable control will be considered.
--maxim,dvs-gpio: GPIO which is connected to DVS pin of device.
--maxim,dvs-default-state: Default state of GPIO during initialisation.
-		1 for HIGH and 0 for LOW.
--maxim,enable-remote-sense: boolean, enable reote sense.
--maxim,enable-falling-slew-rate: boolean, enable falling slew rate.
--maxim,enable-active-discharge: boolean: enable active discharge.
--maxim,enable-frequency-shift: boolean, enable 9% frequency shift.
--maxim,enable-bias-control: boolean, enable bias control. By enabling this
-		startup delay can be reduce to 20us from 220us.
--maxim,enable-etr: boolean, enable Enhanced Transient Response.
--maxim,enable-high-etr-sensitivity: boolean, Enhanced transient response
-		circuit is enabled and set for high sensitivity. If this
-		property is available then etr will be enable default.
-
-Enhanced transient response (ETR) will affect the configuration of CKADV.
-
--junction-warn-millicelsius: u32, junction warning temperature threshold
-		in millicelsius. If die temperature crosses this level then
-		device generates the warning interrupts.
-
-Please note that thermal functionality is only supported on MAX77621. The
-supported threshold warning temperature for MAX77621 are 120 degC and 140 degC.
-
-Example:
-
-	max8973@1b {
-		compatible = "maxim,max8973";
-		reg = <0x1b>;
-
-		regulator-min-microvolt = <935000>;
-		regulator-max-microvolt = <1200000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
diff --git a/Documentation/devicetree/bindings/regulator/maxim,max8973.yaml b/Documentation/devicetree/bindings/regulator/maxim,max8973.yaml
new file mode 100644
index 000000000000..8947d1fa989a
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max8973.yaml
@@ -0,0 +1,140 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/maxim,max8973.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX8973/MAX77621 voltage regulator
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    enum:
+      - maxim,max8973
+      - maxim,max77621
+
+  junction-warn-millicelsius:
+    #$ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Junction warning temperature threshold in millicelsius. If die
+      temperature crosses this level then device generates the warning
+      interrupts.
+      Please note that thermal functionality is only supported on MAX77621. The
+      supported threshold warning temperature for MAX77621 are 120 degC and 140
+      degC.
+
+  maxim,dvs-gpio:
+    maxItems: 1
+    description: |
+      GPIO which is connected to DVS pin of device.
+
+  maxim,dvs-default-state:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description: |
+      Default state of GPIO during initialisation.
+      1 for HIGH and 0 for LOW.
+
+  maxim,externally-enable:
+    type: boolean
+    description: |
+      Externally control the regulator output enable/disable.
+
+  maxim,enable-gpio:
+    maxItems: 1
+    description: |
+      GPIO for enable control. If the valid GPIO is provided then externally
+      enable control will be considered.
+
+  maxim,enable-remote-sense:
+    type: boolean
+    description: Enable remote sense.
+
+  maxim,enable-falling-slew-rate:
+    type: boolean
+    description: Enable falling slew rate.
+
+  maxim,enable-active-discharge:
+    type: boolean
+    description: Eable active discharge.
+
+  maxim,enable-frequency-shift:
+    type: boolean
+    description: Enable 9% frequency shift.
+
+  maxim,enable-bias-control:
+    type: boolean
+    description: |
+      Enable bias control which can reduce the startup delay to 20us from 220us.
+
+  maxim,enable-etr:
+    type: boolean
+    description: Enable Enhanced Transient Response.
+
+  maxim,enable-high-etr-sensitivity:
+    type: boolean
+    description: |
+      Enhanced transient response circuit is enabled and set for high
+      sensitivity. If this property is available then etr will be enable
+      default.
+      Enhanced transient response (ETR) will affect the configuration of CKADV.
+
+  reg:
+    maxItems: 1
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@1b {
+            compatible = "maxim,max8973";
+            reg = <0x1b>;
+
+            regulator-min-microvolt = <935000>;
+            regulator-max-microvolt = <1200000>;
+            regulator-boot-on;
+            regulator-always-on;
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/tegra-gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@1b {
+            compatible = "maxim,max77621";
+            reg = <0x1b>;
+            interrupt-parent = <&gpio>;
+            interrupts = <TEGRA_GPIO(Y, 1) IRQ_TYPE_LEVEL_LOW>;
+
+            regulator-always-on;
+            regulator-boot-on;
+            regulator-min-microvolt = <800000>;
+            regulator-max-microvolt = <1231250>;
+            regulator-name = "PPVAR_CPU";
+            regulator-ramp-delay = <12500>;
+            maxim,dvs-default-state = <1>;
+            maxim,enable-active-discharge;
+            maxim,enable-bias-control;
+            maxim,enable-etr;
+            maxim,enable-gpio = <&pmic 5 GPIO_ACTIVE_HIGH>;
+            maxim,externally-enable;
+        };
+    };
-- 
2.30.2

