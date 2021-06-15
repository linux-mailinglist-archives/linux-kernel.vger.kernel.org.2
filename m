Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830A63A7845
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 09:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhFOHuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 03:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhFOHt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:49:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56582C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 00:47:55 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1lt3na-0003fh-QI; Tue, 15 Jun 2021 09:47:50 +0200
Message-ID: <df3c79738d997ace50bac2433a988f3914739cf6.camel@pengutronix.de>
Subject: Re: [RFC PATCH 2/2] drm/etnaviv: add clock gating workaround for
 GC7000 r6202
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Michael Walle <michael@walle.cc>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 15 Jun 2021 09:47:48 +0200
In-Reply-To: <20210614221752.1251-3-michael@walle.cc>
References: <20210614221752.1251-1-michael@walle.cc>
         <20210614221752.1251-3-michael@walle.cc>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Am Dienstag, dem 15.06.2021 um 00:17 +0200 schrieb Michael Walle:
> The LS1028A SoC errata sheet mentions A-050121 "GPU hangs if clock
> gating for Rasterizer, Setup Engine and Texture Engine are enabled".
> The workaround is to disable the corresponding clock gatings.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index 4102bcea3341..574e4e04dddc 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -613,6 +613,12 @@ static void etnaviv_gpu_enable_mlcg(struct etnaviv_gpu *gpu)
>  	    etnaviv_is_model_rev(gpu, GC2000, 0x5108))
>  		pmc |= VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_TX;
>  
> +	/* Disable RS, SE, TE clock gating on affected core revisions. */

This comment is wrong. RS (resolver) is a different engine than RA
(rasterizer) and the texture engine is abbreviated TX throughout the
driver.

Regards,
Lucas

> +	if (etnaviv_is_model_rev(gpu, GC7000, 0x6202))
> +		pmc |= VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_SE |
> +		       VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_RA |
> +		       VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_TX;
> +
>  	pmc |= VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_RA_HZ;
>  	pmc |= VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_RA_EZ;
>  


