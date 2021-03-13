Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A9433A15C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 22:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbhCMVNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 16:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbhCMVNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 16:13:19 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511DFC061574;
        Sat, 13 Mar 2021 13:13:19 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ED3A799;
        Sat, 13 Mar 2021 22:13:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1615669996;
        bh=98naLgECi8XRxGURVSzTyQdtQ9ze2BrKkADPH9iStf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aoRdvWQgMum/mBWbNeE+QNEW5IhvniorsLUqTDiTTv3vCD/1L82mdV+bhTZIxnBj8
         YsNJWqdNpRMwPQtzCnCekDoD+wxDFr9KDtfHlghb1/hEg0kEfo8Dk0Fszwc0Uc7DLM
         En3Th0Z7YNVrxoPJwHjCMvaWMCgbZzu6aENXXWKw=
Date:   Sat, 13 Mar 2021 23:12:41 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, robdclark@chromium.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/bridge: ti-sn65dsi86: Move code in prep for EDID
 read fix
Message-ID: <YE0qyYedS0NilsCy@pendragon.ideasonboard.com>
References: <20210304155144.1.Ic9c04f960190faad5290738b2a35d73661862735@changeid>
 <20210304155144.2.Id492ddb6e2cdd05eb94474b93654b04b270c9bbe@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210304155144.2.Id492ddb6e2cdd05eb94474b93654b04b270c9bbe@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

Thank you for the patch.

