Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E732D3E56FA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbhHJJc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:32:59 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:42638
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239094AbhHJJcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:32:53 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 03DEE3F049
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 09:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628587950;
        bh=OzcbdzDbFX/7hdNHc1Uaa9h5AIzXuGJQ7WWbGJRZv2I=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=s4IHJeV6bm9XYJ7hCRV5tq6xm0jKcBtwyzQyIDSsNeqkgj8z2x7F212gl8NA+lApX
         cS8g4rGwJBlqzYZE+uc0ucuzLYF949nJIStpaEwDo6Uo+XcsNoXDQcbGqCWz4yDn96
         +3fb2PQQn4YOIl2JhbzgVwc1wOG4HxInwOpBVRmEqQBW0NWqKHQnShwM5MhDBxsdEF
         jWXFc4Fo/kFEr1rIF6OTNGBJljWVFlr0TVthZEGrH5drVHeuT1IWQOxjjMwA20j44T
         PudpHNegvYEibsZNwsw/kdi6hU5mYPfEgX3KVyVOHgKTLDW5J60sZVsEuJ2ZUWmBfv
         UU/kuvSYuqv5w==
Received: by mail-ed1-f72.google.com with SMTP id a23-20020a50ff170000b02903b85a16b672so10497382edu.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 02:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OzcbdzDbFX/7hdNHc1Uaa9h5AIzXuGJQ7WWbGJRZv2I=;
        b=LpZ6+QJ8W01jmBi79u0cs5ZqyYndBnNilTZ9WC/nLbklhELxuRIe/Jhmz6N5nWPGt3
         t/KxGvnE2jWhLK21hbE5WWA7Gx0O2KlaCe8Q9byZncMuqXK0fa4OHldW9im7fecUpJUz
         osvFozb3KND5inNg8sgsXq5B0OA4TQrUdTss6u9KNQm4gB2lTPpob4BAXoXBITZnmRBX
         eixJVKd7AIVxMBoTXAL24aCvhXpeECJ+EFP7Cm9faOxQQlxynAYVXNfmBawubGqCbzKv
         FzIm1I+SJ+z0cQYbC2bIDR8cnjPMCpXtJOYESAtqDQH4bF91jcswIbMGmq/syPDuI2yg
         E6Ww==
X-Gm-Message-State: AOAM531JPvem9axc9EWdGMby62Q6mawOK1fPChfvQZcCk8O8DtcAeLk2
        NAoaL5kouPDqkWPVmmYLyZzGng84b1bVzU3DAqBVE1sFcLXPtWclObxRyNr+5BQk2jjoutlXM8X
        EMoXJiZesstfeKgFxIjeE/0Fssv9DMgnyKL2BCUluww==
X-Received: by 2002:a17:906:1919:: with SMTP id a25mr26443205eje.161.1628587949720;
        Tue, 10 Aug 2021 02:32:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEhq+DTJX3If44p8meBN5uqXskUe0qEC5dC6lsnCApRuAsi68OVH0j029oDIRI/IB9Bru+nA==
X-Received: by 2002:a17:906:1919:: with SMTP id a25mr26443186eje.161.1628587949557;
        Tue, 10 Aug 2021 02:32:29 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id q21sm5117606ejs.43.2021.08.10.02.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 02:32:29 -0700 (PDT)
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
Subject: [PATCH v2 2/8] dt-bindings: clock: samsung: add bindings for Exynos external clock
Date:   Tue, 10 Aug 2021 11:31:39 +0200
Message-Id: <20210810093145.26153-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210810093145.26153-1-krzysztof.kozlowski@canonical.com>
References: <20210810093145.26153-1-krzysztof.kozlowski@canonical.com>
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

