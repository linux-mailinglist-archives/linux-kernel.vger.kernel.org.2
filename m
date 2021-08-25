Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6999A3F762B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbhHYNoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:44:30 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58760
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238500AbhHYNoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:44:19 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 87DB340767
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 13:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629899013;
        bh=W6Oha4DZG34PoHCL6IOPjoBy8fsf6s2H9cR2PIHqu3o=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=DEb6d+tviN1+WZKjW4AcEIrmdITN0q7PjbfrRSLm+TJ4qgyqBLQqk0rF34/kWchcs
         MPTiQ2ivypIFpFl6GYwggF97k/4UGkM9DiXhzQwu9zweZS13l9b4mJ9J/AvwCFCA8c
         2aMaC2jIESrhckvZADcerY14j6Xmi1HSZ5i3I/vltGmdQ1g5m/JRiNRmUvfQpVNOZ2
         s6yW3GioQBEr7vWEyLz0LKWpXy04oMKaAA69lHTsYDrj8LeopcnBG3n/UjnqTnnLTe
         /LZWb2ninMMbRV8AortiYx1aWJ/ot6IORNEUjHMT+IIrWeoj6ovhbxf2z8PMiFRcex
         XCA4HFp8tWbgw==
Received: by mail-wm1-f71.google.com with SMTP id g3-20020a1c2003000000b002e751c4f439so2854876wmg.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 06:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W6Oha4DZG34PoHCL6IOPjoBy8fsf6s2H9cR2PIHqu3o=;
        b=tA24Cd4yBK5l/K3ej9HzEvlMXlG6YNNeulWW8ad8JUfkrzZ0YCSLPS1ouvBb3xTGvO
         vs9O03mapZzEAcn5/clr0rKepXXTNBx+Wjwdrd5n/dCF2b9aa+UZBltkHtajtGHJBHg1
         U9MPejwz8CFtorbTTOCoqQSvOg1/PvnemhP8mZGFhqy5InI9sDKtDQHp3tHARh+rUNng
         sM9G1TPYHFV/7EkhpSVLXxPo/F+IclgrVs7KqXhPGNhqDPStyGJaDPCvBZcmQP2wNMwt
         NrLkoAm1D+RlCpEewBvA8jmkYh8NuvE/OvKW+lRsCwUmJxr8befYNwC/XUs5MLEtI7Nr
         Urhg==
X-Gm-Message-State: AOAM5323OevWtNp2ZeJudFAWboNAGZq873p7B8x8QI2vpc8nnJpw9Qh4
        62bvqjqdoe/WA5l3Ucf5sbRnJFPlLKUoNFz9p1JsOs28K2O0OuqKDFfb2CKbAfXqTB6nGuv3DYG
        phQ2as51VGLu1Kv0PK38n7nUi5mX8V2U5P0KUeucxIQ==
X-Received: by 2002:a5d:4ccc:: with SMTP id c12mr18442143wrt.59.1629899013207;
        Wed, 25 Aug 2021 06:43:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3fagRQBIAglfR3n4QgXwSq1YOk/VrR/cjLAJnCPTJzswjxeHhZDVi/fKirZNqak5phsOaFQ==
X-Received: by 2002:a5d:4ccc:: with SMTP id c12mr18442112wrt.59.1629899013020;
        Wed, 25 Aug 2021 06:43:33 -0700 (PDT)
