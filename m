Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20E5349F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhCZBz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:55:59 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50863 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230361AbhCZBza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:55:30 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id F41885C007B;
        Thu, 25 Mar 2021 21:55:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 25 Mar 2021 21:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=4fWfZpS9KZS+8
        Nt8/LwQGBOC8swx8HY12NB6LCJixY8=; b=ojNjgozSdRCqqWE/qcbG3fEu2plGB
        0EL6QcWjmjE334JpyOrDxiLTxcQ1r7sC5dFcHAQEaXEynyTz45twS2R5BIQ0BWt3
        yoKRcpw69MJzVu0+XbsS6lw4pFcXlYToCjvW3NYIPHhXplUq2zMnUal3tkLbRURT
        skIANV1XdAdeDk2kn5aR6EDOnUFTeeCAtqjR6VbG8oQJOKz5UWORLYd4lHe5Wfyc
        PdAvHMXPt3SD+9AkXEhsd+f2Mr8pu8owiJ5Z7VPVsE1BaKyrZSNDJqnDoMEV6zC6
        50z/UMfghP2INJAMnZ+rBW6AC+UApA+piQ+HRB34S8Txuoj/hEGxbYgXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=4fWfZpS9KZS+8Nt8/LwQGBOC8swx8HY12NB6LCJixY8=; b=T+xcO1jb
        A0XU2JsglMZdiTzy6XTMPsVUJ9bYX2KlkAHUFvdtEyms2iCwRYzf/ekVLWRHtz2I
        UDI0YQc6jhJ5HJo4RPed90a2kW/XEbufcqALBSt+syvRhZrBtyC5xosqVF3/MYd+
        eM3nxQmap9FpRnImkQO2LDQoqE21+Q23c/SG0iZgP9hBNeWKNJhVN0A9VwRIL5tn
        gjCS9OQEzt8NvltI3qPKxq20hUFpejqgpHTDKqLw2cwDYBSvJUr7zfzRhG9C9pIR
        2cxOavA4JG+SlJwecbz/UEC8AxFops7bIqX9PrDfbUSM+8RPeQpKmeRTQTOYAtkO
        nhVwBLvvcMqp8w==
X-ME-Sender: <xms:ET9dYG7iWgvVx-f0_pcK4AeoSA4Sc9Tt7tPPDMm38B7HBVqxAeAQJg>
    <xme:ET9dYLl1LxKFw_MtaeJpcmpZEZJ3P5AZ-5AJQn5AHtzdCYAm7pqSQrlet6NdLUi4m
    EKTFfHoKpcXgffdmRE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehuddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucfkphepudelfedr
    vdejrddufedrvdefheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:ET9dYB5X-obEF3FOW9h2PwbPSJk-5q7KbA0n3pgLvi8qapkq1CJ_4w>
    <xmx:ET9dYMTjoRJ-L-icc2k8C6I_WpmjzhV3AHoVmLzLfLL4twDyzAqIww>
    <xmx:ET9dYPyJQivKVrN9btWFWIaPPHBOE_EzPqmchaZ9zgDrF0vB_euwbQ>
    <xmx:ET9dYNWbqcWlZhgixMNfWccxpfXLpPDqWgd5uhTBKa1ZYPHJlIAIvA>
Received: from ThinkpadX1Yoga3.localdomain (unknown [193.27.13.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id E0AE91080067;
        Thu, 25 Mar 2021 21:55:28 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 5/5] ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a
Date:   Thu, 25 Mar 2021 21:55:11 -0400
Message-Id: <20210326015511.218-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210326015511.218-1-alistair@alistair23.me>
References: <20210326015511.218-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the silergy,sy7636a and silergy,sy7636a-regulator on the
reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
v3:
 - Change patch title
v2:
 - N/A

 arch/arm/boot/dts/imx7d-remarkable2.dts | 61 +++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 791ad55281cc..37834bc7fc72 100644
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
2.31.0

