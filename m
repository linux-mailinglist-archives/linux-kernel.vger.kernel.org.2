Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2BA438060
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 00:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhJVWsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 18:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhJVWsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 18:48:18 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC8EC061767
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 15:45:59 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u21so503334lff.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 15:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bm1KHOnXO9Nvs/x1NBP6TsM2Dt9DXyHWBfDOZJg27a8=;
        b=EtCKFiatwuzA4uM+E8PWtwbbAe8XzQ7UUvuAMd8cRA8gKX4PEY/yqts7H6YG7/CMLM
         a/wNQytvXMKCr3maJK5FIRa31QxjMM8iA5ywrCoMBLH9Jql9MR1sDkCUUBtS15bBFVTz
         Tik5sNTQW1jbgyPq7wLbDyz21Bm3qgQmhPnOfhgIBwCGXT5vqsDTnCEuObZXvNCxaKI2
         3whQfZotJTMYyoXnHeYrq4a4wY27kJO99HoCgE6XBori3Dovuo+ufpEG6Pgbl42ce2ar
         wRVIKqlyderP80WeRrnGsPmnpsw7fdZoWXUlcvX1NvMLHAiuMkf30s8/jC02vQ3C+/qO
         KWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bm1KHOnXO9Nvs/x1NBP6TsM2Dt9DXyHWBfDOZJg27a8=;
        b=JOvg9yQ/D6t0MkEIlkHBMWoC30Ttfl/Hxl6Zq7sUaiqz6IJIBOgRyTIKY/vhhQoLPk
         ShcyYsx5aAb1eXinG4MF6RPZeK+31zLq5kqLUxbjLF2rIUDdNMv1dBQYsxofnxZsTTHm
         aldhZtCFH8GZfwdQWOVqE0G8X4AQWoEKbtdMiguZcpQwmCMOFL1T1Dgf8mSY2YYJZdKJ
         6DkMfO2FlP9ViN8UYdUbX+01MIUZD2ZdSvM2rFd15Lrl9VL/xnN6S718q3X10KDtkOWP
         xyb8eyV6vfDyky31rb1etPo/YMKboP5LDMBih+2f/gCLK1Md48jviQZsOZNX8BwST2iG
         Jrxw==
X-Gm-Message-State: AOAM533WPHsB6X0/Q17+bvBwFIh/xwGxD+FuFZZwWLciyja6UFnGCXK2
        a1NVBe88op59P3sKQARBqS3eHaofpTS18gig
X-Google-Smtp-Source: ABdhPJykSinQrW5tYMCkfcTqTWeVNXJPpKFxklqqD0dxJjpM+ZDacTlJnAzr/PdIr/kg70ibBzjdKg==
X-Received: by 2002:ac2:4426:: with SMTP id w6mr1158404lfl.90.1634942758007;
        Fri, 22 Oct 2021 15:45:58 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id b39sm923707lfv.200.2021.10.22.15.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 15:45:57 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: clock: samsung: Document Exynos850 CMU_APM
Date:   Sat, 23 Oct 2021 01:45:55 +0300
Message-Id: <20211022224556.18742-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMU_APM generates clocks for APM IP-core (Active Power Management). In
particular it generates RTC clocks, which are needed to enable rtc-s3c
driver on Exynos850 SoC.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes in v2:
  - Added R-b tag by Krzysztof Kozlowski
  - Added Ack by Chanwoo Choi

 .../clock/samsung,exynos850-clock.yaml        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
index 7f8c91a29b91..5618cfa62f80 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
@@ -32,6 +32,7 @@ properties:
   compatible:
     enum:
       - samsung,exynos850-cmu-top
+      - samsung,exynos850-cmu-apm
       - samsung,exynos850-cmu-core
       - samsung,exynos850-cmu-dpu
       - samsung,exynos850-cmu-hsi
@@ -68,6 +69,24 @@ allOf:
           items:
             - const: oscclk
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-apm
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: CMU_APM bus clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: dout_clkcmu_apm_bus
+
   - if:
       properties:
         compatible:
-- 
2.30.2

