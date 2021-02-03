Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD95930D731
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 11:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhBCKQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 05:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbhBCKQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 05:16:27 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C4BC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 02:15:45 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id c4so20779112wru.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 02:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=a321zpi9EYFPKrHa/w5wiDf7FzXZmd2yWZ5PnRvh2oY=;
        b=RCZYqjo8I8AawXH9nn6NQo2bQR2kzFkM3XePpRANJJFh+lczMkaDb319tOYYIL1zXa
         yxn6aF18WkJpG3iAp/H1LKgx52iDyHPIS7MGdZknlRvHXfaNZJXshs8+A0/iv6kNsVrB
         JXrIIwgJ+TTIv7ID15/NbNfrIDf5JA+9CfuIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=a321zpi9EYFPKrHa/w5wiDf7FzXZmd2yWZ5PnRvh2oY=;
        b=qahUuyVsci0h3w3NH85BzpjEe7D/tEHe8oEf2Qz83Zv7cUOFhfOsyn1xxX7n124JfW
         UcJ/yGPOZHs8E9gZfNn4W3wAs9N8miX5GPSEirO3X1iZYC7lK0wnccIWACBVeuvy/6oI
         gNFB3rqO1fhnZEAI9Ckj6oeZJHYHJsMT/UCGH9Rk60sIoWoHKpUkydJ1NtaX7KLqk4qY
         JD9IjKXF6cY5a3FZJassv/PkuCCL1O0qugPFIuAhJ2iOKHlEzsdKGUTgLOV7MIO1G53l
         tD3NsEF5/pPVcXSt0Bdnu3yf6ICariYUZ9He2sdrM+IfeozD93AmgV6Kcn6tKjvT/DzF
         sgpg==
X-Gm-Message-State: AOAM532ioeYONopO9t3PHPQrS5BN6KTgFLGK+X04QBXA7gwUoG0I8w4N
        HMpSnZakzit3nG5uSpFdmkPIOw==
X-Google-Smtp-Source: ABdhPJzHB+ffvr9s3UM8FPaGZKcUXhORlDn7t4V0qu+UbQAlINgveENCa31EtHjKs1ycCeGI9sFg6g==
X-Received: by 2002:adf:f743:: with SMTP id z3mr2655431wrp.165.1612347344092;
        Wed, 03 Feb 2021 02:15:44 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f4sm2825617wrs.34.2021.02.03.02.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 02:15:43 -0800 (PST)
Date:   Wed, 3 Feb 2021 11:15:41 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] drm/qxl: properly free qxl releases
Message-ID: <YBp3zQqomQziZbPT@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210126165812.1661512-1-kraxel@redhat.com>
 <20210126165812.1661512-6-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126165812.1661512-6-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 05:58:12PM +0100, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_drv.h     |  1 +
>  drivers/gpu/drm/qxl/qxl_kms.c     | 22 ++++++++++++++++++++--
>  drivers/gpu/drm/qxl/qxl_release.c |  2 ++
>  3 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
> index 01354b43c413..1c57b587b6a7 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.h
> +++ b/drivers/gpu/drm/qxl/qxl_drv.h
> @@ -214,6 +214,7 @@ struct qxl_device {
>  	spinlock_t	release_lock;
>  	struct idr	release_idr;
>  	uint32_t	release_seqno;
> +	atomic_t	release_count;
>  	spinlock_t release_idr_lock;
>  	struct mutex	async_io_mutex;
>  	unsigned int last_sent_io_cmd;
> diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
> index 4a60a52ab62e..f177f72bfc12 100644
> --- a/drivers/gpu/drm/qxl/qxl_kms.c
> +++ b/drivers/gpu/drm/qxl/qxl_kms.c
> @@ -25,6 +25,7 @@
>  
>  #include <linux/io-mapping.h>
>  #include <linux/pci.h>
> +#include <linux/delay.h>
>  
>  #include <drm/drm_drv.h>
>  #include <drm/drm_managed.h>
> @@ -286,8 +287,25 @@ int qxl_device_init(struct qxl_device *qdev,
>  
>  void qxl_device_fini(struct qxl_device *qdev)
>  {
> -	qxl_bo_unref(&qdev->current_release_bo[0]);
> -	qxl_bo_unref(&qdev->current_release_bo[1]);
> +	int cur_idx, try;
> +
> +	for (cur_idx = 0; cur_idx < 3; cur_idx++) {
> +		if (!qdev->current_release_bo[cur_idx])
> +			continue;
> +		qxl_bo_unpin(qdev->current_release_bo[cur_idx]);
> +		qxl_bo_unref(&qdev->current_release_bo[cur_idx]);
> +		qdev->current_release_bo_offset[cur_idx] = 0;
> +		qdev->current_release_bo[cur_idx] = NULL;
> +	}
> +
> +	/*
> +	 * Ask host to release resources (+fill release ring),
> +	 * then wait for the release actually happening.
> +	 */
> +	qxl_io_notify_oom(qdev);
> +	for (try = 0; try < 20 && atomic_read(&qdev->release_count) > 0; try++)
> +		msleep(20);

A bit icky, why not use a wait queue or something like that instead of
hand-rolling this? Not for perf reasons, just so it's a bit clear who
waits for whom and why.
-Daniel

> +
>  	qxl_gem_fini(qdev);
>  	qxl_bo_fini(qdev);
>  	flush_work(&qdev->gc_work);
> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
> index 28013fd1f8ea..43a5436853b7 100644
> --- a/drivers/gpu/drm/qxl/qxl_release.c
> +++ b/drivers/gpu/drm/qxl/qxl_release.c
> @@ -196,6 +196,7 @@ qxl_release_free(struct qxl_device *qdev,
>  		qxl_release_free_list(release);
>  		kfree(release);
>  	}
> +	atomic_dec(&qdev->release_count);
>  }
>  
>  static int qxl_release_bo_alloc(struct qxl_device *qdev,
> @@ -344,6 +345,7 @@ int qxl_alloc_release_reserved(struct qxl_device *qdev, unsigned long size,
>  			*rbo = NULL;
>  		return idr_ret;
>  	}
> +	atomic_inc(&qdev->release_count);
>  
>  	mutex_lock(&qdev->release_mutex);
>  	if (qdev->current_release_bo_offset[cur_idx] + 1 >= releases_per_bo[cur_idx]) {
> -- 
> 2.29.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
