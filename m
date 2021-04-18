Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2D6363DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbhDSIjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:39:01 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:42153 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229635AbhDSIiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:38:51 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5418758101D;
        Mon, 19 Apr 2021 04:38:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 04:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=XtEsg6GbOXHnlwHfF287laoPnJ
        lDIMFR5KZrjKvVuqM=; b=X5eQnA4EJ3vRS4zahtf1VvJO9ovSPaxTSTCseA4Mhu
        ba0dYXrBDbU7sOeoqU/s69Z4CRV9QEbLkkhWrASiZ3AAil+/nV+tjsksvHC0v1ow
        wcKDvGCyvOtj5hboSA/13ZpOzUXoX0O+hB67QCUgmAs6t1kk9RMV3TTTv+Dt4xHE
        xjMfF8KeNTPjBwCHszNqtPTc3Z/xAOsMoS0wGlE6HAK8h0d9+so053FJAePaRLsr
        MglmKcftmlCDeyXCbMvaQDxh/THRhQYDYB1TLn5tHp5bBf6u5YSOVCB3ZqunIuSA
        MpWfoxIUeS8sBPuU4qtc9MKCWfyDgvYn2FsHjs0bYTXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=XtEsg6GbOXHnlwHfF
        287laoPnJlDIMFR5KZrjKvVuqM=; b=JcHieZtd1sOWMnUtvkhp8h1i+xL3hu5+4
        suuz3+V/9LMdsh9+v63UjCoazfkF4mO/wtIFwKkhxbU+PE8N+HIWArr55p9hASMd
        Eup72sD0LIwF/8O9qw3BbVTlfC2JqLdhr2tXI7u9MwSlNDcBDYnqiaG4U9Yu6Alz
        oluLYJ9jnzhnRC8QK6JTr8bJJzFArmJ5ERaKjSYbn6haQQxQRJ+pcIfIPReV/meL
        CH6Y+NSY8KjF0COJJ8RPjo4rVmxAJb2XmKvPHjVoFW0bjRpZwqkSLbJjEsa25w2s
        GmIneLtD0pzBibnOSR4FnyRKZg4CACIA7MaZVvruaSp7fIrzcTo1w==
X-ME-Sender: <xms:e0F9YNC5OP3dIB3VNedlnuTJqKS_pqXDILbxGDldkAMRhFPSYx1Zmw>
    <xme:e0F9YLgZzrvqRrHFhlvWFXZZqYpDj19Ty9iV2NzgCEj_jPPRUUet4R9tNODPogWRV
    AJwd6-_mU9Me7hT9jc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeejleeihfdvtefgtd
    ethfdtgefftdeiffefjeeiffefveeuleejheejvefhffeukeenucfkphepkeelrdeggedr
    uddtrdduvdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:e0F9YImb3F6z9ttc5SWuKtw1mMv2EEOiC0B_TJ4MCJP-wpB0uv43_g>
    <xmx:e0F9YHy72gxFWbvu3DtFzYklrLIpPTRTvfU5F-PCH8heXarD0TmxQQ>
    <xmx:e0F9YCQAJ5jjG7tnAOChn5ESj-gD9GQw6dQoNOLntu_OgRp-sdTu5Q>
    <xmx:fUF9YPSBUeXMJYa9bJdBZRSRHFGR9aCsa6nQq7wZ_npTiPtJLExZCQ>
Received: from ThinkpadX1Yoga3.localdomain (unknown [89.44.10.123])
        by mail.messagingengine.com (Postfix) with ESMTPA id 447CE108005C;
        Mon, 19 Apr 2021 04:38:15 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.co
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH] ARM: imx7d-remarkable2.dts: Add WiFi support
Date:   Mon, 19 Apr 2021 07:00:03 +1000
Message-Id: <20210418210003.2806-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 91 +++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 8cbae656395c..c3dda2b92fe6 100644
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

