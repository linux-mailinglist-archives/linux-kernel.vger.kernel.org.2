Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1963F17DB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbhHSLRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:17:11 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45139 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238785AbhHSLQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:16:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 61DBE5C0076;
        Thu, 19 Aug 2021 07:16:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 19 Aug 2021 07:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=OcxDmT6yzDNfT
        /cRSP0vqtlrxPSFTAH5XRTlf5MSQVA=; b=atg/5DJBzmwu2uLkh2rq/TUMU5Wu/
        zpTxAizVp/bGxVIBb/QajNB27bOsN3865z6tuVBgsWxy2fH4p3Istv6/thBNZUdD
        +x4TEbqn8i8C1Wi3qh0MN2MYqtjkNUkZQn1VZLdxiIh/QlTbwVnAUIYr9jazxPe6
        50Oovyc1pjIBFkG01e2qQhykHLm6O2B4DaQM4TZtgcJChmFxyGzFRbmaCjf928md
        WP0pL6HPzdotCbB/FCp/NIxg6bi6PXcvQtlqVjFEr/E1TTtRMUckbHCVR+FzPTMV
        wAxFn0NpUwWjIflJOss3ESt0n63TTfNlKRoRciKx9O3apQv2etrpUoQYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=OcxDmT6yzDNfT/cRSP0vqtlrxPSFTAH5XRTlf5MSQVA=; b=SwwheKrU
        JVaR9Xo6ZVZ1rcZIbeoJsRVtOtS74pvbuH3xtcV2TiKjtu57/U/p9MCHA1fbiV12
        a/4pJNUjGCFRSzagu7+3Xg+6H5RETuZF4hZ0eMPqrzJKKIIbQwAVYBXz5dYE9zWI
        B8wuFKbhxEpAllljG/KzplPVPw+E2xPjKNtPXKMXgr6q5awJDac55SvwnZYMeToD
        T5LTe54xnel0FaGfHFDeFUSsO9so1+rY8e9hjBQUlwWJecsJ24cW6iIW1Hh9V3oH
        1IeIzsH3dkI4/nmLwhJt+eTUnjp6fUcXWX1Fvsh/uB40WCxducevciqmzGrBfj2u
        PjLtP3IvnvX4qw==
X-ME-Sender: <xms:hT0eYQylSY6PDvHU0vv7M1QDi2hSESYURgRo5YVCBcMq09kgw6XOBg>
    <xme:hT0eYUQqqpbOhdN5fMma6eObgm-AwuiV3IFQVo8CREunpOAsRmWAB3O19pxAcxk2U
    QGDIG5vtSq0epGGoaU>
X-ME-Received: <xmr:hT0eYSVvfe4B1k9RuQPrERfGziu0_e0_25luDetn9R-mMWiZBkLp4SO50Js63HBgrngHeCg-L-qZdD2MctuZE_aMiIltA5BlNhR3d5KQ0Q2fXOfuvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:hT0eYej8Qg6DT3iIeYar9k564pyMgfuBIEPzKyzNcAPYSFCH6cC0RA>
    <xmx:hT0eYSDj4dOLYVr1vGpkMy5SOO9jJbGX0mbrnQyQazIXmK5M4XnbRg>
    <xmx:hT0eYfIQo8v7IE0zbELR8zwRZw8I29LOrHeFJm22lDxTJgqqDctQrQ>
    <xmx:hT0eYYDNwi7yoHmREUXZNx-QiYMLj9S2l5qiJKk407On6pLDV6VaJQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 07:16:17 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v11 08/10] ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a
Date:   Thu, 19 Aug 2021 01:44:47 +1000
Message-Id: <20210818154449.1037-9-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210818154449.1037-1-alistair@alistair23.me>
References: <20210818154449.1037-1-alistair@alistair23.me>
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
index 052f9da32398..ab2f61d9c635 100644
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

