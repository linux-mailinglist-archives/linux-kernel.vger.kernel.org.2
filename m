Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666D13E56FF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239192AbhHJJdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:33:07 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:42636
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239112AbhHJJcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:32:55 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id F1A8B40C76
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 09:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628587952;
        bh=QT8SwdEZ0R6TNUIJP6/Ss9c7WD6R+hflCwKGvca5iIE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=H1K9/pqqBnwJBT/DQD7vYA05qx7pfXILIBy4od/iPKklFA44M8IV76cF9DEsgF7y7
         oJpgEEDAl/QYDGi9uNmViNlqDOOuMmrN7Ak4YVfAOS+5bJluIk6yE9J13KBS1LsZZ4
         5YLn04kqUsot388x2+zW/gVBEw+ne6DziftdwSprEFpRuxrlqDhKnli+R7iwwiONPc
         WJS5oM0+1tpLryWcu74RDTkDSIHJr1pmEFC7uMcl2wPzFXUuRc6mT/PNEeI0gmLX0L
         czrSBsxdSmbZfNdXR9ghnqKZKzof5eZBKP95+tpS/0saDZKgmH6Gads5poMSRnu2fs
         nu9loBKGfdYUg==
Received: by mail-ed1-f69.google.com with SMTP id u4-20020a50eac40000b02903bddc52675eso10302045edp.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 02:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QT8SwdEZ0R6TNUIJP6/Ss9c7WD6R+hflCwKGvca5iIE=;
        b=a6ZfNt4C/R+i77+A9b8zenRN4pnja7JYpIlze8t6FrKQmOd9Tph2XtmiWzIYPRkFRT
         ETivV43cRigJyRsr+QFV18fPrcOedB3pLAc9j0ti7600Oww27SjKfLVXF3drm4jVgJuu
         cFIqMKljO/JancRR9TNVG4ZPy/14P9B7rc4e9m06FZnbUvsNM3SxHkBTQqeQr/y44gUI
         Hk1gr0dvQVhvHRMJ4A631SxHI/1Ht/DS7JJFVZQEIR5QQjQMQcHrghqVbB1m0a66GTtV
         uCAQOEAy4VJEzSBDaLLyOZC/lbqwT+/vEyqJSRTg9nzLtpll2V1qeJaKyvEbk+5CLZZU
         Z/Sw==
X-Gm-Message-State: AOAM532nIfdoy7b5EyC6Cn8comBK//qYiMOLFk8q6EBOiI2wuuKCFQEE
        Dh+u33MudWbEXs00DURIhPEBe/Fc++M7xq4+5HU+18Q73FbcdzFac7cObu5QFjLEHYIzyZvA97C
        wUy3I+253iqxBMvC8qPz3PcgoBB8mcXgvCc872TqidQ==
X-Received: by 2002:a05:6402:3550:: with SMTP id f16mr3169484edd.191.1628587952683;
        Tue, 10 Aug 2021 02:32:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+o8bUuWkirAFl52z/kbYcwQxBg3oWWQP3FGZ3pXj8hg/97qF8mslqZDVz6WXbuCr8+yyEPA==
X-Received: by 2002:a05:6402:3550:: with SMTP id f16mr3169462edd.191.1628587952533;
        Tue, 10 Aug 2021 02:32:32 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id q21sm5117606ejs.43.2021.08.10.02.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 02:32:32 -0700 (PDT)
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
Subject: [PATCH v2 4/8] dt-bindings: clock: samsung: convert Exynos3250 to dtschema
Date:   Tue, 10 Aug 2021 11:31:41 +0200
Message-Id: <20210810093145.26153-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210810093145.26153-1-krzysztof.kozlowski@canonical.com>
References: <20210810093145.26153-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge Exynos3250 clock controller bindings to existing DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/clock/exynos3250-clock.txt       | 57 -------------------
 .../bindings/clock/samsung,exynos-clock.yaml  |  3 +
 2 files changed, 3 insertions(+), 57 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos3250-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/exynos3250-clock.txt b/Documentation/devicetree/bindings/clock/exynos3250-clock.txt
deleted file mode 100644
index 7441ed519f02..000000000000
--- a/Documentation/devicetree/bindings/clock/exynos3250-clock.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-* Samsung Exynos3250 Clock Controller
-
-The Exynos3250 clock controller generates and supplies clock to various
-controllers within the Exynos3250 SoC.
-
-Required Properties:
-
-- compatible: should be one of the following.
-  - "samsung,exynos3250-cmu" - controller compatible with Exynos3250 SoC.
-  - "samsung,exynos3250-cmu-dmc" - controller compatible with
-    Exynos3250 SoC for Dynamic Memory Controller domain.
-  - "samsung,exynos3250-cmu-isp" - ISP block clock controller compatible
-     with Exynos3250 SOC
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
-dt-bindings/clock/exynos3250.h header and can be used in device
-tree sources.
-
-Example 1: Examples of clock controller nodes are listed below.
-
-	cmu: clock-controller@10030000 {
-		compatible = "samsung,exynos3250-cmu";
-		reg = <0x10030000 0x20000>;
-		#clock-cells = <1>;
-	};
-
-	cmu_dmc: clock-controller@105c0000 {
-		compatible = "samsung,exynos3250-cmu-dmc";
-		reg = <0x105C0000 0x2000>;
-		#clock-cells = <1>;
-	};
-
-	cmu_isp: clock-controller@10048000 {
-		compatible = "samsung,exynos3250-cmu-isp";
-		reg = <0x10048000 0x1000>;
-		#clock-cells = <1>;
-	};
-
-Example 2: UART controller node that consumes the clock generated by the clock
-	   controller. Refer to the standard clock bindings for information
-	   about 'clocks' and 'clock-names' property.
-
-	serial@13800000 {
-		compatible = "samsung,exynos4210-uart";
-		reg = <0x13800000 0x100>;
-		interrupts = <0 109 0>;
-		clocks = <&cmu CLK_UART0>, <&cmu CLK_SCLK_UART0>;
-		clock-names = "uart", "clk_uart_baud0";
-	};
diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
index b0f58a1cf6cb..c7b07fcd3fa1 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
@@ -20,6 +20,9 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - samsung,exynos3250-cmu
+          - samsung,exynos3250-cmu-dmc
+          - samsung,exynos3250-cmu-isp
           - samsung,exynos5250-clock
           - samsung,exynos5420-clock
           - samsung,exynos5800-clock
-- 
2.30.2

