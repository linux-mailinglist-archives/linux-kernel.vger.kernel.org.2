Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9673827F8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbhEQJQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbhEQJOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:14:32 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D55C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:12:56 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id x15so5828197oic.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gfSGgq8Bw634jos2BhPIYD1MCiKr2MgkE0Xb4Qf8U2M=;
        b=VZAIk70QX6PShxHjY+RskDqCQ+sq+dfLgQxruSlP9A4jtbpZmS6QMo0MCd5599CT+x
         MA75Mk5rqZMKVmQjye41lzWVs5vf4YiPYQYJlWxmclZKKURgXnJccs+rODdJdwYDffC3
         l2uDzVge0MacxdZNpKFYQOwD8Sqa6YmtGY1XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfSGgq8Bw634jos2BhPIYD1MCiKr2MgkE0Xb4Qf8U2M=;
        b=eTlfwAts9T9J5GdC22gEkNyyH0Fkp7r/kPWlryfazqu5wopxQKNeV7K+64YDj469mM
         xGy1/3hlg7SW9Y/yOdo7FfhjSTdJA1nBl2ZcF4TywXs5arFcA2GbJlyWoAzG9BxvrBlC
         kz/4WqP3LaxG5+KkvZwPDHHxbgcp2eDaUK6lcv8+an65bNT0iEcpbVuvWURC468uwuAh
         eI3uoaOSMWDmWcljWd+sTLVF/pt07d6G6Qi0GV0ZTZjGk4LRH5NqjtckwLabjfe7gXWs
         uJhByToFypPjCf6VhmSbJQwXF5qCvlFYbAMDisFLvQC6k4W90BRu91aUqCyGMNlOZtQ0
         Z6/A==
X-Gm-Message-State: AOAM533svJZS+UQACehiD5AxbZKNW8Pqdf1rWItYCP/sxJ32eAPa+dVk
        SQqgizxqC8nQEyBXF4Zw1Zgt5O75HMS95BE+cvO6Xw==
X-Google-Smtp-Source: ABdhPJzA/Mbq6QuZJW7ON5tHEzjjR1Uqmvq7FwE+r5JmMAtM5hk52qJgoxuO8UGzC9OZmRdQUUpvXVwpqPi06KEa86o=
X-Received: by 2002:a54:4809:: with SMTP id j9mr14630807oij.14.1621242775675;
 Mon, 17 May 2021 02:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
 <YJ42MEgwDZrAEQLl@kroah.com> <CAK8P3a0pcBHfrwu9fHHRWim5WgQuCqpROpMM83yCCpjjwu1FJQ@mail.gmail.com>
 <YKIeBdwFb9Ng275X@phenom.ffwll.local> <YKIigHrwqp8zd036@kroah.com>
 <CAKMK7uEg2khb7wDzHTGEPwfbYe+T_5Av=_BTnt91CBW5U4yWvg@mail.gmail.com> <YKIvh9wbrOnd1yvj@kroah.com>
In-Reply-To: <YKIvh9wbrOnd1yvj@kroah.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 17 May 2021 11:12:44 +0200
Message-ID: <CAKMK7uFsQTjPfpgEFqyxnD1k-zoQHYbGH72Gmu7MML1qcFj0Kg@mail.gmail.com>
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

