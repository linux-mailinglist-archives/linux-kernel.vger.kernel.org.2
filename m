Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38603E26EA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244359AbhHFJMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:12:35 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35005 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244329AbhHFJMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:12:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 14DB45C00BA;
        Fri,  6 Aug 2021 05:12:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 06 Aug 2021 05:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Qp4VJj+NKIDSj
        eZFw5JMaaO480IDZOWJ/rCbso9rZuM=; b=ZDZQY9jdWnXKWoVxMTbYqtxaFDgST
        TIuDdyp7pCU0ekn2Sg94Xd/+C/JAgLi0e3EawsYY/H2cpwbzRr/rWYAOU8es8WHB
        vz8XLWs3Ea8VURSuqW1Cc7ziXylahjQq6EeZGr9Fu7tLZk+0SC1TmijBU2KWlLeY
        Au8SrYDHBa031oGmd0RJsF93SVeNh6AM9LkgrkfOXn3+XRdS9vGdO7WBgxscNp7W
        9JalN4ciY7c45bq7lPOfYScAwm7cYGAmZ/YGdChlZ9QuYgH+u1K6U1Xe/xIC0Y6Z
        /RfZ9eDcrYu4S0ltmsUavz15cEcgS+cf88C2/hy5hw2AUmdjWuV9K8rGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Qp4VJj+NKIDSjeZFw5JMaaO480IDZOWJ/rCbso9rZuM=; b=B9TSH7xu
        xkge+9S99K4e5ytCP/JWlHVmxHmh5/OcDzFAxbPYb9MxwYDp/pVsUZQafLdXgtx7
        omrs0RXtCJj+FPoAp+Fl30aHauhkjpwaP0LMtAYp80On7vTr2QCnjr14oWejYWKp
        3Hhl84KQWtYrj9HpJcc5bDIVLghRV+l2sr07dSZoCgS1oeMocnSe0Q+z72fQJny5
        O3/3vh2+FP8Dk15hLsIRRvVwa1vgGWFEKv3BW/4zgfPDw8bli8TvY707HrUrNb0T
        HVxhPgU4boY3w1b5u7Lde4FfyhiYk/GfXFu6fm68H9tGHRixWlVoyh4+dWc2s0w9
        7/vSrZw1SLB3vg==
X-ME-Sender: <xms:4vwMYUqYsEG4wy-oOcvYZERPpezU4NpzvfEP25uIdG59jfagZhM4AA>
    <xme:4vwMYapvMXmRPQiXqPevq8MDSYo2W-o-Ys_OYDfWVsyPpnoadjP7qhB6Yryjauato
    Lvz2ms949M2uWZd63w>
X-ME-Received: <xmr:4vwMYZOfd1g-WYyJUzO73Ver88xjDq9GfWyM8Ag_8K5WKsyAAMk1pshS1BzfgefX2aMkAcXXPbntljUTLIgvD24Ayctn89DQnyFAriCV9uO-1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:4vwMYb5vtP7DO2oJr6IXtS_SlIsA6oV1dZa0XNNIPPBJh4vjALlWjg>
    <xmx:4vwMYT4MpJIu5ztUQmMbpGFsPIAx_wJSmg7zgT6rDoBU-DFx-o2iNg>
    <xmx:4vwMYbiG52DrBbtOGcR875AflQ5WysBpLsmtggQO6b2IEcbbQNsWJA>
    <xmx:4_wMYWY43nMCLlLR7ojJUhB-kUSufdLAE4cT8-w6q1kv6JGSK8iBzA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 05:11:59 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v9 12/12] ARM: dts: imx7d: remarkable2: Enable lcdif
Date:   Fri,  6 Aug 2021 19:10:58 +1000
Message-Id: <20210806091058.141-13-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210806091058.141-1-alistair@alistair23.me>
References: <20210806091058.141-1-alistair@alistair23.me>
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
index 2f0c4fda38a3..f89945dfd541 100644
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

