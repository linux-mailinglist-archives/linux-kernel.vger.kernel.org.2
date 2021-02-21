Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DF63209B3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 12:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhBULIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 06:08:09 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:59868 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhBULIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 06:08:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 0660CFB04;
        Sun, 21 Feb 2021 12:07:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pMBaL3QD9tAE; Sun, 21 Feb 2021 12:07:14 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id B3BA4403D9; Sun, 21 Feb 2021 12:07:11 +0100 (CET)
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
Subject: [PATCH v1 2/6] arm64: dts: librem5-devkit: Add speaker amplifier
Date:   Sun, 21 Feb 2021 12:07:07 +0100
Message-Id: <53e81ef700ebc77acea774e691888ae8a0a8d4cf.1613905397.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613905396.git.agx@sigxcpu.org>
References: <cover.1613905396.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the amplifier that drives the builtin speaker.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../dts/freescale/imx8mq-librem5-devkit.dts   | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 0c0b12c90363..d01bed5eb9e0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -165,19 +165,21 @@ wwan_codec: sound-wwan-codec {
 
 	sound {
 		compatible = "simple-audio-card";
+		simple-audio-card,aux-devs = <&speaker_amp>;
 		simple-audio-card,name = "Librem 5 Devkit";
 		simple-audio-card,format = "i2s";
 		simple-audio-card,widgets =
 			"Microphone", "Microphone Jack",
 			"Headphone", "Headphone Jack",
-			"Speaker", "Speaker Ext",
+			"Speaker", "Builtin Speaker",
 			"Line", "Line In Jack";
 		simple-audio-card,routing =
 			"MIC_IN", "Microphone Jack",
 			"Microphone Jack", "Mic Bias",
 			"LINE_IN", "Line In Jack",
 			"Headphone Jack", "HP_OUT",
-			"Speaker Ext", "LINE_OUT";
+			"Builtin Speaker", "Speaker Amp OUTR",
+			"Speaker Amp INR", "LINE_OUT";
 
 		simple-audio-card,cpu {
 			sound-dai = <&sai2>;
@@ -207,6 +209,15 @@ telephony_link_master: simple-audio-card,codec {
 		};
 	};
 
+	speaker_amp: speaker-amp {
+		compatible = "simple-audio-amplifier";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_spkamp>;
+		VCC-supply = <&reg_3v3_p>;
+		sound-name-prefix = "Speaker Amp";
+		enable-gpios = <&gpio5 3 GPIO_ACTIVE_HIGH>;
+	};
+
 	vibrator {
 		compatible = "gpio-vibrator";
 		pinctrl-names = "default";
@@ -641,6 +652,12 @@ MX8MQ_IOMUXC_SAI5_RXFS_GPIO3_IO19	0x8  /* IMU_INT */
 		>;
 	};
 
+	pinctrl_spkamp: spkamp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SPDIF_TX_GPIO5_IO3		0x81  /* MUTE */
+		>;
+	};
+
 	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x80  /* PMIC intr */
-- 
2.30.0

