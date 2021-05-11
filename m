Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B29E37AF61
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 21:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhEKThQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 15:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhEKThP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 15:37:15 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1DCC06174A;
        Tue, 11 May 2021 12:36:08 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t18so21279462wry.1;
        Tue, 11 May 2021 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x5jrFRtgn32THIuuycsZoyyMB823S2xuWHvAQrvHs7s=;
        b=ozOhKTwFNHGk4QT474u2sYyAB92rHC+GMVT2mhEbmL28LSTG47g+zODSOSkw+IyYN4
         dLA8HKKYLQ1RhPSOP8YxWCCNK9vXtBxIyl3wCQd0qAim0VJoPGwzGz/Q2gkNSjblY82m
         W/LsbDGKWVviO2k3e5yNk9oOxgs2J/24xVypKhVebDm6FoLanC0Lf9732j9oAg0QRqh6
         uwF9+YacTXC26AFSP1ms2p4KwZkaNMOD/xF+uMecNNJZUEDQhLU/fPJNI6RuhNV5Vn6g
         BnNDhYHoMjSnDUhdRdqvWrG2Ekk131mMlku4JS2lLo//2SdahvBfybsN1wm15m/s3qGj
         BEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x5jrFRtgn32THIuuycsZoyyMB823S2xuWHvAQrvHs7s=;
        b=qumQrbi9V7qWw5kYTNcLuo25V7lUa4nPJpuwT6Z6oX/VsMyHKmfmtS2FMUNtT93T7x
         kkYDNiDKrbByMR3IpmwdxzVqFlOLdcep3hcwqXZDQ4ozzbU+OjL5MYcML7DEI+Gte1jr
         UeUO6YV6yDRi2HjqKbE2ykV/Npxun/+7xT5h0Zu4Hj0PIUEfW3bZGQ5M1ywt8kaY7I1T
         E+JEo2dJq86YH/F6jEaJ4FuRBObfntGTHbuFokxb4n8T3vffVS1O5UuEiVKv56kxVmdN
         hBemAnCdUDH0PE0h8R+MCpv+q5UA/OZkKatBp5SYFVE1J0xoMpg6LB1Jt3fkPs3ESB8w
         JXLQ==
X-Gm-Message-State: AOAM533dzCYDR9JflhkHbhGdMVho5yiIgDAVGqco0yXFMt3fqOtGQ8u0
        jli8QhsXwRIFZdxVdX2sV0g=
X-Google-Smtp-Source: ABdhPJyAL+IK5wZJOI5yv6Lm6P5uaMmaLXnfdYj3vsZBcwY73mQ3ZauDEpnPMhENypSSkq2t42Q+2w==
X-Received: by 2002:a5d:5741:: with SMTP id q1mr40347369wrw.212.1620761766966;
        Tue, 11 May 2021 12:36:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:3e6:d280:2c6d:4527:c2ea:bb9a])
        by smtp.gmail.com with ESMTPSA id a76sm2604562wmd.16.2021.05.11.12.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 12:36:06 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 1/4] arm64: dts: imx8mq-nitrogen: add USB OTG support
Date:   Tue, 11 May 2021 21:35:58 +0200
Message-Id: <20210511193601.2584324-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511193601.2584324-1-adrien.grassein@gmail.com>
References: <20210511193601.2584324-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description for the USB OTG port.
The OTG port uses a dedicated regulator for vbus.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../boot/dts/freescale/imx8mq-nitrogen.dts    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
index 81d269296610..b46f45a82be1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
@@ -34,6 +34,17 @@ power {
 		};
 	};
 
+	reg_usb_otg_vbus: regulator-usb-otg-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usbotg_vbus>;
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_vref_0v9: regulator-vref-0v9 {
 		compatible = "regulator-fixed";
 		regulator-name = "vref-0v9";
@@ -190,6 +201,18 @@ &uart2 {
 	status = "okay";
 };
 
+&usb_dwc3_0 {
+	dr_mode = "otg";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb3_0>;
+	status = "okay";
+};
+
+&usb3_phy0 {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	status = "okay";
+};
+
 &usdhc1 {
 	assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
 	assigned-clock-rates = <400000000>;
@@ -339,6 +362,12 @@ MX8MQ_IOMUXC_SD2_WP_GPIO2_IO20		0x16
 		>;
 	};
 
+	pinctrl_reg_usbotg_vbus: reg-usbotg-vbusgrp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x16
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x45
@@ -353,6 +382,12 @@ MX8MQ_IOMUXC_UART2_TXD_UART2_DCE_TX		0x45
 		>;
 	};
 
+	pinctrl_usb3_0: usb3-0grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_GPIO1_IO13_USB1_OTG_OC		0x16
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x83
-- 
2.25.1

