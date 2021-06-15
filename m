Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008E63A7BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhFOKb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:31:56 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:37691 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231265AbhFOKbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:31:55 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0B00058087B;
        Tue, 15 Jun 2021 06:29:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 15 Jun 2021 06:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=G1RFhaM6SsXFeINjKzhl9UU+qx
        EODyv4CLldEnb/exY=; b=QEfXYOLU7P/FRlpSTzY6HB3+c2YfV6VNEK/877V+aA
        hob3rgWAS3LRD2IqKqBxrZlurx+AaetjUibIdlod8iXQ8wKopXQtjFx+43RMSRco
        ep1q3nGo39o5OXnDt8MhEkJiFsRgIyqw60EqgCv2fmCv8JfmkFlRbdlq+6rdjP1D
        krXfV0GptN7/bOrAhBmZ1PQ4xQ5OhO2jdKYtUIMdjsQnCISFtITieuoCix88Gduv
        u4SG678wpYySM1bDN9qu7Lid2XBZqiQne84mDgoFe9Snfl8WYwXr9Z66f/BEFq6Q
        aPK5SgUy+TSodvDC+FrHbBfs31E1kuXCn2Cm+c3cPm7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=G1RFhaM6SsXFeINjK
        zhl9UU+qxEODyv4CLldEnb/exY=; b=SdB4dw31H5i30bnaX72gBB6vvB9R/sjb4
        VR9YvX9qYHeOP92RfN9b+nSIRT3rT4p4Vne9DG4TMVr5MVLCgAw0VIwyfiZendnD
        CbdYjpCylLnn4QjcuP6WSK35BFtoUCAeOCVqX8Dmlj+/BbwJWOfwRIlUtHWKZ2cA
        +Zj5WscilDlJgXR3RR1IzhlvHlD5YKFj+aoFzd86yXdmPrWnN9XYKaWIat5ombsP
        dVMWX3eNoomIApOZKQH0oAunLHeaoWHN3Y3mXy1KzJIr8sY2/xbJ34HkSY7cRnm5
        f0YFtw4WVSEkjfNkrT4a2mw5+C5GfygPoqwKSJ71nAQRIYaEVIWIA==
X-ME-Sender: <xms:HoHIYERuQB4kxjkrSMsVpV05d4SFtZqk8aLSZUUpwAAa4NqwG3Amfg>
    <xme:HoHIYBwnJqsR71NtuLjMhElv_M-yRDoMmID1hEzrLXvd6hC0I1fHohQODfDjsI5D2
    84Ai13DZmkxI-upL2g>
X-ME-Received: <xmr:HoHIYB0nknOEU7HhVibolWmUrajrqaHbZeeArq8aKUR73rVGpOThfvKx1qD4jPVnnK_WybnYn6_NUFAD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvjedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeejleeihfdvtefgtd
    ethfdtgefftdeiffefjeeiffefveeuleejheejvefhffeukeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsth
    grihhrvdefrdhmvg
X-ME-Proxy: <xmx:HoHIYIAh_v2hodlq57X4El8kzyCSXNTG64xLiwu1ayR9q-10HKFfhA>
    <xmx:HoHIYNgHkZW_WfZhFZ7WFldZUdbWuK4nc4iFYmWhcRbIc7mvRXdrQQ>
    <xmx:HoHIYEoD0wd5fcIMSvu1L1zODjmXjJte6du5nLYOxP4m8HSgxjtwKQ>
    <xmx:H4HIYOUQPU1X2U0aT4PND0fdPgoXq8HlAk3ai_1RA14TVg5kPFBOzg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jun 2021 06:29:46 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v2] ARM: dts: imx7d-remarkable2: Add WiFi support
Date:   Tue, 15 Jun 2021 20:29:35 +1000
Message-Id: <20210615102935.738-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the bcm4329-fmac WiFi in the reMarkable 2, connected via SDHC.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 92 +++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 8cbae656395c..7eebcd7f23bb 100644
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
@@ -56,6 +77,28 @@ &usbotg2 {
 	status = "okay";
 };
 
+&usdhc2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
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
 &usdhc3 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc3>;
@@ -76,6 +119,13 @@ &wdog1 {
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
@@ -90,6 +140,39 @@ MX7D_PAD_EPDC_DATA08__UART6_DCE_RX		0x79
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
@@ -143,4 +226,13 @@ pinctrl_wdog: wdoggrp {
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

