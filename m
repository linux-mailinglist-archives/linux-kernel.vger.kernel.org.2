Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB5A30EE35
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhBDIRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 03:17:00 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:38927 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233392AbhBDIQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:16:49 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2C79158025A;
        Thu,  4 Feb 2021 03:15:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 04 Feb 2021 03:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=qzFkF8RqM3JHD4/VMKwu5H+sHr
        +lPpHzfPQ4QsTHQ7Y=; b=PhMlKPgNcoMau4Y9xQkifnQZALCtViwFIBqxsnN3ch
        kI4a/r5Yb9Nb4WByOG9+vK9N7tchJ7ZmIwrwrG+0Ch9Ep29GOf9w5I5Nqj7NuH1Z
        zpSbLTfqFTlaxjpkm7vw+/AKXWjcmmjL37RH3jkV1i9IusOpMNJKQxcg+dBJhDxt
        /YEE/bFXZ2UfgDa4qPY+apAdm6x7XNLDrhZ3OGbseR2t/ahpqLryY7DccNyiNQrR
        3xEBagumtcgTUx/gkFEjsRhJDkfxnTUKMUVpc7/6HgrzD8hqvd6csz+bnkBBYMNx
        93GFILKiz27c++Uh5bthTAhIitfIBj49r9acJudC/fdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=qzFkF8RqM3JHD4/VM
        Kwu5H+sHr+lPpHzfPQ4QsTHQ7Y=; b=s33lVxvq5DDBz2zPaWv7fZWk5rVwxafez
        doFeb+DguB4ZroFTB/Gyteew6qbH4XqCFjWx8K6XvVzC4ACjsNLeHyDooi2AjXvk
        SAdMKkFGDbZ9pxI1dmreLGAT+4OZ9aWP6Qp635cpC0P5J9qVF1mB7B42UUrUnwjU
        WQsTmVvxeWZUEedOm402rEXtTh6sd5INUPdCbsbGkn8vTChsqZJ0owTdmjDRGx51
        fwoz9+6kRN6d3ZnKhbdk8HNtIaGXQggkVvRLvht1a4pU8kftC3nFVGJkPcO02Y9q
        91XQvMORbkCfGsW1ruIZPS0qAry+HCnEA3cFPyRm4xIqzdwn+BN1A==
X-ME-Sender: <xms:LK0bYDgx1V6DBV4HbefBo4X2bC1YWIm_zgQZGFrinh_cAtCmirDVQA>
    <xme:LK0bYABhlCJeUeFpAWiT4SFwQ3-ScP4ZENXBlPdpP_bw0jX0kq8nhM9l8fy9ooO8X
    bNFWgPMb3q6bGHjR4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgeefgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeekudevfffffefffe
    evhfdujeeffeeiudfgledtgeeuhefhjeekvdduledtieehtdenucffohhmrghinheprhgv
    mhgrrhhkrggslhgvrdgtohhmnecukfhppeejfedrleefrdekgedrvddtkeenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhes
    rghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:LK0bYDGls2utoysjIX3xsMpPSjbVwTD9rd7o9Zs3qisVEuRmhd4SeA>
    <xmx:LK0bYATI9k2749yphmORyTtJQXSLGmBVy18RN3s0vn3MqYARhaiOAA>
    <xmx:LK0bYAyGugGI1JYZyFPyW64na2hBmo-TltrDPfVgmODziy4lJ_QgIA>
    <xmx:Lq0bYMfxHfj-gvfaAniiO5iBwsNMVz5-GmvO6DNfap_mbMmFJUAA0g>
Received: from ThinkpadX1Yoga3.localdomain (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 331831080059;
        Thu,  4 Feb 2021 03:15:39 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 1/3] ARM: imx7d-remarkable2.dts: Initial device tree for reMarkable2
