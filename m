Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150543F013D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 12:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhHRKGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 06:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbhHRKFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 06:05:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AE8C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 03:05:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qk33so3792585ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 03:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=+UugXJNovZ2vqktgPlIQAdEvTrXzjK5N1Cr++nIj3DA=;
        b=R42e8IjQDth0gJLIVgsbrUrhAc6d0ey998kv2PQoRChb7eJx00eZ1Gm0c/EhfBivkC
         IBNmrGkJ8ApCpeW2C+4cEd65TeabJc9SlX1xYSqdk72h0IEQ+khLKq7zNM6jv5wHaBvB
         ZXdjx0ctrHer5bc0vfxlwQtTRpuI1JQHIunWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=+UugXJNovZ2vqktgPlIQAdEvTrXzjK5N1Cr++nIj3DA=;
        b=l5sREF4CxNHCra0X7Lo44iCvviNMNvSb0sSiz3BeWyNRz1RkfhICcDQxGMZOivVXVt
         ZF+PMau24pM0VVPzTdBWiwgWVY9TeVKbT3Ge2dOW1K1aJFV1J0H0srp6b1NkTJxb1ZLw
         ziTGjVlFAMEG4J5kS8fgztRadW0t/y0obqjcCrmOEsD8GnLeNFObyfRpqdCzuEBd7HuC
         aONyw4z36l2FMzhCuuIbMMl3lc4RLdIBpT2V5bz0x2BACnR5S086fAYhAam2y7PlYYp7
         //zGely+hyebKqNzsldIPyVWTw/MCDKEukol/Uvjz6CXFmoWaP8x0Wv0FQzl63qcREwK
         yPkA==
X-Gm-Message-State: AOAM530+FTQDhOPW8UDo/eT6gOj3PxtQhIe2R9y/zx1U+VlG2kXAGf60
        gVEEPJqFKBsLDRLatc43ro1fyw==
X-Google-Smtp-Source: ABdhPJyCL0wNSTVtmCi+TFUYXg5lqc4ePLGIxn2k+rFjGuAVDwSBiMK9lqUgzHWBYJDOF+Ij9NGXdA==
X-Received: by 2002:a17:906:150c:: with SMTP id b12mr8875986ejd.275.1629281104548;
        Wed, 18 Aug 2021 03:05:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id e22sm2384475eds.45.2021.08.18.03.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 03:05:03 -0700 (PDT)
Date:   Wed, 18 Aug 2021 12:05:01 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        sumit.semwal@linaro.org, christian.koenig@amd.com, axboe@kernel.dk,
        oleg@redhat.com, tglx@linutronix.de, dvyukov@google.com,
        walter-zh.wu@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3 2/9] drm: hold master_lookup_lock when releasing a
 drm_file's master
Message-ID: <YRzbTUM8ggXlIEyr@phenom.ffwll.local>
Mail-Followup-To: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, sumit.semwal@linaro.org,
        christian.koenig@amd.com, axboe@kernel.dk, oleg@redhat.com,
        tglx@linutronix.de, dvyukov@google.com, walter-zh.wu@mediatek.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210818073824.1560124-1-desmondcheongzx@gmail.com>
 <20210818073824.1560124-3-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818073824.1560124-3-desmondcheongzx@gmail.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 03:38:17PM +0800, Desmond Cheong Zhi Xi wrote:
> When drm_file.master changes value, the corresponding
> drm_device.master_lookup_lock should be held.
> 
> In drm_master_release, a call to drm_master_put sets the
> file_priv->master to NULL, so we protect this section with
> drm_device.master_lookup_lock.
> 
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>

At this points all refcounts to drm_file have disappeared, so yeah this is
a lockless access, but also no one can observe it anymore. See also next
patch.

Hence I think the current code is fine.
-Daniel

> ---
>  drivers/gpu/drm/drm_auth.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
> index 8efb58aa7d95..8c0e0dba1611 100644
> --- a/drivers/gpu/drm/drm_auth.c
> +++ b/drivers/gpu/drm/drm_auth.c
> @@ -373,8 +373,11 @@ void drm_master_release(struct drm_file *file_priv)
>  	}
>  
>  	/* drop the master reference held by the file priv */
> -	if (file_priv->master)
> +	if (file_priv->master) {
> +		spin_lock(&dev->master_lookup_lock);
>  		drm_master_put(&file_priv->master);
> +		spin_unlock(&dev->master_lookup_lock);
> +	}
>  	mutex_unlock(&dev->master_mutex);
>  }
>  
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
