Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F3231D8F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 13:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhBQL7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:59:44 -0500
Received: from mail-ej1-f52.google.com ([209.85.218.52]:43337 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhBQL66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:58:58 -0500
Received: by mail-ej1-f52.google.com with SMTP id i23so15359407ejg.10;
        Wed, 17 Feb 2021 03:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=erCIbWwHyy0kxKaSupmXnRMAfJfKXIaVx29x2jmxgNw=;
        b=hV5XR1uUNurqara30Eo4cSj4fVN0IVYdszYupoNc5lqvH9GciSnwvn3UZQAOp4rwk+
         eWV7sCqjosIss0muspyV3Dj0W4m6LMfY60uIYR+y91l0BuxG0MWwts/PFF3JDTPVkSEX
         2j9nXVszzJKPoK5GVTRanVSbmLFi60YlXds7BKaASbSbB6XbEVmIMYd5wh2+SnFSLOmK
         nk4mfPVadPbVEK7uENV2L249taCDLocCBu8jMHbK+k2Gzcd8lsNVvUaeMM2IMzKkKdPo
         BF0ICxTJe0LyHDU6BH0iFUrMsDpFQila7MiNxmaoa3iJDntOPAy5V102eSD3beGC5mm2
         U6tg==
X-Gm-Message-State: AOAM532mvGqRGwNPZ29lSf2ugUCflDVaytQlD239XIAj0pjkqGkxCCa7
        XUcuXAdU3zyH94leG715zs0=
X-Google-Smtp-Source: ABdhPJxQtSvc107eIURtn03bp6/fSuo9tLZn/i1hvJr22pX/Rgb49D3j+cNh4OWwLnH4FEkpi2HSGA==
X-Received: by 2002:a17:906:654d:: with SMTP id u13mr24389656ejn.299.1613563096453;
        Wed, 17 Feb 2021 03:58:16 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id a1sm1018963edj.6.2021.02.17.03.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 03:58:15 -0800 (PST)
Date:   Wed, 17 Feb 2021 12:58:14 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
Message-ID: <20210217115814.zfwhd5fwb2ibygt3@kozik-lap>
References: <20210215231943.36910-1-adrien.grassein@gmail.com>
 <20210215231943.36910-2-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215231943.36910-2-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 12:19:36AM +0100, Adrien Grassein wrote:
> Add usdhc3 description which corresponds to the wifi/bt chip
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> index c0c384d76147..bf20a40bcda0 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> @@ -9,6 +9,18 @@
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
> +		startup-delay-us = <70000>;

That's quite a startup time... and it happens is the same as in bindings
example. Do you really need it or it was just copied?

I actually don't mind it, just poking at various things. :)

> +	};
>  };
>  
>  &A53_0 {
> @@ -206,6 +218,19 @@ &usdhc2 {
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

What about vqmmc?

Best regards,
Krzysztof
