Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CF13E57C4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239507AbhHJKAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239506AbhHJKAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:00:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC1AC061799
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 02:59:43 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k5-20020a05600c1c85b02902e699a4d20cso2101527wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 02:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=MefEA4Nq7J6T2dI7JAfQRLzqq6xMi9Np2QTxe9FH/ao=;
        b=Ub3q5SAO7Kv1nHiTJ/N4yNZrN/khgI4qtvA5nxt+dxgcebDl0lDwBFwTvTxyrp17Vm
         wWikexHre+7ie2TJbQLseE0ju6eQjxzjjFRbnISwdtMOUvECJ5HKj8bl5EeAtEYl5bjH
         wJpMPRBavTTOgmIt46gi22Ae41uf/IhJSHAKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=MefEA4Nq7J6T2dI7JAfQRLzqq6xMi9Np2QTxe9FH/ao=;
        b=s2g01TcPaw9MyaEhKLhrQH9CYr98qSNbfKt+acrM9TFU6xfZHTPIX219LYYsmlCc7U
         t0F9qiO+0vliyUG9kfG6oCWX6nvcPCks5OFTy+OxVM+PrXDLKGVR48QukTWLDd5lbkdw
         OA0QLi900DrRqA/zHdSPZeWUzUfKaQWnGB6hLWFESVHekeL6CyV2MBLCgNKqjg9nv+BQ
         SO5Lan3Z/D8Ya53xbcgueozPY34u14uIa/QuW5o2wdWxsmefwdAr6uIfAnqcO0ZR7NdF
         jj3g6Fy/rJWDyrN+utphtm2ukzEQO3jWga3YSTUm1At3jPWg+eMyIA3bU7Az+7KIe8q1
         +Oaw==
X-Gm-Message-State: AOAM53384WS/sZBl53KhGfje2l3ecicczHKaEv+E72jtf8I5Ec+58DnA
        Tt8Vp/4cG1EdD/p0wLCawxJYUA==
X-Google-Smtp-Source: ABdhPJw0ncsCg1y+/DhOKn41spVPSe5l76r1tANrr6Xrdr7e6umhw8yDt/g593RlUe8DkFZlTNJkdg==
X-Received: by 2002:a1c:804a:: with SMTP id b71mr3682474wmd.141.1628589582148;
        Tue, 10 Aug 2021 02:59:42 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id e6sm20450115wme.6.2021.08.10.02.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 02:59:41 -0700 (PDT)
Date:   Tue, 10 Aug 2021 11:59:39 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/drv: Remove initialization of static variables
Message-ID: <YRJOCzKVJOfCS4Ro@phenom.ffwll.local>
Mail-Followup-To: zhaoxiao <zhaoxiao@uniontech.com>, robdclark@gmail.com,
        sean@poorly.run, airlied@linux.ie, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20210806023047.24386-1-zhaoxiao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806023047.24386-1-zhaoxiao@uniontech.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 10:30:47AM +0800, zhaoxiao wrote:
> Address the following checkpatch errors:
> ERROR: do not initialise statics to false
> 
> FILE: :drivers/gpu/drm/msm/msm_drv.c:21:
> -static bool reglog = false;
> 
> FILE: :drivers/gpu/drm/msm/msm_drv.c:31:
> -bool dumpstate = false;
> 
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>

Subject should start out with drm/msm, not drm/drv - that would indicate a
patch touching the drm_drv.c core files, or things related to that.
-Daniel

> ---
> v2: change the patch description 
>  drivers/gpu/drm/msm/msm_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 9b8fa2ad0d84..d9ca4bc9620b 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -59,7 +59,7 @@ static const struct drm_mode_config_helper_funcs mode_config_helper_funcs = {
>  };
>  
>  #ifdef CONFIG_DRM_MSM_REGISTER_LOGGING
> -static bool reglog = false;
> +static bool reglog;
>  MODULE_PARM_DESC(reglog, "Enable register read/write logging");
>  module_param(reglog, bool, 0600);
>  #else
> @@ -76,7 +76,7 @@ static char *vram = "16m";
>  MODULE_PARM_DESC(vram, "Configure VRAM size (for devices without IOMMU/GPUMMU)");
>  module_param(vram, charp, 0);
>  
> -bool dumpstate = false;
> +bool dumpstate;
>  MODULE_PARM_DESC(dumpstate, "Dump KMS state on errors");
>  module_param(dumpstate, bool, 0600);
>  
> -- 
> 2.20.1
> 
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
