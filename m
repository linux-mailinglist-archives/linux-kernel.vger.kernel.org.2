Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5B241E9DF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 11:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353216AbhJAJnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 05:43:53 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46614
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353141AbhJAJnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 05:43:39 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 63E8E402CE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 09:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633081315;
        bh=aaXYHrp3L66rLENOSWMMcR2xo/U8IXQjJU/MbbXOyWE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=si7eAj9hD7aKJfwmh2ezzx+nVKA16ahdbJoKMoJsDy0LMYELPTyayC56PzQQX03eU
         daCa6F1m7bW3i0cnMq+yF4g4/VqQmtxrIMGzFxlnYgI9n1NQKIakZTqHFlAIAScYN2
         Wo7ldLO2yCfidDoJbrjgLlg7UfztkkNygvr4Tqu5VCQRSdLv3nqH8deLjfakEQn7y1
         PP4G4Q//7hpRoPQzohEMXHu88x7HBON6o9xLyXAxduXRhlSZWWbMS4QaIIhf/kBzWl
         Dd31J+pPhfG4UUvdAFiBp86iRnsaEoCJrn2vARV9APq3PxsBFJX8SsQuTNPW7fShAV
         rKy7zuxs57Gcw==
Received: by mail-lf1-f71.google.com with SMTP id i40-20020a0565123e2800b003f53da59009so8443120lfv.16
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 02:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aaXYHrp3L66rLENOSWMMcR2xo/U8IXQjJU/MbbXOyWE=;
        b=WC64xDlFuv4+R4931ZhChVOeGS7rrSOelx+ou1i/yOfMI7UBva9kIxIkHcomAxGLPF
         90e0cfV7t2ru8s6cE2kCNIoR4g0R+vY5u/PtYTXZofTMgAlKdY7pBvayO8wk1mqzjphS
         4DVfZMhIEzRiTmMOsD3oGLgj1X9LW9LL3sBDPrEGRzS688qC1Gje3JL5/g8MJzHhoGUx
         oIAsaj9MdabBPSbX4nlljxb/8gvZiwwb+CUeVd8pXW3GI3/qbPD1TTwENHeXrtrCXHHN
         l7GFYQAiPFpo9fe978quiIh3Y8TfnSqHEm7M4C0VlORJbz1cl2/V2lyfNqD0et9K3fKf
         QkXA==
X-Gm-Message-State: AOAM53201ndZVUwFG/GjJS2v9cYjRMge3IvpY1QGi3SPbZ2Sp2Ear0Q1
        0+63UjXmwnyd0t9G6q+n/1nw9qyht2Nqg2WZgopLu6OEGYdCtzoNV43KgxtPccreE8cX3fI7oZt
        0s+y5JfD+4yHJcDLhfDcLeHE2ohG1EOgqynsHq7EfGw==
X-Received: by 2002:a2e:300c:: with SMTP id w12mr10927693ljw.302.1633081314702;
        Fri, 01 Oct 2021 02:41:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw++2FAU5KVA7/aa7wsxI4/ReeOZHBI8XpkY+ZBJRcwfbnw2bmNoVAkFteXXA7LLfGyYoc8aQ==
X-Received: by 2002:a2e:300c:: with SMTP id w12mr10927674ljw.302.1633081314472;
        Fri, 01 Oct 2021 02:41:54 -0700 (PDT)
Received: from localhost.localdomain ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id g29sm673784lfj.212.2021.10.01.02.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 02:41:53 -0700 (PDT)
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
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 07/10] dt-bindings: mfd: samsung,s2mps11: convert to dtschema
Date:   Fri,  1 Oct 2021 11:41:03 +0200
Message-Id: <20211001094106.52412-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001094106.52412-1-krzysztof.kozlowski@canonical.com>
References: <20211001094106.52412-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the MFD part of Samsung S2MPS11/S2MPS13/S2MPS14/S2MPS15/S2MPU02
family of PMICs to DT schema format.  Previously the bindings were
mostly in mfd/samsung,sec-core.txt.

The conversion copies parts of description from existing bindings
therefore the license is not changed from GPLv2.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/mfd/samsung,s2mps11.yaml         | 267 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 268 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml

