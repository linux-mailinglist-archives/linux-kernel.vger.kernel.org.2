Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1560D3E26E7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244358AbhHFJMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:12:21 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35441 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244213AbhHFJMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:12:10 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id BE3AA5C00DA;
        Fri,  6 Aug 2021 05:11:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 06 Aug 2021 05:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=UMe+3P4YUXxWD
        B9MuMuOzPb8/JlMM81hk5eWcH49tWQ=; b=ebKG/nVDfdmeyaIxSgoN+JJrgmfzt
        HbNHOfPYhjxTR1PHTOGV1w2HOXTX9lVf+/C/RwY2qr/CwOnJdoQoyRnJem0meDoc
        33/6Fa5OJ9OBnF6lJspp9uWCLaeEF6xVLK++AWlU/MOl8rwYyrsP+GweFLN5FFyu
        l6aKlN8G5W+4+B37deM4j/Kd1ywUaBpkBxJZYIW6Lp9MxZLNVII5n7+gW0/9a+lq
        2bnexSg0zhqeig/PiYYSFJpS/obLTzI989w6Ix24fdahOehO2PMmVzj5ZTeo4Qs3
        ILt4w5Sww5i72lZOsRbhjdEu7+IkhHFbeFqt5Yp4eHsAvId5Qdj33pPtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=UMe+3P4YUXxWDB9MuMuOzPb8/JlMM81hk5eWcH49tWQ=; b=ebxdyBt4
        RswBqJjrG0XBvwTAvBnIwheuQS2LSoaQnY9tC2TFC0AQ2dE8BKL1xtz5xwHBcHlU
        L7zU3S8MZbehCH5eycrCu3UgyYtgux5umAoi6sCSxCBuwY0ck82Dg9kc7r2hcmnd
        f0goQwz/xiVpElTW8gTFXjca0K0gpPhnGSsfEavHZ3ts14GLaWGzHtPRsrg1n2g5
        mJR3jmGRtrWvyUj7MGngIqkeC/gvgYvwprHuswL+gD++6M94xDUxu+RJX82S23Qn
        6BudDYlM1Hk9WN4I4ZMMeXK4V4aWxostP97pabcoj6c1O+redD+4SUS2hL+25der
        9Mvs98bEHpAJ7g==
X-ME-Sender: <xms:2vwMYdJp1CLVfKcNftb3o2iPY089WD0Cjd3Rbo9EAIfzUBb4a6MnxQ>
    <xme:2vwMYZLWEZ3wlbfqBhylAyi6DW7YjykMVl6p5wubTezTeNU__oVenisAGOFixNqyg
    J8jhREj-3V8L04OxyI>
X-ME-Received: <xmr:2vwMYVvgV0mjMRdDOxXbbEQ0T_JtRD0j8WT5mBXlJjepTukcawheU8WHYq05E3XeG55N0INT7j9oE-2La4JfzzOgueu51-hOcxswnVyY-WY1qA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:2vwMYea0wzCkJbky4HLm8PVKSytDWz5yeGe26CeoBB4l1TN-Zvpv1w>
    <xmx:2vwMYUZuJgx_3bkUHtsk4dF1ZeA78r9J32jcNGzj7HD97n_lG7qiZQ>
    <xmx:2vwMYSB03pCsFeEFGYq5ovFhCE9b9l6Ro2MqYKolpzrPFx9gHp3fyQ>
    <xmx:2vwMYU4pxvHXxBv-8q-Xf_gQrB6DDmuq5TgNm0P9G-oYBtR3r6lZVw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 05:11:51 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v9 10/12] ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a
Date:   Fri,  6 Aug 2021 19:10:56 +1000
Message-Id: <20210806091058.141-11-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210806091058.141-1-alistair@alistair23.me>
References: <20210806091058.141-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the silergy,sy7636a and silergy,sy7636a-regulator on the
reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 41 +++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index cc33b53ae6ba..2f0c4fda38a3 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -86,6 +86,33 @@ wacom_digitizer: digitizer@9 {
 	};
 };
 
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	epd_pmic: sy7636a@62 {
+		compatible = "silergy,sy7636a";
+		reg = <0x62>;
+		status = "okay";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_epdpmic>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#thermal-sensor-cells = <0>;
+
+		epd-pwr-good-gpios = <&gpio6 21 GPIO_ACTIVE_HIGH>;
+		regulators {
+			reg_epdpmic: vcom {
+				regulator-name = "vcom";
+				regulator-boot-on;
+			};
+		};
+	};
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -179,6 +206,13 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
 		>;
 	};
 
+	pinctrl_epdpmic: epdpmicgrp {
+		fsl,pins = <
+			MX7D_PAD_SAI2_RX_DATA__GPIO6_IO21 0x00000074
+			MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11 0x00000014
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
@@ -186,6 +220,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
 		>;
 	};
 
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX7D_PAD_I2C4_SDA__I2C4_SDA		0x4000007f
+			MX7D_PAD_I2C4_SCL__I2C4_SCL		0x4000007f
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
-- 
2.31.1

