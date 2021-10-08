Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E4B426DF9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243381AbhJHPqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243289AbhJHPp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:45:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34363C061768
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 08:44:03 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g10so37222229edj.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2WVtOa8/GOzyCMHZHw3G3dz8qp2GM3aiIOxGFUb6CZI=;
        b=rjiCGvNCz1e9F2IvQ7r8R+u4jQKWW5Ldlkx2zdPR9LHBYyd1VT356cX4tK9xzACwCB
         TV/uOQjJjpTGwg4JDq1gnsg7EutXuw395l6t2M+MyKheQSAHmsz9uBJOT+CK++XbF3nE
         L3BkQ6dIBsp+O2/zxjNV+OtikPUqgd25NtWU9xDoYXE8k4Bx3zJJpFJccJeDLqq+qilE
         zYJP2k0FVV4pftje/Vgun55hEk8U9zAPQvX8M6ks66LuOFHNEsXbohKwtI94gf2jdw7a
         fgSqz5eKCUxcLEDCfU63U4XvT++j5+i5lP/kdNBEtzGc1G69zImcuWSARa5YPSsqrcLu
         YQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2WVtOa8/GOzyCMHZHw3G3dz8qp2GM3aiIOxGFUb6CZI=;
        b=tmw5W/f5EZ4mSekRBTAreZsaZ9o79wBoAsd4PrJ53Mb4Cv15+ylRr2IV5ReEWQ1QYr
         FTTSFM/jEb1kO2Wbn3ls2Gq5a34pUTq17KF3KFfHWpYfAp4iFG9PHq3FUmICqTkiBuSw
         JMiTtCm4VGUiArnlvL4oh40qdJp3Lk/czLCiWN7GWpqwaXc7Lo3bqd9UuLhJcoLOKlEp
         s+GMI/qrqOX470SuX+DZyOo/Kt+A2xCYGk2BnvDFrRgL1h28p8ZyiWavlwLpYoP/mkLv
         BP0OyKwjmvzH0YJd84gOV5UaUwDQ4BTPNM5SNxiymW8gCdxO9WID0cU8IRKudApfDYCq
         vwWA==
X-Gm-Message-State: AOAM530EFB2o9PZNkESwBXcXGTb2zPwqxBDBpmgxojc21A8Yq4m9TpZ5
        JnkoxB5DDHvi6wnNexr0N9HliQ==
X-Google-Smtp-Source: ABdhPJxaLN6kQe8Ymffw0lxFVY/xoO03HUjoTkg8QoPJLm5TDkwd61d1KTYcPTl1ViJqZPnyE9CWyA==
X-Received: by 2002:a05:6402:5255:: with SMTP id t21mr15192241edd.103.1633707841708;
        Fri, 08 Oct 2021 08:44:01 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id bx11sm1086714ejb.107.2021.10.08.08.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 08:44:01 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Ryu Euiyoul <ryu.real@samsung.com>, Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 4/5] dt-bindings: clock: Document Exynos850 CMU bindings
Date:   Fri,  8 Oct 2021 18:43:51 +0300
Message-Id: <20211008154352.19519-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211008154352.19519-1-semen.protsenko@linaro.org>
References: <20211008154352.19519-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide dt-schema documentation for Exynos850 SoC clock controller.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes in v3:
  -  Added R-b tag by Krzysztof Kozlowski

Changes in v2:
  - Dropped OSCCLK node declaration example
  - Dropped UART node declaration example
  - Added Ack tag by Chanwoo Choi

 .../clock/samsung,exynos850-clock.yaml        | 185 ++++++++++++++++++
 1 file changed, 185 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
new file mode 100644
index 000000000000..79202e6e6402
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
@@ -0,0 +1,185 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/samsung,exynos850-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos850 SoC clock controller
+
+maintainers:
+  - Sam Protsenko <semen.protsenko@linaro.org>
+  - Chanwoo Choi <cw00.choi@samsung.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+  - Tomasz Figa <tomasz.figa@gmail.com>
+
+description: |
+  Exynos850 clock controller is comprised of several CMU units, generating
+  clocks for different domains. Those CMU units are modeled as separate device
+  tree nodes, and might depend on each other. Root clocks in that clock tree are
+  two external clocks:: OSCCLK (26 MHz) and RTCCLK (32768 Hz). Those external
+  clocks must be defined as fixed-rate clocks in dts.
+
+  CMU_TOP is a top-level CMU, where all base clocks are prepared using PLLs and
+  dividers; all other leaf clocks (other CMUs) are usually derived from CMU_TOP.
+
+  Each clock is assigned an identifier and client nodes can use this identifier
+  to specify the clock which they consume. All clocks that available for usage
+  in clock consumer nodes are defined as preprocessor macros in
+  'dt-bindings/clock/exynos850.h' header.
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos850-cmu-top
+      - samsung,exynos850-cmu-core
+      - samsung,exynos850-cmu-dpu
+      - samsung,exynos850-cmu-hsi
+      - samsung,exynos850-cmu-peri
+
+  clocks:
+    minItems: 1
+    maxItems: 5
+
+  clock-names:
+    minItems: 1
+    maxItems: 5
+
+  "#clock-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-top
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+
+        clock-names:
+          items:
+            - const: oscclk
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-core
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: CMU_CORE bus clock (from CMU_TOP)
+            - description: CCI clock (from CMU_TOP)
+            - description: eMMC clock (from CMU_TOP)
+            - description: SSS clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: dout_core_bus
+            - const: dout_core_cci
+            - const: dout_core_mmc_embd
+            - const: dout_core_sss
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-dpu
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: DPU clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: dout_dpu
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-hsi
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: External RTC clock (32768 Hz)
+            - description: CMU_HSI bus clock (from CMU_TOP)
+            - description: SD card clock (from CMU_TOP)
+            - description: "USB 2.0 DRD clock (from CMU_TOP)"
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: rtcclk
+            - const: dout_hsi_bus
+            - const: dout_hsi_mmc_card
+            - const: dout_hsi_usb20drd
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-peri
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: CMU_PERI bus clock (from CMU_TOP)
+            - description: UART clock (from CMU_TOP)
+            - description: Parent clock for HSI2C and SPI (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: dout_peri_bus
+            - const: dout_peri_uart
+            - const: dout_peri_ip
+
+required:
+  - compatible
+  - "#clock-cells"
+  - clocks
+  - clock-names
+  - reg
+
+additionalProperties: false
+
+examples:
+  # Clock controller node for CMU_PERI
+  - |
+    #include <dt-bindings/clock/exynos850.h>
+
+    cmu_peri: clock-controller@10030000 {
+        compatible = "samsung,exynos850-cmu-peri";
+        reg = <0x10030000 0x8000>;
+        #clock-cells = <1>;
+
+        clocks = <&oscclk>, <&cmu_top CLK_DOUT_PERI_BUS>,
+                 <&cmu_top CLK_DOUT_PERI_UART>,
+                 <&cmu_top CLK_DOUT_PERI_IP>;
+        clock-names = "oscclk", "dout_peri_bus",
+                      "dout_peri_uart", "dout_peri_ip";
+    };
+
+...
-- 
2.30.2

