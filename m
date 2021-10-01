Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1551941EE23
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 15:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354126AbhJANF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 09:05:59 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35174
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353738AbhJANFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 09:05:13 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A534640260
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 13:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633093407;
        bh=9H/1OAqByom+0iq1wmifZ9jGWekgEvgSvq5L7+SELgs=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=QqdweoCgzhlQL/LcJok7SZcJEQLA8aahyxrxF/WtngkIjsThT5ewktsRYgsQtyh5I
         bEsQlzkl9w9nfOT/25W4kAWIKlOTGl8mwCzqrqEUAwxB3wl1vg0R6VjT1zwSjAAvFj
         2pEvrv7XcmqWm3mc4YTUp13lFbr5KGg0I/X+LccNFRrl5IDLOX8Gc4esYemFKZG607
         lBmKchHIvJGc55jMkqxT5EiXzHT0lgCzUEko4c1nfQFEW3w2HXTCUzUwCPmDaL0Rkh
         Vu9VVCqfmblUtv8O73woJ05I4xoJ5Y3UTwzYDNgQJ4Lir+EQy3bl049+ccJsu6U8TW
         5oddclJrg8qKQ==
Received: by mail-lf1-f71.google.com with SMTP id d22-20020a0565123d1600b003fd0097d747so8905998lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 06:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9H/1OAqByom+0iq1wmifZ9jGWekgEvgSvq5L7+SELgs=;
        b=MTS7HcEMTUn8HzKTfs9XCQhu14SxbkEYVY8qF4/LqjKWR3Aebw4m+QP/OsSweyQZIW
         aVw/yT2CE5KTBKfWXEd0L2DH8b3Xxq3q5FBtFpUH5dLkFaTRpaARydCemsrbj1pN7CSm
         77FPHb9oOHW2DjjjkNaSXnlpGVuXHQpt/S4Thy+9GNxDq2pMLLui9Pzn1KzLA0CZCoNL
         BoLe7Gxfo2iB/SThxhV3hhu2wNzsghh7T7DOdBoDQaWkSpU1unlxmbCR+tRC9AbCdfno
         v3pPfqxmtnjOeswziY6SL+nH1W+2+67PV2KZSUqUL4pAlvSuv9NqGbkHSaHO3iauX5h9
         Eq0A==
X-Gm-Message-State: AOAM53114bLqQcKvUuLtY0cvvfLs2B+k9CCP6BI1O4k10OtrNswyF0PO
        srSpHAMtyUTWQk2IITc8QYU+GWhEEm9UQikohuAxFrbhQvRQGHBbJhvhn3zljkP5Bxjv2u1F8cb
        xKvXG8ntRnNT5Ushw2hhazSgTu9zBMoKF9r4iCV9lbg==
X-Received: by 2002:ac2:4e04:: with SMTP id e4mr5359405lfr.262.1633093406442;
        Fri, 01 Oct 2021 06:03:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpX5oCmRoWCHEpWVXbi6bKbL+sqS9HzOydiHsJnMzWwDbrix4EtD5dkPEdesZi+y4ker7dFw==
X-Received: by 2002:ac2:4e04:: with SMTP id e4mr5359335lfr.262.1633093405889;
        Fri, 01 Oct 2021 06:03:25 -0700 (PDT)
Received: from localhost.localdomain ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id m5sm732697lfg.121.2021.10.01.06.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 06:03:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] regulator: dt-bindings: maxim,max8997: convert to dtschema
Date:   Fri,  1 Oct 2021 15:02:49 +0200
Message-Id: <20211001130249.80405-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Maxim MAX8997 PMIC bindings to DT schema format.  Extend the
examples with additional one copied from kernel's exynos4210-origen.dts.
Also the binding descriptions are copied from old file, so license
entire work under GPL-2.0.

This also adds previously undocumented 32 kHz clock output modelled as
regulators.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/regulator/max8997-regulator.txt  | 145 ------
 .../bindings/regulator/maxim,max8997.yaml     | 445 ++++++++++++++++++
 2 files changed, 445 insertions(+), 145 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/max8997-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max8997.yaml

