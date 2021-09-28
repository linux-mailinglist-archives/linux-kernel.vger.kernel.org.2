Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99ABF41AB11
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbhI1Iv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:51:58 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48352
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239770AbhI1Ivp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:51:45 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E696E40790
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 08:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632819005;
        bh=FZeW9gTOBHOnj8RTLRGKPiUIpWhM3rlR/d03KzWXwvc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=O1IKlfOG1K9Wj0VqxH16dlAMg2AUMWbEZBuAKiCfGgJUPVEgHvS372vbDxPbXc3pQ
         88I0KNxA9lQRaOI29EdbOAlDZqx36/IxraKnKQA0vdinQC3Q3XF8SIT635jT1L8hVf
         l7r09X5GmDanOXW9EBij3e3sUJ76u06jz8qMr4rKuQAxH6cIJmCZaYEv+q/aOJkX5d
         tZgqhgoYn7K7Xnl6IwOsdEUJXfsemqir95l67KahVtaNiE5K8/dJl0ewbllJBpfVSj
         J7CRpGTqk0zgc7jQTnBs54NjxAHRrEoxNuzv0u4EMxkmBtDveng5x/bRtDUw7/cZGe
         Gfn0CHgPv/KrQ==
Received: by mail-lf1-f72.google.com with SMTP id n22-20020a0565120ad600b003fcc09af59fso13339039lfu.21
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 01:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FZeW9gTOBHOnj8RTLRGKPiUIpWhM3rlR/d03KzWXwvc=;
        b=TcltrG7FjwxrOzhFH9jciOpvuthreyR/d/r4zRBKUDKK26uHGQktlvFK0ka2KAr7jT
         1yEogmQBKSct8xcAwvcqXtDATRHKSwsvL30NySZPvbGI19921M06kH5E8KKDYOoQfTjb
         moRHoFGA93wxFnXt9mIdI3M2zN3JiP21IpxpCzQoziWs2Ckkz2YWNtpBTtFYSWLN4Kbt
         CEpvpFrcuoUkjJJ2jGTZXI/7JsRTDfm+tSWX+zQNthEBKIO9drVfvgUp4iruFAY3ozVx
         otwT/BIWdTv71Xm1P6dUgB3xgY8poLKueOk0bVlAUNklZqERU1GCmBTfzBJMtTLCp7QG
         9C1g==
X-Gm-Message-State: AOAM530crVT22QgQsLMuMHOdHdvL+XMpOoYGBNiSTxxjzDzVnLxNU13K
        Y37kZKPNoPK6KKy1v8EBPTe/ehT7A+ce19nHlOyCddNaeDC2KY63ts/RBaOJIboQfcMFhCafaHD
        e6rxhDh4X7GkzFe/Mb6a8ICImWcvTP/czpz3oxbgtbQ==
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr4570606lfp.127.1632819003867;
        Tue, 28 Sep 2021 01:50:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAZzVg855bdArpHqfbAoNZDubIXgrjxMQIxDJjyZHJURp6JO7ROVEy3wgEdr5Jm3E6Q/8Njw==
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr4570578lfp.127.1632819003649;
        Tue, 28 Sep 2021 01:50:03 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h13sm1848419lfl.205.2021.09.28.01.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 01:50:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 05/12] regulator: dt-bindings: samsung,s2mpa01: convert to dtschema
Date:   Tue, 28 Sep 2021 10:49:42 +0200
Message-Id: <20210928084949.27939-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210928084949.27939-1-krzysztof.kozlowski@canonical.com>
References: <20210928084949.27939-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the regulators of Samsung S2MPA01 PMIC to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/regulator/samsung,s2mpa01.txt    | 79 -------------------
 .../bindings/regulator/samsung,s2mpa01.yaml   | 69 ++++++++++++++++
 2 files changed, 69 insertions(+), 79 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2mpa01.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2mpa01.yaml

