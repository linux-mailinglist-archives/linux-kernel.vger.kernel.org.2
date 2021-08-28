Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386B93FA4FD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 12:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhH1K2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 06:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhH1K2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 06:28:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05CCC061756;
        Sat, 28 Aug 2021 03:27:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id h9so19549934ejs.4;
        Sat, 28 Aug 2021 03:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tXzl0+fzsQFRNFfaE0xHEGy4Y7scX8OLe96hsEArTYw=;
        b=u1NGnfYAWhGLDOLASC9S+V8Kaidcgz1eztLCcF3Us7umRZYSZ+LV0ua9GYYG52hT1q
         TiYpNTqcd97SwNx5ydN28BfBDG8lse5cgIfMWhRmn53KgQ+3/50szns2BhsJ+0DR8ust
         mfW7ejHJqFJLrHBGGir+fB5z5hy/D7BgHEXtrajwwfg3lh9an+JPkasMyd9lMOOrwaDL
         HB+y3ZU6MAvbxvotiiyfOl1yys4CSgW9I7b35T3H/38UZiTZaacarYNabX3Q0wVtyZdQ
         huHKOjT1bpmcybO35KuX/m3lGbdpBnj8fSph1g5zjRr3gTKoqRq2fEUseZ6MSbfha9PG
         2ivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tXzl0+fzsQFRNFfaE0xHEGy4Y7scX8OLe96hsEArTYw=;
        b=T4Sg6GsjfmnH0fF931j4mvoW+uXsTCVRQX9zGqks8Do/hS+iDNF2mXfFaMmmQdW+4g
         qkDQiV6SdsYd8zlTXc9Rc9HoSdlArPwjtxSniNogwv9Q2+wIWzIdsa3/lLLhkuN/H6NM
         MGdPWhP6YvkBGnp5uMIfWn82f1y9CZPuSpVihzv/YnVtyF2wihQ8hek4lY3uRciBnb20
         e2Qj3c5WgIjweDaU8nyB+zLbrPSMgOIseqztUAWLQtTC+9bXCGgkLYjqbs1GvkCEVZFu
         OPx2GBxna7sJ9uhb27nNIGOMKx7k1L42BBuvt8ZRZLyV+tW/kIMN29IUPpqJ7zH8G2SL
         FaUA==
X-Gm-Message-State: AOAM533YzRqDlCt1FxHmpImSr3WY59FKzBpTtxct48ovdWj//weBRn8O
        5Gv/F9D0ddPEOjZ7wWPco3knApZYETtHU+7t
X-Google-Smtp-Source: ABdhPJy0McnAeRa3hj7JCBpxYEn4ABgUippP1b2Dcg+sfc5Q/FU8uTIytLVxGR4VwUppqGS4jPD29g==
X-Received: by 2002:a50:998f:: with SMTP id m15mr14162154edb.193.1630146425675;
        Sat, 28 Aug 2021 03:27:05 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id e11sm4705445edq.30.2021.08.28.03.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 03:27:05 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: swap timer clock-names
Date:   Sat, 28 Aug 2021 12:26:59 +0200
Message-Id: <20210828102659.7348-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the conversion of rockchip,rk-timer.yaml the clock-names order
was set to "pclk", "timer", but nothing was fixed in the ARM dts section
of the mainline kernel, so the swap timer clock-names that don't fit.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036.dtsi | 4 ++--
 arch/arm/boot/dts/rk322x.dtsi | 4 ++--
 arch/arm/boot/dts/rv1108.dtsi | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index ffa9bc7ed..6864b8668 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -416,8 +416,8 @@
 		compatible = "rockchip,rk3036-timer", "rockchip,rk3288-timer";
 		reg = <0x20044000 0x20>;
 		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&xin24m>, <&cru PCLK_TIMER>;
-		clock-names = "timer", "pclk";
+		clocks = <&cru PCLK_TIMER>, <&xin24m>;
+		clock-names = "pclk", "timer";
 	};
 
 	pwm0: pwm@20050000 {
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 4021e92e0..dea025a64 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -477,8 +477,8 @@
 		compatible = "rockchip,rk3228-timer", "rockchip,rk3288-timer";
 		reg = <0x110c0000 0x20>;
 		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&xin24m>, <&cru PCLK_TIMER>;
-		clock-names = "timer", "pclk";
+		clocks = <&cru PCLK_TIMER>, <&xin24m>;
+		clock-names = "pclk", "timer";
 	};
 
 	cru: clock-controller@110e0000 {
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 7d96a0d02..140434384 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -300,8 +300,8 @@
 		compatible = "rockchip,rv1108-timer", "rockchip,rk3288-timer";
 		reg = <0x10350000 0x20>;
 		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&xin24m>, <&cru PCLK_TIMER>;
-		clock-names = "timer", "pclk";
+		clocks = <&cru PCLK_TIMER>, <&xin24m>;
+		clock-names = "pclk", "timer";
 	};
 
 	watchdog: watchdog@10360000 {
-- 
2.20.1

