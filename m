Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F667379491
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhEJQxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhEJQw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:52:57 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DF4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:51:52 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g65so9591627wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vj82DQvWg391VDm1zJSxDbgIrEh76L9ZIZAnowRqXGQ=;
        b=gGoYE+hhb84BJBRxsSCnPggaZ/Ix5Gn6l8QEvHmsCyAHS8XNJokD9hZ/Km3Ge3WcSY
         o3SYApzWs+tzWK1zsn8kL7oZilDGG1X8Fe0iQIcsffxgUOsfpJQkEVEGc6mQi9nK+jOE
         dPdWezbX9yROlSOUDfFJk7Vyx74xYToaGjOv92FzG3F7hKJIyLeJdGkTg5iHnvYhMejr
         U4PBSgrnat5JAgUw8XyVnpB2qGB3AG0p1cTmaUYcHMs9/j/MQDVD74uOMBBTLFZP50dn
         ixXd9rtPO9rRsjUtXz5SkkaZ7xCEUwb86Pr/6jRr6KKb5Id2CfinYqjEWf3D8xJh/nfw
         10bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vj82DQvWg391VDm1zJSxDbgIrEh76L9ZIZAnowRqXGQ=;
        b=nRW4nncmDnrN8ZWgVArt73f6E2yas33WhcXMOYCG4LDw0k5qhzt1N1YnUXiX33qPqb
         DjcHyuyCJriRUR5+T2oPbwL3NKfg8zEGR+5tzmbQAQ+XC5GAQjxS4bF/Rg7jB1/04KhF
         T1Rkie3Yw/6hV00ZypKogEkOV7I9AF7ddEia1nOThShcbCs0xErAaKr1pX8EuVQ937tE
         AoJbqWqx8u1hL/5cE08KQ4xRzqHoLTdDdQSBG8dLiWdCY747XYCtMtrB57WBTj8Vc8aL
         oe1cRb2PAWoaMqaCh2bXAetVpId/QC6H9StExm7BVMbDxY2X3bzOloWMi83KmbHV5X+U
         ratA==
X-Gm-Message-State: AOAM532PJfth1eVHZHboxATB9eCpBbefvU0U0piAscT8jE6mTIZ+qLPZ
        /vAMmpOgms++ow/Us1zn7KULj69qDBDR9QVUCXw=
X-Google-Smtp-Source: ABdhPJydE0p3nCV4Jnaoqt8BOhaG8kUQeipThsmaq28Q7e38GoG5kt6v6kD4gQ1kE2NtqQC4kpI9rx0k9sp/WdAHhV0=
X-Received: by 2002:a05:600c:249:: with SMTP id 9mr27297198wmj.175.1620665510955;
 Mon, 10 May 2021 09:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210508195641.397198-1-robdclark@gmail.com> <20210508195641.397198-2-robdclark@gmail.com>
 <YJlb3GO41hiu4pWw@phenom.ffwll.local>
In-Reply-To: <YJlb3GO41hiu4pWw@phenom.ffwll.local>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 10 May 2021 09:55:32 -0700
Message-ID: <CAF6AEGsGb1jZgRRUqDvf+j+E6pNEtSck=r3xh4VL7FmZMPszBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: Fix dirtyfb stalls
To:     Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 9:14 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Sat, May 08, 2021 at 12:56:38PM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > drm_atomic_helper_dirtyfb() will end up stalling for vblank on "video
> > mode" type displays, which is pointless and unnecessary.  Add an
> > optional helper vfunc to determine if a plane is attached to a CRTC
> > that actually needs dirtyfb, and skip over them.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> So this is a bit annoying because the idea of all these "remap legacy uapi
> to atomic constructs" helpers is that they shouldn't need/use anything
> beyond what userspace also has available. So adding hacks for them feels
> really bad.

I suppose the root problem is that userspace doesn't know if dirtyfb
(or similar) is actually required or is a no-op.

But it is perhaps less of a problem because this essentially boils
down to "x11 vs wayland", and it seems like wayland compositors for
non-vsync'd rendering just pageflips and throws away extra frames from
the app?

