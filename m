Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8421C421F05
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 08:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhJEGry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 02:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230526AbhJEGrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 02:47:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFEBB61165;
        Tue,  5 Oct 2021 06:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633416362;
        bh=iGLwEOScmgytD/tatPTnU36QZ0hfNyjNwouQNp+Iiaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAdXpzYDIpOOkIOzMHf22hymEY6OK3i2IJz3WTzXZCKvSyGamanePwEfb7yuv5gMU
         pHcVuDSaJ5V1eqMwYkZ46KpSggSa41W/mQFPDLTz7gbeELKxk0ofXo+bxDfp9KBoEk
         zOOgH3I9r3qLN8fzZ0bjEbnIEvBL8SKr23TVN/KSPxjSNkHwpaxbEoqvbrfFTD6N28
         jRgjWBodlX3teHis5HikVRvl4TMuOhQR/N5ghCUyyKqH5P4xS1B3FFzKammbgSQ1jo
         MDwNeeGW/+SiVJcUx52HgmoilWN6g+fSUTQfhW6HNDuqVxgV8RG9z6AwKkdvh/B+5O
         GX0m/a8l0STjw==
Date:   Tue, 5 Oct 2021 14:45:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 1/8] arm64: dts: imx8mm-kontron: Add support for ultra
 high speed modes on SD card
Message-ID: <20211005064556.GX20743@dragon>
References: <20210930155633.2745201-1-frieder@fris.de>
 <20210930155633.2745201-2-frieder@fris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930155633.2745201-2-frieder@fris.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 05:56:24PM +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> In order to use ultra high speed modes (UHS) on the SD card slot, we
> add matching pinctrls and fix the voltage switching for LDO5 of the
> PMIC, by providing the SD_VSEL pin as GPIO to the PMIC driver.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  .../dts/freescale/imx8mm-kontron-n801x-s.dts  | 28 ++++++++++++++++++-
>  .../freescale/imx8mm-kontron-n801x-som.dtsi   |  2 ++
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
> index d17abb515835..62ba3bd08a0c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
> @@ -189,8 +189,10 @@ usbnet: usbether@1 {
>  };
>  
>  &usdhc2 {
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>  	pinctrl-0 = <&pinctrl_usdhc2>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
>  	vmmc-supply = <&reg_vdd_3v3>;
>  	vqmmc-supply = <&reg_nvcc_sd>;
>  	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> @@ -319,4 +321,28 @@ MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
>  			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
>  		>;
>  	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {

Did you run dtbs_check on it?

Shawn

> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x194
> +			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d4
> +			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4
> +			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
> +			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
> +			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
> +			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x196
> +			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d6
> +			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d6
> +			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
> +			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
> +			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
> +			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
> +		>;
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> index d0456daefda8..03b3516abd64 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> @@ -86,6 +86,7 @@ pca9450: pmic@25 {
>  		pinctrl-0 = <&pinctrl_pmic>;
>  		interrupt-parent = <&gpio1>;
>  		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +		sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
>  
>  		regulators {
>  			reg_vdd_soc: BUCK1 {
> @@ -225,6 +226,7 @@ MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c3
>  	pinctrl_pmic: pmicgrp {
>  		fsl,pins = <
>  			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x141
> +			MX8MM_IOMUXC_GPIO1_IO04_GPIO1_IO4		0x141
>  		>;
>  	};
>  
> -- 
> 2.33.0
> 