On Thu, Mar 04, 2021 at 03:52:00PM -0800, Douglas Anderson wrote:
> This patch is _only_ code motion to prepare for the patch
> ("drm/bridge: ti-sn65dsi86: Properly get the EDID, but only if
> refclk") and make it easier to understand.

s/make/makes/

> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 196 +++++++++++++-------------
>  1 file changed, 98 insertions(+), 98 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 942019842ff4..491c9c4f32d1 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -345,6 +345,104 @@ static int ti_sn_bridge_parse_regulators(struct ti_sn_bridge *pdata)
>  				       pdata->supplies);
>  }
>  
> +static u32 ti_sn_bridge_get_dsi_freq(struct ti_sn_bridge *pdata)
> +{
> +	u32 bit_rate_khz, clk_freq_khz;
> +	struct drm_display_mode *mode =
> +		&pdata->bridge.encoder->crtc->state->adjusted_mode;
> +
> +	bit_rate_khz = mode->clock *
> +			mipi_dsi_pixel_format_to_bpp(pdata->dsi->format);
> +	clk_freq_khz = bit_rate_khz / (pdata->dsi->lanes * 2);
> +
> +	return clk_freq_khz;
> +}
> +
> +/* clk frequencies supported by bridge in Hz in case derived from REFCLK pin */
> +static const u32 ti_sn_bridge_refclk_lut[] = {
> +	12000000,
> +	19200000,
> +	26000000,
> +	27000000,
> +	38400000,
> +};
> +
> +/* clk frequencies supported by bridge in Hz in case derived from DACP/N pin */
> +static const u32 ti_sn_bridge_dsiclk_lut[] = {
> +	468000000,
> +	384000000,
> +	416000000,
> +	486000000,
> +	460800000,
> +};
> +
> +static void ti_sn_bridge_set_refclk_freq(struct ti_sn_bridge *pdata)
> +{
> +	int i;
> +	u32 refclk_rate;
> +	const u32 *refclk_lut;
> +	size_t refclk_lut_size;
> +
> +	if (pdata->refclk) {
> +		refclk_rate = clk_get_rate(pdata->refclk);
> +		refclk_lut = ti_sn_bridge_refclk_lut;
> +		refclk_lut_size = ARRAY_SIZE(ti_sn_bridge_refclk_lut);
> +		clk_prepare_enable(pdata->refclk);
> +	} else {
> +		refclk_rate = ti_sn_bridge_get_dsi_freq(pdata) * 1000;
> +		refclk_lut = ti_sn_bridge_dsiclk_lut;
> +		refclk_lut_size = ARRAY_SIZE(ti_sn_bridge_dsiclk_lut);
> +	}
> +
> +	/* for i equals to refclk_lut_size means default frequency */
> +	for (i = 0; i < refclk_lut_size; i++)
> +		if (refclk_lut[i] == refclk_rate)
> +			break;
> +
> +	regmap_update_bits(pdata->regmap, SN_DPPLL_SRC_REG, REFCLK_FREQ_MASK,
> +			   REFCLK_FREQ(i));
> +}
> +
> +static void ti_sn_bridge_post_disable(struct drm_bridge *bridge)
> +{
> +	struct ti_sn_bridge *pdata = bridge_to_ti_sn_bridge(bridge);
> +
> +	clk_disable_unprepare(pdata->refclk);
> +
> +	pm_runtime_put_sync(pdata->dev);
> +}
> +
> +static void ti_sn_bridge_pre_enable(struct drm_bridge *bridge)
> +{
> +	struct ti_sn_bridge *pdata = bridge_to_ti_sn_bridge(bridge);
> +
> +	pm_runtime_get_sync(pdata->dev);
> +
> +	/* configure bridge ref_clk */
> +	ti_sn_bridge_set_refclk_freq(pdata);
> +
> +	/*
> +	 * HPD on this bridge chip is a bit useless.  This is an eDP bridge
> +	 * so the HPD is an internal signal that's only there to signal that
> +	 * the panel is done powering up.  ...but the bridge chip debounces
> +	 * this signal by between 100 ms and 400 ms (depending on process,
> +	 * voltage, and temperate--I measured it at about 200 ms).  One
> +	 * particular panel asserted HPD 84 ms after it was powered on meaning
> +	 * that we saw HPD 284 ms after power on.  ...but the same panel said
> +	 * that instead of looking at HPD you could just hardcode a delay of
> +	 * 200 ms.  We'll assume that the panel driver will have the hardcoded
> +	 * delay in its prepare and always disable HPD.
> +	 *
> +	 * If HPD somehow makes sense on some future panel we'll have to
> +	 * change this to be conditional on someone specifying that HPD should
> +	 * be used.
> +	 */
> +	regmap_update_bits(pdata->regmap, SN_HPD_DISABLE_REG, HPD_DISABLE,
> +			   HPD_DISABLE);
> +
> +	drm_panel_prepare(pdata->panel);
> +}
> +
>  static int ti_sn_bridge_attach(struct drm_bridge *bridge,
>  			       enum drm_bridge_attach_flags flags)
>  {
> @@ -443,64 +541,6 @@ static void ti_sn_bridge_disable(struct drm_bridge *bridge)
>  	drm_panel_unprepare(pdata->panel);
>  }
>  
> -static u32 ti_sn_bridge_get_dsi_freq(struct ti_sn_bridge *pdata)
> -{
> -	u32 bit_rate_khz, clk_freq_khz;
> -	struct drm_display_mode *mode =
> -		&pdata->bridge.encoder->crtc->state->adjusted_mode;
> -
> -	bit_rate_khz = mode->clock *
> -			mipi_dsi_pixel_format_to_bpp(pdata->dsi->format);
> -	clk_freq_khz = bit_rate_khz / (pdata->dsi->lanes * 2);
> -
> -	return clk_freq_khz;
> -}
> -
> -/* clk frequencies supported by bridge in Hz in case derived from REFCLK pin */
> -static const u32 ti_sn_bridge_refclk_lut[] = {
> -	12000000,
> -	19200000,
> -	26000000,
> -	27000000,
> -	38400000,
> -};
> -
> -/* clk frequencies supported by bridge in Hz in case derived from DACP/N pin */
> -static const u32 ti_sn_bridge_dsiclk_lut[] = {
> -	468000000,
> -	384000000,
> -	416000000,
> -	486000000,
> -	460800000,
> -};
> -
> -static void ti_sn_bridge_set_refclk_freq(struct ti_sn_bridge *pdata)
> -{
> -	int i;
> -	u32 refclk_rate;
> -	const u32 *refclk_lut;
> -	size_t refclk_lut_size;
> -
> -	if (pdata->refclk) {
> -		refclk_rate = clk_get_rate(pdata->refclk);
> -		refclk_lut = ti_sn_bridge_refclk_lut;
> -		refclk_lut_size = ARRAY_SIZE(ti_sn_bridge_refclk_lut);
> -		clk_prepare_enable(pdata->refclk);
> -	} else {
> -		refclk_rate = ti_sn_bridge_get_dsi_freq(pdata) * 1000;
> -		refclk_lut = ti_sn_bridge_dsiclk_lut;
> -		refclk_lut_size = ARRAY_SIZE(ti_sn_bridge_dsiclk_lut);
> -	}
> -
> -	/* for i equals to refclk_lut_size means default frequency */
> -	for (i = 0; i < refclk_lut_size; i++)
> -		if (refclk_lut[i] == refclk_rate)
> -			break;
> -
> -	regmap_update_bits(pdata->regmap, SN_DPPLL_SRC_REG, REFCLK_FREQ_MASK,
> -			   REFCLK_FREQ(i));
> -}
> -
>  static void ti_sn_bridge_set_dsi_rate(struct ti_sn_bridge *pdata)
>  {
>  	unsigned int bit_rate_mhz, clk_freq_mhz;
> @@ -821,46 +861,6 @@ static void ti_sn_bridge_enable(struct drm_bridge *bridge)
>  	drm_panel_enable(pdata->panel);
>  }
>  
> -static void ti_sn_bridge_pre_enable(struct drm_bridge *bridge)
> -{
> -	struct ti_sn_bridge *pdata = bridge_to_ti_sn_bridge(bridge);
> -
> -	pm_runtime_get_sync(pdata->dev);
> -
> -	/* configure bridge ref_clk */
> -	ti_sn_bridge_set_refclk_freq(pdata);
> -
> -	/*
> -	 * HPD on this bridge chip is a bit useless.  This is an eDP bridge
> -	 * so the HPD is an internal signal that's only there to signal that
> -	 * the panel is done powering up.  ...but the bridge chip debounces
> -	 * this signal by between 100 ms and 400 ms (depending on process,
> -	 * voltage, and temperate--I measured it at about 200 ms).  One
> -	 * particular panel asserted HPD 84 ms after it was powered on meaning
> -	 * that we saw HPD 284 ms after power on.  ...but the same panel said
> -	 * that instead of looking at HPD you could just hardcode a delay of
> -	 * 200 ms.  We'll assume that the panel driver will have the hardcoded
> -	 * delay in its prepare and always disable HPD.
> -	 *
> -	 * If HPD somehow makes sense on some future panel we'll have to
> -	 * change this to be conditional on someone specifying that HPD should
> -	 * be used.
> -	 */
> -	regmap_update_bits(pdata->regmap, SN_HPD_DISABLE_REG, HPD_DISABLE,
> -			   HPD_DISABLE);
> -
> -	drm_panel_prepare(pdata->panel);
> -}
> -
> -static void ti_sn_bridge_post_disable(struct drm_bridge *bridge)
> -{
> -	struct ti_sn_bridge *pdata = bridge_to_ti_sn_bridge(bridge);
> -
> -	clk_disable_unprepare(pdata->refclk);
> -
> -	pm_runtime_put_sync(pdata->dev);
> -}
> -
>  static const struct drm_bridge_funcs ti_sn_bridge_funcs = {
>  	.attach = ti_sn_bridge_attach,
>  	.pre_enable = ti_sn_bridge_pre_enable,

-- 
Regards,

Laurent Pinchart
