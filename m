Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35086399D10
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhFCIvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:51:23 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:39534 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhFCIvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:51:21 -0400
Received: by mail-ed1-f50.google.com with SMTP id dj8so6189921edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 01:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=vPAp0cDqkozZvEWRxxBHH5RxVtokOPhreu0KnKBlDT8=;
        b=Dfc5iwcBu7xHR6cCUm7AXpRC3Am+2tgSjO2cK3b+y81daO+VUcDnqv5aiqhlX2f8ET
         6onChdoAnMmIk5UTlu73QIpDDtNnf1X2MUG0IL1DmsIJFdqoA6heSynaLiB8Ryp9ysYy
         aHhDS1NSxmydVwhy0JCxhpd7kO6T0dhC7iCfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=vPAp0cDqkozZvEWRxxBHH5RxVtokOPhreu0KnKBlDT8=;
        b=btVQnFfsZJdQNQ+TTr3CEn972/SxRFl50ZbzsqNVpBdW62tUy5EukcGNFFYq2NRMIq
         dFmrmlD8lQ1bA/W1Oo6lulwzGbmGrIbtqTyxb7eyVCEeZncgkKkuU749CSnBDxzT2LtW
         0n55a7/IdsE1sK5p3+M7wcxvCZXYliPtJ7NRExoqHFdmxR93nEXVIAWtYDcR6AXQOU6i
         IQZ+04qv9+jmt3CZmUbOQkm/lyagDYz1LN4YK5KBrNWNlOjqNoTnU6ZyQlYJnHm82Cs9
         6GXG1dk8oTYnWZlq08nAelIeaFnFEviZzVxU6a1d9ScPGxRFJznctMaDIrlp53AXxBC7
         egUw==
X-Gm-Message-State: AOAM531PimdzfK5A5+0eO0pyVH79uXrVjmMOJRVFNDi3VuhDGJcUmCud
        ivMErKkz7x9tlMkUSbZCIqOxEA==
X-Google-Smtp-Source: ABdhPJwv4djZniG7P4/1rgxf9Fevn796Yj3QoQ3lNQh0vjHJ+sYM0uCv+TLIpzDfNoN6sGHi5HwO+Q==
X-Received: by 2002:aa7:dd57:: with SMTP id o23mr42071917edw.98.1622710116626;
        Thu, 03 Jun 2021 01:48:36 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z17sm1232609ejc.69.2021.06.03.01.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 01:48:36 -0700 (PDT)
Date:   Thu, 3 Jun 2021 10:48:33 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kees Cook <keescook@chromium.org>
Cc:     Dave Airlie <airlied@redhat.com>, Arnd Bergmann <arnd@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        kernel test robot <lkp@intel.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Emma Anholt <emma@anholt.net>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH 1/3] drm: Avoid circular dependencies for CONFIG_FB
Message-ID: <YLiXYa8OG9hlaEE5@phenom.ffwll.local>
Mail-Followup-To: Kees Cook <keescook@chromium.org>,
        Dave Airlie <airlied@redhat.com>, Arnd Bergmann <arnd@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, kernel test robot <lkp@intel.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Emma Anholt <emma@anholt.net>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org
References: <20210602215252.695994-1-keescook@chromium.org>
 <20210602215252.695994-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602215252.695994-2-keescook@chromium.org>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 02:52:50PM -0700, Kees Cook wrote:
> When cleaning up other drm config dependencies, it is too easy to create
> larger problems. Instead, mark CONFIG_FB as a "depends":
> 
> drivers/gpu/drm/Kconfig:74:error: recursive dependency detected!
> 
> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Link: https://lore.kernel.org/lkml/CAK8P3a3jUQs6c5tESSNMbqfuymewj9FhqRizyHcfOXf8Rgy-nA@mail.gmail.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>

I rebased this one for -next and applied all three patches to
drm-misc-next.
-Daniel

> ---
>  drivers/gpu/drm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 3c16bd1afd87..90891284ccec 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -83,7 +83,7 @@ config DRM_KMS_HELPER
>  config DRM_KMS_FB_HELPER
>  	bool
>  	depends on DRM_KMS_HELPER
> -	select FB
> +	depends on FB
>  	select FRAMEBUFFER_CONSOLE if !EXPERT
>  	select FRAMEBUFFER_CONSOLE_DETECT_PRIMARY if FRAMEBUFFER_CONSOLE
>  	select FB_SYS_FOPS
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
