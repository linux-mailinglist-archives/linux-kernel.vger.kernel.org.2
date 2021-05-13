Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B109E37F8DC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhEMNgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233997AbhEMNga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:36:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B81461363;
        Thu, 13 May 2021 13:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620912919;
        bh=HDpcTZC6Tjfu3QfZbpafDsghdkb70bSqEzahKtVZt1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tJlXnHCahMn0YaLqyDMkcKi4GQPk49ILMVwovOrO9Ts8P9VIJzrWWOhbiXgBX0v9u
         dHZn2M9pkVVWKkHXm5u8GNabxZJel3Jw97hjiyOMnifqKRMf/bgVys5B3g/qw9mNfs
         eVb2RtbGJA8Fe06BBCCI0Ky0dpdzq3JtHqmHivg9QzCJwYSEvENIPceJe8y4x64xfr
         5kwyExHNH4yTy7rlz/aaNqP/mSC0Hez4UO/ci6upXSU5Rs4E2k2UiE1+rrLXaR+VN/
         6VFpearoKqpvoE1UQkAVOur411bjTKrx6PgFhi3vr1KkqIUO1kvMeL7h72v5uueHnk
         VjjE/CZReNGnw==
Date:   Thu, 13 May 2021 21:35:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.co,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com
Subject: Re: [PATCH] ARM: imx7d-remarkable2.dts: Add WiFi support
Message-ID: <20210513133512.GZ3425@dragon>
References: <20210418210003.2806-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210418210003.2806-1-alistair@alistair23.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 07:00:03AM +1000, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

I would suggest you add some commit log, and have subject like below.

ARM: dts: imx7d-remarkable2: Add WiFi support

> ---
>  arch/arm/boot/dts/imx7d-remarkable2.dts | 91 +++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> index 8cbae656395c..c3dda2b92fe6 100644
> --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> @@ -21,6 +21,27 @@ memory@80000000 {
>  		device_type = "memory";
>  		reg = <0x80000000 0x40000000>;
>  	};
> +
> +	reg_brcm: regulator-brcm {
> +		compatible = "regulator-fixed";
> +		regulator-name = "brcm_reg";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_brcm_reg>;
> +		gpio = <&gpio6 13 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		startup-delay-us = <150>;
> +	};
> +
> +	wifi_pwrseq: wifi_pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_wifi>;
> +		reset-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
> +		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
> +		clock-names = "ext_clock";
> +	};
>  };
>  
>  &clks {
> @@ -56,6 +77,27 @@ &usbotg2 {
>  	status = "okay";
>  };
>  
> +&usdhc2 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default", "state_100mhz", "sleep";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;

state_200mhz is missing.

Shawn

> +	pinctrl-2 = <&pinctrl_usdhc2>;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	vmmc-supply = <&reg_brcm>;
> +	bus-width = <4>;
> +	non-removable;
> +	keep-power-in-suspend;
> +	cap-power-off-card;
> +	status = "okay";
> +
> +	brcmf: bcrmf@1 {
> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> +	};
> +};
> +
>  &usdhc3 {
>  	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
>  	pinctrl-0 = <&pinctrl_usdhc3>;
> @@ -76,6 +118,13 @@ &wdog1 {
>  };
>  
>  &iomuxc {
> +	pinctrl_brcm_reg: brcmreggrp {
> +		fsl,pins = <
> +			/* WIFI_PWR_EN */
> +			MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
> +		>;
> +	};
> +
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins = <
>  			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
> @@ -90,6 +139,39 @@ MX7D_PAD_EPDC_DATA08__UART6_DCE_RX		0x79
>  		>;
>  	};
>  
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX7D_PAD_SD2_CMD__SD2_CMD		0x59
> +			MX7D_PAD_SD2_CLK__SD2_CLK		0x19
> +			MX7D_PAD_SD2_DATA0__SD2_DATA0		0x59
> +			MX7D_PAD_SD2_DATA1__SD2_DATA1		0x59
> +			MX7D_PAD_SD2_DATA2__SD2_DATA2		0x59
> +			MX7D_PAD_SD2_DATA3__SD2_DATA3		0x59
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2grp_100mhz {
> +		fsl,pins = <
> +			MX7D_PAD_SD2_CMD__SD2_CMD		0x5a
> +			MX7D_PAD_SD2_CLK__SD2_CLK		0x1a
> +			MX7D_PAD_SD2_DATA0__SD2_DATA0		0x5a
> +			MX7D_PAD_SD2_DATA1__SD2_DATA1		0x5a
> +			MX7D_PAD_SD2_DATA2__SD2_DATA2		0x5a
> +			MX7D_PAD_SD2_DATA3__SD2_DATA3		0x5a
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2grp_200mhz {
> +		fsl,pins = <
> +			MX7D_PAD_SD2_CMD__SD2_CMD		0x5b
> +			MX7D_PAD_SD2_CLK__SD2_CLK		0x1b
> +			MX7D_PAD_SD2_DATA0__SD2_DATA0		0x5b
> +			MX7D_PAD_SD2_DATA1__SD2_DATA1		0x5b
> +			MX7D_PAD_SD2_DATA2__SD2_DATA2		0x5b
> +			MX7D_PAD_SD2_DATA3__SD2_DATA3		0x5b
> +		>;
> +	};
> +
>  	pinctrl_usdhc3: usdhc3grp {
>  		fsl,pins = <
>  			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
> @@ -143,4 +225,13 @@ pinctrl_wdog: wdoggrp {
>  			MX7D_PAD_ENET1_COL__WDOG1_WDOG_ANY	0x74
>  		>;
>  	};
> +
> +	pinctrl_wifi: wifigrp {
> +		fsl,pins = <
> +			/* WiFi Reg On */
> +			MX7D_PAD_SD2_CD_B__GPIO5_IO9		0x00000014
> +			/* WiFi Sleep 32k */
> +			MX7D_PAD_SD1_WP__CCM_CLKO2		0x00000014
> +		>;
> +	};
>  };
> -- 
> 2.31.1
> 
