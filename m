Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DC036F730
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhD3If4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhD3If4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:35:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A34C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:35:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q9so15468748wrs.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/tXUK9fLxdnwD3DuPuv0xoO/5Gq+yxo89QJhbRT++j8=;
        b=CF9zKNqjZOYj0eqB5VmQnkHfPHe3au03bb7bUcKO0K72ii3ROD89T+ExNEmvJ1BwpX
         /LSCyi1VmQQJl5Eib7XdvRkv1ajk+gdJTNPhCCNS4s5rAWgr3Oe7PCmp8TVX7+pBP/Eq
         2eUCw+hLL7Yl4lduVLlQ5gzbo3GlJoWFeIjVxFp9CLSQ9HBkG9A2f3BG+CwtBxhkPCI9
         gglMcppLBxzvqL4XFSjljdHoDS9j+mpp0igrELA9oEv50e+NWBuonQy9L+zUngcGW9h9
         agO6cksTN/fV6YkKfmmVGR22KqGEFaBMCFP0Dq40KpOS7/tx84I4/NVBLZUm/OB/NXwj
         SZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/tXUK9fLxdnwD3DuPuv0xoO/5Gq+yxo89QJhbRT++j8=;
        b=kvbidgUbtDv3gvTAZsdWiXHOanxYUg+6hP8ebccamMz6ZIN8QuQMYNRQY+QGZvPwQN
         xL8x+DPUFhkyjWsj3U1f2rMjshHgiRrUhXFYqHTbENiUUUDYWeaRKxpk7E0CX/flzb3b
         s6ac7wmsE1EoGYk+i+Kj1v5BCQhSTZq1frhwv+ym67dult8So6VhIxA7BtNQFNwbXrA0
         5A6dWBhFyfdYAhxm3Ppp2wMIUrOQmsw1yMVctU2PS1HZrxu71pSqh9JRD5BqTGWt/wo1
         NSuWQtCuWNbcfgNykAHiLt/lYhCu82qzHMqKqrTd3W5eoQQbePkdCf6nE9PPp3CVlnK7
         POwA==
X-Gm-Message-State: AOAM532pnyHi0wAEeIkn2l/rtDODR7riJWMwg3wyKK015KmV3emx/KFS
        M3Y1HuOr6FBuwf3GWo/Nxqh5PQ==
X-Google-Smtp-Source: ABdhPJwVCEIiwpqYFK1FbKbUrG+BhWuRndaeqLWzhqdX41zxNaRjPxf+DkjqwXkaRvVvn4HrPtbf+Q==
X-Received: by 2002:a5d:59ab:: with SMTP id p11mr4461101wrr.54.1619771706949;
        Fri, 30 Apr 2021 01:35:06 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:4a89:8c32:4adc:fc67? ([2a01:e0a:90c:e290:4a89:8c32:4adc:fc67])
        by smtp.gmail.com with ESMTPSA id i3sm1594958wrb.46.2021.04.30.01.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 01:35:06 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] drm/bridge: nwl-dsi: Force a full modeset when
 crtc_state->active is changed to be true
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, a.hajda@samsung.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, agx@sigxcpu.org, robert.chiras@nxp.com,
        linux-imx@nxp.com
References: <1619170003-4817-1-git-send-email-victor.liu@nxp.com>
 <1619170003-4817-2-git-send-email-victor.liu@nxp.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <50781b4b-66dc-27ea-c564-0c383fddb69d@baylibre.com>
Date:   Fri, 30 Apr 2021 10:35:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1619170003-4817-2-git-send-email-victor.liu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2021 11:26, Liu Ying wrote:
> This patch replaces ->mode_fixup() with ->atomic_check() so that
> a full modeset can be requested from there when crtc_state->active
> is changed to be true(which implies only connector's DPMS is brought
> out of "Off" status, though not necessarily).  Bridge functions are
> added or changed to accommodate the ->atomic_check() callback.  That
> full modeset is needed by the up-coming patch which gets MIPI DSI
> controller and PHY ready in ->mode_set(), because it makes sure
> ->mode_set() and ->atomic_disable() are called in pairs.
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
> * Split from the single patch in v2 to clarify changes. (Neil)
> 
>  drivers/gpu/drm/bridge/nwl-dsi.c | 61 ++++++++++++++++++++------------
>  1 file changed, 39 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index 66b67402f1acd..c65ca860712d2 100644
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
> @@ -742,7 +743,9 @@ static int nwl_dsi_disable(struct nwl_dsi *dsi)
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
> @@ -803,17 +806,6 @@ static int nwl_dsi_get_dphy_params(struct nwl_dsi *dsi,
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
> @@ -831,6 +823,24 @@ nwl_dsi_bridge_mode_valid(struct drm_bridge *bridge,
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
> +	/* Do a full modeset if crtc_state->active is changed to be true. */
> +	if (crtc_state->active_changed && crtc_state->active)
> +		crtc_state->mode_changed = true;
> +
> +	return 0;
> +}
> +
>  static void
>  nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
>  			const struct drm_display_mode *mode,
> @@ -862,7 +872,9 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
>  	drm_mode_debug_printmodeline(adjusted_mode);
>  }
>  
> -static void nwl_dsi_bridge_pre_enable(struct drm_bridge *bridge)
> +static void
> +nwl_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> +				 struct drm_bridge_state *old_bridge_state)
>  {
>  	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
>  	int ret;
> @@ -897,7 +909,9 @@ static void nwl_dsi_bridge_pre_enable(struct drm_bridge *bridge)
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
> @@ -942,14 +956,17 @@ static void nwl_dsi_bridge_detach(struct drm_bridge *bridge)
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
> +	.atomic_pre_enable	= nwl_dsi_bridge_atomic_pre_enable,
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

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
