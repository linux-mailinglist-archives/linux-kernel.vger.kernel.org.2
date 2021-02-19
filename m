Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225FB31FAF3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 15:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhBSOfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 09:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhBSOcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:32:45 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07CBC06178C;
        Fri, 19 Feb 2021 06:30:40 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r21so8786085wrr.9;
        Fri, 19 Feb 2021 06:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=04jt4/0intaiLaSKslJ40tOuHE+N0R37dYPqlrpJm20=;
        b=YmUKoMc80XEM5rwO0g6UwsJFSPvousphHFIx8og2bTx44DvNFiHBvo0HzAFSEVTtdG
         S1EY14paLwlaN8EeE6zVwdfuxeGwGk82h0ItyTY5Nz9HimWNCIIVaGSphsjkZbzw4mrT
         JpU1skByz/m48lrpjJLvJKLTPbqxwTy5WIrUSoT4j+HO3jzvMK8Bwa66V2NxEKqfRa+y
         GC0lJvbL17YBJkMVf81mhLLE/NEgb6OB2AkzZmhDSVZVj/2RTWkUleJaiC21EhcSxy/0
         aF/8PXYxRyoVAFjzKhmNhi1JHQ3BmODo+PUCs8ZFN8a+G9xEqmcw2xFBne8ppB6QjnOp
         xHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=04jt4/0intaiLaSKslJ40tOuHE+N0R37dYPqlrpJm20=;
        b=kRp7VMdJsQWrBmS96n3y+hcxpgPIzZcdcsZZuOHN9/YsXlchamFi9GALkSseYutZgs
         +ybdzdwa6gy6gqXWAD93rJbLwi/giDdXE6NhQtLxMZFY5V1qmsSZRg8l2ToK8D1xA5wL
         gPVD92yEMmmPSfxayrL+AaazDi6AZFIfUcycrK53458xstg7z+9/8KtkWSO27PGTdPrR
         4ujrEOEXnopki0iwefrDrCxfb5NNI31qXV5DUOXjArcQfMmaJf+70r5sE10Jb+DVGpQy
         2sxVH842ufTG2e+OWFprDGMqRPJq18uRfJKAv/TQG+bUPAmr09NIMlQ+DZSZ5iksK0kp
         PJAQ==
X-Gm-Message-State: AOAM533MjqGQhy/8F9BFsPXxPxVoEBKbj8iinCVxytr5GyAduuyR3T40
        n+2QB2zEIOLRduSDmPhImXw=
X-Google-Smtp-Source: ABdhPJzEc5w+f30WWJZurubfRwzhZwFas/8q764Ns9bE0+Ey6v2QHEM4aOff6ROn0VNcznVFiZVt1A==
X-Received: by 2002:a05:6000:1547:: with SMTP id 7mr9492533wry.301.1613745038935;
        Fri, 19 Feb 2021 06:30:38 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27003cf54d240f3b36ef.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:3cf5:4d24:f3b:36ef])
        by smtp.gmail.com with ESMTPSA id v9sm8348215wrn.86.2021.02.19.06.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 06:30:38 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 4/9] arm64: dts: imx8mm-nitrogen-r2: add UARTs
Date:   Fri, 19 Feb 2021 15:30:23 +0100
Message-Id: <20210219143028.207975-5-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219143028.207975-1-adrien.grassein@gmail.com>
References: <20210219143028.207975-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description and pin muxing for UARTs.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index af740170569c..9ef1c4994e8c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -204,6 +204,14 @@ rtc@68 {
 	};
 };
 
+/* BT */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
 /* console */
 &uart2 {
 	pinctrl-names = "default";
@@ -213,6 +221,21 @@ &uart2 {
 	status = "okay";
 };
 
+/* J15 */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+/* J9 */
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
 /* eMMC */
 &usdhc1 {
 	bus-width = <8>;
@@ -352,6 +375,15 @@ MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20 0x16
 		>;
 	};
 
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX 0x140
+			MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX 0x140
+			MX8MM_IOMUXC_UART3_RXD_UART1_DCE_CTS_B 0x140
+			MX8MM_IOMUXC_UART3_TXD_UART1_DCE_RTS_B 0x140
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX 0x140
@@ -359,6 +391,22 @@ MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX 0x140
 		>;
 	};
 
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI1_SCLK_UART3_DCE_RX 0x140
+			MX8MM_IOMUXC_ECSPI1_MOSI_UART3_DCE_TX 0x140
+			MX8MM_IOMUXC_ECSPI1_SS0_UART3_DCE_RTS_B 0x140
+			MX8MM_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B 0x140
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART4_RXD_UART4_DCE_RX 0x140
+			MX8MM_IOMUXC_UART4_TXD_UART4_DCE_TX 0x140
+		>;
+	};
+
 	pinctrl_usbotg1: usbotg1grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO12_USB1_OTG_PWR	0x16
-- 
2.25.1

