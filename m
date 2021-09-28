Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587D541B1D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbhI1OQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 10:16:15 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39392
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241003AbhI1OQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:16:13 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C07A640300
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632838473;
        bh=kr/qddPqetj9p+Lio+2f6nDLzbZKDQizoD0Kdmeh6CY=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=SfTZSftnOc0+Pa7eAatezoT4B+ybY34N7959txZCg9tbT1ms4wvwE+lLhef7Ftx0/
         B1DHvf9Ed7NjU/KnXnhsCguBQAJ+1nn5wkc4L8yQNQl0oInA+zd2JZu1kqyUauYjax
         uUk6wvlu3WLCHdujusuBFDiTijZ8aLBaOibaigRP1FFe9gy6ZtJiJuIa1BRC4OP+bc
         id5CrtO5NjWVvc+JBOhmQjJo5+NiLb2saivtFvAHYallOBFshzzy0C5AlP8C26U+GZ
         SQoiCDVsfdRByYpKMqRO2ulvRCqR/EWOxSKwAhtL12weadHj50xHcNWht7DN92CFU8
         lGgfeFlpCh+3Q==
Received: by mail-lf1-f71.google.com with SMTP id x33-20020a0565123fa100b003fcfd99073dso1963213lfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kr/qddPqetj9p+Lio+2f6nDLzbZKDQizoD0Kdmeh6CY=;
        b=rE2xpriCfSityMSImc+t4+b0Z3JrElkfdJF1RGSaPwpkBhxysqt06/eGxqVytAVSxX
         OGRmGmj2ovFwbYTNuxAWsksaTneR506pRAOJQUKkZ7sj0DbOm9L4kZ8+GMV4kmitqQ96
         x8MV0LganDDBWB9NQrr8zrq6UJ3eAM3AoRISY8RRdFcCyFxVMlNZEWmCX3eQDkCyMRtK
         FsPicB8P82i8TZOwGZ58i3FeuQo0GcSudonsMwxeT7jDfqznPNkQnDBZubGOk476L6vU
         l8jJwypNzVpLXwythnV/6OQ71llXalMlS82vDOk32Uilwt2Uf6kY6XePsAElslJDc0zO
         AKxg==
X-Gm-Message-State: AOAM531cNKQfvF32G/CjGGgcelWqzVO93g1PRyz+LOb+OGWqUUD29zb4
        Kk0C26kWyIBVXWXmWnDu+UppVYBXWpWQ7z8c5QKptmXPZoQsIq0/dEUhCW6bovb9r8rkczB4wf6
        E5Ohk1JUTWNgN43/5LALj1S0+FOCoyCPp/wlXZ1YrjQ==
X-Received: by 2002:ac2:5a10:: with SMTP id q16mr1671983lfn.337.1632838472988;
        Tue, 28 Sep 2021 07:14:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpAzXRD5rjv0m8zWOTMT35Cly9f01wZkW3W32PUPwT65jqxMglzNw+JSm6Icd6u+4H/IwodQ==
X-Received: by 2002:ac2:5a10:: with SMTP id q16mr1671959lfn.337.1632838472771;
        Tue, 28 Sep 2021 07:14:32 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w19sm2353241ljd.110.2021.09.28.07.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 07:14:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] regulator: dt-bindings: maxim,max77686: convert to dtschema
Date:   Tue, 28 Sep 2021 16:13:52 +0200
Message-Id: <20210928141353.112619-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210928141353.112619-1-krzysztof.kozlowski@canonical.com>
References: <20210928141353.112619-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the regulators of Maxim MAX77686 PMIC to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/regulator/max77686.txt           | 71 --------------
 .../bindings/regulator/maxim,max77686.yaml    | 92 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 93 insertions(+), 71 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/max77686.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77686.yaml

