Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC863ED9F5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbhHPPgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbhHPPfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:35:55 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22FFC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:35:22 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id bo19so27031709edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=IasKvmj0grPyZpclaR8IMBAIBRCjZoEN6q1hySOpIx8=;
        b=FLJi4iZUP8UiTgTh2IzZR2WM5wp0UlezFnpQ0+W4dKvlP/Bp0N/xwQ5xVJ8QzlbwcW
         FfqgUTOGQVSAZ6lhJSKcNchtnt2bnEjmau/bBsT9uARYt77GapvGf8OEOjjT0jXDRZQe
         3IopPSjLA0oQ60FwNzj8SQ1orL3ysEbohceDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=IasKvmj0grPyZpclaR8IMBAIBRCjZoEN6q1hySOpIx8=;
        b=Uf6lrMtzmXJUkacNDS3s4Jl1/myq7sKA7KiGDzxuC3RaCITvw6lkInkXQKRxGyjl9+
         V0Kjg1dpi/kEqE+i4b6jBd7ncR4uUa55Lz3Xnm9Ok7HKbRxsiNYFn3IY2NKQ3GbhUl7i
         OBMbdR6YWejvmcirMkvuBd7daxcizVTmpZq3ATq/0PKPFKxDO63FgeZorF6ghk3Zm7ye
         +bHGn5LetPTgsgFGppL4lGah+wNBgmv2oh+M7PZrnhqwwnmuY+9OsNyHT6ApN9WR8xh2
         jJoTwRTFdIoCUEQIAoWvhJYh5D1qSMUpM8VTK772IEPciz0TahlpOrDjzZJzuxKsO2il
         s4zQ==
X-Gm-Message-State: AOAM533Iv99v8LZ/5BOF8lOE/4OWabnYtMQ30kxPNfZH+xT1WELIUiXr
        54/uyzqTXKvuu2smCKsm99PNDrfNpfYN0A==
X-Google-Smtp-Source: ABdhPJw86Us3yeAl8Ak8OflhLTWRhOuq8mFn02KQKAqblo+89lWzBRM05emXkzKLODsMjl1K7NUN0w==
X-Received: by 2002:a05:6402:328:: with SMTP id q8mr21378867edw.84.1629128121309;
        Mon, 16 Aug 2021 08:35:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id wc16sm3821383ejb.15.2021.08.16.08.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:35:20 -0700 (PDT)
Date:   Mon, 16 Aug 2021 17:35:18 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] drm/atomic-helper: Set fence deadline for vblank
Message-ID: <YRqFtgCNMKOw3GbX@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20210807183804.459850-1-robdclark@gmail.com>
 <20210807183804.459850-4-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807183804.459850-4-robdclark@gmail.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2021 at 11:37:57AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> For an atomic commit updating a single CRTC (ie. a pageflip) calculate
> the next vblank time, and inform the fence(s) of that deadline.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 36 +++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index bc3487964fb5..7caa2c3cc304 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1406,6 +1406,40 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_enables);
>  
> +/*
> + * For atomic updates which touch just a single CRTC, calculate the time of the
> + * next vblank, and inform all the fences of the of the deadline.

s/of the//

Otherwise lgtm, Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>


> + */
> +static void set_fence_deadline(struct drm_device *dev,
> +			       struct drm_atomic_state *state)
> +{
> +	struct drm_crtc *crtc, *wait_crtc = NULL;
> +	struct drm_crtc_state *new_crtc_state;
> +	struct drm_plane *plane;
> +	struct drm_plane_state *new_plane_state;
> +	ktime_t vbltime;
> +	int i;
> +
> +	for_each_new_crtc_in_state (state, crtc, new_crtc_state, i) {
> +		if (wait_crtc)
> +			return;
> +		wait_crtc = crtc;
> +	}
> +
> +	/* If no CRTCs updated, then nothing to do: */
> +	if (!wait_crtc)
> +		return;
> +
> +	if (drm_crtc_next_vblank_time(wait_crtc, &vbltime))
> +		return;
> +
> +	for_each_new_plane_in_state (state, plane, new_plane_state, i) {
> +		if (!new_plane_state->fence)
> +			continue;
> +		dma_fence_set_deadline(new_plane_state->fence, vbltime);
> +	}
> +}
> +
>  /**
>   * drm_atomic_helper_wait_for_fences - wait for fences stashed in plane state
>   * @dev: DRM device
> @@ -1435,6 +1469,8 @@ int drm_atomic_helper_wait_for_fences(struct drm_device *dev,
>  	struct drm_plane_state *new_plane_state;
>  	int i, ret;
>  
> +	set_fence_deadline(dev, state);
> +
>  	for_each_new_plane_in_state(state, plane, new_plane_state, i) {
>  		if (!new_plane_state->fence)
>  			continue;
> -- 
> 2.31.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
