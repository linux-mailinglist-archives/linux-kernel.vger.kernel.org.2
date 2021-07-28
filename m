Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390683D94E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhG1SBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbhG1SBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:01:08 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC51EC061764;
        Wed, 28 Jul 2021 11:01:05 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id x3so3088915qkl.6;
        Wed, 28 Jul 2021 11:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A7JOWTCTU3mD3oDw+k1gzAhKjoRm+3hquu6wc2UO4Yo=;
        b=NhfcLtyU22TcWSCOGXGgpZ+wknGxJBUJ5IiOpFCdLpmp46UYw742rMBwYjXqbZjzw1
         SdxLvYFtMWyj3r3NDGQiApGAVSArPmipjdGr7W7vnGvlZEYFkwguPDrommUZGF//UtGW
         0sbF2FhEItBqfeeoh+B+wC9+QKKaAxmot5SVomrGF4zhThnE2iXwvzvdDUbmdzpePTI3
         xS5dyhHaBV2oq0AT54Ti8A+g/T9BzEJxFqttkI3QnhOdKw4mQ5pb74XYLc2h3HdHsn9i
         5T/lISfJUU/zjOEA9lQiRHXkVZ36TUHUrewd0m/dtgLG2CD/SdgZxISNlGHfyPrp9cjP
         frTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A7JOWTCTU3mD3oDw+k1gzAhKjoRm+3hquu6wc2UO4Yo=;
        b=cK7mhppzFQNP3tydt9WR3xp+e9VOxOJApZGw58Ptvhv3FygENffudTCSCt9Sd/xlgH
         F2cDRAYlNIqVA3AKd8evZ4HKqtIglbJZ/UvgREs+Xki0Nft280p1eJlpINaAU29iuiUG
         R9hkL0eKn3TLzaGcG1Ty88R0gHfw7KLvRzPcg6MvK1qbThiYldaKjsgkmcEma37WiK6t
         dPX4F5Hfg/Ymi3RoCWL2UenVeDzr4z4YWgoMMEGQFzgDmceHc5QkCIJFnsqDAb5zPS04
         XYZFQZ3s5HCgc4GTmp3PvP8EgAw4XsYxqt4WP28+vCHF/hRE/PuyqG26wckw+P/dCOzw
         1lvQ==
X-Gm-Message-State: AOAM532rcRX7FhqpMAEsetihw8f8k841ifVBrN7Mu2TDA2FxMNx8U5NG
        hp4RXOQQM/Yyp6Rwy7Ot74k=
X-Google-Smtp-Source: ABdhPJwAeS8EcjSx8OOrubvq4e88OEay+SE8dd0bRnV9hpQSSmPWnW1xeHm+IBfMailcCNtrvqYvCQ==
X-Received: by 2002:a37:5d7:: with SMTP id 206mr969388qkf.170.1627495264946;
        Wed, 28 Jul 2021 11:01:04 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:b58:2ae8:d75f:660a])
        by smtp.gmail.com with ESMTPSA id r5sm223341qtm.75.2021.07.28.11.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 11:01:04 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] arm64: dts: rockchip: add thermal support to Quartz64 Model A
Date:   Wed, 28 Jul 2021 14:00:34 -0400
Message-Id: <20210728180034.717953-9-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728180034.717953-1-pgwipeout@gmail.com>
References: <20210728180034.717953-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the thermal nodes for the Quartz64 Model A.
The Model A supports a single speed gpio fan.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index b239f314b38a..a244f7b87e38 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -27,6 +27,14 @@ gmac1_clkin: external-gmac1-clock {
 		#clock-cells = <0>;
 	};
 
+	fan: gpio_fan {
+		compatible = "gpio-fan";
+		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
+		gpio-fan,speed-map = <0    0
+				      4500 1>;
+		#cooling-cells = <2>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -124,6 +132,23 @@ &cpu3 {
 	cpu-supply = <&vdd_cpu>;
 };
 
+&cpu_thermal {
+	trips {
+		cpu_hot: cpu_hot {
+			temperature = <55000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map1 {
+			trip = <&cpu_hot>;
+			cooling-device = <&fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &gmac1 {
 	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru SCLK_GMAC1>;
 	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru SCLK_GMAC1>, <&gmac1_clkin>;
@@ -433,6 +458,14 @@ &sdmmc0 {
 	status = "okay";
 };
 
+&tsadc {
+	/* tshut mode 0:CRU 1:GPIO */
+	rockchip,hw-tshut-mode = <1>;
+	/* tshut polarity 0:LOW 1:HIGH */
+	rockchip,hw-tshut-polarity = <0>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_xfer>;
-- 
2.25.1

