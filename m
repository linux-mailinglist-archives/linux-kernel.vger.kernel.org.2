Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9310934E33C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhC3Ifu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhC3IfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:35:22 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1616AC061764;
        Tue, 30 Mar 2021 01:35:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c8so15345296wrq.11;
        Tue, 30 Mar 2021 01:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x5jrFRtgn32THIuuycsZoyyMB823S2xuWHvAQrvHs7s=;
        b=qgautln4jKlR8WBO221jqNvixSDqSmkVX5fd5zvLtnDZAJBjP5LE5TMBnGUrOsC/mZ
         UszbgiTpjM7FZkR4LZXmp/ewVJK1MwuURww07Vc34ictYba2Mdk/Bj/T89ICJ3hWn4BX
         ksnnNiCoaWH2i7pVPEDA055Rhq7gd86KlLsC0q6fyZsDzgDmT+4O/cGRaXFuALEUUz0L
         6pjK1g1EzeNeJmhc2sS0cCeN7fEeUG5YzQEMxCMP5SHhVYNkCErSYVlEbwt5xkggwFzY
         5rgoF1pR24lRewsq0XAROHjzAwZF+RnsfmpJiTaO+zlBrdZYkFKwAz1sWEDIRDFw7gJ3
         k2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x5jrFRtgn32THIuuycsZoyyMB823S2xuWHvAQrvHs7s=;
        b=fpzc6xykLCZKjpOUfoNbxKYeSzP8uDH8EGhJHdQhb1uUKWNS1nrWY/1aoP6onrKKe3
         fwxmSDQSgQ8ZeuoLn7F5T/jWOqa7Vp6cNjoh/uJLmXYEvqxHqD9XMHdb0x1ZKrVO7OoV
         HQYy+Mkd5wQofo6jppzjsRfHkIW0Ub6skcEmTyNyMxm5bthF1mzYTEUrXJJYTMIfklsR
         AqSvj9um96qi2QWsOkW2z23kZn5uk8xmN+zAGx+XmekdxF20utODKjARFErU91m5QCxv
         6cLJd4DAZMHVjW6A1uX+C4jVk5E9vC3ZnLkyldKVUPEDAbZVywi9Ze9oSqfqJBhCFoDG
         bRmA==
X-Gm-Message-State: AOAM533UcCdaH5O1sUMjJheQAStncfCsS0835vprO8B6v6eCyItYMIKo
        +kOd9bB1L8L6YRFi7nomsso=
X-Google-Smtp-Source: ABdhPJxW8eMB99mjPwu56FLDXS+sl0Z7qoi+5k4CR84r7e3QN/blmiLp2k7bGm0ISoBQR6DTKulOEQ==
X-Received: by 2002:a05:6000:10d:: with SMTP id o13mr1665249wrx.106.1617093320755;
        Tue, 30 Mar 2021 01:35:20 -0700 (PDT)
Received: from localhost.localdomain (2a01cb0008bd2700a086f61fd085ac55.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:a086:f61f:d085:ac55])
        by smtp.gmail.com with ESMTPSA id g9sm32830263wrp.14.2021.03.30.01.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 01:35:20 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v1 1/4] arm64: dts: imx8mq-nitrogen: add USB OTG support
Date:   Tue, 30 Mar 2021 10:35:11 +0200
Message-Id: <20210330083514.5874-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330083514.5874-1-adrien.grassein@gmail.com>
References: <20210330083514.5874-1-adrien.grassein@gmail.com>
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

