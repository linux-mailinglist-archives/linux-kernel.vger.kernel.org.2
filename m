Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A2137937B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhEJQQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhEJQPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:15:32 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF80C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:14:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so9231549wmn.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=/u989ZzQlUZcKtlarwp4DjPGMy3VRc1qd02puXmUDYM=;
        b=TI3yKKEy6BV0ogVLfZGlGlAeIKd33OfRHPZbklOjagZvlIf2/XXmjZwRD0tQNSBRm9
         603YgESeeZnfuILYFPPURhqsngvI/ER85ZqGuibFtEJ4j4ZYuU0uvgs+3iTeLLe/cgQj
         JyPLsBKU7ZhMYq1Yp3LMlYGNUQTvhtzdkhuao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=/u989ZzQlUZcKtlarwp4DjPGMy3VRc1qd02puXmUDYM=;
        b=SriVxEbB/a2NuAQ0rhtXWNyRVYoZ5mMyR84cBug0799fHLxI5iV1L0x41t6SzGJ9aK
         3jh3rvEfXTtvf3QyPmye2F/y0dm9GPIF655baMXMv3QXS+QLmd4jglKB3xCl/NHn7+Ky
         VoDz1l+la9GHOBGz1AvIyyEGh7ZRPUhmBxQ78IOhQpEkwN1BEm+zb+EsswEnH95kdHX3
         zUm4F5+wYqYRN0GWwLTUHbWyLNoU/IjkhCk6TsyZ0minA5DyxwbJiZbmss52z0iqr2L6
         +5YPT/vrHVuMuQFsxbJLOkGGtAnZlYcnVr5TOb87GDyEEnWKZPNlZEmggwRtzumOBMg3
         HKRQ==
X-Gm-Message-State: AOAM531qOzbj5ywybBAhvMs8sniduCpc512gmBueG9IZ++UChp7VoIuD
        /cIDMfKbLPVRrG8WeafxeQvXEQ==
X-Google-Smtp-Source: ABdhPJyheVMLPROAhXkbBLr6ibUsP+9urLYBoCZ+gu+epj/ILixd+q8lymtpjKrX3ZFEtm6p4Mea1A==
X-Received: by 2002:a7b:c217:: with SMTP id x23mr37245491wmi.26.1620663262629;
        Mon, 10 May 2021 09:14:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c15sm2235879wml.38.2021.05.10.09.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 09:14:21 -0700 (PDT)
Date:   Mon, 10 May 2021 18:14:20 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm: Fix dirtyfb stalls
Message-ID: <YJlb3GO41hiu4pWw@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20210508195641.397198-1-robdclark@gmail.com>
 <20210508195641.397198-2-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210508195641.397198-2-robdclark@gmail.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2021 at 12:56:38PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> drm_atomic_helper_dirtyfb() will end up stalling for vblank on "video
> mode" type displays, which is pointless and unnecessary.  Add an
> optional helper vfunc to determine if a plane is attached to a CRTC
> that actually needs dirtyfb, and skip over them.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

So this is a bit annoying because the idea of all these "remap legacy uapi
to atomic constructs" helpers is that they shouldn't need/use anything
beyond what userspace also has available. So adding hacks for them feels
really bad.

Also I feel like it's not entirely the right thing to do here either.
We've had this problem already on the fbcon emulation side (which also
shouldn't be able to peek behind the atomic kms uapi curtain), and the fix
there was to have a worker which batches up all the updates and avoids any
stalls in bad places.

Since this is for frontbuffer rendering userspace only we can probably get
away with assuming there's only a single fb, so the implementation becomes
pretty simple:

- 1 worker, and we keep track of a single pending fb
- if there's already a dirty fb pending on a different fb, we stall for
  the worker to start processing that one already (i.e. the fb we track is
  reset to NULL)
- if it's pending on the same fb we just toss away all the updates and go
  with a full update, since merging the clip rects is too much work :-) I
  think there's helpers so you could be slightly more clever and just have
  an overall bounding box

Could probably steal most of the implementation.

This approach here feels a tad too much in the hacky area ...

Thoughts?
-Daniel

> ---
>  drivers/gpu/drm/drm_damage_helper.c      |  8 ++++++++
>  include/drm/drm_modeset_helper_vtables.h | 14 ++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
> index 3a4126dc2520..a0bed1a2c2dc 100644
> --- a/drivers/gpu/drm/drm_damage_helper.c
> +++ b/drivers/gpu/drm/drm_damage_helper.c
> @@ -211,6 +211,7 @@ int drm_atomic_helper_dirtyfb(struct drm_framebuffer *fb,
>  retry:
>  	drm_for_each_plane(plane, fb->dev) {
>  		struct drm_plane_state *plane_state;
> +		struct drm_crtc *crtc;
>  
>  		ret = drm_modeset_lock(&plane->mutex, state->acquire_ctx);
>  		if (ret)
> @@ -221,6 +222,13 @@ int drm_atomic_helper_dirtyfb(struct drm_framebuffer *fb,
>  			continue;
>  		}
>  
> +		crtc = plane->state->crtc;
> +		if (crtc->helper_private->needs_dirtyfb &&
> +				!crtc->helper_private->needs_dirtyfb(crtc)) {
> +			drm_modeset_unlock(&plane->mutex);
> +			continue;
> +		}
> +
>  		plane_state = drm_atomic_get_plane_state(state, plane);
>  		if (IS_ERR(plane_state)) {
>  			ret = PTR_ERR(plane_state);
> diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
> index eb706342861d..afa8ec5754e7 100644
> --- a/include/drm/drm_modeset_helper_vtables.h
> +++ b/include/drm/drm_modeset_helper_vtables.h
> @@ -487,6 +487,20 @@ struct drm_crtc_helper_funcs {
>  				     bool in_vblank_irq, int *vpos, int *hpos,
>  				     ktime_t *stime, ktime_t *etime,
>  				     const struct drm_display_mode *mode);
> +
> +	/**
> +	 * @needs_dirtyfb
> +	 *
> +	 * Optional callback used by damage helpers to determine if fb_damage_clips
> +	 * update is needed.
> +	 *
> +	 * Returns:
> +	 *
> +	 * True if fb_damage_clips update is needed to handle DIRTYFB, False
> +	 * otherwise.  If this callback is not implemented, then True is
> +	 * assumed.
> +	 */
> +	bool (*needs_dirtyfb)(struct drm_crtc *crtc);
>  };
>  
>  /**
> -- 
> 2.30.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
