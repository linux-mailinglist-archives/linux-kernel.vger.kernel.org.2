Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCB13ABA51
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 19:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhFQRO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 13:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFQRO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 13:14:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E128C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 10:12:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n7so7631321wri.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 10:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=DSxV25jNuC8bMklajaQy85foJZxKyLDGx7XcG+qcPGE=;
        b=bTaG5jb4m8r/EsPv2Vlun/axFb4g20DC1YTproNDbKwn2ZSobnWF+up5RVOHZiBNcX
         7xwnDJWhZ4vgdhamJI77mkMZabqP7Q+CHIytdDqjb3LwQkfXuJwknbKg8YZGbRoxqTB0
         /TmH9hFDrDDG0fI/Fyr+Zav/mzP5h7XyS7VdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=DSxV25jNuC8bMklajaQy85foJZxKyLDGx7XcG+qcPGE=;
        b=QjD4rwcSM64ZwnGkXC8ga8eyOc325HCuF/X8XeCvldVqP2pkFt+WwxzzLVFUVa4wXI
         TkQ9O92S4nwJadBk3EvKRqZu9dgEyYav4zQbuzKvsTC4SfBtknfUALoZa0pb4vdyVeAF
         np3OMMuFDbCquKqQrA6K6X+PSwbqoMqInmgIyMwHipwrw+Mh7+wmGP+lBUGTsQH3dKvi
         MKnfArcFw566I2lvS6Aqqsfr5piQIGbZhHZ+rL7T3LCWsxlGi+4WCNux+EvBHyxlcwdG
         UgAdNh+NDy/yrolDJiX/kPTvFKjuexK6JyNV/UZ4KTGUnpQycKiyp4DF9XYXOBTwyXzE
         xP0A==
X-Gm-Message-State: AOAM533+xUSK1m5Z15pgbl8lxfOvwfjwufv2u1sByjU4uCO9OFL25vzM
        OgJmKt2H5P6BLpHacCeqtzfSjQ==
X-Google-Smtp-Source: ABdhPJwv3vZFJ5wt80/sGXceS5DGQsW7p2ArAoUoDzhMRB3/NCMWWMNMYFLe1Dhrl2pG0DjuGboevw==
X-Received: by 2002:a05:6000:1864:: with SMTP id d4mr6942028wri.369.1623949938842;
        Thu, 17 Jun 2021 10:12:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h15sm5713745wrq.88.2021.06.17.10.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 10:12:18 -0700 (PDT)
Date:   Thu, 17 Jun 2021 19:12:02 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        emil.l.velikov@gmail.com, Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v2 2/2] drm: Protect drm_master pointers in drm_lease.c
Message-ID: <YMuCYqLafn5sGcFo@phenom.ffwll.local>
Mail-Followup-To: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        emil.l.velikov@gmail.com
References: <20210615023645.6535-1-desmondcheongzx@gmail.com>
 <20210615023645.6535-3-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615023645.6535-3-desmondcheongzx@gmail.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 10:36:45AM +0800, Desmond Cheong Zhi Xi wrote:
