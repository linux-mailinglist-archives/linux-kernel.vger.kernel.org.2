Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB15354A1A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 03:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243138AbhDFBeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 21:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242044AbhDFBeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 21:34:06 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD3BC06174A;
        Mon,  5 Apr 2021 18:33:58 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r193so10914764ior.9;
        Mon, 05 Apr 2021 18:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PCkx1Hy5ZNunfJ03zaMyAAsCJ1wPoE7EfbDV0oUNaa8=;
        b=c8Wza6l9543trVN8mpcKblGAxlLHLxdABy5DN63shJgi3XfBFtLGYuOQmO5wp2Qm1k
         GBtIR9ZUy6nImKTgbOCOvNhoBaNUzqwbEVFpUhIaeLoqAOF4f4g23V2cKyDQ89WRVxYh
         NU576n0HMTAs0uRtAkn2BFIdyJ0cn4wAAsa+pAbTvgcMnQ1REdST6dWp0II75qQI7Juf
         UMPkWyWsiRqtj1cv/g+2FRyzS7P1VjTPh/VzmBXkk4rcQS+NPJO7zJyReWFuiTxaTev0
         P8gcXbAyY+PpEQ6/zefd0lAHVxaSpw6IhtPF+ODDeo+cu5w08x4mtcJCo9oAbfUOI6Q/
         zJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PCkx1Hy5ZNunfJ03zaMyAAsCJ1wPoE7EfbDV0oUNaa8=;
        b=Fh9io87D6qMqUsZQjDuIiVY6MZRo+2tQI9HJ/3sGwa/mUvao7oH+YN7eJM1zUorVmV
         9XuRw6uFzc5mlUQ0owEuQ9a3m1cNrvKnzFyaHNf6QLNya9r6Cp5gcR0UKesTN3qCxNQK
         htMlBpDnWFWw8vTV4sXb0PXGhLnu03A493MLEcJz6tCXqb1c2V7tdJetkHnjkziH7nVR
         C8vYbSW5n11OKaBVh8sm6tgWl6TR7eEu0GZHyipiCHdLLfNzywmFmFSHg2nGoOmdsXvw
         VxuJNgeNsfUM9mCNStHFnDLvf7Vj1LJ7t8hFTC75gHdkWZEQ60hAVTxhBvrXJ2hGTDFG
         10dQ==
X-Gm-Message-State: AOAM530bT8UM3FtDwFZGaHVBnjbn70LR5GRJdZAAYQJePKr7VhlyROg+
        bfNdwhhJCUiG61Z7ldNzZBs=
X-Google-Smtp-Source: ABdhPJx5hbNRMUA/iwd7evM3Yd0rT++sQZPetPLkxZDVG/3kV7ujVuOw2Xw2QXV/ALcVV+u1HLBTQA==
X-Received: by 2002:a6b:b447:: with SMTP id d68mr21325741iof.87.1617672837766;
        Mon, 05 Apr 2021 18:33:57 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:987f:5ec9:b10c:df19])
        by smtp.gmail.com with ESMTPSA id s16sm11821167ilq.87.2021.04.05.18.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 18:33:56 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: imx8mn: Add spba1 bus
Date:   Mon,  5 Apr 2021 20:33:42 -0500
Message-Id: <20210406013344.124255-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8MN has an SPBA bus which covers much of the audio, but
there is a second SPBA bus which covers many of the serial interfaces
like SPI and UARTs currently missing from the device tree. The reference
manual calls the bus handling the audio peripherals SPBA2, and the bus
handling the serial peripherals is called SPBA1.

Rename the existing spba bus to spba2 and add spba1.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 4dac4da38f4c..e961acd237a8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -255,7 +255,7 @@ aips1: bus@30000000 {
 			#size-cells = <1>;
 			ranges;
 
-			spba: spba-bus@30000000 {
+			spba2: spba-bus@30000000 {
 				compatible = "fsl,spba-bus", "simple-bus";
 				#address-cells = <1>;
 				#size-cells = <1>;
@@ -681,80 +681,88 @@ aips3: bus@30800000 {
 			#size-cells = <1>;
 			ranges;
 
-			ecspi1: spi@30820000 {
-				compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
+			spba1: spba-bus@30800000 {
+				compatible = "fsl,spba-bus", "simple-bus";
 				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x30820000 0x10000>;
-				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MN_CLK_ECSPI1_ROOT>,
-					 <&clk IMX8MN_CLK_ECSPI1_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 0 7 1>, <&sdma1 1 7 2>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				#size-cells = <1>;
+				reg = <0x30800000 0x100000>;
+				ranges;
 
-			ecspi2: spi@30830000 {
-				compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x30830000 0x10000>;
-				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MN_CLK_ECSPI2_ROOT>,
-					 <&clk IMX8MN_CLK_ECSPI2_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 2 7 1>, <&sdma1 3 7 2>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				ecspi1: spi@30820000 {
+					compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x30820000 0x10000>;
+					interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_ECSPI1_ROOT>,
+						 <&clk IMX8MN_CLK_ECSPI1_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 0 7 1>, <&sdma1 1 7 2>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			ecspi3: spi@30840000 {
-				compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x30840000 0x10000>;
-				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MN_CLK_ECSPI3_ROOT>,
-					 <&clk IMX8MN_CLK_ECSPI3_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 4 7 1>, <&sdma1 5 7 2>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				ecspi2: spi@30830000 {
+					compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x30830000 0x10000>;
+					interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_ECSPI2_ROOT>,
+						 <&clk IMX8MN_CLK_ECSPI2_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 2 7 1>, <&sdma1 3 7 2>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			uart1: serial@30860000 {
-				compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
-				reg = <0x30860000 0x10000>;
-				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MN_CLK_UART1_ROOT>,
-					 <&clk IMX8MN_CLK_UART1_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 22 4 0>, <&sdma1 23 4 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				ecspi3: spi@30840000 {
+					compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x30840000 0x10000>;
+					interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_ECSPI3_ROOT>,
+						 <&clk IMX8MN_CLK_ECSPI3_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 4 7 1>, <&sdma1 5 7 2>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			uart3: serial@30880000 {
-				compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
-				reg = <0x30880000 0x10000>;
-				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MN_CLK_UART3_ROOT>,
-					 <&clk IMX8MN_CLK_UART3_ROOT>;
-				clock-names = "ipg", "per";
-				dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
+				uart1: serial@30860000 {
+					compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
+					reg = <0x30860000 0x10000>;
+					interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_UART1_ROOT>,
+						 <&clk IMX8MN_CLK_UART1_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 22 4 0>, <&sdma1 23 4 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
 
-			uart2: serial@30890000 {
-				compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
-				reg = <0x30890000 0x10000>;
-				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MN_CLK_UART2_ROOT>,
-					 <&clk IMX8MN_CLK_UART2_ROOT>;
-				clock-names = "ipg", "per";
-				status = "disabled";
+				uart3: serial@30880000 {
+					compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
+					reg = <0x30880000 0x10000>;
+					interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_UART3_ROOT>,
+						 <&clk IMX8MN_CLK_UART3_ROOT>;
+					clock-names = "ipg", "per";
+					dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
+
+				uart2: serial@30890000 {
+					compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
+					reg = <0x30890000 0x10000>;
+					interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_UART2_ROOT>,
+						 <&clk IMX8MN_CLK_UART2_ROOT>;
+					clock-names = "ipg", "per";
+					status = "disabled";
+				};
 			};
 
 			crypto: crypto@30900000 {
-- 
2.25.1

