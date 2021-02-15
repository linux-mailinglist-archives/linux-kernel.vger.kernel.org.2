Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E34D31C453
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 00:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBOXV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 18:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhBOXVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 18:21:13 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1B2C06178A;
        Mon, 15 Feb 2021 15:19:56 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u14so11027549wri.3;
        Mon, 15 Feb 2021 15:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A1T9AE55ZxHAbAZGEngDPriRKSyy8ugqua1zU1484bg=;
        b=e7VWAw5Qtjyc1Da/6ElgkepOtWvRIlS85fhQrJFmwD/lPSJ8gEDDAPHuepFhm5Cmn4
         DOkezDJXxu06LbtzzblppR30Dn/926hKutevaQ9GYQiZ1vtp7pYiEx3bv0N6/TNjK7ju
         4IsK6T8ZoqNrN9mR6ZDxTxNlpLjasRzISu2GECjpk96Y+Jl7NBSHXrVjYJfNWpSw4hkC
         bPR45/SxFjugJa/ifKgYkUPvR6V4xs7kDndIkVTYitx9ZzjViszro50L+cDqEbgTwSoM
         k1/U/Xemkle6Ur7gdH5+hC8gDOVZDx2jrPU6XiG856rcbcvIb5P4X2xZmumheNKpv9ym
         rVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A1T9AE55ZxHAbAZGEngDPriRKSyy8ugqua1zU1484bg=;
        b=TNL6b8zhs0UmoS8FLFkzNazyn8vcHtLrb5eyPCMNofab1zNqwggATVfktJFa2jfECF
         VYx9YIusrCy1gJ6BGuIQ1zjfp2YgwjN5GfWS2t5Tyz2SXkAH6JtmclgjbdTtgBtsUqkY
         sAFhtvBLT/BJjmZ/jHaNooSVFV3SOWE+AP9Y2DMQVAhtetIRjbJbI91+8D316ECF/TtO
         oQHM0CiRgU41w3u1YunuT0A07tsAXYcU9DwJTQhK6AShIpP2tAIFRCHFeJpsVXv+eVqJ
         l4WVNvDKid8PrUlPbLngJc2HzWbRfkD3KtI4UjJE8u8waY+31qe0KlWZP31dM0rtTiFZ
         sfPg==
X-Gm-Message-State: AOAM531Q+8e6hEjuiN4Fefjiacz6AggG11Gzxc1KT5mE1Oinug/Q4Qfk
        dj+ZvoVHdVTMT56T2kK1JNqlSTfxQenpBg==
X-Google-Smtp-Source: ABdhPJzWD7eLrkqValDP/PdQbqZNc/3kkYgBDIlBR9lzeoFJqppXM9Vb4IADcU8Qfh8sTDMISsfCXg==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr6773440wrw.124.1613431195194;
        Mon, 15 Feb 2021 15:19:55 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd27008c8ad15d1b12a6b4.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:8c8a:d15d:1b12:a6b4])
        by smtp.gmail.com with ESMTPSA id f5sm963158wmf.15.2021.02.15.15.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 15:19:54 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 5/8] arm64: dts: imx8mm-nitrogen-r2: add pwms
Date:   Tue, 16 Feb 2021 00:19:40 +0100
Message-Id: <20210215231943.36910-6-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215231943.36910-1-adrien.grassein@gmail.com>
References: <20210215231943.36910-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for the four pwms.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index 3c5b692f6ad1..eafdf39e1f39 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -206,6 +206,33 @@ rtc@68 {
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
@@ -373,6 +400,30 @@ MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22 0x1c0
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

