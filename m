Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC0933098C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhCHIlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhCHIkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:40:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D636C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 00:40:51 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1lJBRX-0001qA-Sm; Mon, 08 Mar 2021 09:40:47 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1lJBRX-00062y-5A; Mon, 08 Mar 2021 09:40:47 +0100
Date:   Mon, 8 Mar 2021 09:40:47 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Heiko Schocher <hs@denx.de>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Teresa Remmet <t.remmet@phytec.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] arm64: imx8mp: imx8mp-phycore-som enable spi nor
Message-ID: <20210308084047.numy4o2jvsiz5d3v@pengutronix.de>
References: <20210308064046.1576267-1-hs@denx.de>
 <20210308064046.1576267-3-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308064046.1576267-3-hs@denx.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:04:00 up 95 days, 22:10, 39 users,  load average: 0.10, 0.07,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-08 07:40, Heiko Schocher wrote:
> enable the mt25qu256aba spi nor on the imx8mp-phycore-som.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> 
>  .../dts/freescale/imx8mp-phycore-som.dtsi     | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
> index 44a8c2337cee4..0284e7a5c6bba 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
> @@ -65,6 +65,22 @@ ethphy1: ethernet-phy@0 {
>  	};
>  };
>  
> +&flexspi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexspi0>;
> +	status = "okay";
> +
> +	flash0: mt25qu256aba@0 {
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";

Please make the compatible the first property followed by the reg
property. Also you don't need to add the #size-cells and #address-cells
now since you don't add a child node.

Regards,
  Marco

> +		spi-max-frequency = <80000000>;
> +		spi-tx-bus-width = <4>;
> +		spi-rx-bus-width = <4>;
> +	};
> +};
> +
>  &i2c1 {
>  	clock-frequency = <400000>;
>  	pinctrl-names = "default";
> @@ -217,6 +233,17 @@ MX8MP_IOMUXC_GPIO1_IO15__GPIO1_IO15		0x11
>  		>;
>  	};
>  
> +	pinctrl_flexspi0: flexspi0grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_ALE__FLEXSPI_A_SCLK		0x1c2
> +			MX8MP_IOMUXC_NAND_CE0_B__FLEXSPI_A_SS0_B	0x82
> +			MX8MP_IOMUXC_NAND_DATA00__FLEXSPI_A_DATA00	0x82
> +			MX8MP_IOMUXC_NAND_DATA01__FLEXSPI_A_DATA01	0x82
> +			MX8MP_IOMUXC_NAND_DATA02__FLEXSPI_A_DATA02	0x82
> +			MX8MP_IOMUXC_NAND_DATA03__FLEXSPI_A_DATA03	0x82
> +		>;
> +	};
> +
>  	pinctrl_i2c1: i2c1grp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c3
> -- 
> 2.29.2
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
