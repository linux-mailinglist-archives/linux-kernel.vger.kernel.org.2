Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96A1350AAF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 01:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhCaXYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 19:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhCaXYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 19:24:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB03DC06175F;
        Wed, 31 Mar 2021 16:24:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so1912176wmd.4;
        Wed, 31 Mar 2021 16:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x5jrFRtgn32THIuuycsZoyyMB823S2xuWHvAQrvHs7s=;
        b=kBqM0GgCmvA+QCM8bdjMTNvvgjR/j6gu+HF0FPRL6UruCU9tL8tJ6G36/RRQuZubja
         NlQkaE8SIm4RdIZLOxkcR/QiYV3UsJq4klxN68/4OWQ35HVAiNBYj0uhD6Lmf08PJwGP
         5dKpNAog3G/ag8DP4HWlfukOVyzXHuU07pemD7trblg7M2bY+hZaM/uxtL878IPO7PQR
         p0IYUfDdUicCtpoogoFh1g/ZExxGuHeuLoefrxVUTzHm3IHn7Stt4hOICE0zJAei6C/z
         spwXo7PqpexeVoUonwkODzmJOe06P3hyEjoncGsZjY4Bx+gGCdnejSlxg59uvkj2ruL1
         zUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x5jrFRtgn32THIuuycsZoyyMB823S2xuWHvAQrvHs7s=;
        b=LFEPPh0DtcpmPr7k67eyk3VnE2Xwoz5FmYRmjIadvtCDSj6VU7VhpdicI52h8uJIaX
         z4Na3mX+axtPeClI6Saul3cU/GVlzkzOCLAM9CZUYLeI0SXrO7lYdS2Rba+EldjIN7C5
         E0DdzLQrczI/E8f8caJEVZFz2dLvo+9PqEKqUmCCO30r246nADxP2gXRfE7Wjd0xtr7H
         zv3EYZZ8Ybj8hTzqxldvBduOv0g3RABMC9ka0HngHKi7I5ScQi9EsL83a0/C4Q51SM8Q
         RuecaC4IctfUQTT2Vf1WgbdzZ9V4u/NTYlIsKkWq6elsYClSnwx0EE17pIY/6JWRbEXv
         c1cA==
X-Gm-Message-State: AOAM530xTdj8HKLnIXs+huX6fUsTe39PUYOOSm/NpuuB+5g08wAnxJ3M
        UPNlimMHQHF/zF/APfJwvkM=
X-Google-Smtp-Source: ABdhPJwQhj3nQ+qHTGCgbNPI/B1XMjsTQlzZkr/dXM/N0Jo4egwKboH/RrJhnKu4itiGbcse8l9dUw==
X-Received: by 2002:a05:600c:2109:: with SMTP id u9mr5213840wml.44.1617233039580;
        Wed, 31 Mar 2021 16:23:59 -0700 (PDT)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd27007d57ea0d08d946c1.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:7d57:ea0d:8d9:46c1])
        by smtp.gmail.com with ESMTPSA id t14sm6343041wru.64.2021.03.31.16.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 16:23:59 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 1/4] arm64: dts: imx8mq-nitrogen: add USB OTG support
Date:   Thu,  1 Apr 2021 01:23:53 +0200
Message-Id: <20210331232356.2204476-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331232356.2204476-1-adrien.grassein@gmail.com>
References: <20210331232356.2204476-1-adrien.grassein@gmail.com>
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

