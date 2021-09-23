Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476EB4154C8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 02:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbhIWApt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 20:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbhIWAps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 20:45:48 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8569C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 17:44:17 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A0CE8E52;
        Thu, 23 Sep 2021 02:44:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1632357855;
        bh=AD4J1QMO7ktVeDSj6yyg5UVYYG05cXHdGt1ipcOlcbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qAp+odD1+3b7Im31C7ynaxZuF+YLCbms+xBSvtab41ArtOLOgW/MMpUSIuu1TfCDH
         3ygvYguk1tx5wcWeeFh28THBkAr2CN8f9nrdmHxqzVbqTjWEH5PR/vv3wPcNvXouhi
         KMVoMJcsrF3mQ6J1GyntOGPjHruWg1k6BwngW/zI=
Date:   Thu, 23 Sep 2021 03:44:14 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] drm/bridge: ti-sn65dsi86: Add NO_CONNECTOR support
Message-ID: <YUvN3j0v+8NMjNte@pendragon.ideasonboard.com>
References: <20210920225801.227211-1-robdclark@gmail.com>
 <20210920225801.227211-4-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210920225801.227211-4-robdclark@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Mon, Sep 20, 2021 at 03:58:00PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Slightly awkward to fish out the display_info when we aren't creating
> own connector.  But I don't see an obvious better way.
> 
> v2: Remove error return with NO_CONNECTOR flag
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 39 ++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 6154bed0af5b..94c94cc8a4d8 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -667,11 +667,6 @@ static int ti_sn_bridge_attach(struct drm_bridge *bridge,
>  						   .node = NULL,
>  						 };
>  
> -	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) {
> -		DRM_ERROR("Fix bridge driver to make connector optional!");
> -		return -EINVAL;
> -	}
> -
>  	pdata->aux.drm_dev = bridge->dev;
>  	ret = drm_dp_aux_register(&pdata->aux);
>  	if (ret < 0) {
> @@ -679,9 +674,11 @@ static int ti_sn_bridge_attach(struct drm_bridge *bridge,
>  		return ret;
>  	}
>  
> -	ret = ti_sn_bridge_connector_init(pdata);
> -	if (ret < 0)
> -		goto err_conn_init;
> +	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
> +		ret = ti_sn_bridge_connector_init(pdata);
> +		if (ret < 0)
> +			goto err_conn_init;
> +	}
>  
>  	/*
>  	 * TODO: ideally finding host resource and dsi dev registration needs
> @@ -743,7 +740,8 @@ static int ti_sn_bridge_attach(struct drm_bridge *bridge,
>  err_dsi_attach:
>  	mipi_dsi_device_unregister(dsi);
>  err_dsi_host:
> -	drm_connector_cleanup(&pdata->connector);
> +	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
> +		drm_connector_cleanup(&pdata->connector);

I wonder if we actually need this. The connector gets attached to the
encoder, won't it be destroyed by the DRM core in the error path ?

>  err_conn_init:
>  	drm_dp_aux_unregister(&pdata->aux);
>  	return ret;
> @@ -792,9 +790,30 @@ static void ti_sn_bridge_set_dsi_rate(struct ti_sn65dsi86 *pdata)
>  	regmap_write(pdata->regmap, SN_DSIA_CLK_FREQ_REG, val);
>  }
>  
> +/*
> + * Find the connector and fish out the bpc from display_info.  It would
> + * be nice if we could get this instead from drm_bridge_state, but that
> + * doesn't yet appear to be the case.

You already have a bus format in the bridge state, from which you can
derive the bpp. Could you give it a try ?

> + */
>  static unsigned int ti_sn_bridge_get_bpp(struct ti_sn65dsi86 *pdata)
>  {
> -	if (pdata->connector.display_info.bpc <= 6)
> +	struct drm_bridge *bridge = &pdata->bridge;
> +	struct drm_connector_list_iter conn_iter;
> +	struct drm_connector *connector;
> +	unsigned bpc = 0;
> +
> +	drm_connector_list_iter_begin(bridge->dev, &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		if (drm_connector_has_possible_encoder(connector, bridge->encoder)) {
> +			bpc = connector->display_info.bpc;
> +			break;
> +		}
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +
> +	WARN_ON(bpc == 0);
> +
> +	if (bpc <= 6)
>  		return 18;
>  	else
>  		return 24;

-- 
Regards,

Laurent Pinchart