> Also I feel like it's not entirely the right thing to do here either.
> We've had this problem already on the fbcon emulation side (which also
> shouldn't be able to peek behind the atomic kms uapi curtain), and the fix
> there was to have a worker which batches up all the updates and avoids any
> stalls in bad places.

I'm not too worried about fbcon not being able to render faster than
vblank.  OTOH it is a pretty big problem for x11

> Since this is for frontbuffer rendering userspace only we can probably get
> away with assuming there's only a single fb, so the implementation becomes
> pretty simple:
>
> - 1 worker, and we keep track of a single pending fb
> - if there's already a dirty fb pending on a different fb, we stall for
>   the worker to start processing that one already (i.e. the fb we track is
>   reset to NULL)
> - if it's pending on the same fb we just toss away all the updates and go
>   with a full update, since merging the clip rects is too much work :-) I
>   think there's helpers so you could be slightly more clever and just have
>   an overall bounding box

This doesn't really fix the problem, you still end up delaying sending
the next back-buffer to mesa

But we could re-work drm_framebuffer_funcs::dirty to operate on a
per-crtc basis and hoist the loop and check if dirtyfb is needed out
of drm_atomic_helper_dirtyfb()

BR,
-R

>
> Could probably steal most of the implementation.
>
> This approach here feels a tad too much in the hacky area ...
>
> Thoughts?
> -Daniel
>
> > ---
> >  drivers/gpu/drm/drm_damage_helper.c      |  8 ++++++++
> >  include/drm/drm_modeset_helper_vtables.h | 14 ++++++++++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
> > index 3a4126dc2520..a0bed1a2c2dc 100644
> > --- a/drivers/gpu/drm/drm_damage_helper.c
> > +++ b/drivers/gpu/drm/drm_damage_helper.c
> > @@ -211,6 +211,7 @@ int drm_atomic_helper_dirtyfb(struct drm_framebuffer *fb,
> >  retry:
> >       drm_for_each_plane(plane, fb->dev) {
> >               struct drm_plane_state *plane_state;
> > +             struct drm_crtc *crtc;
> >
> >               ret = drm_modeset_lock(&plane->mutex, state->acquire_ctx);
> >               if (ret)
> > @@ -221,6 +222,13 @@ int drm_atomic_helper_dirtyfb(struct drm_framebuffer *fb,
> >                       continue;
> >               }
> >
> > +             crtc = plane->state->crtc;
> > +             if (crtc->helper_private->needs_dirtyfb &&
> > +                             !crtc->helper_private->needs_dirtyfb(crtc)) {
> > +                     drm_modeset_unlock(&plane->mutex);
> > +                     continue;
> > +             }
> > +
> >               plane_state = drm_atomic_get_plane_state(state, plane);
> >               if (IS_ERR(plane_state)) {
> >                       ret = PTR_ERR(plane_state);
> > diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
> > index eb706342861d..afa8ec5754e7 100644
> > --- a/include/drm/drm_modeset_helper_vtables.h
> > +++ b/include/drm/drm_modeset_helper_vtables.h
> > @@ -487,6 +487,20 @@ struct drm_crtc_helper_funcs {
> >                                    bool in_vblank_irq, int *vpos, int *hpos,
> >                                    ktime_t *stime, ktime_t *etime,
> >                                    const struct drm_display_mode *mode);
> > +
> > +     /**
> > +      * @needs_dirtyfb
> > +      *
> > +      * Optional callback used by damage helpers to determine if fb_damage_clips
> > +      * update is needed.
> > +      *
> > +      * Returns:
> > +      *
> > +      * True if fb_damage_clips update is needed to handle DIRTYFB, False
> > +      * otherwise.  If this callback is not implemented, then True is
> > +      * assumed.
> > +      */
> > +     bool (*needs_dirtyfb)(struct drm_crtc *crtc);
> >  };
> >
> >  /**
> > --
> > 2.30.2
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
