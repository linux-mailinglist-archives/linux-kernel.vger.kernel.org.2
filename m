Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645973ABC7A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhFQTUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhFQTUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:20:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C91C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:17:51 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l9so4133287wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=cyKaQCeyHLS4EathuQVksg4S7Jponx+EApTJ2kRHanM=;
        b=LlfNDK0UOBDhPM4icZWg0U1hqnlUirGnt9g8bDduYnZVgb74v7YtAJu5ZSszaIchx+
         1LglqLJkgtMk9YvpMJr3gbLNb5va96BbmIPqUbvW4vo2Xnb+kxt/1NqcRXqjks1lNgvg
         uci7OCDYW5WAFt6GYfi/zQwwZbiTt26k/coDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=cyKaQCeyHLS4EathuQVksg4S7Jponx+EApTJ2kRHanM=;
        b=OkekbYuEjnPBC/jCkQTgXImEknVhtB7xxlPRCzZ/twjUb9iIWHTLPF7mZVI333Tevw
         +VfwHmxEpQHSPX3y8UB/rEJqcZYz7K5IkEtH0DOLGFCgVOW2VUvJxL4Iu3XykudNVb8l
         mEkqVakaSBY3mhK/r1mJI9yJMppAylSj1YyT+kvX6TxJfhnxpQ3E0CUKYljDQPpNOlhD
         K9xcH8KWUVFonO+VAcL4QH3IOS1ObYCnEGQOh6mfrI4oETC8gTDUJtvMc0mxOTNvqdck
         OMtjl6MwQodkNSeyJhH3gI13MtZP4aVzRL083hWqQyw9gvzGBfcTPyuAQIkBvlW5Wp4X
         Zfsw==
X-Gm-Message-State: AOAM533oJTHMcBLf1ffI8pKtxTgRifM+vB7jZh3LsUmUXPA/OxSgrP3t
        xv1RuCWuIUlIcK6vdbywoBHdRw==
X-Google-Smtp-Source: ABdhPJz9r3Zc1W04RbJHA8pEKhmLAqX+WD+p/Bg8XfAFkOoVW2zFgvW7BDV3Hpiz1ea7DIxR9MNF7Q==
X-Received: by 2002:a1c:df09:: with SMTP id w9mr3003192wmg.91.1623957470485;
        Thu, 17 Jun 2021 12:17:50 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w23sm9415180wmi.0.2021.06.17.12.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 12:17:50 -0700 (PDT)
Date:   Thu, 17 Jun 2021 21:17:48 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Qiang Ma <maqianga@uniontech.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/auth: Move master pointer from drm_device to drm_file
Message-ID: <YMuf3BHk+3ROGJ09@phenom.ffwll.local>
Mail-Followup-To: Qiang Ma <maqianga@uniontech.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210617094733.8429-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617094733.8429-1-maqianga@uniontech.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 05:47:33PM +0800, Qiang Ma wrote:
> The drm_file pointer clears to zero during multi-user switching,
> so it needs to call drm_new_set_master for master pointer from drm_file.

That sounds like a bug. drm_file->master should be always the same -
either you become a new stand-alone thing, our you get linked to the
current master.

Or I'm completely missing what you're trying to fix here.
-Daniel

> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
>  drivers/gpu/drm/drm_auth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
> index f2d46b7ac6f9..02431af6d0c5 100644
> --- a/drivers/gpu/drm/drm_auth.c
> +++ b/drivers/gpu/drm/drm_auth.c
> @@ -302,7 +302,7 @@ int drm_master_open(struct drm_file *file_priv)
>  	/* if there is no current master make this fd it, but do not create
>  	 * any master object for render clients */
>  	mutex_lock(&dev->master_mutex);
> -	if (!dev->master)
> +	if (!file_priv->master)
>  		ret = drm_new_set_master(dev, file_priv);
>  	else
>  		file_priv->master = drm_master_get(dev->master);
> -- 
> 2.20.1
> 
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
