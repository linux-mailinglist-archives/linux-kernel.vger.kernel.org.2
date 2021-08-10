Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836343E570C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239163AbhHJJdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:33:19 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:42896
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239144AbhHJJc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:32:59 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 37EF140328
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 09:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628587957;
        bh=jIw2Z0zLUVUpsOXW4AW8yaScSH2fLaZf9ngYQCkR0aY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=aRycWpW8wgydnmX2IsfUDq4apN2e2oJ0B/1D0zIQ/+Al0nWOJNH3OFR+OXPK+HBWS
         siMzB2AeDMvfFeLl+sewqMiz9bQS4yRD0Gknn9iK7gkvT0WsTHhlhCl10qU57Kdhnr
         2qFt8+LhwAmiJWoW2CH8l/XnM4/ToW/wIJBbl4thYa1IFVwteH//7x98T6qKpsazZU
         2dTl+K31vHaLCxyAzDWD2RhjyaGUzOKwVktelxI8ehDZF02RfLVwTyetBKG/E8s+QE
         YycN4zEzJJYRbZsyrbmOcEbkU51QKXFQ7u7oBzlKpt4wvNjoS/qvE3feOciCzHdkfb
         +kZxB85qcScLQ==
Received: by mail-ed1-f72.google.com with SMTP id l3-20020aa7c3030000b02903bccf1897f9so10468722edq.19
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 02:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jIw2Z0zLUVUpsOXW4AW8yaScSH2fLaZf9ngYQCkR0aY=;
        b=G3lWPvFjCa1P/y6ozIYJk05/bpkbrlmmFmEfHEpa52MVRxDMAspxEyzYZ2UwzxrnLQ
         B+oHIFaqqFArWI7s9HovhkEL6xDA+rET6CcVaVYWqH1CqZjnYoKyjbytNSDw5k/vKOf2
         lRoKEOsWuQkdsh/mixlwYgD783OZjY/29HbD+6ytHWNEi9TX2zT2umoIz+bpNJ+ZF5SD
         lI5K9UD/gclFrdyx+/lL3Xn0V1zgUqgp1uPqGw1NFE8l2RrEUcMDuUuqX0P9Si+KDl6T
         Z3liwh4+R7y3lP/tXmE8Z5dX+FpcXspcjbCidi7V+Knt5q27tPUjIRlBpeylay3mk2OQ
         OHng==
X-Gm-Message-State: AOAM531HsIBqfaosenX4nbOS761eBegqPCHVD50h+cenyBk26htKnq/o
        aq/hSm/RhtA/ofUnuBQLvNGfy0I3+Djj6UYuRw+EQc0CMNYnu51ieE1eZun0MaYVWXytG5b3oZa
        95Md1Valb7bXBFtSu3A+zVwPrxTqdQCPrXlSzXw20lg==
X-Received: by 2002:a05:6402:54f:: with SMTP id i15mr3962862edx.24.1628587956801;
        Tue, 10 Aug 2021 02:32:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPFI4GcFdjOXUhlSG8zDmrMpzFfA+4/qms1t1UGWPX9cZftWAZwLxBJaTrTmcAvQTuf+q7KA==
X-Received: by 2002:a05:6402:54f:: with SMTP id i15mr3962842edx.24.1628587956642;
        Tue, 10 Aug 2021 02:32:36 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id q21sm5117606ejs.43.2021.08.10.02.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 02:32:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v2 7/8] dt-bindings: clock: samsung: convert S5Pv210 AudSS to dtschema
