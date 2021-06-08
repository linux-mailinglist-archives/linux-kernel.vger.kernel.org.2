Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A1639FC46
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhFHQXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:23:13 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33535 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFHQXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:23:12 -0400
Received: by mail-wr1-f54.google.com with SMTP id a20so22286895wrc.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 09:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=WHP+bfUpSSgGU+40YQorcw79is7T2xXrk6IDd2U02us=;
        b=c/v0NunbtdBf4Xod9Iby2PJdbikNXHp0gGbmCubNDw59u9q+q37XhdKtWUVUnFxG0D
         /mvqUjSLG6Drp3g+Jz0p8IOhe11FJ7AOkte64ETRH1iBseT1w05UpzQqgb4yyTNW+kfl
         nnFJDfxFmxYnq6Z6MOackwV895C/U/b1UD0B8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=WHP+bfUpSSgGU+40YQorcw79is7T2xXrk6IDd2U02us=;
        b=TiwWAqTid1gnwPbUecZFy8M5OU2KDwSjXD4o3HTTU7um7xH5Qr3oD/BLKpi7mxlc9i
         vbu3G6mEE38b4qkzm8yuUU95UuwHVNLhNcPNe9wJkPlbKzigtQcAf+PghahbDfMUuayT
         SZs9fFh9ybPpUsTorjpQ8HTL9oWc2FwhapruhfILqBa4zyuKP71ySIroAKV10B0yQ8yG
         qBRxRo6sV50e3j0nEgDLJ0iJ7bWNH6e1CcTXRJLXlVx1FqYDxGkUThSTY9JremcAeVVQ
         /NlE3tvHxcago1L+Cag8eI9tim+fM7eeR+u3rxxYt1++qp/2XXYkufPzNfTimjuAJzx/
         9f4w==
X-Gm-Message-State: AOAM533tWyRMQh7f4fxmnFdPot17sU9HlS7p+L5P2K966iAyzAyICdtS
        YuC7FX9RV4XS2LxCVyXs2x0Cb8ir/thPbA==
X-Google-Smtp-Source: ABdhPJz+2SyUcy0W2KB1qYd96JVRrSCiw9s0a2u5+A255K0jX40r7indtLoxfqUrXGXSkFD91UfgkA==
X-Received: by 2002:a5d:6b0b:: with SMTP id v11mr22883654wrw.339.1623169202970;
        Tue, 08 Jun 2021 09:20:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m37sm11891194wms.46.2021.06.08.09.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 09:20:02 -0700 (PDT)
Date:   Tue, 8 Jun 2021 18:20:00 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+c3a706cec1ea99e1c693@syzkaller.appspotmail.com
Subject: Re: [PATCH] drm: Fix use-after-free read in drm_getunique()
Message-ID: <YL+YsFUKtK5LbGex@phenom.ffwll.local>
Mail-Followup-To: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+c3a706cec1ea99e1c693@syzkaller.appspotmail.com
References: <20210608110436.239583-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608110436.239583-1-desmondcheongzx@gmail.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 07:04:36PM +0800, Desmond Cheong Zhi Xi wrote:
> There is a time-of-check-to-time-of-use error in drm_getunique() due
> to retrieving file_priv->master prior to locking the device's master
> mutex.
> 
> An example can be seen in the crash report of the use-after-free error
> found by Syzbot:
> https://syzkaller.appspot.com/bug?id=148d2f1dfac64af52ffd27b661981a540724f803
> 
> In the report, the master pointer was used after being freed. This is
> because another process had acquired the device's master mutex in
> drm_setmaster_ioctl(), then overwrote fpriv->master in
> drm_new_set_master(). The old value of fpriv->master was subsequently
> freed before the mutex was unlocked.
> 
> To fix this, we lock the device's master mutex before retrieving the
> pointer from from fpriv->master. This patch passes the Syzbot
> reproducer test.
> 
> Reported-by: syzbot+c3a706cec1ea99e1c693@syzkaller.appspotmail.com
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>

Very nice debug work, thanks a lot!

> ---
> 
> In this patch, I made the assumption that dev and file_priv->master->dev
> refer to the same struct drm_device*, and from my test runs this seemed
> to be the case. If this was a wrong assumption to make, please let me
> know.

Yup that's correct.

Patch applied to drm-misc-fixes and cc: stable added so it gets
backported.

Cheers, Daniel

> 
>  drivers/gpu/drm/drm_ioctl.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index d273d1a8603a..495a4767a443 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -118,17 +118,18 @@ int drm_getunique(struct drm_device *dev, void *data,
>  		  struct drm_file *file_priv)
>  {
>  	struct drm_unique *u = data;
> -	struct drm_master *master = file_priv->master;
> +	struct drm_master *master;
>  
> -	mutex_lock(&master->dev->master_mutex);
> +	mutex_lock(&dev->master_mutex);
> +	master = file_priv->master;
>  	if (u->unique_len >= master->unique_len) {
>  		if (copy_to_user(u->unique, master->unique, master->unique_len)) {
> -			mutex_unlock(&master->dev->master_mutex);
> +			mutex_unlock(&dev->master_mutex);
>  			return -EFAULT;
>  		}
>  	}
>  	u->unique_len = master->unique_len;
> -	mutex_unlock(&master->dev->master_mutex);
> +	mutex_unlock(&dev->master_mutex);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
