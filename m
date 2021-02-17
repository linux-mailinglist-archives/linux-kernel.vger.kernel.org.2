Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B304E31DB62
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhBQOXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:23:42 -0500
Received: from mail-ej1-f41.google.com ([209.85.218.41]:40289 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbhBQOXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:23:32 -0500
Received: by mail-ej1-f41.google.com with SMTP id b14so16462212eju.7;
        Wed, 17 Feb 2021 06:23:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/cZ1TPSfhwcT7eeaWpLG2b2x+qUWHwcJjDjHqV8vqz8=;
        b=mgFgIEqqnXwz0eMgabcUf2yaKLdE7VaC+CWxm6Uk+k07eqrZUjKe2SayoPUXTNd3hC
         SNW/CPdkW0FZmqyLfZtpUH25dE5Zd3mY70eOeI1KHEiDIqyGP8u/P0j7Jud+ggG9gvjY
         3jOOOwN4vic0aRS3MBTD/kv6VkrMw1c/pUJ57h5nYtrwskaJwqbgezY6Dpuc51U5adSM
         iX+TtkYugTJWKjMYdoToJrZRJnpCHex2KgkCH7UPsuLnNUpSr36tzlr43dfQ2sz1hFdq
         JeaTCVo5SsuOQWg3ngqCjaqotnNN6n3OaptpOxcwDOSxIJYO2WqejluUx4snk34sa5vY
         3xxg==
X-Gm-Message-State: AOAM530sfAeM2pPc0XpUdo+WCnv5OAc0no944qGaW2hxqKtZ++m4ukG+
        HlkqXtsUqMCuM08+t42pM6k=
X-Google-Smtp-Source: ABdhPJxvm+4w8jYCGbVq1X1GGG/XVSiVzPd1/5/eZsnm9n1dc1nwiQUnQgCal6Os3p3nACTexccIFA==
X-Received: by 2002:a17:906:7697:: with SMTP id o23mr18674348ejm.292.1613571770988;
        Wed, 17 Feb 2021 06:22:50 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id z16sm1072289ejd.102.2021.02.17.06.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 06:22:49 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:22:48 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] arm64: dts: imx8mm-nitrogen-r2: add uarts
Message-ID: <20210217142248.klq36mraspeehiqj@kozik-lap>
References: <20210215231943.36910-1-adrien.grassein@gmail.com>
 <20210215231943.36910-5-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215231943.36910-5-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 12:19:39AM +0100, Adrien Grassein wrote:
> Add description and pinmuxing for uarts.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 53 ++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> index 22acde0f3ba8..3c5b692f6ad1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> @@ -206,6 +206,15 @@ rtc@68 {
>  	};
>  };
>  
> +/* BT */
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	assigned-clocks = <&clk IMX8MM_CLK_UART1>;

I see you have it also for uart2 - what is the purpose of it? What does
the "assigned-clocks" property alone do?

> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
>  /* console */
>  &uart2 {
>  	pinctrl-names = "default";
> @@ -215,6 +224,23 @@ &uart2 {
>  	status = "okay";
>  };
>  
> +/* J15 */
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	assigned-clocks = <&clk IMX8MM_CLK_UART3>;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +/* J9 */
> +&uart4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart4>;
> +	assigned-clocks = <&clk IMX8MM_CLK_UART4>;
> +	status = "okay";
> +};
> +
>  /* eMMC */
>  &usdhc1 {
>  	bus-width = <8>;
> @@ -353,6 +379,15 @@ MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20 0x16
>  		>;
>  	};
>  
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX 0x140
> +			MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX 0x140
> +			MX8MM_IOMUXC_UART3_RXD_UART1_DCE_CTS_B 0x140
> +			MX8MM_IOMUXC_UART3_TXD_UART1_DCE_RTS_B 0x140
> +		>;
> +	};
> +
>  	pinctrl_uart2: uart2grp {
>  		fsl,pins = <
>  			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX 0x140
> @@ -360,6 +395,22 @@ MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX 0x140
>  		>;
>  	};
>  
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_ECSPI1_SCLK_UART3_DCE_RX 0x140
> +			MX8MM_IOMUXC_ECSPI1_MOSI_UART3_DCE_TX 0x140
> +			MX8MM_IOMUXC_ECSPI1_SS0_UART3_DCE_RTS_B 0x140
> +			MX8MM_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B 0x140
> +		>;
> +	};
> +
> +	pinctrl_uart4: uart4grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_UART4_RXD_UART4_DCE_RX 0x140
> +			MX8MM_IOMUXC_UART4_TXD_UART4_DCE_TX 0x140
> +		>;
> +	};
> +
>  	pinctrl_usbotg1: usbotg1grp {
>  		fsl,pins = <
>  			MX8MM_IOMUXC_GPIO1_IO12_USB1_OTG_PWR	0x16
> @@ -370,7 +421,7 @@ MX8MM_IOMUXC_GPIO1_IO13_USB1_OTG_OC	0x156
>  	pinctrl_usbotg2: usbotg2grp {
>  		fsl,pins = <
>  			MX8MM_IOMUXC_GPIO1_IO14_USB2_OTG_PWR	0x16
> -			MX8MM_IOMUXC_GPIO1_IO15_USB2_OTG_OC	0x156
> +			MX8MM_IOMUXC_GPIO1_IO15_USB2_OTG_OC	0x15

This is not relevant to the topic.

Best regards,
Krzysztof
