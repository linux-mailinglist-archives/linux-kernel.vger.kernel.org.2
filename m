Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBBC3D7588
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbhG0NFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbhG0NE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:04:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD9FC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 06:04:59 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l18so7462762wrv.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 06:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=J1D0YAy3KCN+DKC/n4HOYEFT5Ge7h0z0gSwGvWYMl4Y=;
        b=Gpy+Hle+WikTFeHozpdX83+mwuZ9VA1xIiAAGAGdvbRKB/U6TM6Y4fRyBZJR2xygR9
         4BCkIwyAOUWMRT2hR6qqbO6ITrwLC3szr82s6QMopW90w1G3Fdn3WxuAXAxyxlsXYnJJ
         D1faNragfwDXhVIeDyJ4tkuXb8LJIitJTEeSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=J1D0YAy3KCN+DKC/n4HOYEFT5Ge7h0z0gSwGvWYMl4Y=;
        b=pk6uCugOqHLyed2x1yjSB9eOkOetcj9HcCqnXDIMZU0VYvvD91y9MwDtsaBidGujrW
         IBJ9V0nvn1LHD/Nd7sAIb+S13p3PwZC3npWQZ1cO/PMVgWN1Ts8egB+CCOrJd1QRNl0g
         2T4lYF06EfK+UD67jkQ11GBOOcgHZafkbmYz0/J56nIWm8YYyUgYp5prDg7biTA8bp+0
         QNmv9/V9BQuI9iGJoNO2CUgF5zWjCKwxsRDhnmvK3eYg+IeVwyiToPh9P3DBLETGhmjB
         OFjzJLjedVq7T84KG/31loX1sPzDRo2uP4fi044xtwf+AtIhrCk2/Rn/UO5fKz4+ccRR
         6GDg==
X-Gm-Message-State: AOAM5304TU8yOGR3KyKVYTS8Dp3xwC0IBe9s0aeXNX5jHwGrd0V8au0A
        uUFztiIsGu6nuvOo/LA4JUxCJfh8YuoJRg==
X-Google-Smtp-Source: ABdhPJx8I7ocA2Cs3lnYDgNJH1wvGpMqM8Q/kfBbmW5XCiVmevz8H48nOi3WV7bD9VWVm88ofkhlIg==
X-Received: by 2002:a5d:6991:: with SMTP id g17mr13765368wru.253.1627391098337;
        Tue, 27 Jul 2021 06:04:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p5sm2882911wme.2.2021.07.27.06.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:04:57 -0700 (PDT)
Date:   Tue, 27 Jul 2021 15:04:55 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     linux-graphics-maintainer@vmware.com, zackr@vmware.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, corbet@lwn.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        intel-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v2 1/3] drm: use the lookup lock in drm_is_current_master
Message-ID: <YQAEd5UqPfOiYrih@phenom.ffwll.local>
Mail-Followup-To: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-graphics-maintainer@vmware.com, zackr@vmware.com,
        airlied@linux.ie, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        intel-gfx@lists.freedesktop.org
References: <20210724111824.59266-1-desmondcheongzx@gmail.com>
 <20210724111824.59266-2-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724111824.59266-2-desmondcheongzx@gmail.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 07:18:22PM +0800, Desmond Cheong Zhi Xi wrote:
> Inside drm_is_current_master, using the outer drm_device.master_mutex
> to protect reads of drm_file.master makes the function prone to creating
> lock hierarchy inversions. Instead, we can use the
> drm_file.master_lookup_lock that sits at the bottom of the lock
> hierarchy.
> 
> Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Applied to drm-misc-next, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/drm_auth.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
> index f00354bec3fb..9c24b8cc8e36 100644
> --- a/drivers/gpu/drm/drm_auth.c
> +++ b/drivers/gpu/drm/drm_auth.c
> @@ -63,8 +63,9 @@
>  
>  static bool drm_is_current_master_locked(struct drm_file *fpriv)
>  {
> -	lockdep_assert_held_once(&fpriv->minor->dev->master_mutex);
> -
> +	/* Either drm_device.master_mutex or drm_file.master_lookup_lock
> +	 * should be held here.
> +	 */
>  	return fpriv->is_master && drm_lease_owner(fpriv->master) == fpriv->minor->dev->master;
>  }
>  
> @@ -82,9 +83,9 @@ bool drm_is_current_master(struct drm_file *fpriv)
>  {
>  	bool ret;
>  
> -	mutex_lock(&fpriv->minor->dev->master_mutex);
> +	spin_lock(&fpriv->master_lookup_lock);
>  	ret = drm_is_current_master_locked(fpriv);
> -	mutex_unlock(&fpriv->minor->dev->master_mutex);
> +	spin_unlock(&fpriv->master_lookup_lock);
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
