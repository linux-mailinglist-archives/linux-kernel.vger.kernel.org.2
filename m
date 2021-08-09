Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F653E455B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 14:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbhHIMH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 08:07:59 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:45270
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234060AbhHIMH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 08:07:56 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 4865C3F359
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 12:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628510855;
        bh=OzcbdzDbFX/7hdNHc1Uaa9h5AIzXuGJQ7WWbGJRZv2I=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=UX83DbrEYzZD/xbSGD9F1vrBUU+IeHZ5OahWfvHC28/KONW13KSiHnfkgwqgMpeYO
         /2HFMKC0sxYkZL62D9ZtVkv/fe/WNKAb0UROIdKjJ5f2D+lXSga8xgxz4eTRc0UyfG
         Wm0KlnE+HJHZ7m+1aeffgif/X8pcxXz+78yJ3R553XqP+SjhLAIAO/nVB6QuIFMfiJ
         DQz5ZLuiRvxHFhXVews8w2wswb0ayzPRKF8x89PctHp/80WRxEiXCAmN+rZP1QOBQG
         1VNV7qrKS3B7gAVWcBpM98whJ8ThXjRUXb0GL1JMhuGNeph6Sys2+3DzumSivyDI29
         WeAr05+HrrSfg==
Received: by mail-ed1-f72.google.com with SMTP id g3-20020a0564024243b02903be33db5ae6so4649140edb.18
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 05:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OzcbdzDbFX/7hdNHc1Uaa9h5AIzXuGJQ7WWbGJRZv2I=;
        b=QV+U/qjML3e/xEwx4Gvn3nzhQGpPRXty8ea362Hq3RLd8oWN8B8RLniYaPrsMlsDyf
         kye4iFiFOcsepYC85ve/GTUn+rc0Ye52LSdVp4dV23pzfm+uWIQchcFiJf2gltryKDd5
         SO6qS5Xg0rHp8s2Y6kWNlB/alBgkcmnSxPizPq8aUZVZPMHzhnC1kSe3Pt9REtKMqRNZ
         0sfXffVb1t7ULm0Ksrnx6saBtasZSU98ruuketBQXzh5WTXJAN4nDRhYADiaaaOTCiai
         zGCuzL84/3xopnV6msQ3O8e4l4kB/0LsiYMs5rG6PXQUaohD/0zPJDrDuiA2AQJ+Hzvs
         5PbQ==
X-Gm-Message-State: AOAM531LWR0XSGkR3zoSZrXoJtIAiKIJKTBoG7Cl4UPRWInH3xWO1erO
        k8yeBhpNyz+w0gJcgJxmvJqdqol8V0LgZJS2MBF2ZW1pBV+P3BfFMpESeyAzkHHq2AfKjdiqH43
        1c1zvD1ciizyr1Oytk7c7kHvzxoGp2EUmEESTE+e9KQ==
X-Received: by 2002:aa7:dc02:: with SMTP id b2mr28698720edu.46.1628510854859;
        Mon, 09 Aug 2021 05:07:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwl0z9zY6TIRsWFOr2u74gnQQlWSGYod2iNeNyrZ86XebFxOWaMyJnUCR3NQeVehyALnrzY2g==
X-Received: by 2002:aa7:dc02:: with SMTP id b2mr28698690edu.46.1628510854621;
        Mon, 09 Aug 2021 05:07:34 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id i6sm8084863edt.28.2021.08.09.05.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 05:07:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH 2/3] dt-bindings: clock: samsung: add bindings for Exynos external clock
Date:   Mon,  9 Aug 2021 14:05:43 +0200
Message-Id: <20210809120544.56596-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809120544.56596-1-krzysztof.kozlowski@canonical.com>
References: <20210809120544.56596-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for Samsung Exynos external to SoC
(oscclk/XXTI/XusbXTI) clock provided on boards.  The bindings are
already implemented in most of the Exynos clock drivers and DTS files.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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

