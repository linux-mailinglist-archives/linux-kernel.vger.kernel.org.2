Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84113863CE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbhEQUBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbhEQUBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:01:43 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF0AC061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:00:26 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso6612236otg.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xtjdje62yD9oW3HEgHTuDl9DmMypEy/sRMCMoiLlyK8=;
        b=OzwnYrKYMaYFJamVY9o+1JtKgZTcpEFZ0w19j8y+zZR+QadYHkx37rbQAFSiq+sImx
         738pbcMQFtnVAsl7XPerLkJAIXvYQIhewaFsSrnFCJ03BJZ8A0zrkDW819tpu+IpPT78
         F0zglpq/SMPZM6qmf9X5F5DT0jyavkonPiySA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xtjdje62yD9oW3HEgHTuDl9DmMypEy/sRMCMoiLlyK8=;
        b=DEuIygB5+EPV02PZ+cFRGFXlPvxFcXiXH3rS+FFXQJdKkXrjU3rEK2fe47zR6+ZEh+
         cGg9lGICVVMAsBQ6mRTvzUh1otp6VlMYtVM/qYbQn06PrqSPW6Rgt/hlxjRFGpxGbf2i
         Cq1se7CFPNZOQN5ddQWyElZyky8J97yiZpJvaEug3N/Fb9lUCODvPFFW+BEIWBAuAgUz
         lpMXrcFQDMl2YnS4EZ2eTPQgoAlJf4+891jjF8D8IDasJKl6sDDsYS0hOWYe8R5EVpwV
         qrrMn97mobqnv/MXj35ud4O2RluRtS+dkPezhdZRUcQR2lq4OB3paL189P7Rdp9SlrRj
         rMyw==
X-Gm-Message-State: AOAM5337DKK8qVYV9+jWXYmj+Fqk/oKTw1FGi5R+ToZVZe1BKYGBTP/i
        V+7sGhbo6Vr13bloPsVS3y8o5JMnosf1Qp+hxoJtYA==
X-Google-Smtp-Source: ABdhPJzSRhLB+ZsKjK7Y9NOTBW/MdZUTUaNuuD/r7tN8j0vZd8wXbTlo3vlPKi44cglUPOYryfXV4DRE6LUN0LHgJ38=
X-Received: by 2002:a9d:4101:: with SMTP id o1mr1056732ote.281.1621281625633;
 Mon, 17 May 2021 13:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
 <YJ42MEgwDZrAEQLl@kroah.com> <CAK8P3a0pcBHfrwu9fHHRWim5WgQuCqpROpMM83yCCpjjwu1FJQ@mail.gmail.com>
 <YKIeBdwFb9Ng275X@phenom.ffwll.local> <503d101d-7273-757a-2809-e272db93c45d@suse.de>
 <CADnq5_NR+ysqmx6ftakGTjqjw0p6roiupa3sYTN8NuAMoGa6sQ@mail.gmail.com> <3aac3e39-4889-22dc-83dc-72fff63cb3d0@suse.de>
