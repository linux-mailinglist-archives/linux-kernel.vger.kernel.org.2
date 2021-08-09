Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F483E4643
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbhHINLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 09:11:50 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:49008
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235159AbhHINLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:11:47 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id DBF0940679
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 13:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628514685;
        bh=QT8SwdEZ0R6TNUIJP6/Ss9c7WD6R+hflCwKGvca5iIE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=UsqH39gyrJpQhGVY3qqOLslaz8kbZHNiXUPAi4TQQ7RKpK3L89YuriqQl7/aB5KsI
         i1lReYtfF6+qbyEqAm1SPn0bKSG87rob8sW2g/HpIdHcR6YMBAVI2CDBFG8QKJrXob
         cuZilE2dtyPLsYAxW3U3A97KtNfTYzDISxmN23Cn+BaE2KhDhHH9wgiQBNH4/ZZejK
         ZOdyQPh25kHCrcv8f3yxR7NyXLVxLaPoEmeiXa7v+FkWXcPCvisU2Mr0CwViv0bUYP
         wZHFC+cCZ2sgZmiHt3Ayfp+WLQM5qqSMJsXxuAYjcVTkEZbMzTpVDbFcGgi5iDTc2B
         hk0j1yWpXbqZQ==
Received: by mail-ed1-f72.google.com with SMTP id k14-20020a05640212ceb02903bc50d32c17so8926615edx.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 06:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QT8SwdEZ0R6TNUIJP6/Ss9c7WD6R+hflCwKGvca5iIE=;
        b=h0bPkGDwQrYNSzmQodDPZd5RK7Q0CAFGSFvtpKEjIjmPuVCYcAbor6tlaKzLHpRylp
         r90gw/N5GqgiOUyJXklODBKJ2JwsUTVJzeZUKoCvd/FeaS+IyStL9hNIx2/A5EFHVUYr
         RYSC7ehpoays8izv1/pN0Wy5xV9VNlCIEbjpq28Ep6zrjPUJKhSaY327lollDOepXGqi
         07wVvp1/2AoCWgLbTaKP5b7We5LtqB/cXKuicEjF4iXxgan1vDxYLbMHT4MB2EMt/CUt
         D4HLNop9uxefxtVTDWbLh4NPdp94Rq4gSkZVLnzZsC85XKYmph0Gz8NjWEupR5Fpydpe
         A6RQ==
X-Gm-Message-State: AOAM532IUFx2FP1x3pUWCkRvaF/PY6Q8JIlEvH8lTPAPt2vf93HDDUK5
        IKxvN+z7+sP7UfCDvxELfgA5saLWw2BYRJXc16llfZpzSO3Xi3o6xaZM78G3r8P8Q/SQZgdaHGo
        x8Y02sIwKT8bs0IvoHriU/fVq7SDZISaZFcBRuFaoCA==
X-Received: by 2002:a05:6402:1603:: with SMTP id f3mr29666983edv.274.1628514685601;
        Mon, 09 Aug 2021 06:11:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsBn38E/01SuiowZudPrXAASccbbFYi5v/N0fNRNffxu2X4kYSHdNIQQP0mWfQ0n1EBaDBhw==
X-Received: by 2002:a05:6402:1603:: with SMTP id f3mr29666944edv.274.1628514685342;
        Mon, 09 Aug 2021 06:11:25 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id cf16sm8023425edb.92.2021.08.09.06.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 06:11:24 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: clock: samsung: convert Exynos3250 to dtschema
Date:   Mon,  9 Aug 2021 15:09:34 +0200
Message-Id: <20210809130935.80565-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809130935.80565-1-krzysztof.kozlowski@canonical.com>
References: <20210809130935.80565-1-krzysztof.kozlowski@canonical.com>
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

