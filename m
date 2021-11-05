Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0E444682D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbhKERzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhKERzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:55:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB46BC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:53:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v127so7688458wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 10:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=3qgpnu4+F949fFLt8z7lhntewhGpkCVCzWBi5xlW0s0=;
        b=dmlBo/fkpE9Iw7lZw2Qa6cY2qshJgOqn/esRDkYVWJovgHLAEfPt31IG47x6DF8jVM
         4ER8ljNzvW3nHCpkHveERc8dU94O8eFXdh0pmFSOcFDfUcoBREFZWbP2pQQKb3lMW0Nl
         NG05r2mL1x53BdJjnSZ5Qcs4k3ZemviXqIu88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=3qgpnu4+F949fFLt8z7lhntewhGpkCVCzWBi5xlW0s0=;
        b=LjGHlCXbhNHvf24snErmOV/ZPz+GtH903oeIc6A8VKQ+m2176kUd5DWtZI1rw576rG
         4Aln+YRgmo00R3a0iLwSZK1j4QsIDDS+3Ju9tLTGlBvLG9zrq4w5TRYB1gkADzokKRJw
         8vES5dV8yWN6u/gzV62lAxyKZr6/V0HB9b54gflWOnhksqQbnT5kac4y+XYMUf595xBf
         yVxlNIwzRXds0Skt9/Ou0AXFgK9r/kWQkWIg7A4fnqYLbkYkbAC8aBKRxErcJbTVNIlv
         z5QgAaygnsOhdp41B06WZTEVZ7c69p3K4gTAvNKI3poJ/9tgv2aBzo4AOn4WxLoXJl97
         0XHg==
X-Gm-Message-State: AOAM531sfCoV10QRsRQ510p7qBKnYIdcKl/lUXUCS34zoguC3I5SGoys
        N+WjSCVmz+W0RVWWWbmQdUj5Bw==
X-Google-Smtp-Source: ABdhPJxj4ymiq7qSLhQiUYJ5j1gU+jqd+d6bDAotiSbE0ZcSDcoiY/LEjRjkGyWD86rZ5EdVzoa5cA==
X-Received: by 2002:a05:600c:1c13:: with SMTP id j19mr31954323wms.175.1636134788288;
        Fri, 05 Nov 2021 10:53:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i15sm11461959wmb.20.2021.11.05.10.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 10:53:07 -0700 (PDT)
Date:   Fri, 5 Nov 2021 18:53:05 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        "Acked-by : Jani Nikula" <jani.nikula@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: fb_helper: improve CONFIG_FB dependency
Message-ID: <YYVvgVNz+py5H4Yz@phenom.ffwll.local>
Mail-Followup-To: Arnd Bergmann <arnd@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>,
        "Acked-by : Jani Nikula" <jani.nikula@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211029120307.1407047-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029120307.1407047-1-arnd@kernel.org>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 02:02:38PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> My previous patch correctly addressed the possible link failure, but as
> Jani points out, the dependency is now stricter than it needs to be.
> 
> Change it again, to allow DRM_FBDEV_EMULATION to be used when
> DRM_KMS_HELPER and FB are both loadable modules and DRM is linked into
> the kernel.
> 
> As a side-effect, the option is now only visible when at least one DRM
> driver makes use of DRM_KMS_HELPER. This is better, because the option
> has no effect otherwise.
> 
> Fixes: 606b102876e3 ("drm: fb_helper: fix CONFIG_FB dependency")
> Suggested-by: Acked-by: Jani Nikula <jani.nikula@intel.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Queued up for the merge window, thanks for the patch.
-Daniel

> ---
>  drivers/gpu/drm/Kconfig | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index c08860db2520..d2e6d8ce5000 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -117,9 +117,8 @@ config DRM_DEBUG_MODESET_LOCK
>  
>  config DRM_FBDEV_EMULATION
>  	bool "Enable legacy fbdev support for your modesetting driver"
> -	depends on DRM
> -	depends on FB=y || FB=DRM
> -	select DRM_KMS_HELPER
> +	depends on DRM_KMS_HELPER
> +	depends on FB=y || FB=DRM_KMS_HELPER
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> -- 
> 2.29.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
