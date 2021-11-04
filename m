Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B12445322
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 13:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhKDMhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 08:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKDMhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 08:37:08 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D949C061714;
        Thu,  4 Nov 2021 05:34:30 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id c206so5168205iof.2;
        Thu, 04 Nov 2021 05:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aSDFeDkO0qaLEtNK76O8NQimr+zDhbv1igoxk25YmPY=;
        b=E1DVTWypHI2O3f/jSult45xc4Nyet5nYf4oCkBxkNAF3ggPghzVdYPA1jCTjFxGi+4
         0gxaT98/tY8ziYzhlBwzJoKieroEL7j/vsFEzX2lZcYMQSJD+ymAzVbYGaa6Kcfd3ZyD
         io3gGk3bAqSzjp1kVPH9xpBfSYXJh+Lw2k9LWIHv0fCoZLzyt5HxChxRA3aG2Tkq6+wS
         kODFZYk9ugSw9G4IWZfyAiH6ZSnmvNOgZoXiOPuwtBaUiRxvJ/azHPABI1jsH31b8DvK
         FCtm9m+KRoUuRPtNY3MtUMku1SSxhc7Jjgimy+RmRqfq0ks+BhjZMqRbZl0tUNb9Tt/e
         h/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aSDFeDkO0qaLEtNK76O8NQimr+zDhbv1igoxk25YmPY=;
        b=Vil2qyxa+qN6SzjrVM7ectpPB8mfGe4lFahGOR0H2ZJOdDiiy5d3d2Hx28F5HsG14W
         75MyH+9lBzXwvxf16/BkY67fuDJj/btxhDtPemEaoMZ3GhDVvM8Ajy0SV/Hx5+QXHdhx
         QzYQN2jToc92VgjCoqMArFskzT2Eqt+vDotFYLJa+Ti8vFP3b67eAf/iIEWPP7igpkVI
         GBsMdJIGC1g6vL+DnD2yf8H142LDfLcI2tF69qgPLlWpHl2yc2dh1MGgHyvOUqu2IU9N
         RvspGzMCT7LFMTh1akzonUjAdsPKVvxeiLuHZRZ3T4Q7MYjhJSv9W9XdUKprnKsAYkP4
         jRTg==
X-Gm-Message-State: AOAM530BoCwjatOKgKoiVGeQYCaLHmkRPZ0KoTNuIZLtd/cZjymhxHKq
        Q+QiYgX34SCNIeHsQFc0740=
X-Google-Smtp-Source: ABdhPJw6M9RYSmqHFJvybY+a+KomOfFaWSSqh7ifj2ugVv7FmZS+hyQlTz+463uXwfx9IfqdHLDjug==
X-Received: by 2002:a6b:6a17:: with SMTP id x23mr6170895iog.165.1636029269668;
        Thu, 04 Nov 2021 05:34:29 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:e81d:737a:bb84:83ba])
        by smtp.gmail.com with ESMTPSA id o10sm2632156ilc.56.2021.11.04.05.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 05:34:28 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm-beacon: Enable USB Controllers
Date:   Thu,  4 Nov 2021 07:34:11 -0500
Message-Id: <20211104123411.397205-1-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Mini has two available USB controllers.  On the
imx8mm-beacon board, USB1 is routed to a mini-USB port with
OTG functionality.  USB2 is routed to a USB hub which has
three host-only ports connected to it.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
index 6f5e63696ec0..4097a66163b2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
@@ -43,6 +43,17 @@ reg_audio: regulator-audio {
 		enable-active-high;
 	};
 
+	reg_usbotg1: regulator-usbotg1 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usb_otg1>;
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		regulator-name = "VSD_3V3";
@@ -169,6 +180,24 @@ &uart3 {
 	status = "okay";
 };
 
+&usbotg1 {
+	vbus-supply = <&reg_usbotg1>;
+	disable-over-current;
+	dr_mode="otg";
+	status = "okay";
+};
+
+&usbotg2 {
+	pinctrl-names = "default";
+	disable-over-current;
+	dr_mode="host";
+	status = "okay";
+};
+
+&usbphynop2 {
+	reset-gpios = <&pca6416_1 7 GPIO_ACTIVE_HIGH>;
+};
+
 &usdhc2 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
@@ -215,6 +244,12 @@ MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19
 		>;
 	};
 
+	pinctrl_reg_usb_otg1: usbotg1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_RXC_GPIO4_IO29     0x19
+		>;
+	};
+
 	pinctrl_sai3: sai3grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
-- 
2.32.0