Received: from localhost.localdomain ([79.98.113.172])
        by smtp.gmail.com with ESMTPSA id w9sm5238954wmc.19.2021.08.25.06.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 06:43:32 -0700 (PDT)
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
Subject: [PATCH v3 6/8] dt-bindings: clock: samsung: convert Exynos AudSS to dtschema
Date:   Wed, 25 Aug 2021 15:42:49 +0200
Message-Id: <20210825134251.220098-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825134056.219884-6-krzysztof.kozlowski@canonical.com>
References: <20210825134056.219884-6-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung Exynos Audio SubSystem clock controller bindings to DT
schema format using json-schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../bindings/clock/clk-exynos-audss.txt       | 103 ------------------
 .../clock/samsung,exynos-audss-clock.yaml     |  80 ++++++++++++++
 2 files changed, 80 insertions(+), 103 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/clk-exynos-audss.txt
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos-audss-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt b/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt
deleted file mode 100644
index 6030afb10b5c..000000000000
--- a/Documentation/devicetree/bindings/clock/clk-exynos-audss.txt
+++ /dev/null
@@ -1,103 +0,0 @@
-* Samsung Audio Subsystem Clock Controller
-
-The Samsung Audio Subsystem clock controller generates and supplies clocks
-to Audio Subsystem block available in the S5PV210 and Exynos SoCs. The clock
-binding described here is applicable to all SoCs in Exynos family.
-
-Required Properties:
-
-- compatible: should be one of the following:
-  - "samsung,exynos4210-audss-clock" - controller compatible with all Exynos4 SoCs.
-  - "samsung,exynos5250-audss-clock" - controller compatible with Exynos5250
-    SoCs.
-  - "samsung,exynos5410-audss-clock" - controller compatible with Exynos5410
-    SoCs.
-  - "samsung,exynos5420-audss-clock" - controller compatible with Exynos5420
-    SoCs.
-- reg: physical base address and length of the controller's register set.
-
-- #clock-cells: should be 1.
-
-- clocks:
-  - pll_ref: Fixed rate PLL reference clock, parent of mout_audss. "fin_pll"
-    is used if not specified.
-  - pll_in: Input PLL to the AudioSS block, parent of mout_audss. "fout_epll"
-    is used if not specified.
-  - cdclk: External i2s clock, parent of mout_i2s. "cdclk0" is used if not
-    specified.
-  - sclk_audio: Audio bus clock, parent of mout_i2s. "sclk_audio0" is used if
-    not specified.
-  - sclk_pcm_in: PCM clock, parent of sclk_pcm.  "sclk_pcm0" is used if not
-    specified.
-
-- clock-names: Aliases for the above clocks. They should be "pll_ref",
-  "pll_in", "cdclk", "sclk_audio", and "sclk_pcm_in" respectively.
-
-Optional Properties:
-
-  - power-domains: a phandle to respective power domain node as described by
-    generic PM domain bindings (see power/power_domain.txt for more
-    information).
-
-The following is the list of clocks generated by the controller. Each clock is
-assigned an identifier and client nodes use this identifier to specify the
-clock which they consume. Some of the clocks are available only on a particular
-Exynos4 SoC and this is specified where applicable.
-
-Provided clocks:
-
-Clock           ID      SoC (if specific)
------------------------------------------------
-
-mout_audss      0
-mout_i2s        1
-dout_srp        2
-dout_aud_bus    3
-dout_i2s        4
-srp_clk         5
-i2s_bus         6
-sclk_i2s        7
-pcm_bus         8
-sclk_pcm        9
-adma            10      Exynos5420
-
-Example 1: An example of a clock controller node using the default input
-	   clock names is listed below.
-
-clock_audss: audss-clock-controller@3810000 {
-	compatible = "samsung,exynos5250-audss-clock";
-	reg = <0x03810000 0x0C>;
-	#clock-cells = <1>;
-};
-
-Example 2: An example of a clock controller node with the input clocks
-           specified.
-
-clock_audss: audss-clock-controller@3810000 {
-	compatible = "samsung,exynos5250-audss-clock";
-	reg = <0x03810000 0x0C>;
-	#clock-cells = <1>;
-	clocks = <&clock 1>, <&clock 7>, <&clock 138>, <&clock 160>,
-		<&ext_i2s_clk>;
-	clock-names = "pll_ref", "pll_in", "sclk_audio", "sclk_pcm_in", "cdclk";
-};
-
-Example 3: I2S controller node that consumes the clock generated by the clock
-           controller. Refer to the standard clock bindings for information
-           about 'clocks' and 'clock-names' property.
-
-i2s0: i2s@3830000 {
-	compatible = "samsung,i2s-v5";
-	reg = <0x03830000 0x100>;
-	dmas = <&pdma0 10
-		&pdma0 9
-		&pdma0 8>;
-	dma-names = "tx", "rx", "tx-sec";
-	clocks = <&clock_audss EXYNOS_I2S_BUS>,
-		<&clock_audss EXYNOS_I2S_BUS>,
-		<&clock_audss EXYNOS_SCLK_I2S>,
-		<&clock_audss EXYNOS_MOUT_AUDSS>,
-		<&clock_audss EXYNOS_MOUT_I2S>;
-	clock-names = "iis", "i2s_opclk0", "i2s_opclk1",
-		      "mout_audss", "mout_i2s";
-};
diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos-audss-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos-audss-clock.yaml
new file mode 100644
index 000000000000..f14f1d39da36
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos-audss-clock.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/samsung,exynos-audss-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC Audio SubSystem clock controller
+
+maintainers:
+  - Chanwoo Choi <cw00.choi@samsung.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+  - Tomasz Figa <tomasz.figa@gmail.com>
+
+description: |
+  All available clocks are defined as preprocessor macros in
+  include/dt-bindings/clock/exynos-audss-clk.h header.
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos4210-audss-clock
+      - samsung,exynos5250-audss-clock
+      - samsung,exynos5410-audss-clock
+      - samsung,exynos5420-audss-clock
+
+  clocks:
+    minItems: 2
+    items:
+      - description:
+          Fixed rate PLL reference clock, parent of mout_audss. "fin_pll" is
+          used if not specified.
+      - description:
+          Input PLL to the AudioSS block, parent of mout_audss. "fout_epll" is
+          used if not specified.
+      - description:
+          Audio bus clock, parent of mout_i2s. "sclk_audio0" is used if not
+          specified.
+      - description:
+          PCM clock, parent of sclk_pcm.  "sclk_pcm0" is used if not specified.
+      - description:
+          External i2s clock, parent of mout_i2s. "cdclk0" is used if not
+          specified.
+
+  clock-names:
+    minItems: 2
+    items:
+      - const: pll_ref
+      - const: pll_in
+      - const: sclk_audio
+      - const: sclk_pcm_in
+      - const: cdclk
+
+  "#clock-cells":
+    const: 1
+
+  power-domains:
+    maxItems: 1
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
+    clock-controller@3810000 {
+        compatible = "samsung,exynos5250-audss-clock";
+        reg = <0x03810000 0x0c>;
+        #clock-cells = <1>;
+        clocks = <&clock 1>, <&clock 7>, <&clock 138>, <&clock 160>, <&ext_i2s_clk>;
+        clock-names = "pll_ref", "pll_in", "sclk_audio", "sclk_pcm_in", "cdclk";
+    };
-- 
2.30.2

