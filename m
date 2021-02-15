Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9771A31C44A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 00:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhBOXVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 18:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhBOXUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 18:20:36 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7FCC061788;
        Mon, 15 Feb 2021 15:19:55 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v7so10963805wrr.12;
        Mon, 15 Feb 2021 15:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zQGO2TPddJB0NGq7T6gPJP8YOzjXwOoJJM9lSCvl+ms=;
        b=GIHZvRLMtV9JZY/0O1L5QNe3PS/14hiFRQWkXTvd1EejIqp8G6w5EBE74dSXbRcvIC
         dQ1sN+lJCo4U9K30KI2sfrxxbYB4M4OUDg4+4BEiU1tE/kXolWGQFaFCqeoKDRPcf7aH
         +mWi49i3MqiPghsRM2hzv48WEYmRWEhzWzk/53y8jCktT6tHos3ThwtZSRlgBzX7TO/E
         jDF0fobLIa5LemOmSGdMHxgSdBsBluYyCn5OqFwXqx3yUvEy/IqfZ0lmXaqDVUWzl/KP
         LoTCruj2SdrXKDPqEaTXhCr15N01gpH1BQC9CSwSH7qhgMapARZ3cNruGr4/s7/oQwe9
         lb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zQGO2TPddJB0NGq7T6gPJP8YOzjXwOoJJM9lSCvl+ms=;
        b=LpqAjQtP1hCbS2sJWKdqJczbFdbvFAd3q6bi342mylc5hWDwDF7dhYMVFmZlnmbaR9
         XNNlHb3FA46SiGVNXRerApwfnxgijEoN8qdEcn5Z49fyJApD+aOLZQEvMIDmk9XwQOZs
         bjcBMukj4nDuo4zqT9eLy7b+xWkaiCgLQ+lH6zgFcOKAVZeu4Thc4TPPA1C6nW6szxVe
         q0iYX0Eb2CBBE/aho4+cBrS3khrCX/0XPjX0HhCNYNSEj83ZlePpGbAAsoORHpS0YtPG
         eQVTdUqXPd/IbJuPUBzrPWDe8bi/CfiTarC+sLKVVfhbQMLVSIwaxofAF1kgJgis5XJJ
         TXIw==
X-Gm-Message-State: AOAM533fjihTkZf7LGYrgw3RZn33V4qgEmdA9TSnr9wShy9vWAspbR81
        9SCGcn9bc8VfjiRI+m8XufY=
X-Google-Smtp-Source: ABdhPJwxkB/oNQOIPsiguZuktonfR/6SNdb1I0BgSgahFBJC43TGhG4gwWLtNAW0MvclTuAhpLF1Fw==
X-Received: by 2002:a5d:4c8c:: with SMTP id z12mr11474040wrs.176.1613431194529;
        Mon, 15 Feb 2021 15:19:54 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd27008c8ad15d1b12a6b4.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:8c8a:d15d:1b12:a6b4])
        by smtp.gmail.com with ESMTPSA id f5sm963158wmf.15.2021.02.15.15.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 15:19:54 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 4/8] arm64: dts: imx8mm-nitrogen-r2: add uarts
Date:   Tue, 16 Feb 2021 00:19:39 +0100
Message-Id: <20210215231943.36910-5-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215231943.36910-1-adrien.grassein@gmail.com>
References: <20210215231943.36910-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description and pinmuxing for uarts.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 53 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index 22acde0f3ba8..3c5b692f6ad1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -206,6 +206,15 @@ rtc@68 {
 	};
 };
 
+/* BT */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	assigned-clocks = <&clk IMX8MM_CLK_UART1>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
 /* console */
 &uart2 {
 	pinctrl-names = "default";
@@ -215,6 +224,23 @@ &uart2 {
 	status = "okay";
 };
 
+/* J15 */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	assigned-clocks = <&clk IMX8MM_CLK_UART3>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+/* J9 */
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	assigned-clocks = <&clk IMX8MM_CLK_UART4>;
+	status = "okay";
+};
+
 /* eMMC */
 &usdhc1 {
 	bus-width = <8>;
@@ -353,6 +379,15 @@ MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20 0x16
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
@@ -360,6 +395,22 @@ MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX 0x140
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
@@ -370,7 +421,7 @@ MX8MM_IOMUXC_GPIO1_IO13_USB1_OTG_OC	0x156
 	pinctrl_usbotg2: usbotg2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO14_USB2_OTG_PWR	0x16
-			MX8MM_IOMUXC_GPIO1_IO15_USB2_OTG_OC	0x156
+			MX8MM_IOMUXC_GPIO1_IO15_USB2_OTG_OC	0x15
 		>;
 	};
 
-- 
2.25.1

