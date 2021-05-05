Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FAE374880
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 21:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbhEETMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 15:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbhEETMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 15:12:35 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48D2C061761;
        Wed,  5 May 2021 12:11:37 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id y10so2719820ilv.0;
        Wed, 05 May 2021 12:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vZeEXRCd24seoFH7GRFkufDJ4YkQs9v5c3UPLyEGxAo=;
        b=HMyA15emhA9kvzs6t5n2eHmMr7C1OdaGSA5Am2dCKb8XBeoCB4gi7wkd4d1I+uuWRT
         lluqGqRc9LJK6nxZNnO8k38P//gAS3PgSSf+SCXyY3+0MraX07A3l3vHx4mOE1qHFz++
         MLSS4sBgB2fm968szDXV2LvEQxmBVF3nzFbtNA5x8E7Fwoyzui0VPcSACLe+DEVtk61R
         9HltsY8TzPA61MaelYYORYOYevFJvQpe80wxn07YFXYyh7JX/sC+xt6cIsYSLYd0DtPK
         VcvxsBCi/E/u/7beL7n0QWrQ+Ns+rqMRKihpj1Bpbiy8yNRVr2oDeZ8h7sC8P6ZtYyvB
         s5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vZeEXRCd24seoFH7GRFkufDJ4YkQs9v5c3UPLyEGxAo=;
        b=ZAD0UfNVdLKApiCCMB3ComV0lWBj+gv7M8yPCy6OS/Zpi3ZvBTLnbBwnGcRrV6Q9Pk
         MDMG8v8aYBpeFIp+pPdLEsVxX0134mpP/WbfgnOWEQhhyKMLLHZ1EbwKhFOqQUsah0c4
         mCLUhCYLfAbK1NYGxe7+F0dJIh7ZLtPAnEkr36Q5hHLKtjHMgTXBan4NhCorRwqKqV1+
         JR31VMonibLYrqCuxdO4e5/7cKug43Sj2WYMDObs7U4XWtRhjx8rZBgYs24144Wl8bLe
         BykmiOQZjb8Jx3QpOLTNYG3C7l+eW60UiNI7pR2DQ7HK051fDs2sX9xX2Fc8U8tlaMSl
         ArWQ==
X-Gm-Message-State: AOAM530A4i09sFqEQg0VluZ3tHmYU9e/ffac4UC36xkp2ZoJ41U+baYw
        nQE2rRiMCXnVttb7/DtNX6Y=
X-Google-Smtp-Source: ABdhPJyQhdUZ1ymtZ1XredlqSqWvf2hevJrzKx8j9JQpzkIUnde16I8WrwmXDbM+tTvXyYoNbz/+zQ==
X-Received: by 2002:a92:d242:: with SMTP id v2mr422947ilg.135.1620241897076;
        Wed, 05 May 2021 12:11:37 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:c971:6623:b9e9:f40d])
        by smtp.gmail.com with ESMTPSA id q11sm140037ile.56.2021.05.05.12.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 12:11:36 -0700 (PDT)
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
Subject: [PATCH 2/2] arm64: dts: imx8mn-beacon: Enable more audio
Date:   Wed,  5 May 2021 14:11:25 -0500
Message-Id: <20210505191126.1239309-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505191126.1239309-1-aford173@gmail.com>
References: <20210505191126.1239309-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are audio ports for SPDIF and MICFIL on the baseboard.
Enable them.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
index 376ca8ff7213..cc31f2c5b4bf 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
@@ -76,6 +76,20 @@ sound {
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
@@ -151,6 +165,15 @@ &easrc {
 	status = "okay";
 };
 
+&micfil {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_micfil>;
+	assigned-clocks = <&clk IMX8MN_CLK_PDM>;
+	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <196608000>;
+	status = "okay";
+};
+
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
@@ -165,6 +188,23 @@ &snvs_pwrkey {
 	status = "okay";
 };
 
+&spdif1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spdif1>;
+	assigned-clocks = <&clk IMX8MN_CLK_SPDIF1>;
+	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	clocks = <&clk IMX8MN_CLK_AUDIO_AHB>, <&clk IMX8MN_CLK_24M>,
+		<&clk IMX8MN_CLK_SPDIF1>, <&clk IMX8MN_CLK_DUMMY>,
+		<&clk IMX8MN_CLK_DUMMY>, <&clk IMX8MN_CLK_DUMMY>,
+		<&clk IMX8MN_CLK_AUDIO_AHB>, <&clk IMX8MN_CLK_DUMMY>,
+		<&clk IMX8MN_CLK_DUMMY>, <&clk IMX8MN_CLK_DUMMY>,
+		<&clk IMX8MN_AUDIO_PLL1_OUT>, <&clk IMX8MN_AUDIO_PLL2_OUT>;
+	clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3",
+		"rxtx4", "rxtx5", "rxtx6", "rxtx7", "spba", "pll8k", "pll11k";
+	status = "okay";
+};
+
 &uart2 { /* console */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
@@ -226,6 +266,13 @@ MX8MN_IOMUXC_SAI3_RXFS_GPIO4_IO28	0x41
 		>;
 	};
 
+	pinctrl_micfil: micfilgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SAI5_RXC_PDM_CLK		0xd6
+			MX8MN_IOMUXC_SAI5_RXD0_PDM_BIT_STREAM0	0xd6
+		>;
+	};
+
 	pinctrl_pcal6414: pcal6414-gpiogrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19
@@ -248,6 +295,14 @@ MX8MN_IOMUXC_SAI3_RXD_SAI3_RX_DATA0	0xd6
 		>;
 	};
 
+	pinctrl_spdif1: spdif1grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SPDIF_TX_SPDIF1_OUT	0xd6
+			MX8MN_IOMUXC_SPDIF_RX_SPDIF1_IN		0xd6
+			MX8MN_IOMUXC_SPDIF_EXT_CLK_SPDIF1_EXT_CLK	0xd6
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MN_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
-- 
2.25.1

