Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345E8380C00
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhENOkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhENOky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:40:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8FAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:39:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d11so30253215wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nmVdek38n6ibAH38hNuyn9kJ/P/QzS89Xl7MFzWBQdg=;
        b=Q74GPtmCp4TQWo9xCXfgT6OXTZ61f9mM1Qxl5aRf8eE8qTkiM3yVFFuGY2iE6wzJWo
         xivybmhlWyGmXadxsp2PSGF6wk4nNzFeaxblwLc95pveWWX7BDpDQ77p4Tp8yW/z7qjz
         sovajZtyngvWCqjxJnXAciGqcxDjR5nGlzFQJ6lW+eYWhU9jPwzavwGpMs4ow38rsa5A
         2fdi2s4sa+l1Jp3NUyPukOLnRla6Zmn64KdnNGmXlaZB1JzN/GTKO63euWLy79QIofSW
         nptpuZby224rqden50KQ9/7wOqyYwrs3nmWIl0+K5zbGdH9j3l8vcKahL1UD0B0Lapth
         HWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nmVdek38n6ibAH38hNuyn9kJ/P/QzS89Xl7MFzWBQdg=;
        b=e6G+Fn3+P86cDtE6Be5oxBg9fKTZ9mFisIfOhT0zBTvU6ahhqF4/CBT6q7Dk8SZdaR
         1+9/w253nFSXrnOE4pew39AbPa5DHcwaRhDP0o/WEF8QP9NNY6Ii0DSIGILCj2GQOYdR
         gtl+DUM2UlL82cEJ4XTZErnejY0BJFteqsfemEspB9O1Zz+VlScpTGjPFtqMejKVm4AS
         5lBRGPWDWA552rmj7m2202htC8ExYm24sDB/Dq9WmRqfwxvcG/QTo6FDhtpGeR33SjNu
         2NE4iHtaQNeRPPeXcXDy2ZSJkirx7llQuG3ZHDlSq7SKbMc+wMeHzcUuD3ps+7AX+4ZU
         IDRA==
X-Gm-Message-State: AOAM531imDWPVpomJIcE5loHHydUtWVe0MeLXguXktxguGReUvOQ2L6t
        dAtsl9GZR0EI/r6SJ+FV4rGQmLW9jw6BpZ7ihWQ=
X-Google-Smtp-Source: ABdhPJwkR4yo6sndBjrXrB4Am0lNwfUlDlmc10ZO4aVBCoqiy4Ixurx4ZbW0J4M3WeY5RK51zPsMKL2kbqzxfyjxrCE=
X-Received: by 2002:adf:e84a:: with SMTP id d10mr59196019wrn.132.1621003181361;
 Fri, 14 May 2021 07:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210508195641.397198-1-robdclark@gmail.com> <20210508195641.397198-2-robdclark@gmail.com>
 <YJlb3GO41hiu4pWw@phenom.ffwll.local> <CAF6AEGsGb1jZgRRUqDvf+j+E6pNEtSck=r3xh4VL7FmZMPszBQ@mail.gmail.com>
 <CAKMK7uGPGbOPRtJaiG5oNCDhYQ27+V3bO5Wcgv7C9fqdyp8LeA@mail.gmail.com>
 <CAF6AEGto1PQcEbYeWfXqMatK0z3dW-mpLNVh=VJb=9gwrPfCWg@mail.gmail.com>
 <YJq0YVi4O4zGkb3j@phenom.ffwll.local> <20210512112330.0130a62a@eldfell>
 <CAF6AEGu4B2wXhbjUxT36tKUhz7R_Mg=TzD7yOA-90L7VBCHpMQ@mail.gmail.com> <20210514105404.6e5e44bc@eldfell>
