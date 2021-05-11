Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F448379CE4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 04:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhEKCXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 22:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhEKCXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 22:23:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7F0E6162B;
        Tue, 11 May 2021 02:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620699749;
        bh=J49dWfDtr/uMNE/FC4yL9V1Co9tZspE5lpR1SyxOHjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TpsjRagjADiC1FUuy2fCOnZL1eoYMaycgp44lLT/0ugp4Uc5b87Vkf3z/PfxXLpOL
         SFN+wNCjPzeLCpDHm7nzLJphs9OcP5SQxNEMrMnulAyt6qBCwLwJZ8CfHoVfENkHye
         5aXeThsD/0k+BqOdfIBgCn7ZJlcSr09FrpAPRDiTamBvEnLpeKRqMJnGs2tiKy3aBN
         nQT1/qwbinEV4GMBBx44UqtYZ9Q1v4Io4MVybbSOCzst+47PhWr4Ot9W4+rKpHYDFA
         S0etXL9L21PVGOFJQlqVHqrBPrjAi4diWzGJ+j9Dub0KCyhR/IFSc31cwfXuRMm2PK
         Wct5kJPnW0gvw==
Date:   Tue, 11 May 2021 10:22:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, catalin.marinas@arm.com,
        will@kernel.org, bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] arm64: dts: imx8mq-nitrogen: add USB HOST support
Message-ID: <20210511022222.GB3425@dragon>
References: <20210331232356.2204476-1-adrien.grassein@gmail.com>
 <20210331232356.2204476-3-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331232356.2204476-3-adrien.grassein@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 01:23:54AM +0200, Adrien Grassein wrote:
> Add the description for the USB host port.
> This port is linked to a resettable USB HUB so handle
> this reset signal with a GPIO hog.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../boot/dts/freescale/imx8mq-nitrogen.dts    | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
> index b46f45a82be1..04992cbba56e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
> @@ -102,6 +102,14 @@ ethphy0: ethernet-phy@4 {
>  	};
>  };
>  
> +&gpio1 {
> +	usb-host-reset-hog {
> +		gpio-hog;
> +		gpios = <14 GPIO_ACTIVE_HIGH>;
> +		output-high;
> +	};
> +};
> +
>  &i2c1 {
>  	clock-frequency = <400000>;
>  	pinctrl-names = "default";
> @@ -213,6 +221,22 @@ &usb3_phy0 {
>  	status = "okay";
>  };
>  
> +&usb_dwc3_1 {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +/*
> + * On this board, USB host is connected to a resettable hub.
> + * The reset signal is connected to the GPIO <&gpio1 14 GPIO_ACTIVE_LOW>.
> + * You need to activate it in the bootloader or in the userspace.
> + */
> +&usb3_phy1 {
> +	status = "okay";

We usually end property list with 'status'.

Shawn

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usb3_1>;
> +};
> +
>  &usdhc1 {
>  	assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
>  	assigned-clock-rates = <400000000>;
> @@ -388,6 +412,12 @@ MX8MQ_IOMUXC_GPIO1_IO13_USB1_OTG_OC		0x16
>  		>;
>  	};
>  
> +	pinctrl_usb3_1: usb3-1grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_GPIO1_IO14_GPIO1_IO14		0x16
> +		>;
> +	};
> +
>  	pinctrl_usdhc1: usdhc1grp {
>  		fsl,pins = <
>  			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x83
> -- 
> 2.25.1
> 
