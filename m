Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8CE31DD10
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhBQQNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbhBQQLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:11:41 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47242C06178A;
        Wed, 17 Feb 2021 08:11:00 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v14so17966213wro.7;
        Wed, 17 Feb 2021 08:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jo4VsbzP0e0XWf7NceEMzeS3lYjyhNdF97b5uZVQC00=;
        b=C5Hcj/GtVN6/Pz8Jr3r912bpx8GfvHRc3YmbZG/0mgmOXWx/50UWIl660V/4hIxu68
         41PeybW/kNo9zdIukq+dS93vB/4wkCPxlHg+3pX7bWXJZ5QnLp3jt6BpNP4djEt5Ahiw
         RTYZlaC3G+/FefYhA9qmqhiKkHjn5jnPpNPrda3PrG8yU3maNLGUMllq6CzZENze3bmI
         Yl15q1JCOUdaxHT3w3oTyViTk6OdnJkLuG5ZXokFvT34FmZBGG855pTN0+N8fj2SgpAQ
         UzTtSdKIazqACn2PVF2Kza/5xzTNMiElbAzJiJkTq0V+QTKMeJllZPvcjUB2y9r2iQBy
         +VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jo4VsbzP0e0XWf7NceEMzeS3lYjyhNdF97b5uZVQC00=;
        b=licneyLSUpI4WGxARzMXr66JgcGfitxPUbx/XooWqPGM2ufQ4mbvgqsSBSPEbIThDZ
         VrrDd00+m2yRsIY7tImP5a9GiUDbj3GEv7H3/gYxId7AzanxeR+7Zbt8nM0Kr9S/nsYE
         aZF+0lDXo0zqjQQk5Qf831IsN3GRdWFE0FagyI8F241N/+9Xwmiyj+ZizjQkKdQY6w7r
         AEByal8ba65KqGtL7cHjSLBB8c+NfszbFV9Ui853AxjdceuSYCgOFzJUosImbUobZU4T
         u9lRSH42I2jxphVQf9VasOfEZO0c0KQgQ1gmQfmWZ09169V5QILfs1Iob+IXC5vNGC5Z
         PMfw==
X-Gm-Message-State: AOAM530U+1IJg0UZiUvMVOL+azeVbuGkkMCuqma4bYRvP8LkASFAzF9u
        /CQhIdGKiBfM2WAe82VdaD4=
X-Google-Smtp-Source: ABdhPJyAK/2m+FH6dx5eFoLiiD5to8o83Xa+XLfE9x4uZbh9F+ydhQ5lp/VThn0Fe1Ghd4r85GdQFw==
X-Received: by 2002:a05:6000:1101:: with SMTP id z1mr29413wrw.110.1613578259015;
        Wed, 17 Feb 2021 08:10:59 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700605dcea117b1d0f0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:605d:cea1:17b1:d0f0])
        by smtp.gmail.com with ESMTPSA id e12sm4260260wrv.59.2021.02.17.08.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:10:58 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 4/8] arm64: dts: imx8mm-nitrogen-r2: add UARTs
Date:   Wed, 17 Feb 2021 17:10:48 +0100
Message-Id: <20210217161052.877877-5-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210217161052.877877-1-adrien.grassein@gmail.com>
References: <20210217161052.877877-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description and pin muxing for UARTs.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 50 ++++++++++++++++++-
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index c4bb22bb4e6a..8f210e21a1bd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -205,12 +205,33 @@ rtc@68 {
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
 	pinctrl-0 = <&pinctrl_uart2>;
-	assigned-clocks = <&clk IMX8MM_CLK_UART2>;
-	assigned-clock-parents = <&clk IMX8MM_CLK_24M>;
+	status = "okay";
+};
+
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
 	status = "okay";
 };
 
@@ -353,6 +374,15 @@ MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20 0x16
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
@@ -360,6 +390,22 @@ MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX 0x140
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

