Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06A7354A19
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 03:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242076AbhDFBeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 21:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242073AbhDFBeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 21:34:06 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11742C061756;
        Mon,  5 Apr 2021 18:34:00 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id l9so5599827ils.6;
        Mon, 05 Apr 2021 18:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=58EPUjvc//5ZWoOYFPrgsk5ZSjrXwdDsAthn9PUF+9g=;
        b=rUhLP/67UwaTE0HTr+qQdobVmRPNKmizF6+y4jjCQwt1tdvOSidOnbu6g7cOqTmALB
         e1367jwmo4pWLS0RbQeJXsCDICRp8+onOcED+ln1ycU3OuGYIRUEaJgz83J5oCegdSBS
         k1rKU7uWyiRGVCqvdH8gYxvo6cW3J1msi1oe4sHRbQ4Wgk4nCJMcLbJL6K4z+py2TlE9
         8Rr563ON4qaoxyBCRqdd+lV35e2e+NxFavJRVZetcJaiFrMSPe9X4+44M/zNFFHVuQym
         eVG25oAlbrQczfL5zs/GjAbtudE8965k6sZJAAJXNTu+zV4qVpdvQlEklyd8cA6iSIFE
         vekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58EPUjvc//5ZWoOYFPrgsk5ZSjrXwdDsAthn9PUF+9g=;
        b=HVe5th0WW0Lfte44AokiEPx+8bgAZ8jl5hGA5KQQKu4rweKJg9FeIGNngTRZ8Cntyb
         KSXvyG369YG092G0cJkZGU9oYCkdMHlGCyjD7d+grOH/feRLS9c7lBXlzyGRvHVW/smg
         0aozwTb7+p3RyBa7rQYDasI5FYBJgACssxv1DGFZm7eu6uJuo4ljFTmW/wEoXA628s7b
         kfaTYlLzI5qG2lK5WdPU1T1tYI1tmtJoSXqcyMzPSZCV2uqXExvGIUUd2rfzYlf5O+F9
         hgyNLp0748qeAbC/S5VeyDPSAOMRzvkmi7UIDf+A/cjbrOC1oauc7+3qF9NIF/bt8Ozb
         0rKA==
X-Gm-Message-State: AOAM530rr0/ao5nI6bCSoxTMlHrFwpurkp+Y3jybDwbPNETwtBzGShlM
        RkRO91ysGBSmIL60NR2BsNQ=
X-Google-Smtp-Source: ABdhPJzrCvl8mYXX9HRMNFbvz2QZ94+t3lPrKMHDUeS9+T2SC8VWb9rc9Rfasimq+u8Cae12W2WAJw==
X-Received: by 2002:a05:6e02:1aab:: with SMTP id l11mr3247327ilv.150.1617672839312;
        Mon, 05 Apr 2021 18:33:59 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:987f:5ec9:b10c:df19])
        by smtp.gmail.com with ESMTPSA id s16sm11821167ilq.87.2021.04.05.18.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 18:33:58 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: imx8mm: Add spba1 and spba2 buses
Date:   Mon,  5 Apr 2021 20:33:43 -0500
Message-Id: <20210406013344.124255-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406013344.124255-1-aford173@gmail.com>
References: <20210406013344.124255-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8MM reference manual shows there are two spba busses.
SPBA1 handles much of the serial interfaces, and SPBA2 covers much
of the audio.

