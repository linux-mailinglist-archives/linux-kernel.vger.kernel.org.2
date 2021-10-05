Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBF0422853
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbhJENwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:52:04 -0400
Received: from comms.puri.sm ([159.203.221.185]:44010 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235171AbhJENv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:51:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id F1640E126E;
        Tue,  5 Oct 2021 06:49:37 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d7L9YQfy76eH; Tue,  5 Oct 2021 06:49:37 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     martin.kepplinger@puri.sm
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, kernel@puri.sm,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, robh@kernel.org, shawnguo@kernel.org,
        Angus Ainslie <angus@akkea.ca>
Subject: [PATCH v2 5/7] arm64: dts: imx8mq-librem5: add power sequencing for M.2 cards
Date:   Tue,  5 Oct 2021 15:49:00 +0200
Message-Id: <20211005134902.2138731-6-martin.kepplinger@puri.sm>
In-Reply-To: <20211005134902.2138731-1-martin.kepplinger@puri.sm>
References: <20211005134902.2138731-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
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
index 7a09312f31c4..396eb4434229 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -198,6 +198,14 @@ simple-audio-card,codec {
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
@@ -312,6 +320,13 @@ MX8MQ_IOMUXC_NAND_DQS_GPIO3_IO14	0x83
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
@@ -643,6 +658,13 @@ MX8MQ_IOMUXC_SD2_RESET_B_USDHC2_RESET_B 0xc1
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
@@ -1212,6 +1234,7 @@ &usdhc2 {
 	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
 	bus-width = <4>;
 	vmmc-supply = <&reg_wifi_3v3>;
+	mmc-pwrseq = <&usdhc2_pwrseq>;
 	post-power-on-delay-ms = <1000>;
 	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
 	disable-wp;
-- 
2.30.2

