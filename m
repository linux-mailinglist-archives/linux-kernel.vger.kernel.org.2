Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431253BD459
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241226AbhGFMIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:08:15 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:47301 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234923AbhGFLnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 07:43:37 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id AC18A58072D;
        Tue,  6 Jul 2021 07:40:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 06 Jul 2021 07:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=x//GlUaN3R+rfIHXOoIZVp3V3k
        muONtJayusdAtObv0=; b=PTFgjsiQ0B+4TNTcSIghSCAqXFJTDDMwCQgwrjUPuZ
        KZvhrAjI825efna+CKasePyPHCTHygxvAtJpe6hTYDL4MAqSAsal5CscEsbCQJ3a
        LcXvujRAzRjKiGxTWlOrXcxSEboT/cgRlOlMDfTDEJ23BdoRkuXKvOT7qPNwu2Ml
        4phms8swGv05Y0qsZgTfYcBMV4fu4p84L6aGtpLjYkcyq7qCDzffn7LMrYs2iHcn
        vEgOtJEnxhFrxy9EavVeGuYFVLxHQLZe8WjLvGM+HMgM2JtsxOuk3RHpe1Vupp0m
        +T/CeF6Zo/ySNTlOMfbqk3EYcJwthxQqZf+fVWx0J9/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=x//GlUaN3R+rfIHXO
        oIZVp3V3kmuONtJayusdAtObv0=; b=jmF+gkY7sAFfJwoNV8Dki71v/RRwWKi8s
        wGcjqfMjae23S8GI6D7iKASlUsC7OPW9VYQ3/x8oLN4nm4CFs7MkKYNBVUbHVBEX
        rD610jbvt5vNlAQhQtuShBokC/nn2sgWfa1BLUxZbLA8BDihASvzAV2sfvlgwlPy
        d//Dro0CoQADIJ/E74DVrliRnGECLdFhuZICLbbyeOe1kw1eI/DBsLT3XdVGy/H+
        q9B0n2fdIXzmE6TNQdl9l6c7arddCetouHMkrc85LunVWSSsVEO4iLPUAk1ww0FB
        CQFRvDpyfK/R2tvOdQYX5YqFy991q3PgCWgnZ3nUCj+2f9g0JaO3w==
X-ME-Sender: <xms:SEHkYLbhhhq2HDIYVp8VNfXIlbGWwIv8sl0j4j4ZxrrEaXCbbrCUCg>
    <xme:SEHkYKa69amuNCYcWXTU07c0d3vWhiQUaEyGTrpRCLpAcxbVp2ac2wMjb7SI0QD-E
    p0_PPnk9YurZjv6MrM>
X-ME-Received: <xmr:SEHkYN_0uR8J8r9XPQ-12C_hjoNTfQEil4WAZD2eYuRkjm4jUOEmptTpBsFFt9gGKW_79BUDMqoG0ToqAu4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtddtgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhes
    rghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepjeeliefhvdetgfdtte
    fhtdegffdtiefffeejiefffeevueeljeehjeevhfffueeknecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrg
    hirhdvfedrmhgv
X-ME-Proxy: <xmx:SEHkYBoJpfilwPIvmkLIrHc1iPpBxkMI6rQhNGs97X0W5dC6__w4AQ>
    <xmx:SEHkYGoArlB3esIv32WFFiIIBaKxsG8wB2way59ZLquRm6OgPmdBxg>
    <xmx:SEHkYHQFFH3zJWhCftSdCweC_7mhvjZj8hyW32VvJKfxnt2cNlXR9g>
    <xmx:SEHkYCfT205pt3yTaEnI1WDTlsTqFGN1wLZYssFn5zKSElaYNB-6Qw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jul 2021 07:40:48 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3] ARM: dts: imx7d-remarkable2: Add WiFi support
Date:   Tue,  6 Jul 2021 21:40:28 +1000
Message-Id: <20210706114028.132-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the bcm4329-fmac WiFi in the reMarkable 2, connected via SDHC.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
V3:
 - Remove the duplicate pinctrl-2

 arch/arm/boot/dts/imx7d-remarkable2.dts | 91 +++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 8cbae656395c..89cbf13097a4 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -21,6 +21,27 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>;
 	};
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
 };
 
 &clks {
@@ -56,6 +77,27 @@ &usbotg2 {
 	status = "okay";
 };
 
+&usdhc2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
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
 &usdhc3 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc3>;
@@ -76,6 +118,13 @@ &wdog1 {
 };
 
 &iomuxc {
+	pinctrl_brcm_reg: brcmreggrp {
+		fsl,pins = <
+			/* WIFI_PWR_EN */
+			MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
@@ -90,6 +139,39 @@ MX7D_PAD_EPDC_DATA08__UART6_DCE_RX		0x79
 		>;
 	};
 
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
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
@@ -143,4 +225,13 @@ pinctrl_wdog: wdoggrp {
 			MX7D_PAD_ENET1_COL__WDOG1_WDOG_ANY	0x74
 		>;
 	};
+
+	pinctrl_wifi: wifigrp {
+		fsl,pins = <
+			/* WiFi Reg On */
+			MX7D_PAD_SD2_CD_B__GPIO5_IO9		0x00000014
+			/* WiFi Sleep 32k */
+			MX7D_PAD_SD1_WP__CCM_CLKO2		0x00000014
+		>;
+	};
 };
-- 
2.31.1

