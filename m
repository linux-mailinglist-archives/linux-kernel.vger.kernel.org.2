Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7CC3BF978
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhGHMBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:01:21 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52065 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231643AbhGHMBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:01:16 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 46FA75C0196;
        Thu,  8 Jul 2021 07:58:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 08 Jul 2021 07:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=r7v2sGI6eutla
        1HtTgIVdJ8GS0/nq7Ix9Yt0KrGBTXQ=; b=gfUYCm1hzJR6IhXPObijuOPQ5h5d9
        KV13qtppDAcRcu6nSxBXpAzW8eBhQGka0yIj5aXvF1eELHlUR/AFISrQzi6bTDEJ
        kdOwUXjYub9f3eYy0kiLwA1dZgcIhxbQF92cPDlZ3v+JceUkD3+tzecUTgto9hr4
        cFhtD/oWXVHDDq4F1Df0wBP/0VAZK0fpis6fd4MX2Tfn4bA3yk6ligwNu2QClDbE
        Z8jRxLakzlZiqlObR9vFqUrhGLOFqdmiIZTvZDwmWZ/P1HSNtggPhxyQHmQcpgRg
        bdTI1g5qLZojvuu9s8oz8h3DslCFR7/KFv8aXVxcTD/HzSIcr5HJu+/oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=r7v2sGI6eutla1HtTgIVdJ8GS0/nq7Ix9Yt0KrGBTXQ=; b=D685+eF4
        Pfvy7s5Qgc1aSS2mGv2Jh38i5XYNU/ukKv9x+8/fBZJjkAyM/VOgCkq25umhHlHb
        ZssfP5H69fzFod9NtDdk/JsfNEjrO4qQJWpUjDuqQ1YH0LU8ig/Vv9SRMl02nyEr
        kN5dfWZ1rqOPN7VNXv1wEFeyqbbasHvq4CYykVVGxFyprNU3biQ8Ymzv0v6lT0jM
        dpMv6X+Rlypk8pocITW/9feRq19jEj5GTqJgA+3tP3Bpjsa9ozJ5UTvNU4U/XUFd
        GOBMJ+G7jcJdr0pdQvRSyx/aBTanymDtHt2/RO4eiV38ShiWjnDceAwTpk74jg8R
        ESsXadMcPgaVKA==
X-ME-Sender: <xms:aejmYBMHuROi4oiNFwQxsL_bBaOeKQwkPfKGGkcdh_VV5zlUk9W4XA>
    <xme:aejmYD8xnelOBf5QvqpLg3mfTn6vM3DUgGtgs0DhD1YddAVFHkQ2fwR7ohbQ-z3lo
    _CAZxgpCL4H0aqhyYk>
X-ME-Received: <xmr:aejmYATqoLFQ4u-dPGxIq_D1Pf6vArBS9kSQ-1BHbdu_mDcowJQ4pKNY2p52FU99iXBN5f0O_qEPjtKQhso>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtdeggdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:aejmYNunVqwMEaPo_ImbEhIEJsrwLTpLBb2QxmJ0WNWz0mKkRL-PHw>
    <xmx:aejmYJf-2x9ID40lzLwokeqWjb9SIAgQzAryEZoiJLajfwWpmxaIIA>
    <xmx:aejmYJ2sgV0RWgOuzci7LId4-4aM2wp7vAOEWvyc0L8eDvH4US4uIQ>
    <xmx:aujmYDuJQW77okPBM5cvndfqF_Wh0VDXoWCFsyA9_umoNpCHJlwE6w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jul 2021 07:58:30 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v7 5/6] ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a
Date:   Thu,  8 Jul 2021 21:58:03 +1000
Message-Id: <20210708115804.212-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210708115804.212-1-alistair@alistair23.me>
References: <20210708115804.212-1-alistair@alistair23.me>
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

