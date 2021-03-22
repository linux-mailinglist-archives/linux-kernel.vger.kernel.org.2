Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BA234455F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhCVNRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:17:21 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:34849 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232659AbhCVNJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:09:42 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 141F9580E6A;
        Mon, 22 Mar 2021 09:09:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 22 Mar 2021 09:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=ii13w0W+n5l/U
        F2EYZK44Qh2yACLwbEEu3Npe+ipnoU=; b=Mho9mLQtG0du5noximxYnAQ4bV/DH
        aG8IuiNt3y4ceL8zzAKPHBD1tY7IfE85XtnQzDZ6gd5+1W/G8Gft0Y3/fPgGiLlw
        MZM7r3uqVyWqEPapQ0zSJF/SnlAocDkAC+sgt/TuGNKPjLS+h3H/88aUGTzyrUOC
        /UzBAVhiwCMAHJoOMFSzesMi38OqMMDeSVU4OU10ELgWSSkFtjSrSYlGVF2PxkXQ
        yHOLDeJnK3VAZr4Uj0U+GB+nJREMfklsWS70zRdHLzoilOVTxjcqeGiWBySOpPmE
        if9Tuj5WhMrydti2/1RpODKzqMXlmQj2WW85Fz7CXnUN0dHbD1chXxlIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ii13w0W+n5l/UF2EYZK44Qh2yACLwbEEu3Npe+ipnoU=; b=HcsAIN0b
        tKg5Y1wORrIg45C+UFdilwCr+K3WU2RwOl4M7+yswupVUZNjjuy4pXdngo2PHRa4
        ztoi0MDB2GdvrmcjLtYbC8yc+jjMtBot3WYT4p+MQjcsuBHc620YhWEPuHiBORm/
        FRX1XuF3PKkCTPxOcIt2vb4MmPr+NraB01HbET6z8uaT1WY2HmXZIMFPdNnfUEpU
        UXiiqzEd0gbTfbPZUIkfxciFeyQearONI4Ykp8H9HXgu0n/e9nfWlt3ZA5/Wde9+
        L3aAjE7AT22ET3Umq5fAkogi6m3XO9EJWXryPwrVvz4iegUYvOuY+4a4kk5Ip3M+
        P4y7cNoZ5WR23A==
X-ME-Sender: <xms:D5dYYGJWxdjyA_lHFZgizX211LoCBm3cFTJGp9lgjHGw5CGqHTYG3Q>
    <xme:D5dYYO1BqcRqT_Hhxosfqcp2C_ReRLc7NB5QnDFzcjl06cJP-ysFnUj3c0RD88-94
    eFIYYo3uFaSG233ml8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeggedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehffejteette
    ekfffhvdeghfegvedvvdeujeehheefveefudefgeeitdehueejleenucffohhmrghinhep
    rhgvmhgrrhhkrggslhgvrdgtohhmnecukfhppeduleefrddvjedrudefrddvfeehnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:D5dYYE7UfGFZjTMv562sn1aD6LUjQyz7wj_sdwlfwImrDkULkYEPeA>
    <xmx:D5dYYP_YGVfr9AnoPsxY3O_uHGbgAa_BGFeljC3QUpy3oT-EyjIOUg>
    <xmx:D5dYYDXa5O-gkb_xtaFjhPmDQJHICcKzJqJg7P-0zCDcskcI6IbZew>
    <xmx:EJdYYJVkSMWyQuBeyc9qAFFJMkjZo5Ue76rZUThFvuoyvKwzzzG1ZA>
Received: from ThinkpadX1Yoga3.localdomain (unknown [193.27.13.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3F3F2108006A;
        Mon, 22 Mar 2021 09:09:34 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v6 3/3] ARM: imx7d-remarkable2.dts: Initial device tree for reMarkable2
Date:   Mon, 22 Mar 2021 09:09:27 -0400
Message-Id: <20210322130928.132-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210322130928.132-1-alistair@alistair23.me>
References: <20210322130928.132-1-alistair@alistair23.me>
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

WiFi is untested (no display or UART RX makes it hard to test), but
should work with the current upstream driver. As it's untested it's not
included in this commit.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
v6:
 - Remove unneeded disables (crypt and dma_apbh)
 - Remove uneeded enables (sdma)
 - Fixup memory entry
 - Remove unused reference

 arch/arm/boot/dts/Makefile              |   1 +
 arch/arm/boot/dts/imx7d-remarkable2.dts | 146 ++++++++++++++++++++++++
 2 files changed, 147 insertions(+)
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
index 000000000000..8cbae656395c
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -0,0 +1,146 @@
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
+	memory@80000000 {
+		device_type = "memory";
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

