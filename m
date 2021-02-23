Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E006323150
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhBWTT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbhBWTST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:18:19 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF07C06178C;
        Tue, 23 Feb 2021 11:17:00 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f137so3465553wmf.3;
        Tue, 23 Feb 2021 11:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KknQtWGUGxRZSIN2ha5Umn0+sE7b1VICaKzdAkqCFyU=;
        b=O+FoNca4hTG1UZxpYlQAfnxLTuZ+fc6TvhEdUVEschBt2Bzp9LDPFaDMbZfFzH3EhG
         3FAHGtW1dO6p6xfdiYZBD3Y4ZTsoqXNNj6MN4kABAEYuIBtylzMbKl0Yaw9HjDKczBWo
         9dCH1IgPQZl+mRMIYwEhuiODxbHzfyXU3VRmzSyaDHjUkFdpNezBxGUoxFJOdYXbdmOT
         ixX0lW+U2fVCSH1WJVGwOg/JQb9abCZUEOhcZjFoqx2UfXCrvD8tNAkkY5e/WTQGqx20
         27z3f+VMS/jr9H4XXqSebnZ47zkXeGD0DtxX48oFkdja1VCYeoDFRMaZmBJAfUNxrXF9
         66Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KknQtWGUGxRZSIN2ha5Umn0+sE7b1VICaKzdAkqCFyU=;
        b=tury2H1d3peKM2ivyu33dY3CLqym3sM2RLmfgT0V7qpu0GbONh35rd2YNJVZtR9D/K
         91mrlA6Z8VNsad3WduhdBvroqYRRdEv1vXVnkODGWztS/aLU7RHJHE5LBOuWCQZBbUXL
         b4/SyC3sOqiRPgImx4iZ04qVne5ofrNyIov/mJWNXSCDH6Q6e92oOVPiALFDBZ0rNjZP
         I6zFipReYrr3wSnubf/VbPVuUvFi0NopAfhJXYnwUv1ySuSifgFUAfF9nCVS50v4cAUc
         oSHhXEJ5s/+RR8+L4z2S/oy0WCnavbHNWa8BpFrP4IBG9RZBV2zrnxOuUlVNGN4AYL59
         w1iQ==
X-Gm-Message-State: AOAM5315MRrjc4yXZShIj0Z0yZ1Dymi+POU3UyMes75bxPPdoWLchr9c
        2ElC/5NVlE7SHmlaPAo9Tyg=
X-Google-Smtp-Source: ABdhPJwsP35fgSY5BJ9/k4cJkR6zqZhY7f87svFii5+Hw2aQ2m/NlYgxfcYf0IrtIbeg1jKVQpeozQ==
X-Received: by 2002:a05:600c:2248:: with SMTP id a8mr199991wmm.167.1614107819292;
        Tue, 23 Feb 2021 11:16:59 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd270084c09ff22cc10cb2.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:84c0:9ff2:2cc1:cb2])
        by smtp.gmail.com with ESMTPSA id a21sm3611413wmb.5.2021.02.23.11.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 11:16:59 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 05/10] arm64: dts: imx8mm-nitrogen-r2: add UARTs
Date:   Tue, 23 Feb 2021 20:16:47 +0100
Message-Id: <20210223191652.436397-5-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223191652.436397-1-adrien.grassein@gmail.com>
References: <20210223191652.436397-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description and pin muxing for UARTs.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index 0c5949b40eeb..1b16d09fa887 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -211,6 +211,14 @@ rtc@68 {
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
@@ -220,6 +228,21 @@ &uart2 {
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
@@ -361,6 +384,15 @@ MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20 0x16
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
@@ -368,6 +400,22 @@ MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX 0x140
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

