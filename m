Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8B33D2231
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhGVJ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhGVJ7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:59:22 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026D6C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 03:39:58 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id t3so6181028edc.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 03:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=jnlm21J6SlYJjPe81X61eHbfm5OMgcOz8zyqmSLYvPQ=;
        b=NpBBKqrdi56YhzkxFSewaW9GKDUpQ+fUhYE5+RkUh/mBRnGlUYIeNVp7gFkyHII+Wc
         QRxqAzGrpMvRUg6TI08B6k9huJMutm+Hx1aPAR8bebLUxzxn13SB0Kk39EHnBS3c4YZR
         fWGT8oKhgDjLRfSJ9uW+AomaH4j1haN9aSZ0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=jnlm21J6SlYJjPe81X61eHbfm5OMgcOz8zyqmSLYvPQ=;
        b=tqpslWeR4pJVPClFhS2TkPvrSEgnSYH9DvAyqUnBKz3i8pWVI3/aYNiMHhuOJHIhgX
         NvlIXFaMH4kJ4dTGuH3NRxsSydJLrwOgY3rEdLUVcdFkTeoGw2akChik483ql+HH1O0H
         q5sjnmyMIz74SJuwS85QTbCv/RLEUXQwyiRs7HnwiFZpHKYJ7dhA6eFiI5/5z7nGn3pq
         TQ2MbZqfPz3ZJM4l3sltr/gEbpaBScOJUSKe66JpCYjDRJarTUZ9w7TkwoEGZSeFAD9o
         yjo7hJf9XJ0gYWlhOw6q5U3/pRBwZCVGZRgQh+IGQEGpmcdEx4gXj/sgF0PFGAlqkEik
         BRBA==
X-Gm-Message-State: AOAM53344kRJgR8M3RikXyOJAGyqvWwbd194eAYAeLWCYRr+tni3M6/7
        09uEhuEmbuplEjo6ksrC47DJbw==
X-Google-Smtp-Source: ABdhPJzr7EsXEh64NgUGE8NlxZu8PVM5/iUdV7lOJ1gOxWRo5nSODbf792yJ2bwdGRFWp7KaBmVx0g==
X-Received: by 2002:a05:6402:d2:: with SMTP id i18mr53783290edu.17.1626950391725;
        Thu, 22 Jul 2021 03:39:51 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id cq22sm12251755edb.77.2021.07.22.03.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 03:39:51 -0700 (PDT)
Date:   Thu, 22 Jul 2021 12:39:49 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     linux-graphics-maintainer@vmware.com, zackr@vmware.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 3/3] drm/vmwgfx: fix potential UAF in vmwgfx_surface.c
Message-ID: <YPlK9b+7CN533jpl@phenom.ffwll.local>
Mail-Followup-To: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-graphics-maintainer@vmware.com, zackr@vmware.com,
        airlied@linux.ie, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210722092929.244629-1-desmondcheongzx@gmail.com>
 <20210722092929.244629-4-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722092929.244629-4-desmondcheongzx@gmail.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 05:29:29PM +0800, Desmond Cheong Zhi Xi wrote:
> drm_file.master should be protected by either drm_device.master_mutex
> or drm_file.master_lookup_lock when being dereferenced. However,
> drm_master_get is called on unprotected file_priv->master pointers in
> vmw_surface_define_ioctl and vmw_gb_surface_define_internal.
> 
> This is fixed by replacing drm_master_get with drm_file_get_master.
> 
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I'll let Zack take a look at this and expect him to push this patch to
drm-misc.git.
-Daniel

> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> index 0eba47762bed..5d53a5f9d123 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> @@ -865,7 +865,7 @@ int vmw_surface_define_ioctl(struct drm_device *dev, void *data,
>  	user_srf->prime.base.shareable = false;
>  	user_srf->prime.base.tfile = NULL;
>  	if (drm_is_primary_client(file_priv))
> -		user_srf->master = drm_master_get(file_priv->master);
> +		user_srf->master = drm_file_get_master(file_priv);
>  
>  	/**
>  	 * From this point, the generic resource management functions
> @@ -1534,7 +1534,7 @@ vmw_gb_surface_define_internal(struct drm_device *dev,
>  
>  	user_srf = container_of(srf, struct vmw_user_surface, srf);
>  	if (drm_is_primary_client(file_priv))
> -		user_srf->master = drm_master_get(file_priv->master);
> +		user_srf->master = drm_file_get_master(file_priv);
>  
>  	res = &user_srf->srf.res;
>  
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
