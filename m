Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0C845736E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhKSQx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhKSQx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:53:28 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAE9C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:50:26 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id x9so10806080ilu.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aEmSSWhf+gL8qBnC3OQ4k9nQBlz6XV75q4puJdRh5oQ=;
        b=Cq14xpJqAALRp2rNxOmf2l7mV944d/L/PTfUJIREFoDicZFdK0CzzoPMMEVPiEXbFr
         4gR5ON7YpQVgpVjHiBjOnsYHB6fsuvMUsScx8RAA7lotRP4XonGgFEH/3o6Jfe44277z
         AE88++2ANNjZbfrxW0p3Ew5ekRE4O1Wc5T3ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aEmSSWhf+gL8qBnC3OQ4k9nQBlz6XV75q4puJdRh5oQ=;
        b=6S4YNzmIZMW0rmAhVs8DHV3yJgWDfOn0ON3ZbEMeqbHHTFWuFFu5FFIaEqdSqgmadp
         YsrxGHPbsepXchJg79lxFNwYsTRIQPAMNXoe0zxJ3z3Jw9iw5ZvZ0sQ1mTFvotR8BzI4
         ZGqSFmFPfhBJooJrwuvgbeepGwjLfSK5lSfcWNE/fL7QmD7xAZGRqsdQNswxWnDGjIhf
         /uE48+huA8dInQZPsHSNaPks+vmMovDzwAil0IT1o2kWVhQ2k1MIAVIa039DPlsHFNYO
         7u6Lp03gZkcgB0UvrbH15jzqyuTH8XevzfAuplqLuhj+VTXash8ikVvt2zkSfi5BjDh+
         izrg==
X-Gm-Message-State: AOAM531uP383oHoc/RAGZJJ0aWnwHvFiMT66Ou6mLzSzPRmkd2aU3Agu
        sHFDFro5a2b5MO3jnc10WXH6Vr12bZSsuQ==
X-Google-Smtp-Source: ABdhPJxPXxJOcq14B5SyHdA0wgXdhG4arUQZtAyusQqPFMOI+ZY+TESuvnjIKKI0WnVzQeWvX6FEpA==
X-Received: by 2002:a05:6e02:19cb:: with SMTP id r11mr6078163ill.151.1637340625227;
        Fri, 19 Nov 2021 08:50:25 -0800 (PST)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id g11sm219828ioo.3.2021.11.19.08.50.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 08:50:23 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id z18so13548823iof.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:50:23 -0800 (PST)
X-Received: by 2002:a05:6638:190f:: with SMTP id p15mr29151871jal.82.1637340622932;
 Fri, 19 Nov 2021 08:50:22 -0800 (PST)
MIME-Version: 1.0
References: <20211117224841.3442482-1-briannorris@chromium.org>
 <20211117144807.v2.1.I09b516eff75ead160a6582dd557e7e7e900c9e8e@changeid>
 <20211118123928.545dec8a@eldfell> <CAF6AEGuc9JbOsC4Lrvoqo8VzMHq+7ru7Y6_UwoZaGV2wHQ6E5g@mail.gmail.com>
 <20211119115419.505155b5@eldfell> <CAF6AEGus9CtgjvpJRX-YPkrrNeE+--9KeGxKBN_U=aOzzRE8FA@mail.gmail.com>
