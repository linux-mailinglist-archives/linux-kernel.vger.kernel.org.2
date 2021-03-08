Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EC9330566
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 01:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbhCHAgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 19:36:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:58300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229922AbhCHAfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 19:35:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D0AF64FAC;
        Mon,  8 Mar 2021 00:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615163733;
        bh=8dT0xfzxkUdyQ6TABw06p1wI9meAzWGET7N3Q2Am8KQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BPvjLqkvwZ0qY5R1HGAJLaRKAiX0LMmuTYL6G5M3OL47ZM0GdXT8Pc7meo1yOWwxD
         gnos4L22IL4x/YyYExdo5mzoCpVQjhwa1eD/0A1IB/+Hpue+Jt11bCpVUyyzF9PRmZ
         UGE2Kde+XbfkWafMM0v4AS8tyKiJg7fq1FlVdu2BwZjWVgHP/L/qDkReXI1UVsMl1c
         92nkp2IMxkHMU17kJcL+Zoqv/D0VoWV3UWxZFvSIkbFpANPwJqjOq/+5URa6USpxa7
         L98Kkt3B1AHbZ0mcwXHp/5QPpzuy8ScLPb/OK92OM3NoS6vSvKSMB4zNC7cLmH4Pr+
         +mRYndzQGVBBw==
Date:   Mon, 8 Mar 2021 08:35:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv1 1/4] ARM: dts: imx: ba16: add USB OTG VBUS enable GPIO
Message-ID: <20210308003526.GK543@dragon>
References: <20210223183346.138575-1-sebastian.reichel@collabora.com>
 <20210223183346.138575-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223183346.138575-2-sebastian.reichel@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 07:33:43PM +0100, Sebastian Reichel wrote:
> Add VBUS regulator GPIO information, so that USB OTG port can
> also be used in host mode.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

'ARM: dts: imx6q-ba16: ' this style for prefix maybe?

> ---
>  arch/arm/boot/dts/imx6q-ba16.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/imx6q-ba16.dtsi
> index e4578ed3371e..4793ef5171aa 100644
> --- a/arch/arm/boot/dts/imx6q-ba16.dtsi
> +++ b/arch/arm/boot/dts/imx6q-ba16.dtsi
> @@ -124,6 +124,10 @@ reg_usb_otg_vbus: regulator-usbotgvbus {
>  		regulator-name = "usb_otg_vbus";
>  		regulator-min-microvolt = <5000000>;
>  		regulator-max-microvolt = <5000000>;
> +

This is newline is not necessary.

Shawn

> +		pinctrl-0 = <&pinctrl_usbotg_vbus>;
> +		gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
>  	};
>  };
>  
> @@ -575,6 +579,12 @@ MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID 0x17059
>  		>;
>  	};
>  
> +	pinctrl_usbotg_vbus: usbotgvbusgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15 0x000b0
> +		>;
> +	};
> +
>  	pinctrl_usdhc2: usdhc2grp {
>  		fsl,pins = <
>  			MX6QDL_PAD_SD2_CMD__SD2_CMD	0x17059
> -- 
> 2.30.0
> 
