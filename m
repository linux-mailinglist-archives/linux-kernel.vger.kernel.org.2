Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D643636F734
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhD3IgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhD3IgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:36:01 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7034DC06138C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:35:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 26-20020a05600c22dab029013efd7879b8so1299065wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a+bpxvXrCumd+0ZkpocwQojFVxQtmszrDN0GGOxfQ6E=;
        b=C1u0zByjvLDQd2b5gMuupfkP/+EZxXVDPwz24p3nBUAv9+PlwhWjfkXWcmVXzqLyin
         RL9g4g5qeJi2EGXBYoHmBDDZkW9IiEjU/CHl/hI5zWdR2RiXD0vd3kEflockuHc2oU/j
         lhtfUA41gYco/BWpaM09hUFZPHkECBb8V8CN7oACug0iDn1+rr07DKHG4d8fIbV6e72K
         7lBW3ADKFY+xBo6wwsXbnrOUZJ8uP2rsz7LKMc8pLs3hC0vFN5jip6eUbaS8JyINho0z
         MMERIf/ZukSWi4bmSRrGe29+XcKZRCptDEsqkbO9+bttg1B0mKOZhjhC8/tmkSUQbrQs
         2pKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=a+bpxvXrCumd+0ZkpocwQojFVxQtmszrDN0GGOxfQ6E=;
        b=s3DP//rZoLZUc2MIWdAsfyBQCdiB48mRUMkXmOavu4/9G8FfF3mBslCLLsh09dDAmB
         RCyzAMhc08Uvtr0btxWWA9jx35d5MtEUuxAPNnS+LWK87pjnp+7Gea089XImwpLJ2zcw
         ZnpEOG2I/wtVctLNMWzLTaarxrrLoTvTuxqG3c3aDR4xMKyDg/94lUe4TFA3KA90IErs
         5OnVffmw4bpwiqAv+CUSfMM6ol+Gue1Brss2G4KnthpTnej/C28feTN7U+XRdbUlJKcb
         Oe77lxOke4ujwuWGBMYo9R/R8Ncf7M6+FOFSG5RJTPPhpfK1UQX9MPWTaC6r/tlyRPER
         g+Zw==
X-Gm-Message-State: AOAM532q4NtqfQ8UZmP7fUrg2MXefXhFG/eRvaVnuBcX3iZaHRuae1ut
        Zvqg+Xf8C7CbqrqGmWqroFhRJA==
X-Google-Smtp-Source: ABdhPJw613zFbLTeMGoyT+jCIEGAh2nEpztCeJ3FnVr56SiV3w8Tb+tXyEQIT+ydSKtF2RPSmwCFwA==
X-Received: by 2002:a1c:1bc1:: with SMTP id b184mr15104890wmb.119.1619771712131;
        Fri, 30 Apr 2021 01:35:12 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:4a89:8c32:4adc:fc67? ([2a01:e0a:90c:e290:4a89:8c32:4adc:fc67])
        by smtp.gmail.com with ESMTPSA id j13sm1389076wrw.93.2021.04.30.01.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 01:35:11 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] drm/bridge: nwl-dsi: Remove a check on unchanged
 HS clock rate from ->mode_set()
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, a.hajda@samsung.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, agx@sigxcpu.org, robert.chiras@nxp.com,
        linux-imx@nxp.com
References: <1619170003-4817-1-git-send-email-victor.liu@nxp.com>
 <1619170003-4817-3-git-send-email-victor.liu@nxp.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <176671b3-b0f8-d1be-79a1-ebf8ee9123e9@baylibre.com>
Date:   Fri, 30 Apr 2021 10:35:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1619170003-4817-3-git-send-email-victor.liu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2021 11:26, Liu Ying wrote:
> The check on unchanged HS clock rate in ->mode_set() improves
> the callback's performance a bit by early return.  However,
> the up-coming patch would get MIPI DSI controller and PHY ready
> in ->mode_set() after that check, thus likely skipped.
> So, this patch removes that check to make sure MIPI DSI controller
> and PHY will be brought up and taken down from ->mode_set() and
> ->atomic_disable() respectively in pairs.
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
>  drivers/gpu/drm/bridge/nwl-dsi.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index c65ca860712d2..601ccc4a7cdc7 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -856,13 +856,6 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
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
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
