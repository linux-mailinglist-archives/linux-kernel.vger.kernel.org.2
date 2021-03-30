Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FD534E34A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhC3IjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhC3Iif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:38:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AA4C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:38:34 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lR9tH-0005fI-95; Tue, 30 Mar 2021 10:38:23 +0200
Subject: Re: [PATCH v1 2/4] arm64: dts: imx8mq-nitrogen: add USB HOST support
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     devicetree@vger.kernel.org, will@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        krzk@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, catalin.marinas@arm.com,
        festevam@gmail.com, linux-arm-kernel@lists.infradead.org
References: <20210330083514.5874-1-adrien.grassein@gmail.com>
 <20210330083514.5874-3-adrien.grassein@gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <0d173681-7eb6-798f-7d9b-66a221625d34@pengutronix.de>
Date:   Tue, 30 Mar 2021 10:38:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210330083514.5874-3-adrien.grassein@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Adrien,

On 30.03.21 10:35, Adrien Grassein wrote:
> Add the description for the USB host port.
> At this time, the port will not work directly from the
> kernel because it's connected through a resettable hub
> that is not handle in the kernel. It should be controlled
> in the bootloader or in the userspace.

Couldn't you add a gpio-hog that gets the hub out of reset?

Cheers,
Ahmad

> 
> In the case of the Boundary's u-boot, this is done on the
> boot script:
> "
> starting USB...
> Bus usb@38100000: Register 2000140 NbrPorts 2
> Starting the controller
> USB XHCI 1.10
> Bus usb@38200000: Register 2000140 NbrPorts 2
> Starting the controller
> USB XHCI 1.10
> scanning bus usb@38100000 for devices... 1 USB Device(s) found
> scanning bus usb@38200000 for devices... 3 USB Device(s) found
> "
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../boot/dts/freescale/imx8mq-nitrogen.dts    | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
> index b46f45a82be1..7a52e247c527 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
> @@ -213,6 +213,22 @@ &usb3_phy0 {
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
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usb3_1>;
> +};
> +
>  &usdhc1 {
>  	assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
>  	assigned-clock-rates = <400000000>;
> @@ -388,6 +404,12 @@ MX8MQ_IOMUXC_GPIO1_IO13_USB1_OTG_OC		0x16
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
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
