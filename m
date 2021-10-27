Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452A943CC61
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242609AbhJ0OkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbhJ0OkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:40:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62606C061570;
        Wed, 27 Oct 2021 07:37:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z14so4562711wrg.6;
        Wed, 27 Oct 2021 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ECYBC4YNujNcfruFWFj5cKTQLy3jB52lzNAq73G9ODI=;
        b=WbLTG5z/2bX7mQkpZ20I/XHwbLEHWBZUHGye6qS7zMYsl85xenrtP3igf3w8vmbGZl
         yQ5DU8T0FcbKh2bL3uIZLPTsW2SbJsPu3F178yLzQEmUGO+g45XfTcFynvFwhqv9OO2v
         qixGGNpRkpGDhuYKCWDSIhJs9gXuKu5t4Pr8R9WmR0Y83mG3mvzsDl5hR0wIX4fOsEjr
         C87J+9EtyqwDvQ+UrWdlecbtUKDEpQYtmt658iRhoulvUo7mNVWF1lB9VqoSnkJkSizk
         YAwyYnNWsfrN24nbuGy4eoD9lLzWTbLFfD5dRiVnjQs4hW4A9NduSaDbXIDWbd27+gpt
         OKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECYBC4YNujNcfruFWFj5cKTQLy3jB52lzNAq73G9ODI=;
        b=RtIMkRfB8+5cGRNTgzI6FZze6dkYQUM8ix3QJ2VeS0VSeLTtMqkYJtRasuk6qAQW0A
         ND8bxVg+s8DGZqqaBoxo9t6mPp+D2FPtd1oioicMzYz0KPaPTHtTc4NRSjBMhMht5mje
         jteD2LvTAfKR8N619E+lexpZQmeuh8pfEFuN7nj4nc+LcVlOZjlRQ+RalJ9OwPcyliTc
         7xDF3JNdd4j4ILb2bxOuIWoKP57AtXS5KVMAEFjZTMQjN4kK+KCp0g74sH6Tvsx6st42
         RtrC3JvEzfoZc0r9ts7K2vK6xo9cplwsrQpOzl/rR6yE0ETcagP49Iqf52e4YEgov0CH
         dtRw==
X-Gm-Message-State: AOAM532JFkavKSWSgjxMX6S7xDxz+ALAL3iR2SxMcSaoWRLSrPVMLSy/
        i3peDCM/CBKw1NCnR2C6ZA==
X-Google-Smtp-Source: ABdhPJxM2xWFRcYqepvLXxjzgmiMicba79H5c9p5JTK4rrrGKSDr9cU4H9ZbipquZRtbuWCNQuZc6A==
X-Received: by 2002:a05:6000:2a2:: with SMTP id l2mr34083026wry.109.1635345462964;
        Wed, 27 Oct 2021 07:37:42 -0700 (PDT)
Received: from alex-ThinkPad-E480.. ([2a02:810b:f40:4200:8072:4c96:3e48:9ebf])
        by smtp.googlemail.com with ESMTPSA id p21sm25866wmc.11.2021.10.27.07.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 07:37:42 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 2/2] arm64: dts: rockchip: add interrupt and headphone-detection for Rock Pi4's audio codec
Date:   Wed, 27 Oct 2021 16:37:26 +0200
Message-Id: <20211027143726.165809-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027143726.165809-1-knaerzche@gmail.com>
References: <20211027143726.165809-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As schematics at [1] and [2] show C- and plus-revisions have interrupt and
headphone detection lines of ES8316 codec connected.

Add them to the respective device trees.

[1] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi_4c_v12_sch_20200620.pdf
[2] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4b_plus_v16_sch_20200628.pdf

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi   | 12 +++++++++++-
 .../boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts     | 11 +++++++++++
 .../boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts     | 11 +++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts   | 11 +++++++++++
 4 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index 6a434be62819..92acf6ea299b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -36,7 +36,7 @@ sdio_pwrseq: sdio-pwrseq {
 		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
 	};
 
-	sound {
+	sound: sound {
 		compatible = "audio-graph-card";
 		label = "Analog";
 		dais = <&i2s0_p0>;
@@ -543,6 +543,16 @@ bt_wake_l: bt-wake-l {
 		};
 	};
 
+	es8316 {
+		hp_detect: hp-detect {
+			rockchip,pins = <1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		hp_int: hp-int {
+			rockchip,pins = <1 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	pcie {
 		pcie_pwr_en: pcie-pwr-en {
 			rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts
index 281a04b2f5e9..f5a68d8d072d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts
@@ -12,3 +12,14 @@ / {
 	model = "Radxa ROCK Pi 4A+";
 	compatible = "radxa,rockpi4a-plus", "radxa,rockpi4", "rockchip,rk3399";
 };
+
+&es8316 {
+	pinctrl-0 = <&hp_detect &hp_int>;
+	pinctrl-names = "default";
+	interrupt-parent = <&gpio1>;
+	interrupts = <RK_PA1 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&sound {
+	hp-det-gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
index dfad13d2ab24..81bea953c891 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
@@ -17,6 +17,13 @@ aliases {
 	};
 };
 
+&es8316 {
+	pinctrl-0 = <&hp_detect &hp_int>;
+	pinctrl-names = "default";
+	interrupt-parent = <&gpio1>;
+	interrupts = <RK_PA1 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &sdio0 {
 	status = "okay";
 
@@ -31,6 +38,10 @@ brcmf: wifi@1 {
 	};
 };
 
+&sound {
+	hp-det-gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
+};
+
 &uart0 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
index 99169bcd51c0..0ad7b6e22f70 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
@@ -17,6 +17,13 @@ aliases {
 	};
 };
 
+&es8316 {
+	pinctrl-0 = <&hp_detect &hp_int>;
+	pinctrl-names = "default";
+	interrupt-parent = <&gpio1>;
+	interrupts = <RK_PA1 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &sdio0 {
 	status = "okay";
 
@@ -31,6 +38,10 @@ brcmf: wifi@1 {
 	};
 };
 
+&sound {
+	hp-det-gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
+};
+
 &uart0 {
 	status = "okay";
 
-- 
2.30.2

