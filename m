Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6645F36E382
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 05:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhD2DIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 23:08:52 -0400
Received: from inva021.nxp.com ([92.121.34.21]:52316 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229762AbhD2DIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 23:08:51 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4B9FA20235C;
        Thu, 29 Apr 2021 05:08:04 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D00DB2011B7;
        Thu, 29 Apr 2021 05:07:59 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9377840287;
        Thu, 29 Apr 2021 05:07:54 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shengjiu.wang@gmail.com
Subject: [PATCH] ARM: dts: imx6ul: Switch to fsl-asoc-card sound card
Date:   Thu, 29 Apr 2021 10:52:19 +0800
Message-Id: <1619664739-12589-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is issue with simple sound card, the simple sound
card can't configure the pll of codec.

[  115.352669] wm8960 1-001a: failed to configure clock
[  115.358843] wm8960 1-001a: ASoC: error at snd_soc_dai_hw_params on wm8960-hifi: -22

So Switch to fsl-asoc-card and the fsl-asoc-card can support
asrc module as front-end component.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi | 50 +++++++++++--------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
index 5a1e10def6ef..779cc536566d 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
@@ -60,38 +60,26 @@ reg_can_3v3: regulator-can-3v3 {
 		gpios = <&gpio_spi 3 GPIO_ACTIVE_LOW>;
 	};
 
-	sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "mx6ul-wm8960";
-		simple-audio-card,format = "i2s";
-		simple-audio-card,bitclock-master = <&dailink_master>;
-		simple-audio-card,frame-master = <&dailink_master>;
-		simple-audio-card,widgets =
-			"Microphone", "Mic Jack",
-			"Line", "Line In",
-			"Line", "Line Out",
-			"Speaker", "Speaker",
-			"Headphone", "Headphone Jack";
-		simple-audio-card,routing =
+	sound-wm8960 {
+		compatible = "fsl,imx-audio-wm8960";
+		model = "wm8960-audio";
+		audio-cpu = <&sai2>;
+		audio-codec = <&codec>;
+		audio-asrc = <&asrc>;
+		hp-det-gpio = <&gpio5 4 0>;
+		audio-routing =
 			"Headphone Jack", "HP_L",
 			"Headphone Jack", "HP_R",
-			"Speaker", "SPK_LP",
-			"Speaker", "SPK_LN",
-			"Speaker", "SPK_RP",
-			"Speaker", "SPK_RN",
-			"LINPUT1", "Mic Jack",
+			"Ext Spk", "SPK_LP",
+			"Ext Spk", "SPK_LN",
+			"Ext Spk", "SPK_RP",
+			"Ext Spk", "SPK_RN",
+			"LINPUT2", "Mic Jack",
 			"LINPUT3", "Mic Jack",
-			"RINPUT1", "Mic Jack",
-			"RINPUT2", "Mic Jack";
-
-		simple-audio-card,cpu {
-			sound-dai = <&sai2>;
-		};
-
-		dailink_master: simple-audio-card,codec {
-			sound-dai = <&codec>;
-			clocks = <&clks IMX6UL_CLK_SAI2>;
-		};
+			"RINPUT1", "AMIC",
+			"RINPUT2", "AMIC",
+			"Mic Jack", "MICB",
+			"AMIC", "MICB";
 	};
 
 	spi4 {
@@ -145,6 +133,10 @@ codec: wm8960@1a {
 		compatible = "wlf,wm8960";
 		reg = <0x1a>;
 		wlf,shared-lrclk;
+		wlf,hp-cfg = <3 2 3>;
+		wlf,gpio-cfg = <1 3>;
+		clocks = <&clks IMX6UL_CLK_SAI2>;
+		clock-names = "mclk";
 	};
 
 	camera@3c {
-- 
2.27.0

