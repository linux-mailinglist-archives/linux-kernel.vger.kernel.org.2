Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68813E455D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 14:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhHIMIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 08:08:01 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:45272
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234887AbhHIMH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 08:07:57 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 8EA2C3F347
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 12:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628510856;
        bh=LfA7OKYMoMr4P+BoBEbRrouGl0bAW01mzwQl8SL+Db8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=MdNdupwDiFHaZXohPtTicgavLolxcNbaTWmBtjLem/iq5jp/xJ3gHNewIwUyRTxe9
         vgf4OeZ+P2QsheCqCsPNQXfJPoNiIRYNXKYiHbY7+rOoOeuGzMzOK8W2H5c5OMqKFL
         IaHO/oXFnyvRXpx2SdU1u6TzMo8NZ961tIl1AJ5W2H8b4IYyqcuOqLa7Nm05Q3hehK
         7L5xwNtrKFhXCtF7VZEAFBtdx0C00Kueir5ORYGx7vNxf/TfecB9kRmh0b99rf/cx7
         03ukXuuMmVUGe/kEO81wma2iQScuwDxWESrX+Uu3o+//Rw3c3bRXodVHUJGDj6Y3aA
         WF+IZLPXo4JxQ==
Received: by mail-ed1-f72.google.com with SMTP id e3-20020a50ec830000b02903be5be2fc73so2754797edr.16
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 05:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LfA7OKYMoMr4P+BoBEbRrouGl0bAW01mzwQl8SL+Db8=;
        b=DsHrGuSkbw9wg6s1EHD2dhvH6njgS+AwPFFjKN3rCRTslimMcYwXzI4J/x42O7zgMT
         r5WK2ju+KfWcwzwTWSJfCmAKnY+yhMEvWAGZFUMxVjXddyCcvpuHwbFl276IL8+yV+4b
         jNhWvNHDDb5jhAeCccAj+XQZ0pFzhn8wDJyn+ubM3hwAGgw45DB5BoNa4qjBg++VpAZP
         Vig9UKoyrpN/uR+CKXp9GMf3tiMpCq5rkFXqSbSKIMGVcKDC9CrOj9Jg7+/ggOy+YhSS
         /sup9M7ijoRLnVLkLVHc+ZHCF03WdzBxiDBUYEdZO8taxdRtzulLumkiTKPaG2lBBxn+
         QYcQ==
X-Gm-Message-State: AOAM532EcP2pyKmFVFH0NaWUBvscp0thMKkBeIoUVljm5+Shr1fEZ81P
        deUyTRHrMSRFni7CH1TvWFTKQ+CG3pIb4KDjNHqG3WHaYpERFOwwmyMUQZo4wMTjmosTMDFYpp+
        SY2Y2lozAwifTHmpEd/wHp6EvuQDsk1m3eyU6662x+w==
X-Received: by 2002:a17:907:76b9:: with SMTP id jw25mr21916354ejc.393.1628510856140;
        Mon, 09 Aug 2021 05:07:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuos2Z9gfhypAAu3nOPV+w+tJ10HOtSRDmMLpd34rRYAqFUz6mH+K3RHzU2QDUNrW5X1+yEA==
X-Received: by 2002:a17:907:76b9:: with SMTP id jw25mr21916341ejc.393.1628510855985;
        Mon, 09 Aug 2021 05:07:35 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id i6sm8084863edt.28.2021.08.09.05.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 05:07:35 -0700 (PDT)
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
Subject: [PATCH 3/3] dt-bindings: clock: samsung: convert Exynos542x to dtschema
Date:   Mon,  9 Aug 2021 14:05:44 +0200
Message-Id: <20210809120544.56596-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809120544.56596-1-krzysztof.kozlowski@canonical.com>
References: <20210809120544.56596-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge Exynos542x clock controller bindings to existing DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/clock/exynos5420-clock.txt       | 42 -------------------
 .../bindings/clock/samsung,exynos-clock.yaml  | 11 ++++-
 2 files changed, 10 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos5420-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt b/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
deleted file mode 100644
index 717a7b1531c7..000000000000
--- a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-* Samsung Exynos5420 Clock Controller
-
-The Exynos5420 clock controller generates and supplies clock to various
-controllers within the Exynos5420 SoC and for the Exynos5800 SoC.
-
-Required Properties:
-
-- compatible: should be one of the following.
-  - "samsung,exynos5420-clock" - controller compatible with Exynos5420 SoC.
-  - "samsung,exynos5800-clock" - controller compatible with Exynos5800 SoC.
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
-dt-bindings/clock/exynos5420.h header and can be used in device
-tree sources.
-
-Example 1: An example of a clock controller node is listed below.
-
-	clock: clock-controller@10010000 {
-		compatible = "samsung,exynos5420-clock";
-		reg = <0x10010000 0x30000>;
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
diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
index cd6567bd8cc7..b0f58a1cf6cb 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
@@ -18,7 +18,16 @@ description: |
 
 properties:
   compatible:
-    const: samsung,exynos5250-clock
+    oneOf:
+      - enum:
+          - samsung,exynos5250-clock
+          - samsung,exynos5420-clock
+          - samsung,exynos5800-clock
+      - items:
+          - enum:
+              - samsung,exynos5420-clock
+              - samsung,exynos5800-clock
+          - const: syscon
 
   assigned-clocks: true
   assigned-clock-parents: true
-- 
2.30.2

