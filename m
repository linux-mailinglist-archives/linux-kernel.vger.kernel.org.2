Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412814186CA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 08:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhIZG4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 02:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhIZG4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 02:56:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86B4C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 23:54:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mUO3a-0007cq-0A; Sun, 26 Sep 2021 08:54:38 +0200
Subject: Re: [PATCH v2 4/5] ARM: dts: imx6sl: fix mmc compatibles
To:     Andreas Kemnade <andreas@kemnade.info>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lucas Stach <lst@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
References: <20210924091439.2561931-1-andreas@kemnade.info>
 <20210924091439.2561931-5-andreas@kemnade.info>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <a5ec87f2-7e72-9c23-e13a-75498287b451@pengutronix.de>
Date:   Sun, 26 Sep 2021 08:54:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210924091439.2561931-5-andreas@kemnade.info>
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

Hello Andreas,

On 24.09.21 11:14, Andreas Kemnade wrote:
> Binding specification only allows one compatible here.

This same change was NACKed by Lucas here:
https://lore.kernel.org/linux-devicetree/72e1194e10ccb4f87aed96265114f0963e805092.camel@pengutronix.de/

I also think the schema should be fixed instead.

Cheers,
Ahmad

> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  arch/arm/boot/dts/imx6sl.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index c7d907c5c352..887d2a80a335 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -856,7 +856,7 @@ fec: ethernet@2188000 {
>  			};
>  
>  			usdhc1: mmc@2190000 {
> -				compatible = "fsl,imx6sl-usdhc", "fsl,imx6q-usdhc";
> +				compatible = "fsl,imx6sl-usdhc";
>  				reg = <0x02190000 0x4000>;
>  				interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clks IMX6SL_CLK_USDHC1>,
> @@ -868,7 +868,7 @@ usdhc1: mmc@2190000 {
>  			};
>  
>  			usdhc2: mmc@2194000 {
> -				compatible = "fsl,imx6sl-usdhc", "fsl,imx6q-usdhc";
> +				compatible = "fsl,imx6sl-usdhc";
>  				reg = <0x02194000 0x4000>;
>  				interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clks IMX6SL_CLK_USDHC2>,
> @@ -880,7 +880,7 @@ usdhc2: mmc@2194000 {
>  			};
>  
>  			usdhc3: mmc@2198000 {
> -				compatible = "fsl,imx6sl-usdhc", "fsl,imx6q-usdhc";
> +				compatible = "fsl,imx6sl-usdhc";
>  				reg = <0x02198000 0x4000>;
>  				interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clks IMX6SL_CLK_USDHC3>,
> @@ -892,7 +892,7 @@ usdhc3: mmc@2198000 {
>  			};
>  
>  			usdhc4: mmc@219c000 {
> -				compatible = "fsl,imx6sl-usdhc", "fsl,imx6q-usdhc";
> +				compatible = "fsl,imx6sl-usdhc";
>  				reg = <0x0219c000 0x4000>;
>  				interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clks IMX6SL_CLK_USDHC4>,
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
