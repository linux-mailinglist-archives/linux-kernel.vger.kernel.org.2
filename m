Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6542C373CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhEEOCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:02:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54815 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbhEEOCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:02:53 -0400
Received: from mail-qk1-f198.google.com ([209.85.222.198])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1leI67-0008Pq-HM
        for linux-kernel@vger.kernel.org; Wed, 05 May 2021 14:01:55 +0000
Received: by mail-qk1-f198.google.com with SMTP id o14-20020a05620a130eb02902ea53a6ef80so1083083qkj.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 07:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oHaAGMQCQ1pAj//qWoQI8DKNyR6P/lkpmRo6s3ewDIo=;
        b=NudQSzZuCfqqVGM4+IpDg0ioW8V+rKjvyx7hlzrPbDyhloFO2cYHhNGsMJ/tNNVqW8
         3A/l0+TYlxe5gejneWnUhvLW5S/7f52uG7UhGB2pHlbK7AYnD3/apvI+ox32fTt5ERL6
         cojnd1j0+YbfCJtNJBLqeZjSH3CaIoVDupYUrg1UtH23ItIOhn8QqtcpPWj1KKBpfiMu
         T3yMqc7JEm99CwMmC+NvraVFKC0VeJAOB+GSUjz+41s9rb+ZKqKZdf36a0PBldCtapPI
         xHX41C1bB7z3B2wCthcorYSjxJLRPI5NQcLwDgoODjtdX73LEe0gnwS+Gge+Wx2i13y0
         gV4A==
X-Gm-Message-State: AOAM531DEQNKN/V/8XM0XQS1w1BFeHtyPnUx3QqlTk8FskqeyRFlFjwu
        0X3BcbYo2qOAftU/VWv7mrWiBHwMwFP4lWGpyTu3rt9dc1Q20eexJkYpORRKXBIY2J4MQTXwTY9
        WL/PRmnTdR7ZvvYP7iB0nIvarIAd0q8iFQZKh77cwrg==
X-Received: by 2002:a37:a6c6:: with SMTP id p189mr22057993qke.161.1620223314629;
        Wed, 05 May 2021 07:01:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzU763cPQ1xdHbff6dt62YRnHTN6UDqkMUU+zw0J+G/5UkccrdKaat1ubNv8PZ2xanVeRFnkw==
X-Received: by 2002:a37:a6c6:: with SMTP id p189mr22057979qke.161.1620223314451;
        Wed, 05 May 2021 07:01:54 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.2])
        by smtp.gmail.com with ESMTPSA id 97sm5016632qte.20.2021.05.05.07.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 07:01:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] ARM: dts: exynos: align Broadcom WiFi with dtschema
Date:   Wed,  5 May 2021 09:59:37 -0400
Message-Id: <20210505135941.59898-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom BCM4329 family dtschema expects devices to be compatible
also with brcm,bcm4329-fmac:

  arch/arm/boot/dts/exynos3250-rinato.dt.yaml: wifi@1: compatible: 'oneOf' conditional failed, one must be fixed:
    ['brcm,bcm4334-fmac'] is too short
    'brcm,bcm4329-fmac' was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos3250-rinato.dts         | 2 +-
 arch/arm/boot/dts/exynos4210-i9100.dts          | 2 +-
 arch/arm/boot/dts/exynos4210-trats.dts          | 2 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index c52b9cf4f74c..f6ba5e426040 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -653,7 +653,7 @@ &mshc_1 {
 	mmc-pwrseq = <&wlan_pwrseq>;
 
 	brcmf: wifi@1 {
-		compatible = "brcm,bcm4334-fmac";
+		compatible = "brcm,bcm4334-fmac", "brcm,bcm4329-fmac";
 		reg = <1>;
 
 		interrupt-parent = <&gpx1>;
diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
index 525ff3d2fac3..db70f62cc08f 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -806,7 +806,7 @@ &sdhci_3 {
 	pinctrl-0 = <&sd3_clk>, <&sd3_cmd>, <&sd3_bus4>;
 
 	brcmf: wifi@1 {
-		compatible = "brcm,bcm4330-fmac";
+		compatible = "brcm,bcm4330-fmac", "brcm,bcm4329-fmac";
 		reg = <1>;
 
 		interrupt-parent = <&gpx2>;
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index d2406c9146b8..3eb8df319246 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -521,7 +521,7 @@ &sdhci_3 {
 	pinctrl-0 = <&sd3_clk>, <&sd3_cmd>, <&sd3_bus4>;
 
 	brcmf: wifi@1 {
-		compatible = "brcm,bcm4330-fmac";
+		compatible = "brcm,bcm4330-fmac", "brcm,bcm4329-fmac";
 		reg = <1>;
 
 		interrupt-parent = <&gpx2>;
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index dd44ad2c6ad6..f052853244a4 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -614,7 +614,7 @@ &sdhci_3 {
 	pinctrl-0 = <&sd3_clk>, <&sd3_cmd>, <&sd3_bus4>;
 
 	brcmf: wifi@1 {
-		compatible = "brcm,bcm4330-fmac";
+		compatible = "brcm,bcm4330-fmac", "brcm,bcm4329-fmac";
 		reg = <1>;
 		interrupt-parent = <&gpx2>;
 		interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

