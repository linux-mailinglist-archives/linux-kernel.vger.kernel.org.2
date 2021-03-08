Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6A1330E9B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhCHMpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhCHMoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:44:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4400CC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 04:44:55 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1lJFFl-0005zn-7Z; Mon, 08 Mar 2021 13:44:53 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1lJFFk-0007TM-84; Mon, 08 Mar 2021 13:44:52 +0100
Date:   Mon, 8 Mar 2021 13:44:52 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] arm64: dts: imx8mm-nitrogen-r2: add espi2 support
Message-ID: <20210308124452.c4svp52m77bnf3zk@pengutronix.de>
References: <20210308123958.254116-1-adrien.grassein@gmail.com>
 <20210308123958.254116-2-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308123958.254116-2-adrien.grassein@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:43:47 up 96 days,  2:50, 43 users,  load average: 0.11, 0.08,
 0.06
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrien,

On 21-03-08 13:39, Adrien Grassein wrote:
> Add the description for espi support.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> index 4f4cf7df5a5a..0c5949b40eeb 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> @@ -52,6 +52,19 @@ &A53_3 {
>  	cpu-supply = <&reg_buck3>;
>  };
>  
> +/* J15 */
> +&ecspi2 {
> +	assigned-clocks = <&clk IMX8MM_CLK_ECSPI2>;
> +	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_40M>;
> +	assigned-clock-rates = <40000000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi2>;
> +	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;

> +	#address-cells = <1>;
> +	#size-cells = <0>;

Nit: These two properties should be added to the base dtsi if not
already done.

Regards,
  Marco

> +	status = "okay";
> +};
> +
>  &fec1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_fec1>;
> @@ -286,6 +299,15 @@ &iomuxc {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_hog>;
>  
> +	pinctrl_ecspi2: ecspi2grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13	0x140
> +			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO	0x19
> +			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0x19
> +			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI	0x19
> +		>;
> +	};
> +
>  	pinctrl_fec1: fec1grp {
>  		fsl,pins = <
>  			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x3
> -- 
> 2.25.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
