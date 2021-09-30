Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6B641DE2E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347332AbhI3P6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346789AbhI3P6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:58:34 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1252C06176A;
        Thu, 30 Sep 2021 08:56:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 67ADFBFC87;
        Thu, 30 Sep 2021 17:56:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1633017409; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=7MTFLH0nF2ydDs5hog4J7IiH2Yacxf1aNgYfRZym6Nw=;
        b=iRgcy0nBiKGFa0osS8HjSayva48QzhhvfHyfRVxKbPufi+3T3C0yaLMBaSStL41ZDfNHGV
        BFmPFoRKWoD3QDJdz4E1KmuAUdwcPffaPONL5i48z+6h8kUc1uU2GrPLqw37o6tl1zj4Rp
        fWT0CGUqOONvlQZy8prQQ/BiN4Z6C4OgtXp/QcU33CtXtvY9F/8iL+kv2s02m7XpvDZDtC
        vcQ1jfX2f/I932KU+wzsXZ3up2bB5pY0Ch2S5+0W3WO3RbObiyMG40qNO3Y1UaPj+0mnlm
        1xnzIo3LHh/g+zmReDYpPoH9oj7B2N4c0iMVpLJQgtQ3BsDKyBzjXNab0XYh+w==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 1/8] arm64: dts: imx8mm-kontron: Add support for ultra high speed modes on SD card
Date:   Thu, 30 Sep 2021 17:56:24 +0200
Message-Id: <20210930155633.2745201-2-frieder@fris.de>
In-Reply-To: <20210930155633.2745201-1-frieder@fris.de>
References: <20210930155633.2745201-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

In order to use ultra high speed modes (UHS) on the SD card slot, we
add matching pinctrls and fix the voltage switching for LDO5 of the
PMIC, by providing the SD_VSEL pin as GPIO to the PMIC driver.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 .../dts/freescale/imx8mm-kontron-n801x-s.dts  | 28 ++++++++++++++++++-
 .../freescale/imx8mm-kontron-n801x-som.dtsi   |  2 ++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
index d17abb515835..62ba3bd08a0c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
@@ -189,8 +189,10 @@ usbnet: usbether@1 {
 };
 
 &usdhc2 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
 	vmmc-supply = <&reg_vdd_3v3>;
 	vqmmc-supply = <&reg_nvcc_sd>;
 	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
@@ -319,4 +321,28 @@ MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
 		>;
 	};
+
+	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x194
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d4
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x196
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d6
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d6
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
+		>;
+	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
index d0456daefda8..03b3516abd64 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
@@ -86,6 +86,7 @@ pca9450: pmic@25 {
 		pinctrl-0 = <&pinctrl_pmic>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
 
 		regulators {
 			reg_vdd_soc: BUCK1 {
@@ -225,6 +226,7 @@ MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c3
 	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x141
+			MX8MM_IOMUXC_GPIO1_IO04_GPIO1_IO4		0x141
 		>;
 	};
 
-- 
2.33.0

