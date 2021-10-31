Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64458440E43
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 13:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhJaMZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 08:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbhJaMYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 08:24:54 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BFFC061746
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 05:22:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m14so2010656edd.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 05:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4hAAB9ACVGB7w+5kN6PqXP+giYjWZ8rzjhqYUsb2soQ=;
        b=tjyz05UAvEZeR+kQ75NlySwkepTuKYMqx5I3q57MUpX7MKgJSmnaMUPMwEhGRpfycy
         n2cLROtK8MOo0BcrjMwbvdwuemUh3b7OGnESGtyLaai/EPMQNZWgMRPqEorWVFf5RvHH
         lFu7O7usjBu8fTxLOgWo+xFBrP/Ed4oNB9EI/VgGj6iEekppWtWsjiPF8lpWE0bmugiu
         RQ/VDXyZHY5YLMxeD1LrDzHbyX2w1cPTTAPUtawtewhfKo4kHKo2GGBIW352q7uVqIvG
         nJ+lZWXnWWnBA+zROr1/3+9SlL/MfIqoMwkn1OX9R+sNhjCRkuZDRXu2do8zY/KA17GS
         X7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4hAAB9ACVGB7w+5kN6PqXP+giYjWZ8rzjhqYUsb2soQ=;
        b=Q34TGkR7vqVV7woDTeelr4fpfub2IjCJ4JI3EXgF4qd5qug4519dgJ6ckw8npPXn8g
         0/z5RqQ0jW/orzTQGcESj3EiIs9+GfMi4hl3XGtGewOcqdA8fo5bbrW6aPEvjpkPYZqo
         VsGT1m1ix/dJbV7408OeIABARL2SpsMyhsYrIjqoiIyV+EvdDNT3ZT6PhpToxN4BsppQ
         ypITLR5XDSWPtKNI9Cqg37IyKJzpo07AvsWT6yzArMKJcsHUzPgnoyqs/Zab1i+Z5f3G
         zi2zCQPaw4Zi2ZgyM13rPcR2xZ9WeuMEGROZb2RHG6qu+N5Oq/VEHDDIidrWeGw9w4u3
         eKbQ==
X-Gm-Message-State: AOAM532U+Ec0X/u2VlNwJD3ru/jgvS0YfibyUvEKLDAbqx6n4A6CzSNG
        /ouN8no6QLmzYTwtPGDFQrbjlQ==
X-Google-Smtp-Source: ABdhPJw1btUJn7dyIICN98vaTkAsHX3B/Uv+co666O+A3jpDVitVf+48qEz1YZu90eIvjdvpsZlgAw==
X-Received: by 2002:a17:906:269a:: with SMTP id t26mr28852315ejc.20.1635682941200;
        Sun, 31 Oct 2021 05:22:21 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id x3sm7738974edd.67.2021.10.31.05.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 05:22:20 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 02/12] dt-bindings: watchdog: Document Exynos850 watchdog bindings
Date:   Sun, 31 Oct 2021 14:22:06 +0200
Message-Id: <20211031122216.30212-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211031122216.30212-1-semen.protsenko@linaro.org>
References: <20211031122216.30212-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos850 SoC has two CPU clusters:
  - cluster 0: contains CPUs #0, #1, #2, #3
  - cluster 1: contains CPUs #4, #5, #6, #7

Each cluster has its own dedicated watchdog timer. Those WDT instances
are controlled using different bits in PMU registers, new
"samsung,index" property is added to tell the driver which bits to use
for defined watchdog node.

Also on Exynos850 the peripheral clock and the source clock are two
different clocks. Provide a way to specify two clocks in watchdog device
tree node.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Stated explicitly that Exynos850 driver requires 2 clocks
  - Used single compatible for Exynos850
  - Added "index" property to specify CPU cluster index
  - Fixed a typo in commit message: dedicater -> dedicated

 .../bindings/watchdog/samsung-wdt.yaml        | 44 +++++++++++++++++--
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
index 93cd77a6e92c..f29d0ca4eced 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
@@ -22,25 +22,32 @@ properties:
       - samsung,exynos5250-wdt                # for Exynos5250
       - samsung,exynos5420-wdt                # for Exynos5420
       - samsung,exynos7-wdt                   # for Exynos7
+      - samsung,exynos850-wdt                 # for Exynos850
 
   reg:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   clock-names:
-    items:
-      - const: watchdog
+    minItems: 1
+    maxItems: 2
 
   interrupts:
     maxItems: 1
 
+  samsung,index:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Index of CPU cluster on which watchdog is running (in case of Exynos850)
+
   samsung,syscon-phandle:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
       Phandle to the PMU system controller node (in case of Exynos5250,
-      Exynos5420 and Exynos7).
+      Exynos5420, Exynos7 and Exynos850).
 
 required:
   - compatible
@@ -59,9 +66,38 @@ allOf:
               - samsung,exynos5250-wdt
               - samsung,exynos5420-wdt
               - samsung,exynos7-wdt
+              - samsung,exynos850-wdt
     then:
       required:
         - samsung,syscon-phandle
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos850-wdt
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Bus clock, used for register interface
+            - description: Source clock (driving watchdog counter)
+        clock-names:
+          items:
+            - const: watchdog
+            - const: watchdog_src
+        samsung,index:
+          enum: [0, 1]
+      required:
+        - samsung,index
+    else:
+      properties:
+        clocks:
+          items:
+            - description: Bus clock, which is also a source clock
+        clock-names:
+          items:
+            - const: watchdog
 
 unevaluatedProperties: false
 
-- 
2.30.2

