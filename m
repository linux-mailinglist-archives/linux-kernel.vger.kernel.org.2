Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8180636C604
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 14:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbhD0MXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 08:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbhD0MXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 08:23:52 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252C6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 05:23:08 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i21-20020a05600c3555b029012eae2af5d4so6985591wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 05:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=0pMESe1z+MsjbhBRHvTQHk6SqcR4Ic+PigvgIgSdX4w=;
        b=j/YIAhHVG51+GO+y7bT1Sg35jUm9Uat83QdrpCqSHZyO3K8wq0n5c9o5EQ3kGNTexF
         XU8SgXOq2P4fvbzGgQmiob6iCbBr2/q6gXd0BPDNeoZ8jgN3Wm0VqAwM5vOq15uWXToW
         GMyTTxbn08cGD8eEAS40PmSaVz8PREoA6FAOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=0pMESe1z+MsjbhBRHvTQHk6SqcR4Ic+PigvgIgSdX4w=;
        b=nV2sBetvhItD4x7/Kfx4DkQDyeymVgCO/u2L3u9/MUjKm1At+Es69I/jSqyLPvpeJi
         qRU9ycfyYJrO0A+0L942C22bC4WPrbeh72GhbSAjYetK2wUzAox0K+gK2bPyPt1JCjPB
         WYNYYKkw1sGNMDxnpTu9fAEma1bAEOX8Iql+H5pR2iXSkgSlz66+CcCAxejmHKRvIc6l
         fioCUKbsa5AcnqstzOK5+V0bkyRf3qw19ieUGyU+bXaCz15Mig6lgABxaPAJ2jZT2Lr+
         uyXrNGOAoayN/oNztp3Dv00hlRX1H7azriVz2U5R5X5qIEGFcsaI/vEh8I1WpU72QfK1
         0B1g==
X-Gm-Message-State: AOAM532RJkTOqtEWsx6IuXtmhxaNwGreoFFjzJmecGIvDc577afF3KCA
        Jz2GnwFOQ3l9SA5Ezsj0D3nNJw==
X-Google-Smtp-Source: ABdhPJwmWvSYs4zi3tUhhsyr3/eaD9g6PjtdpY/LhVc/Bh9wuH/cDkbysx+IzGT6qsUoBJgNjHkJkg==
X-Received: by 2002:a1c:1d91:: with SMTP id d139mr16655610wmd.101.1619526186919;
        Tue, 27 Apr 2021 05:23:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b202sm2585727wmb.5.2021.04.27.05.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 05:23:06 -0700 (PDT)
Date:   Tue, 27 Apr 2021 14:23:04 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/drm_file.c: Define drm_send_event_helper() as
 'static'
Message-ID: <YIgCKOSIyc1rMkrt@phenom.ffwll.local>
Mail-Followup-To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        outreachy-kernel@googlegroups.com, dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20210427105503.10765-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427105503.10765-1-fmdefrancesco@gmail.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 12:55:03PM +0200, Fabio M. De Francesco wrote:
> drm_send_event_helper() has not prototype, it has internal linkage and
> therefore it should be defined with storage class 'static'.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Applied to drm-misc-next for 5.14, thanks for your patch.
-Daniel

> ---
> 
> Changes from v2: Removed all the other lines in function comment.
> Changes from v1: As suggested by Daniel Vetter, removed unnecessary
> kernel-doc comments.
> 
>  drivers/gpu/drm/drm_file.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index 7efbccffc2ea..d4f0bac6f8f8 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -774,19 +774,7 @@ void drm_event_cancel_free(struct drm_device *dev,
>  }
>  EXPORT_SYMBOL(drm_event_cancel_free);
>  
> -/**
> - * drm_send_event_helper - send DRM event to file descriptor
> - * @dev: DRM device
> - * @e: DRM event to deliver
> - * @timestamp: timestamp to set for the fence event in kernel's CLOCK_MONOTONIC
> - * time domain
> - *
> - * This helper function sends the event @e, initialized with
> - * drm_event_reserve_init(), to its associated userspace DRM file.
> - * The timestamp variant of dma_fence_signal is used when the caller
> - * sends a valid timestamp.
> - */
> -void drm_send_event_helper(struct drm_device *dev,
> +static void drm_send_event_helper(struct drm_device *dev,
>  			   struct drm_pending_event *e, ktime_t timestamp)
>  {
>  	assert_spin_locked(&dev->event_lock);
> -- 
> 2.31.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
