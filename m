Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DAA420A89
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbhJDMCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhJDMCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:02:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF37D6136F;
        Mon,  4 Oct 2021 12:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633348862;
        bh=KedfUiHTHFdKBqDMUFp//yfqESdnS5zwFhj4rJZj11Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kdd6xS/Cywh2ing8rz4BfiOjwLsEo+AmAJOIq/FPXIdMV6IumDmk8f7xmwmTxcBj8
         QaAOj5pjFSt3mg26mdx/IUC6Guv0q/OqtF4blaPloqCvBGhAAqydEfzMCHQmNSWgbg
         G/AUK33RHDsVnwdAD6ZwIf3SSHWFBfUot1qFkl2Q70tOLd3KShBLMjL2v8mR1xtpRH
         dQsfbfieyg4mAfj0rU0NcTWogW23cGJcRmrFZ0TskO/ytefcW2FltRgXVOmn4wCRJa
         y0hB+M1rcnbI9m61Ifka6j0w15QpWVLNfXsHunHBxof530p3d75Z8yBDGJhcUQku3P
         ReDEcvO7waO2A==
Date:   Mon, 4 Oct 2021 20:00:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        kernel@puri.sm, Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH v1 3/6] arm64: dts: imx8mq-librem5: wire up the wifi
 regulator
Message-ID: <20211004120054.GG15650@dragon>
References: <20210913135706.309685-1-martin.kepplinger@puri.sm>
 <20210913135706.309685-4-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210913135706.309685-4-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 03:57:03PM +0200, Martin Kepplinger wrote:
> From: Guido Günther <agx@sigxcpu.org>
> 
> Connect the wifi power regulator to the corresponding GPIO.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> index ba26c6ee98a0..b5562c8f9a3c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> @@ -138,9 +138,15 @@ reg_vsys_3v4: regulator-vsys-3v4 {
>  
>  	reg_wifi_3v3: regulator-wifi-3v3 {
>  		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_wifi_pwr>;
>  		regulator-name = "3V3_WIFI";
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio3 10 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		vin-supply = <&reg_vdd_3v3>;
> +		regulator-always-on;

Any reason you need to have this always-on?

Shawn

>  	};
>  
>  	sound {
> @@ -638,6 +644,13 @@ MX8MQ_IOMUXC_SD2_RESET_B_USDHC2_RESET_B 0xc1
>  		>;
>  	};
>  
> +	pinctrl_wifi_pwr: wifipwrgrp {
> +		fsl,pins = <
> +			/* WIFI3V3_EN */
> +			MX8MQ_IOMUXC_NAND_DATA04_GPIO3_IO10	0x83
> +		>;
> +	};
> +
>  	pinctrl_wdog: wdoggrp {
>  		fsl,pins = <
>  			/* nWDOG */
> -- 
> 2.30.2
> 