In-Reply-To: <3aac3e39-4889-22dc-83dc-72fff63cb3d0@suse.de>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 17 May 2021 22:00:14 +0200
Message-ID: <CAKMK7uFyTM9NQzhtOv-ABemYThLE2CnA=OYRiJwe7YwgotfLPA@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Driver of Intel(R) Gaussian & Neural Accelerator
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 9:49 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 17.05.21 um 21:23 schrieb Alex Deucher:
> > On Mon, May 17, 2021 at 3:12 PM Thomas Zimmermann <tzimmermann@suse.de>
> wrote:
> >>
> >> Hi
> >>
> >> Am 17.05.21 um 09:40 schrieb Daniel Vetter:
> >>> On Fri, May 14, 2021 at 11:00:38AM +0200, Arnd Bergmann wrote:
> >>>> On Fri, May 14, 2021 at 10:34 AM Greg Kroah-Hartman
> >>>> <gregkh@linuxfoundation.org> wrote:
> >>>>> On Thu, May 13, 2021 at 01:00:26PM +0200, Maciej Kwapulinski wrote:
> >>>>>> Dear kernel maintainers,
> >>>>>>
> >>>>>> This submission is a kernel driver to support Intel(R) Gaussian & Neural
> >>>>>> Accelerator (Intel(R) GNA). Intel(R) GNA is a PCI-based neural co-processor
> >>>>>> available on multiple Intel platforms. AI developers and users can
> offload
> >>>>>> continuous inference workloads to an Intel(R) GNA device in order to
> >> free
> >>>>>> processor resources and save power. Noise reduction and speech recognition
> >>>>>> are the examples of the workloads Intel(R) GNA deals with while its usage
> >>>>>> is not limited to the two.
> >>>>>
> >>>>> How does this compare with the "nnpi" driver being proposed here:
> >>>>>           https://lore.kernel.org/r/20210513085725.45528-1-guy.zadicario@intel.com
> >>>>>
> >>>>> Please work with those developers to share code and userspace api and
> >>>>> tools.  Having the community review two totally different apis and
> >>>>> drivers for the same type of functionality from the same company is
> >>>>> totally wasteful of our time and energy.
> >>>>
> >>>> Agreed, but I think we should go further than this and work towards a
> >>>> subsystem across companies for machine learning and neural networks
> >>>> accelerators for both inferencing and training.
> >>>
> >>> We have, it's called drivers/gpu. Feel free to rename to drivers/xpu or
> >>> think G as in General, not Graphisc.
> >>
> >> I hope this was a joke.
> >>
> >> Just some thoughts:
> >>
> >> AFAICT AI first came as an application of GPUs, but has now
> >> evolved/specialized into something of its own. I can imagine sharing
> >> some code among the various subsystems, say GEM/TTM internals for memory
> >> management. Besides that there's probably little that can be shared in
> >> the userspace interfaces. A GPU is device that puts an image onto the
> >> screen and an AI accelerator isn't. Treating both as the same, even if
> >> they share similar chip architectures, seems like a stretch. They might
> >> evolve in different directions and fit less and less under the same
> >> umbrella.
> >
> > The putting something on the screen is just a tiny part of what GPUs
> > do these days.  Many GPUs don't even have display hardware anymore.
> > Even with drawing APIs, it's just some operation that you do with
> > memory.  The display may be another device entirely.  GPUs also do
> > video encode and decode, jpeg acceleration, etc.  drivers/gpu seems
> > like a logical place to me.  Call it drivers/accelerators if you like.
> > Other than modesetting most of the shared infrastructure in
> > drivers/gpu is around memory management and synchronization which are
> > all the hard parts.  Better to try and share that than to reinvent
> > that in some other subsystem.
>
> I'm not sure whether we're on the same page or not.
>
> I look at this from the UAPI perspective: the only interfaces that we
> really standardize among GPUs is modesetting, dumb buffers, GEM. The
> sophisticated rendering is done with per-driver interfaces. And
> modesetting is the thing that AI does not do.

Yeah, but the peole who know what should be standardized and what
should not be standardized for accel drivers are here. Because we've
done both models in the past, and pretty much everything in between.

Also like Daniel said, we support hw (and know how to drive it) for
anything from "kernel bashes register values" (gpus worked like that
20 years ago) to "mostly direct userspace submit (amdkfd and parts of
nouveau work like this).

There isn't any other subsystem with that much knowledge about how to
stand up the entire accelerator stack and not making it suck too
badly. That is the real value of dri-devel and the community we have
here, not the code sharing we occasionally tend to do.

> Sharing common code among subsystems is not a problem. Many of our
> more-sophisticated helpers are located in DRM because no other
> subsystems have the requirements yet. Maybe AI now has and we can move
> the rsp shareable code to a common location. But AI is still no GPU. To
> give a bad analogy: GPUs transmit audio these days. Yet we don't treat
> them as sound cards.

We actually do, there are full blown sound drivers for them over in
sound/ (ok I think they're all in sound/hda for pci gpus or in
sound/soc actually). There's some glue to tie it together because it
requires coordination between the gpu and sound side of things, but
that's it.

Also I think it would be extremely silly to remove all the drm_ stuff
just because it's originated from GPUs, and therefore absolutely
cannot be used by other accelarators. I'm not seeing the point in
that, but if someone has convincing technical argument for this we
could do it. A tree wide s/drm_/xpu_ might make some sense perhaps if
that makes people more comfortable with the idea of reusing code from
gpu origins for accelerators in general.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
