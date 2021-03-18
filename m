Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2F033FC2C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 01:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhCRAVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 20:21:51 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60410 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhCRAVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 20:21:21 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C97658E6;
        Thu, 18 Mar 2021 01:21:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1616026879;
        bh=dPQCVgzd2lJUq3jAWBjnHWNQs/oOCycuPf1cKDuvFNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kXDP5Vr4spLR26JNCW6vFJT2VC7Hi008uWYh5P3Yksx+ILEzfvHMztFPSPEzLQXvC
         UKcwWkb8k6lYpZoYEmIPcK5U5XFa2QuK8Z7hNOWNSAqxAUn0U2RIA/l5gMKqiasfyL
         ITEU8yUmZn+OAdyYCrNeyQKwt7SpFY1vGog3qa5I=
Date:   Thu, 18 Mar 2021 02:20:43 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH v3 3/4] drm/bridge: ti-sn65dsi86: Read EDID blob over DDC
Message-ID: <YFKc23MwUQAosCs8@pendragon.ideasonboard.com>
References: <20201102181144.3469197-1-swboyd@chromium.org>
 <20201102181144.3469197-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102181144.3469197-4-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Reviving a bit of an old thread, for a question.

On Mon, Nov 02, 2020 at 10:11:43AM -0800, Stephen Boyd wrote:
> Use the DDC connection to read the EDID from the eDP panel instead of
> relying on the panel to tell us the modes.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> Cc: Sean Paul <seanpaul@chromium.org>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 8276fa50138f..6b6e98ca2881 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -119,6 +119,7 @@
>   * @debugfs:      Used for managing our debugfs.
>   * @host_node:    Remote DSI node.
>   * @dsi:          Our MIPI DSI source.
> + * @edid:         Detected EDID of eDP panel.
>   * @refclk:       Our reference clock.
>   * @panel:        Our panel.
>   * @enable_gpio:  The GPIO we toggle to enable the bridge.
> @@ -144,6 +145,7 @@ struct ti_sn_bridge {
>  	struct drm_bridge		bridge;
>  	struct drm_connector		connector;
>  	struct dentry			*debugfs;
> +	struct edid			*edid;
>  	struct device_node		*host_node;
>  	struct mipi_dsi_device		*dsi;
>  	struct clk			*refclk;
> @@ -265,6 +267,23 @@ connector_to_ti_sn_bridge(struct drm_connector *connector)
>  static int ti_sn_bridge_connector_get_modes(struct drm_connector *connector)
>  {
>  	struct ti_sn_bridge *pdata = connector_to_ti_sn_bridge(connector);
> +	struct edid *edid = pdata->edid;
> +	int num, ret;
> +
> +	if (!edid) {
> +		pm_runtime_get_sync(pdata->dev);
> +		edid = pdata->edid = drm_get_edid(connector, &pdata->aux.ddc);
> +		pm_runtime_put(pdata->dev);

Is there any specific reason to use the indirect access method, compared
to the direct method that translates access to an I2C ancillary address
to an I2C-over-AUX transaction (see page 20 of SLLSEH2B) ? The direct
method seems it would be more efficient.

> +	}
> +
> +	if (edid && drm_edid_is_valid(edid)) {
> +		ret = drm_connector_update_edid_property(connector, edid);
> +		if (!ret) {
> +			num = drm_add_edid_modes(connector, edid);
> +			if (num)
> +				return num;
> +		}
> +	}
>  
>  	return drm_panel_get_modes(pdata->panel, connector);
>  }
> @@ -1245,6 +1264,7 @@ static int ti_sn_bridge_remove(struct i2c_client *client)
>  	if (!pdata)
>  		return -EINVAL;
>  
> +	kfree(pdata->edid);
>  	ti_sn_debugfs_remove(pdata);
>  
>  	of_node_put(pdata->host_node);

-- 
Regards,

Laurent Pinchart