diff --git a/Documentation/devicetree/bindings/regulator/max77686.txt b/Documentation/devicetree/bindings/regulator/max77686.txt
deleted file mode 100644
index e9f7578ca09a..000000000000
--- a/Documentation/devicetree/bindings/regulator/max77686.txt
+++ /dev/null
@@ -1,71 +0,0 @@
-Binding for Maxim MAX77686 regulators
-
-This is a part of the device tree bindings of MAX77686 multi-function device.
-More information can be found in ../mfd/max77686.txt file.
-
-The MAX77686 PMIC has 9 high-efficiency Buck and 26 Low-DropOut (LDO)
-regulators that can be controlled over I2C.
-
-Following properties should be present in main device node of the MFD chip.
-
-Optional node:
-- voltage-regulators : The regulators of max77686 have to be instantiated
-  under subnode named "voltage-regulators" using the following format.
-
-	regulator_name {
-		regulator-compatible = LDOn/BUCKn
-		standard regulator constraints....
-	};
-	refer Documentation/devicetree/bindings/regulator/regulator.txt
-
-  The regulator node's name should be initialized with a string
-to get matched with their hardware counterparts as follow:
-
-	-LDOn 	:	for LDOs, where n can lie in range 1 to 26.
-			example: LDO1, LDO2, LDO26.
-	-BUCKn 	:	for BUCKs, where n can lie in range 1 to 9.
-			example: BUCK1, BUCK5, BUCK9.
-
-  Regulators which can be turned off during system suspend:
-	-LDOn	:	2, 6-8, 10-12, 14-16,
-	-BUCKn	:	1-4.
-  Use standard regulator bindings for it ('regulator-off-in-suspend').
-
-  LDO20, LDO21, LDO22, BUCK8 and BUCK9 can be configured to GPIO enable
-  control. To turn this feature on this property must be added to the regulator
-  sub-node:
-	- maxim,ena-gpios :	one GPIO specifier enable control (the gpio
-				flags are actually ignored and always
-				ACTIVE_HIGH is used)
-
-Example:
-
-	max77686: pmic@9 {
-		compatible = "maxim,max77686";
-		interrupt-parent = <&wakeup_eint>;
-		interrupts = <26 IRQ_TYPE_NONE>;
-		reg = <0x09>;
-
-		voltage-regulators {
-			ldo11_reg: LDO11 {
-				regulator-name = "vdd_ldo11";
-				regulator-min-microvolt = <1900000>;
-				regulator-max-microvolt = <1900000>;
-				regulator-always-on;
-			};
-
-			buck1_reg: BUCK1 {
-				regulator-name = "vdd_mif";
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			buck9_reg: BUCK9 {
-				regulator-name = "CAM_ISP_CORE_1.2V";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1200000>;
-				maxim,ena-gpios = <&gpm0 3 GPIO_ACTIVE_HIGH>;
-			};
-	};
diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77686.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77686.yaml
new file mode 100644
index 000000000000..33a80a8caf26
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max77686.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/maxim,max77686.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77686 Power Management IC regulators
+
+maintainers:
+  - Chanwoo Choi <cw00.choi@samsung.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77686 Power Management
+  Integrated Circuit (PMIC).
+
+  The Maxim MAX77686 provides high-efficiency Buck and 26 Low-DropOut (LDO)
+  regulators.
+
+  See also Documentation/devicetree/bindings/mfd/maxim,max77686.yaml for
+  additional information and example.
+
+patternProperties:
+  # 26 LDOs
+  "^LDO([1-9]|1[0-9]|2[0-6])$":
+    type: object
+    $ref: regulator.yaml#
+    description: |
+      Properties for single LDO regulator.
+      Regulators which can be turned off during system suspend:
+        LDO2, LDO6-8, LDO10-12, LDO14-16
+
+    properties:
+      regulator-name: true
+
+      maxim,ena-gpios:
+        maxItems: 1
+        description: |
+          GPIO specifier to enable the GPIO control (on/off) for regulator.
+
+    required:
+      - regulator-name
+
+    unevaluatedProperties: false
+
+    allOf:
+      - if:
+          properties:
+            $nodename:
+              pattern: "^(LDO20|LDO21|LDO22|BUCK8|BUCK9)$"
+        then:
+          properties:
+            maxim,ena-gpios: true
+        else:
+          properties:
+            maxim,ena-gpios: false
+
+  # 9 bucks
+  "^BUCK[1-9]$":
+    type: object
+    $ref: regulator.yaml#
+    description: |
+      Properties for single BUCK regulator.
+      Regulators which can be turned off during system suspend:
+      BUCK[1-4]
+
+    properties:
+      regulator-name: true
+
+      maxim,ena-gpios:
+        maxItems: 1
+        description: |
+          GPIO specifier to enable the GPIO control (on/off) for regulator.
+
+    required:
+      - regulator-name
+
+    unevaluatedProperties: false
+
+    allOf:
+      - if:
+          properties:
+            $nodename:
+              pattern: "^(LDO20|LDO21|LDO22|BUCK8|BUCK9)$"
+        then:
+          properties:
+            maxim,ena-gpios: true
+        else:
+          properties:
+            maxim,ena-gpios: false
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index 39b4ef4b5a95..32b55f9ab76a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11469,6 +11469,7 @@ M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/*/max77686.txt
+F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
 F:	Documentation/devicetree/bindings/mfd/max14577.txt
 F:	Documentation/devicetree/bindings/mfd/max77693.txt
-- 
2.30.2