In-Reply-To: <CAF6AEGus9CtgjvpJRX-YPkrrNeE+--9KeGxKBN_U=aOzzRE8FA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 19 Nov 2021 08:50:10 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XARhZoj+0p-doxcbC=4K+NuMc=uR6wqG6kWk-MkPkNdQ@mail.gmail.com>
Message-ID: <CAD=FV=XARhZoj+0p-doxcbC=4K+NuMc=uR6wqG6kWk-MkPkNdQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/input_helper: Add new input-handling helper
To:     Rob Clark <robdclark@gmail.com>
Cc:     Pekka Paalanen <ppaalanen@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@linux.ie>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "Kristian H . Kristensen" <hoegsberg@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 19, 2021 at 8:39 AM Rob Clark <robdclark@gmail.com> wrote:
>
> On Fri, Nov 19, 2021 at 1:54 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> >
> > On Thu, 18 Nov 2021 15:30:38 -0800
> > Rob Clark <robdclark@gmail.com> wrote:
> >
> > > On Thu, Nov 18, 2021 at 2:39 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> > > >
> > > > On Wed, 17 Nov 2021 14:48:40 -0800
> > > > Brian Norris <briannorris@chromium.org> wrote:
> > > >
> > > > > A variety of applications have found it useful to listen to
> > > > > user-initiated input events to make decisions within a DRM driver, given
> > > > > that input events are often the first sign that we're going to start
> > > > > doing latency-sensitive activities:
> > > > >
> > > > >  * Panel self-refresh: software-directed self-refresh (e.g., with
> > > > >    Rockchip eDP) is especially latency sensitive. In some cases, it can
> > > > >    take 10s of milliseconds for a panel to exit self-refresh, which can
> > > > >    be noticeable. Rockchip RK3399 Chrome OS systems have always shipped
> > > > >    with an input_handler boost, that preemptively exits self-refresh
> > > > >    whenever there is input activity.
> > > > >
> > > > >  * GPU drivers: on GPU-accelerated desktop systems, we may need to
> > > > >    render new frames immediately after user activity. Powering up the
> > > > >    GPU can take enough time that it is worthwhile to start this process
> > > > >    as soon as there is input activity. Many Chrome OS systems also ship
> > > > >    with an input_handler boost that powers up the GPU.
> > > > >
> > > > > This patch provides a small helper library that abstracts some of the
> > > > > input-subsystem details around picking which devices to listen to, and
> > > > > some other boilerplate. This will be used in the next patch to implement
> > > > > the first bullet: preemptive exit for panel self-refresh.
> > > > >
> > > > > Bits of this are adapted from code the Android and/or Chrome OS kernels
> > > > > have been carrying for a while.
> > > > >
> > > > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > > > ---
> > > >
> > > > Thanks Simon for the CC.
> > > >
> > > > Hi Brian,
> > > >
> > > > while this feature in general makes sense and sounds good, to start
> > > > warming up display hardware early when something might start to happen,
> > > > this particular proposal has many problems from UAPI perspective (as it
> > > > has none). Comments below.
> > > >
> > > > Btw. if PSR is that slow to wake up from, how much do you actually gain
> > > > from this input event watching? I would imagine the improvement to not
> > > > be noticeable.
> > > >
> > > > I think some numbers about how much this feature helps would be really
> > > > good, even if they are quite specific use cases. You also need to
> > > > identify the userspace components, because I think different display
> > > > servers are very different in their reaction speed.
> > > >
> > > > If KMS gets a pageflip or modeset in no time after an input event, then
> > > > what's the gain. OTOH, if the display server is locking on to vblank,
> > > > there might be a delay worth avoiding. But then, is it worth
> > > > short-circuiting the wake-up in kernel vs. adding a new ioctl that
> > > > userspace could hit to start the warming up process?
> > >
> > > In my measurements, it takes userspace a frame or two to respond and
> > > get to the point of starting to build cmdstream (before eventually
> > > doing atomic/pageflip ioctl).. possibly longer if you don't also have
> > > a similar boost mechanism to spool up cpufreq
> > >
> > > But the important thing, IMO, is that atomic/pageflip ioctl is the
> > > cumulation of a long sequence of events.. input-boost is letting
> > > whatever it may be (PSR exit, GPU resume, etc) happen in parallel with
> > > that long sequence.
> >
> > Right, exactly. That is why I was musing about a *new* ioctl that
> > userspace could hit as soon as any input device fd (or network fd!)
> > shows signs of life. Would that be enough, avoiding all the annoying
> > questions about which input and DRM devices should participate here
> > (and what about non-input devices that still want to trigger the
> > warm-up, like network traffic, e.g. remote control?), or does it really
> > need to be kernel internal to be fast enough?
> >
> > As Brian wrote about his quick hack to test that via debugfs, sounds
> > like the userspace solution would be totally sufficient.
> >
>
> The question is, I think we want to use this for at least a couple
> different things.. PSR exit, and/or early GPU wakeup/boost.  So I'm
> not quite sure where/what this ioctl should be.  Different drivers may
> have different uses.  Also, because of the CrOS userspace sandbox
> architecture, the place that could do a kms ioctl isn't really the
> place that would know when to call the ioctl.
>
> But if we want to move the policy out of the kernel, one approach
> would just be to have some sysfs where userspace could configure the
> input_device_id[] filter..

While I'm fine with being overridden, in my mind:

1. Having a simple set of rules that works for "simple" devices that's
built-in to the kernel seems like a nice thing to have. Something like
what Brian has is pretty simple and works for a pretty wide variety of
devices. It's also not very much code nor all that complex.

2. IMO the answer for some of the more complex use cases is to allow
them to disable the simple in-kernel solution (we can debate about
Kconfig, sysfs, or ioctl) and control this with whatever complicated
logic they want to implement in userspace. If it were up to me, I
would make this as raw as possible. I wouldn't add optimizations to
make it easy for userspace to specify which input devices or anything,
I'd just let userspace figure out how to pay attention to the events
it cares about, make decisions, and then tell the kernel about it.

-Doug
