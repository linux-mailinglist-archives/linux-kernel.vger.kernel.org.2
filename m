Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605BD3AEB32
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 16:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFUO1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 10:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUO12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:27:28 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CF4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 07:25:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f2so19866077wri.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 07:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=N8KORs1w5sO5Pt8tvYP3PqKHK+tsp4Q8XjedmOUr0+I=;
        b=VHh+2mmwhGNltgxbiIC+DldZJb2u+ZHeIQQqrsWcN7mpfPYQ0GSjzxa8b7bf3x37Bz
         25EO6uOjhKyqOeC9APlx3BBggF6hPQKt60xGOpQISihSymf3JO5lS4b8NLYcsFMrnXIh
         +pZ9lkDoTUf9jhKJeWQsyBtTvzWptqRCh/OH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=N8KORs1w5sO5Pt8tvYP3PqKHK+tsp4Q8XjedmOUr0+I=;
        b=RkZfm6BWx1l8ZouNHI4cgiwMdVhqiiBLNUsMlD3sL0RhjeypWRXDIHfTOuL1ToZ8x9
         Erv3K9WalCKDV72gPW0Ip/26U4+ZM67v+hjb0mNotkquaeO96RteXzqhs9/DEgoSy0a7
         59DaYmbq+BWaTIJi6F7xFYMp8GpgSXvGRpBhtwAkzrNchACbehgak5rFcEYA8SNIQgOS
         QqGUTgou4QdyDmdHVd9E+TXuckXx86YQ3t3XFsXPeNtK6n4icGN+fWTX9vDEtJx8nWBY
         pRq93RcRoWAhFqHSL0e2/yiJKew+rWF52iS9mKfLHO0OOCI5haWC5yz348D9kZqLaU6P
         l/kw==
X-Gm-Message-State: AOAM531swMKZT97K1SDMUEHIdQtYTvwt2LJmw7iTpyQeGkedAqqj0I0B
        b+y0mtNMBOVVArJXYNvdEmfyvw==
X-Google-Smtp-Source: ABdhPJzWikMDb6HRHwnrjRscIwfDp8Y3d+qprOGR+QBWeCWpaL374TxTEE7RKVa8r9yVS4mSkemp/Q==
X-Received: by 2002:adf:f743:: with SMTP id z3mr19302639wrp.329.1624285512590;
        Mon, 21 Jun 2021 07:25:12 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z10sm16679734wmp.39.2021.06.21.07.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 07:25:12 -0700 (PDT)
Date:   Mon, 21 Jun 2021 16:25:10 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        emil.l.velikov@gmail.com, Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v3 1/2] drm: add a locked version of drm_is_current_master
Message-ID: <YNChRvGjIz6++jnd@phenom.ffwll.local>
Mail-Followup-To: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, sumit.semwal@linaro.org,
        christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        emil.l.velikov@gmail.com
References: <20210620110327.4964-1-desmondcheongzx@gmail.com>
 <20210620110327.4964-2-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210620110327.4964-2-desmondcheongzx@gmail.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 07:03:26PM +0800, Desmond Cheong Zhi Xi wrote:
> While checking the master status of the DRM file in
> drm_is_current_master(), the device's master mutex should be
> held. Without the mutex, the pointer fpriv->master may be freed
> concurrently by another process calling drm_setmaster_ioctl(). This
> could lead to use-after-free errors when the pointer is subsequently
> dereferenced in drm_lease_owner().
> 
> The callers of drm_is_current_master() from drm_auth.c hold the
> device's master mutex, but external callers do not. Hence, we implement
> drm_is_current_master_locked() to be used within drm_auth.c, and
> modify drm_is_current_master() to grab the device's master mutex
> before checking the master status.
> 
> Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

Merged to drm-misc-fixes, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/drm_auth.c | 51 ++++++++++++++++++++++++--------------
>  1 file changed, 32 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
> index 232abbba3686..86d4b72e95cb 100644
> --- a/drivers/gpu/drm/drm_auth.c
> +++ b/drivers/gpu/drm/drm_auth.c
> @@ -61,6 +61,35 @@
>   * trusted clients.
>   */
>  
> +static bool drm_is_current_master_locked(struct drm_file *fpriv)
> +{
> +	lockdep_assert_held_once(&fpriv->master->dev->master_mutex);
> +
> +	return fpriv->is_master && drm_lease_owner(fpriv->master) == fpriv->minor->dev->master;
> +}
> +
> +/**
> + * drm_is_current_master - checks whether @priv is the current master
> + * @fpriv: DRM file private
> + *
> + * Checks whether @fpriv is current master on its device. This decides whether a
> + * client is allowed to run DRM_MASTER IOCTLs.
> + *
> + * Most of the modern IOCTL which require DRM_MASTER are for kernel modesetting
> + * - the current master is assumed to own the non-shareable display hardware.
> + */
> +bool drm_is_current_master(struct drm_file *fpriv)
> +{
> +	bool ret;
> +
> +	mutex_lock(&fpriv->master->dev->master_mutex);
> +	ret = drm_is_current_master_locked(fpriv);
> +	mutex_unlock(&fpriv->master->dev->master_mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_is_current_master);
> +
>  int drm_getmagic(struct drm_device *dev, void *data, struct drm_file *file_priv)
>  {
>  	struct drm_auth *auth = data;
> @@ -223,7 +252,7 @@ int drm_setmaster_ioctl(struct drm_device *dev, void *data,
>  	if (ret)
>  		goto out_unlock;
>  
> -	if (drm_is_current_master(file_priv))
> +	if (drm_is_current_master_locked(file_priv))
>  		goto out_unlock;
>  
>  	if (dev->master) {
> @@ -272,7 +301,7 @@ int drm_dropmaster_ioctl(struct drm_device *dev, void *data,
>  	if (ret)
>  		goto out_unlock;
>  
> -	if (!drm_is_current_master(file_priv)) {
> +	if (!drm_is_current_master_locked(file_priv)) {
>  		ret = -EINVAL;
>  		goto out_unlock;
>  	}
> @@ -321,7 +350,7 @@ void drm_master_release(struct drm_file *file_priv)
>  	if (file_priv->magic)
>  		idr_remove(&file_priv->master->magic_map, file_priv->magic);
>  
> -	if (!drm_is_current_master(file_priv))
> +	if (!drm_is_current_master_locked(file_priv))
>  		goto out;
>  
>  	drm_legacy_lock_master_cleanup(dev, master);
> @@ -342,22 +371,6 @@ void drm_master_release(struct drm_file *file_priv)
>  	mutex_unlock(&dev->master_mutex);
>  }
>  
> -/**
> - * drm_is_current_master - checks whether @priv is the current master
> - * @fpriv: DRM file private
> - *
> - * Checks whether @fpriv is current master on its device. This decides whether a
> - * client is allowed to run DRM_MASTER IOCTLs.
> - *
> - * Most of the modern IOCTL which require DRM_MASTER are for kernel modesetting
> - * - the current master is assumed to own the non-shareable display hardware.
> - */
> -bool drm_is_current_master(struct drm_file *fpriv)
> -{
> -	return fpriv->is_master && drm_lease_owner(fpriv->master) == fpriv->minor->dev->master;
> -}
> -EXPORT_SYMBOL(drm_is_current_master);
> -
>  /**
>   * drm_master_get - reference a master pointer
>   * @master: &struct drm_master
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
