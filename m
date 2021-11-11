Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4438744D471
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhKKJ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhKKJ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:57:53 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8266C061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 01:55:04 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i12so3706224wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 01:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=bdsCoAnax0xMdSi3LEgeLkYD/HFUU9RT8hDhS95OAt0=;
        b=Pvr6LjVy0p4znnuxieeKa3HPTeRFxZ+3knxotyGb0PFNzFJ4xM/abD+ljU/qbLS9aR
         5QrmdMZmVTweFvDlm2eLs44xWhyVo1EBNNm2nIWCe+7jkOi+vZBd8ZaHb6Q7ZgYPqtQp
         kLq9fvUodqqeqMnMOUsVbbtGxI7f175Jrdez0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=bdsCoAnax0xMdSi3LEgeLkYD/HFUU9RT8hDhS95OAt0=;
        b=K2Rg1wAWKqt4GYrzcP9lZev2mZ5blhtQirE8Lv0VnldwWlv4TrO8ZNqpX6SH2J6KZR
         mPy/1rDuLPBku1ry10Q0kDl0yp7VnkghCOW6AXU1udZgw9lekAm1bb/OFaE0PwykGkdw
         y8vttWp5DhtArOH/0BZ8N72dntbqtiUKBitqLmEkWzVAcASAUqR6SkmQ7B+af0Bx9Ncj
         MFnff4wtonVBWaaNvnVtOowheS8JD0LcRy4C2EzendJOBOcJUziMmN5K4dFwEw0eSTc5
         x74u/msgB2UzatgUXjfeGqXfL33sp3wVEdmsvP8fmKJLVWSm1P+gaFXozdXXN7SFjTpw
         NYwg==
X-Gm-Message-State: AOAM532AH0jb2hpP92+J1sratoaLDNZ9vgzUdHc04yE/ZeYXKzA9xgaZ
        3x6EgOC4MRl1u0wFVWWmaLKE0w==
X-Google-Smtp-Source: ABdhPJzZD6hXg1vjTxLyAuHF9yWYrd++DYJyRcez14UgECfYo+Da2LILIKoHIcu0e84TnnarVAnjJw==
X-Received: by 2002:a7b:c1cb:: with SMTP id a11mr7024713wmj.30.1636624503159;
        Thu, 11 Nov 2021 01:55:03 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p19sm2521931wmq.4.2021.11.11.01.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 01:55:02 -0800 (PST)
Date:   Thu, 11 Nov 2021 10:54:33 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ilya Trukhanov <lahvuun@gmail.com>
Subject: Re: [PATCH] fbdev: Prevent probing generic drivers if a FB is
 already registered
Message-ID: <YYzoWTMBkC64a4Cn@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ilya Trukhanov <lahvuun@gmail.com>
References: <20211111092053.1328304-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111092053.1328304-1-javierm@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 10:20:53AM +0100, Javier Martinez Canillas wrote:
> The efifb and simplefb drivers just render to a pre-allocated frame buffer
> and rely on the display hardware being initialized before the kernel boots.
> 
> But if another driver already probed correctly and registered a fbdev, the
> generic drivers shouldn't be probed since an actual driver for the display
> hardware is already present.
> 
> Reported-by: Ilya Trukhanov <lahvuun@gmail.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Also Cc: stable@vger.kernel.org?

btw time to organize drm-misc commit rights so you can push stuff like
this?
-Daniel

> ---
> 
>  drivers/video/fbdev/efifb.c    | 6 ++++++
>  drivers/video/fbdev/simplefb.c | 6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git drivers/video/fbdev/efifb.c drivers/video/fbdev/efifb.c
> index edca3703b964..76325c07cf0c 100644
> --- drivers/video/fbdev/efifb.c
> +++ drivers/video/fbdev/efifb.c
> @@ -351,6 +351,12 @@ static int efifb_probe(struct platform_device *dev)
>  	char *option = NULL;
>  	efi_memory_desc_t md;
>  
> +	if (num_registered_fb > 0) {
> +		dev_err(&dev->dev,
> +			"efifb: a framebuffer is already registered\n");
> +		return -EINVAL;
> +	}
> +
>  	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI || pci_dev_disabled)
>  		return -ENODEV;
>  
> diff --git drivers/video/fbdev/simplefb.c drivers/video/fbdev/simplefb.c
> index 62f0ded70681..55c1f54d7663 100644
> --- drivers/video/fbdev/simplefb.c
> +++ drivers/video/fbdev/simplefb.c
> @@ -407,6 +407,12 @@ static int simplefb_probe(struct platform_device *pdev)
>  	struct simplefb_par *par;
>  	struct resource *mem;
>  
> +	if (num_registered_fb > 0) {
> +		dev_err(&pdev->dev,
> +			"simplefb: a framebuffer is already registered\n");
> +		return -EINVAL;
> +	}
> +
>  	if (fb_get_options("simplefb", NULL))
>  		return -ENODEV;
>  
> -- 
> 2.33.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
