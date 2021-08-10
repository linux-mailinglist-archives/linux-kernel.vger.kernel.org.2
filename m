Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AEA3E5702
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbhHJJdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:33:11 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:42724
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239105AbhHJJc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:32:58 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 49A8440C78
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 09:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628587954;
        bh=Q3Bw+lxFxrrX2xzHWCqOWv7XU5mwkZpCcX6GjIggRT8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=nhR2NsmKjUPxCjaIzoj2bjO21rvyEsIymwZq0G0Fb0UO67VHv4YjY/5QQrWXiKKOV
         zfKQblLsbrm8KRUPTIY1YQZ0jGbN9R4zVKIqSVCE4MeUfFEmUfyMWm3YeG0jy1DHgk
         njH3antNUpoNTF44nG/PPUNhVhUky8NuHRb26Jd9hFiQryDosoIK5BHzsO0HjHUySn
         gRBdYg62jaiP2+YQh/gPuhiGIZxZ51PNKKpHcqxQ2BPgGxPNasjjbz7ugzXe1E2LE4
         xbw5vz5bDu3oTz/oTG1O9wqPXz3JKAyUU7VhL9tanrvRRRLNmDfHQywVyvNeBnK0VY
         wHCk+yymGgaBQ==
Received: by mail-ed1-f71.google.com with SMTP id p2-20020a50c9420000b02903a12bbba1ebso10438482edh.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 02:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q3Bw+lxFxrrX2xzHWCqOWv7XU5mwkZpCcX6GjIggRT8=;
        b=gF2b8xnV60IS/wJc9JB1HqUNgEIW+1dxTfc1U5d6sggonkoBc9vfLWLM7T34LnXvvF
         jlUtva9zZ9dwvHMMjhepn19GFyA99yfRFfEdS0RLw/QxeM86MtLJeLLqYqtMUtRr0VKl
         y/2GMVvrrZvW848umdLt9gNKvhVtFFDdyS5CaB6y4OzsXMYBLQwhakheCJtPGF8Ki5iQ
         a9WPOECiej5p2OMzslGNYdfhv1YCL3yIRtiYyb1n5bc1sJCifafYEp20Hl6Vzsw9J7ce
         ZUJIJPblnhF4Mvy1QsxGUF6cC2GWKer+KI7kgdelDVm2jq8XKHETVEnrQLx92AeqlIMA
         nPkA==
X-Gm-Message-State: AOAM533hk5g60AWCxpr/w7IGg1HDblfG+hs7aMuJc3z1XC/ZqzQjjZBm
        gFV7SyxB98eHy2FGFOIFeDDwe+J4F7Ts2g2AwJTQlnvcNsDMKJgNe0iDiovdSkt0HoZ0ojBZJlj
        2ZDLlrP/ZPoznlWVecAD1HyiqdijiTt6ddi34TIsQtA==
X-Received: by 2002:a05:6402:12c4:: with SMTP id k4mr3799310edx.240.1628587954014;
        Tue, 10 Aug 2021 02:32:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9rP0nK011mVbs91I/zjqo9DzU0OUy1BGh6y82DEnIsanVgPX+52wJvFzsYtSmjAQwnYmi4Q==
X-Received: by 2002:a05:6402:12c4:: with SMTP id k4mr3799292edx.240.1628587953860;
        Tue, 10 Aug 2021 02:32:33 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id q21sm5117606ejs.43.2021.08.10.02.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 02:32:33 -0700 (PDT)
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
Subject: [PATCH v2 5/8] dt-bindings: clock: samsung: convert Exynos4 to dtschema
Date:   Tue, 10 Aug 2021 11:31:42 +0200
Message-Id: <20210810093145.26153-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210810093145.26153-1-krzysztof.kozlowski@canonical.com>
References: <20210810093145.26153-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge Exynos4210 and Exynos4412 clock controller bindings to existing DT
schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/clock/exynos4-clock.txt          | 86 -------------------
 .../bindings/clock/samsung,exynos-clock.yaml  | 29 ++++++-
 2 files changed, 28 insertions(+), 87 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos4-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/exynos4-clock.txt b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
