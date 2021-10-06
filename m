Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690654238C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 09:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbhJFHYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 03:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbhJFHYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 03:24:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61779C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 00:22:16 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mY1Fi-00076j-AC; Wed, 06 Oct 2021 09:22:10 +0200
Message-ID: <459e00f5c3320d70937d7300b31a0ef730dab8db.camel@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8mm-venice-gw7901.dts: disable pgc_gpumix
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Tim Harvey <tharvey@gateworks.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 06 Oct 2021 09:22:08 +0200
In-Reply-To: <20211005152348.17325-1-tharvey@gateworks.com>
References: <20211005152348.17325-1-tharvey@gateworks.com>
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

Am Dienstag, dem 05.10.2021 um 08:23 -0700 schrieb Tim Harvey:
> Since commit d39d4bb15310 ("arm64: dts: imx8mm: add GPC node") the
> GW7901 will hang during kernel init because it does not power the unused GPU
> voltage rails on the IMX8MM. Disable pgc_gpumix to work around this.
> 
> We also disable the GPU devices that depend on the gpumix power domain
> to avoid them staying in a probe deferred state forever.
> 
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  .../boot/dts/freescale/imx8mm-venice-gw7901.dts      | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> index bafd5c8ea4e2..e0153ce35722 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> @@ -282,6 +282,14 @@
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
> @@ -632,6 +640,10 @@
>  	status = "okay";
>  };
>  
> +&pgc_gpumix {
> +	status = "disabled";
> +};

I suggest to also disable the pgc_gpu, as that one is in the same
situation as the GPU devices and will stay in probe deferred state
forever, as the gpumix domain is not available.

Regards,
Lucas

> +
>  &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1>, <&pinctrl_uart1_gpio>;


