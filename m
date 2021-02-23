Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F956323157
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbhBWTV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhBWTSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:18:20 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB61EC0617A7;
        Tue, 23 Feb 2021 11:17:02 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id n4so23739978wrx.1;
        Tue, 23 Feb 2021 11:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=poyP0J703OBa/L+sKd17+zL/WYULA/m6tHtP1PSkj6k=;
        b=W1eIIxnK8V/+VRPTjZKgBCxR+Pg/b627epeVN8tt77JXO5xYKvbamQfVCgqKV8fHxE
         rsDqSBi2cIXxKrccpk6Izmd5rDWk5H2CTUJ4ZnWnMgDhc8BFCHR7yV6QIMLPzmUhRRmy
         Y1cr+WPLj2EKv+pOyGKwkCxIFs+uifRuA61Xjue0hfhag5F5yPwOjKOpr2WgVuDjTOgZ
         Bh3h9vT4QiB1dFu37pqOH8creWLwrszauzZCvplpyfK9Q//CZSkcvSqesMSYyZTDxREJ
         rE6d+lVTTtCwY+FSLFgdAqg+dRYozjLi20R4oVtxtR1ptFTZiOANRzFG/PU99WjEOQ37
         /ASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=poyP0J703OBa/L+sKd17+zL/WYULA/m6tHtP1PSkj6k=;
        b=C+KR4Y1OQkJapvSbzNKC8RCktK2sgxepmEkzkcQRUi+13J4hiuTwzVWYxTkG4iXp3e
         D029+iQnempfv8EIr1O2Jj/qtOBw0woRz9MN4CQSf3eYMZxbznOAaImt+efjhQtiZaFQ
         D9fJwttVgm40s5iljwy1tJVqe8k3BDiRvfe+4RPwbgL8t7Ix4Bb23pcSq+5UwFYAdhQc
         KC+C4tfhCeX/uRct//W1/QyGf0zxxEgyzruKR0ahC89Y3iyeu+e+Y7Oe/6kBi9fTWjA4
         A34QCPuMlz9f3fVxlKFZvAGQoXjVBwdmpmC16pglopKfYOjRItNCvX0khCp0TtNJmO7o
         KzQQ==
X-Gm-Message-State: AOAM531uUp4huG9sJLAUKCV3fvJwVQecmP00BUII0J2NP5tqUAxiLkP6
        OFCg1MKprwPDzy2WqsWY6w0=
X-Google-Smtp-Source: ABdhPJymFFfwmgO0TOV4srkKMvHnRAKmvpcLFFhhlsTweT6TgSaxVx3itPVBTvfTRrDxi43F8zqZ6A==
X-Received: by 2002:a5d:4a0e:: with SMTP id m14mr1072251wrq.73.1614107821743;
        Tue, 23 Feb 2021 11:17:01 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd270084c09ff22cc10cb2.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:84c0:9ff2:2cc1:cb2])
        by smtp.gmail.com with ESMTPSA id a21sm3611413wmb.5.2021.02.23.11.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 11:17:01 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 09/10] arm64: dts: imx8mm-nitrogen-r2: add audio
Date:   Tue, 23 Feb 2021 20:16:51 +0100
Message-Id: <20210223191652.436397-9-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223191652.436397-1-adrien.grassein@gmail.com>
References: <20210223191652.436397-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audio description and pin muxing.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index c13788e6c0d9..b6775f832907 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -34,6 +34,28 @@ reg_wlan_vmmc: regulator-wlan-vmmc {
 		gpio = <&gpio3 20 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	sound-wm8960 {
+		audio-cpu = <&sai1>;
+		audio-codec = <&wm8960>;
+		audio-routing =
+			"Headphone Jack", "HP_L",
+			"Headphone Jack", "HP_R",
+			"Ext Spk", "SPK_LP",
+			"Ext Spk", "SPK_LN",
+			"Ext Spk", "SPK_RP",
+			"Ext Spk", "SPK_RN",
+			"RINPUT1", "Mic Jack",
+			"Mic Jack", "MICB";
+		compatible = "fsl,imx-audio-wm8960";
+		/* JD2: hp detect high for headphone*/
+		hp-det-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
+		/* Jack is not stuffed */
+		mic-det-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+		model = "wm8960-audio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sound_wm8960>;
+	};
 };
 
 &A53_0 {
@@ -217,6 +239,22 @@ rtc@68 {
 	};
 };
 
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	wm8960: codec@1a {
+		compatible = "wlf,wm8960";
+		reg = <0x1a>;
+		clocks = <&clk IMX8MM_CLK_SAI1_ROOT>;
+		clock-names = "mclk1";
+		wlf,shared-lrclk;
+		#sound-dai-cells = <0>;
+	};
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
@@ -244,6 +282,18 @@ &pwm4 {
 	status = "okay";
 };
 
+&sai1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	status = "okay";
+};
+
+&sai2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+	status = "okay";
+};
+
 /* BT */
 &uart1 {
 	pinctrl-names = "default";
@@ -414,6 +464,13 @@ MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA 0x400001c3
 		>;
 	};
 
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL 0x400001c3
+			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA 0x400001c3
+		>;
+	};
+
 	pinctrl_i2c3a_rv4162: i2c3a-rv4162grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22 0x1c0
@@ -450,6 +507,34 @@ MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20 0x16
 		>;
 	};
 
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			/* wm8960 */
+			MX8MM_IOMUXC_SAI1_MCLK_SAI1_MCLK	0xd6
+			MX8MM_IOMUXC_SAI1_TXFS_SAI1_TX_SYNC	0xd6
+			MX8MM_IOMUXC_SAI1_TXC_SAI1_TX_BCLK	0xd6
+			MX8MM_IOMUXC_SAI1_TXD0_SAI1_TX_DATA0	0xd6
+			MX8MM_IOMUXC_SAI1_RXD0_SAI1_RX_DATA0	0xd6
+		>;
+	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			/* Bluetooth PCM */
+			MX8MM_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC	0xd6
+			MX8MM_IOMUXC_SAI2_TXC_SAI2_TX_BCLK	0xd6
+			MX8MM_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0	0xd6
+			MX8MM_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0	0xd6
+		>;
+	};
+
+	pinctrl_sound_wm8960: sound-wm8960grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10	0x80
+			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28	0x80
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX 0x140
-- 
2.25.1

