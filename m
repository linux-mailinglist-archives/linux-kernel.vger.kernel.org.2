Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106B8387C39
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 17:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350034AbhERPS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 11:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243998AbhERPS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 11:18:26 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C358C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 08:17:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id z19-20020a7bc7d30000b029017521c1fb75so1770700wmk.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 08:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oX2FWDTJXKAkYaew6nQcQrC7zAKbVD+lv92TvcmNFrs=;
        b=FzN3TN6lUQ0CZnk8VoKGL3Nd9p2PPppuRvfFJCdBcggeukhU6liuHsbWTv2hm490pJ
         g97vd6kptQAmKuEl8jPE5ddwXaBDqUOzNBVQs+h63I2Tr/5+4zUZVJoS8XthPlWI+Ppr
         bTYvcm8EuJIUUPGCa/5lssyQ9CIfN4SP6n7i1Hw0xp2MRIu5S7NpZ5pfImhbvs+f8u+q
         9BOz1SXJlsr+3MnWhBJjJY/zk0gZBB7Ze3+4kvHkfiB/27rqXyftQX0WADjQG5kAbvb6
         j6AYUU8y4NIeunYBA7rD1ISXzMA6r8d3qxdfaCsXHnbqxlHEx1doPmoNVuC5Vv6kT5h/
         lkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oX2FWDTJXKAkYaew6nQcQrC7zAKbVD+lv92TvcmNFrs=;
        b=XTZI/FPgfcLPGq/rzuzQuIwaUAEH/BLNKvo26G1x2/xghmYgcPuhGko2XcLkd1cqAg
         mOmWzr4RFRBY7KeAPeoLF/WsEu5Mqw98idH+VkxZI5MvjSgTGtNTbG9/lRRNpjwpEM/f
         2pObEhaGO3T8/MdaVqWQXmEDLKFuzBrzVSioVZmxThAbohIepoaVj4ZYHr3UJd9d48mg
         to1Hk9UZUY1NVmgVdpeW4vL+osgKGRk65HOkNEw/2kJEW7RMrUP9nE5Jd2x6xi6g1o1i
         sCXRK9R2kEdmjlANRnMFjP0EyVjYuilwE1U8ED4kJUDnjr0Queui2vx4RmPNsM7p8cLU
         W9AA==
X-Gm-Message-State: AOAM533dR1pnFuapFzYKT97ZfNXhqSzsroZVVQAvinKSPT9CgrZ39nxy
        8kVsqAVoLk7WgAvkZuRa7cbSJg==
X-Google-Smtp-Source: ABdhPJzXKIud3JJqMCfPxm2yOmdpLJSBdlJQjGno3UxJaXzzecxXcLBep8AX44s6aMVxnWlTPwy1Uw==
X-Received: by 2002:a05:600c:4f0f:: with SMTP id l15mr5497276wmq.143.1621351027095;
        Tue, 18 May 2021 08:17:07 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z9sm18005808wmi.17.2021.05.18.08.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 08:17:06 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linus.walleij@linaro.org, linux@armlinux.org.uk,
        robh+dt@kernel.org, ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/5] db-dinding: crypto: Add DT bindings documentation for sl3516-ce
Date:   Tue, 18 May 2021 15:16:51 +0000
Message-Id: <20210518151655.125153-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518151655.125153-1-clabbe@baylibre.com>
References: <20210518151655.125153-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation for Device-Tree bindings for the
SL3516-ce cryptographic offloader driver.
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../crypto/cortina,sl3516-crypto.yaml         | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/cortina,sl3516-crypto.yaml

diff --git a/Documentation/devicetree/bindings/crypto/cortina,sl3516-crypto.yaml b/Documentation/devicetree/bindings/crypto/cortina,sl3516-crypto.yaml
new file mode 100644
index 000000000000..8330b16a07e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/cortina,sl3516-crypto.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/cortina,sl3516-crypto.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SL3516 cryptographic offloader driver
+
+maintainers:
+  - Corentin Labbe <clabbe@baylibre.com>
+
+properties:
+  compatible:
+    enum:
+      - cortina,sl3516-crypto
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/cortina,gemini-clock.h>
+    #include <dt-bindings/reset/cortina,gemini-reset.h>
+
+    crypto@62000000 {
+        compatible = "cortina,sl3516-crypto";
+        reg = <0x62000000 0x10000>;
+        interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+        resets = <&syscon GEMINI_RESET_SECURITY>;
+        clocks = <&syscon GEMINI_CLK_GATE_SECURITY>;
+    };
-- 
2.26.3

