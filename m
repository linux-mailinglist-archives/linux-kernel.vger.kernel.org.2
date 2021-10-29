Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F002440F8E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 17:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhJaQxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 12:53:43 -0400
Received: from ixit.cz ([94.230.151.217]:41868 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229838AbhJaQxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 12:53:39 -0400
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 745DF236BE;
        Fri, 29 Oct 2021 13:49:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1635508196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5E4M99vMPTvOFmcUC+iHe20MffqlLM2e2yyycVCMrFc=;
        b=x/6JTSGL7EvLUnu1jDXAHmvK0BgihWBaAzBpLB5VseZ4ZQW7DAFaDLwJIOWrMW6d7EmXJO
        7rkL/Qe3/FDJH3twa56e+yWRj1QEjVucJD97hW1MV4EYbyy6Xa9USQ2JA75Kblxpjr1mo6
        Zdk0xio1jfVXFgkgJXwpowKavksrYvs=
From:   David Heidelberg <david@ixit.cz>
To:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     ~okias/devicetree@lists.sr.ht, phone-devel@vger.kernel.org,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 2/3] arm64: dts: make dts use gpio-fan matrix instead of array
Date:   Fri, 29 Oct 2021 13:49:45 +0200
Message-Id: <20211029114948.41841-2-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211029114948.41841-1-david@ixit.cz>
References: <20211029114948.41841-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes.

Adjust to comply with dt-schema requirements
and make possible to validate values.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 9 +++++----
 arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts     | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi     | 2 +-
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts    | 5 +++--
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 86bdc0baf032..fbbcacf24f2e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -52,10 +52,11 @@ gpio_fan: gpio-fan {
 		gpios = <&gpio GPIODV_14 GPIO_ACTIVE_HIGH
 			 &gpio GPIODV_15 GPIO_ACTIVE_HIGH>;
 		/* Dummy RPM values since fan is optional */
-		gpio-fan,speed-map = <0 0
-				      1 1
-				      2 2
-				      3 3>;
+		gpio-fan,speed-map =
+				<0 0>,
+				<1 1>,
+				<2 2>,
+				<3 3>;
 		#cooling-cells = <2>;
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
index a3b9d615a3b4..e34045d10a12 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
@@ -39,7 +39,7 @@ reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
 
 	fan: gpio-fan {
 		compatible = "gpio-fan";
-		gpio-fan,speed-map = <0 0 8600 1>;
+		gpio-fan,speed-map = <0 0>, <8600 1>;
 		gpios = <&gpio3 5 GPIO_ACTIVE_HIGH>;
 		#cooling-cells = <2>;
 		pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
index 46b0f97a0b1c..4af535866d1f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
@@ -44,7 +44,7 @@ dc_12v: dc-12v {
 	fan0: gpio-fan {
 		#cooling-cells = <2>;
 		compatible = "gpio-fan";
-		gpio-fan,speed-map = <0 0 3000 1>;
+		gpio-fan,speed-map = <0 0>, <3000 1>;
 		gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index 4d4b2a301b1a..8af3763daaba 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -30,8 +30,9 @@ gmac1_clkin: external-gmac1-clock {
 	fan: gpio_fan {
 		compatible = "gpio-fan";
 		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
-		gpio-fan,speed-map = <0    0
-				      4500 1>;
+		gpio-fan,speed-map =
+				<   0 0>,
+				<4500 1>;
 		#cooling-cells = <2>;
 	};
 
-- 
2.33.0

