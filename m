Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD853694F3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242715AbhDWOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242681AbhDWOmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:42:05 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40A5C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:41:27 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id l17so18060108oil.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FePZXkucMceLOfDt03Vpu6abm992vMdpP+oGJ2jOjNw=;
        b=m6fpWplmKwdwXU4JK/IzeVTFzLzC28YWwbXoD+y/NaLLaErrITDCBfoyGoqFlIdHtw
         2Ai/wBaQ/xW7RyPPeV2dMP1pp+WVF4QImf73t/ouSQmci0HuziElWSVp2RdH1RIVvkWH
         /ucHbwRkH0n8TZ9bcizSv996O93ISQEPrkQBlCjrKx53OY1o1SFfhyB1MsGb45PeKr8F
         EtXs/0kpF1Sfi19AoeE8Y7oDxDgMiKcts7PNmyofMsCGA5xnz+EG/AXo6gBir5R3VmnJ
         SJt7pUeTT+NKIbktxIgXSSdyGduCcevrzTTlVtayEjH0KOnCIV4g/n8PI9x2USqEP0UZ
         6gKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FePZXkucMceLOfDt03Vpu6abm992vMdpP+oGJ2jOjNw=;
        b=QAwPX5Ee3msjmB/udUPCAOUDnAbd/q7Zx3zLdSG+KdaCAbKA/aUSZraYPUQyraIVjd
         Jz6LImSsxN68DzEqEac37rbbz6F4CFQVZCG5PDSRDVV8MMO69pFcTl+KIeP3BR1M2vFD
         vWDPXBJZqS0K4Q3tYnRlBFKy2bP4LNQXrNz+ZsRkP/p1Ed0skAhODFImXZETRDIjCo6c
         G14yIz4Ef9Gy8kET29kOlivvL7xNuT3KQk5HOo4KQZwajn4hw5HCo8UR9Hvi25hdfi24
         gThF1B8fJwhnb96BaX7O994mRY/kGFYVu2PC8RCwSspqhhvXKFUxRiqw6Z9XMvGWZWb/
         c4TQ==
X-Gm-Message-State: AOAM531GZeOGonwOcLuCOFEvO4UTI3mYx2Ns1CNDta4GqhYVbFBkWnns
        /v9Mg4fsmI5uT7H8W0ZE3ZfGtA==
X-Google-Smtp-Source: ABdhPJxwatmNfPYAnerhrE6CQ2lbmlzjbgp9e+EIKP+DoG9PcKGhtuAVJ9evo923JktvZP5xV9BSBA==
X-Received: by 2002:a05:6808:1305:: with SMTP id y5mr4378294oiv.142.1619188887294;
        Fri, 23 Apr 2021 07:41:27 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j20sm1228593ooc.29.2021.04.23.07.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:41:26 -0700 (PDT)
Date:   Fri, 23 Apr 2021 09:41:24 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, robdclark@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, Linus W <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/27] drm/bridge: ti-sn65dsi86: Move all the
 chip-related init to the start
Message-ID: <YILclD/XF1Ww6H7g@builder.lan>
References: <20210416223950.3586967-1-dianders@chromium.org>
 <20210416153909.v4.14.Ide8ba40feb2e43bc98a11edbb08d696d62dcd83e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416153909.v4.14.Ide8ba40feb2e43bc98a11edbb08d696d62dcd83e@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16 Apr 17:39 CDT 2021, Douglas Anderson wrote:

> This is just code motion of the probe routine to move all the things
> that are for the "whole chip" (instead of the GPIO parts or the
> MIPI-to-eDP parts) together at the start of probe. This is in
> preparation for breaking the driver into sub-drivers.
> 
> Since we're using devm for all of the "whole chip" stuff this is
> actually quite easy now.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 53f1f7b3022f..57bc489a0412 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -1253,12 +1253,6 @@ static int ti_sn65dsi86_probe(struct i2c_client *client,
>  		return PTR_ERR(pdata->regmap);
>  	}
>  
> -	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &pdata->panel, NULL);
> -	if (ret) {
> -		DRM_ERROR("could not find any panel node\n");
> -		return ret;
> -	}
> -
>  	pdata->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
>  	if (IS_ERR(pdata->enable_gpio)) {
>  		DRM_ERROR("failed to get enable gpio from DT\n");
> @@ -1266,8 +1260,6 @@ static int ti_sn65dsi86_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> -	ti_sn_bridge_parse_lanes(pdata, dev->of_node);
> -
>  	ret = ti_sn65dsi86_parse_regulators(pdata);
>  	if (ret) {
>  		DRM_ERROR("failed to parse regulators\n");
> @@ -1278,12 +1270,22 @@ static int ti_sn65dsi86_probe(struct i2c_client *client,
>  	if (IS_ERR(pdata->refclk))
>  		return PTR_ERR(pdata->refclk);
>  
> -	ret = ti_sn_bridge_parse_dsi_host(pdata);
> +	pm_runtime_enable(dev);
> +	ret = devm_add_action_or_reset(dev, ti_sn65dsi86_runtime_disable, dev);
>  	if (ret)
>  		return ret;
>  
> -	pm_runtime_enable(dev);
> -	ret = devm_add_action_or_reset(dev, ti_sn65dsi86_runtime_disable, dev);
> +	ti_sn65dsi86_debugfs_init(pdata);
> +
> +	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &pdata->panel, NULL);
> +	if (ret) {
> +		DRM_ERROR("could not find any panel node\n");
> +		return ret;
> +	}
> +
> +	ti_sn_bridge_parse_lanes(pdata, dev->of_node);
> +
> +	ret = ti_sn_bridge_parse_dsi_host(pdata);
>  	if (ret)
>  		return ret;
>  
> @@ -1301,8 +1303,6 @@ static int ti_sn65dsi86_probe(struct i2c_client *client,
>  
>  	drm_bridge_add(&pdata->bridge);
>  
> -	ti_sn65dsi86_debugfs_init(pdata);
> -
>  	return 0;
>  }
>  
> -- 
> 2.31.1.368.gbe11c130af-goog
> 
