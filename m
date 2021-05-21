Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E5538CA3F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbhEUPfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbhEUPfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:35:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5BAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 08:33:47 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v12so21486029wrq.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=hSIZxyk96SLY1XQc0ujDhUeuMAPOJDJS58v+vou3vqU=;
        b=Sbw/57As09mDpcBGYQp3lkC801L3fY2gN/R6txd/32+cNs0LPsc9ddXDYBbIhaCsvg
         9fulOrU0ivZ8C4UDpYFNvK/sMe3ht6NLXkjpdzFPdPwycNvhvgGpfKVntFngOC4vmZJn
         Rox2+8t2qTDE+tGikX+8G2REPunu79FyIW0rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=hSIZxyk96SLY1XQc0ujDhUeuMAPOJDJS58v+vou3vqU=;
        b=K1JGI3gTEphOK6OjJZS+Kzu1q3xFd02IydSTBfhHm3jjMkDiIb8at+gyuB4IKtqP+5
         ONQytmIOVPsflfQ5GikfuLt0v1iRJ5NnghZxhXfPtTHZRFpq71nRTBwl1RHPzaIIIGTa
         5nC1hbccne4GhWrEHKHZJKJpPw6Xbn6TKXTPfW3d5tbu2IBekgX+m0rkHGYpvbv1aeWS
         krU8n+OBwEU6gRl5ZWR0K8pvMwVDph6/FSlyKzp9Og4O0xEJjoWKdNN5q9W+EfxrQy4M
         LWvDRmZxepyxzFWJ2B4iLB5K4iFKibCYtwXxYfDmZnoWVvFusBtmEiyddXFAlvlNCLti
         yRpw==
X-Gm-Message-State: AOAM5313lTkFVlUP5eqwJDRhLZs5r4oJTvKk9CCC/NSCI8e85dnqvO8J
        yRrcQ2KVskb5tkC8W27Dif/bGw==
X-Google-Smtp-Source: ABdhPJyFAxjYLwd3JRLG1+e5wLLBwZ5a4eoEosj6V0G47O1d5wSUaiR91EvP476eAX0cwRU7w4HuPA==
X-Received: by 2002:a5d:5301:: with SMTP id e1mr10197031wrv.36.1621611226499;
        Fri, 21 May 2021 08:33:46 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c6sm2528654wru.50.2021.05.21.08.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 08:33:45 -0700 (PDT)
Date:   Fri, 21 May 2021 17:33:44 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/fb-helper: improve DRM fbdev emulation device names
Message-ID: <YKfS2GDCXPJ/q8gT@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Peter Robinson <pbrobinson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
References: <20210521131910.3000689-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521131910.3000689-1-javierm@redhat.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 03:19:10PM +0200, Javier Martinez Canillas wrote:
> Framebuffer devices that are registered by DRM drivers for fbdev emulation
> have a "drmfb" suffix in their name. But makes them to be quite confusing
> if a driver already has "drm" in its name:
> 
> $ cat /proc/fb
> 0 rockchipdrmdrmfb
> 
> $ cat /proc/fb
> 0 simpledrmdrmfb
> 
> Instead, let's just add a "-fb" suffix to denote that are DRM drivers FB:
> 
> $ cat /proc/fb
> 0 rockchipdrm-fb
> 
> $ cat /proc/fb
> 0 simpledrm-fb
> 
> Suggested-by: Peter Robinson <pbrobinson@gmail.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

So what with all the drivers which do _not_ have drm in their name? Also
I'm never sure how much these are uapi or not ...
-Daniel

> ---
> 
>  drivers/gpu/drm/drm_fb_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index f6baa204612..bbaff92c509 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -1737,7 +1737,7 @@ void drm_fb_helper_fill_info(struct fb_info *info,
>  			       sizes->fb_width, sizes->fb_height);
>  
>  	info->par = fb_helper;
> -	snprintf(info->fix.id, sizeof(info->fix.id), "%sdrmfb",
> +	snprintf(info->fix.id, sizeof(info->fix.id), "%s-fb",
>  		 fb_helper->dev->driver->name);
>  
>  }
> -- 
> 2.31.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