On Mon, May 17, 2021 at 10:55 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, May 17, 2021 at 10:49:09AM +0200, Daniel Vetter wrote:
> > On Mon, May 17, 2021 at 10:00 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, May 17, 2021 at 09:40:53AM +0200, Daniel Vetter wrote:
> > > > On Fri, May 14, 2021 at 11:00:38AM +0200, Arnd Bergmann wrote:
> > > > > On Fri, May 14, 2021 at 10:34 AM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > On Thu, May 13, 2021 at 01:00:26PM +0200, Maciej Kwapulinski wrote:
> > > > > > > Dear kernel maintainers,
> > > > > > >
> > > > > > > This submission is a kernel driver to support Intel(R) Gaussian & Neural
> > > > > > > Accelerator (Intel(R) GNA). Intel(R) GNA is a PCI-based neural co-processor
> > > > > > > available on multiple Intel platforms. AI developers and users can offload
> > > > > > > continuous inference workloads to an Intel(R) GNA device in order to free
> > > > > > > processor resources and save power. Noise reduction and speech recognition
> > > > > > > are the examples of the workloads Intel(R) GNA deals with while its usage
> > > > > > > is not limited to the two.
> > > > > >
> > > > > > How does this compare with the "nnpi" driver being proposed here:
> > > > > >         https://lore.kernel.org/r/20210513085725.45528-1-guy.zadicario@intel.com
> > > > > >
> > > > > > Please work with those developers to share code and userspace api and
> > > > > > tools.  Having the community review two totally different apis and
> > > > > > drivers for the same type of functionality from the same company is
> > > > > > totally wasteful of our time and energy.
> > > > >
> > > > > Agreed, but I think we should go further than this and work towards a
> > > > > subsystem across companies for machine learning and neural networks
> > > > > accelerators for both inferencing and training.
> > > >
> > > > We have, it's called drivers/gpu. Feel free to rename to drivers/xpu or
> > > > think G as in General, not Graphisc.
> > > >
> > > > > We have support for Intel habanalabs hardware in drivers/misc, and there are
> > > > > countless hardware solutions out of tree that would hopefully go the same
> > > > > way with an upstream submission and open source user space, including
> > > > >
> > > > > - Intel/Mobileye EyeQ
> > > > > - Intel/Movidius Keembay
> > > > > - Nvidia NVDLA
> > > > > - Gyrfalcon Lightspeeur
> > > > > - Apple Neural Engine
> > > > > - Google TPU
> > > > > - Arm Ethos
> > > > >
> > > > > plus many more that are somewhat less likely to gain fully open source
> > > > > driver stacks.
> > > >
> > > > We also had this entire discussion 2 years ago with habanalabs. The
> > > > hang-up is that drivers/gpu folks require fully open source userspace,
> > > > including compiler and anything else you need to actually use the chip.
> > > > Greg doesn't, he's happy if all he has is the runtime library with some
> > > > tests.
> >
> > I guess we're really going to beat this horse into pulp ... oh well.
> >
> > > All you need is a library, what you write on top of that is always
> > > application-specific, so how can I ask for "more"?
> >
> > This is like accepting a new cpu port, where all you require is that
> > the libc port is open source, but the cpu compiler is totally fine as
> > a blob (doable with llvm now being supported). It makes no sense at
> > all, at least to people who have worked with accelerators like this
> > before.
> >
> > We are not requiring that applications are open. We're only requiring
> > that at least one of the compilers you need (no need to open the fully
> > optimized one with all the magic sauce) to create any kind of
> > applications is open, because without that you can't use the device,
> > you can't analyze the stack, and you have no idea at all about what
> > exactly it is you're merging. With these devices, the uapi visible in
> > include/uapi is the smallest part of the interface exposed to
> > userspace.
>
> Ok, sorry, I was not aware that the habanalabs compiler was not
> available to all under an open source license.  All I was trying to
> enforce was that the library to use the kernel api was open so that
> anyone could use it.  Trying to enforce compiler requirements like this
> might feel to be a bit of a reach as the CPU on the hardware really
> doesn't fall under the license of the operating system running on this
> CPU over here :)

Experience says if you don't, forget about supporting your
drivers/subsystem long-term. At best you're stuck with a per-device
fragmented mess that vendors might or might not support. This has
nothing to do with GPL licensing or not, but about making sure you can
do proper engineering/support/review of the driver stack. At least in
the GPU world we're already making it rather clear that running blobby
userspace is fine with us (as long as it's using the exact same uapi
as the truly open stack, no exceptions/hacks/abuse are supported).

Also yes vendors don't like it. But they also don't like that they
have to open source their kernel drivers, or runtime library. Lots of
background chats over years, and a very clear line in the sand helps
to get there, and also makes sure that the vendors who got here don't
return to the old closed source ways they love so much.

Anyway we've had all this discussions 2 years ago, nothing has changed
(well on the gpu side we managed to get ARM officially on board with
fully open stack paid by them meanwhile, other discussions still
ongoing). I just wanted to re-iterate that if we'd really care about
having a proper accel subsystem, there's people who've been doing this
for decades.

-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