diff --git a/Documentation/devicetree/bindings/regulator/samsung,s2mpa01.txt b/Documentation/devicetree/bindings/regulator/samsung,s2mpa01.txt
deleted file mode 100644
index bae3c7f838cf..000000000000
--- a/Documentation/devicetree/bindings/regulator/samsung,s2mpa01.txt
+++ /dev/null
@@ -1,79 +0,0 @@
-Binding for Samsung S2MPA01 regulator block
-===========================================
-
-This is a part of device tree bindings for S2M family multi-function devices.
-More information can be found in bindings/mfd/sec-core.txt file.
-
-The S2MPA01 device provide buck and LDO regulators.
-
-To register these with regulator framework instantiate under main device node
-a sub-node named "regulators" with more sub-nodes for each regulator using the
-common regulator binding documented in:
- - Documentation/devicetree/bindings/regulator/regulator.txt
-
-
-Names of regulators supported by S2MPA01 device:
-	- LDOn
-		  - valid values for n are 1 to 26
-		  - Example: LDO1, LD02, LDO26
-	- BUCKn
-		  - valid values for n are 1 to 10.
-		  - Example: BUCK1, BUCK2, BUCK9
-Note: The 'n' in LDOn and BUCKn represents the LDO or BUCK number
-as per the datasheet of device.
-
-
-Optional properties of buck regulator nodes under "regulators" sub-node:
- - regulator-ramp-delay: ramp delay in uV/us. May be 6250, 12500
-   (default), 25000, or 50000. May be 0 for disabling the ramp delay on
-   BUCK{1,2,3,4}.
-
-   In the absence of the regulator-ramp-delay property, the default ramp
-   delay will be used.
-
-   Note: Some bucks share the ramp rate setting i.e. same ramp value
-   will be set for a particular group of bucks so provide the same
-   regulator-ramp-delay value for them.
-   Groups sharing ramp rate:
-    - buck{1,6},
-    - buck{2,4},
-    - buck{8,9,10}.
-
-Example:
-
-	s2mpa01_pmic@66 {
-		compatible = "samsung,s2mpa01-pmic";
-		reg = <0x66>;
-
-		regulators {
-			ldo1_reg: LDO1 {
-				regulator-name = "VDD_ALIVE";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-			};
-
-			ldo2_reg: LDO2 {
-				regulator-name = "VDDQ_MMC2";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-always-on;
-			};
-
-			buck1_reg: BUCK1 {
-				regulator-name = "vdd_mif";
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			buck2_reg: BUCK2 {
-				regulator-name = "vdd_arm";
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-ramp-delay = <50000>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/regulator/samsung,s2mpa01.yaml b/Documentation/devicetree/bindings/regulator/samsung,s2mpa01.yaml
new file mode 100644
index 000000000000..1fd33550c860
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/samsung,s2mpa01.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/samsung,s2mpa01.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S2MPA01 Power Management IC regulators
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for S2M and S5M family of Power
+  Management IC (PMIC).
+
+  The S2MPA01 provide buck and LDO regulators.
+
+  See also Documentation/devicetree/bindings/mfd/samsung,s2mpa01.yaml for
+  additional information and example.
+
+patternProperties:
+  # 26 LDOs
+  "^LDO([1-9]|1[0-9]|2[0-6])$":
+    type: object
+    $ref: regulator.yaml#
+    description:
+      Properties for single LDO regulator.
+
+    properties:
+      regulator-name: true
+
+    required:
+      - regulator-name
+
+    unevaluatedProperties: false
+
+  # 10 bucks
+  "^BUCK([1-9]|10)$":
+    type: object
+    $ref: regulator.yaml#
+    description:
+      Properties for single BUCK regulator.
+
+    properties:
+      regulator-name: true
+
+      regulator-ramp-delay:
+        enum: [0, 6250, 12500, 25000, 50000]
+        default: 12500
+        description: |
+          May be 0 for disabling the ramp delay on BUCK{1,2,3,4}.
+
+          In the absence of the regulator-ramp-delay property, the default ramp
+          delay will be used.
+
+          Note: Some bucks share the ramp rate setting i.e. same ramp value
+          will be set for a particular group of bucks so provide the same
+          regulator-ramp-delay value for them.
+          Groups sharing ramp rate:
+            * buck{1,6},
+            * buck{2,4},
+            * buck{8,9,10}.
+
+    required:
+      - regulator-name
+
+    unevaluatedProperties: false
+
+additionalProperties: false
-- 
2.30.2

