Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DB545D5C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbhKYHxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:53:55 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59198
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236384AbhKYHvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:51:49 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 974D340A02
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 07:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637826517;
        bh=qwEOXx7QmHM4SPQS7W1jrbDlksKsweg6zUhLr3HLmQw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=UiJPgswsd18+SxJNBrcdRC5easPykz1gnfoUgSbaxIM3g7HU/1du1pWI/ZnIsljFm
         phDCztBtOAhfYAR5C36oQeX4AocZ5MYdqDY5I1DEycPrcrmKXWyRM39kHEH4kI4gnR
         1hDYPs6smP4SjZdxKPsdcBZ6ZvbQA6lh0FeDNMyWm1lrP+cXxuK6hNeq3Pe4DFZfva
         SAuV7UzcxyPR7jWEp/I5lMP1H59cTUp1w9F87iVVSoIjoQ/owmO9L47LwMVdWFJF89
         jsKg7IfP8+M0h0FZKEWOgaOeMOwLhVBPOcafzBjcxVUQ5zJp3+8coxzqbxrzc4XL+Y
         kdPiiqzwm1Hwg==
Received: by mail-wm1-f72.google.com with SMTP id 201-20020a1c04d2000000b003335bf8075fso2782464wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 23:48:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qwEOXx7QmHM4SPQS7W1jrbDlksKsweg6zUhLr3HLmQw=;
        b=4CnurbOEN6sCYK0161Acgd0hl5NRzJVXOI8gOvWPeXUWr2A+YQiJRn38J2dWWW1isx
         Q5YTSIhhgeJO5gyfOwI1n/1mvSvZFsB/epEzUMbTID9SVLmLg1tPIc6YVETZOH/w1TzE
         LjvD/zZAqdFCYIykN1YTHiwvL7Da+s5L5jb1Q5IMpOT+L+y2Dk6O6oNrp13vbLqa36SS
         8C37Bbg3zSGk+n5P0TWvwIZyX2pDXLCN136tPg5cIro9AHqiyYX9clOSuKg6xyPLrUhz
         765KRXnNzJV2EcnrNYd+cLo63V5/PoRYg2gj1l2XNsLHaCfUtWKtM4EBjvO5vz9zuNt5
         UfVQ==
X-Gm-Message-State: AOAM533RLLIia7w9jGT8/i0Ll7buzskcPP/qS/m3m3hSBDGxaxbviKH1
        ykKZJCs4/1wVIwkTB8LP1D/BnBPjtuZ5wpykRp2eJHX46Rdq6QuSVPBoo+BhCk/8t6kHtWsyhaJ
        1JK6TZLHLb8H4KcFjtlCvPBu8GAfYUP2buULs6QwzjQ==
X-Received: by 2002:a7b:c744:: with SMTP id w4mr4849874wmk.50.1637826516018;
        Wed, 24 Nov 2021 23:48:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrWo/YCaIdOUSWN6rdG6srBxwGmV5NwDFzHK3FHmVQHqYwqk3q3WEaQAebm7+UlAXkCFpSvQ==
X-Received: by 2002:a7b:c744:: with SMTP id w4mr4849833wmk.50.1637826515757;
        Wed, 24 Nov 2021 23:48:35 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id o3sm8087937wms.10.2021.11.24.23.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 23:48:35 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] regulator: dt-bindings: maxim,max77686: convert to dtschema
Date:   Thu, 25 Nov 2021 08:48:25 +0100
Message-Id: <20211125074826.7947-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211125074826.7947-1-krzysztof.kozlowski@canonical.com>
References: <20211125074826.7947-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the regulators of Maxim MAX77686 PMIC to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v2:
1. Rebased.
2. Add Rob's tag.

Changes since v1:
1. Split regulator nodes pattern on those supporting ena-gpios and those
   don't.
2. Drop regulator-name from properties.
3. Add Mark's tag.
---
 .../bindings/regulator/max77686.txt           | 71 ----------------
 .../bindings/regulator/maxim,max77686.yaml    | 83 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 84 insertions(+), 71 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/max77686.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77686.yaml

diff --git a/Documentation/devicetree/bindings/regulator/max77686.txt b/Documentation/devicetree/bindings/regulator/max77686.txt
deleted file mode 100644
index ff3d2dec8c4b..000000000000
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
-		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
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
index 000000000000..bb64b679f765
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max77686.yaml
@@ -0,0 +1,83 @@
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
+  "^LDO([1-9]|1[0-9]|2[3-6])$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description: |
+      Properties for single LDO regulator.
+      Regulators which can be turned off during system suspend:
+        LDO2, LDO6-8, LDO10-12, LDO14-16
+
+    required:
+      - regulator-name
+
+  # LDO20-LDO22 with maxim,ena-gpios
+  "^LDO2[0-2]$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description: |
+      Properties for single LDO regulator.
+
+    properties:
+      maxim,ena-gpios:
+        maxItems: 1
+        description: |
+          GPIO specifier to enable the GPIO control (on/off) for regulator.
+
+    required:
+      - regulator-name
+
+  # 9 bucks
+  "^BUCK[1-7]$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description: |
+      Properties for single BUCK regulator.
+      Regulators which can be turned off during system suspend:
+      BUCK[1-4]
+
+    required:
+      - regulator-name
+
+  "^BUCK[89]$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description: |
+      Properties for single BUCK regulator.
+
+    properties:
+      maxim,ena-gpios:
+        maxItems: 1
+        description: |
+          GPIO specifier to enable the GPIO control (on/off) for regulator.
+
+    required:
+      - regulator-name
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index 00ad0cb5cb05..aa12b807d3f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11661,6 +11661,7 @@ M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/*/max77686.txt
+F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
 F:	Documentation/devicetree/bindings/mfd/max14577.txt
 F:	Documentation/devicetree/bindings/mfd/max77693.txt
-- 
2.32.0

