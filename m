Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120A742392F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 09:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbhJFHue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 03:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236829AbhJFHud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 03:50:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009D6C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 00:48:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mY1fG-0001t3-BQ; Wed, 06 Oct 2021 09:48:34 +0200
Message-ID: <4a47669a6b450822da7128bbb62f50b046dfd210.camel@pengutronix.de>
Subject: Re: [PATCH 4/7] arm64: dts: imx8mn: add GPC node
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
Date:   Wed, 06 Oct 2021 09:48:33 +0200
In-Reply-To: <20211006000505.627334-4-aford173@gmail.com>
References: <20211006000505.627334-1-aford173@gmail.com>
         <20211006000505.627334-4-aford173@gmail.com>
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
> Add the DT node for the GPC, including all the PGC power domains,
> some of them are not fully functional yet, as they require interaction
> with the blk-ctrls to properly power up/down the peripherals.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 49 +++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index da6c942fb7f9..4191b5bfcdf3 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -4,6 +4,8 @@
>   */
>  
>  #include <dt-bindings/clock/imx8mn-clock.h>
> +#include <dt-bindings/power/imx8mn-power.h>
> +#include <dt-bindings/reset/imx8mq-reset.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -612,6 +614,53 @@ src: reset-controller@30390000 {
>  				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
>  				#reset-cells = <1>;
>  			};
> +
> +			gpc: gpc@303a0000 {
> +				compatible = "fsl,imx8mn-gpc";
> +				reg = <0x303a0000 0x10000>;
> +				interrupt-parent = <&gic>;
> +				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> +
> +				pgc {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					pgc_hsiomix: power-domain@0 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8MN_POWER_DOMAIN_HSIOMIX>;
> +						clocks = <&clk IMX8MN_CLK_USB1_CTRL_ROOT>;

This should be IMX8MN_CLK_USB_BUS.

Regards,
Lucas

> +					};
> +
> +					pgc_otg1: power-domain@1 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8MN_POWER_DOMAIN_OTG1>;
> +						power-domains = <&pgc_hsiomix>;
> +					};
> +
> +					pgc_gpumix: power-domain@2 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8MN_POWER_DOMAIN_GPUMIX>;
> +						clocks = <&clk IMX8MN_CLK_GPU_CORE_ROOT>,
> +							 <&clk IMX8MN_CLK_GPU_SHADER_DIV>,
> +							 <&clk IMX8MN_CLK_GPU_BUS_ROOT>,
> +							 <&clk IMX8MN_CLK_GPU_AHB>;
> +						resets = <&src IMX8MQ_RESET_GPU_RESET>;
> +					};
> +
> +					pgc_dispmix: power-domain@3 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8MN_POWER_DOMAIN_DISPMIX>;
> +						clocks = <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
> +							 <&clk IMX8MN_CLK_DISP_APB_ROOT>;
> +					};
> +
> +					pgc_mipi: power-domain@4 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8MN_POWER_DOMAIN_MIPI>;
> +						power-domains = <&pgc_dispmix>;
> +					};
> +				};
> +			};
>  		};
>  
>  		aips2: bus@30400000 {