diff --git a/Documentation/devicetree/bindings/regulator/max8997-regulator.txt b/Documentation/devicetree/bindings/regulator/max8997-regulator.txt
deleted file mode 100644
index b53c5e2b335f..000000000000
--- a/Documentation/devicetree/bindings/regulator/max8997-regulator.txt
+++ /dev/null
@@ -1,145 +0,0 @@
-* Maxim MAX8997 Voltage and Current Regulator
-
-The Maxim MAX8997 is a multi-function device which includes voltage and
-current regulators, rtc, charger controller and other sub-blocks. It is
-interfaced to the host controller using a i2c interface. Each sub-block is
-addressed by the host system using different i2c slave address. This document
-describes the bindings for 'pmic' sub-block of max8997.
-
-Required properties:
-- compatible: Should be "maxim,max8997-pmic".
-- reg: Specifies the i2c slave address of the pmic block. It should be 0x66.
-
-- max8997,pmic-buck1-dvs-voltage: A set of 8 voltage values in micro-volt (uV)
-  units for buck1 when changing voltage using gpio dvs. Refer to [1] below
-  for additional information.
-
-- max8997,pmic-buck2-dvs-voltage: A set of 8 voltage values in micro-volt (uV)
-  units for buck2 when changing voltage using gpio dvs. Refer to [1] below
-  for additional information.
-
-- max8997,pmic-buck5-dvs-voltage: A set of 8 voltage values in micro-volt (uV)
-  units for buck5 when changing voltage using gpio dvs. Refer to [1] below
-  for additional information.
-
-[1] If none of the 'max8997,pmic-buck[1/2/5]-uses-gpio-dvs' optional
-    property is specified, the 'max8997,pmic-buck[1/2/5]-dvs-voltage'
-    property should specify atleast one voltage level (which would be a
-    safe operating voltage).
-
-    If either of the 'max8997,pmic-buck[1/2/5]-uses-gpio-dvs' optional
-    property is specified, then all the eight voltage values for the
-    'max8997,pmic-buck[1/2/5]-dvs-voltage' should be specified.
-
-Optional properties:
-- interrupts: Interrupt specifiers for two interrupt sources.
-  - First interrupt specifier is for 'irq1' interrupt.
-  - Second interrupt specifier is for 'alert' interrupt.
-- charger-supply: regulator node for charging current.
-- max8997,pmic-buck1-uses-gpio-dvs: 'buck1' can be controlled by gpio dvs.
-- max8997,pmic-buck2-uses-gpio-dvs: 'buck2' can be controlled by gpio dvs.
-- max8997,pmic-buck5-uses-gpio-dvs: 'buck5' can be controlled by gpio dvs.
-
-Additional properties required if either of the optional properties are used:
-- max8997,pmic-ignore-gpiodvs-side-effect: When GPIO-DVS mode is used for
-  multiple bucks, changing the voltage value of one of the bucks may affect
-  that of another buck, which is the side effect of the change (set_voltage).
-  Use this property to ignore such side effects and change the voltage.
-
-- max8997,pmic-buck125-default-dvs-idx: Default voltage setting selected from
-  the possible 8 options selectable by the dvs gpios. The value of this
-  property should be between 0 and 7. If not specified or if out of range, the
-  default value of this property is set to 0.
-
-- max8997,pmic-buck125-dvs-gpios: GPIO specifiers for three host gpio's used
-  for dvs. The format of the gpio specifier depends in the gpio controller.
-
-Regulators: The regulators of max8997 that have to be instantiated should be
-included in a sub-node named 'regulators'. Regulator nodes included in this
-sub-node should be of the format as listed below.
-
-	regulator_name {
-		standard regulator bindings here
-	};
-
-The following are the names of the regulators that the max8997 pmic block
-supports. Note: The 'n' in LDOn and BUCKn represents the LDO or BUCK number
-as per the datasheet of max8997.
-
-	- LDOn
-		  - valid values for n are 1 to 18 and 21
-		  - Example: LDO0, LD01, LDO2, LDO21
-	- BUCKn
-		  - valid values for n are 1 to 7.
-		  - Example: BUCK1, BUCK2, BUCK3, BUCK7
-
-	- ENVICHG: Battery Charging Current Monitor Output. This is a fixed
-		   voltage type regulator
-
-	- ESAFEOUT1: (ldo19)
-	- ESAFEOUT2: (ld020)
-
-	- CHARGER_CV: main battery charger voltage control
-	- CHARGER: main battery charger current control
-	- CHARGER_TOPOFF: end of charge current threshold level
-
-The bindings inside the regulator nodes use the standard regulator bindings
-which are documented elsewhere.
-
-Example:
-
-	max8997_pmic@66 {
-		compatible = "maxim,max8997-pmic";
-		interrupt-parent = <&wakeup_eint>;
-		reg = <0x66>;
-		interrupts = <4 0>, <3 0>;
-
-		max8997,pmic-buck1-uses-gpio-dvs;
-		max8997,pmic-buck2-uses-gpio-dvs;
-		max8997,pmic-buck5-uses-gpio-dvs;
-
-		max8997,pmic-ignore-gpiodvs-side-effect;
-		max8997,pmic-buck125-default-dvs-idx = <0>;
-
-		max8997,pmic-buck125-dvs-gpios = <&gpx0 0 1 0 0>, /* SET1 */
-						 <&gpx0 1 1 0 0>, /* SET2 */
-						 <&gpx0 2 1 0 0>; /* SET3 */
-
-		max8997,pmic-buck1-dvs-voltage = <1350000>, <1300000>,
-						 <1250000>, <1200000>,
-						 <1150000>, <1100000>,
-						 <1000000>, <950000>;
-
-		max8997,pmic-buck2-dvs-voltage = <1100000>, <1100000>,
-						 <1100000>, <1100000>,
-						 <1000000>, <1000000>,
-						 <1000000>, <1000000>;
-
-		max8997,pmic-buck5-dvs-voltage = <1200000>, <1200000>,
-						 <1200000>, <1200000>,
-						 <1200000>, <1200000>,
-						 <1200000>, <1200000>;
-
-		regulators {
-			ldo1_reg: LDO1 {
-				regulator-name = "VDD_ABB_3.3V";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			ldo2_reg: LDO2 {
-				regulator-name = "VDD_ALIVE_1.1V";
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-always-on;
-			};
-
-			buck1_reg: BUCK1 {
-				regulator-name = "VDD_ARM_1.2V";
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml b/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml
new file mode 100644
index 000000000000..d5a44ca3df04
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml
@@ -0,0 +1,445 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/maxim,max8997.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX8997 Power Management IC
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  The Maxim MAX8997 is a Power Management IC which includes voltage and current
+  regulators, charger controller with fuel gauge, RTC, clock outputs, haptic
+  motor driver, flash LED driver and Micro-USB Interface Controller.
+
+  The binding here is not complete and describes only regulator and charger
+  controller parts.
+
+properties:
+  compatible:
+    const: maxim,max8997-pmic
+
+  charger-supply:
+    description: |
+      Regulator node for charging current.
+
+  interrupts:
+    items:
+      - description: irq1 interrupt
+      - description: alert interrupt
+
+  max8997,pmic-buck1-dvs-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 8
+    description: |
+      A set of 8 voltage values in micro-volt (uV) units for buck1 when
+      changing voltage using GPIO DVS.
+      If none of max8997,pmic-buck[1/2/5]-uses-gpio-dvs optional property is
+      specified, the max8997,pmic-buck[1/2/5]-dvs-voltage property should
+      specify at least one voltage level (which would be a safe operating
+      voltage).
+
+  max8997,pmic-buck2-dvs-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 8
+    description: |
+      A set of 8 voltage values in micro-volt (uV) units for buck2 when
+      changing voltage using GPIO DVS.
+      If none of max8997,pmic-buck[1/2/5]-uses-gpio-dvs optional property is
+      specified, the max8997,pmic-buck[1/2/5]-dvs-voltage property should
+      specify at least one voltage level (which would be a safe operating
+      voltage).
+
+  max8997,pmic-buck5-dvs-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 8
+    description: |
+      A set of 8 voltage values in micro-volt (uV) units for buck5 when
+      changing voltage using GPIO DVS.
+      If none of max8997,pmic-buck[1/2/5]-uses-gpio-dvs optional property is
+      specified, the max8997,pmic-buck[1/2/5]-dvs-voltage property should
+      specify at least one voltage level (which would be a safe operating
+      voltage).
+
+  max8997,pmic-buck1-uses-gpio-dvs:
+    type: boolean
+    description: |
+      buck1 can be controlled by GPIO DVS.
+
+  max8997,pmic-buck2-uses-gpio-dvs:
+    type: boolean
+    description: |
+      buck2 can be controlled by GPIO DVS.
+
+  max8997,pmic-buck5-uses-gpio-dvs:
+    type: boolean
+    description: |
+      buck5 can be controlled by GPIO DVS.
+
+  max8997,pmic-buck125-default-dvs-idx:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+    default: 0
+    description: |
+      Default voltage setting selected from the possible 8 options selectable
+      by the dvs gpios. The value of this property should be between 0 and 7.
+      If not specified or if out of range, the default value of this property
+      is set to 0.
+
+  max8997,pmic-buck125-dvs-gpios:
+    minItems: 3
+    maxItems: 3
+    description: |
+      GPIO specifiers for three host gpio's used for DVS.
+
+  max8997,pmic-ignore-gpiodvs-side-effect:
+    type: boolean
+    description: |
+      When GPIO-DVS mode is used for multiple bucks, changing the voltage value
+      of one of the bucks may affect that of another buck, which is the side
+      effect of the change (set_voltage).  Use this property to ignore such
+      side effects and change the voltage.
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description:
+      List of child nodes that specify the regulators.
+
+    patternProperties:
+      # 1-18 and 21 LDOs
+      "^LDO([1-9]|1[0-8]|21)$":
+        type: object
+        $ref: regulator.yaml#
+        description:
+          Properties for single LDO regulator.
+
+        properties:
+          regulator-name: true
+
+        required:
+          - regulator-name
+
+        unevaluatedProperties: false
+
+      # 7 bucks
+      "^BUCK[1-7]$":
+        type: object
+        $ref: regulator.yaml#
+        description:
+          Properties for single BUCK regulator.
+
+        properties:
+          regulator-name: true
+
+        required:
+          - regulator-name
+
+        unevaluatedProperties: false
+
+      "^EN32KHZ_[AC]P$":
+        type: object
+        $ref: regulator.yaml#
+        description:
+          32768 Hz clock output (modelled as regulator)
+
+        properties:
+          regulator-name: true
+          regulator-always-on: true
+          regulator-boot-on: true
+
+        required:
+          - regulator-name
+
+        additionalProperties: false
+
+    properties:
+      CHARGER:
+        type: object
+        $ref: regulator.yaml#
+        description: main battery charger current control
+
+        properties:
+          regulator-name: true
+
+        required:
+          - regulator-name
+
+        unevaluatedProperties: false
+
+      CHARGER_CV:
+        type: object
+        $ref: regulator.yaml#
+        description: main battery charger voltage control
+
+        properties:
+          regulator-name: true
+
+        required:
+          - regulator-name
+
+        unevaluatedProperties: false
+
+      CHARGER_TOPOFF:
+        type: object
+        $ref: regulator.yaml#
+        description: end of charge current threshold level
+
+        properties:
+          regulator-name: true
+
+        required:
+          - regulator-name
+
+        unevaluatedProperties: false
+
+      ENVICHG:
+        type: object
+        $ref: regulator.yaml#
+        description: |
+          Battery Charging Current Monitor Output. This is a fixed voltage type
+          regulator
+        properties:
+          regulator-name: true
+
+        required:
+          - regulator-name
+
+        unevaluatedProperties: false
+
+      ESAFEOUT1:
+        type: object
+        $ref: regulator.yaml#
+        description: LDO19
+
+        properties:
+          regulator-name: true
+
+        required:
+          - regulator-name
+
+        unevaluatedProperties: false
+
+      ESAFEOUT2:
+        type: object
+        $ref: regulator.yaml#
+        description: LDO20
+
+        properties:
+          regulator-name: true
+
+        required:
+          - regulator-name
+
+        unevaluatedProperties: false
+
+required:
+  - compatible
+  - max8997,pmic-buck1-dvs-voltage
+  - max8997,pmic-buck2-dvs-voltage
+  - max8997,pmic-buck5-dvs-voltage
+  - reg
+  - regulators
+
+dependencies:
+  max8997,pmic-buck1-uses-gpio-dvs: [ 'max8997,pmic-buck125-dvs-gpios' ]
+  max8997,pmic-buck2-uses-gpio-dvs: [ 'max8997,pmic-buck125-dvs-gpios' ]
+  max8997,pmic-buck5-uses-gpio-dvs: [ 'max8997,pmic-buck125-dvs-gpios' ]
+
+additionalProperties: false
+
+if:
+  anyOf:
+    - required:
+        - max8997,pmic-buck1-uses-gpio-dvs
+    - required:
+        - max8997,pmic-buck2-uses-gpio-dvs
+    - required:
+        - max8997,pmic-buck5-uses-gpio-dvs
+then:
+  properties:
+    max8997,pmic-buck1-dvs-voltage:
+      minItems: 8
+      maxItems: 8
+    max8997,pmic-buck2-dvs-voltage:
+      minItems: 8
+      maxItems: 8
+    max8997,pmic-buck5-dvs-voltage:
+      minItems: 8
+      maxItems: 8
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@66 {
+            compatible = "maxim,max8997-pmic";
+            reg = <0x66>;
+
+            interrupts-extended = <&gpx0 7 IRQ_TYPE_LEVEL_LOW>,
+                                  <&gpx2 3 IRQ_TYPE_EDGE_FALLING>;
+
+            max8997,pmic-buck1-uses-gpio-dvs;
+            max8997,pmic-buck2-uses-gpio-dvs;
+            max8997,pmic-buck5-uses-gpio-dvs;
+
+            max8997,pmic-ignore-gpiodvs-side-effect;
+            max8997,pmic-buck125-default-dvs-idx = <0>;
+
+            max8997,pmic-buck125-dvs-gpios = <&gpx0 5 GPIO_ACTIVE_HIGH>,
+                                             <&gpx0 6 GPIO_ACTIVE_HIGH>,
+                                             <&gpl0 0 GPIO_ACTIVE_HIGH>;
+
+            max8997,pmic-buck1-dvs-voltage = <1350000>, <1300000>,
+                                             <1250000>, <1200000>,
+                                             <1150000>, <1100000>,
+                                             <1000000>, <950000>;
+
+            max8997,pmic-buck2-dvs-voltage = <1100000>, <1000000>,
+                                             <950000>,  <900000>,
+                                             <1100000>, <1000000>,
+                                             <950000>,  <900000>;
+
+            max8997,pmic-buck5-dvs-voltage = <1200000>, <1200000>,
+                                             <1200000>, <1200000>,
+                                             <1200000>, <1200000>,
+                                             <1200000>, <1200000>;
+
+            pinctrl-0 = <&max8997_irq>, <&otg_gp>, <&usb_sel>;
+            pinctrl-names = "default";
+
+            charger-supply = <&charger_reg>;
+
+            regulators {
+                LDO1 {
+                    regulator-name = "VADC_3.3V_C210";
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-always-on;
+                };
+
+                LDO2 {
+                    regulator-name = "VALIVE_1.1V_C210";
+                    regulator-min-microvolt = <1100000>;
+                    regulator-max-microvolt = <1100000>;
+                    regulator-always-on;
+                };
+
+                BUCK1 {
+                    regulator-name = "VARM_1.2V_C210";
+                    regulator-min-microvolt = <65000>;
+                    regulator-max-microvolt = <2225000>;
+                    regulator-always-on;
+                };
+
+                // ...
+
+                BUCK7 {
+                    regulator-name = "VCC_SUB_2.0V";
+                    regulator-min-microvolt = <2000000>;
+                    regulator-max-microvolt = <2000000>;
+                    regulator-always-on;
+                };
+
+                ESAFEOUT1 {
+                    regulator-name = "SAFEOUT1";
+                };
+
+                ESAFEOUT2 {
+                    regulator-name = "SAFEOUT2";
+                    regulator-boot-on;
+                };
+
+                EN32KHZ_AP {
+                    regulator-name = "EN32KHZ_AP";
+                    regulator-always-on;
+                };
+
+                EN32KHZ_CP {
+                    regulator-name = "EN32KHZ_CP";
+                    regulator-always-on;
+                };
+
+                CHARGER {
+                    regulator-name = "CHARGER";
+                    regulator-min-microamp = <200000>;
+                    regulator-max-microamp = <950000>;
+                };
+
+                CHARGER_CV {
+                    regulator-name = "CHARGER_CV";
+                    regulator-min-microvolt = <4200000>;
+                    regulator-max-microvolt = <4200000>;
+                    regulator-always-on;
+                };
+
+                CHARGER_TOPOFF {
+                    regulator-name = "CHARGER_TOPOFF";
+                    regulator-min-microamp = <200000>;
+                    regulator-max-microamp = <200000>;
+                    regulator-always-on;
+                };
+            };
+        };
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@66 {
+            compatible = "maxim,max8997-pmic";
+            reg = <0x66>;
+
+            interrupt-parent = <&gpx0>;
+            interrupts = <4 IRQ_TYPE_LEVEL_LOW>,
+                         <3 IRQ_TYPE_EDGE_FALLING>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&max8997_irq>;
+
+            max8997,pmic-buck1-dvs-voltage = <1350000>;
+            max8997,pmic-buck2-dvs-voltage = <1100000>;
+            max8997,pmic-buck5-dvs-voltage = <1200000>;
+
+            regulators {
+                LDO1 {
+                    regulator-name = "VDD_ABB_3.3V";
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <3300000>;
+                };
+
+                // ...
+
+                BUCK1 {
+                    regulator-name = "VDD_ARM_1.2V";
+                    regulator-min-microvolt = <950000>;
+                    regulator-max-microvolt = <1350000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                };
+
+                // ...
+
+                EN32KHZ_AP {
+                    regulator-name = "EN32KHZ_AP";
+                    regulator-always-on;
+                };
+            };
+        };
+    };
-- 
2.30.2

