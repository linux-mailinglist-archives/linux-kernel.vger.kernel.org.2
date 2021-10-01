Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F6941E9E0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 11:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353294AbhJAJn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 05:43:57 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46576
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353215AbhJAJnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 05:43:41 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C3F36402D6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 09:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633081316;
        bh=R3ErAtthN0V3efdYXbXsQBs5evIbwDUWOvfMQKp3DG8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=gT7tz6a0glWrLYW0SOhF5PHqBn0cO6E+vl01KgrrRJByXGA7mih5/E5fT3nnkS4Fq
         1wFwAVHMhbwZDt69/+/1+OKCUYe9gtNVgO0G10KuoZzsTxpO9tkNP74NoDUNwZ2D1J
         jxhGZdnJ5zu8Mg7DpID1rJZr4q85V8iHL2/FucFwPs2NdWzG/Rrvpj0ZoFhEfs7C2k
         FBXbwET6sutaODKmnoSmBtVz19QQjh82/buq9mUUfUQTgk2eUguvxx4WA2R83uP6yp
         ONbjpokSevbCupdzPFb+SKQoLWRMDxTR64IfPEvb0ZQynlqAW6zl0ieUZgAOzZ5JsA
         aGu7yD1K058VA==
Received: by mail-lf1-f72.google.com with SMTP id s28-20020a056512203c00b003f42015e912so8448495lfs.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 02:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R3ErAtthN0V3efdYXbXsQBs5evIbwDUWOvfMQKp3DG8=;
        b=MxhCPWbMX0Dq04919H+7IPnB+8o1DlTwdqmLHVWKfWEKJcvT26nOG5sk9b4CFB7mXt
         E3GFg3FuFam1kAzA/y3nJcJ2eH3nMkKqJPZ2QquMyt4Z9WsgVhFoII3C/Ub/4HLtWE3A
         l8KFgT2ZP+nd6zpcdkJhZmeamEYJX2P4uDe8AayDGfTQajbsTD/9m7WXysCoG2QczbRB
         DHxWtgRnaXZQ4l6eAM0Tmtyca/eW0ot/6IWhZeaJEM37QMt2msWl7bLGYOW4ylJkfpHe
         YEJbM8+mifotEdgu/BLBTiD2mOqJ1F81nmtzJ9sIL3wM6Zh0Xq0nuGKBBwp3tp5nMkxr
         9X4A==
X-Gm-Message-State: AOAM533zzSQInC4S9WiaxHUmCWA49TMVMPL4p5iCiWrY23tfj5sO6R/+
        vnmkG0Mt/ZBsyFChedIskY4DF8BdnpWHRG1ROquTaWo+dYWFRze7FPsKms1gmy7i4LUKgEKvCco
        h9QfXcJAQyJp1JR5Bzb5eoBCVlJCahL+iRk1hK0zi2w==
X-Received: by 2002:a19:6f4a:: with SMTP id n10mr4402732lfk.290.1633081316181;
        Fri, 01 Oct 2021 02:41:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJIDthiAZ7heJfzp7NcZtncpSXHC9eeOmPSdeTN4mmqPF7n5qVnxs75s8X8WHjYt2bqL0EKg==
X-Received: by 2002:a19:6f4a:: with SMTP id n10mr4402717lfk.290.1633081316015;
        Fri, 01 Oct 2021 02:41:56 -0700 (PDT)
Received: from localhost.localdomain ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id g29sm673784lfj.212.2021.10.01.02.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 02:41:55 -0700 (PDT)
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
Subject: [PATCH v2 08/10] dt-bindings: mfd: samsung,s2mpa01: convert to dtschema
Date:   Fri,  1 Oct 2021 11:41:04 +0200
Message-Id: <20211001094106.52412-9-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001094106.52412-1-krzysztof.kozlowski@canonical.com>
References: <20211001094106.52412-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the MFD part of Samsung S2MPA01 PMIC to DT schema format.
Previously the bindings were mostly in mfd/samsung,sec-core.txt.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/mfd/samsung,s2mpa01.yaml         | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/samsung,s2mpa01.yaml

diff --git a/Documentation/devicetree/bindings/mfd/samsung,s2mpa01.yaml b/Documentation/devicetree/bindings/mfd/samsung,s2mpa01.yaml
new file mode 100644
index 000000000000..017befdf8adb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/samsung,s2mpa01.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/samsung,s2mpa01.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S2MPA01 Power Management IC
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  This is a part of device tree bindings for S2M and S5M family of Power
+  Management IC (PMIC).
+
+  The Samsung S2MPA01 is a Power Management IC which includes voltage
+  and current regulators, RTC, clock outputs and other sub-blocks.
+
+properties:
+  compatible:
+    const: samsung,s2mpa01-pmic
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    $ref: ../regulator/samsung,s2mpa01.yaml
+    description:
+      List of child nodes that specify the regulators.
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
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@66 {
+            compatible = "samsung,s2mpa01-pmic";
+            reg = <0x66>;
+
+            regulators {
+                ldo1_reg: LDO1 {
+                    regulator-name = "VDD_ALIVE";
+                    regulator-min-microvolt = <1000000>;
+                    regulator-max-microvolt = <1000000>;
+                };
+
+                ldo2_reg: LDO2 {
+                    regulator-name = "VDDQ_MMC2";
+                    regulator-min-microvolt = <2800000>;
+                    regulator-max-microvolt = <2800000>;
+                    regulator-always-on;
+                };
+
+                // ...
+
+                buck1_reg: BUCK1 {
+                    regulator-name = "vdd_mif";
+                    regulator-min-microvolt = <950000>;
+                    regulator-max-microvolt = <1350000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                };
+
+                buck2_reg: BUCK2 {
+                    regulator-name = "vdd_arm";
+                    regulator-min-microvolt = <950000>;
+                    regulator-max-microvolt = <1350000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-ramp-delay = <50000>;
+                };
+
+                // ...
+            };
+        };
+    };
-- 
2.30.2

