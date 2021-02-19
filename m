Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB9C31FB00
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 15:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhBSOgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 09:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhBSOdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:33:33 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF45C061797;
        Fri, 19 Feb 2021 06:30:42 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id f7so7645966wrt.12;
        Fri, 19 Feb 2021 06:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oR8ZY3nztvYVqBilVl0U3ZkANai8Igyf3opAC1nc1Gg=;
        b=LcVwRlFIUWsqehZsbUV3dMi85RbIiCmzEJ8sHsPq/vgdhdqrWYay1BZdf8sGDlfhJx
         mgzCkScVzyXrV+moMXTzPZ0wlXQt9LwleoWPDOHmiwJ10sEj3zkdYBT3/5Qzmf3hUd7j
         qEjSOJy64CoL67kOn4z5VCYaUGTJeAnq9+nfQScGn+RJHaRuRTe5ZY/vKt5NkMFptb1o
         TmWAkYMTKdCrXptUHkuxi6X2Cp1Z3ZK/wPLvTcedI6ukxUth5WttxWR0hpgP95cRj1KW
         8reegRymzjv7NsLvM0Dhewr5Xa3vaSniduseDCg+/29Vace7CuW034HZ7P9q7x0/gZ81
         7psQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oR8ZY3nztvYVqBilVl0U3ZkANai8Igyf3opAC1nc1Gg=;
        b=GyQwziielhoDwNyWdMJej3DSYMjolBAKX97w4kizomwKJIUE35QEZFGgZuF8rkpbrI
         hkT2ZN4TVTvCznZ3j4Wtk8krSpCJ8UV0RSZwbjcuVw4dniHyKh4QtByOXCCximk2Tmpk
         vUYmU/EX6MDn35U+KXRJ6PLvUIvmld3lKPZzE7EpYuT53ZJLKMftTlIGmAXC+Hcwkrso
         WsXwV+8M/fuaWL5QgCzv5K1aJAdi5FiSmlEKXEtAuXlQxUpB+9IO2lWz39jKet68rI8k
         IylEtfZHaaa8hCO5UrTSA9n9homBhvhGbGVbzmTuu0AsoZzwVDlcDRI+crZ0F3I7cy5i
         8Viw==
X-Gm-Message-State: AOAM530owZifouZ/qWYpylgR0H3mQaNiPh090pGIPogznFxeS9zMCES6
        AkxtqsMa60BP02DugW/Grvs=
X-Google-Smtp-Source: ABdhPJz2yRmSPJ0vNPbRYzXrA/kTcYEYkq8Piqqc7A2Yci5F40ZGgVRMda91sFy/4RIktG4VgoLI5A==
X-Received: by 2002:a5d:6448:: with SMTP id d8mr9517868wrw.401.1613745041524;
        Fri, 19 Feb 2021 06:30:41 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27003cf54d240f3b36ef.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:3cf5:4d24:f3b:36ef])
        by smtp.gmail.com with ESMTPSA id v9sm8348215wrn.86.2021.02.19.06.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 06:30:41 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 8/9] arm64: dts: imx8mm-nitrogen-r2: add audio
Date:   Fri, 19 Feb 2021 15:30:27 +0100
Message-Id: <20210219143028.207975-9-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219143028.207975-1-adrien.grassein@gmail.com>
References: <20210219143028.207975-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audio description and pin muxing.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index 0fd8e2a54073..961818598247 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -27,6 +27,29 @@ reg_wlan_vmmc: regulator-wlan-vmmc {
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
@@ -210,6 +233,22 @@ rtc@68 {
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
@@ -237,6 +276,18 @@ &pwm4 {
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
@@ -405,6 +456,13 @@ MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA 0x400001c3
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
@@ -441,6 +499,34 @@ MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20 0x16
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

