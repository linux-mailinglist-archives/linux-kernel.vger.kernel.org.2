Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699B43333B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 04:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhCJC5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 21:57:03 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:40277 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232215AbhCJC4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 21:56:53 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id DAE1D58040E;
        Tue,  9 Mar 2021 21:56:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 09 Mar 2021 21:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=vthBqcjxoGRZVKdqjJdc8swtDM
        /rZi7LmBxD2JuDq40=; b=UF/w+rfVtNdV/dDIzWTA0ptdBFoCv3bWNNAl1BNCaz
        BNzzWb0w87xxd1c5BpGgrL0C4xVJdU7/T6rAsD0iW62h02i0mFslOE59k7BOFNpx
        tbn6W69cqBolOYwA7mnJ4BUqDHNQz54qxtjbWneHuAnJZIJWvxZlB4UVmL1qTpYB
        Cw99CLD14gWDF+m8eLCIzXx5ZCODiI2WI+HXpKTC4pArUqhu37M+oKX2ZEJ2MtSt
        wZe9I15Ow+hsmnUSJ2kWfAmuH1qztu0gy8rdqwIIqLyW4AXWByU82WQoREk9yQ/9
        AzonugxjDTKUGAUqIWdKnzzI/5VPVXX2OPRmapnjNiAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vthBqcjxoGRZVKdqj
        Jdc8swtDM/rZi7LmBxD2JuDq40=; b=AV9HqKj2kW02Se16l533BwgceRi1EaLJ8
        6TXN0iQ+vgb70NckdcH7r6B8L6xckG+qkXWVe6k6ybzIsITe9sb7V3Jtk7XYH/Iy
        AmBoR6jACaBNjogKDBHhWigY5Usao9iwLBEpMoPQxcnooMKPVUy/Am//CQGpJay+
        EUMsX+nnzAYVbJsVkZfOu/yMoNV3lxbPCN0vdKNEloF54EugcCuaKhQeSWXnqvpY
        yxjDWbeuftbDqbpNUEiQYwEDae38nuUGrdtN/dxLPFcF3xGrNxIKxehAZZshAjiP
        5c6H2ppOg3s+aIQMnBWl2enWR/yvm5XxlYDw2wsjGs5YFo0uDD+OQ==
X-ME-Sender: <xms:czVIYM1kkJ1p0ygK8hxJjUzLFBFV_yMGhgFYTp9jrKcpXiz4mqYzqA>
    <xme:czVIYHE1_cudcxJZWYD1nRJbVRahsjVexTLWq0XebhEDnvH4YlrjhXpGXv1IVaqCr
    ojBaWUFUY5mehExFeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddujedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeekudevfffffefffe
    evhfdujeeffeeiudfgledtgeeuhefhjeekvdduledtieehtdenucffohhmrghinheprhgv
    mhgrrhhkrggslhgvrdgtohhmnecukfhppeduleekrdehgedrudefgedrudduieenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:czVIYE6fX5KNJKJevl6u3eY_x2KqkiczWWFgyTTIsncKaGHDTyHe5w>
    <xmx:czVIYF1UogDkYT_qYyUshNOv4CvXex9ulIE7iRyatXn0lUHz8sAKIw>
    <xmx:czVIYPE96cQG1yXOQ6Pn_4615vCAuXw8j5VyGGSzqJ3WV8x1d60Pqg>
    <xmx:dDVIYGBGGaWvWBnN1DEREE1hbbUT3UE28cTqEwvYFLzQdGzmrmFbzQ>
Received: from ThinkpadX1Yoga3.localdomain (static-198-54-134-116.cust.tzulo.com [198.54.134.116])
        by mail.messagingengine.com (Postfix) with ESMTPA id BF2AF1080059;
        Tue,  9 Mar 2021 21:56:48 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4] ARM: imx7d-remarkable2.dts: Initial device tree for reMarkable2
Date:   Mon,  8 Mar 2021 03:22:27 -0500
Message-Id: <20210308082227.18663-1-alistair@alistair23.me>
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

Currently the kernel boots, but there is no support for the display.

WiFi is untested (no dispaly or UART RX makes it hard to test), but
should work with the current upstream driver. As it's untested it's not
included in this commit.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/imx7d-remarkable2.dts       | 166 ++++++++++++++++++
 4 files changed, 170 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7d-remarkable2.dts

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 297c87f45db8..d139440c86b6 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -617,6 +617,7 @@ properties:
               - kam,imx7d-flex-concentrator       # Kamstrup OMNIA Flex Concentrator
               - kam,imx7d-flex-concentrator-mfg   # Kamstrup OMNIA Flex Concentrator in manufacturing mode
               - novtech,imx7d-meerkat96   # i.MX7 Meerkat96 Board
+              - remarkable,imx7d-remarkable2  # i.MX7D ReMarkable 2 E-Ink Tablet
               - technexion,imx7d-pico-dwarf   # TechNexion i.MX7D Pico-Dwarf
               - technexion,imx7d-pico-hobbit  # TechNexion i.MX7D Pico-Hobbit
               - technexion,imx7d-pico-nymph   # TechNexion i.MX7D Pico-Nymph
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f6064d84a424..a8e1e8d2ef20 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -932,6 +932,8 @@ patternProperties:
     description: Unisoc Communications, Inc.
   "^realtek,.*":
     description: Realtek Semiconductor Corp.
+  "^remarkable,.*":
+    description: reMarkable AS
   "^renesas,.*":
     description: Renesas Electronics Corporation
   "^rex,.*":
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

