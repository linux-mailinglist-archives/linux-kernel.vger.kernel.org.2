Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BABB36C179
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 11:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbhD0JLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 05:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhD0JLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 05:11:34 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8DEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 02:10:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a4so58683160wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 02:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=n7pb8U/vANg8DkgjnfhKWXBOO9anvx207tlIcVrJQJ8=;
        b=F30ycGVHuqTdERjON0BrUg7XctaGeT53f7MbHOVymKhnJD+MIwrvM8DZ10UJJDma4W
         7oVFQ4r4V0H9ULifunx+AR9oycW6WxWVTrSTkx1JDfQy1GHREx7oIBKhD0knlGSLPJRU
         CZsxgvX5Wq53Jr5CRAHqy3uHeJ/rX7KY15MSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=n7pb8U/vANg8DkgjnfhKWXBOO9anvx207tlIcVrJQJ8=;
        b=p1QrD4wSygxPCFNgBuK+DmQ7IWD00C5JGihrtRrb3yEHOP7jNmfJ7G6Kbddc+6yLrJ
         NBRdVjZKhlAdgoG5+hQ2BqRJEpVsWUfDy0Guhzn5DLpYJxDPGLnVGZdz1lazXm4bksZ1
         QMkAlqHqZSf7i+4cM1WbV1mdmRHkOrHLuWhhcLaReqSdSgEH17fuaRteP8QqIzOaWKLr
         9kTTggMHjLGpO0zSXHBHBEshrfsRa9CHBR6H5FnsYEyir30l8j8ybgSD2dPWT/AZer2b
         OBLiP/DTpmWia+pbVjxMz2AQKVJ9bb7oqCCwCyJXcVoJ3SUUszayVGPxu027srf96sHM
         hGgA==
X-Gm-Message-State: AOAM533bRoZdh7BLCGNAMo6UJ7DIhUEhGNNtR+SmQdlXYb2TV0BKilOW
        LE2dn7VRfS/znz49PcF3YlLKFg==
X-Google-Smtp-Source: ABdhPJxi11Q25W3ep1Deeurj1gNS9KQqebu7z2WSz2/OvIkkKvYk/cXzjlCgzcq92lN90LhBmjvMdg==
X-Received: by 2002:adf:fc85:: with SMTP id g5mr1852842wrr.295.1619514649110;
        Tue, 27 Apr 2021 02:10:49 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a2sm3262846wrt.82.2021.04.27.02.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 02:10:48 -0700 (PDT)
Date:   Tue, 27 Apr 2021 11:10:46 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2] drm/drm_file.c: Define drm_send_event_helper() as
 'static'
Message-ID: <YIfVFqUtJ2UDucSJ@phenom.ffwll.local>
Mail-Followup-To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        outreachy-kernel@googlegroups.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
References: <20210426200051.11530-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426200051.11530-1-fmdefrancesco@gmail.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 10:00:51PM +0200, Fabio M. De Francesco wrote:
> drm_send_event_helper() has not prototype, it has internal linkage and
> therefore it should be defined with storage class 'static'.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> Changes from v1: As suggested by Daniel Vetter, removed unnecessary
> kernel-doc comments.
> 
>  drivers/gpu/drm/drm_file.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index 7efbccffc2ea..a32e0d4f3604 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -774,19 +774,15 @@ void drm_event_cancel_free(struct drm_device *dev,
>  }
>  EXPORT_SYMBOL(drm_event_cancel_free);
>  
> -/**
> +/*
>   * drm_send_event_helper - send DRM event to file descriptor
> - * @dev: DRM device
> - * @e: DRM event to deliver
> - * @timestamp: timestamp to set for the fence event in kernel's CLOCK_MONOTONIC
> - * time domain
>   *
> - * This helper function sends the event @e, initialized with
> + * This helper function sends the event e, initialized with

Sorry I wasn't clear, I don't think there's anything useful at all in this
comment, so best to entirely remove it. Not just the kerneldoc header. Can
you pls respin?
-Daniel

>   * drm_event_reserve_init(), to its associated userspace DRM file.
>   * The timestamp variant of dma_fence_signal is used when the caller
>   * sends a valid timestamp.
>   */
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
