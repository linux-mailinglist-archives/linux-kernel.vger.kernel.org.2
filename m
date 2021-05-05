Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E1137487E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 21:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbhEETMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 15:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhEETMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 15:12:34 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C931C061574;
        Wed,  5 May 2021 12:11:36 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id j20so2644597ilo.10;
        Wed, 05 May 2021 12:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iqYLEWNmfMZU8omZo87Grp7RzQjr7r2bX7XQx2q4gTo=;
        b=H8rjHtvrnXak1UZPVJnc/sNqqnu3LjhcZSnGJy6Zd0PocowYBlS/GkFC+BRWB9VlEK
         gzO080wpr3Fsirq3NULZiWo6jYUaAJHYc/qf7xClDCUL5B8HJbjvkvPUCB6E1VIHamg9
         mOFywkogMb+fmYOjh5r7/5XO/sRquoS/xkabLJKD8WHtuTrTJArvvX2TLg4UtdhmQMka
         TCH/DMf685kzRZOel7AnYQftUmTxP6s+nPcaKG6dj73rnyphA8bmqQoW7Z95UoylBHsM
         Tigqf8vjjdowPW5/dABJjtS4d9K2fBCgfCqmUUhjAIyN6xVsaH+4VlLOLr0xW0UKHH3Z
         sEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iqYLEWNmfMZU8omZo87Grp7RzQjr7r2bX7XQx2q4gTo=;
        b=f8XJKTSIpiRT0CXq5mMadwvj5Q68Fnx5uOJWR7aaXLGazKL5hekvAWo5bXv+6mlJaQ
         FIgZYpx76UGz6+Pt/DoV/269Vg02poLiiM3bxJJx7u12HgvRSaBSqqEQ0cKilCZE/+4Q
         +uuje0Vwrhhrj4IeZtDqI1as5OFSF4+ElboFjhqu2lU5GSH5JEKioFtNrJOWzLpuap/t
         5JmKNMQ2r+GSdmuFGZrcb/E01h4dIX8wFw5fiLylNd6gSSiF0oB5YSukxdjNLGoD4iiH
         wiPyJU+qEIwtdFqJNCNyOg+9NeelQ+uKHIOgZdlPgJbMJN3MZGmQwu4ngYQFErEm076Q
         mISA==
X-Gm-Message-State: AOAM533fXrmKcPXrxpvB0maOCoBl6YfEREKGDw2PBhZQin4MqQ8v/H5h
        PD/JS/VTWmCUxtTXz7Pl+3s=
X-Google-Smtp-Source: ABdhPJw93A8fHpSNE6Y2Mu4u3vP8T2gjTo557TsCSwpUW4fugVXt/BE9EiKhhSCrHXHhrLBUc+QP3g==
X-Received: by 2002:a92:ca0a:: with SMTP id j10mr452413ils.73.1620241895730;
        Wed, 05 May 2021 12:11:35 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:c971:6623:b9e9:f40d])
        by smtp.gmail.com with ESMTPSA id q11sm140037ile.56.2021.05.05.12.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 12:11:35 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: imx8mm-beacon: Enable more audio
Date:   Wed,  5 May 2021 14:11:24 -0500
Message-Id: <20210505191126.1239309-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are audio ports for SPDIF and MICFIL on the baseboard.
Enable them.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
index 6f5e63696ec0..3039a030f3d8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
@@ -65,6 +65,20 @@ sound {
 			"AMIC", "MICBIAS",
 			"IN3R", "AMIC";
 	};
+
+	sound-micfil {
+		compatible = "fsl,imx-audio-micfil";
+		model = "imx-audio-micfil";
+		cpu-dai = <&micfil>;
+	};
+
+	sound-spdif {
+		compatible = "fsl,imx-audio-spdif";
+		model = "imx-spdif";
+		spdif-controller = <&spdif1>;
+		spdif-out;
+		spdif-in;
+	};
 };
 
 &ecspi2 {
@@ -141,6 +155,15 @@ pca6416_1: gpio@21 {
 	};
 };
 
+&micfil {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_micfil>;
+	assigned-clocks = <&clk IMX8MM_CLK_PDM>;
+	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <196608000>;
+	status = "okay";
+};
+
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
@@ -155,6 +178,23 @@ &snvs_pwrkey {
 	status = "okay";
 };
 
+&spdif1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spdif1>;
+	assigned-clocks = <&clk IMX8MM_CLK_SPDIF1>;
+	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	clocks = <&clk IMX8MM_CLK_AUDIO_AHB>, <&clk IMX8MM_CLK_24M>,
+		<&clk IMX8MM_CLK_SPDIF1>, <&clk IMX8MM_CLK_DUMMY>,
+		<&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>,
+		<&clk IMX8MM_CLK_AUDIO_AHB>, <&clk IMX8MM_CLK_DUMMY>,
+		<&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>,
+		<&clk IMX8MM_AUDIO_PLL1_OUT>, <&clk IMX8MM_AUDIO_PLL2_OUT>;
+	clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3",
+		"rxtx4", "rxtx5", "rxtx6", "rxtx7", "spba", "pll8k", "pll11k";
+	status = "okay";
+};
+
 &uart2 { /* console */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
@@ -209,6 +249,13 @@ MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28	0x41
 		>;
 	};
 
+	pinctrl_micfil: micfilgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_RXC_PDM_CLK		0xd6
+			MX8MM_IOMUXC_SAI5_RXD0_PDM_DATA0	0xd6
+		>;
+	};
+
 	pinctrl_pcal6414: pcal6414-gpiogrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19
@@ -225,6 +272,14 @@ MX8MM_IOMUXC_SAI3_RXD_SAI3_RX_DATA0	0xd6
 		>;
 	};
 
+	pinctrl_spdif1: spdif1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_TX_SPDIF1_OUT	0xd6
+			MX8MM_IOMUXC_SPDIF_RX_SPDIF1_IN		0xd6
+			MX8MM_IOMUXC_SPDIF_EXT_CLK_SPDIF1_EXT_CLK	0xd6
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
-- 
2.25.1

