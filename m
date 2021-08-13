Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FED3EB985
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 17:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241291AbhHMPvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 11:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241078AbhHMPvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 11:51:39 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2558C0617AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 08:51:12 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k29so13897474wrd.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 08:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=chmAAuuu9/imXcL05QrcQEYuvIcsA2PuEr2bsNmWeMk=;
        b=YXNQ1jJxmMfb4W6F0Ii5J6L9JrznTqUjOcuFAqOOrX6uBrOVpgkK22QocovoZ8l10V
         qau/1XGthmja7EiXttRCYcn6dncQJxnTAlO0kX6joAsSq5pqJchTi7vuTc8ezgGzlkG9
         1rPG2lPmD4puppEecPzIS3+snUwBW4xNT4PhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=chmAAuuu9/imXcL05QrcQEYuvIcsA2PuEr2bsNmWeMk=;
        b=iTbJfJm4Rr49VFJUhBmzrK968tRBd91XuXg10KjnHQ4eEckPp1C2m4x9n0BPRLaL3d
         8hD1Nb2SgUTkzEOFpBX2elNHapb2hLe3O3IX6iRdjIBT33i+pWUshgfnLpBGt9vRk8Qx
         90VKzLlAZ834z+qzJyJCYf22QntQxJGcf3SVZ79/KsJo735+0buS9wgR05m2PQjraLBQ
         /AxzlTI6DOM57W3p1UGg5aK6yfd1peUbw2K4n0wZYG9xxBnfieApmWpp+3VTFcHmS6Uh
         DqZp+8Wc3+GG/Sx0e9m/Zr6Y0GBNSjfCNbQ1dQAY2R9CWcLebXwMNfbdLUMl7csw/rqV
         Omqg==
X-Gm-Message-State: AOAM533ixY9EbpmpC7UzARUUuymjRVfWCWumO+zxj6i71DuKjjfwnav4
        ZR83FxVNsAd1njYD9BVawj2nug==
X-Google-Smtp-Source: ABdhPJxmL/0BdkkgG1cfg0Kb8lawu3ocVEXGdInJyWEC5vjU11a4bxLVspErgkAcGWROUTwh6G7ozg==
X-Received: by 2002:a5d:66d1:: with SMTP id k17mr3944388wrw.102.1628869871300;
        Fri, 13 Aug 2021 08:51:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z13sm1942615wrs.71.2021.08.13.08.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 08:51:10 -0700 (PDT)
Date:   Fri, 13 Aug 2021 17:51:08 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        intel-gfx@lists.freedesktop.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 2/2] drm: unexport drm_ioctl_permit
Message-ID: <YRaU7EB5shTUMZZ7@phenom.ffwll.local>
Mail-Followup-To: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, sumit.semwal@linaro.org,
        christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, intel-gfx@lists.freedesktop.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210813085450.32494-1-desmondcheongzx@gmail.com>
 <20210813085450.32494-3-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813085450.32494-3-desmondcheongzx@gmail.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 04:54:50PM +0800, Desmond Cheong Zhi Xi wrote:
> Since the last user of drm_ioctl_permit was removed, and it's now only
> used in drm_ioctl.c, unexport the symbol.
> 
> Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>

Applied to drm-misc-next for 5.16, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/drm_ioctl.c | 15 +--------------
>  include/drm/drm_ioctl.h     |  1 -
>  2 files changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index eb4ec3fab7d1..fe271f6f96ab 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -522,19 +522,7 @@ int drm_version(struct drm_device *dev, void *data,
>  	return err;
>  }
>  
> -/**
> - * drm_ioctl_permit - Check ioctl permissions against caller
> - *
> - * @flags: ioctl permission flags.
> - * @file_priv: Pointer to struct drm_file identifying the caller.
> - *
> - * Checks whether the caller is allowed to run an ioctl with the
> - * indicated permissions.
> - *
> - * Returns:
> - * Zero if allowed, -EACCES otherwise.
> - */
> -int drm_ioctl_permit(u32 flags, struct drm_file *file_priv)
> +static int drm_ioctl_permit(u32 flags, struct drm_file *file_priv)
>  {
>  	/* ROOT_ONLY is only for CAP_SYS_ADMIN */
>  	if (unlikely((flags & DRM_ROOT_ONLY) && !capable(CAP_SYS_ADMIN)))
> @@ -557,7 +545,6 @@ int drm_ioctl_permit(u32 flags, struct drm_file *file_priv)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(drm_ioctl_permit);
>  
>  #define DRM_IOCTL_DEF(ioctl, _func, _flags)	\
>  	[DRM_IOCTL_NR(ioctl)] = {		\
> diff --git a/include/drm/drm_ioctl.h b/include/drm/drm_ioctl.h
> index 13a68cdcea36..fd29842127e5 100644
> --- a/include/drm/drm_ioctl.h
> +++ b/include/drm/drm_ioctl.h
> @@ -174,7 +174,6 @@ struct drm_ioctl_desc {
>  		.name = #ioctl						\
>  	}
>  
> -int drm_ioctl_permit(u32 flags, struct drm_file *file_priv);
>  long drm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
>  long drm_ioctl_kernel(struct file *, drm_ioctl_t, void *, u32);
>  #ifdef CONFIG_COMPAT
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
