Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBEB423906
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 09:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbhJFHiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 03:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhJFHiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 03:38:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EDCC061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 00:36:11 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mY1TC-0000Rj-9h; Wed, 06 Oct 2021 09:36:06 +0200
Message-ID: <8d54835921f1648a4d50d8d4e160b5a12582590f.camel@pengutronix.de>
Subject: Re: [PATCH] CONFIG_SOC_IMX6Q = i.MX6 Quad/DualLite/Solo
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Krzysztof =?UTF-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Date:   Wed, 06 Oct 2021 09:36:05 +0200
In-Reply-To: <m3sfxen0yw.fsf@t19.piap.pl>
References: <m3sfxen0yw.fsf@t19.piap.pl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 06.10.2021 um 08:04 +0200 schrieb Krzysztof Hałasa:
> Print i.MX6 "Solo" name in addition to the "Quad" and "DualLite"
> for SOC_IMX6Q.
> 
I don't think that's helpful, you would need to at least also print
"Dual" to make it correct. The Solo is just a fused down version of the
DualLite, just as the Dual is a fused down version of the Quad.

Quad/DualLite refers to the two different die versions of the chip.

Regards,
Lucas

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


