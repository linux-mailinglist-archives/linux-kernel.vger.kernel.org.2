Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189E033B2FB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhCOMns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:43:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33256 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhCOMnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:43:20 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lLmZ5-0004h2-Ay
        for linux-kernel@vger.kernel.org; Mon, 15 Mar 2021 12:43:19 +0000
Received: by mail-wm1-f70.google.com with SMTP id v5so8135118wml.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 05:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ap5ykNmpsbJrdR3iXM5yH1laQEs7sajDaAHvKopsfYY=;
        b=qIllMkk8m2ViJmkWyXxFFVFKZqJP0VixIKExB5k7BQs4ipoAGjBy+Vq2hz9e9+rPdc
         DQ4XXgtclTH0wJSuttY1pzPxr1utn8RxailbHISAnsfX9PnOGwzNfhHOJQwxASiuoWax
         7/a0fuHaDbI9BFaXDI8Vifw4qgj+pnm6X/zaiId+EqiFsllYcvT3/dIdi5zbFOw+CkuH
         KfQU8GGHK/BFwqciA9OOxsSYUm+JLi/f3Q8e/nk+C9Msn8dIWhRu973gTrAnicNsR9Ck
         28DW92r7fY1JcslssooIEsld74c24C73lQzLTC8oGbcANOgHYeZht17lrdYeezAyV+p8
         GfvA==
X-Gm-Message-State: AOAM533b0T6cKSx1FfaYMMtPMXgy2V/brcIvIj+clfCdwyrufVEcAmHa
        MBGaspo+FZLQoy0oIJgJwkoAu2U9VzhVRLgfssGIQU5j4T+l+Du118zme3OHqkehP6wIE7zMEg4
        EyoOnUWXAWMamNM/keumOQ3us5qaQUoKKVLn5s4J6gg==
X-Received: by 2002:a1c:dd89:: with SMTP id u131mr25312318wmg.54.1615812199081;
        Mon, 15 Mar 2021 05:43:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmU1m3dmd00t2dinw2OgM+pPhoIqpEjxFpRuHHFrZ/nlHv0DtmWmNj9mLulLOyG1tXv3t5pg==
X-Received: by 2002:a1c:dd89:: with SMTP id u131mr25312303wmg.54.1615812198908;
        Mon, 15 Mar 2021 05:43:18 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id r10sm14410094wmh.45.2021.03.15.05.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:43:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/3] ARM: dts: exynos: replace deprecated NTC/Murata compatibles
Date:   Mon, 15 Mar 2021 13:43:11 +0100
Message-Id: <20210315124313.114842-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatibles with "ntc" vendor prefix become deprecated and "murata"
should be used.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos3250-monk.dts   | 4 ++--
 arch/arm/boot/dts/exynos3250-rinato.dts | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index fae046e08a5d..8b41a9d5e2db 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -142,7 +142,7 @@ &adc {
 	assigned-clock-rates = <6000000>;
 
 	thermistor-ap {
-		compatible = "ntc,ncp15wb473";
+		compatible = "murata,ncp15wb473";
 		pullup-uv = <1800000>;
 		pullup-ohm = <100000>;
 		pulldown-ohm = <100000>;
@@ -150,7 +150,7 @@ thermistor-ap {
 	};
 
 	thermistor-battery {
-		compatible = "ntc,ncp15wb473";
+		compatible = "murata,ncp15wb473";
 		pullup-uv = <1800000>;
 		pullup-ohm = <100000>;
 		pulldown-ohm = <100000>;
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index d64ccf4b7d32..c52b9cf4f74c 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -142,7 +142,7 @@ &adc {
 	assigned-clock-rates = <6000000>;
 
 	thermistor-ap {
-		compatible = "ntc,ncp15wb473";
+		compatible = "murata,ncp15wb473";
 		pullup-uv = <1800000>;
 		pullup-ohm = <100000>;
 		pulldown-ohm = <100000>;
@@ -150,7 +150,7 @@ thermistor-ap {
 	};
 
 	thermistor-battery {
-		compatible = "ntc,ncp15wb473";
+		compatible = "murata,ncp15wb473";
 		pullup-uv = <1800000>;
 		pullup-ohm = <100000>;
 		pulldown-ohm = <100000>;
-- 
2.25.1

