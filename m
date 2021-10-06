Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A1F42393B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 09:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbhJFHzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 03:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbhJFHzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 03:55:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67268C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 00:54:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mY1kP-0002Qa-04; Wed, 06 Oct 2021 09:53:53 +0200
Message-ID: <c4c5e2dd51e6a47c0973f46ff64ac200405ac84e.camel@pengutronix.de>
Subject: Re: [PATCH 7/7] arm64: dts: imx8mn: Enable GPU
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 06 Oct 2021 09:53:51 +0200
In-Reply-To: <20211006000505.627334-7-aford173@gmail.com>
References: <20211006000505.627334-1-aford173@gmail.com>
         <20211006000505.627334-7-aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 05.10.2021 um 19:05 -0500 schrieb Adam Ford:
> The i.MX8M-Nano features a GC7000. The Etnaviv driver detects it as:
> 
>     etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 25 +++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index 57f67257d2fd..46144a7482d3 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -1089,6 +1089,31 @@ gpmi: nand-controller@33002000 {
>  			status = "disabled";
>  		};
>  
> +		gpu: gpu@38000000 {
> +			compatible = "vivante,gc";
> +			reg = <0x38000000 0x8000>;
> +			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk IMX8MN_CLK_GPU_AHB>,
> +				<&clk IMX8MN_CLK_GPU_BUS_ROOT>,
> +				<&clk IMX8MN_CLK_GPU_CORE_ROOT>,
> +				<&clk IMX8MN_CLK_GPU_SHADER_DIV>;

Last one should be just IMX8MN_CLK_GPU_SHADER.

> +			clock-names = "reg", "bus", "core", "shader";
> +			assigned-clocks = <&clk IMX8MN_CLK_GPU_CORE_SRC>,
> +					  <&clk IMX8MN_CLK_GPU_SHADER_SRC>,
> +					  <&clk IMX8MN_CLK_GPU_AXI>,
> +					  <&clk IMX8MN_CLK_GPU_AHB>,
> +					  <&clk IMX8MN_GPU_PLL>,
> +					  <&clk IMX8MN_CLK_GPU_CORE_DIV>,
> +					  <&clk IMX8MN_CLK_GPU_SHADER_DIV>;

_SRC and _DIV clocks are just legacy aliases for the now composite
clocks and should not be used in new DTs. Please just use the composite
clock handles directly.

Regards,
Lucas

> +			assigned-clock-parents = <&clk IMX8MN_GPU_PLL_OUT>,
> +						  <&clk IMX8MN_GPU_PLL_OUT>,
> +						  <&clk IMX8MN_SYS_PLL1_800M>,
> +						  <&clk IMX8MN_SYS_PLL1_800M>;
> +			assigned-clock-rates = <0>, <0>, <800000000>, <400000000>, <1200000000>,
> +				<400000000>, <400000000>;
> +			power-domains = <&pgc_gpumix>;
> +		};
> +
>  		gic: interrupt-controller@38800000 {
>  			compatible = "arm,gic-v3";
>  			reg = <0x38800000 0x10000>,


