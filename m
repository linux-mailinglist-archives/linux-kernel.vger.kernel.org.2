Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB000382778
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbhEQIum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbhEQIug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:50:36 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFAFC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:49:20 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so4918233otc.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EnT5zPP6tdK7KNtej1vtHjp/uSJMK556tLchSIAqikM=;
        b=Sq53JhE7KMBm0UPwLM+rHrr+JZARZREBqCPBEm8dSK6Ims+ND5f9GWoygNUQsu7fmO
         p0XFDXBZJvaWIqpQGDWJNgHg9b0xNc5ur0nSfcxMXBHoj1iMYR4k5wNMnroT3cl2P0w6
         3gMM3izZyREKSjIyLtfft5A5VPdMEivqOYX68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EnT5zPP6tdK7KNtej1vtHjp/uSJMK556tLchSIAqikM=;
        b=ZoIwFV3Pom+iR4yQmHN5uNQnyIubuAxoSTdLg8JM/u/NXfNkj7cEyeyw2acrK2ME0E
         kj1GxV2Kvt8PE8vQYlzG7CdaEqwxcNXSoK1Mt/ZHkmTUsk66pizBIQfBz1uSFnNf1xON
         ABKz3GXWw03kgjTOzYCyC5VeC/hfAllDtqGA7QN8eteOYU73xRDnKjw6DCKJ+ZvI/VHw
         qq/VGVJRT0Mb/LkFJzRGzZeIV24xtnWjfKJMrc2uB/uDMzGMfzcHA2+oDOiTlSz6hs0i
         391ouJgP2uuQatGNVXKdnqjOIUECjGpGHfOvCADtnadJfreAnrF/yg5K/99keBbGbjSo
         ARlg==
X-Gm-Message-State: AOAM533dvRW0HfRl7TZwOtfR8tM630LNNTsocS4fD6EyuUV0DO5XekDU
        IGK9GP9hhhpS/yI4MJ1Ecr67T9p5jOfIQOWEdlKmCw==
X-Google-Smtp-Source: ABdhPJxc9pYlbCYwIxhWot8DMVsHS/tn8pjsxaxDWm52qe4op+KGVrxVWtIyueOlpx2VvTelwYRceN40ohGZ3IzBopw=
X-Received: by 2002:a9d:4101:: with SMTP id o1mr12094671ote.281.1621241360211;
 Mon, 17 May 2021 01:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
 <YJ42MEgwDZrAEQLl@kroah.com> <CAK8P3a0pcBHfrwu9fHHRWim5WgQuCqpROpMM83yCCpjjwu1FJQ@mail.gmail.com>
 <YKIeBdwFb9Ng275X@phenom.ffwll.local> <YKIigHrwqp8zd036@kroah.com>