diff --git a/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml b/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml
new file mode 100644
index 000000000000..771b3f16da96
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml
@@ -0,0 +1,267 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/samsung,s2mps11.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S2MPS11/13/14/15 and S2MPU02 Power Management IC
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for S2M and S5M family of Power
+  Management IC (PMIC).
+
+  The Samsung S2MPS11/13/14/15 and S2MPU02 is a family of Power Management IC
+  which include voltage and current regulators, RTC, clock outputs and other
+  sub-blocks.
+
+properties:
+  compatible:
+    enum:
+      - samsung,s2mps11-pmic
+      - samsung,s2mps13-pmic
+      - samsung,s2mps14-pmic
+      - samsung,s2mps15-pmic
+      - samsung,s2mpu02-pmic
+
+  clocks:
+    $ref: ../clock/samsung,s2mps11.yaml
+    description:
+      Child node describing clock provider.
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description:
+      List of child nodes that specify the regulators.
+
+  samsung,s2mps11-acokb-ground:
+    description: |
+      Indicates that ACOKB pin of S2MPS11 PMIC is connected to the ground so
+      the PMIC must manually set PWRHOLD bit in CTRL1 register to turn off the
+      power. Usually the ACOKB is pulled up to VBATT so when PWRHOLD pin goes
+      low, the rising ACOKB will trigger power off.
+    type: boolean
+
+  samsung,s2mps11-wrstbi-ground:
+    description: |
+      Indicates that WRSTBI pin of PMIC is pulled down. When the system is
+      suspended it will always go down thus triggerring unwanted buck warm
+      reset (setting buck voltages to default values).
+    type: boolean
+
+  wakeup-source: true
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,s2mps11-pmic
+    then:
+      properties:
+        regulators:
+          $ref: ../regulator/samsung,s2mps11.yaml
+        samsung,s2mps11-wrstbi-ground: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,s2mps13-pmic
+    then:
+      properties:
+        regulators:
+          $ref: ../regulator/samsung,s2mps13.yaml
+        samsung,s2mps11-acokb-ground: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,s2mps14-pmic
+    then:
+      properties:
+        regulators:
+          $ref: ../regulator/samsung,s2mps14.yaml
+        samsung,s2mps11-acokb-ground: false
+        samsung,s2mps11-wrstbi-ground: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,s2mps15-pmic
+    then:
+      properties:
+        regulators:
+          $ref: ../regulator/samsung,s2mps15.yaml
+        samsung,s2mps11-acokb-ground: false
+        samsung,s2mps11-wrstbi-ground: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,s2mpu02-pmic
+    then:
+      properties:
+        regulators:
+          $ref: ../regulator/samsung,s2mpu02.yaml
+        samsung,s2mps11-acokb-ground: false
+        samsung,s2mps11-wrstbi-ground: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@66 {
+            compatible = "samsung,s2mps11-pmic";
+            reg = <0x66>;
+
+            interrupt-parent = <&gpx0>;
+            interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&s2mps11_irq>;
+            samsung,s2mps11-acokb-ground;
+            wakeup-source;
+
+            clocks {
+                compatible = "samsung,s2mps11-clk";
+                #clock-cells = <1>;
+                clock-output-names = "s2mps11_ap", "s2mps11_cp", "s2mps11_bt";
+            };
+
+            regulators {
+                LDO1 {
+                    regulator-name = "vdd_ldo1";
+                    regulator-min-microvolt = <1000000>;
+                    regulator-max-microvolt = <1000000>;
+                    regulator-always-on;
+                };
+
+                LDO4 {
+                    regulator-name = "vdd_adc";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                // ....
+
+                BUCK1 {
+                    regulator-name = "vdd_mif";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <1300000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                BUCK2 {
+                    regulator-name = "vdd_arm";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <1500000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-coupled-with = <&buck3_reg>;
+                    regulator-coupled-max-spread = <300000>;
+
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                BUCK3 {
+                    regulator-name = "vdd_int";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <1400000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-coupled-with = <&buck2_reg>;
+                    regulator-coupled-max-spread = <300000>;
+
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                // ...
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
+            compatible = "samsung,s2mps14-pmic";
+            reg = <0x66>;
+
+            interrupt-parent = <&gpx0>;
+            interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+            wakeup-source;
+
+            clocks {
+                compatible = "samsung,s2mps14-clk";
+                #clock-cells = <1>;
+                clock-output-names = "s2mps14_ap", "unused", "s2mps14_bt";
+            };
+
+            regulators {
+                LDO1 {
+                    regulator-name = "VLDO1_1.0V";
+                    regulator-min-microvolt = <1000000>;
+                    regulator-max-microvolt = <1000000>;
+                    regulator-always-on;
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                    };
+                };
+
+                // ...
+
+                BUCK1 {
+                    regulator-name = "VBUCK1_1.0V";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <1000000>;
+                    regulator-always-on;
+
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                // ...
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 5a7cb990b182..2de215d1274c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16600,6 +16600,7 @@ L:	linux-kernel@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml
+F:	Documentation/devicetree/bindings/mfd/samsung,s2m*.yaml
 F:	Documentation/devicetree/bindings/mfd/samsung,sec-core.txt
 F:	Documentation/devicetree/bindings/regulator/samsung,s2m*.yaml
 F:	Documentation/devicetree/bindings/regulator/samsung,s5m*.yaml
-- 
2.30.2

