Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8783F17E0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbhHSLRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:17:16 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:49889 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238848AbhHSLRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:17:05 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8E5E15C012A;
        Thu, 19 Aug 2021 07:16:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 19 Aug 2021 07:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=0Fvpa8Z1R1zqH
        Pq5M4cA9gD9N1aHb4dJ5to/1Pfz26w=; b=mQTnHRdD/nJGO/euOcgmyAynEISTj
        bTDqr4m18waLWD7WpVs2p3Zdh2m21kovcZ/bMSBMsN2ikUfWuETJJuiexulwOgeh
        jrAYDg53ckHUXlLriyd0I6+s+23HwMnxKmKuisu+3FOmJzZ4atEBqVYopkbK+O8F
        SIKsnGkFQQQUbCuAZLHbNCYU+o3qBHYwctmn/szesxsmRvQEwqQSq6GgS90F62fk
        ABcWM98HJMU+lcFzk0F2h8bH2FLgqFwVhmDgCv2SfHbIqHOQfBWsKwvMh7uruMiu
        JTwCVKxYEu5lIumX/OaV7j2KBEXqXIOhpFZjhSYEEDYJlz67gqe4mzZ0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=0Fvpa8Z1R1zqHPq5M4cA9gD9N1aHb4dJ5to/1Pfz26w=; b=a0ReVDKF
        h4ozwZe74QzM5NwRQ2WbsUVtK4xq1bxrPvfpCkQ7fnGCdu+MMQLXj3HuNtb2frnl
        0Rc/SWeOMbakwHM8KXFEXZCpC0flsRDLMDhU7gcmQwNGxxjwtxnjPg5FvzyOZiEX
        UAteZUdZDZycTUDtn4jfsKW6caM9KbNT1P7ElGsulRmCyZJpPUMZK/V/m8QkieUL
        w8EUWpQe9eLbmrGsJorDSwRLFAbOnzH0lqwYRJ8nvh3kNrhmRdc2SZz51eg0DZrN
        jNzj5ZpS7dFSxXCzvFP7j5+qfSjcQ/+9iBDGuK0DPffoT4vtqmfkGWTTcL6AvVyZ
        3oLei2WneAxCOQ==
X-ME-Sender: <xms:jT0eYduubkuKIAxTnHhw92ZfuOBzu8s6wyvNClWBCFpyvzeBPFyxZQ>
    <xme:jT0eYWdRE_MYP-0GNWMMS_FbtYhl23uPZbmWxOn0fHWeaydmfpHbFIowv1ISptFn5
    JEQ53RyaInyDbgzz24>
X-ME-Received: <xmr:jT0eYQyLsC4ucqa4p9QVaefONa7hUtIjFoTgrZXylnqUzKqZkynHUCRjWAR69DPKE4jc58dP1kNRffurdovRT1pe3nvV5uYo7RKlx4Dy3M7VMBA9Pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:jT0eYUNoC1qXCBkG5lJq7iJwq-qeugNuwt2WJ2w4KqIoJLNaHmBRNQ>
    <xmx:jT0eYd9ajwqFdgNFb3GSEJv2LDTIvmKkn5mO_0-6vat4vqEl5ZJfUA>
    <xmx:jT0eYUWnKPNkqR92ZCF5LIf6gB_aXfj4z5ENSZ05dD9M9iPKYVHbkA>
    <xmx:jT0eYWMDoFPgaaTNlrSfb0jYUM1seedNcmXg3UW8rAflTjg4HdAYFQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 07:16:25 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v11 10/10] ARM: dts: imx7d: remarkable2: Enable lcdif
Date:   Thu, 19 Aug 2021 01:44:49 +1000
Message-Id: <20210818154449.1037-11-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210818154449.1037-1-alistair@alistair23.me>
References: <20210818154449.1037-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Connect the dispaly on the reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 74 +++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index ab2f61d9c635..7a48ffb14498 100644
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
@@ -113,6 +133,20 @@ reg_epdpmic: vcom {
 	};
 };
 
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif>;
+	lcd-supply = <&reg_epdpmic>;
+	lcd2-supply = <&reg_sdoe>;
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
@@ -227,6 +261,46 @@ MX7D_PAD_I2C4_SCL__I2C4_SCL		0x4000007f
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

