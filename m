Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DE3460648
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 13:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352615AbhK1M4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 07:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346027AbhK1Mx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 07:53:56 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044B2C061756;
        Sun, 28 Nov 2021 04:50:41 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id t8so14065143ilu.8;
        Sun, 28 Nov 2021 04:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Agu7xnGDM6YB+EYmU4GI2QBmIQdCn4bFRF+w99b6/s4=;
        b=gYIvu/Qiz0FgOa4gqRNYROLmw597I76DI8q1gWPR2eSQtYZCiqHmA4pfpOOVXgZngl
         udOMaXvUWbRHZ9LOsJV4G7gc6ji58rcVfpzHAF+h7Pvd31h7SOryOM6yku50+NxeIx8A
         ykcSpsXCVcS2x/K7TMljRKVxVLoszRCodYhRQsi9tlDyNMqlVjvpDb4iiaqMCOqxqrRq
         YpU7o08dUj4+pSntux6hjZQzERnJSgTjlpFG7TFpCt5rAHACfX+oZSZ4p6/1b5NzXAVy
         NIzwGPrKp3hWceKg9b69PT8T7oRUXER7d+OulvqgfxnJvtAeOI4VAEU9Y67HEw971LX2
         CCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Agu7xnGDM6YB+EYmU4GI2QBmIQdCn4bFRF+w99b6/s4=;
        b=AkHj6naa7yY0COkd66qp0O30S00TvpsTkPAtTyt8gl7bgFrfaYo1KMZp5ySn/ltEGz
         CE7JyY0XoyqQsFRr3El0cA5bU/PVgOr4XwoYIcK3J/QFPwOtE5DTyvS6/dwyvjrW0uoC
         M4da6IFcRLpkpdKy7fK6+gjR4D9U3zZT9kvb5pRGvMaYBuqaUoWP4zuwYzNHVBPpAdfj
         aovuRkOUpzBW2RzhPEH1wXcyy6JhbQG6cjAXdmOzGZ8pLFFSWOhpAyDK5bcC0aYghmRJ
         DU2OBb786bzmX2tggUPbdiq9O/B8FxQAG175V0UgEN4i6FfWV4TwKJpLNjgjATXJohcr
         bQ5w==
X-Gm-Message-State: AOAM5301pM1Ia1HHVUknWoaU1OgDbRV6LrM3WdVDeSsEjAmJVz37/KkS
        gFi02UURF0ZH7ICQGMDdSZQ=
X-Google-Smtp-Source: ABdhPJwK00tAWAHYQ/Xg0jq7NAFJALJ2iXohnWaIhM1OM5Y31jjY4Y941QDSCDzShp+REV9xjw1Etw==
X-Received: by 2002:a05:6e02:5c4:: with SMTP id l4mr50079850ils.317.1638103840289;
        Sun, 28 Nov 2021 04:50:40 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2a06:17d2:47df:6c8e])
        by smtp.gmail.com with ESMTPSA id j21sm6545240ila.6.2021.11.28.04.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 04:50:39 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     laurent.pinchart@ideasonboard.com, tharvey@gateworks.com,
        aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/5] arm64: dts: imx8mm-beacon: Enable OV5640 Camera
Date:   Sun, 28 Nov 2021 06:50:10 -0600
Message-Id: <20211128125011.12817-4-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211128125011.12817-1-aford173@gmail.com>
References: <20211128125011.12817-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The baseboard has support for a TDNext 5640 Camera which
uses an OV5640 connected to a 2-lane CSI2 interface.

With the CSI and mipi_csi2 drivers pointing to an OV5640 camera, the media
pipeline can be configured with the following:

    media-ctl --links "'ov5640 1-003c':0->'imx7-mipi-csis.0':0[1]"

The camera and various nodes in the pipeline can be configured for UYVY:
    media-ctl -v -V "'ov5640 1-003c':0 [fmt:UYVY8_1X16/640x480 field:none]"
    media-ctl -v -V "'csi':0 [fmt:UYVY8_1X16/640x480 field:none]"

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
V3:  No Change
V2:  No Change

 .../freescale/imx8mm-beacon-baseboard.dtsi    | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
index 4097a66163b2..0da311898e01 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
@@ -54,6 +54,16 @@ reg_usbotg1: regulator-usbotg1 {
 		enable-active-high;
 	};
 
+	reg_camera: regulator-camera {
+		compatible = "regulator-fixed";
+		regulator-name = "mipi_pwr";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		gpio = <&pca6416_1 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		startup-delay-us = <100000>;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		regulator-name = "VSD_3V3";
@@ -78,6 +88,10 @@ sound {
 	};
 };
 
+&csi {
+	status = "okay";
+};
+
 &ecspi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_espi2>;
@@ -101,6 +115,30 @@ &i2c2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
+
+	camera@3c {
+		compatible = "ovti,ov5640";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ov5640>;
+		reg = <0x3c>;
+		clocks = <&clk IMX8MM_CLK_CLKO1>;
+		clock-names = "xclk";
+		assigned-clocks = <&clk IMX8MM_CLK_CLKO1>;
+		assigned-clock-parents = <&clk IMX8MM_CLK_24M>;
+		assigned-clock-rates = <24000000>;
+		AVDD-supply = <&reg_camera>;  /* 2.8v */
+		powerdown-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+
+		port {
+			/* MIPI CSI-2 bus endpoint */
+			ov5640_to_mipi_csi2: endpoint {
+				remote-endpoint = <&imx8mm_mipi_csi_in>;
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
 };
 
 &i2c4 {
@@ -152,6 +190,18 @@ pca6416_1: gpio@21 {
 	};
 };
 
+&mipi_csi {
+	status = "okay";
+	ports {
+		port@0 {
+			imx8mm_mipi_csi_in: endpoint {
+				remote-endpoint = <&ov5640_to_mipi_csi2>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
+
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
@@ -238,6 +288,14 @@ MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28	0x41
 		>;
 	};
 
+	pinctrl_ov5640: ov5640grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x19
+			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19
+			MX8MM_IOMUXC_GPIO1_IO14_CCMSRCGPCMIX_CLKO1	0x59
+		>;
+	};
+
 	pinctrl_pcal6414: pcal6414-gpiogrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19
-- 
2.32.0

