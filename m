Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DAD424296
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbhJFQ20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 12:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhJFQ2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 12:28:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAD9C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 09:26:31 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mY9kQ-0006Op-55; Wed, 06 Oct 2021 18:26:26 +0200
Message-ID: <45dc35aa5e7901051cd86f3461aab01d8604c746.camel@pengutronix.de>
Subject: Re: [PATCH v2] arm64: dts: imx8mm-venice-gw7901.dts: disable
 pgc_gpumix
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Tim Harvey <tharvey@gateworks.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 06 Oct 2021 18:26:24 +0200
In-Reply-To: <20211006153836.13760-1-tharvey@gateworks.com>
References: <20211006153836.13760-1-tharvey@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 06.10.2021 um 08:38 -0700 schrieb Tim Harvey:
> Since commit b21269b12e48 ("arm64: dts: imx8mm: add GPC node") the
> GW7901 will hang during kernel init because it does not power the unused
> GPU voltage rails on the IMX8MM. Disable pgc_gpumix to work around this.
> 
> We also disable the GPU devices that depend on the gpumix power domain
> and pgc_gpu to avoid them staying in a probe deferred state forever.
> 
> Additionally as the MIPI voltage rail is also not connected on this
> board we disable pgc_mipi and disp_blk_ctrl.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> v2:
>  - also disable pgc_gpu to keep gpu from getting in probe deferred state
>  - also disable pgc_mipi and disp_blk_ctrl as the MIPI power rails are
>    not connected
> ---
>  .../dts/freescale/imx8mm-venice-gw7901.dts    | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> index bafd5c8ea4e2..21c546c4628d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> @@ -255,6 +255,10 @@
>  	};
>  };
>  
> +&disp_blk_ctrl {
> +	status = "disabled";
> +};
> +
>  &ecspi1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_spi1>;
> @@ -282,6 +286,14 @@
>  	};
>  };
>  
> +&gpu_2d {
> +	status = "disabled";
> +};
> +
> +&gpu_3d {
> +	status = "disabled";
> +};
> +
>  &i2c1 {
>  	clock-frequency = <100000>;
>  	pinctrl-names = "default";
> @@ -632,6 +644,18 @@
>  	status = "okay";
>  };
>  
> +&pgc_gpu {
> +	status = "disabled";
> +};
> +
> +&pgc_gpumix {
> +	status = "disabled";
> +};
> +
> +&pgc_mipi {
> +	status = "disabled";
> +};
> +
>  &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1>, <&pinctrl_uart1_gpio>;


