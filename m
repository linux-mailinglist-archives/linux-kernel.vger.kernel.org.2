Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B380367CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbhDVItf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbhDVIte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:49:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE0FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:48:58 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id y204so22246921wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oAwIpAx12q8rbH6oxHbkcQIupWpyBxEiQ1CBHxTPIa8=;
        b=N/BdHPwtGez2fbj1rmG2UVsjuoXJ64upvKZMDLIQnzIyWnjQmUxKLei6pGPu3ATXRO
         eJe3aOtkgPiPXUZFxMTtaBxYutcrYbQvUQ356nRGrj5vVUBp6eO2Q5SD6n1oJzDaK01c
         beJvioHcuqi4biB9IIjpd8Z/Uvr43Hnkq5X8OCxZkJxNfXJRc/kTli2g+90UmoZBjYc2
         JIQenAF0QCOjb8qb18bdZHXvzoO2BT5QbDfCYo8JKKv6yH3YWPzAH3fOivXoegUz8ypE
         zcEWnU1iBvoZjTDvVZaOYZUEKmkCQXm16XMh+psK7OwRSXtUabSdsNP5qzrigxxOqWt1
         vjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oAwIpAx12q8rbH6oxHbkcQIupWpyBxEiQ1CBHxTPIa8=;
        b=c/ct045lIfcZ7b5+2Mo5J0qlT6gefPgvgl6nV4Yt8cmRoHIv1YQeUK1zsVxzOm/vjj
         JTd956JR1gkJYtpOrv732EVkXJyWv1E+Wb/b0cU0MM17FYs/1nbi2adiLmeeE1kcx+Gk
         pOnb+PM+SEUc/jyG4u2qRGKHyvy++fhBrHYbpH+xuV6QkjFYAh0EXTeE5bc8ekkCIekF
         OZhVEsi6w1d88gYRZvLwp/UbtC5pU1Tr/UzwJu1HyS/bJDplW3dhMyiG5h8tlXi5WpdZ
         N0u9hZVQ8qq3q5FYnqKFrxNlGi/2WRCj2OoNLGV0U1+KQiBPVIFRLDHPrgtn5/bnNTBq
         8jHQ==
X-Gm-Message-State: AOAM531iNspyoDCG1+zNFwMiUJp3C7k3SJ1H0bYXO7wNvzMNMKN5hS71
        5mV3Na0pS3wqx37EADZD5kY8Cg==
X-Google-Smtp-Source: ABdhPJxvRYigk/nD7KFwSkpphTSKKSrHFyZOUfahevGoDXniwE292FBYczWBwgO76HJkFyhxvPb4EA==
X-Received: by 2002:a7b:c4d9:: with SMTP id g25mr14336076wmk.182.1619081337222;
        Thu, 22 Apr 2021 01:48:57 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:916d:6f7:3c58:6b43? ([2a01:e0a:90c:e290:916d:6f7:3c58:6b43])
        by smtp.gmail.com with ESMTPSA id r2sm2315726wrt.79.2021.04.22.01.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 01:48:56 -0700 (PDT)
Subject: Re: [PATCH v2] drm/bridge: nwl-dsi: Get MIPI DSI controller and PHY
 ready in ->mode_set()
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>
References: <1619068455-1932-1-git-send-email-victor.liu@nxp.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <36441ffb-2a79-f965-efc8-042844bc349d@baylibre.com>
Date:   Thu, 22 Apr 2021 10:48:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1619068455-1932-1-git-send-email-victor.liu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/04/2021 07:14, Liu Ying wrote:
> Some MIPI DSI panel drivers like 'raydium,rm68200' send
> MIPI_DCS_SET_DISPLAY_ON commands in panel_funcs->prepare(), which
> requires the MIPI DSI controller and PHY to be ready beforehand.
> Without this patch, the nwl-dsi driver gets the MIPI DSI controller
> and PHY ready in bridge_funcs->pre_enable(), which happens after
> the panel_funcs->prepare(). So, this patch shifts the bridge operation
> ealier from bridge_funcs->pre_enable() to bridge_funcs->mode_set().