Date:   Wed,  3 Feb 2021 19:03:14 -0800
Message-Id: <20210204030316.489-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reMarkable2 (https://remarkable.com) is an e-ink tablet based on
the imx7d SoC.

This commit is based on the DTS provide by reMarkable but ported to the
latest kernel (instead of 4.14). I have removed references to
non-upstream devices and have changed the UART so that the console can
be accessed without having to open up the device via the OTG pogo pins.

Currently the kernel boots, but there is no support for the dispaly,
WiFi or the power controller chips.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/Makefile              |   1 +
 arch/arm/boot/dts/imx7d-remarkable2.dts | 253 ++++++++++++++++++++++++
 2 files changed, 254 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7d-remarkable2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3d1ea0b25168..9608c363b25f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -658,6 +658,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-pico-hobbit.dtb \
 	imx7d-pico-nymph.dtb \
 	imx7d-pico-pi.dtb \
+	imx7d-remarkable2.dtb \
 	imx7d-sbc-imx7.dtb \
 	imx7d-sdb.dtb \
 	imx7d-sdb-reva.dtb \
diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
new file mode 100644
index 000000000000..0aae13f5eed6
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ * Copyright (C) 2019 reMarkable AS - http://www.remarkable.com/
+ *
+ */
+
+/dts-v1/;
+
+#include "imx7d.dtsi"
+
+/ {
+	model = "reMarkable 2.0";
+	compatible = "fsl,imx7d-remarkable2", "fsl,imx7d";
+
+	chosen {
+		stdout-path = &uart6;
+	};
+
+	memory {
+		reg = <0x80000000 0x40000000>;
+	};
+
+	reg_brcm: regulator-brcm {
+		compatible = "regulator-fixed";
+		regulator-name = "brcm_reg";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_brcm_reg>;
+		gpio = <&gpio6 13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		startup-delay-us = <150>;
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wifi>;
+		reset-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
+		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
+		clock-names = "ext_clock";
+	};
+};
+
+&clks {
+	assigned-clocks = <&clks IMX7D_CLKO2_ROOT_SRC>,
+			  <&clks IMX7D_CLKO2_ROOT_DIV>;
+	assigned-clock-parents = <&clks IMX7D_CKIL>;
+	assigned-clock-rates = <0>, <32768>;
+};
+
+&crypto {
+	status = "disabled";
+};
+
+&dma_apbh {
+	status = "disabled";
+};
+
+&sdma {
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	assigned-clocks = <&clks IMX7D_UART1_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
+	status = "okay";
+};
+
+&uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart6>;
+	assigned-clocks = <&clks IMX7D_UART6_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
+	status = "okay";
+};
+
+&usbotg2 {
+	srp-disable;
+	hnp-disable;
+	status = "okay";
+};
+
+&usdhc2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default", "state_100mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	vmmc-supply = <&reg_brcm>;
+	bus-width = <4>;
+	non-removable;
+	keep-power-in-suspend;
+	cap-power-off-card;
+	status = "okay";
+
+	brcmf: bcrmf@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	pinctrl-3 = <&pinctrl_usdhc3>;
+	assigned-clocks = <&clks IMX7D_USDHC3_ROOT_CLK>;
+	assigned-clock-rates = <400000000>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
+&iomuxc_lpsr {
+	pinctrl_digitizer_reg: digitizerreggrp {
+		fsl,pins = <
+			/* DIGITIZER_PWR_EN */
+			MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6	0x14
+		>;
+	};
+};
+
+&iomuxc {
+	pinctrl_brcm_reg: brcmreggrp {
+		fsl,pins = <
+			/* WIFI_PWR_EN */
+			MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
+			MX7D_PAD_UART1_RX_DATA__UART1_DCE_RX	0x79
+		>;
+	};
+
+	pinctrl_uart6: uart6grp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA09__UART6_DCE_TX		0x79
+			MX7D_PAD_EPDC_DATA08__UART6_DCE_RX		0x79
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX7D_PAD_SD2_CMD__SD2_CMD		0x59
+			MX7D_PAD_SD2_CLK__SD2_CLK		0x19
+			MX7D_PAD_SD2_DATA0__SD2_DATA0		0x59
+			MX7D_PAD_SD2_DATA1__SD2_DATA1		0x59
+			MX7D_PAD_SD2_DATA2__SD2_DATA2		0x59
+			MX7D_PAD_SD2_DATA3__SD2_DATA3		0x59
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2grp_100mhz {
+		fsl,pins = <
+			MX7D_PAD_SD2_CMD__SD2_CMD		0x5a
+			MX7D_PAD_SD2_CLK__SD2_CLK		0x1a
+			MX7D_PAD_SD2_DATA0__SD2_DATA0		0x5a
+			MX7D_PAD_SD2_DATA1__SD2_DATA1		0x5a
+			MX7D_PAD_SD2_DATA2__SD2_DATA2		0x5a
+			MX7D_PAD_SD2_DATA3__SD2_DATA3		0x5a
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2grp_200mhz {
+		fsl,pins = <
+			MX7D_PAD_SD2_CMD__SD2_CMD		0x5b
+			MX7D_PAD_SD2_CLK__SD2_CLK		0x1b
+			MX7D_PAD_SD2_DATA0__SD2_DATA0		0x5b
+			MX7D_PAD_SD2_DATA1__SD2_DATA1		0x5b
+			MX7D_PAD_SD2_DATA2__SD2_DATA2		0x5b
+			MX7D_PAD_SD2_DATA3__SD2_DATA3		0x5b
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
+			MX7D_PAD_SD3_CLK__SD3_CLK		0x19
+			MX7D_PAD_SD3_DATA0__SD3_DATA0		0x59
+			MX7D_PAD_SD3_DATA1__SD3_DATA1		0x59
+			MX7D_PAD_SD3_DATA2__SD3_DATA2		0x59
+			MX7D_PAD_SD3_DATA3__SD3_DATA3		0x59
+			MX7D_PAD_SD3_DATA4__SD3_DATA4		0x59
+			MX7D_PAD_SD3_DATA5__SD3_DATA5		0x59
+			MX7D_PAD_SD3_DATA6__SD3_DATA6		0x59
+			MX7D_PAD_SD3_DATA7__SD3_DATA7		0x59
+			MX7D_PAD_SD3_STROBE__SD3_STROBE		0x19
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
+		fsl,pins = <
+			MX7D_PAD_SD3_CMD__SD3_CMD		0x5a
+			MX7D_PAD_SD3_CLK__SD3_CLK		0x1a
+			MX7D_PAD_SD3_DATA0__SD3_DATA0		0x5a
+			MX7D_PAD_SD3_DATA1__SD3_DATA1		0x5a
+			MX7D_PAD_SD3_DATA2__SD3_DATA2		0x5a
+			MX7D_PAD_SD3_DATA3__SD3_DATA3		0x5a
+			MX7D_PAD_SD3_DATA4__SD3_DATA4		0x5a
+			MX7D_PAD_SD3_DATA5__SD3_DATA5		0x5a
+			MX7D_PAD_SD3_DATA6__SD3_DATA6		0x5a
+			MX7D_PAD_SD3_DATA7__SD3_DATA7		0x5a
+			MX7D_PAD_SD3_STROBE__SD3_STROBE		0x1a
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3grp_200mhz {
+		fsl,pins = <
+			MX7D_PAD_SD3_CMD__SD3_CMD		0x5b
+			MX7D_PAD_SD3_CLK__SD3_CLK		0x1b
+			MX7D_PAD_SD3_DATA0__SD3_DATA0		0x5b
+			MX7D_PAD_SD3_DATA1__SD3_DATA1		0x5b
+			MX7D_PAD_SD3_DATA2__SD3_DATA2		0x5b
+			MX7D_PAD_SD3_DATA3__SD3_DATA3		0x5b
+			MX7D_PAD_SD3_DATA4__SD3_DATA4		0x5b
+			MX7D_PAD_SD3_DATA5__SD3_DATA5		0x5b
+			MX7D_PAD_SD3_DATA6__SD3_DATA6		0x5b
+			MX7D_PAD_SD3_DATA7__SD3_DATA7		0x5b
+			MX7D_PAD_SD3_STROBE__SD3_STROBE		0x1b
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX7D_PAD_ENET1_COL__WDOG1_WDOG_ANY	0x74
+		>;
+	};
+
+	pinctrl_wifi: wifigrp {
+		fsl,pins = <
+			/* WiFi Reg On */
+			MX7D_PAD_SD2_CD_B__GPIO5_IO9		0x00000014
+			/* WiFi Sleep 32k */
+			MX7D_PAD_SD1_WP__CCM_CLKO2		0x00000014
+		>;
+	};
+};
-- 
2.30.0