> This patch ensures that the device's master mutex is acquired before
> accessing pointers to struct drm_master that are subsequently
> dereferenced. Without the mutex, the struct drm_master may be freed
> concurrently by another process calling drm_setmaster_ioctl(). This
> could then lead to use-after-free errors.
> 
> Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> ---
>  drivers/gpu/drm/drm_lease.c | 58 +++++++++++++++++++++++++++----------
>  1 file changed, 43 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
> index da4f085fc09e..3e6f689236e5 100644
> --- a/drivers/gpu/drm/drm_lease.c
> +++ b/drivers/gpu/drm/drm_lease.c
> @@ -107,10 +107,16 @@ static bool _drm_has_leased(struct drm_master *master, int id)
>   */
>  bool _drm_lease_held(struct drm_file *file_priv, int id)
>  {
> +	bool ret;
> +
>  	if (!file_priv || !file_priv->master)
>  		return true;
>  
> -	return _drm_lease_held_master(file_priv->master, id);
> +	mutex_lock(&file_priv->master->dev->master_mutex);

So maybe we have a bug somewhere, and the kerneldoc isn't 100% clear, but
I thought file_priv->master is invariant over the lifetime of file_priv.
So we don't need a lock to check anything here.

It's the drm_device->master derefence that gets us into trouble. Well also
file_priv->is_owner is protected by dev->master_mutex.

So I think with your previous patch all the access here in drm_lease.c is
ok and already protected? Or am I missing something?

Thanks, Daniel


> +	ret = _drm_lease_held_master(file_priv->master, id);
> +	mutex_unlock(&file_priv->master->dev->master_mutex);
> +
> +	return ret;
>  }
>  
>  /**
> @@ -132,10 +138,12 @@ bool drm_lease_held(struct drm_file *file_priv, int id)
>  	if (!file_priv || !file_priv->master || !file_priv->master->lessor)
>  		return true;
>  
> +	mutex_lock(&file_priv->master->dev->master_mutex);
>  	master = file_priv->master;
>  	mutex_lock(&master->dev->mode_config.idr_mutex);
>  	ret = _drm_lease_held_master(master, id);
>  	mutex_unlock(&master->dev->mode_config.idr_mutex);
> +	mutex_unlock(&file_priv->master->dev->master_mutex);
>  	return ret;
>  }
>  
> @@ -158,6 +166,7 @@ uint32_t drm_lease_filter_crtcs(struct drm_file *file_priv, uint32_t crtcs_in)
>  	if (!file_priv || !file_priv->master || !file_priv->master->lessor)
>  		return crtcs_in;
>  
> +	mutex_lock(&file_priv->master->dev->master_mutex);
>  	master = file_priv->master;
>  	dev = master->dev;
>  
> @@ -177,6 +186,7 @@ uint32_t drm_lease_filter_crtcs(struct drm_file *file_priv, uint32_t crtcs_in)
>  		count_in++;
>  	}
>  	mutex_unlock(&master->dev->mode_config.idr_mutex);
> +	mutex_unlock(&file_priv->master->dev->master_mutex);
>  	return crtcs_out;
>  }
>  
> @@ -490,7 +500,7 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
>  	size_t object_count;
>  	int ret = 0;
>  	struct idr leases;
> -	struct drm_master *lessor = lessor_priv->master;
> +	struct drm_master *lessor;
>  	struct drm_master *lessee = NULL;
>  	struct file *lessee_file = NULL;
>  	struct file *lessor_file = lessor_priv->filp;
> @@ -502,12 +512,6 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
>  	if (!drm_core_check_feature(dev, DRIVER_MODESET))
>  		return -EOPNOTSUPP;
>  
> -	/* Do not allow sub-leases */
> -	if (lessor->lessor) {
> -		DRM_DEBUG_LEASE("recursive leasing not allowed\n");
> -		return -EINVAL;
> -	}
> -
>  	/* need some objects */
>  	if (cl->object_count == 0) {
>  		DRM_DEBUG_LEASE("no objects in lease\n");
> @@ -519,12 +523,23 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
>  		return -EINVAL;
>  	}
>  
> +	mutex_lock(&dev->master_mutex);
> +	lessor = lessor_priv->master;
> +	/* Do not allow sub-leases */
> +	if (lessor->lessor) {
> +		DRM_DEBUG_LEASE("recursive leasing not allowed\n");
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
>  	object_count = cl->object_count;
>  
>  	object_ids = memdup_user(u64_to_user_ptr(cl->object_ids),
>  			array_size(object_count, sizeof(__u32)));
> -	if (IS_ERR(object_ids))
> -		return PTR_ERR(object_ids);
> +	if (IS_ERR(object_ids)) {
> +		ret = PTR_ERR(object_ids);
> +		goto unlock;
> +	}
>  
>  	idr_init(&leases);
>  
> @@ -535,14 +550,15 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
>  	if (ret) {
>  		DRM_DEBUG_LEASE("lease object lookup failed: %i\n", ret);
>  		idr_destroy(&leases);
> -		return ret;
> +		goto unlock;
>  	}
>  
>  	/* Allocate a file descriptor for the lease */
>  	fd = get_unused_fd_flags(cl->flags & (O_CLOEXEC | O_NONBLOCK));
>  	if (fd < 0) {
>  		idr_destroy(&leases);
> -		return fd;
> +		ret = fd;
> +		goto unlock;
>  	}
>  
>  	DRM_DEBUG_LEASE("Creating lease\n");
> @@ -578,6 +594,7 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
>  	/* Hook up the fd */
>  	fd_install(fd, lessee_file);
>  
> +	mutex_unlock(&dev->master_mutex);
>  	DRM_DEBUG_LEASE("drm_mode_create_lease_ioctl succeeded\n");
>  	return 0;
>  
> @@ -587,6 +604,8 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
>  out_leases:
>  	put_unused_fd(fd);
>  
> +unlock:
> +	mutex_unlock(&dev->master_mutex);
>  	DRM_DEBUG_LEASE("drm_mode_create_lease_ioctl failed: %d\n", ret);
>  	return ret;
>  }
> @@ -609,7 +628,7 @@ int drm_mode_list_lessees_ioctl(struct drm_device *dev,
>  	struct drm_mode_list_lessees *arg = data;
>  	__u32 __user *lessee_ids = (__u32 __user *) (uintptr_t) (arg->lessees_ptr);
>  	__u32 count_lessees = arg->count_lessees;
> -	struct drm_master *lessor = lessor_priv->master, *lessee;
> +	struct drm_master *lessor, *lessee;
>  	int count;
>  	int ret = 0;
>  
> @@ -620,6 +639,8 @@ int drm_mode_list_lessees_ioctl(struct drm_device *dev,
>  	if (!drm_core_check_feature(dev, DRIVER_MODESET))
>  		return -EOPNOTSUPP;
>  
> +	mutex_lock(&dev->master_mutex);
> +	lessor = lessor_priv->master;
>  	DRM_DEBUG_LEASE("List lessees for %d\n", lessor->lessee_id);
>  
>  	mutex_lock(&dev->mode_config.idr_mutex);
> @@ -643,6 +664,7 @@ int drm_mode_list_lessees_ioctl(struct drm_device *dev,
>  		arg->count_lessees = count;
>  
>  	mutex_unlock(&dev->mode_config.idr_mutex);
> +	mutex_unlock(&dev->master_mutex);
>  
>  	return ret;
>  }
> @@ -662,7 +684,7 @@ int drm_mode_get_lease_ioctl(struct drm_device *dev,
>  	struct drm_mode_get_lease *arg = data;
>  	__u32 __user *object_ids = (__u32 __user *) (uintptr_t) (arg->objects_ptr);
>  	__u32 count_objects = arg->count_objects;
> -	struct drm_master *lessee = lessee_priv->master;
> +	struct drm_master *lessee;
>  	struct idr *object_idr;
>  	int count;
>  	void *entry;
> @@ -676,6 +698,8 @@ int drm_mode_get_lease_ioctl(struct drm_device *dev,
>  	if (!drm_core_check_feature(dev, DRIVER_MODESET))
>  		return -EOPNOTSUPP;
>  
> +	mutex_lock(&dev->master_mutex);
> +	lessee = lessee_priv->master;
>  	DRM_DEBUG_LEASE("get lease for %d\n", lessee->lessee_id);
>  
>  	mutex_lock(&dev->mode_config.idr_mutex);
> @@ -703,6 +727,7 @@ int drm_mode_get_lease_ioctl(struct drm_device *dev,
>  		arg->count_objects = count;
>  
>  	mutex_unlock(&dev->mode_config.idr_mutex);
> +	mutex_unlock(&dev->master_mutex);
>  
>  	return ret;
>  }
> @@ -721,7 +746,7 @@ int drm_mode_revoke_lease_ioctl(struct drm_device *dev,
>  				void *data, struct drm_file *lessor_priv)
>  {
>  	struct drm_mode_revoke_lease *arg = data;
> -	struct drm_master *lessor = lessor_priv->master;
> +	struct drm_master *lessor;
>  	struct drm_master *lessee;
>  	int ret = 0;
>  
> @@ -731,8 +756,10 @@ int drm_mode_revoke_lease_ioctl(struct drm_device *dev,
>  	if (!drm_core_check_feature(dev, DRIVER_MODESET))
>  		return -EOPNOTSUPP;
>  
> +	mutex_lock(&dev->master_mutex);
>  	mutex_lock(&dev->mode_config.idr_mutex);
>  
> +	lessor = lessor_priv->master;
>  	lessee = _drm_find_lessee(lessor, arg->lessee_id);
>  
>  	/* No such lessee */
> @@ -751,6 +778,7 @@ int drm_mode_revoke_lease_ioctl(struct drm_device *dev,
>  
>  fail:
>  	mutex_unlock(&dev->mode_config.idr_mutex);
> +	mutex_unlock(&dev->master_mutex);
>  
>  	return ret;
>  }
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
