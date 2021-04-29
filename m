Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B65336EC76
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239897AbhD2Ofb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbhD2Of3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:35:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4DDC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:34:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1lc7kO-0003XE-T9; Thu, 29 Apr 2021 16:34:32 +0200
Message-ID: <abde5337ac265287f8e1225846e140e8df370f47.camel@pengutronix.de>
Subject: Re: [PATCH 16/16] soc: imx: gpcv2: remove waiting handshake in
 power up
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
Date:   Thu, 29 Apr 2021 16:34:31 +0200
In-Reply-To: <20210429073050.21039-17-peng.fan@oss.nxp.com>
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
         <20210429073050.21039-17-peng.fan@oss.nxp.com>
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
> i.MX8MM has blk ctl module, the handshake can only finish after setting
> blk ctl. The blk ctl driver will set the bus clk bit and the handshake
> will finish there. we just add a delay and suppose the handshake will
> finish after that.

Instead of this patch, just drop patch 05/16 from this series. I think
we should leave a comment in the code on why we aren't waiting for the
handshake ack, as this is non-obvious from looking at the driver code. 

Basically add a polished version of the commit log from this patch into
the driver code.

Regards,
Lucas

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/gpcv2.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 49dd137f6b94..04564017bfe9 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -251,14 +251,6 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>  		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
>  				   domain->bits.hskreq, domain->bits.hskreq);
>  
> 
> 
> 
> -		ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK,
> -					       reg_val,
> -					       (reg_val & domain->bits.hskack),
> -					       0, USEC_PER_MSEC);
> -		if (ret) {
> -			dev_err(domain->dev, "failed to power up ADB400\n");
> -			goto out_clk_disable;
> -		}
>  	}
>  
> 
> 
> 
>  	/* Disable reset clocks for all devices in the domain */


