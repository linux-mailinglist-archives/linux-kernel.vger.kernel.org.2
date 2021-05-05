Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740F7373CEA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbhEEODR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:03:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54834 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbhEEODL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:03:11 -0400
Received: from mail-qv1-f72.google.com ([209.85.219.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1leI6P-0008SY-WB
        for linux-kernel@vger.kernel.org; Wed, 05 May 2021 14:02:14 +0000
Received: by mail-qv1-f72.google.com with SMTP id b10-20020a0cf04a0000b02901bda1df3afbso1716493qvl.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 07:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTU4LvKoIv4gbIfQl210SnqkxjG4gaXmVLweqPSDUqI=;
        b=CK7/6dPEHKMpB2QlCZ3P+pTfwC3SsoBcPeEvi5tS8oRN84y3jNuRoPsbAzbXGlq+x4
         RfEoZEWiOsOR3FjGrXt1iDD9X4x7g6QzBZR/15mUaDWzoTrFTL+lXxj4Mj18zqWX7doa
         KZymyPiA5qgT/arZtMwuO/LpiAD+kYVGYDpZku2HqnWfQQ8+2NLe4DvVP86M4UtQuR7g
         bxuOKqwsFmb+fJRUXfXyZ/6Kkx7yhVxWKcZZuX7hjSC6uZX7ibwifFmSomnlGSt2UnTE
         AQEuXJkaNHYdNcz6uzhuHs8gx039utbxftzjpT9OhkvpaAXVR4A0IkAVSd4d0w31GvRm
         mIlw==
X-Gm-Message-State: AOAM533DOSVjPiaayYHy9UwaLL2Moq5ZC/GqtmRg4SmuYvqyJR1qlTrL
        3EYLS8nmfFq81wt6470oaFfzcavN+d0VOGaCoHF5s20GIWJhdWK1c81MqpRA80SaWrFx8eucdjN
        ivLneDyQirlE4SWq7gGkBRcWcfb5il9Y8N9Z/zFxx0Q==
X-Received: by 2002:a37:a6c6:: with SMTP id p189mr22059580qke.161.1620223333157;
        Wed, 05 May 2021 07:02:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNcZdZr9OarCUN7JS5MpdDZOe89c0ANjh7iN+CrZx0Za+sQThYLZ0fXL8V4Op7GS3d+n0c6Q==
X-Received: by 2002:a37:a6c6:: with SMTP id p189mr22059565qke.161.1620223333014;
        Wed, 05 May 2021 07:02:13 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.2])
        by smtp.gmail.com with ESMTPSA id 97sm5016632qte.20.2021.05.05.07.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 07:02:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] ARM: dts: exynos: fix PWM LED max brightness on Odroid XU/XU3
Date:   Wed,  5 May 2021 09:59:39 -0400
Message-Id: <20210505135941.59898-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505135941.59898-1-krzysztof.kozlowski@canonical.com>
References: <20210505135941.59898-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no "max_brightness" property.  This brings the intentional
brightness reduce of green LED and dtschema checks as well:

  arch/arm/boot/dts/exynos5410-odroidxu.dt.yaml: led-controller-1: led-1: 'max-brightness' is a required property

Fixes: 719f39fec586 ("ARM: dts: exynos5422-odroidxu3: Hook up PWM and use it for LEDs")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi b/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
index 2fc3e86dc5f7..982752e1df24 100644
--- a/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
+++ b/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
@@ -22,7 +22,7 @@ led-1 {
 			 * Green LED is much brighter than the others
 			 * so limit its max brightness
 			 */
-			max_brightness = <127>;
+			max-brightness = <127>;
 			linux,default-trigger = "mmc0";
 		};
 
@@ -30,7 +30,7 @@ led-2 {
 			label = "blue:heartbeat";
 			pwms = <&pwm 2 2000000 0>;
 			pwm-names = "pwm2";
-			max_brightness = <255>;
+			max-brightness = <255>;
 			linux,default-trigger = "heartbeat";
 		};
 	};
-- 
2.25.1

