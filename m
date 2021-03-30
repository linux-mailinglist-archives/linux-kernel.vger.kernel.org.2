Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FF534E420
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhC3JOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhC3JOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:14:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAE5C061764;
        Tue, 30 Mar 2021 02:14:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x16so15474566wrn.4;
        Tue, 30 Mar 2021 02:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x5jrFRtgn32THIuuycsZoyyMB823S2xuWHvAQrvHs7s=;
        b=Gu0DhOy9K5cjKnG58xDYHSmg6QtSVuu7e+sxdZ1SfkO2MmoUgkMVTUs9829+ayk6LQ
         uI8siSIC1dxZ7vJVDUbEvPIJfLf9oj3aMy1yIF21iAoI73xULxzIBDmCLsCQxG9fHxM+
         +Rhaiv1/6gH60RIw7wda6aicyePrNHnS51E2Bxw4TAdsUa+5Hn0qP7SIC8fv1vlvv3cO
         ZFY2IEd95Jcbr5oU9WQUE773bPftKUQFHQ3LYkl18TG/sa1jMvY4SGuo6/5CXrfWUX4e
         hQiO4AArIUjJq2Ovuz2yypTWBEzftYdMmgwNQZIXFA6fWXcFsx3IVay/P+1I3ptCoJSe
         Yclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x5jrFRtgn32THIuuycsZoyyMB823S2xuWHvAQrvHs7s=;
        b=nfWg7Qltm15pNAWAYF+f4HavYWntkNLKtCua1+UTd39i5uS8n2ItcqJuTdFGFuxciv
         /z4uVHXMXSEPFlwVhKz4+mFI1o2puvNMHYmrWMZj2eiz5LOBTGivqjpNIo27hIMxtCco
         s2VZUWfNQfpxv1iJWHdWagDYwHlZXygtJeS7JJloaDfZf0Rr28B+N8/qP0ji1KrLDSLF
         4MP4S6EDY8Kt4gGTnmrzEOasBAvFYr9SeDcYAnSaoOM9Y2u2NoXZqG8ZJ4B5LJQB0EwP
         4O93Xk6x4j2COhziva61wZtunMIuBxvkZhPOgR5j4XnfZ66bHA6csfyzuejE+qTs1+Mf
         FoxA==
X-Gm-Message-State: AOAM5324JpOBno23CuEJLNwhLEoN828dz7egqO+I9YzDOb46PRpk9vvn
        RVw3BKFg21eWOMRJxDNxDUA=
X-Google-Smtp-Source: ABdhPJwH/P++gOfHKAL+lgvvPANVEHvejS9b1EfZ7YSFOLIXLqhy6a1qgfZpZX7wrWejQaVemzT7Lg==
X-Received: by 2002:a5d:5051:: with SMTP id h17mr32436463wrt.80.1617095670064;
        Tue, 30 Mar 2021 02:14:30 -0700 (PDT)
Received: from localhost.localdomain (2a01cb0008bd2700a086f61fd085ac55.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:a086:f61f:d085:ac55])
        by smtp.gmail.com with ESMTPSA id l8sm33305840wrx.83.2021.03.30.02.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 02:14:29 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 1/4] arm64: dts: imx8mq-nitrogen: add USB OTG support
Date:   Tue, 30 Mar 2021 11:14:23 +0200
Message-Id: <20210330091426.95030-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330091426.95030-1-adrien.grassein@gmail.com>
References: <20210330091426.95030-1-adrien.grassein@gmail.com>
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

