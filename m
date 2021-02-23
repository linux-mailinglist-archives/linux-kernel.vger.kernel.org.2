Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61905323140
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhBWTR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhBWTRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:17:39 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58BEC06174A;
        Tue, 23 Feb 2021 11:16:58 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id v21so3481277wml.4;
        Tue, 23 Feb 2021 11:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x2ooXDb60QzvXUrPq//dOW0oVIAt3M11F1De29wx8iw=;
        b=ZcYB31rMPnORSXJmJFj4IGyw9heJo6GI9OBXP4F6K8uQqoMSUItHhr2OANULwvyMJq
         rh6Fc7XbzKxQUON5S8N0iZaSWgjMY3N2pSIyi7RevEz6p4LM/xtR9hCfNiYuPV5+KcSX
         BNNOl9eXk6Qgyg42S+7Pa10t74S2uF/2ZGA4BSHNRBFp2FN7rZiyv7av6Dr8DNoenQ3f
         +yh2tqXtbe5ohKT2M63Q3D+Ecm5DRKsWbMbhFdSLe0vqrhwIEbftK99HRuGvNZCgJMwx
         Ao77t36a+zCnJMeRh6HqTJOEV911lRuCQYW0PP9rNb9K/j0G6VRQdPboI2xWRvRWwXO/
         Z49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x2ooXDb60QzvXUrPq//dOW0oVIAt3M11F1De29wx8iw=;
        b=pwdVCDWBGQYyK4RBNRRpwowNL8sGiHp/rPv1B2elhptp8dAXS61pyJtlvIx3lluhWO
         vwLI/YFBQbRLLdyAsKuxKF4Oj6ez/Q1wuAG9t9UALJckdeojQQ+tCMA7YeSf5ix4u4x1
         AoqEBW5+ADZzXoDB+PArrhfhicuA3ZCCnkK1jGvp3aoslhwX+yArFJGeVQqyxqdfO4g+
         FeitDorElZeJ5QvGoz+hFNqPPwE1Zqr2W4Ufo7IYZlPJwgGeZQ01hea5uVJbVBZDf2df
         4yyq90tQUmLAzAVR5OftXNMRAT1bt80XcWjb+15MCvVq1NtaY+8v8HLR7p1dqvWjG1Fb
         jVOA==
X-Gm-Message-State: AOAM5305v4AGlsrjg5HIw6ecDXEIFCpCUUtWdMOjmxFI0Eud3BEV6zCv
        B9vgxJzJy9L1UKkG/oV0yH4=
X-Google-Smtp-Source: ABdhPJwTjrrAlAxwg4os4Lz0rKdbj17c+56udlUW1+MDsy7nnBpnndxl2PRQMfzYQOiQub075q2Gkg==
X-Received: by 2002:a7b:c7c6:: with SMTP id z6mr267807wmk.50.1614107817409;
        Tue, 23 Feb 2021 11:16:57 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd270084c09ff22cc10cb2.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:84c0:9ff2:2cc1:cb2])
        by smtp.gmail.com with ESMTPSA id a21sm3611413wmb.5.2021.02.23.11.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 11:16:57 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 01/10] arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
Date:   Tue, 23 Feb 2021 20:16:44 +0100
Message-Id: <20210223191652.436397-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223191652.436397-1-adrien.grassein@gmail.com>
References: <20210223191652.436397-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usdhc3 description which corresponds to the wifi/bt chip

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index c0c384d76147..4a3dabeb8c85 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -9,6 +9,24 @@
 / {
 	model = "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
 	compatible = "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm";
+
+	reg_vref_1v8: regulator-vref-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vref-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_wlan_vmmc: regulator-wlan-vmmc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_wlan_vmmc>;
+		regulator-name = "reg_wlan_vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 20 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &A53_0 {
@@ -206,6 +224,20 @@ &usdhc2 {
 	status = "okay";
 };
 
+/* wlan */
+&usdhc3 {
+	bus-width = <4>;
+	sdhci-caps-mask = <0x2 0x0>;
+	non-removable;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	vmmc-supply = <&reg_wlan_vmmc>;
+	vqmmc-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
 &wdog1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_wdog>;
@@ -264,6 +296,12 @@ MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22 0x1c0
 		>;
 	};
 
+	pinctrl_reg_wlan_vmmc: reg-wlan-vmmcgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20 0x16
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX 0x140
-- 
2.25.1