This makes sense, this is how we do on the synopsys dw mipi dsi driver.

> This way, more MIPI DSI panels can connect to this nwl-dsi bridge.
> Care is taken to make sure bridge_funcs->mode_set()/atomic_disable()
> are called in pairs, which includes removing a check on unchanged HS
> clock rate and forcing a full modeset when only connector's DPMS is
> brought out of "Off" status.

I would split the changes in multiple patches to clarify the changes.

Neil

> 
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Robert Foss <robert.foss@linaro.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Guido Günther <agx@sigxcpu.org>
> Cc: Robert Chiras <robert.chiras@nxp.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v1->v2:
> * Fix commit message typo - s/unchange/unchanged/
> 
>  drivers/gpu/drm/bridge/nwl-dsi.c | 86 +++++++++++++++++++++-------------------
>  1 file changed, 46 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index be6bfc5..229f0b1 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -21,6 +21,7 @@
>  #include <linux/sys_soc.h>
>  #include <linux/time64.h>
>  
> +#include <drm/drm_atomic_state_helper.h>
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_of.h>
> @@ -661,7 +662,7 @@ static irqreturn_t nwl_dsi_irq_handler(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static int nwl_dsi_enable(struct nwl_dsi *dsi)
> +static int nwl_dsi_mode_set(struct nwl_dsi *dsi)
>  {
>  	struct device *dev = dsi->dev;
>  	union phy_configure_opts *phy_cfg = &dsi->phy_cfg;
> @@ -748,7 +749,9 @@ static int nwl_dsi_disable(struct nwl_dsi *dsi)
>  	return 0;
>  }
>  
> -static void nwl_dsi_bridge_disable(struct drm_bridge *bridge)
> +static void
> +nwl_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
> +			      struct drm_bridge_state *old_bridge_state)
>  {
>  	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
>  	int ret;
> @@ -809,17 +812,6 @@ static int nwl_dsi_get_dphy_params(struct nwl_dsi *dsi,
>  	return 0;
>  }
>  
> -static bool nwl_dsi_bridge_mode_fixup(struct drm_bridge *bridge,
> -				      const struct drm_display_mode *mode,
> -				      struct drm_display_mode *adjusted_mode)
> -{
> -	/* At least LCDIF + NWL needs active high sync */
> -	adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
> -	adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
> -
> -	return true;
> -}
> -
>  static enum drm_mode_status
>  nwl_dsi_bridge_mode_valid(struct drm_bridge *bridge,
>  			  const struct drm_display_info *info,
> @@ -837,6 +829,29 @@ nwl_dsi_bridge_mode_valid(struct drm_bridge *bridge,
>  	return MODE_OK;
>  }
>  
> +static int nwl_dsi_bridge_atomic_check(struct drm_bridge *bridge,
> +				       struct drm_bridge_state *bridge_state,
> +				       struct drm_crtc_state *crtc_state,
> +				       struct drm_connector_state *conn_state)
> +{
> +	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
> +
> +	/* At least LCDIF + NWL needs active high sync */
> +	adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
> +	adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
> +
> +	/*
> +	 * Do a full modeset if crtc_state->active is changed to be true.
> +	 * This ensures our ->mode_set() is called to get the DSI controller
> +	 * and the PHY ready to send DCS commands, when only the connector's
> +	 * DPMS is brought out of "Off" status.
> +	 */
> +	if (crtc_state->active_changed && crtc_state->active)
> +		crtc_state->mode_changed = true;
> +
> +	return 0;
> +}
> +
>  static void
>  nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
>  			const struct drm_display_mode *mode,
> @@ -852,13 +867,6 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
>  	if (ret < 0)
>  		return;
>  
> -	/*
> -	 * If hs clock is unchanged, we're all good - all parameters are
> -	 * derived from it atm.
> -	 */
> -	if (new_cfg.mipi_dphy.hs_clk_rate == dsi->phy_cfg.mipi_dphy.hs_clk_rate)
> -		return;
> -
>  	phy_ref_rate = clk_get_rate(dsi->phy_ref_clk);
>  	DRM_DEV_DEBUG_DRIVER(dev, "PHY at ref rate: %lu\n", phy_ref_rate);
>  	/* Save the new desired phy config */
> @@ -866,14 +874,8 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
>  
>  	memcpy(&dsi->mode, adjusted_mode, sizeof(dsi->mode));
>  	drm_mode_debug_printmodeline(adjusted_mode);
> -}
>  
> -static void nwl_dsi_bridge_pre_enable(struct drm_bridge *bridge)
> -{
> -	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
> -	int ret;
> -
> -	pm_runtime_get_sync(dsi->dev);
> +	pm_runtime_get_sync(dev);
>  
>  	if (clk_prepare_enable(dsi->lcdif_clk) < 0)
>  		return;
> @@ -883,27 +885,29 @@ static void nwl_dsi_bridge_pre_enable(struct drm_bridge *bridge)
>  	/* Step 1 from DSI reset-out instructions */
>  	ret = reset_control_deassert(dsi->rst_pclk);
>  	if (ret < 0) {
> -		DRM_DEV_ERROR(dsi->dev, "Failed to deassert PCLK: %d\n", ret);
> +		DRM_DEV_ERROR(dev, "Failed to deassert PCLK: %d\n", ret);
>  		return;
>  	}
>  
>  	/* Step 2 from DSI reset-out instructions */
> -	nwl_dsi_enable(dsi);
> +	nwl_dsi_mode_set(dsi);
>  
>  	/* Step 3 from DSI reset-out instructions */
>  	ret = reset_control_deassert(dsi->rst_esc);
>  	if (ret < 0) {
> -		DRM_DEV_ERROR(dsi->dev, "Failed to deassert ESC: %d\n", ret);
> +		DRM_DEV_ERROR(dev, "Failed to deassert ESC: %d\n", ret);
>  		return;
>  	}
>  	ret = reset_control_deassert(dsi->rst_byte);
>  	if (ret < 0) {
> -		DRM_DEV_ERROR(dsi->dev, "Failed to deassert BYTE: %d\n", ret);
> +		DRM_DEV_ERROR(dev, "Failed to deassert BYTE: %d\n", ret);
>  		return;
>  	}
>  }
>  
> -static void nwl_dsi_bridge_enable(struct drm_bridge *bridge)
> +static void
> +nwl_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
> +			     struct drm_bridge_state *old_bridge_state)
>  {
>  	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
>  	int ret;
> @@ -948,14 +952,16 @@ static void nwl_dsi_bridge_detach(struct drm_bridge *bridge)
>  }
>  
>  static const struct drm_bridge_funcs nwl_dsi_bridge_funcs = {
> -	.pre_enable = nwl_dsi_bridge_pre_enable,
> -	.enable     = nwl_dsi_bridge_enable,
> -	.disable    = nwl_dsi_bridge_disable,
> -	.mode_fixup = nwl_dsi_bridge_mode_fixup,
> -	.mode_set   = nwl_dsi_bridge_mode_set,
> -	.mode_valid = nwl_dsi_bridge_mode_valid,
> -	.attach	    = nwl_dsi_bridge_attach,
> -	.detach	    = nwl_dsi_bridge_detach,
> +	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
> +	.atomic_reset		= drm_atomic_helper_bridge_reset,
> +	.atomic_check		= nwl_dsi_bridge_atomic_check,
> +	.atomic_enable		= nwl_dsi_bridge_atomic_enable,
> +	.atomic_disable		= nwl_dsi_bridge_atomic_disable,
> +	.mode_set		= nwl_dsi_bridge_mode_set,
> +	.mode_valid		= nwl_dsi_bridge_mode_valid,
> +	.attach			= nwl_dsi_bridge_attach,
> +	.detach			= nwl_dsi_bridge_detach,
>  };
>  
>  static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
> 

