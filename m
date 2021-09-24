Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDB3416E63
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 10:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245102AbhIXJAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 05:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245031AbhIXJAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:00:16 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291A9C061756;
        Fri, 24 Sep 2021 01:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IPUPNCwWkiWtX6ylRhZipI+kIlL+1Bu1bPcs/0DR0oc=; b=ZkAH0Eg6x981Px5VOxQh/fdnE4
        4vW1LkyADoLk8+eSIpPFlrm6Kcl32YurUcqFqGpWWao1glzMTzaZh8oc3KIWG9Mu3DJEuKzzuyWsb
        nokn3qTEhN8aGAF4xGXDNwHEyvtkEAGgoKcSTE9EzBsVpOi4yqICxzRnKLGVLD3y3aB4=;
Received: from p200300ccff0ce8001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:e800:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mTh2S-00025O-KM; Fri, 24 Sep 2021 10:58:36 +0200
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1mTh2S-00Ak4X-6F; Fri, 24 Sep 2021 10:58:36 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, krzk@kernel.org,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 4/4] ARM: dts: imx: add devicetree for Tolino Vision 5
Date:   Fri, 24 Sep 2021 10:58:32 +0200
Message-Id: <20210924085832.2560317-5-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210924085832.2560317-1-andreas@kemnade.info>
References: <20210924085832.2560317-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a devicetree for the Tolino Vision 5 Ebook reader. It is
based on boards called ¨e70k02¨. It is equipped with an imx6sl SoC.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v2:
- mmc pinmux node names: -grp at the end
- s/_/-/ in other node names

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/imx6sl-tolino-vision5.dts | 349 ++++++++++++++++++++
 2 files changed, 350 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6sl-tolino-vision5.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index c8c7a876ac57..a1377657af7d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -635,6 +635,7 @@ dtb-$(CONFIG_SOC_IMX6SL) += \
 	imx6sl-evk.dtb \
 	imx6sl-tolino-shine2hd.dtb \
 	imx6sl-tolino-shine3.dtb \
+	imx6sl-tolino-vision5.dtb \
 	imx6sl-warp.dtb
 dtb-$(CONFIG_SOC_IMX6SLL) += \
 	imx6sll-evk.dtb \
