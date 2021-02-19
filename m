Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6879F31FAE8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 15:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhBSOd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 09:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhBSObS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:31:18 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D67C061786;
        Fri, 19 Feb 2021 06:30:38 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o24so7813279wmh.5;
        Fri, 19 Feb 2021 06:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x2ooXDb60QzvXUrPq//dOW0oVIAt3M11F1De29wx8iw=;
        b=krOa7CCRuYs9avkL5jO9S6Vl972SsJ8DvEeg0tllXkhB8DTF0kW+0QUMRhV5mYw1Pd
         l43OT8qwCqMH5ZoD2gyRhDt8P5NYbYgeEbwnW6pGUI61ScwXFfTQzaNQrPFH1zGhZCAF
         1J7VtkBtDAEpxP9Sq47jQLuBuvZ4EAwD1foa64V0ZfDGOT+vAiC5OenIyBAbLBdVov4t
         MJlOImawTxc747WXM6L42tJe2fbxIsvA+BEpnCSggb6xstBgK+A9VN5krEEEgudPRcPV
         Z4PCSa+PiJHv4iXvgA9VvQLtFtUXdKhI5J+ahgIetO/LozLk9rhW987AdvluVfyzgR6n
         onQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x2ooXDb60QzvXUrPq//dOW0oVIAt3M11F1De29wx8iw=;
        b=NDx1fMFnfB1+Ya2h/XMGd6+94anztbUYaKdPb6hQ0y53DGaN9+TZqyp8uVcpKuItU+
         VE21Jl9JJzu6yi3D/AfZNlcJUBbbpLOmScOUsEd//N/Wj1Te00sOcEt81EN+iKHxjXRk
         aYo6+WZLLR0AdtWsoLInqYLMFPYq8wb5Sp+1yr2ro2tZVGsQT5gzeXudFu3Nukv/1iMN
         3QLQOSuj096BG50qeJ44NRigkivQHvXNDIIrCVCq6E5cXpRTZ/Xqs9L894Om6mIvaeOD
         bY8dcN6QkBZLNcXTJtcnt0BW/EGpFnR8pWnPDRhz/T04D68RmHRHyhtEjcxuknAs+Pm2
         0j4Q==
X-Gm-Message-State: AOAM532VaJ6rZqO2MLUSTqXuiGjsocwx2w6gdaf11hb3CpLT2lQCw3gw
        nGvQjCOu+4aNm25gsEuf7kc=
X-Google-Smtp-Source: ABdhPJye/9Jcd1krds8cLtEOortj6SMBnPYXmtYkWpQr1KAHdAWXyKgpIaQVB51fu81o2NVtUrBx8A==
X-Received: by 2002:a1c:5686:: with SMTP id k128mr8532166wmb.189.1613745036827;
        Fri, 19 Feb 2021 06:30:36 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27003cf54d240f3b36ef.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:3cf5:4d24:f3b:36ef])
        by smtp.gmail.com with ESMTPSA id v9sm8348215wrn.86.2021.02.19.06.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 06:30:36 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 1/9] arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
Date:   Fri, 19 Feb 2021 15:30:20 +0100
Message-Id: <20210219143028.207975-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219143028.207975-1-adrien.grassein@gmail.com>
References: <20210219143028.207975-1-adrien.grassein@gmail.com>
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

