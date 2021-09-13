Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE7E4091B6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 16:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245605AbhIMOEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 10:04:01 -0400
Received: from comms.puri.sm ([159.203.221.185]:39980 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343735AbhIMOBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 10:01:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id E0720E129E;
        Mon, 13 Sep 2021 06:57:39 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id looLM0Jr5CNu; Mon, 13 Sep 2021 06:57:39 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        kernel@puri.sm, Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 5/6] arm64: dts: imx8mq-librem5: add power sequencing for M.2 cards
Date:   Mon, 13 Sep 2021 15:57:05 +0200
Message-Id: <20210913135706.309685-6-martin.kepplinger@puri.sm>
In-Reply-To: <20210913135706.309685-1-martin.kepplinger@puri.sm>
References: <20210913135706.309685-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angus Ainslie <angus@akkea.ca>

Some wifi cards need reset asserted until after the power supplies
have been enabled.

So wire up the W_DISABLE signal for the SDIO port (WIFI_REG_ON net) and
the BT_REG_ON net to use it for power sequencing.

Signed-off-by: Angus Ainslie <angus@akkea.ca>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 .../boot/dts/freescale/imx8mq-librem5.dtsi    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index e5fdb50557f2..65c86fbbd6d1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -199,6 +199,14 @@ simple-audio-card,codec {
 		};
 	};
 
+	usdhc2_pwrseq: pwrseq {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_bt>, <&pinctrl_wifi_disable>;
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio3 25 GPIO_ACTIVE_HIGH>,
+			      <&gpio4 29 GPIO_ACTIVE_HIGH>;
+	};
+
 	bm818_codec: sound-wwan-codec {
 		compatible = "broadmobi,bm818", "option,gtm601";
 		#sound-dai-cells = <0>;
@@ -313,6 +321,13 @@ MX8MQ_IOMUXC_NAND_DQS_GPIO3_IO14	0x83
 		>;
 	};
 
+	pinctrl_bt: btgrp {
+		fsl,pins = <
+			/* BT_REG_ON */
+			MX8MQ_IOMUXC_SAI5_MCLK_GPIO3_IO25	0x83
+		>;
+	};
+
 	pinctrl_charger_in: chargeringrp {
 		fsl,pins = <
 			/* CHRG_INT */
@@ -644,6 +659,13 @@ MX8MQ_IOMUXC_SD2_RESET_B_USDHC2_RESET_B 0xc1
 		>;
 	};
 
+	pinctrl_wifi_disable: wifidisablegrp {
+		fsl,pins = <
+			/* WIFI_REG_ON */
+			MX8MQ_IOMUXC_SAI3_RXC_GPIO4_IO29	0x83
+		>;
+	};
+
 	pinctrl_wifi_pwr: wifipwrgrp {
 		fsl,pins = <
 			/* WIFI3V3_EN */
@@ -1213,6 +1235,7 @@ &usdhc2 {
 	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
 	bus-width = <4>;
 	vmmc-supply = <&reg_wifi_3v3>;
+	mmc-pwrseq = <&usdhc2_pwrseq>;
 	post-power-on-delay-ms = <1000>;
 	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
 	disable-wp;
-- 
2.30.2