In-Reply-To: <20210514105404.6e5e44bc@eldfell>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 14 May 2021 07:43:23 -0700
Message-ID: <CAF6AEGv2JVk6Zm8C1HreRbkqYorx36fcUQHeSYNd4ykdRYEm6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: Fix dirtyfb stalls
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 12:54 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
>
> On Wed, 12 May 2021 07:57:26 -0700
> Rob Clark <robdclark@gmail.com> wrote:
>
> > On Wed, May 12, 2021 at 1:23 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> > >
> > > On Tue, 11 May 2021 18:44:17 +0200
> > > Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > > On Mon, May 10, 2021 at 12:06:05PM -0700, Rob Clark wrote:
> > > > > On Mon, May 10, 2021 at 10:44 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > > >
> > > > > > On Mon, May 10, 2021 at 6:51 PM Rob Clark <robdclark@gmail.com> wrote:
> > > > > > >
> > > > > > > On Mon, May 10, 2021 at 9:14 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > > > > >
> > > > > > > > On Sat, May 08, 2021 at 12:56:38PM -0700, Rob Clark wrote:
> > > > > > > > > From: Rob Clark <robdclark@chromium.org>
> > > > > > > > >
> > > > > > > > > drm_atomic_helper_dirtyfb() will end up stalling for vblank on "video
> > > > > > > > > mode" type displays, which is pointless and unnecessary.  Add an
> > > > > > > > > optional helper vfunc to determine if a plane is attached to a CRTC
> > > > > > > > > that actually needs dirtyfb, and skip over them.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> ...
>
> > > > > > > But we could re-work drm_framebuffer_funcs::dirty to operate on a
> > > > > > > per-crtc basis and hoist the loop and check if dirtyfb is needed out
> > > > > > > of drm_atomic_helper_dirtyfb()
> > > > > >
> > > > > > That's still using information that userspace doesn't have, which is a
> > > > > > bit irky. We might as well go with your thing here then.
> > > > >
> > > > > arguably, this is something we should expose to userspace.. for DSI
> > > > > command-mode panels, you probably want to make a different decision
> > > > > with regard to how many buffers in your flip-chain..
> > > > >
> > > > > Possibly we should add/remove the fb_damage_clips property depending
> > > > > on the display type (ie. video/pull vs cmd/push mode)?
> > > >
> > > > I'm not sure whether atomic actually needs this exposed:
> > > > - clients will do full flips for every frame anyway, I've not heard of
> > > >   anyone seriously doing frontbuffer rendering.
> > >
> > > That may or may not be changing, depending on whether the DRM drivers
> > > will actually support tearing flips. There has been a huge amount of
> > > debate for needing tearing for Wayland [1], and while I haven't really
> > > joined that discussion, using front-buffer rendering (blits) to work
> > > around the driver inability to flip-tear might be something some people
> > > will want.
> >
> > jfwiw, there is a lot of hw that just can't do tearing pageflips.. I
> > think this probably includes most arm hw.  What is done instead is to
> > skip the pageflip and render directly to the front-buffer.
> >
> > EGL_KHR_mutable_render_buffer is a thing you might be interested in..
> > it is wired up for android on i965 and there is a WIP MR[1] for
> > mesa/st (gallium):
> >
> > Possibly it could be useful to add support for platform_wayland?
> >
> > [1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/10685
>
> Thanks Rob, that's interesting.
>
> I would like to say that EGL Wayland platform cannot and has no reason
> to support frontbuffer rendering in Wayland clients, because the
> compositor may be reading the current client frontbuffer at any time,
> including *not reading it again* until another update is posted via
> Wayland. So if a Wayland client is doing frontbuffer rendering, then I
> would expect it to be very likely that the window might almost never
> show a "good" picture, meaning that it is literally just the
> half-rendered frame after the current one with continuously updating
> clients.
>
> That is because a Wayland client doing frontbuffer rendering is
> completely unrelated to the Wayland compositor putting the client
> buffer on scanout.
>
> Frontbuffer rendering used by a Wayland compositor would be used for
> fallback tearing updates, where the rendering is roughly just a blit
> from a client buffer. By definition, it means blit instead of scanout
> from client buffers, so the performance/power hit is going to be...
> let's say observable.
>
> If a Wayland client did frontbuffer rendering, and then it used a
> shadow buffer of its own to minimise the level of garbage on screen by
> doing only blits into the frontbuffer, that would again be a blit. And
> then the compositor might be doing another blit because it doesn't know
> the client is doing frontbuffer rendering which would theoretically
> allow the compositor to scan out the client buffer.
>
> There emerges the need for a Wayland extension for clients to be
> telling the compositor explicitly that they are going to be doing
> frontbuffer rendering now, it is ok to put the client buffer on scanout
> even if you want to do tearing updates on hardware that cannot
> tear-flip.
>
> However, knowing that a client buffer is good for scanout is not
> sufficient for scanout in a compositor, so it might still not be
> scanned out. If the compositor is instead render-compositing, you have
> the first problem of "likely never a good picture".

I think if a client is doing front-buffer rendering, then "tearing" is
the clients problem.

The super-big-deal use-case for this is stylus, because you want to
minimize the latency of pen-to-pixel.. tearing isn't really a problem
because things aren't changing much from-by-frame

I'm going to predict there will be at least one wayland compositor
supporting this, maybe via custom protocol, idk. ;-)

BR,
-R

> I'm sure there can be specialised use cases (e.g. a game console
> Wayland compositor) where scanout can be guaranteed, but generally
> for desktops it's not so.
>
> I believe there will be people wanting EGL Wayland platform frontbuffer
> rendering for very special cases, and I also believe it will just break
> horribly everywhere else. Would it be worth it to implement? No idea.
>
> Maybe there would need to be a Wayland extension so that compositors
> can control the availability of frontbuffer rendering in EGL Wayland
> platform?
>
> There is the dmabuf-hints Wayland addition that is aimed at dynamically
> providing information to help optimise for scanout and
> render-compositing. If a compositor could control frontbuffer rendering
> in a client, it could tell the client to use frontbuffer rendering when
> it does hit scanout, and tell the client to stop frontbuffer rendering
> when scanout is no longer possible. The problem with the latter is a
> glitch, but since frontbuffer rendering is by definition glitchy (when
> done in clients), maybe that is acceptable to some?
>
>
> Thanks,
> pq
