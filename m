Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EC2441B7A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 14:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhKANHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 09:07:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:20531 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232017AbhKANHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 09:07:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="211061306"
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="211061306"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 06:02:12 -0700
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="500031023"
Received: from mvtammin-mobl.ger.corp.intel.com (HELO localhost) ([10.251.214.228])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 06:02:08 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     He Ying <heying24@huawei.com>, mripard@kernel.org, wens@csie.org,
        airlied@linux.ie, daniel@ffwll.ch, jernej.skrabec@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] drm: Grab reference of connector before return connector from sun4i_tcon_get_connector
In-Reply-To: <20211101062906.231518-1-heying24@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211101062906.231518-1-heying24@huawei.com>
Date:   Mon, 01 Nov 2021 15:02:06 +0200
Message-ID: <87cznkdo6p.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Nov 2021, He Ying <heying24@huawei.com> wrote:
> From the comments of drm_for_each_connector_iter(), we know
> that "connector is only valid within the list body, if you
> want to use connector after calling drm_connector_list_iter_end()
> then you need to grab your own reference first using
> drm_connector_get()". So fix the wrong use of connector
> according to the comments and then call drm_connector_put()
> after using connector finishes.
>
> Signed-off-by: He Ying <heying24@huawei.com>

Please use "drm/sun4i:" subject prefix for sun4i patches.

BR,
Jani.


> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 9f06dec0fc61..24fa6784ee5f 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -47,12 +47,12 @@ static struct drm_connector *sun4i_tcon_get_connector(const struct drm_encoder *
>  	drm_connector_list_iter_begin(encoder->dev, &iter);
>  	drm_for_each_connector_iter(connector, &iter)
>  		if (connector->encoder == encoder) {
> -			drm_connector_list_iter_end(&iter);
> -			return connector;
> +			drm_connector_get(connector);
> +			break;
>  		}
>  	drm_connector_list_iter_end(&iter);
>  
> -	return NULL;
> +	return connector;
>  }
>  
>  static int sun4i_tcon_get_pixel_depth(const struct drm_encoder *encoder)
> @@ -65,6 +65,7 @@ static int sun4i_tcon_get_pixel_depth(const struct drm_encoder *encoder)
>  		return -EINVAL;
>  
>  	info = &connector->display_info;
> +	drm_connector_put(connector);
>  	if (info->num_bus_formats != 1)
>  		return -EINVAL;
>  
> @@ -361,6 +362,7 @@ static void sun4i_tcon0_mode_set_cpu(struct sun4i_tcon *tcon,
>  	/* TODO support normal CPU interface modes */
>  	struct sun6i_dsi *dsi = encoder_to_sun6i_dsi(encoder);
>  	struct mipi_dsi_device *device = dsi->device;
> +	struct drm_connector *connector;
>  	u8 bpp = mipi_dsi_pixel_format_to_bpp(device->format);
>  	u8 lanes = device->lanes;
>  	u32 block_space, start_delay;
> @@ -372,7 +374,9 @@ static void sun4i_tcon0_mode_set_cpu(struct sun4i_tcon *tcon,
>  	sun4i_tcon0_mode_set_common(tcon, mode);
>  
>  	/* Set dithering if needed */
> -	sun4i_tcon0_mode_set_dithering(tcon, sun4i_tcon_get_connector(encoder));
> +	connector = sun4i_tcon_get_connector(encoder);
> +	sun4i_tcon0_mode_set_dithering(tcon, connector);
> +	drm_connector_put(connector);
>  
>  	regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
>  			   SUN4I_TCON0_CTL_IF_MASK,
> @@ -430,6 +434,7 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
>  				      const struct drm_display_mode *mode)
>  {
>  	unsigned int bp;
> +	struct drm_connector *connector;
>  	u8 clk_delay;
>  	u32 reg, val = 0;
>  
> @@ -440,7 +445,9 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
>  	sun4i_tcon0_mode_set_common(tcon, mode);
>  
>  	/* Set dithering if needed */
> -	sun4i_tcon0_mode_set_dithering(tcon, sun4i_tcon_get_connector(encoder));
> +	connector = sun4i_tcon_get_connector(encoder);
> +	sun4i_tcon0_mode_set_dithering(tcon, connector);
> +	drm_connector_put(connector);
>  
>  	/* Adjust clock delay */
>  	clk_delay = sun4i_tcon_get_clk_delay(mode, 0);
> @@ -518,6 +525,7 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>  
>  	/* Set dithering if needed */
>  	sun4i_tcon0_mode_set_dithering(tcon, connector);
> +	drm_connector_put(connector);
>  
>  	/* Adjust clock delay */
>  	clk_delay = sun4i_tcon_get_clk_delay(mode, 0);

-- 
Jani Nikula, Intel Open Source Graphics Center