Add both of them.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index a27e02bee6b4..64aa38fd2b6e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -271,117 +271,125 @@ aips1: bus@30000000 {
 			#size-cells = <1>;
 			ranges = <0x30000000 0x30000000 0x400000>;
 
-			sai1: sai@30010000 {
-				#sound-dai-cells = <0>;
-				compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
-				reg = <0x30010000 0x10000>;
-				interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_SAI1_IPG>,
-					 <&clk IMX8MM_CLK_SAI1_ROOT>,
-					 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
-				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma2 0 2 0>, <&sdma2 1 2 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+			spba2: spba-bus@30000000 {
+				compatible = "fsl,spba-bus", "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x30000000 0x100000>;
+				ranges;
+
+				sai1: sai@30010000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+					reg = <0x30010000 0x10000>;
+					interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_SAI1_IPG>,
+						 <&clk IMX8MM_CLK_SAI1_ROOT>,
+						 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 0 2 0>, <&sdma2 1 2 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			sai2: sai@30020000 {
-				#sound-dai-cells = <0>;
-				compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
-				reg = <0x30020000 0x10000>;
-				interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_SAI2_IPG>,
-					<&clk IMX8MM_CLK_SAI2_ROOT>,
-					<&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
-				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma2 2 2 0>, <&sdma2 3 2 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				sai2: sai@30020000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+					reg = <0x30020000 0x10000>;
+					interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_SAI2_IPG>,
+						<&clk IMX8MM_CLK_SAI2_ROOT>,
+						<&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 2 2 0>, <&sdma2 3 2 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			sai3: sai@30030000 {
-				#sound-dai-cells = <0>;
-				compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
-				reg = <0x30030000 0x10000>;
-				interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_SAI3_IPG>,
-					 <&clk IMX8MM_CLK_SAI3_ROOT>,
-					 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
-				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma2 4 2 0>, <&sdma2 5 2 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				sai3: sai@30030000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+					reg = <0x30030000 0x10000>;
+					interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_SAI3_IPG>,
+						 <&clk IMX8MM_CLK_SAI3_ROOT>,
+						 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 4 2 0>, <&sdma2 5 2 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			sai5: sai@30050000 {
-				#sound-dai-cells = <0>;
-				compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
-				reg = <0x30050000 0x10000>;
-				interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_SAI5_IPG>,
-					 <&clk IMX8MM_CLK_SAI5_ROOT>,
-					 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
-				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma2 8 2 0>, <&sdma2 9 2 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				sai5: sai@30050000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+					reg = <0x30050000 0x10000>;
+					interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_SAI5_IPG>,
+						 <&clk IMX8MM_CLK_SAI5_ROOT>,
+						 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 8 2 0>, <&sdma2 9 2 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			sai6: sai@30060000 {
-				#sound-dai-cells = <0>;
-				compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
-				reg = <0x30060000 0x10000>;
-				interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_SAI6_IPG>,
-					 <&clk IMX8MM_CLK_SAI6_ROOT>,
-					 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
-				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma2 10 2 0>, <&sdma2 11 2 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				sai6: sai@30060000 {
+					#sound-dai-cells = <0>;
+					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+					reg = <0x30060000 0x10000>;
+					interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_SAI6_IPG>,
+						 <&clk IMX8MM_CLK_SAI6_ROOT>,
+						 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
+					clock-names = "bus", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 10 2 0>, <&sdma2 11 2 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			micfil: audio-controller@30080000 {
-				compatible = "fsl,imx8mm-micfil";
-				reg = <0x30080000 0x10000>;
-				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_PDM_IPG>,
-					 <&clk IMX8MM_CLK_PDM_ROOT>,
-					 <&clk IMX8MM_AUDIO_PLL1_OUT>,
-					 <&clk IMX8MM_AUDIO_PLL2_OUT>,
-					 <&clk IMX8MM_CLK_EXT3>;
-				clock-names = "ipg_clk", "ipg_clk_app",
-					      "pll8k", "pll11k", "clkext3";
-				dmas = <&sdma2 24 25 0x80000000>;
-				dma-names = "rx";
-				status = "disabled";
-			};
+				micfil: audio-controller@30080000 {
+					compatible = "fsl,imx8mm-micfil";
+					reg = <0x30080000 0x10000>;
+					interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_PDM_IPG>,
+						 <&clk IMX8MM_CLK_PDM_ROOT>,
+						 <&clk IMX8MM_AUDIO_PLL1_OUT>,
+						 <&clk IMX8MM_AUDIO_PLL2_OUT>,
+						 <&clk IMX8MM_CLK_EXT3>;
+					clock-names = "ipg_clk", "ipg_clk_app",
+						      "pll8k", "pll11k", "clkext3";
+					dmas = <&sdma2 24 25 0x80000000>;
+					dma-names = "rx";
+					status = "disabled";
+				};
 
-			spdif1: spdif@30090000 {
-				compatible = "fsl,imx35-spdif";
-				reg = <0x30090000 0x10000>;
-				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_AUDIO_AHB>, /* core */
-					 <&clk IMX8MM_CLK_24M>, /* rxtx0 */
-					 <&clk IMX8MM_CLK_SPDIF1>, /* rxtx1 */
-					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx2 */
-					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx3 */
-					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx4 */
-					 <&clk IMX8MM_CLK_AUDIO_AHB>, /* rxtx5 */
-					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx6 */
-					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx7 */
-					 <&clk IMX8MM_CLK_DUMMY>; /* spba */
-				clock-names = "core", "rxtx0",
-					      "rxtx1", "rxtx2",
-					      "rxtx3", "rxtx4",
-					      "rxtx5", "rxtx6",
-					      "rxtx7", "spba";
-				dmas = <&sdma2 28 18 0>, <&sdma2 29 18 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
+				spdif1: spdif@30090000 {
+					compatible = "fsl,imx35-spdif";
+					reg = <0x30090000 0x10000>;
+					interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_AUDIO_AHB>, /* core */
+						 <&clk IMX8MM_CLK_24M>, /* rxtx0 */
+						 <&clk IMX8MM_CLK_SPDIF1>, /* rxtx1 */
+						 <&clk IMX8MM_CLK_DUMMY>, /* rxtx2 */
+						 <&clk IMX8MM_CLK_DUMMY>, /* rxtx3 */
+						 <&clk IMX8MM_CLK_DUMMY>, /* rxtx4 */
+						 <&clk IMX8MM_CLK_AUDIO_AHB>, /* rxtx5 */
+						 <&clk IMX8MM_CLK_DUMMY>, /* rxtx6 */
+						 <&clk IMX8MM_CLK_DUMMY>, /* rxtx7 */
+						 <&clk IMX8MM_CLK_DUMMY>; /* spba */
+					clock-names = "core", "rxtx0",
+						      "rxtx1", "rxtx2",
+						      "rxtx3", "rxtx4",
+						      "rxtx5", "rxtx6",
+						      "rxtx7", "spba";
+					dmas = <&sdma2 28 18 0>, <&sdma2 29 18 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 			};
 
 			gpio1: gpio@30200000 {
@@ -670,80 +678,88 @@ aips3: bus@30800000 {
 			ranges = <0x30800000 0x30800000 0x400000>,
 				 <0x8000000 0x8000000 0x10000000>;
 
-			ecspi1: spi@30820000 {
-				compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
+			spba1: spba-bus@30800000 {
+				compatible = "fsl,spba-bus", "simple-bus";
 				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x30820000 0x10000>;
-				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_ECSPI1_ROOT>,
-					 <&clk IMX8MM_CLK_ECSPI1_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 0 7 1>, <&sdma1 1 7 2>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				#size-cells = <1>;
+				reg = <0x30800000 0x100000>;
+				ranges;
+
+				ecspi1: spi@30820000 {
+					compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x30820000 0x10000>;
+					interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_ECSPI1_ROOT>,
+						 <&clk IMX8MM_CLK_ECSPI1_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 0 7 1>, <&sdma1 1 7 2>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			ecspi2: spi@30830000 {
-				compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x30830000 0x10000>;
-				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_ECSPI2_ROOT>,
-					 <&clk IMX8MM_CLK_ECSPI2_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 2 7 1>, <&sdma1 3 7 2>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				ecspi2: spi@30830000 {
+					compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x30830000 0x10000>;
+					interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_ECSPI2_ROOT>,
+						 <&clk IMX8MM_CLK_ECSPI2_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 2 7 1>, <&sdma1 3 7 2>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			ecspi3: spi@30840000 {
-				compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x30840000 0x10000>;
-				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_ECSPI3_ROOT>,
-					 <&clk IMX8MM_CLK_ECSPI3_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 4 7 1>, <&sdma1 5 7 2>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				ecspi3: spi@30840000 {
+					compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x30840000 0x10000>;
+					interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_ECSPI3_ROOT>,
+						 <&clk IMX8MM_CLK_ECSPI3_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 4 7 1>, <&sdma1 5 7 2>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			uart1: serial@30860000 {
-				compatible = "fsl,imx8mm-uart", "fsl,imx6q-uart";
-				reg = <0x30860000 0x10000>;
-				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_UART1_ROOT>,
-					 <&clk IMX8MM_CLK_UART1_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 22 4 0>, <&sdma1 23 4 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				uart1: serial@30860000 {
+					compatible = "fsl,imx8mm-uart", "fsl,imx6q-uart";
+					reg = <0x30860000 0x10000>;
+					interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_UART1_ROOT>,
+						 <&clk IMX8MM_CLK_UART1_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 22 4 0>, <&sdma1 23 4 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			uart3: serial@30880000 {
-				compatible = "fsl,imx8mm-uart", "fsl,imx6q-uart";
-				reg = <0x30880000 0x10000>;
-				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_UART3_ROOT>,
-					 <&clk IMX8MM_CLK_UART3_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				uart3: serial@30880000 {
+					compatible = "fsl,imx8mm-uart", "fsl,imx6q-uart";
+					reg = <0x30880000 0x10000>;
+					interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_UART3_ROOT>,
+						 <&clk IMX8MM_CLK_UART3_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			uart2: serial@30890000 {
-				compatible = "fsl,imx8mm-uart", "fsl,imx6q-uart";
-				reg = <0x30890000 0x10000>;
-				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MM_CLK_UART2_ROOT>,
-					 <&clk IMX8MM_CLK_UART2_ROOT>;
-				clock-names = "ipg", "per";
-				status = "disabled";
+				uart2: serial@30890000 {
+					compatible = "fsl,imx8mm-uart", "fsl,imx6q-uart";
+					reg = <0x30890000 0x10000>;
+					interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MM_CLK_UART2_ROOT>,
+						 <&clk IMX8MM_CLK_UART2_ROOT>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
 			};
 
 			crypto: crypto@30900000 {
-- 
2.25.1

