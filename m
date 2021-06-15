Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7100D3A7C12
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhFOKgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:36:55 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35945 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231785AbhFOKgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:36:45 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6F4F75C0195;
        Tue, 15 Jun 2021 06:34:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 15 Jun 2021 06:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=h7XH6I2ycjrnk
        yVPqG7auaEntJ59Imdi7yDlZm2rCj8=; b=JS17wA5nTA5Tyu5WtWUMh4n3PLqxz
        Rn9rMhfzpvCzcc675thdnNagUWqvOYPNE5AVUSzVRt9S7iyc2PqwKuEPAzfDZwUF
        FRgMgpxPxycfFwtYuSiAXstj+EqWxjaisCa8+ZYiktoRDnmUa/5kq7/630SRMM/T
        ZSZlViceN4M6R9tPVk4qPORqILISy8CZHqbw/FKYyZb9fvro7QXx4mprpm8muwX5
        4jon7iYUWgEZ+Taby/v2KE1L7MhClWRtH9bl9K4x4zaIQhqo3C1vmyRymc6LG9Cp
        3Yf6AsO6ATLZ3Eco/NTULJuCedM5QDb6XFbJAM/YJOeHfdGRDrSrLx/6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=h7XH6I2ycjrnkyVPqG7auaEntJ59Imdi7yDlZm2rCj8=; b=SWjxzWsz
        87fFVB6THUNp3VMbfwbHUdRI2XQxuoe3vPfN6Gv0+PztQvKKw5oN05oAOwV/IA1C
        Q0U00w5v8SL0+qbnj6sHcJAd6M0fu8T3Xf8ogXeS0oeQswQLG5ekrew4Ul10Hh8d
        B6ICSZ8Pxx72mN8K6B7ehKKS9hIpXEmazSZSUpk15YjRY+PQcE0qVOAPYrcd47CH
        4rykwEp8jAml7b8JlDbgN1AHLyJ/hVIjdFaV1DqKercgMIJx+vc/Gp9/9nTxOgJB
        wPMDB4F1ZCcPwsME2gLVgDPL/zdSbw8g4CKL04srZLtTcijVCupgYOU+l3zf2SI7
        Fs7N1IJUoM/LYw==
X-ME-Sender: <xms:P4LIYC4TDX1H3CFiLBp3K72AxTWzLR8TsF3fWmz1GyWD23XqB_cVag>
    <xme:P4LIYL6aKtjGxnsk0wJKdm4Rirk4K7IT_cRN3I9FhNd1DfDJBmYQ8r9kV1PE0jZLN
    To7Idf766oWTwV_7oI>
X-ME-Received: <xmr:P4LIYBfvsrMYxehUQ4icTMWl69OcYNrWyk2BvcKJbxTUm_t2gptSkqWu6xCE6XEz6nyhP967aW4o3zUx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvjedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:QILIYPLiFeZtkGQ9svPtf_YPWtmMuiSucKASfc3ENOWW-oaaNTDiGw>
    <xmx:QILIYGLRkvBfTNUHfySU4RAU4r4xGnKipKOI73YwlwVvZH8nYDETVA>
    <xmx:QILIYAzP39k3ZQnZady9RFMxAYj4IcgkHJIokQZUlXOpZ0pIgmY9Sw>
    <xmx:QILIYHpQiIgVGefwIO7a6IyhqmCRsR99SPQg9SfWrHFwK-tIHykBgg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jun 2021 06:34:35 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v6 5/5] ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a
Date:   Tue, 15 Jun 2021 20:34:00 +1000
Message-Id: <20210615103400.946-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210615103400.946-1-alistair@alistair23.me>
References: <20210615103400.946-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the silergy,sy7636a and silergy,sy7636a-regulator on the
reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 61 +++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 35262c60f015..5876d16c4494 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -22,6 +22,27 @@ memory@80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 
+	thermal-zones {
+		epd-thermal {
+			thermal-sensors = <&epd_pmic>;
+			polling-delay-passive = <30000>;
+			polling-delay = <30000>;
+			trips {
+				trip0 {
+					temperature = <49000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <50000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	reg_brcm: regulator-brcm {
 		compatible = "regulator-fixed";
 		regulator-name = "brcm_reg";
@@ -86,6 +107,32 @@ wacom_digitizer: digitizer@9 {
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
@@ -180,6 +227,13 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
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
@@ -187,6 +241,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
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

