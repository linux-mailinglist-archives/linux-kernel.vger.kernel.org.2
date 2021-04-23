Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2053696AE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 18:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhDWQNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 12:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhDWQN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 12:13:27 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EBEC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 09:12:49 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so40634767otf.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t2yrefWokbt33zTb8tmxj08fAqkU3+m9KUoV5do9LC0=;
        b=PJ/zA3NEHcqEnhs54KzGFdXCkq4oVc/gAhKk8CPtOzBSe3RpJxzCnR8t0i5EWQ2rUn
         cBvcR75IV7rT/nCF4fzK4L8JBnVnV4fvzgBFlVnTefFtn/sUFAydBkgugBPl4u093wYZ
         UDBgcLOOuPdIfospceeYriu21HsVIX0XCEve5L1FragZ4PenxTOH+fi3cwYSG5rMeTin
         LtV8ITJCs8Q93hancAReZ5D8emnlNbC2HuKZKWPu6z95xsaBrZUQkp97rZArr0f5ra/j
         sXNPosDBmufG4qNw09oYtxTfSW/XWSxeGYTLVEb3D4jQD5sG/i5PvthnYHoL+Z7V9PIh
         FDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t2yrefWokbt33zTb8tmxj08fAqkU3+m9KUoV5do9LC0=;
        b=mXnrOw70ZV0KOEVy2N0xb5pzG/ByRGkc4kE/+Ml1DFnWurYgGl5ZenrLLmxSziQXQZ
         CLG9Jbx2kqapXF6o3vhXCVt2d66DUJ6MTo4Y2OmNRde/bYQxTXzxLwbKSkCuZ3Vckk5S
         UP+DztI/F68GtnaELHMqG73ILm5j48AKh6XF+Z1TVgoAamVFXJgTVe+DcrtlOR9gmBbw
         gmiinKmTy/2cOCk1sFnqeYy7gVe5AS5Lxq89I06+VAjxc5JIdZwA5tU0oVnG0ZNwvPAg
         jJTum2adshv03GbsIhNAjb7NseQsNG8vBWleJNMgakXhoL2Ts1o/gDzI5Z0DBbvvz2mg
         CvuA==
X-Gm-Message-State: AOAM531F+K2qJYCE5xjgl+rJKn5zySPXfuMVnnPcDe6P9wZql974kqZh
        H/ZGKtb9VKvMvCAvgm8Wy5dvpg==
X-Google-Smtp-Source: ABdhPJz1tp/EQchiVjH4auFBqgFjc0Uz3XgKzC1NFD0VSi1F0QaLnrO+79sKOL4PwuCs206USDCV7A==
X-Received: by 2002:a9d:5a1a:: with SMTP id v26mr4123172oth.50.1619194368866;
        Fri, 23 Apr 2021 09:12:48 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x24sm1465060otk.16.2021.04.23.09.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 09:12:48 -0700 (PDT)
Date:   Fri, 23 Apr 2021 11:12:46 -0500
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
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 24/27] drm/panel: panel-simple: Cache the EDID as long
 as we retain power
Message-ID: <YILx/iODs+DFWWwm@builder.lan>
References: <20210416223950.3586967-1-dianders@chromium.org>
 <20210416153909.v4.24.If050957eaa85cf45b10bcf61e6f7fa61c9750ebf@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416153909.v4.24.If050957eaa85cf45b10bcf61e6f7fa61c9750ebf@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16 Apr 17:39 CDT 2021, Douglas Anderson wrote:

> It doesn't make sense to go out to the bus and read the EDID over and
> over again. Let's cache it and throw away the cache when we turn power
> off from the panel. Autosuspend means that even if there are several
> calls to read the EDID before we officially turn the power on then we
> should get good use out of this cache.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  drivers/gpu/drm/panel/panel-simple.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 40382c1be692..5a2953c4ca44 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -189,6 +189,8 @@ struct panel_simple {
>  	struct gpio_desc *enable_gpio;
>  	struct gpio_desc *hpd_gpio;
>  
> +	struct edid *edid;
> +
>  	struct drm_display_mode override_mode;
>  
>  	enum drm_panel_orientation orientation;
> @@ -345,6 +347,9 @@ static int panel_simple_suspend(struct device *dev)
>  	regulator_disable(p->supply);
>  	p->unprepared_time = ktime_get();
>  
> +	kfree(p->edid);
> +	p->edid = NULL;

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>


But separate of this, shouldn't the driver have a pm_runtime_disable()
in the remove path to synchronize the autosleep? Or is that not how that
works?

Regards,
Bjorn

> +
>  	return 0;
>  }
>  
> @@ -510,15 +515,13 @@ static int panel_simple_get_modes(struct drm_panel *panel,
>  
>  	/* probe EDID if a DDC bus is available */
>  	if (p->ddc) {
> -		struct edid *edid;
> -
>  		pm_runtime_get_sync(panel->dev);
>  
> -		edid = drm_get_edid(connector, p->ddc);
> -		if (edid) {
> -			num += drm_add_edid_modes(connector, edid);
> -			kfree(edid);
> -		}
> +		if (!p->edid)
> +			p->edid = drm_get_edid(connector, p->ddc);
> +
> +		if (p->edid)
> +			num += drm_add_edid_modes(connector, p->edid);
>  
>  		pm_runtime_mark_last_busy(panel->dev);
>  		pm_runtime_put_autosuspend(panel->dev);
> -- 
> 2.31.1.368.gbe11c130af-goog
> 
