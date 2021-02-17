Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6951F31DD15
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbhBQQOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbhBQQLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:11:44 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA5DC061756;
        Wed, 17 Feb 2021 08:11:04 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id x16so2573324wmk.3;
        Wed, 17 Feb 2021 08:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sTkvherP9fuGVCExQolvQue5rGBtl9CKuzfrYkeIVTw=;
        b=khGGuHA+IAIhkrPly79rO0nwM2SiBC7c3goZ4FHjxkRWkc3Cz1GCz5jAWv87ZauMKW
         9CGFWF11JCKJbgnjwACWEeUL8S45HFeQb8pt1HO8BipGVvNmmEIC8WQInG/BXFJRKRkM
         OYbzk7t5w3sfxQQ3nahGpgNLWLOvDzvSXihpbbzR3M8vODvjfzY08XDVffvR+nxtYI6e
         orsvYQf+OzF/VaAoTeNMrzL7kM+/rOL0Fu6F05db/D3CmC1TmkhGoG0Gy+AHxPoCQN8f
         fWQOHRWzofjic5c83cuNf1tIO0YquUgkEW5CC5PWoT7IFz9qFRTJXLnNMtUHnKjxbfmU
         3fiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sTkvherP9fuGVCExQolvQue5rGBtl9CKuzfrYkeIVTw=;
        b=tmDYdlEpOWn7lqDEvSrYTPL1uelJnKQM7w/Hk5J8hw+6wc7BwdLx6rMb4BtN7hUBhQ
         6bdFFlPioy4e4/Nvw2eFyAaL04RS8/Hj9luQnA0I1wbbSWOiLufSO1AbUYVeh1/MtXO2
         NOav7Hv5UcWmvlR02RFpwpi7f4nXxha2EJuy3qbMrTLln+Xlu9ahx4Mo4jKKhDwpG+gn
         wUKqNJYbTuLSZqwLu0o3ailRf/NowSTrTUVzaAgz3U1mg7za9+rBqGNsmHEdo58VtGL2
         nXw/+nLuSp47JAjXr9PztKCsdZKzvN8Bb6+pzrIb9XeI+jH/ZAT87q8NxEliXjtswMBN
         wP9A==
X-Gm-Message-State: AOAM531hmbzteFckgCAmQArVCOqgK4pOEbr8LJeg/D6SxciPjQ2BSCnS
        bHU1M69TkfTSXeJXbxh99sY=
X-Google-Smtp-Source: ABdhPJxJmTAplKj9H30cFn2CwCwP6Cw9Wtfz1RliRIYhoriS0jMXQ8lZqKO8/Xz/kUJH/gErlbpVBQ==
X-Received: by 2002:a05:600c:4f91:: with SMTP id n17mr7450020wmq.71.1613578261000;
        Wed, 17 Feb 2021 08:11:01 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700605dcea117b1d0f0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:605d:cea1:17b1:d0f0])
        by smtp.gmail.com with ESMTPSA id e12sm4260260wrv.59.2021.02.17.08.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:11:00 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 7/8] arm64: dts: imx8mm-nitrogen-r2: add audio
Date:   Wed, 17 Feb 2021 17:10:51 +0100
Message-Id: <20210217161052.877877-8-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210217161052.877877-1-adrien.grassein@gmail.com>
References: <20210217161052.877877-1-adrien.grassein@gmail.com>
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
index bdadc70acac6..6a90ef77b25b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -28,6 +28,29 @@ reg_wlan_vmmc: regulator-wlan-vmmc {
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
@@ -211,6 +234,22 @@ rtc@68 {
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
@@ -238,6 +277,18 @@ &pwm4 {
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
@@ -406,6 +457,13 @@ MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA 0x400001c3
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
@@ -442,6 +500,34 @@ MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20 0x16
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

