Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2B93BF979
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhGHMBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:01:22 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35157 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231727AbhGHMBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:01:20 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E1A95C0196;
        Thu,  8 Jul 2021 07:58:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 08 Jul 2021 07:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=HINbVbCnlBaJT
        xYq0NO/rfGihWnDVmFHWZN+GPBONQE=; b=UUEOj83WfhxLw1jmSKq65mfdyd3aS
        DLwy3vS1+0PBpHj8QOUGFGk5ksnzxlB19FNysl4Sy3O5vBTGofFeW60p3modm7dv
        N2fy6gEdF5yosxP0ZGptp7KbJ2aKTV4OMUndIzkFCIYAEg4CiJuSdt+o7AqOdB+y
        4MkckDbxy0q4F3xjK0pi06TYrlsdtYc52UMOqqRduSfBMDjXBkuJxXOr3t/1PQ49
        C0JqBGWSjSVYzGSpikAoyx5s8p7SPoXlqIXPSBJw8RGH31J6a6idLh6mgkplJ4NN
        cBMJsyG+PO4xTxXDSghHpS2dRyquArdZFhBEDcd4uq3DE4OZvQRxpalSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=HINbVbCnlBaJTxYq0NO/rfGihWnDVmFHWZN+GPBONQE=; b=m9WFtsl3
        Pu8rL/OzCxMvdqIQ12WXN+pfLe7P/vyDlx/kid+EexY9khVS+UKLFIVKF5d0TGfm
        mVv45y5G5H189h6lioTf0FuC5VrWSHJDpERiOS775Fg4zhaTs7RtW7gvexVAyZYV
        JyhlyiR7aZp9bcugWN27Wz/GSmVEeMJwJMjigtf6VpX5DE4PgWVImoN16HzscrVG
        dL3AxRzqqylFClIsB2JTqX9mp3mEABTDal0Dw1S9RZn7JtDKCGULlXHJ7BeGzqAB
        SUyiIqd/hB4RD6WmZdPtB1U9+uVdG173C+Udt7FBnl6zBDzgebkbal63j1vQ0ku4
        X8CbjlR28I4ivQ==
X-ME-Sender: <xms:bujmYNIXO8ZQVr2T0Gv7wPzvxtm5VrCwPx8hd2WvscX2sD_Sd5iM9Q>
    <xme:bujmYJLsHdiK0cintROoqODDGpqXtcElqwmHfAs-u9pZAAJloWjesPBhxNJgnAfxf
    c5pwRvGx6TcgVuucyU>
X-ME-Received: <xmr:bujmYFs-QZGFf-w1AvRNG1tTMf8tOl0q5TKiu7FfdX5W2VOguqUeS-5K2_Rdmf9htU0KX2OVZtaU4yiLzbU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtdeggdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:bujmYOa6lCGF8cqrbX6dUPDwjzYyoHEfdwmE9gcO3hGif0hTI-Xo8w>
    <xmx:bujmYEb8iejRJZk_DSz7H61oGKFlqVK2NPthtL2UPW8QjGJvcr0l2A>
    <xmx:bujmYCDq1cAa0gNKGhAnpo4APZLXD0_izmv6nVI5h6yXkSFwjxlWhQ>
    <xmx:bujmYE6_AwDYd7re-7CjpKAQNPKRpGv2zBr_UVBJAS7_ooZhiA4tsA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jul 2021 07:58:34 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v7 6/6] ARM: dts: imx7d: remarkable2: Enable lcdif
Date:   Thu,  8 Jul 2021 21:58:04 +1000
Message-Id: <20210708115804.212-6-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210708115804.212-1-alistair@alistair23.me>
References: <20210708115804.212-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Connect the dispaly on the reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 75 +++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 9bdae1c1236e..12af892f4b15 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -47,6 +47,16 @@ reg_digitizer: regulator-digitizer {
 		startup-delay-us = <100000>; /* 100 ms */
 	};
 
+	reg_sdoe: regulator-sdoe {
+		compatible = "regulator-fixed";
+		regulator-name = "SDOE";
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&pinctrl_sdoe_reg>;
+		pinctrl-1 = <&pinctrl_sdoe_reg>;
+		gpio = <&gpio3 27 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		pinctrl-names = "default";
@@ -55,6 +65,16 @@ wifi_pwrseq: wifi_pwrseq {
 		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
 		clock-names = "ext_clock";
 	};
+
+	panel {
+		compatible = "eink,vb3300-kca";
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
 };
 
 &clks {
@@ -114,6 +134,21 @@ reg_epdpmic: vcom {
 	};
 };
 
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif>;
+	lcd-supply = <&reg_epdpmic>;
+	lcd2-supply = <&reg_sdoe>;
+	prevent-frying-pan;
+	status = "okay";
+
+	port {
+		display_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -228,6 +263,46 @@ MX7D_PAD_I2C4_SCL__I2C4_SCL		0x4000007f
 		>;
 	};
 
+	pinctrl_lcdif: lcdifgrp {
+		fsl,pins = <
+			MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
+			MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79
+			MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79
+			MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79
+			MX7D_PAD_LCD_DATA04__LCD_DATA4		0x79
+			MX7D_PAD_LCD_DATA05__LCD_DATA5		0x79
+			MX7D_PAD_LCD_DATA06__LCD_DATA6		0x79
+			MX7D_PAD_LCD_DATA07__LCD_DATA7		0x79
+			MX7D_PAD_LCD_DATA08__LCD_DATA8		0x79
+			MX7D_PAD_LCD_DATA09__LCD_DATA9		0x79
+			MX7D_PAD_LCD_DATA10__LCD_DATA10		0x79
+			MX7D_PAD_LCD_DATA11__LCD_DATA11		0x79
+			MX7D_PAD_LCD_DATA12__LCD_DATA12		0x79
+			MX7D_PAD_LCD_DATA13__LCD_DATA13		0x79
+			MX7D_PAD_LCD_DATA14__LCD_DATA14		0x79
+			MX7D_PAD_LCD_DATA15__LCD_DATA15		0x79
+
+			MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79
+			MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79
+			MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79
+			MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79
+			MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79
+
+			MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79
+			MX7D_PAD_LCD_CLK__LCD_CLK		0x79
+			MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x79
+			MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x79
+			MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x79
+			MX7D_PAD_LCD_RESET__LCD_RESET		0x79
+		>;
+	};
+
+	pinctrl_sdoe_reg: sdoereggrp {
+		fsl,pins = <
+			MX7D_PAD_LCD_DATA22__GPIO3_IO27		0x74
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
-- 
2.31.1

