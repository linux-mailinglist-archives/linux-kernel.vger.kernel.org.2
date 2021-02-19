Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C5B31F9CB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 14:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhBSNTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 08:19:13 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:40435 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBSNTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 08:19:10 -0500
Received: by mail-wr1-f53.google.com with SMTP id v14so8433426wro.7;
        Fri, 19 Feb 2021 05:18:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KVqyxNcnB00VMULwUWGBYcw+bI2owGiteqtWDwQJW0s=;
        b=cmfh5Q+KJkpUEMqv/10CJaRKqqUJcCsSh4P/ir/vdkkweSk7DWRvCHDueveFKsbeEa
         DCO6ItXX+x7Bev6ufejParGrNXoRj8uIspREQDJrLKl4P1m0RmyrA8mxc8WCq8loILJt
         dWocoRvoTGHxPbfu2BeP/aIA6U05if7CTwxG9oy/Fkg9alif3tsrmUkGFwgHuuvHCLeL
         3xxCpd+d0jxhW3VgF+NKNXjH3R1/RZB9PR4MIL8nwUVxv4a4u4BCud5pwXN3OQCwBX3p
         oeH+1+4KOO78QAZqVGR3/zV5ys/cpT73CILX2GveDrbjfLIaXrbtcMCD4vkLxfzfhHlS
         li7A==
X-Gm-Message-State: AOAM531YZv8kTLzbtyZzG9XBL7ykSdDRHrDw3Jy+lJvQbEjYfGS9KqvE
        L8d/zvx0YeApPOYeStUexYo=
X-Google-Smtp-Source: ABdhPJxIgrFH7LQQLMjM+IvHEsXLwlJDIcAu94ti8CTUFmVNPSHgUm6S9Kj/IP3WCYyQ4Ek4cWJ8jg==
X-Received: by 2002:adf:f14b:: with SMTP id y11mr2388704wro.80.1613740708103;
        Fri, 19 Feb 2021 05:18:28 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id x11sm12967755wrv.83.2021.02.19.05.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 05:18:27 -0800 (PST)
Date:   Fri, 19 Feb 2021 14:18:25 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
Message-ID: <20210219131825.niiftfm5r32qc6m3@kozik-lap>
References: <20210217161052.877877-1-adrien.grassein@gmail.com>
 <20210217161052.877877-2-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210217161052.877877-2-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 05:10:45PM +0100, Adrien Grassein wrote:
> Add usdhc3 description which corresponds to the wifi/bt chip
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> index c0c384d76147..212dc9e5e85d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> @@ -9,6 +9,17 @@
>  / {
>  	model = "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
>  	compatible = "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm";
> +
> +	reg_wlan_vmmc: regulator-wlan-vmmc {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_wlan_vmmc>;
> +		regulator-name = "reg_wlan_vmmc";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio3 20 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
>  };
>  
>  &A53_0 {
> @@ -206,6 +217,20 @@ &usdhc2 {
>  	status = "okay";
>  };
>  
> +/* wlan */
> +&usdhc3 {
> +	bus-width = <4>;
> +	sdhci-caps-mask = <0x2 0x0>;
> +	non-removable;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +	vmmc-supply = <&reg_wlan_vmmc>;
> +	vqmmc-1-8-v;

There is no such property in the bindings.

Best regards,
Krzysztof
