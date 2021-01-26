Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1299304FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbhA0DiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbhAZV4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:56:11 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FADC061573;
        Tue, 26 Jan 2021 13:55:16 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j18so3709594wmi.3;
        Tue, 26 Jan 2021 13:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=thEebwIJh5TAbqy+mXWpJTbrAfE0ddYwkqXqlmzMeB0=;
        b=oeFCWWoxarlMyRwYBVKoFlAcyfp3pINXvgRSnPu4NRUgDg9yhXwhSHUwOpsVSy0l11
         e0aUUHBTKgRprSkWtlFez4O/ZUmIEnUURzza1xs1z9SWBfRlf7MkF/CcGMMnArO5ivMa
         yM1w8l9UZTp4J1hZugi3uiqjfk5Yrb4w82/6Zf0dWS7fnnujc3YOdHxSm5dgLHGOIxn+
         iImsl1nWgLSKm6lCuXmrpqbUQk1zKDIfkZsgskgb5Z9S7SAUmfmCiqRNXgzS2ss+pzcQ
         5m6bxTaxwNp5X2GxSaj7CcflIA9jNV8h6eTwISxYVryMzgVeyVRFHgyfH444mclp/LAR
         jNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=thEebwIJh5TAbqy+mXWpJTbrAfE0ddYwkqXqlmzMeB0=;
        b=imthvj+Gnw6VYl/HmZDRh3CjC+z/VzUqAH1S9qqlL7aNTIRyS0dL4u8I6Smds/sHFg
         LQTi8Wc+FTK/rKUE9pJeZ6hyDcasrChDgJjL/icszcP9jkOkcAaN0vsA84pbhwf3LUuw
         Ub8dKRclKQf5fXLmXzIfvBr/jCla8E7VquepmpkK+p79wurOv5KLhdS8Z+5j4S/qyq8h
         91bfLU4hsxfaBuhLf83020PdZeokAz/0CsbC5J92oKCKpMCvD3pA0CQYVM3ZMmkExm6V
         LsDj+rFVn7zvE/UNAE6GDN35tuaTvf1CPHj+j/09KXghqjYHstGzvCUMej9ZsDXuWGCh
         t2EA==
X-Gm-Message-State: AOAM531YjS+KW7KPDxvTJYYYWQUr9SoNigD/73LBD4q94is59jLHLI8J
        ykZ14+T5+i7njTpYDh7MFjQ=
X-Google-Smtp-Source: ABdhPJwvAZrSaNjV4BCF4LcfDpOLNuzuKTKg8DSnSqJQtKgq1kMzCwIqOeQrsfihjmJTPL1iGE2dYA==
X-Received: by 2002:a1c:98c6:: with SMTP id a189mr1438596wme.88.1611698114870;
        Tue, 26 Jan 2021 13:55:14 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd2700e5dd22906bf4cfc4.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:e5dd:2290:6bf4:cfc4])
        by smtp.gmail.com with ESMTPSA id 36sm17678wrj.97.2021.01.26.13.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 13:55:14 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     gary.bisson@boundarydevices.com, troy.kisky@boundarydevices.com,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH] arm64: dts: imx8mq-nitrogen: add USB support
Date:   Tue, 26 Jan 2021 22:55:11 +0100
Message-Id: <20210126215511.1056600-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add USB support for imx8mq-nitrogen. It consists
in 2 phys: OTG and host.

The OTG port uses a dedicated regulator for vbus.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../boot/dts/freescale/imx8mq-nitrogen.dts    | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
index 81d269296610..fb8acd83a280 100644
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
@@ -190,6 +201,25 @@ &uart2 {
 	status = "okay";
 };
 
+&usb_dwc3_0 {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb3_phy0 {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	status = "okay";
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usb3_phy1 {
+	status = "okay";
+};
+
 &usdhc1 {
 	assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
 	assigned-clock-rates = <400000000>;
@@ -339,6 +369,12 @@ MX8MQ_IOMUXC_SD2_WP_GPIO2_IO20		0x16
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
-- 
2.25.1