Date:   Tue, 10 Aug 2021 11:31:44 +0200
Message-Id: <20210810093145.26153-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210810093145.26153-1-krzysztof.kozlowski@canonical.com>
References: <20210810093145.26153-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung S5Pv210 Audio SubSystem clock controller bindings to DT
schema format using json-schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. Include header to fix clock IDs error in example.
---
 .../bindings/clock/clk-s5pv210-audss.txt      | 53 -------------
 .../clock/samsung,s5pv210-audss-clock.yaml    | 77 +++++++++++++++++++
 2 files changed, 77 insertions(+), 53 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/clk-s5pv210-audss.txt
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s5pv210-audss-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/clk-s5pv210-audss.txt b/Documentation/devicetree/bindings/clock/clk-s5pv210-audss.txt
deleted file mode 100644
index f6272dcd96f4..000000000000
--- a/Documentation/devicetree/bindings/clock/clk-s5pv210-audss.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-* Samsung Audio Subsystem Clock Controller
-
-The Samsung Audio Subsystem clock controller generates and supplies clocks
-to Audio Subsystem block available in the S5PV210 and compatible SoCs.
-
-Required Properties:
-
-- compatible: should be "samsung,s5pv210-audss-clock".
-- reg: physical base address and length of the controller's register set.
-
-- #clock-cells: should be 1.
-
-- clocks:
-  - hclk: AHB bus clock of the Audio Subsystem.
-  - xxti: Optional fixed rate PLL reference clock, parent of mout_audss. If
-    not specified (i.e. xusbxti is used for PLL reference), it is fixed to
-    a clock named "xxti".
-  - fout_epll: Input PLL to the AudioSS block, parent of mout_audss.
-  - iiscdclk0: Optional external i2s clock, parent of mout_i2s. If not
-    specified, it is fixed to a clock named "iiscdclk0".
-  - sclk_audio0: Audio bus clock, parent of mout_i2s.
-
-- clock-names: Aliases for the above clocks. They should be "hclk",
-  "xxti", "fout_epll", "iiscdclk0", and "sclk_audio0" respectively.
-
-All available clocks are defined as preprocessor macros in
-dt-bindings/clock/s5pv210-audss-clk.h header and can be used in device
-tree sources.
-
-Example: Clock controller node.
-
-	clk_audss: clock-controller@c0900000 {
-		compatible = "samsung,s5pv210-audss-clock";
-		reg = <0xc0900000 0x1000>;
-		#clock-cells = <1>;
-		clock-names = "hclk", "xxti",
-				"fout_epll", "sclk_audio0";
-		clocks = <&clocks DOUT_HCLKP>, <&xxti>,
-				<&clocks FOUT_EPLL>, <&clocks SCLK_AUDIO0>;
-	};
-
-Example: I2S controller node that consumes the clock generated by the clock
-	 controller. Refer to the standard clock bindings for information
-         about 'clocks' and 'clock-names' property.
-
-	i2s0: i2s@3830000 {
-		/* ... */
-		clock-names = "iis", "i2s_opclk0",
-				"i2s_opclk1";
-		clocks = <&clk_audss CLK_I2S>, <&clk_audss CLK_I2S>,
-				<&clk_audss CLK_DOUT_AUD_BUS>;
-		/* ... */
-	};
diff --git a/Documentation/devicetree/bindings/clock/samsung,s5pv210-audss-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,s5pv210-audss-clock.yaml
new file mode 100644
index 000000000000..ef313df4afa4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/samsung,s5pv210-audss-clock.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/samsung,s5pv210-audss-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S5Pv210 SoC Audio SubSystem clock controller
+
+maintainers:
+  - Chanwoo Choi <cw00.choi@samsung.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+  - Tomasz Figa <tomasz.figa@gmail.com>
+
+description: |
+  All available clocks are defined as preprocessor macros in
+  include/dt-bindings/clock/s5pv210-audss.h header.
+
+properties:
+  compatible:
+    const: samsung,s5pv210-audss-clock
+
+  clocks:
+    minItems: 4
+    items:
+      - description:
+          AHB bus clock of the Audio Subsystem.
+      - description:
+          Optional fixed rate PLL reference clock, parent of mout_audss. If not
+          specified (i.e. xusbxti is used for PLL reference), it is fixed to a
+          clock named "xxti".
+      - description:
+          Input PLL to the AudioSS block, parent of mout_audss.
+      - description:
+          Audio bus clock, parent of mout_i2s.
+      - description:
+          Optional external i2s clock, parent of mout_i2s. If not specified, it
+          is fixed to a clock named "iiscdclk0".
+
+  clock-names:
+    minItems: 4
+    items:
+      - const: hclk
+      - const: xxti
+      - const: fout_epll
+      - const: sclk_audio0
+      - const: iiscdclk0
+
+  "#clock-cells":
+    const: 1
+
+  power-domains: true
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - "#clock-cells"
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/s5pv210.h>
+
+    clock-controller@c0900000 {
+        compatible = "samsung,s5pv210-audss-clock";
+        reg = <0xc0900000 0x1000>;
+        #clock-cells = <1>;
+        clock-names = "hclk", "xxti", "fout_epll", "sclk_audio0";
+        clocks = <&clocks DOUT_HCLKP>, <&xxti>, <&clocks FOUT_EPLL>,
+                 <&clocks SCLK_AUDIO0>;
+    };
-- 
2.30.2

