Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76A3346D9B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 23:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhCWWyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 18:54:33 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45014 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbhCWWyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:54:07 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1FD17B1D;
        Tue, 23 Mar 2021 23:54:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1616540045;
        bh=KSIuPPDkROSGPS7M94OOzj75s3Z9r37vKuGVwJxJMgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nggxOMfg1ILRNGYWxIpX8MtcV1wNzlOxqMc7DCaaBrqEIUGV8c432f/q97n0bYxEZ
         G+/c9Ku2wEa55JPp2Y0dJ3vmDaVG5a4EpCXiNL6CGpuL0BHO3/hKK8O4hik6uymrWh
         RTn7tPckVfXpe8u8H6ZrO6kedQfMPhMroT77TR6c=
Date:   Wed, 24 Mar 2021 00:53:22 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 1/4] drm: sun4i: dsi: Use drm_of_find_panel_or_bridge
Message-ID: <YFpxYpA+EIZm7sOf@pendragon.ideasonboard.com>
References: <20210322140152.101709-1-jagan@amarulasolutions.com>
 <20210322140152.101709-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210322140152.101709-2-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

Thank you for the patch.

On Mon, Mar 22, 2021 at 07:31:49PM +0530, Jagan Teki wrote:
> Replace of_drm_find_panel with drm_of_find_panel_or_bridge
> for finding panel, this indeed help to find the bridge if
> bridge support added.
> 
> Added NULL in bridge argument, same will replace with bridge
> parameter once bridge supported.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Looks good, there should be no functional change.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Changes for v4, v3:
> - none
> 
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 4f5efcace68e..2e9e7b2d4145 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -21,6 +21,7 @@
>  
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_of.h>
>  #include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
> @@ -963,10 +964,14 @@ static int sun6i_dsi_attach(struct mipi_dsi_host *host,
>  			    struct mipi_dsi_device *device)
>  {
>  	struct sun6i_dsi *dsi = host_to_sun6i_dsi(host);
> -	struct drm_panel *panel = of_drm_find_panel(device->dev.of_node);
> +	struct drm_panel *panel;
> +	int ret;
> +
> +	ret = drm_of_find_panel_or_bridge(dsi->dev->of_node, 0, 0,
> +					  &panel, NULL);
> +	if (ret)
> +		return ret;
>  
> -	if (IS_ERR(panel))
> -		return PTR_ERR(panel);
>  	if (!dsi->drm || !dsi->drm->registered)
>  		return -EPROBE_DEFER;
>  

-- 
Regards,

Laurent Pinchart
