Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119BD33CB69
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 03:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbhCPC2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 22:28:11 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:33563 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231643AbhCPC1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 22:27:48 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id B77A55809B4;
        Mon, 15 Mar 2021 22:27:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 15 Mar 2021 22:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=xihCkfjZnCzcr
        nqNSoSyOVKNoXb242z8lYAQzE/CBkI=; b=SitAAMFclN3QDyfRMmHVA08Wv+gXR
        fgWy9Tv8R0Ru1Berlq4bFHod1nS1LXo4C9o1dqDQZALLIai1qFeydi6YPlhoihXC
        I6i6QCQEjfS5B2D4tjPFXmfWJd+BT5hYclDPMNTk3z/N/39LiDIvt+xzoYZEk6Za
        IJrzAtoelBInJRtlApiM0zEggY8Noz7H8Fbx9ODcgGUBvZ37gzLFW4iPMcqtRvaS
        af1n5EJfAQTTFL95u0WqSKIUAHaOTEmeR3bFVJdBNDjLQYOAewwtqsmtc74msG68
        eMORoWPISZY8iuHYYiCQzSRiYP90tJqMuZQlPBVlPaG10YpmLxvHbtKpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=xihCkfjZnCzcrnqNSoSyOVKNoXb242z8lYAQzE/CBkI=; b=YSX1Lqy/
        RqvwkH6IX+w6j0Tp7Vt3EE/VikXmTAKl7LV6lnBb4/aCDcTMqWG/MHTxyogulglL
        Iz8h1jYL4slZ3YkJ14qCV08fay1Z6zrBiRBzFV7zWRWW/EUABFmnMB2U18AgvU1D
        5MmSMuIEdTFn3BUCU5IxZwydM8xbZRubGIIpHXUnRgB34OVHJw6LFeVfbULv6Bvx
        wdcnImrhye6bNSWTkKMZUnrahNrf6ViOfWwn2/VdXIQEy0JBw7sYFU83vjxo2Qk0
        lutZBuwpuMmkngkOYP8+EtFXeNTXXVi5eHf+YfSLUjDsZgRNJBFPTv88nxAME8xm
        iDq3Tf+u6WERvw==
X-ME-Sender: <xms:oxdQYPb6GBTB0kWfTkq5JysXjq2kGeuQP9TIOqRes28G0DNqiWC89w>
    <xme:oxdQYCrUCFD3Z1KC28g1kfp-xN7ToMIDWeYxO9T97ujuM7gyOv-GMkcRgE_dafaY4
    xeMJ7CracK4_CuoxCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefuddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehffejteette
    ekfffhvdeghfegvedvvdeujeehheefveefudefgeeitdehueejleenucffohhmrghinhep
    rhgvmhgrrhhkrggslhgvrdgtohhmnecukfhppeeiiedrudduhedrudekledrudejjeenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishht
    rghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:oxdQYM_-wsZu2dFzz2koGoWt5r75c-zk4nxjj_ANyi61fULa63-5Hw>
    <xmx:oxdQYJ-Bx0lpUTlEtCmOvvQoc8OHYAccDyMFbT7mmqCFdaJX_f3PcA>
    <xmx:oxdQYDuqjuG5wXX7UwXasTkH6qJ_LwfcFx-nuAFa-LTgLgnNqUiKxg>
    <xmx:oxdQYKGTTOWs2p65uU7qPPu6osMUam7MkwIlzmMdf1A_MKcrddOP2g>
Received: from ThinkpadX1Yoga3.localdomain (unknown [66.115.189.177])
        by mail.messagingengine.com (Postfix) with ESMTPA id B3548240072;
        Mon, 15 Mar 2021 22:27:46 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v5 3/3] ARM: imx7d-remarkable2.dts: Initial device tree for reMarkable2
Date:   Mon, 15 Mar 2021 22:27:40 -0400
Message-Id: <20210316022740.132-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210316022740.132-1-alistair@alistair23.me>
References: <20210316022740.132-1-alistair@alistair23.me>
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

Currently the kernel boots, but there is no support for the display.

WiFi is untested (no dispaly or UART RX makes it hard to test), but
should work with the current upstream driver. As it's untested it's not
included in this commit.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/Makefile              |   1 +
 arch/arm/boot/dts/imx7d-remarkable2.dts | 166 ++++++++++++++++++++++++
 2 files changed, 167 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7d-remarkable2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8e5d4ab4e75e..dc8e378689af 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -660,6 +660,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-pico-hobbit.dtb \
 	imx7d-pico-nymph.dtb \
 	imx7d-pico-pi.dtb \
+	imx7d-remarkable2.dtb \
 	imx7d-sbc-imx7.dtb \
 	imx7d-sdb.dtb \
 	imx7d-sdb-reva.dtb \
diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
new file mode 100644
index 000000000000..86d555bd33c2
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -0,0 +1,166 @@
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
+	compatible = "remarkable,imx7d-remarkable2", "fsl,imx7d";
+
+	chosen {
+		stdout-path = &uart6;
+	};
+
+	memory {
+		reg = <0x80000000 0x40000000>;
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
+&snvs_pwrkey {
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
+};
-- 
2.30.1

