Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0377458299
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 09:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbhKUI6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 03:58:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229972AbhKUI6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 03:58:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 689BA60231;
        Sun, 21 Nov 2021 08:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637484907;
        bh=BSrNBk1+xTVdjY/KH9HeiQ19aqGKk4qtpYXlS/s+Bi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tatESt2cVzf7HD/KkoxWzf6u8sn0XI27B+PpnyEvnlG5TRXVuC3dZOd3am3b8I+C0
         5G3PaGYVPSDNLTfsws9MbU7DSfDXQec8L3S1EMA9SYP602lbQgq6TdNKLPv8gTEa5W
         h4DCKpMJQ69txcLZBiZHHTb+zpZ7YZa6TMBeXJeGSrQo2O1ejc+DSL0yiwmEZ0s+V+
         WCx5dJPVXpxqkVOL46x0LUbKwTPT8WRQ0p3QZIEzDFCrXuB3380URRWhZ3jicWE4qv
         oOo20/GIDVTxQJ1xkqHyCxvtvXYImCo1uJ/UQjPqhwKjtnE9Iw3RWmw+ZHfm4kZCJx
         gaXkZ8rHGV2lw==
Date:   Sun, 21 Nov 2021 16:55:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        ~okias/devicetree@lists.sr.ht, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/3] arm64: dts: make dts use gpio-fan matrix instead
 of array
Message-ID: <20211121085457.GN31998@dragon>
References: <20211029114948.41841-1-david@ixit.cz>
 <20211029114948.41841-2-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029114948.41841-2-david@ixit.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 01:49:45PM +0200, David Heidelberg wrote:
> No functional changes.
> 
> Adjust to comply with dt-schema requirements
> and make possible to validate values.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 9 +++++----
>  arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts     | 2 +-

You may want to split it per platform, so that corresponding platform
maintainer can pick them up.

Shawn

>  arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi     | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts    | 5 +++--
>  4 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> index 86bdc0baf032..fbbcacf24f2e 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> @@ -52,10 +52,11 @@ gpio_fan: gpio-fan {
>  		gpios = <&gpio GPIODV_14 GPIO_ACTIVE_HIGH
>  			 &gpio GPIODV_15 GPIO_ACTIVE_HIGH>;
>  		/* Dummy RPM values since fan is optional */
> -		gpio-fan,speed-map = <0 0
> -				      1 1
> -				      2 2
> -				      3 3>;
> +		gpio-fan,speed-map =
> +				<0 0>,
> +				<1 1>,
> +				<2 2>,
> +				<3 3>;
>  		#cooling-cells = <2>;
>  	};
>  
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
> index a3b9d615a3b4..e34045d10a12 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
> @@ -39,7 +39,7 @@ reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
>  
>  	fan: gpio-fan {
>  		compatible = "gpio-fan";
> -		gpio-fan,speed-map = <0 0 8600 1>;
> +		gpio-fan,speed-map = <0 0>, <8600 1>;
>  		gpios = <&gpio3 5 GPIO_ACTIVE_HIGH>;
>  		#cooling-cells = <2>;
>  		pinctrl-names = "default";
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
> index 46b0f97a0b1c..4af535866d1f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
> @@ -44,7 +44,7 @@ dc_12v: dc-12v {
>  	fan0: gpio-fan {
>  		#cooling-cells = <2>;
>  		compatible = "gpio-fan";
> -		gpio-fan,speed-map = <0 0 3000 1>;
> +		gpio-fan,speed-map = <0 0>, <3000 1>;
>  		gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
>  		status = "okay";
>  	};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> index 4d4b2a301b1a..8af3763daaba 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> @@ -30,8 +30,9 @@ gmac1_clkin: external-gmac1-clock {
>  	fan: gpio_fan {
>  		compatible = "gpio-fan";
>  		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
> -		gpio-fan,speed-map = <0    0
> -				      4500 1>;
> +		gpio-fan,speed-map =
> +				<   0 0>,
> +				<4500 1>;
>  		#cooling-cells = <2>;
>  	};
>  
> -- 
> 2.33.0
> 
