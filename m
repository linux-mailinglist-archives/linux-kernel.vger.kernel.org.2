Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470CA3209B7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 12:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhBULIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 06:08:53 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:59994 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhBULIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 06:08:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 83C6DFB08;
        Sun, 21 Feb 2021 12:07:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xhnrK9k1cf-W; Sun, 21 Feb 2021 12:07:22 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id E2D35403FF; Sun, 21 Feb 2021 12:07:11 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/6] arm64: dts: librem5-devkit: Move headphone detection to sound card
Date:   Sun, 21 Feb 2021 12:07:11 +0100
Message-Id: <4c16b2bc0f0d1e3cd2beaf0edb8dd017b8ee62d7.1613905397.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613905396.git.agx@sigxcpu.org>
References: <cover.1613905396.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows for automatic output source switching in userspace. Enable
the pullup on the GPIO to actually make it trigger and mark it as
active-high since detection is reversed otherwise.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../dts/freescale/imx8mq-librem5-devkit.dts   | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index f818af592046..e3bfef98090a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -50,13 +50,6 @@ btn2 {
 			linux,code = <KEY_VOLUMEDOWN>;
 		};
 
-		hp-det {
-			label = "HP_DET";
-			gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
-			wakeup-source;
-			linux,code = <KEY_HP>;
-		};
-
 		wwan-wake {
 			label = "WWAN_WAKE";
 			gpios = <&gpio3 8 GPIO_ACTIVE_LOW>;
@@ -173,22 +166,25 @@ mic_mux: mic-mux {
 
 	sound {
 		compatible = "simple-audio-card";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hpdet>;
 		simple-audio-card,aux-devs = <&speaker_amp>, <&mic_mux>;
 		simple-audio-card,name = "Librem 5 Devkit";
 		simple-audio-card,format = "i2s";
 		simple-audio-card,widgets =
 			"Microphone", "Builtin Microphone",
 			"Microphone", "Headset Microphone",
-			"Headphone", "Headphone Jack",
+			"Headphone", "Headphones",
 			"Speaker", "Builtin Speaker";
 		simple-audio-card,routing =
 			"MIC_IN", "Mic Mux OUT",
 			"Mic Mux IN1", "Headset Microphone",
 			"Mic Mux IN2", "Builtin Microphone",
 			"Mic Mux OUT", "Mic Bias",
-			"Headphone Jack", "HP_OUT",
+			"Headphones", "HP_OUT",
 			"Builtin Speaker", "Speaker Amp OUTR",
 			"Speaker Amp INR", "LINE_OUT";
+		simple-audio-card,hp-det-gpio = <&gpio3 20 GPIO_ACTIVE_HIGH>;
 
 		simple-audio-card,cpu {
 			sound-dai = <&sai2>;
@@ -630,7 +626,6 @@ pinctrl_gpio_keys: gpiokeygrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SAI2_RXFS_GPIO4_IO21	0x16
 			MX8MQ_IOMUXC_SAI2_RXC_GPIO4_IO22	0x16
-			MX8MQ_IOMUXC_SAI5_RXC_GPIO3_IO20	0x180  /* HP_DET */
 			MX8MQ_IOMUXC_NAND_DATA02_GPIO3_IO8	0x80   /* nWoWWAN */
 		>;
 	};
@@ -641,6 +636,12 @@ MX8MQ_IOMUXC_SPDIF_RX_GPIO5_IO4		0xc6   /* nHAPTIC */
 		>;
 	};
 
+	pinctrl_hpdet: hpdetgrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SAI5_RXC_GPIO3_IO20	0xC0   /* HP_DET */
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL		0x4000001f
-- 
2.30.0

