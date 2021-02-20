Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5B93206E5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 20:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhBTTXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 14:23:35 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:35758 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhBTTXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 14:23:32 -0500
Received: by mail-ed1-f42.google.com with SMTP id n1so16648440edv.2;
        Sat, 20 Feb 2021 11:23:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JzFKHqvuSUGXCnevV5+iFx0p/nySPaeOSAeBEwyhoZM=;
        b=ZYWSvGFmEVGGdL6Llne/zicjntLd3r3uHogqtJnRJXgopio2w+RkrfkHytYpjIOvRu
         Cq4yHhZCinKo3pNUEYWxYQu6ixY8jZ1Q711BoHlq4hDnsUaqBWz4I2Tv+SByCV60Cuxn
         oAhZmcagNI2DUB8uApQMGTsQPhCXZJLHBktxpLv+OIDf320bEB/xXY0oE7GVqmGHP2CA
         CgeeCwzOciCe9ie+Bu2Xua7t9Mqc2yDk1R7rk82t0KwvkIPp4jqaN1XTABcj5IHUQhc2
         u0FCX8KJsDqWnf2KVNgaJtycgWcq1ZbBkyL+uJ67XEGZDrz5kXjGUFVuUxINhHgOokFP
         /heg==
X-Gm-Message-State: AOAM533UdQScpViO5Vju+o+7xpTPlQfdBu3cTnCXIl31/7ICYWqZVIl3
        qkw7M3yzyCABOHEAayytxVOCMuDSzAE=
X-Google-Smtp-Source: ABdhPJzM9MWlsrTf8/OshCZ1sv8gKEwc9FTZajGLSwthP3mMiTUtfDoWeQkCLEz68cHLu7p0fc+0jg==
X-Received: by 2002:a50:aac8:: with SMTP id r8mr14937708edc.9.1613848970522;
        Sat, 20 Feb 2021 11:22:50 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id k4sm4856721ejv.73.2021.02.20.11.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 11:22:49 -0800 (PST)
Date:   Sat, 20 Feb 2021 20:22:48 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
Message-ID: <20210220192248.2x4zk4zvorxbjsen@kozik-lap>
References: <20210219143028.207975-1-adrien.grassein@gmail.com>
 <20210219143028.207975-2-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210219143028.207975-2-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 03:30:20PM +0100, Adrien Grassein wrote:
> Add usdhc3 description which corresponds to the wifi/bt chip
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> index c0c384d76147..4a3dabeb8c85 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> @@ -9,6 +9,24 @@
>  / {
>  	model = "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
>  	compatible = "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm";
> +
> +	reg_vref_1v8: regulator-vref-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vref-1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
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
> @@ -206,6 +224,20 @@ &usdhc2 {
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
> +	vqmmc-supply = <&reg_vref_1v8>;

You sent v3 before I replied on your comments. I don't think there is
any benefit in fixed-regulator which cannot be controlled. Are you sure
vqmmc (the bus clock, host interface, controller core?) does not go from
the PMIC?

Best regards,
Krzysztof
