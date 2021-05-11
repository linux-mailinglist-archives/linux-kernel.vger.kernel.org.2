Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23368379D24
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 04:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhEKCrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 22:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229932AbhEKCrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 22:47:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E89A6157F;
        Tue, 11 May 2021 02:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620701170;
        bh=bacp6zQsCI5jt/Rek+mjl2af4biDb3FKuxJ5Ls8K6Uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=csDUpbIoiXOE2t9V7lDqWw6oWfTx/+R5GWApUq5l+hnd2tDkQnoffKcJxOdSGtLz7
         yt/+OvBgdLmRsrYsSJ3YfUZyrKJN3vnOAn3CXSM2c/XrHbB+BTvFXhNyYv1ftQ35Cx
         encBPWZAMTC+awPSrhtpUCh5Xzgj6NMDQWdbNWJLeyMAFJ54+37o9hrM5HmEueslQ4
         3fWVDAbLkXjAJ/rAQ/YayXKUST87gldmTKimBas1nlXX1tYMkaZiX8yQQxnirLc9G+
         9AbHvcLyyaO09D9MzMdaRUrv1yD8/CcSoOeRU2RK/GkXeLoXmFug/mXeH/bAsVxItQ
         JEAq3gzCEwASA==
Date:   Tue, 11 May 2021 10:46:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: imx8mn: Add spba1 bus
Message-ID: <20210511024604.GE3425@dragon>
References: <20210406013344.124255-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406013344.124255-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 08:33:42PM -0500, Adam Ford wrote:
> The i.MX8MN has an SPBA bus which covers much of the audio, but
> there is a second SPBA bus which covers many of the serial interfaces
> like SPI and UARTs currently missing from the device tree. The reference
> manual calls the bus handling the audio peripherals SPBA2, and the bus
> handling the serial peripherals is called SPBA1.
> 
> Rename the existing spba bus to spba2 and add spba1.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index 4dac4da38f4c..e961acd237a8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -255,7 +255,7 @@ aips1: bus@30000000 {
>  			#size-cells = <1>;
>  			ranges;
>  
> -			spba: spba-bus@30000000 {
> +			spba2: spba-bus@30000000 {
>  				compatible = "fsl,spba-bus", "simple-bus";

Just noticed that "fsl,spba-bus" is undocumented, no?

Also may I ask if you have a real use case for this bus node?

Shawn

>  				#address-cells = <1>;
>  				#size-cells = <1>;
> @@ -681,80 +681,88 @@ aips3: bus@30800000 {
>  			#size-cells = <1>;
>  			ranges;
>  
> -			ecspi1: spi@30820000 {
> -				compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
> +			spba1: spba-bus@30800000 {
> +				compatible = "fsl,spba-bus", "simple-bus";
>  				#address-cells = <1>;
> -				#size-cells = <0>;
> -				reg = <0x30820000 0x10000>;
> -				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk IMX8MN_CLK_ECSPI1_ROOT>,
> -					 <&clk IMX8MN_CLK_ECSPI1_ROOT>;
> -				clock-names = "ipg", "per";
> -				dmas = <&sdma1 0 7 1>, <&sdma1 1 7 2>;
> -				dma-names = "rx", "tx";
> -				status = "disabled";
> -			};
> +				#size-cells = <1>;
> +				reg = <0x30800000 0x100000>;
> +				ranges;
>  
> -			ecspi2: spi@30830000 {
> -				compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				reg = <0x30830000 0x10000>;
> -				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk IMX8MN_CLK_ECSPI2_ROOT>,
> -					 <&clk IMX8MN_CLK_ECSPI2_ROOT>;
> -				clock-names = "ipg", "per";
> -				dmas = <&sdma1 2 7 1>, <&sdma1 3 7 2>;
> -				dma-names = "rx", "tx";
> -				status = "disabled";
> -			};
> +				ecspi1: spi@30820000 {
> +					compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0x30820000 0x10000>;
> +					interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&clk IMX8MN_CLK_ECSPI1_ROOT>,
> +						 <&clk IMX8MN_CLK_ECSPI1_ROOT>;
> +					clock-names = "ipg", "per";
> +					dmas = <&sdma1 0 7 1>, <&sdma1 1 7 2>;
> +					dma-names = "rx", "tx";
> +					status = "disabled";
> +				};
>  
> -			ecspi3: spi@30840000 {
> -				compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				reg = <0x30840000 0x10000>;
> -				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk IMX8MN_CLK_ECSPI3_ROOT>,
> -					 <&clk IMX8MN_CLK_ECSPI3_ROOT>;
> -				clock-names = "ipg", "per";
> -				dmas = <&sdma1 4 7 1>, <&sdma1 5 7 2>;
> -				dma-names = "rx", "tx";
> -				status = "disabled";
> -			};
> +				ecspi2: spi@30830000 {
> +					compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0x30830000 0x10000>;
> +					interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&clk IMX8MN_CLK_ECSPI2_ROOT>,
> +						 <&clk IMX8MN_CLK_ECSPI2_ROOT>;
> +					clock-names = "ipg", "per";
> +					dmas = <&sdma1 2 7 1>, <&sdma1 3 7 2>;
> +					dma-names = "rx", "tx";
> +					status = "disabled";
> +				};
>  
> -			uart1: serial@30860000 {
> -				compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
> -				reg = <0x30860000 0x10000>;
> -				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk IMX8MN_CLK_UART1_ROOT>,
> -					 <&clk IMX8MN_CLK_UART1_ROOT>;
> -				clock-names = "ipg", "per";
> -				dmas = <&sdma1 22 4 0>, <&sdma1 23 4 0>;
> -				dma-names = "rx", "tx";
> -				status = "disabled";
> -			};
> +				ecspi3: spi@30840000 {
> +					compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0x30840000 0x10000>;
> +					interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&clk IMX8MN_CLK_ECSPI3_ROOT>,
> +						 <&clk IMX8MN_CLK_ECSPI3_ROOT>;
> +					clock-names = "ipg", "per";
> +					dmas = <&sdma1 4 7 1>, <&sdma1 5 7 2>;
> +					dma-names = "rx", "tx";
> +					status = "disabled";
> +				};
>  
> -			uart3: serial@30880000 {
> -				compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
> -				reg = <0x30880000 0x10000>;
> -				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk IMX8MN_CLK_UART3_ROOT>,
> -					 <&clk IMX8MN_CLK_UART3_ROOT>;
> -				clock-names = "ipg", "per";
> -				dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
> -				dma-names = "rx", "tx";
> -				status = "disabled";
> -			};
> +				uart1: serial@30860000 {
> +					compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
> +					reg = <0x30860000 0x10000>;
> +					interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&clk IMX8MN_CLK_UART1_ROOT>,
> +						 <&clk IMX8MN_CLK_UART1_ROOT>;
> +					clock-names = "ipg", "per";
> +					dmas = <&sdma1 22 4 0>, <&sdma1 23 4 0>;
> +					dma-names = "rx", "tx";
> +					status = "disabled";
> +				};
>  
> -			uart2: serial@30890000 {
> -				compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
> -				reg = <0x30890000 0x10000>;
> -				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clk IMX8MN_CLK_UART2_ROOT>,
> -					 <&clk IMX8MN_CLK_UART2_ROOT>;
> -				clock-names = "ipg", "per";
> -				status = "disabled";
> +				uart3: serial@30880000 {
> +					compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
> +					reg = <0x30880000 0x10000>;
> +					interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&clk IMX8MN_CLK_UART3_ROOT>,
> +						 <&clk IMX8MN_CLK_UART3_ROOT>;
> +					clock-names = "ipg", "per";
> +					dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
> +					dma-names = "rx", "tx";
> +					status = "disabled";
> +				};
> +
> +				uart2: serial@30890000 {
> +					compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
> +					reg = <0x30890000 0x10000>;
> +					interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> +					clocks = <&clk IMX8MN_CLK_UART2_ROOT>,
> +						 <&clk IMX8MN_CLK_UART2_ROOT>;
> +					clock-names = "ipg", "per";
> +					status = "disabled";
> +				};
>  			};
>  
>  			crypto: crypto@30900000 {
> -- 
> 2.25.1
> 
