Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8ED3DE8BB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhHCIqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:46:38 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52575 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234784AbhHCIqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:46:35 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5DA585C00F0;
        Tue,  3 Aug 2021 04:46:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 03 Aug 2021 04:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=r7v2sGI6eutla
        1HtTgIVdJ8GS0/nq7Ix9Yt0KrGBTXQ=; b=EItefy0mlag0sZz/FtcCeJ7CFt0FP
        1Qk8mFWlI6TARuiDq83k4SfChT6vAaL1doQ9M1tStIG/ZfBwzJF4NIz/n8cP2gja
        kkp6kLhGHJt71AnN4zxDcBZhtZ2hg0CW498mSQizkvgHFkxNAUIrV8T9PPGsQ0L3
        XJL6F1jKiFaeqRK3cfNfT7qW71pKFjmUIBG6HQAwAiIy+bV83ZQ7Q8cyHInDJQZK
        65mqzbrOU4to90PP07psA0RZcwI4rZIFpDMfixvecaaRbzCyz5CSs+IlluI7PheH
        bI/nmJ51XgBOiN2wG0bJHLtnPGIWoIA470iQ1EogQf9OFpD12OEBu7R4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=r7v2sGI6eutla1HtTgIVdJ8GS0/nq7Ix9Yt0KrGBTXQ=; b=lwmfW5Dv
        VMijldL+igRDU7D6eHbKFxAlK79RCrNG+24p7erklWsW/ojjcuob6y9aNCijOMZr
        Cvye9xWleLFsXQMIDioCK+FYgvzvUFNwCi70jkpE1xeajW1QGALrckYCPsOY/8eS
        9pFqL+2mCOV053RpGjMepffLVcjJ8Dh8Rw23EsA0e/K6Opkmnc3434D9Kjz6ZYCQ
        R2JM50gQ0rL3ZRpmrQgGhF2EF/Gf7+F53nEps9l7wiBY+vBT3tMHGqI7PnPGRkX6
        J1L+zrUgd3gioekeg2GdAeGNRFD46YlKILhBBdyPcKeMottOBV9osofY5i/ABGJM
        5jNZv/NdPDMavg==
X-ME-Sender: <xms:YAIJYcw4g5a9f4YnRxRTKmg_J_MZRdD_0TNYP0plqrath24i-kKXuw>
    <xme:YAIJYQST7IZ2O5UM-lgLTajfSPOCzCXqfSmPU6MhIlthlp-0ZqMwuhW861RZTbw5X
    qswThfU2cKsfNOpDhE>
X-ME-Received: <xmr:YAIJYeWI4PWUwLOhg-RX3aKvXz676kM7FYw5pg39X6VKnjurKMix4JSzr6YDsaQYCi9FJGFelifhXKYd75bmCROjkqzr0u5pbaMlK4gSokSr6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:YAIJYahzl3l_FUDplQIzMoEX-g1QwCYzndbxHARn6BUR4nE2KfKGqA>
    <xmx:YAIJYeDyiGIYs-eO8RTYd0M11fSpktCqZXUwuEmoobtiQuA_FclmvQ>
    <xmx:YAIJYbJF66Uq7qAJJQZaIS5PEVc6iUrumOfbbPrfxbII-_DPnhfF-w>
    <xmx:YAIJYUDmcCu5i0jr2FBO4JOX7BNms44GKn90A6fC0yBa8-Ec3eny6A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Aug 2021 04:46:20 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v8 09/11] ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a
Date:   Tue,  3 Aug 2021 18:44:56 +1000
Message-Id: <20210803084456.198-9-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803084456.198-1-alistair@alistair23.me>
References: <20210803084456.198-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the silergy,sy7636a and silergy,sy7636a-regulator on the
reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 42 +++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index cc33b53ae6ba..9bdae1c1236e 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -86,6 +86,34 @@ wacom_digitizer: digitizer@9 {
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
+			compatible = "silergy,sy7636a-regulator";
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
@@ -179,6 +207,13 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
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
@@ -186,6 +221,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
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

