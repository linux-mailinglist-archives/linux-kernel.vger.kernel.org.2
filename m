Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113114237E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 08:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhJFGTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 02:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhJFGTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 02:19:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A43BC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 23:17:51 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mY0FQ-00086A-Vp; Wed, 06 Oct 2021 08:17:49 +0200
Subject: Re: [PATCH] CONFIG_SOC_IMX6Q = i.MX6 Quad/DualLite/Solo
To:     =?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <m3sfxen0yw.fsf@t19.piap.pl>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <d510bd24-9c1c-4870-1e69-8f4f57628b05@pengutronix.de>
Date:   Wed, 6 Oct 2021 08:17:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <m3sfxen0yw.fsf@t19.piap.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On 06.10.21 08:04, Krzysztof Hałasa wrote:
> Print i.MX6 "Solo" name in addition to the "Quad" and "DualLite"
> for SOC_IMX6Q.
If you think enumerating all variants is worthwhile, you should
probably be adding normal Dual (Quad, but with only 2 cores) as well.

> Signed-off-by: Krzysztof Hałasa <khalasa@piap.pl>
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index b407b024dde3..b6f2f2ea8e65 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -143,7 +143,7 @@ config SOC_IMX6
>  	select PL310_ERRATA_769419 if CACHE_L2X0
>  
>  config SOC_IMX6Q
> -	bool "i.MX6 Quad/DualLite support"
> +	bool "i.MX6 Quad/DualLite/Solo support"
>  	select ARM_ERRATA_764369 if SMP
>  	select ARM_ERRATA_754322
>  	select ARM_ERRATA_775420
> @@ -153,7 +153,7 @@ config SOC_IMX6Q
>  	select SOC_IMX6
>  
>  	help
> -	  This enables support for Freescale i.MX6 Quad processor.
> +	  This enables support for Freescale i.MX6 Quad/DualLite/Solo processors.
>  
>  config SOC_IMX6SL
>  	bool "i.MX6 SoloLite support"
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 11dcc369ec14..8cc8a2ed1d12 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -217,7 +217,7 @@ static const char * const imx6q_dt_compat[] __initconst = {
>  	NULL,
>  };
>  
> -DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad/DualLite (Device Tree)")
> +DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad/DualLite/Solo (Device Tree)")
>  	.l2c_aux_val 	= 0,
>  	.l2c_aux_mask	= ~0,
>  	.smp		= smp_ops(imx_smp_ops),
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
