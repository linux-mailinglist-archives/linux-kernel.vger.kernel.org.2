Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE72040FC5F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbhIQPc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbhIQPc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:32:27 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DE8C061764
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:31:05 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g11so9070272qtk.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7X1afZ73VKSyODOmfKxOaEasFjcfN4b6MQLd6Hy3k8E=;
        b=Er3xcMkHW0Vd5RfakskLkNxvu6I+CSGw4v7JtnwtV+IUFBr19q+6slAsRatI7PbFTk
         9VT0CMP4hPoWeZ4JgRzCV0XT7vaF8r3bSRZpgo4kIx8hyzfrvkC5Z/s2W8EOpwNmpDgS
         qEzdPEH8KT1m1/62h3M4j1Zc05hlau/qAgt2dIQqae+jvCXHdW+u2wR5hKU2lTgc1ZvP
         3zYIBGcvDAN/C9kDi+ykBi/zazwH7XO9UxyVj3zG33fT06KJelUzUlO+R2WacTqIYyB0
         aL3EkSwp5VDt6wJ7COgzOzgrGhpDskS57wTQ38WZouFAtyJtEdQf78lov2eDmfFmFhZV
         HwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7X1afZ73VKSyODOmfKxOaEasFjcfN4b6MQLd6Hy3k8E=;
        b=3C6h/ugxPHGZWVCzYORJCvecgJhsXI6JgIK2qjlG6mOEsRV2QeDtiojZ+PA5VWMT5E
         nT+xmiq+AEEzhh9tBrfezxuRc9FvvbPQZh4FhHkM1xrTd1iFUbkruRRIOAEzmrjB1zaa
         7jndp3V96Yxdxvfg3wL7QO9QSuU6uF5S5OwOV9rVHO2ZZHAjRZn0wkVochyiRJsWXHPV
         EnG2AbU8cTWnJnMG4frrz9YkviypG0lyqVJph7QJos1btyPM3nXPk4oJKAxy9wWf5tyv
         B1I+eZH1xC0SYQs/oh4q2hXHHwkaUDU8FkKBWsOwRST/tX67NpIkGoymMLG+IjaUdsUd
         68IA==
X-Gm-Message-State: AOAM5305zUz76cZaspAq2q3thjGpghW77ljZMoYnoZ1UE1aYD7Et5haX
        0HrT/iFBZw4c4H2TZD4baVp2EA==
X-Google-Smtp-Source: ABdhPJwjahZ1TqeH62g039cRCxfBYrWcC+lhlSDSdnE4I9J7ju+z6wB1QZ8H/+6isc91rxEeD3ZpcQ==
X-Received: by 2002:ac8:7cb:: with SMTP id m11mr11330316qth.72.1631892664440;
        Fri, 17 Sep 2021 08:31:04 -0700 (PDT)
Received: from localhost ([167.100.64.199])
        by smtp.gmail.com with ESMTPSA id 69sm5573766qke.55.2021.09.17.08.31.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Sep 2021 08:31:04 -0700 (PDT)
Date:   Fri, 17 Sep 2021 11:31:02 -0400
From:   Sean Paul <sean@poorly.run>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sean@poorly.run, linux-doc@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 02/15] dmr/i915: cleanup: drm_modeset_lock_all_ctx() -->
 DRM_MODESET_LOCK_ALL_BEGIN()
Message-ID: <20210917153102.GC2515@art_vandelay>
References: <20210916211552.33490-1-greenfoo@u92.eu>
 <20210916211552.33490-3-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916211552.33490-3-greenfoo@u92.eu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 11:15:39PM +0200, Fernando Ramos wrote:
> As requested in Documentation/gpu/todo.rst, replace the boilerplate code
> surrounding drm_modeset_lock_all_ctx() with DRM_MODESET_LOCK_ALL_BEGIN()
> and DRM_MODESET_LOCK_ALL_END()
> 

With the subject fixed (s/dmr/drm),

Reviewed-by: Sean Paul <sean@poorly.run>

> Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
> ---
>  drivers/gpu/drm/i915/display/intel_display.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index 134a6acbd8fb..997a16e85c85 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -13476,22 +13476,13 @@ void intel_display_resume(struct drm_device *dev)
>  	if (state)
>  		state->acquire_ctx = &ctx;
>  
> -	drm_modeset_acquire_init(&ctx, 0);
> -
> -	while (1) {
> -		ret = drm_modeset_lock_all_ctx(dev, &ctx);
> -		if (ret != -EDEADLK)
> -			break;
> -
> -		drm_modeset_backoff(&ctx);
> -	}
> +	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
>  
> -	if (!ret)
> -		ret = __intel_display_resume(dev, state, &ctx);
> +	ret = __intel_display_resume(dev, state, &ctx);
>  
>  	intel_enable_ipc(dev_priv);
> -	drm_modeset_drop_locks(&ctx);
> -	drm_modeset_acquire_fini(&ctx);
> +
> +	DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);
>  
>  	if (ret)
>  		drm_err(&dev_priv->drm,
> -- 
> 2.33.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
