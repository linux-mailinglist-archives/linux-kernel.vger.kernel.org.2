Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318D93695EA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbhDWPQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237114AbhDWPQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:16:53 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81497C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:16:15 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so45575637otn.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BjzbYvHGDqNt1YrSCIFKFkhQqyjNhWk2rxPsi+B5Z3s=;
        b=UzkHH4Za2rzrIPCUbRuGbPYHM4r9JlI4pOryZV93zkkwAN7aqG2i26EObLU6VO5xUL
         eZzSjnwKZrDgKpkPR7aEHclOaavZGSKmhSw6MNRclEK9MTCcqJ/wbMpa2iJayhcllkx3
         80fvTG4YREIStTYLYqJebwHp9baZtG5GbsKLMTlOg4lekOg6vq7aPWc31fTvkiNMqXmj
         J8jobDoUcybkm6/WLG/SKILg4X2ogYknn1U+3AWt/EKHObA1xzN91PITatYhWz3niIfS
         wE+7zMrdgklhMKbnVcVdbWSz+7/1nUE4rVp9yvNR3yVNXtoz58SuYF4kaOxKaEG5q+rr
         +Ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BjzbYvHGDqNt1YrSCIFKFkhQqyjNhWk2rxPsi+B5Z3s=;
        b=jXpAjQKdbjlImkaUPYC0NUjWba8Med5xBu+4ixurp53g0UhhwtcztSgUu02r0W6HUq
         8mpj0p7A4aQZTe81TFSj6sT+HLnfg1Xs8d8D+6nJjjuCxEkTBc9zaTB5dZ9db6hEbVBg
         EAGgNRoaZuT6C8TrAOU1dKDUnTGxNyFkf945IJDYAj6A2ANYcNI2DWg6m+SGs3diBIT1
         0CkqZcDaRQ4OHptjcT1E1snogTvUmf5HyWCzje+s20AfF78OMyxqWqJ7CzJvu23Hivsm
         RFH1pBSGc0i6Ou3aERlyTCWuNPb96Jc/46kJQFxOBvVFssaS2NsTt0gY0IsMc6w3E5xK
         f+XQ==
X-Gm-Message-State: AOAM530OcViiR4522nNxYEMqwH1EjVe48MdAGnS9K3IUwJpymaWiaVPQ
        ra30n8dzrahBR12cJ4RyVFEk1Q==
X-Google-Smtp-Source: ABdhPJx2mA/UkPjKOQEWBZn8yjTss/9rypijIbSfKKeR01z01ECtO/FDlU2BQR7ZN9tTWnK5pHWk7A==
X-Received: by 2002:a9d:7003:: with SMTP id k3mr3876923otj.351.1619190974920;
        Fri, 23 Apr 2021 08:16:14 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s131sm1300317oib.14.2021.04.23.08.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 08:16:14 -0700 (PDT)
Date:   Fri, 23 Apr 2021 10:16:12 -0500
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
Subject: Re: [PATCH v4 23/27] drm/panel: panel-simple: Power the panel when
 reading the EDID
Message-ID: <YILkvOs1abQ7WzdA@builder.lan>
References: <20210416223950.3586967-1-dianders@chromium.org>
 <20210416153909.v4.23.Ibd31b8f7c73255d68c5c9f5b611b4bfaa036f727@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416153909.v4.23.Ibd31b8f7c73255d68c5c9f5b611b4bfaa036f727@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16 Apr 17:39 CDT 2021, Douglas Anderson wrote:

> I don't believe that it ever makes sense to read the EDID when a panel
> is not powered and the powering on of the panel is the job of
> prepare(). Let's make sure that this happens before we try to read the
> EDID. We use the pm_runtime functions directly rather than directly
> calling the normal prepare() function because the pm_runtime functions
> are definitely refcounted whereas it's less clear if the prepare() one
> is.
> 
> NOTE: I'm not 100% sure how EDID reading was working for folks in the
> past, but I can only assume that it was failing on the initial attempt
> and then working only later. This patch, presumably, will fix that. If
> some panel out there really can read the EDID without powering up and
> it's a big advantage to preserve the old behavior we can add a
> per-panel flag. It appears that providing the DDC bus to the panel in
> the past was somewhat uncommon in any case.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  drivers/gpu/drm/panel/panel-simple.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index c91e8aa108f7..40382c1be692 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -510,12 +510,18 @@ static int panel_simple_get_modes(struct drm_panel *panel,
>  
>  	/* probe EDID if a DDC bus is available */
>  	if (p->ddc) {
> -		struct edid *edid = drm_get_edid(connector, p->ddc);
> +		struct edid *edid;
>  
> +		pm_runtime_get_sync(panel->dev);
> +
> +		edid = drm_get_edid(connector, p->ddc);
>  		if (edid) {
>  			num += drm_add_edid_modes(connector, edid);
>  			kfree(edid);
>  		}
> +
> +		pm_runtime_mark_last_busy(panel->dev);
> +		pm_runtime_put_autosuspend(panel->dev);
>  	}
>  
>  	/* add hard-coded panel modes */
> -- 
> 2.31.1.368.gbe11c130af-goog
> 
