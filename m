Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3349E3E34F5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhHGKlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:41:07 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42885 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232168AbhHGKkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:40:55 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 27B4C5C00C2;
        Sat,  7 Aug 2021 06:40:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 07 Aug 2021 06:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Qp4VJj+NKIDSj
        eZFw5JMaaO480IDZOWJ/rCbso9rZuM=; b=n8n1OENGFMM1ISGNuNcKwEbG8abZS
        lf55xNEoeMegxfTCU15BVplWRYaNb9Ob3yvgJhaTnazmL9KNvNHj9DFdsJHzqose
        OxioFdc+LATtVJb2Icp843dpo762Q29lPrHcbvqgL0Mn6g5qftT4GDvLM79H7ABG
        rNgYynfB2ngV/9UhUcZIwf67KpODj8foAf7B9tS9XkvRXQhbdC+aaGgRNdqAUSzL
        BwkZADWaZIXpmU2nj5LSuJGdeQgp9Nu7zB9SNY1yMlGhjVopwswKxeMB5uRC27qi
        DvT10tOENuQlI4evGb8BEFwYZxhTAPA27+m3c2IFXIRsR1CpFd7fM4Ytw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Qp4VJj+NKIDSjeZFw5JMaaO480IDZOWJ/rCbso9rZuM=; b=POhy9Ilw
        7zebkjLsSCxketXYd+mCSqIbBqQpc9QmhBwkbDhsesPgOR9rqI/zeTE8gAk8n8ie
        V7N3SMmqnbratUlfNf6LDdvo1vqpcbEhpeaplACi/AM27qYYzysaTE9ZVON6zeh3
        rPhGQ77VJMx/FiKuklLsma5g85YtcJeo5KKJ/rmCml5Pn+Lo13wsYwjQG39PXtGt
        o4Yt2MkdCLppmCx58BJeJ0CCXTvmddNY3bbNBFugrUiOowj5KXA1MceIVRVFplD5
        V6bVi11vMbdQQDjnE6TGFW9Y76cTNzg7dNTbRQxi0bvNiwlzp0jUwS0YHOnybrj0
        kX5YnY2nrVraFg==
X-ME-Sender: <xms:JmMOYfOxNYSoLTnwvaKNKEDp-sqG-hzWdMtzzc9o1ejxV25lsRa4Cw>
    <xme:JmMOYZ8yt5Z_hmOVIulu_dz7XJod-RE3aC0Qvv_2ZFaIJi1Fl89ISU51h3VheXf1M
    6NH8SiNS2VPnNJ1mpM>
X-ME-Received: <xmr:JmMOYeS_b0fcwbcEDEURLlxg7guMds0pZ0zGfllDBixZl_l4HvRpZkzVHDCTojogv_48lja82QsXdQ4foDYBurv9hZl9cFkBldRjrNahmL0SEaoksw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeefgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:JmMOYTv4DrQHhcHmKvbkFdlMx06bMOL4XGXxylgZ4CdQWBIwR3YXyQ>
    <xmx:JmMOYXd3DFr8_97Bs1_JDboDbRdhl53mdvYn-oQn36-4nHd_58DjkA>
    <xmx:JmMOYf1jPl8KqpC6yQLd3p3IHB1uC5UXNg9-lQ-gHKR1V0KQXxqd5Q>
    <xmx:JmMOYZuiXjVcY8Q0CphtIY00AX4lsCXqGyJX84ylPEEvzRr5RMq7ig>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Aug 2021 06:40:34 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v10 11/11] ARM: dts: imx7d: remarkable2: Enable lcdif
Date:   Sat,  7 Aug 2021 20:39:40 +1000
Message-Id: <20210807103940.152-12-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210807103940.152-1-alistair@alistair23.me>
References: <20210807103940.152-1-alistair@alistair23.me>
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

