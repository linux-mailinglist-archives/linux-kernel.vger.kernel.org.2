Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11BB36EC62
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbhD2O3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbhD2O3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:29:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083C0C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:28:54 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1lc7en-0002lJ-BM; Thu, 29 Apr 2021 16:28:45 +0200
Message-ID: <43f3fd817b5d0448eeb940b4f3386d3c13680da0.camel@pengutronix.de>
Subject: Re: [PATCH 14/16] soc: imx: gpcv2: move reset assert after
 requesting domain power up
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, krzk@kernel.org, agx@sigxcpu.org,
        marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Date:   Thu, 29 Apr 2021 16:28:43 +0200
In-Reply-To: <20210429073050.21039-15-peng.fan@oss.nxp.com>
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
         <20210429073050.21039-15-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, dem 29.04.2021 um 15:30 +0800 schrieb Peng Fan (OSS):
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX8MM VPU power up sequence is a bit special, it must follow:
> 1. request power up
> 2. reset assert
> 3. reset deassert
> 
> This change in this patch will not affect other domains, because
> the power domain default is in asserted state, unless bootloader
> deassert the reset.
> 
> [Note: We expect bootloader leave the domain in asserted state,
> but this may not always be true, so we might need another solution
> to address the VPU domain requirements]

This is only about the VPU and GPU domain, where we need to handle the
SRC reset from the GPC driver right? In that case I think it's a sane
assumption that the bootloader does not touch those resets.

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/gpcv2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index d2ce47a5ebad..072f519462a5 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -217,8 +217,6 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>  		goto out_regulator_disable;
>  	}
>  
> 
> 
> 
> 
> 
> 
> 
> -	reset_control_assert(domain->reset);
> -
>  	if (domain->bits.pxx) {
>  		/* request the domain to power up */
>  		regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
> @@ -241,6 +239,8 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>  				   GPC_PGC_CTRL_PCR, 0);
>  	}
>  
> 
> 
> 
> 
> 
> 
> 
> +	reset_control_assert(domain->reset);
> +
>  	/* delay for reset to propagate */
>  	udelay(5);

As this is a pretty arbitrary delay added by me, can you please check
with the HW team or whoever knows, if this is sufficiently long for
both GPU and VPU domains?

Regards,
Lucas

