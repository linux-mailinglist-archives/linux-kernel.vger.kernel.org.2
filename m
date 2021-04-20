Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC5A365DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhDTQuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:50:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49843 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbhDTQun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:50:43 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYtZi-0003a3-Vt
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 16:50:11 +0000
Received: by mail-ej1-f71.google.com with SMTP id z6-20020a17090665c6b02903700252d1ccso5000564ejn.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 09:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fn7WNZfjW0ssAzIaE1Bkd1jfIrVSqjALIl9VWkYNFrI=;
        b=LmPUIdU7kE6MWFX3dqYj87oNtfS7AgnBIN23vlgBC9n6Iw4Hzn2/sih22MygNgllv3
         FbK4vqXFEV9hw/w4d6D34C1p8wyfLMr5Faea9uMbhzt1uGZbV4jQdo1pCF5auFZpn/fA
         EFcD1EaC2YecsL+VJcM2xqogrs5fGRzn7mmycVQxrJ+5RgKZ2ZDdwVGv7ED1Z9zSz4ld
         ie+A09rMVzNpNqTfg6qvDw1kdJFk2vJ5NCLDjNa0wdjfkSHvTYeL6+CZK0UsIFruI66N
         ZdJ4+VNnDbFXsidMbE9Di87x7iokRbTl+c34QHySFfW+4Nb1Jj5Yu4xlFYLZrlp08ek+
         k13g==
X-Gm-Message-State: AOAM5303VRF4GlTEVaZEwF479ov0w6Fd+O6E4zXe0fC/Ui6WuUTXt7uD
        6FuaZ55OfOJXrOWZpdSrj7Fvd/aKCDbsDy2dzIl903WOi5Fx109vqANnCwcUqxrKJSNeVPUhcAU
        jg9WTiOHTfa0T64mjmyBWL7ey700hDaawWR70Qj59YA==
X-Received: by 2002:a17:906:ecb8:: with SMTP id qh24mr29480538ejb.162.1618937410726;
        Tue, 20 Apr 2021 09:50:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQSsSBBW1PF+n0XJ+szv31xF4/G4mzXij8EuyYawNnaIWsWmfuu6kMMnZ5Oveq3ByZm6pv8w==
X-Received: by 2002:a17:906:ecb8:: with SMTP id qh24mr29480531ejb.162.1618937410609;
        Tue, 20 Apr 2021 09:50:10 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id c12sm18252873edx.54.2021.04.20.09.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 09:50:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] ARM: dts: exynos: enable PMIC wakeup from suspend on Odroid XU3/XU4 family
Date:   Tue, 20 Apr 2021 18:49:42 +0200
Message-Id: <20210420164943.11152-10-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420164943.11152-1-krzysztof.kozlowski@canonical.com>
References: <20210420164943.11152-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC on S2MPS11 PMIC on Odroid XU3/XU4 family of boards can wakeup
the system from suspend to RAM.  Add a generic property for this.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 6d690b1db099..e7958dbecfd2 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -512,6 +512,7 @@ pmic@66 {
 		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&s2mps11_irq>;
+		wakeup-source;
 
 		s2mps11_osc: clocks {
 			compatible = "samsung,s2mps11-clk";
-- 
2.25.1

