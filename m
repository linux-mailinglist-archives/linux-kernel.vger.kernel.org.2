Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7266531DD0D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhBQQMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbhBQQLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:11:41 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28CFC06178B;
        Wed, 17 Feb 2021 08:11:00 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o15so2553042wmq.5;
        Wed, 17 Feb 2021 08:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AfGgajJlbquPHo2r+bu/G+yFio/773IJq6+DllQZo4Q=;
        b=Ncpcef/Ud+VYl8kx+VXmqpK2XX6gJ02PmsKFsu3XWYPsmoQxsyUrWCCkLumRiDAb34
         eeNf5lFxyio+6XAGWLKf1ujygSPoBPuMofGg62/+MDqXc8siIBUsZ2T2ukndMm0pW0ou
         xpAEHWiSKGKZYZAKPvcIgIYr7SiBYY93wxeXvVS5n9bmQoZWlZzPB666keeY9Vo60GYo
         HDduftLW3VLgLil6jcbmGcKmcOJesPEnNrXjtJLWDbJNf4AZ03I6Mu/e1dArdKgc2PqR
         OanITahMOISEmT7Tx87LUYe2JFm2YG8ajUOh9+spcIiNOUDvqcBbUzALjGqPkcjXW/hv
         AUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AfGgajJlbquPHo2r+bu/G+yFio/773IJq6+DllQZo4Q=;
        b=PHeZDoqOkX89jo0LNM/XnoZSxPZXTABykvDm6gHgxXGoSB66V69MueELKL01rttk6u
         iPyHyhQXiAnU5iMS2yUZduxhjJZnIkvLt7aQwFypQ7ipiglYYTGaUkCJPFTJhxAW8Efs
         5BWSCiTAGEfkW3mDqBPAxzVdxkd6lxbMKjYQJiEgw+966srBNcKQdp7a70ccDNlzyoQa
         bLGWCrkd3IbYwZy+27BNjDijB4MgVzfxFmkI2Fvm37hiC5iWTbKj2h0l+YnIlTtUnjZR
         S2W6nIVATuavdMPQQUv79ZA7dTLNLlBnBhW1q9GtSecOeJrhWFDf1MPfSWf+zXK/i9iZ
         +wAw==
X-Gm-Message-State: AOAM530aM2QN0Iq17E0xi7lYOBBGdQoNOsUWaH1QBY/L39Ks9A39F0i2
        9rIzBo3XBFEzHXpB179EVO8=
X-Google-Smtp-Source: ABdhPJx3IQAmn6Od+Z18LK24IUBDqJvNDDcJ5kwX5q6ixwOgvMw9Xw9pfVtCIWNx995Kuw5KBSyKJQ==
X-Received: by 2002:a1c:bcc3:: with SMTP id m186mr7608730wmf.165.1613578259586;
        Wed, 17 Feb 2021 08:10:59 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700605dcea117b1d0f0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:605d:cea1:17b1:d0f0])
        by smtp.gmail.com with ESMTPSA id e12sm4260260wrv.59.2021.02.17.08.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:10:59 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 5/8] arm64: dts: imx8mm-nitrogen-r2: add PWMs
Date:   Wed, 17 Feb 2021 17:10:49 +0100
Message-Id: <20210217161052.877877-6-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210217161052.877877-1-adrien.grassein@gmail.com>
References: <20210217161052.877877-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for the four PWMs.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index 8f210e21a1bd..35213f3abecc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -205,6 +205,33 @@ rtc@68 {
 	};
 };
 
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&pwm2 {
+	assigned-clocks = <&clk IMX8MM_CLK_PWM2>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_40M>;
+	assigned-clock-rates = <40000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+	status = "okay";
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "okay";
+};
+
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+	status = "okay";
+};
+
 /* BT */
 &uart1 {
 	pinctrl-names = "default";
@@ -368,6 +395,30 @@ MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22 0x1c0
 		>;
 	};
 
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_EXT_CLK_PWM1_OUT 0x16
+		>;
+	};
+
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT 0x16
+		>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_TX_PWM3_OUT 0x16
+		>;
+	};
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_MCLK_PWM4_OUT 0x16
+		>;
+	};
+
 	pinctrl_reg_wlan_vmmc: reg-wlan-vmmcgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20 0x16
-- 
2.25.1

