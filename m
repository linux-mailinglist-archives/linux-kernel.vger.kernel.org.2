Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A472231C45C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 00:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhBOXXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 18:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhBOXVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 18:21:15 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93326C06178C;
        Mon, 15 Feb 2021 15:19:57 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id g6so10974487wrs.11;
        Mon, 15 Feb 2021 15:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UA2ukqRZDvOIUXQ3fWNlJTOD6E3mKj4svJiks0IkF+0=;
        b=KSoRRQWhCyel5eo0ELGv/XgzG/IanIAF2kyBUILePzw382BoPT5MSEwjhmtH04LU95
         Efjhgv1yZC25Da2AzZJ0eFaaH0jeyDfoidKOsJmMrwA6hCNpt3ud71cdAVUJjJxjqZgB
         2xyAOogiSCSROVj6LfrNEHOgHHmEqgPujl+U+FjyJ2vxvsW6ksjs67pLz911sn93KJoa
         XbRLDI8soqHInaxLxMnvevGZI6efvMBS1VaBenxT4OJc0Oa4y29ez0mkYDlNNDA0MxjS
         e0LoFm5gl5+2xsGHBvhwV4ksHO7wDGBTcGyeleZiJlIqlUpygu0tWJILy+c08NDPxY9j
         z0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UA2ukqRZDvOIUXQ3fWNlJTOD6E3mKj4svJiks0IkF+0=;
        b=lNU89lru+jQ9YqF8Puy88O8ZbfsqkxI9DJYEeEQ7SNETdeU6QElmeFggKwJbxUlLVL
         hUywV5wljKcMrlJgfJ2zDwPTljFAbLLl77AI5y9ji8rloZbXVRMfTpGY4wGPOT5KGdVB
         EyNjxehFpirCQen80W0HhLjjsS9UGPhsV/WX7p2wTS+jEJzXKhYKVfzq8vm/YCEVIRW0
         2NKR2SFoxjD1CvZVM2OxavRPd/cubgvdEYubKPH7tso4aye6/7pfONmhBhPmaToG89ND
         PnRxErsD8EJA5yYsPoUw26TaQqofWDLKMbNPY1PDmpyoI1izSTBmo3ltoPT62JhswsEZ
         KipQ==
X-Gm-Message-State: AOAM531/d8ZyFLupu/tE9tk04yIAJY/g7MbnCfg976Upuc8ntsN6HQQY
        q6Krcugp4XU1fF50DLJKxIc=
X-Google-Smtp-Source: ABdhPJxsQV5H87wrBsGPkvGiihFqZdtFTLznsYl6DctvwQtqQkVLbXq+ZbvJq6OeC7RwGcy0onn3+Q==
X-Received: by 2002:a5d:448c:: with SMTP id j12mr14006867wrq.63.1613431196391;
        Mon, 15 Feb 2021 15:19:56 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd27008c8ad15d1b12a6b4.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:8c8a:d15d:1b12:a6b4])
        by smtp.gmail.com with ESMTPSA id f5sm963158wmf.15.2021.02.15.15.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 15:19:56 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 7/8] arm64: dts: imx8mm-nitrogen-r2: add sai
Date:   Tue, 16 Feb 2021 00:19:42 +0100
Message-Id: <20210215231943.36910-8-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215231943.36910-1-adrien.grassein@gmail.com>
References: <20210215231943.36910-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SAI description and pinmuxing.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index 5ba3c8ef7706..6c77d50d9e5d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -29,6 +29,29 @@ reg_wlan_vmmc: regulator-wlan-vmmc {
 		enable-active-high;
 		startup-delay-us = <70000>;
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
+		codec-master;
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
@@ -212,6 +235,22 @@ rtc@68 {
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
@@ -239,6 +278,18 @@ &pwm4 {
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
@@ -411,6 +462,13 @@ MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA 0x400001c3
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
@@ -447,6 +505,34 @@ MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20 0x16
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

