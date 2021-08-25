Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497F43F7619
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241369AbhHYNm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:42:29 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:35666
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241353AbhHYNm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:42:27 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DB3393F316
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 13:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629898900;
        bh=Fu7nhqoLsdx7J4VJ8i/X4VRnmeHuFEOaw/7iDh/5xwU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=VsOpWCPXIhH3Swy6ABGk05X+Sdt3SJFFc5+iONpLk35DeP5PVLjhFm77IEt9SqJxV
         keO3YDTdJD7Zf8lsIs8E3tN24P5Clh8m341wFwcmiJTccArmyM4bpHyajOVGoG511K
         ncLyHf126Vze7gVO2MhQy7Qv6pYDxGv0O+dfcQybp6v99QxwmY5V3gtVuqDp5ehOiD
         02Jvq1ELjlbrzS5eS7QKIZOamLA5AYcUI1thyHYiv7AyU1RY8Mz0dtzSm6+Fkta6Jx
         JjhukgkbW1Y+5F3SEfhkYVZIMUfNwCsaACTf1Tk6nNwTfaIBuA8IarzshoT3HycC/g
         d3WFHK/Bu5U9w==
Received: by mail-wr1-f72.google.com with SMTP id r17-20020adfda510000b02901526f76d738so6666745wrl.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 06:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fu7nhqoLsdx7J4VJ8i/X4VRnmeHuFEOaw/7iDh/5xwU=;
        b=Gr5R6H1qvkTfEo3Yfu0tvGORIZiC0hGRc7GhxCD1rsmgEl414LlxpMiuIJze/cY2Lc
         ZmlzwEus/2kD7XOezsC5vdyqlIuYU2ENXjXFURZseGWpr3HKRgAfk1dQ4qe2bAoHSHrz
         Mf6DtkKKjJx1U9UwqTK6r9H0SQboqJ/6SjL9bfp27rxA2g5n8FeB3Rz+AHAA/Sb2ggVt
         TxXEdfXKUEPD311/ddqOuuHAt0l3mjXTIYczJQ0as9fGeeuFicFdFtPV4Z3X2JqXvh2j
         4c5DfgqC6UiyC5DkVdRqumyqktMQl884pO1vZpMHqJDAa9Am8Ti1U85rPaaaVwQtqLkJ
         hJMg==
X-Gm-Message-State: AOAM531bdcsRNXmiKLwJZIf4e+xr7BgINvWoJibGXcwxqIn3qiCaAyt7
        GZOS1mlzICOhIdPR2/3k/EkTXHDQY0UaOwJGUxuLNtgBx3yBUT+2SXRfV2DqYllXPUQ6dr3pjMg
        cL/rNkDU9Twi9FVdkKndIT0yxHQhZwyf+m0pYwxcCYQ==
X-Received: by 2002:adf:f101:: with SMTP id r1mr22146847wro.355.1629898900205;
        Wed, 25 Aug 2021 06:41:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwv3aUuZKjhpsqEs0lCyA2F2p+XqsNIBWOW6aAfvOYHqCigAlulET63pPT8ux2hZPlYieuM1A==
X-Received: by 2002:adf:f101:: with SMTP id r1mr22146832wro.355.1629898900022;
        Wed, 25 Aug 2021 06:41:40 -0700 (PDT)
Received: from localhost.localdomain ([79.98.113.233])
        by smtp.gmail.com with ESMTPSA id g5sm7185861wrq.80.2021.08.25.06.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 06:41:39 -0700 (PDT)
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
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/8] dt-bindings: clock: samsung: add bindings for Exynos external clock
Date:   Wed, 25 Aug 2021 15:40:50 +0200
Message-Id: <20210825134056.219884-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825134056.219884-1-krzysztof.kozlowski@canonical.com>
References: <20210825134056.219884-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for Samsung Exynos external to SoC
(oscclk/XXTI/XusbXTI) clock provided on boards.  The bindings are
already implemented in most of the Exynos clock drivers and DTS files.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../clock/samsung,exynos-ext-clock.yaml       | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos-ext-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos-ext-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos-ext-clock.yaml
new file mode 100644
index 000000000000..64d027dbe3b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos-ext-clock.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/samsung,exynos-ext-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung SoC external/osc/XXTI/XusbXTI clock
+
+maintainers:
+  - Chanwoo Choi <cw00.choi@samsung.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+  - Tomasz Figa <tomasz.figa@gmail.com>
+
+description: |
+  Samsung SoCs require an external clock supplied through XXTI or XusbXTI pins.
+
+properties:
+  compatible:
+    enum:
+      - samsung,clock-xxti
+      - samsung,clock-xusbxti
+      - samsung,exynos5420-oscclk
+
+  "#clock-cells":
+    const: 0
+
+  clock-frequency: true
+
+  clock-output-names:
+    maxItems: 1
+
+required:
+  - compatible
+  - clock-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    fixed-rate-clocks {
+        clock {
+            compatible = "samsung,clock-xxti";
+            clock-frequency = <24000000>;
+        };
+    };
-- 
2.30.2

