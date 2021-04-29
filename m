Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A6A36E72A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbhD2IkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhD2IkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:40:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF67C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:39:24 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lc2Ca-0007uh-7v; Thu, 29 Apr 2021 10:39:16 +0200
Subject: Re: [PATCH 15/16] soc: imx: gpcv2: support reset defer probe
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     marex@denx.de, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, kernel@pengutronix.de,
        abel.vesa@nxp.com, andrew.smirnov@gmail.com, aford173@gmail.com,
        agx@sigxcpu.org, linux-kernel@vger.kernel.org, krzk@kernel.org,
        frieder.schrempf@kontron.de, ping.bai@nxp.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
 <20210429073050.21039-16-peng.fan@oss.nxp.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <bc5793e4-5d43-1ca9-7a12-9b58806c1856@pengutronix.de>
Date:   Thu, 29 Apr 2021 10:39:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210429073050.21039-16-peng.fan@oss.nxp.com>
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

Hi,

On 29.04.21 09:30, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When gpcv2 probe, the reset controller might not be ready, so we need
> defer probe
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/gpcv2.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 072f519462a5..49dd137f6b94 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -784,9 +784,12 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>  				     "Failed to get domain's clocks\n");
>  
>  	domain->reset = devm_reset_control_array_get_optional_exclusive(domain->dev);
> -	if (IS_ERR(domain->reset))
> +	if (IS_ERR(domain->reset)) {
> +		if (PTR_ERR(domain->reset) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
>  		return dev_err_probe(domain->dev, PTR_ERR(domain->reset),
>  				     "Failed to get domain's resets\n");

dev_err_probe already propagates the error code in its second argument.
Seems to me this patch's only effect is to disable deferred probe reason tracking?

> +	}
>  
>  	pm_runtime_enable(domain->dev);
>  
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