deleted file mode 100644
index 17bb11365354..000000000000
--- a/Documentation/devicetree/bindings/clock/exynos4-clock.txt
+++ /dev/null
@@ -1,86 +0,0 @@
-* Samsung Exynos4 Clock Controller
-
-The Exynos4 clock controller generates and supplies clock to various controllers
-within the Exynos4 SoC. The clock binding described here is applicable to all
-SoC's in the Exynos4 family.
-
-Required Properties:
-
-- compatible: should be one of the following.
-  - "samsung,exynos4210-clock" - controller compatible with Exynos4210 SoC.
-  - "samsung,exynos4412-clock" - controller compatible with Exynos4412 SoC.
-
-- reg: physical base address of the controller and length of memory mapped
-  region.
-
-- #clock-cells: should be 1.
-
-Each clock is assigned an identifier and client nodes can use this identifier
-to specify the clock which they consume.
-
-All available clocks are defined as preprocessor macros in
-dt-bindings/clock/exynos4.h header and can be used in device
-tree sources.
-
-Example 1: An example of a clock controller node is listed below.
-
-	clock: clock-controller@10030000 {
-		compatible = "samsung,exynos4210-clock";
-		reg = <0x10030000 0x20000>;
-		#clock-cells = <1>;
-	};
-
-Example 2: UART controller node that consumes the clock generated by the clock
-	   controller. Refer to the standard clock bindings for information
-	   about 'clocks' and 'clock-names' property.
-
-	serial@13820000 {
-		compatible = "samsung,exynos4210-uart";
-		reg = <0x13820000 0x100>;
-		interrupts = <0 54 0>;
-		clocks = <&clock CLK_UART2>, <&clock CLK_SCLK_UART2>;
-		clock-names = "uart", "clk_uart_baud0";
-	};
-
-Exynos4412 SoC contains some additional clocks for FIMC-ISP (Camera ISP)
-subsystem. Registers for those clocks are located in the ISP power domain.
-Because those registers are also located in a different memory region than
-the main clock controller, a separate clock controller has to be defined for
-handling them.
-
-Required Properties:
-
-- compatible: should be "samsung,exynos4412-isp-clock".
-
-- reg: physical base address of the ISP clock controller and length of memory
-  mapped region.
-
-- #clock-cells: should be 1.
-
-- clocks: list of the clock controller input clock identifiers,
-  from common clock bindings, should point to CLK_ACLK200 and
-  CLK_ACLK400_MCUISP clocks from the main clock controller.
-
-- clock-names: list of the clock controller input clock names,
-  as described in clock-bindings.txt, should be "aclk200" and
-  "aclk400_mcuisp".
-
-- power-domains: a phandle to ISP power domain node as described by
-  generic PM domain bindings.
-
-Example 3: The clock controllers bindings for Exynos4412 SoCs.
-
-	clock: clock-controller@10030000 {
-		compatible = "samsung,exynos4412-clock";
-		reg = <0x10030000 0x18000>;
-		#clock-cells = <1>;
-	};
-
-	isp_clock: clock-controller@10048000 {
-		compatible = "samsung,exynos4412-isp-clock";
-		reg = <0x10048000 0x1000>;
-		#clock-cells = <1>;
-		power-domains = <&pd_isp>;
-		clocks = <&clock CLK_ACLK200>, <&clock CLK_ACLK400_MCUISP>;
-		clock-names = "aclk200", "aclk400_mcuisp";
-	};
diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
index c7b07fcd3fa1..ea73201f259b 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
@@ -23,6 +23,9 @@ properties:
           - samsung,exynos3250-cmu
           - samsung,exynos3250-cmu-dmc
           - samsung,exynos3250-cmu-isp
+          - samsung,exynos4210-clock
+          - samsung,exynos4412-clock
+          - samsung,exynos4412-isp-clock
           - samsung,exynos5250-clock
           - samsung,exynos5420-clock
           - samsung,exynos5800-clock
@@ -35,11 +38,18 @@ properties:
   assigned-clocks: true
   assigned-clock-parents: true
   assigned-clock-rates: true
-  clocks: true
+  clocks:
+    description: |
+      For samsung,exynos4412-isp-clock, the input clocks should be CLK_ACLK200
+      and CLK_ACLK400_MCUISP from the main clock controller.
+
+  clock-names: true
 
   "#clock-cells":
     const: 1
 
+  power-domains: true
+
   reg:
     maxItems: 1
 
@@ -50,6 +60,23 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos4412-isp-clock
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: aclk200
+            - const: aclk400_mcuisp
+      required:
+        - clocks
+        - clock-names
+        - power-domains
+
 examples:
   - |
     #include <dt-bindings/clock/exynos5250.h>
-- 
2.30.2

