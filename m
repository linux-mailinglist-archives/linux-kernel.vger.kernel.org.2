Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3892538CA21
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbhEUPdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbhEUPdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:33:36 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBE7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 08:32:13 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j14so19741732wrq.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 08:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=CNMKcijQVquaMBJ+WGo20PjbrA43l1fqxKOe5bq3x5g=;
        b=F9unqGpK9ZQWLu39xhVuEsxgo/Cbu5rApxCHVDojuxkO9F4/RQCxzbo8HGlGB9Dwu5
         sM9mNN3i5SwK9YGrVlkvXFAxgPngSsy9cqNGKYFZDGruGE0vZ1KPnWms9rkNWPMq86ue
         LNYGJnmtkyvjXNUO8651tNd4MS/Gs8LBCpzKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=CNMKcijQVquaMBJ+WGo20PjbrA43l1fqxKOe5bq3x5g=;
        b=JCQfDhVZgGhW8ypDYpMKEFeC0ZVyp9cuZIJUwJeaPdcCcQO9GJ0AoStPjRSAIV9SjU
         dLlEJjndScY7lNkSE8CJJTLg+YW2AtMge+qZU2ceWrN+f5UseNWHIr9EFM8LyPiJtHE2
         m+HCuqDZWEgrocRZEn17VcJDXHfX/AzwZTn+CieCYmvY7VEQ06NN0VCcMz/ZgngnsRUQ
         8lEkC0RdGYDk/ujkoWkCyvXi5GhgbVxY1YPP9zt9R2DkQpMFwlNCAHrT5dofZ9fhdPVs
         l/WCAUPQicReT1+ozrYvN8+52g0I8iSXtfPR5DCXArmM0f0y3OafUF54bxzKHcu99jn+
         mCvw==
X-Gm-Message-State: AOAM530jUF7sW9AmXi55UxCKPkR87FWHBKCgh3OQ8n0sGhzOev24I5f5
        M3IG61iGsaevSRgbkkqD7mK+mQ==
X-Google-Smtp-Source: ABdhPJy7hNKHarTmPB2N61OrXBmySG8p0l/JeTOBfBGdkOtjecHjbovid48JSrymvCZOc64qF7pPxA==
X-Received: by 2002:adf:e4c8:: with SMTP id v8mr10338485wrm.345.1621611131705;
        Fri, 21 May 2021 08:32:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q1sm12703589wmq.48.2021.05.21.08.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 08:32:11 -0700 (PDT)
Date:   Fri, 21 May 2021 17:32:09 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, emma@anholt.net, mripard@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm: Fix PM reference leak
Message-ID: <YKfSeS1vvqKNSRSH@phenom.ffwll.local>
Mail-Followup-To: Zou Wei <zou_wei@huawei.com>, a.hajda@samsung.com,
        narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, emma@anholt.net,
        mripard@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1621602186-74786-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621602186-74786-1-git-send-email-zou_wei@huawei.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 09:03:06PM +0800, Zou Wei wrote:
> pm_runtime_get_sync will increment pm usage counter even it failed.
> Forgetting to putting operation will result in reference leak here.
> Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> counter balanced.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Looks good, but can you pls split this up into a patch per driver (vc and
bridge/cdns-dsi here)?

Thanks, Daniel

> ---
>  drivers/gpu/drm/bridge/cdns-dsi.c | 2 +-
>  drivers/gpu/drm/vc4/vc4_hdmi.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
> index 76373e3..b31281f 100644
> --- a/drivers/gpu/drm/bridge/cdns-dsi.c
> +++ b/drivers/gpu/drm/bridge/cdns-dsi.c
> @@ -1028,7 +1028,7 @@ static ssize_t cdns_dsi_transfer(struct mipi_dsi_host *host,
>  	struct mipi_dsi_packet packet;
>  	int ret, i, tx_len, rx_len;
>  
> -	ret = pm_runtime_get_sync(host->dev);
> +	ret = pm_runtime_resume_and_get(host->dev);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index c27b287..f20a65b 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -798,7 +798,7 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder,
>  	unsigned long pixel_rate, hsm_rate;
>  	int ret;
>  
> -	ret = pm_runtime_get_sync(&vc4_hdmi->pdev->dev);
> +	ret = pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev);
>  	if (ret < 0) {
>  		DRM_ERROR("Failed to retain power domain: %d\n", ret);
>  		return;
> -- 
> 2.6.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
