Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D45736F735
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhD3IgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhD3IgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:36:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4092AC06138D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:35:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x7so69566276wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fn6AYw4BJVaN24DbFIxNtIPDUt22G+/MHKJIlFH6dLI=;
        b=ZJSnO/KAhQjEp3mZx9JZQWTguYGlqnwR7DPl9TbHB9EpWH3zzxuQC7lZo+64W/16hW
         F8ioicj9t0M5mNom0CsIvdTR+bJuC1aHyispUcb4KJKsOaFb36GEKIsAwFAt/HyDp8zb
         dyXSPSR/azForvRQ01HXwZVMaFWwIBPXE1skZ5IU/k7a3x8iINjv2atV1bUXN7Nusqjd
         kV4cfezAnlP2hR/7Y3oTfZVDgETYllLuML2onloWcsnSeH9TnOOgUBoX7XNfU5ejRHGj
         SNlsQy+VV1Z+T3J7JqUCMI6J9RLchu7C1zVxLIF2nDif23+pYLOLqBSdp3lFSMTDBZx8
         iEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fn6AYw4BJVaN24DbFIxNtIPDUt22G+/MHKJIlFH6dLI=;
        b=VSrTQOUZ9HgoJt/czPo+DIGFsHoiPnjruHGad4HHFeAHFX6X0Xxtm3SNo2v7iPF6GR
         Xjz7Gj2OrT6uX9S/Ooj0ezuTVZoEhXBXbzvCtiZmc3aUxvqYrn5XJkdeH6Cwk1VN1y4G
         OKLrZWBpl3ABbbtV77qMTRmOpZq4jP/LzxzCw3M+1uYdEPqj73WtOZHCJkVKtUfSyq5t
         Ekm37OdP+6SGf7Xi87DmS97LaDWBwekXE7KZXcJi4fIQxMpQPHHCXr5M1gW5fHA2cong
         kGIEq9n2T48rzIkkOt3rku+SIr7YZoj79uZZCb/Set2HBqh5VtDvAN6M/TH1o2kVvII5
         jgNg==
X-Gm-Message-State: AOAM533O4GkXdgzLC3MCSEpKdnhL6p8WnMRrQQLx5yShgcqnGo1CUoIz
        Rc8bsb44/4vMf1dY+iMwr8DDJA==
X-Google-Smtp-Source: ABdhPJwwz0a07pBPkgdgCFD8QuFjbv3EYe5W81b8yX6OPXeOfC6sqn15XkjDfvXRTz0Dv4+tdpjZfw==
X-Received: by 2002:adf:e412:: with SMTP id g18mr5281820wrm.205.1619771717941;
        Fri, 30 Apr 2021 01:35:17 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:4a89:8c32:4adc:fc67? ([2a01:e0a:90c:e290:4a89:8c32:4adc:fc67])
        by smtp.gmail.com with ESMTPSA id k10sm19989851wmf.0.2021.04.30.01.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 01:35:17 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] drm/bridge: nwl-dsi: Get MIPI DSI controller and
 PHY ready in ->mode_set()
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, a.hajda@samsung.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, agx@sigxcpu.org, robert.chiras@nxp.com,
        linux-imx@nxp.com
References: <1619170003-4817-1-git-send-email-victor.liu@nxp.com>
 <1619170003-4817-4-git-send-email-victor.liu@nxp.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <be50d7db-3455-2357-8601-501bc4b5aeb4@baylibre.com>
Date:   Fri, 30 Apr 2021 10:35:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1619170003-4817-4-git-send-email-victor.liu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2021 11:26, Liu Ying wrote:
> Some MIPI DSI panel drivers like 'raydium,rm68200' send
> MIPI_DCS_SET_DISPLAY_ON commands in panel_funcs->prepare(), which
> requires the MIPI DSI controller and PHY to be ready beforehand.
> Without this patch, the nwl-dsi driver gets the MIPI DSI controller
> and PHY ready in bridge_funcs->atomic_pre_enable(), which happens after
> the panel_funcs->prepare().  So, this patch shifts the bridge operation
> ealier from bridge_funcs->atomic_pre_enable() to bridge_funcs->mode_set().
> This way, more MIPI DSI panels can connect to this nwl-dsi bridge.
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
> v2->v3:
> * Split some changes to patch 1/3 and 2/3, to clarify changes. (Neil)
> 
> v1->v2:
> * Fix a typo in commit message - s/unchange/unchanged/
> 
>  drivers/gpu/drm/bridge/nwl-dsi.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index 601ccc4a7cdc7..873995f0a7416 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -662,7 +662,7 @@ static irqreturn_t nwl_dsi_irq_handler(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static int nwl_dsi_enable(struct nwl_dsi *dsi)
> +static int nwl_dsi_mode_set(struct nwl_dsi *dsi)
>  {
>  	struct device *dev = dsi->dev;
>  	union phy_configure_opts *phy_cfg = &dsi->phy_cfg;
> @@ -834,7 +834,12 @@ static int nwl_dsi_bridge_atomic_check(struct drm_bridge *bridge,
>  	adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
>  	adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
>  
> -	/* Do a full modeset if crtc_state->active is changed to be true. */
> +	/*
> +	 * Do a full modeset if crtc_state->active is changed to be true.
> +	 * This ensures our ->mode_set() is called to get the DSI controller
> +	 * and the PHY ready to send DCS commands, when only the connector's
> +	 * DPMS is brought out of "Off" status.
> +	 */
>  	if (crtc_state->active_changed && crtc_state->active)
>  		crtc_state->mode_changed = true;
>  
> @@ -863,16 +868,8 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
>  
>  	memcpy(&dsi->mode, adjusted_mode, sizeof(dsi->mode));
>  	drm_mode_debug_printmodeline(adjusted_mode);
> -}
> -
> -static void
> -nwl_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> -				 struct drm_bridge_state *old_bridge_state)
> -{
> -	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
> -	int ret;
>  
> -	pm_runtime_get_sync(dsi->dev);
> +	pm_runtime_get_sync(dev);
>  
>  	if (clk_prepare_enable(dsi->lcdif_clk) < 0)
>  		return;
> @@ -882,22 +879,22 @@ nwl_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
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
> @@ -953,7 +950,6 @@ static const struct drm_bridge_funcs nwl_dsi_bridge_funcs = {
>  	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
>  	.atomic_reset		= drm_atomic_helper_bridge_reset,
>  	.atomic_check		= nwl_dsi_bridge_atomic_check,
> -	.atomic_pre_enable	= nwl_dsi_bridge_atomic_pre_enable,
>  	.atomic_enable		= nwl_dsi_bridge_atomic_enable,
>  	.atomic_disable		= nwl_dsi_bridge_atomic_disable,
>  	.mode_set		= nwl_dsi_bridge_mode_set,
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
