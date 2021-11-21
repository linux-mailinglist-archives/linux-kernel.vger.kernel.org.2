Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0847E458719
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 00:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhKUXa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 18:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhKUXaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 18:30:55 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A03BC061714
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 15:27:49 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id y26so72019319lfa.11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 15:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8CZKqka7M6tEP9XVjxB965JDKVWEBscM9hH1JFJ6ZQ=;
        b=YEEEiJW178qXfDDc0lusKijK4A5UHRKm4Zk131Dw0u0RfiBMb6De7fk21+pRhJI6rU
         gHfGnD+468uPGASMJnY4lCeLrlIMSfBsU8V6JNmr4d06nVSJi4e5NPiKsZYIMBRpBXld
         9PVgl72pG/02StJ/MYgiIR46poPSnOL8JiplmbbgbHlG78ESK6ndNrYbuWEDLlDYmrji
         vOb6oGl189xDMF5pzcNmI39vYDVXtehsXYPTyPxTtw5tTgJZSEoGModxcZAuBEg7Vy81
         qRqVtoNwxIeiZa/Ion7m4AK3TViTdu+8gx1KEVdqOw9KnBH2bXcdV81e/2eGyCDDeg+Q
         ozCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8CZKqka7M6tEP9XVjxB965JDKVWEBscM9hH1JFJ6ZQ=;
        b=Kf+zCXRiPr7t6gNfSKKwCfuQF6EGS6uxIjQOvzx3mlgK/4dsoKjI1J9zKvLVJGEzK6
         UhCJuYEgCGGgJp22dyR7RETcwYWtafwDDCHtcsk91ui/uEMNn573kLlXM6+6VK/qdANv
         pjPVd+Q4+AhE/D4Is7ScSfMYypJS9DEHrb3ArA2vUv0EFFjWxOKC5LYr3u9mO2f0cuyk
         uyWwAqOuRB6cCyduEHtQA+84HczOwuttY1yTuU0p3vEeTrKVNf6xQXByhTA7a0Ge8b5T
         7qj401dsPpNqoLs4q/2czlP0d9xyrIKK2CkwXAJ0OMU/YSPNqHju5GBHMGrfnBpt0vY4
         9LvA==
X-Gm-Message-State: AOAM533cf8abQd7/SxAEQ4Xzz1UV+UPIYMo2n9J4wt4ZDNA27EJorv17
        UauODvckaD/HRzk18QUc3mt+hw==
X-Google-Smtp-Source: ABdhPJzD+8zJSuHLU6JveUo3jrkNaH50rQSXy7vBXwXD0Iy3UFqqkwso7IqNjw+3Ijo2FKj9b11aEA==
X-Received: by 2002:a2e:7a11:: with SMTP id v17mr33328270ljc.33.1637537267633;
        Sun, 21 Nov 2021 15:27:47 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id b26sm778961lff.148.2021.11.21.15.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 15:27:47 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     David Virag <virag.david003@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 3/6] dt-bindings: clock: Add bindings for Exynos850 CMU_CMGP
Date:   Mon, 22 Nov 2021 01:27:38 +0200
Message-Id: <20211121232741.6967-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211121232741.6967-1-semen.protsenko@linaro.org>
References: <20211121232741.6967-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMU_CMGP generates USI and ADC clocks for BLK_ALIVE. In particular USI
clocks are needed for HSI2C_3 and HSI2C_4 instances.

Add clock indices and bindings documentation for CMU_CMGP domain.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 .../clock/samsung,exynos850-clock.yaml        | 19 +++++++++++++++++++
 include/dt-bindings/clock/exynos850.h         | 17 +++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
index 5618cfa62f80..80ba60838f2b 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
@@ -33,6 +33,7 @@ properties:
     enum:
       - samsung,exynos850-cmu-top
       - samsung,exynos850-cmu-apm
+      - samsung,exynos850-cmu-cmgp
       - samsung,exynos850-cmu-core
       - samsung,exynos850-cmu-dpu
       - samsung,exynos850-cmu-hsi
@@ -87,6 +88,24 @@ allOf:
             - const: oscclk
             - const: dout_clkcmu_apm_bus
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-cmgp
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: CMU_CMGP bus clock (from CMU_APM)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: gout_clkcmu_cmgp_bus
+
   - if:
       properties:
         compatible:
diff --git a/include/dt-bindings/clock/exynos850.h b/include/dt-bindings/clock/exynos850.h
index df3978b58304..8aa5e82af0d3 100644
--- a/include/dt-bindings/clock/exynos850.h
+++ b/include/dt-bindings/clock/exynos850.h
@@ -84,6 +84,23 @@
 #define CLK_GOUT_SPEEDY_PCLK		21
 #define APM_NR_CLK			22
 
+/* CMU_CMGP */
+#define CLK_RCO_CMGP			1
+#define CLK_MOUT_CMGP_ADC		2
+#define CLK_MOUT_CMGP_USI0		3
+#define CLK_MOUT_CMGP_USI1		4
+#define CLK_DOUT_CMGP_ADC		5
+#define CLK_DOUT_CMGP_USI0		6
+#define CLK_DOUT_CMGP_USI1		7
+#define CLK_GOUT_CMGP_ADC_S0_PCLK	8
+#define CLK_GOUT_CMGP_ADC_S1_PCLK	9
+#define CLK_GOUT_CMGP_GPIO_PCLK		10
+#define CLK_GOUT_CMGP_USI0_IPCLK	11
+#define CLK_GOUT_CMGP_USI0_PCLK		12
+#define CLK_GOUT_CMGP_USI1_IPCLK	13
+#define CLK_GOUT_CMGP_USI1_PCLK		14
+#define CMGP_NR_CLK			15
+
 /* CMU_HSI */
 #define CLK_MOUT_HSI_BUS_USER		1
 #define CLK_MOUT_HSI_MMC_CARD_USER	2
-- 
2.30.2

