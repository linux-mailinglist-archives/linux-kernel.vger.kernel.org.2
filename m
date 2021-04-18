Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48F1363DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbhDSIlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:41:23 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34409 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237923AbhDSIlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:41:22 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 047BC5C0065;
        Mon, 19 Apr 2021 04:40:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 04:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=lh2yqqD62rRvs
        A4AfshhonKA9bQHJqJxNH42xzix+/s=; b=b/NkLx/kLnxOESL9ugxBz/0GnRsKc
        z9iLCSpmwpvW4m5oa7v3UssSx6fgVwN5p7XuIHyUw1IHLET3cJAKbLF9FfQKOGLz
        U2WHSh6ShH7ltxhYujVJ1aSpA2gSUxoQwQiu+XEHhms43+M/xk7RmMTrYe4eNnIp
        Ks95NTy3rB1hLmWAZKdDSTKt4pwkcu5C2EcAzny1YHQt/QRU1hfr49PwCpSsxU9h
        1kyVmiZsrlKCamiZy2y3Pt0HvXe9oe0nOXruuaGqoGR+I+mod/yLyKUj86XbNM0B
        j4vG/lgaK5wOdNTuyHtXnjTrCuimwE2JAkWatKsE9BiVZYyv66zVYk3tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=lh2yqqD62rRvsA4AfshhonKA9bQHJqJxNH42xzix+/s=; b=DR5SLcKy
        NWTYVbcmyjMnDCnvfKI2P0gKk44v2HLf/Cr9ZGsl/oQ85rTId6Iwy2ose9QtFz8q
        TFjqolRama2BZwACkgWrWciJS68kN+8J3xgNPzPD5Je7QhcdNuJjiDjibyPJ9qMc
        YEwe3mEweTH5JCudt1jSk76+zstl2CMamgtI3g9Kq8PgmU9I3SzOF+1RjfuQCnJY
        eTjn6j3hwWxZNLufN8JgmvbnxdcS78qGouorxVBmcyg4FJK3CekuZtM9Hjo8tTOC
        MEZbwDrEjMbi1uK4JYKAk62m4G8lcSB0koDh6G0V8V/AuOqoawBpP4kcMsB0I2K1
        6kQn7DtGTc1cpA==
X-ME-Sender: <xms:FEJ9YL2cEutbR69t6l9KMFC5NUlDv4TaDzLVR2PQKGA1cRgulFvi4Q>
    <xme:FEJ9YKGm8Hs7WLmVcoR2bgzjocVYZifB1Kj8j0rlNOhXvdci0U7_A9JEr7JoccbjQ
    r4RiLgDydavzccbYCY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucfkphepkeelrdeg
    gedruddtrdduvdefnecuvehluhhsthgvrhfuihiivgepjeenucfrrghrrghmpehmrghilh
    hfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:FEJ9YL7w9yxovV0Q678DAeIukB5re4PJ5Pw0VQvdOD67BIghxE2d0Q>
    <xmx:FEJ9YA2h59_GvlYJIOsxGLPggFuMLfzNYnZTfLetPLxVEqfVFpmKMA>
    <xmx:FEJ9YOEEkWqX8LaQnZRPV1CA10bwvbnCut-PRZRtodf4ArV9IYRGnQ>
    <xmx:FUJ9YD6rBGZQCS8kaJQO1cwq4DySSmekvLzoCxH8_VfQIXrBfni1zA>
Received: from ThinkpadX1Yoga3.localdomain (unknown [89.44.10.123])
        by mail.messagingengine.com (Postfix) with ESMTPA id A148B108005C;
        Mon, 19 Apr 2021 04:40:48 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v5 5/5] ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a
Date:   Mon, 19 Apr 2021 07:02:22 +1000
Message-Id: <20210418210222.2945-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210418210222.2945-1-alistair@alistair23.me>
References: <20210418210222.2945-1-alistair@alistair23.me>
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
index ea1dd41023f9..bdfc658d89db 100644
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
@@ -179,6 +226,13 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
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
@@ -186,6 +240,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
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

