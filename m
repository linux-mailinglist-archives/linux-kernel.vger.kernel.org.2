Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D632425C6F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 21:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhJGTpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 15:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbhJGTnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 15:43:17 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569D0C061760
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 12:41:23 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z11so21044567lfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 12:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6qypjTcxQ7XQKBuiOwqn5g+UY0WDWTYynbpPAmde6MA=;
        b=Byf34ukrpWPrWz8IZz8w9qcSwzWA8mrQitD8/gm5xPSQ7A4U73QOfddicwA8aQ/PZq
         VE//d6HefRiFkfqe2GBFGKAkOFdSHgusQ7f+sTS5XBaef4a64B4E/XwwJoqaXLuUn8aV
         D3aDiCpaXxCokr4X1iW5AnUdcqlylPxOPCv8joD7BWcBBhmNo6pj97F+8g2QI6aEpmLM
         QMAdhm0Vw3cq/fBfgJqQL/lvQLKoRgHfyu/nIOYyiOGHnhqKC3LjUKdLwXKZdPFIB42X
         Cd04GRckN28UJM7C2wXsW86nT1mGeY7mIATawdeZT+5lZ0L+ke89XCq3bfwFBI4ayzHA
         PCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6qypjTcxQ7XQKBuiOwqn5g+UY0WDWTYynbpPAmde6MA=;
        b=KzQH8HksVU4J+qOGFkflZuLBdNQhRU8avgBcVwhYSRFhOrJ7Csa1vOdE6WU1pg9Tbt
         f/4FNNAkSPdD7BDYiO9oJtOC3W3/NunfvNintHYpo4DvRbWHeM1Az3QMjL4SytcN5csb
         +02cPmapZLyr711FMugXhmAkuB7nSM2nmIXP7XNrvaG1Wt7esmZb7zrCi8Y86Y8oIGl8
         A0/l3kslDIleet2iFDAVAgc7luu8Ik8g/S/uEPnTbpG1dctT6+OpGRWTp5tCSNKFMZQ+
         jxZhfWTzY/VafvOtbZYO5U712oww3A5+5ZsAHB0kv9auf7xz3wXgokjLIylpTNPshhmy
         UZpA==
X-Gm-Message-State: AOAM532VtUQuHXp7e3trE4VsuXLwnKEM9R2hxgefDGNxdQOzCTaYnfF0
        sBxgU1VI3g1cayAzGEkPa+dqoQ==
X-Google-Smtp-Source: ABdhPJw1QADHTDExJHD/8BVAYf2IKTwIG+OK6TZHVQtQj1M1kyPY0A+Xpq0zE3Hc6qlvMAIy+T80TA==
X-Received: by 2002:a05:6512:692:: with SMTP id t18mr5618211lfe.572.1633635681608;
        Thu, 07 Oct 2021 12:41:21 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id r11sm22598lfn.224.2021.10.07.12.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:41:21 -0700 (PDT)
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
Subject: [PATCH v2 4/5] dt-bindings: clock: Document Exynos850 CMU bindings
Date:   Thu,  7 Oct 2021 22:41:12 +0300
Message-Id: <20211007194113.10507-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211007194113.10507-1-semen.protsenko@linaro.org>
References: <20211007194113.10507-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide dt-schema documentation for Exynos850 SoC clock controller.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
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

