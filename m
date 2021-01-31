Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331C0309F2B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 23:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhAaWCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 17:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbhAaV72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 16:59:28 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA2AC061573;
        Sun, 31 Jan 2021 13:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=inPeTh18wjb0l+HhRSID9H7hT121FY9CPy5oZ+1jTps=; b=Ifrrjxp/+X61a1oz8ELWA3upBq
        /vmoRpUsbiCcUkKq9mIhR0/0KcKVbAvVPHzLc/DsOFn/Yrunq/OZ1Oeroa85JM+1Czd3sVcjfyFYt
        sMyJwi60QFryIwkdGcBlgKwlTMJEFA0R80cq7sYWYvPMcMov1b7Hs2Jp9Ul4xZkWLWJI=;
Received: from p200300ccff48ca001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff48:ca00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1l6KjG-0003SU-Mc; Sun, 31 Jan 2021 22:57:58 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1l6KjG-0001Dn-AE; Sun, 31 Jan 2021 22:57:58 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, robh+dt@kernel.org, andreas@kemnade.info,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.galvani@gmail.com, stefan@agner.ch
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH RESEND v2] dt-bindings: mfd: Convert rn5t618 to json-schema
Date:   Sun, 31 Jan 2021 22:57:30 +0100
Message-Id: <20210131215730.4647-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the RN5T618 binding to DT schema format. Also
clearly state which regulators are available.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: Rob Herring <robh@kernel.org>
---
https://lore.kernel.org/lkml/CAL_JsqJWt91+aZwAWEUVjOBQgsYw6GBHqmoHwU_T5qZabxX+Aw@mail.gmail.com/

Changes in v2:
- drop irq description

Due to its .txt-format history BSD license was not added.
 .../bindings/mfd/ricoh,rn5t618.yaml           | 111 ++++++++++++++++++
 .../devicetree/bindings/mfd/rn5t618.txt       |  52 --------
 2 files changed, 111 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/rn5t618.txt

diff --git a/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
new file mode 100644
index 000000000000..d70e85a09c84
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ricoh,rn5t618.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ricoh RN5T567/RN5T618/RC5T619 PMIC
+
+maintainers:
+  - Andreas Kemnade <andreas@kemnade.info>
+
+description: |
+  Ricoh RN5T567/RN5T618/RC5T619 is a power management IC family which
+  integrates 3 to 5 step-down DCDC converters, 7 to 10 low-dropout regulators,
+  GPIOs, and a watchdog timer. It can be controlled through an I2C interface.
+  The RN5T618/RC5T619 provides additionally a Li-ion battery charger,
+  fuel gauge, and an ADC.
+  The RC5T619 additionnally includes USB charger detection and an RTC.
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ricoh,rn5t567
+    then:
+      properties:
+        regulators:
+          patternProperties:
+            "^(DCDC[1-4]|LDO[1-5]|LDORTC[12])$":
+              $ref: ../regulator/regulator.yaml
+          additionalProperties: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ricoh,rn5t618
+    then:
+      properties:
+        regulators:
+          patternProperties:
+            "^(DCDC[1-3]|LDO[1-5]|LDORTC[12])$":
+              $ref: ../regulator/regulator.yaml
+          additionalProperties: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ricoh,rc5t619
+    then:
+      properties:
+        regulators:
+          patternProperties:
+            "^(DCDC[1-5]|LDO[1-9]|LDO10|LDORTC[12])$":
+              $ref: ../regulator/regulator.yaml
+          additionalProperties: false
+
+properties:
+  compatible:
+    enum:
+      - ricoh,rn5t567
+      - ricoh,rn5t618
+      - ricoh,rc5t619
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  system-power-controller:
+    type: boolean
+    description: |
+      See Documentation/devicetree/bindings/power/power-controller.txt
+
+  regulators:
+    type: object
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic@32 {
+        compatible = "ricoh,rn5t618";
+        reg = <0x32>;
+        interrupt-parent = <&gpio5>;
+        interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+        system-power-controller;
+
+        regulators {
+          DCDC1 {
+            regulator-min-microvolt = <1050000>;
+            regulator-max-microvolt = <1050000>;
+          };
+
+          DCDC2 {
+            regulator-min-microvolt = <1175000>;
+            regulator-max-microvolt = <1175000>;
+          };
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/mfd/rn5t618.txt b/Documentation/devicetree/bindings/mfd/rn5t618.txt
deleted file mode 100644
index 16778ea00dbc..000000000000
--- a/Documentation/devicetree/bindings/mfd/rn5t618.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-* Ricoh RN5T567/RN5T618 PMIC
-
-Ricoh RN5T567/RN5T618/RC5T619 is a power management IC family which
-integrates 3 to 5 step-down DCDC converters, 7 to 10 low-dropout regulators,
-GPIOs, and a watchdog timer. It can be controlled through an I2C interface.
-The RN5T618/RC5T619 provides additionally a Li-ion battery charger,
-fuel gauge, and an ADC.
-The RC5T619 additionnally includes USB charger detection and an RTC.
-
-Required properties:
- - compatible: must be one of
-		"ricoh,rn5t567"
-		"ricoh,rn5t618"
-		"ricoh,rc5t619"
- - reg: the I2C slave address of the device
-
-Optional properties:
- - interrupts: interrupt mapping for IRQ
-   See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
- - system-power-controller:
-   See Documentation/devicetree/bindings/power/power-controller.txt
-
-Sub-nodes:
- - regulators: the node is required if the regulator functionality is
-   needed. The valid regulator names are: DCDC1, DCDC2, DCDC3, DCDC4
-   (RN5T567/RC5T619), LDO1, LDO2, LDO3, LDO4, LDO5, LDO6, LDO7, LDO8,
-   LDO9, LDO10, LDORTC1 and LDORTC2.
-   LDO7-10 are specific to RC5T619.
-   The common bindings for each individual regulator can be found in:
-   Documentation/devicetree/bindings/regulator/regulator.txt
-
-Example:
-
-	pmic@32 {
-		compatible = "ricoh,rn5t618";
-		reg = <0x32>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
-		system-power-controller;
-
-		regulators {
-			DCDC1 {
-				regulator-min-microvolt = <1050000>;
-				regulator-max-microvolt = <1050000>;
-			};
-
-			DCDC2 {
-				regulator-min-microvolt = <1175000>;
-				regulator-max-microvolt = <1175000>;
-			};
-		};
-	};
-- 
2.20.1