diff --git a/arch/arm/boot/dts/imx6sl-tolino-vision5.dts b/arch/arm/boot/dts/imx6sl-tolino-vision5.dts
new file mode 100644
index 000000000000..ff6118df3946
--- /dev/null
+++ b/arch/arm/boot/dts/imx6sl-tolino-vision5.dts
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: (GPL-2.0)
+/*
+ * Device tree for the Tolino Vision 5 ebook reader
+ *
+ * Name on mainboard is: 37NB-E70K0M+6A3
+ * Serials start with: E70K02 (a number also seen in
+ * vendor kernel sources)
+ *
+ * This mainboard seems to be equipped with different SoCs.
+ * In the Tolino Vision 5 ebook reader it is a i.MX6SL
+ *
+ * Copyright 2021 Andreas Kemnade
+ * based on works
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "imx6sl.dtsi"
+#include "e70k02.dtsi"
+
+/ {
+	model = "Tolino Vision 5";
+	compatible = "kobo,tolino-vision5", "fsl,imx6sl";
+};
+
+&gpio_keys {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio_keys>;
+};
+
+&i2c1 {
+	pinctrl-names = "default","sleep";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_sleep>;
+};
+
+&i2c2 {
+	pinctrl-names = "default","sleep";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_sleep>;
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_gpio_keys: gpio-keysgrp {
+		fsl,pins = <
+			MX6SL_PAD_FEC_CRS_DV__GPIO4_IO25	0x17059	/* PWR_SW */
+			MX6SL_PAD_FEC_MDC__GPIO4_IO23	0x17059	/* HALL_EN */
+			MX6SL_PAD_KEY_COL4__GPIO4_IO00		0x17059	/* PAGE_UP */
+			MX6SL_PAD_KEY_COL5__GPIO4_IO02		0x17059	/* PAGE_DOWN */
+		>;
+	};
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX6SL_PAD_LCD_DAT1__GPIO2_IO21	0x79
+			MX6SL_PAD_LCD_DAT4__GPIO2_IO24	0x79
+			MX6SL_PAD_LCD_DAT5__GPIO2_IO25	0x79
+			MX6SL_PAD_LCD_DAT6__GPIO2_IO26	0x79
+			MX6SL_PAD_LCD_DAT7__GPIO2_IO27	0x79
+			MX6SL_PAD_LCD_DAT8__GPIO2_IO28	0x79
+			MX6SL_PAD_LCD_DAT9__GPIO2_IO29	0x79
+			MX6SL_PAD_LCD_DAT10__GPIO2_IO30	0x79
+			MX6SL_PAD_LCD_DAT11__GPIO2_IO31	0x79
+			MX6SL_PAD_LCD_DAT12__GPIO3_IO00	0x79
+			MX6SL_PAD_LCD_DAT13__GPIO3_IO01	0x79
+			MX6SL_PAD_LCD_DAT14__GPIO3_IO02	0x79
+			MX6SL_PAD_LCD_DAT15__GPIO3_IO03	0x79
+			MX6SL_PAD_LCD_DAT16__GPIO3_IO04	0x79
+			MX6SL_PAD_LCD_DAT17__GPIO3_IO05	0x79
+			MX6SL_PAD_LCD_DAT18__GPIO3_IO06	0x79
+			MX6SL_PAD_LCD_DAT19__GPIO3_IO07	0x79
+			MX6SL_PAD_LCD_DAT20__GPIO3_IO08	0x79
+			MX6SL_PAD_LCD_DAT21__GPIO3_IO09	0x79
+			MX6SL_PAD_LCD_DAT22__GPIO3_IO10	0x79
+			MX6SL_PAD_LCD_DAT23__GPIO3_IO11	0x79
+			MX6SL_PAD_LCD_CLK__GPIO2_IO15		0x79
+			MX6SL_PAD_LCD_ENABLE__GPIO2_IO16	0x79
+			MX6SL_PAD_LCD_HSYNC__GPIO2_IO17	0x79
+			MX6SL_PAD_LCD_VSYNC__GPIO2_IO18	0x79
+			MX6SL_PAD_LCD_RESET__GPIO2_IO19	0x79
+			MX6SL_PAD_FEC_TX_CLK__GPIO4_IO21	0x79
+			MX6SL_PAD_FEC_REF_CLK__GPIO4_IO26	0x79
+			MX6SL_PAD_KEY_COL3__GPIO3_IO30		0x79
+			MX6SL_PAD_KEY_ROW7__GPIO4_IO07		0x79
+			MX6SL_PAD_ECSPI2_MOSI__GPIO4_IO13	0x79
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6SL_PAD_I2C1_SCL__I2C1_SCL	 0x4001f8b1
+			MX6SL_PAD_I2C1_SDA__I2C1_SDA	 0x4001f8b1
+		>;
+	};
+
+	pinctrl_i2c1_sleep: i2c1grp-sleep {
+		fsl,pins = <
+			MX6SL_PAD_I2C1_SCL__I2C1_SCL	 0x400108b1
+			MX6SL_PAD_I2C1_SDA__I2C1_SDA	 0x400108b1
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6SL_PAD_I2C2_SCL__I2C2_SCL	 0x4001f8b1
+			MX6SL_PAD_I2C2_SDA__I2C2_SDA	 0x4001f8b1
+		>;
+	};
+
+	pinctrl_i2c2_sleep: i2c2grp-sleep {
+		fsl,pins = <
+			MX6SL_PAD_I2C2_SCL__I2C2_SCL	 0x400108b1
+			MX6SL_PAD_I2C2_SDA__I2C2_SDA	 0x400108b1
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6SL_PAD_REF_CLK_24M__I2C3_SCL  0x4001f8b1
+			MX6SL_PAD_REF_CLK_32K__I2C3_SDA  0x4001f8b1
+		>;
+	};
+
+	pinctrl_led: ledgrp {
+		fsl,pins = <
+			MX6SL_PAD_FEC_RXD0__GPIO4_IO17	0x10059
+		>;
+	};
+
+	pinctrl_lm3630a_bl_gpio: lm3630a-bl-gpiogrp {
+		fsl,pins = <
+			MX6SL_PAD_EPDC_PWRCTRL3__GPIO2_IO10		0x10059 /* HWEN */
+		>;
+	};
+
+	pinctrl_ricoh_gpio: ricoh-gpiogrp {
+		fsl,pins = <
+			MX6SL_PAD_FEC_MDIO__GPIO4_IO20		0x1b8b1 /* ricoh619 chg */
+			MX6SL_PAD_FEC_RX_ER__GPIO4_IO19		0x1b8b1 /* ricoh619 irq */
+			MX6SL_PAD_KEY_COL2__GPIO3_IO28		0x1b8b1 /* ricoh619 bat_low_int */
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6SL_PAD_UART1_TXD__UART1_TX_DATA 0x1b0b1
+			MX6SL_PAD_UART1_RXD__UART1_RX_DATA 0x1b0b1
+		>;
+	};
+
+	pinctrl_usbotg1: usbotg1grp {
+		fsl,pins = <
+			MX6SL_PAD_EPDC_PWRCOM__USB_OTG1_ID 0x17059
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6SL_PAD_SD1_CMD__SD1_CMD	0x17059
+			MX6SL_PAD_SD1_CLK__SD1_CLK	0x17059
+			MX6SL_PAD_SD1_DAT0__SD1_DATA0	0x17059
+			MX6SL_PAD_SD1_DAT1__SD1_DATA1	0x17059
+			MX6SL_PAD_SD1_DAT2__SD1_DATA2	0x17059
+			MX6SL_PAD_SD1_DAT3__SD1_DATA3	0x17059
+			MX6SL_PAD_SD1_DAT4__SD1_DATA4	0x17059
+			MX6SL_PAD_SD1_DAT5__SD1_DATA5	0x17059
+			MX6SL_PAD_SD1_DAT6__SD1_DATA6	0x17059
+			MX6SL_PAD_SD1_DAT7__SD1_DATA7	0x17059
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD1_CMD__SD1_CMD	0x170b9
+			MX6SL_PAD_SD1_CLK__SD1_CLK	0x170b9
+			MX6SL_PAD_SD1_DAT0__SD1_DATA0	0x170b9
+			MX6SL_PAD_SD1_DAT1__SD1_DATA1	0x170b9
+			MX6SL_PAD_SD1_DAT2__SD1_DATA2	0x170b9
+			MX6SL_PAD_SD1_DAT3__SD1_DATA3	0x170b9
+			MX6SL_PAD_SD1_DAT4__SD1_DATA4	0x170b9
+			MX6SL_PAD_SD1_DAT5__SD1_DATA5	0x170b9
+			MX6SL_PAD_SD1_DAT6__SD1_DATA6	0x170b9
+			MX6SL_PAD_SD1_DAT7__SD1_DATA7	0x170b9
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD1_CMD__SD1_CMD	0x170f9
+			MX6SL_PAD_SD1_CLK__SD1_CLK	0x170f9
+			MX6SL_PAD_SD1_DAT0__SD1_DATA0	0x170f9
+			MX6SL_PAD_SD1_DAT1__SD1_DATA1	0x170f9
+			MX6SL_PAD_SD1_DAT2__SD1_DATA2	0x170f9
+			MX6SL_PAD_SD1_DAT3__SD1_DATA3	0x170f9
+			MX6SL_PAD_SD1_DAT4__SD1_DATA4	0x170b9
+			MX6SL_PAD_SD1_DAT5__SD1_DATA5	0x170b9
+			MX6SL_PAD_SD1_DAT6__SD1_DATA6	0x170b9
+			MX6SL_PAD_SD1_DAT7__SD1_DATA7	0x170b9
+		>;
+	};
+
+	pinctrl_usdhc1_sleep: usdhc1-sleepgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD1_CMD__SD1_CMD	0x10059
+			MX6SL_PAD_SD1_CLK__SD1_CLK	0x10059
+			MX6SL_PAD_SD1_DAT0__SD1_DATA0	0x10059
+			MX6SL_PAD_SD1_DAT1__SD1_DATA1	0x10059
+			MX6SL_PAD_SD1_DAT2__SD1_DATA2	0x10059
+			MX6SL_PAD_SD1_DAT3__SD1_DATA3	0x10059
+			MX6SL_PAD_SD1_DAT4__SD1_DATA4	0x10059
+			MX6SL_PAD_SD1_DAT5__SD1_DATA5	0x10059
+			MX6SL_PAD_SD1_DAT6__SD1_DATA6	0x10059
+			MX6SL_PAD_SD1_DAT7__SD1_DATA7	0x10059
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX6SL_PAD_SD3_CMD__SD3_CMD	0x11059
+			MX6SL_PAD_SD3_CLK__SD3_CLK	0x11059
+			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x11059
+			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x11059
+			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x11059
+			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x11059
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD3_CMD__SD3_CMD	0x170b9
+			MX6SL_PAD_SD3_CLK__SD3_CLK	0x170b9
+			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x170b9
+			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x170b9
+			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x170b9
+			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x170b9
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD3_CMD__SD3_CMD	0x170f9
+			MX6SL_PAD_SD3_CLK__SD3_CLK	0x170f9
+			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x170f9
+			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x170f9
+			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x170f9
+			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x170f9
+		>;
+	};
+
+	pinctrl_usdhc3_sleep: usdhc3-sleepgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD3_CMD__GPIO5_IO21	0x100c1
+			MX6SL_PAD_SD3_CLK__GPIO5_IO18	0x100c1
+			MX6SL_PAD_SD3_DAT0__GPIO5_IO19	0x100c1
+			MX6SL_PAD_SD3_DAT1__GPIO5_IO20	0x100c1
+			MX6SL_PAD_SD3_DAT2__GPIO5_IO16	0x100c1
+			MX6SL_PAD_SD3_DAT3__GPIO5_IO17	0x100c1
+		>;
+	};
+
+	pinctrl_wifi_power: wifi-powergrp {
+		fsl,pins = <
+			MX6SL_PAD_SD2_DAT6__GPIO4_IO29	0x10059	 /* WIFI_3V3_ON */
+		>;
+	};
+
+	pinctrl_wifi_reset: wifi-resetgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD2_DAT7__GPIO5_IO00	0x10059	/* WIFI_RST */
+		>;
+	};
+};
+
+&leds {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_led>;
+};
+
+&lm3630a {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lm3630a_bl_gpio>;
+};
+
+&reg_wifi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wifi_power>;
+};
+
+&reg_vdd1p1 {
+	vin-supply = <&dcdc2_reg>;
+};
+
+&reg_vdd2p5 {
+	vin-supply = <&dcdc2_reg>;
+};
+
+&reg_arm {
+	vin-supply = <&dcdc3_reg>;
+};
+
+&reg_soc {
+	vin-supply = <&dcdc1_reg>;
+};
+
+&reg_pu {
+	vin-supply = <&dcdc1_reg>;
+};
+
+&ricoh619 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ricoh_gpio>;
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz","sleep";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	pinctrl-3 = <&pinctrl_usdhc1_sleep>;
+};
+
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz","sleep";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	pinctrl-3 = <&pinctrl_usdhc3_sleep>;
+};
+
+&wifi_pwrseq {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wifi_reset>;
+};
-- 
2.30.2

