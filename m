Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A20133096D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCHIeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhCHIdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:33:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983E6C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 00:33:51 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1lJBKg-00019l-4L; Mon, 08 Mar 2021 09:33:42 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1lJBKf-0005o3-Hx; Mon, 08 Mar 2021 09:33:41 +0100
Date:   Mon, 8 Mar 2021 09:33:41 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Heiko Schocher <hs@denx.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Dong Aisheng <aisheng.dong@nxp.com>,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Alice Guo <alice.guo@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Li Jun <jun.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Teresa Remmet <t.remmet@phytec.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp: add flexspi node
Message-ID: <20210308083341.6mublqva6lm777gn@pengutronix.de>
References: <20210308064046.1576267-1-hs@denx.de>
 <20210308064046.1576267-2-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308064046.1576267-2-hs@denx.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:09:54 up 95 days, 22:16, 39 users,  load average: 0.02, 0.05,
 0.08
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 21-03-08 07:40, Heiko Schocher wrote:
> add node for the flexspi modul on imx8mp.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> 
> ---
> 
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index c7523fd4eae9b..086cfbbef43d7 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -36,6 +36,7 @@ aliases {
>  		serial1 = &uart2;
>  		serial2 = &uart3;
>  		serial3 = &uart4;
> +		spi0 = &flexspi;
>  	};
>  
>  	cpus {
> @@ -744,6 +745,21 @@ usdhc3: mmc@30b60000 {
>  				status = "disabled";
>  			};
>  
> +			flexspi: spi@30bb0000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;

This properties can moved to end just in front of the status property
which should be the last one.

> +				compatible = "nxp,imx8mm-fspi";

Please add a own compatible "nxp,imx8mp-fspi" to the driver which should
be the first patch in your series.

Also the compatible is always the first property.

Regards,
  Marco

> +				reg = <0x30bb0000 0x10000>, <0x8000000 0x10000000>;
> +				reg-names = "fspi_base", "fspi_mmap";
> +				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MP_CLK_QSPI_ROOT>,
> +					 <&clk IMX8MP_CLK_QSPI_ROOT>;
> +				clock-names = "fspi", "fspi_en";
> +				assigned-clock-rates = <80000000>;
> +				assigned-clocks = <&clk IMX8MP_CLK_QSPI>;
> +				status = "disabled";
> +			};
> +
>  			sdma1: dma-controller@30bd0000 {
>  				compatible = "fsl,imx8mp-sdma", "fsl,imx8mq-sdma";
>  				reg = <0x30bd0000 0x10000>;
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