In-Reply-To: <YKIigHrwqp8zd036@kroah.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 17 May 2021 10:49:09 +0200
Message-ID: <CAKMK7uEg2khb7wDzHTGEPwfbYe+T_5Av=_BTnt91CBW5U4yWvg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Driver of Intel(R) Gaussian & Neural Accelerator
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dave Airlie <airlied@gmail.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 10:00 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, May 17, 2021 at 09:40:53AM +0200, Daniel Vetter wrote:
> > On Fri, May 14, 2021 at 11:00:38AM +0200, Arnd Bergmann wrote:
> > > On Fri, May 14, 2021 at 10:34 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > On Thu, May 13, 2021 at 01:00:26PM +0200, Maciej Kwapulinski wrote:
> > > > > Dear kernel maintainers,
> > > > >
> > > > > This submission is a kernel driver to support Intel(R) Gaussian & Neural
> > > > > Accelerator (Intel(R) GNA). Intel(R) GNA is a PCI-based neural co-processor
> > > > > available on multiple Intel platforms. AI developers and users can offload
> > > > > continuous inference workloads to an Intel(R) GNA device in order to free
> > > > > processor resources and save power. Noise reduction and speech recognition
> > > > > are the examples of the workloads Intel(R) GNA deals with while its usage
> > > > > is not limited to the two.
> > > >
> > > > How does this compare with the "nnpi" driver being proposed here:
> > > >         https://lore.kernel.org/r/20210513085725.45528-1-guy.zadicario@intel.com
> > > >
> > > > Please work with those developers to share code and userspace api and
> > > > tools.  Having the community review two totally different apis and
> > > > drivers for the same type of functionality from the same company is
> > > > totally wasteful of our time and energy.
> > >
> > > Agreed, but I think we should go further than this and work towards a
> > > subsystem across companies for machine learning and neural networks
> > > accelerators for both inferencing and training.
> >
> > We have, it's called drivers/gpu. Feel free to rename to drivers/xpu or
> > think G as in General, not Graphisc.
> >
> > > We have support for Intel habanalabs hardware in drivers/misc, and there are
> > > countless hardware solutions out of tree that would hopefully go the same
> > > way with an upstream submission and open source user space, including
> > >
> > > - Intel/Mobileye EyeQ
> > > - Intel/Movidius Keembay
> > > - Nvidia NVDLA
> > > - Gyrfalcon Lightspeeur
> > > - Apple Neural Engine
> > > - Google TPU
> > > - Arm Ethos
> > >
> > > plus many more that are somewhat less likely to gain fully open source
> > > driver stacks.
> >
> > We also had this entire discussion 2 years ago with habanalabs. The
> > hang-up is that drivers/gpu folks require fully open source userspace,
> > including compiler and anything else you need to actually use the chip.
> > Greg doesn't, he's happy if all he has is the runtime library with some
> > tests.

I guess we're really going to beat this horse into pulp ... oh well.

> All you need is a library, what you write on top of that is always
> application-specific, so how can I ask for "more"?

This is like accepting a new cpu port, where all you require is that
the libc port is open source, but the cpu compiler is totally fine as
a blob (doable with llvm now being supported). It makes no sense at
all, at least to people who have worked with accelerators like this
before.

We are not requiring that applications are open. We're only requiring
that at least one of the compilers you need (no need to open the fully
optimized one with all the magic sauce) to create any kind of
applications is open, because without that you can't use the device,
you can't analyze the stack, and you have no idea at all about what
exactly it is you're merging. With these devices, the uapi visible in
include/uapi is the smallest part of the interface exposed to
userspace.

> > These two drivers here look a lot more like classic gpus than habanalabs
> > did, at least from a quick look they operate with explicit buffer
> > allocations/registration model. So even more reasons to just reuse all the
> > stuff we have already. But also I don't expect these drivers here to come
> > with open compilers, they never do, not initially at least before you
> > started talking with the vendor. Hence I expect there'll be more
> > drivers/totally-not-drm acceleration subsystem nonsense.
>
> As these are both from Intel, why aren't they using the same open
> compiler?  Why aren't they using the same userspace api as well?  What's
> preventing them from talking to each other about this and not forcing
> the community (i.e. outsiders) from being the one to force this to
> happen?

I'm unfortuantely not the CEO of this company. Also you're the one who
keeps accepting drivers that the accel folks (aka dri-devel community)
said shouldn't be merged, so my internal bargaining power is zero to
force something reaonable here. So please don't blame me for this
mess, this is yours entirely.

> > Anyway this horse has been throughroughly beaten to death and more, the
> > agreement is that accel drivers in drivers/misc must not use any gpu
> > stuff, so that drivers/gpu people dont end up in a prickly situation they
> > never signed up for. E.g. I removed some code sharing from habanalabs.
> > This means interop between gpu and nn/ai drivers will be no-go until this
> > is resolved, but *shrug*.
>
> I'm all for making this unified, but these are not really devices doing
> graphics so putting it all into DRM always feels wrong to me.  The fact
> that people abuse GPU devices for not graphic usages would indicate to
> me that that code should be moving _out_ of the drm subsystem :)

Like I said, if the 'g' really annoys you that much, feel free to send
in a patch to rename drivers/gpu to drivers/xpu.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
