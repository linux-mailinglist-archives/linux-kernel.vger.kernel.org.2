Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0023209B6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 12:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhBULIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 06:08:42 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:59992 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhBULIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 06:08:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 88CBAFB07;
        Sun, 21 Feb 2021 12:07:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 26h5ZKKtVGCy; Sun, 21 Feb 2021 12:07:20 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id D6A7840404; Sun, 21 Feb 2021 12:07:11 +0100 (CET)
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
Subject: [PATCH v1 5/6] arm64: dts: librem5-devkit: Add mux for built-in vs headset mic
Date:   Sun, 21 Feb 2021 12:07:10 +0100
Message-Id: <cdd0c4f966fd425425c056043d8672334b49d32b.1613905397.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613905396.git.agx@sigxcpu.org>
References: <cover.1613905396.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mux so we can select either headset or built-in microphone input.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../dts/freescale/imx8mq-librem5-devkit.dts   | 25 ++++++++++++++++---
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index aac05bbaa001..f818af592046 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -163,18 +163,29 @@ wwan_codec: sound-wwan-codec {
 		#sound-dai-cells = <0>;
 	};
 
+	mic_mux: mic-mux {
+		compatible = "simple-audio-mux";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_micsel>;
+		mux-gpios = <&gpio5 5 GPIO_ACTIVE_LOW>;
+		sound-name-prefix = "Mic Mux";
+	};
+
 	sound {
 		compatible = "simple-audio-card";
-		simple-audio-card,aux-devs = <&speaker_amp>;
+		simple-audio-card,aux-devs = <&speaker_amp>, <&mic_mux>;
 		simple-audio-card,name = "Librem 5 Devkit";
 		simple-audio-card,format = "i2s";
 		simple-audio-card,widgets =
-			"Microphone", "Microphone Jack",
+			"Microphone", "Builtin Microphone",
+			"Microphone", "Headset Microphone",
 			"Headphone", "Headphone Jack",
 			"Speaker", "Builtin Speaker";
 		simple-audio-card,routing =
-			"MIC_IN", "Microphone Jack",
-			"Microphone Jack", "Mic Bias",
+			"MIC_IN", "Mic Mux OUT",
+			"Mic Mux IN1", "Headset Microphone",
+			"Mic Mux IN2", "Builtin Microphone",
+			"Mic Mux OUT", "Mic Bias",
 			"Headphone Jack", "HP_OUT",
 			"Builtin Speaker", "Speaker Amp OUTR",
 			"Speaker Amp INR", "LINE_OUT";
@@ -650,6 +661,12 @@ MX8MQ_IOMUXC_SAI5_RXFS_GPIO3_IO19	0x8  /* IMU_INT */
 		>;
 	};
 
+	pinctrl_micsel: micselgrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5	0xc6  /* MIC_SEL */
+		>;
+	};
+
 	pinctrl_spkamp: spkamp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SPDIF_TX_GPIO5_IO3		0x81  /* MUTE */
-- 
2.30.0

