Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E63438B875
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 22:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbhETUfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 16:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbhETUfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 16:35:08 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5EDC061574;
        Thu, 20 May 2021 13:33:45 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id c10so5388147lfm.0;
        Thu, 20 May 2021 13:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LzD1HrIfiwtnehS+rQoZFJPwLpfj/VvtbDQSX02ISsw=;
        b=MvR/gkMg1i1UwAUlVJTujLc/umC5HKnXQG477F6seHo8q3NDsNsmYOGU4D7iyBeObs
         nvf85Ig7ZCihfTbZ80/VKkLgob+Xc64AL4ZT9TMp/1BKcYMlJs3gDfOnp9WQM+eQtLqb
         4TtJRfHo4rO6l+yISAKWPDNnwzllvKstVVFCHONt0x3PaKyKxDOJ5Sj8rl1g2tfeTFMl
         uP5S2gIvXlPjOVpvphSPfhGiR1ksTF5rtnxH591Tu8A02rCBMK26MvBXh8rN2CiQxJi2
         1j/Fkl/Tt0qShWrdfvbDaKsHLlQh8izFTaxMhHHwOWQd1GeO8Vrqn/tZytEIwEukn9fK
         e7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LzD1HrIfiwtnehS+rQoZFJPwLpfj/VvtbDQSX02ISsw=;
        b=Q4wwnRFEN6QrXTl545VCL80UzjSzCaeZ9uM/Yum805c8LY8aSH6IYHc7E2QOtRgahi
         pbboobW3RaRrIp+wbPNjRLUxSwWTm3/6RaM7cIqVIBdpvrXC3NpPqLMrN7KPzxax9oCX
         5aKhji/irqNx1Z/D23ANF1WCqjUNu9WAadhE1vkLuT65HwvPo8mwtW/r4r1XB7levGLD
         MqBGZyUdyp1aXlYQVlytSYEJsheOJVFnsSoEj2o3+Xsdfh/RgLnYOYCaKkvJKW9rPF6Z
         nJ/uEP0oxfCPXVDMyM4d5XuUyER9eDUfl92yvW+s1/m8kvUUAIi/fZtqjtKjZ34CB7+v
         yR2g==
X-Gm-Message-State: AOAM5306d/3G4LnD/7iaDI8wY0+Kn3Ix4v0boqajJpgz2WQfzfssBxBF
        xFD/b3BFB4pJFOF2C1acXikwr6BlySu1bQD+z/Xdi8VKnicTfQ==
X-Google-Smtp-Source: ABdhPJxA5+TC34jrRmy0MZ1oXkKDJ2F+bHSpymYqwwDKkV3Cfyr2gLDDQ5O9WJrqT3+cojGPknl7FqVHh3my0iIfp44=
X-Received: by 2002:a19:7f10:: with SMTP id a16mr4516238lfd.238.1621542823454;
 Thu, 20 May 2021 13:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210515132348.19082-1-dwaipayanray1@gmail.com> <87k0ntnoyq.fsf@meer.lwn.net>
In-Reply-To: <87k0ntnoyq.fsf@meer.lwn.net>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Fri, 21 May 2021 02:03:31 +0530
Message-ID: <CABJPP5D=Z6Uwr5hihB1yHjxcww=QO8Ju46m1eruRTuJkKWDXpw@mail.gmail.com>
Subject: Re: [PATCH] docs: Add more message type documentations for checkpatch
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Adding Joe for comments)

On Fri, May 21, 2021 at 1:43 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Dwaipayan Ray <dwaipayanray1@gmail.com> writes:
>
> > - Document a couple of more checkpatch message types.
> > - Add a blank line before all `See:` lines to improve the
> >   rst output.
> > - Create a new subsection `Permissions` and move a few types
> >   to it.
> >
> > Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> > ---
> >  Documentation/dev-tools/checkpatch.rst | 170 ++++++++++++++++++++++++-
> >  1 file changed, 163 insertions(+), 7 deletions(-)
>
> So this seems good, but I just notice something that has evidently
> escaped me until now...
>
> > diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> > index 51fed1bd72ec..e409f27f48b6 100644
> > --- a/Documentation/dev-tools/checkpatch.rst
> > +++ b/Documentation/dev-tools/checkpatch.rst
> > @@ -246,6 +246,7 @@ Allocation style
> >      The first argument for kcalloc or kmalloc_array should be the
> >      number of elements.  sizeof() as the first argument is generally
> >      wrong.
> > +
> >      See: https://www.kernel.org/doc/html/latest/core-api/memory-allocation.html
> >
> >    **ALLOC_SIZEOF_STRUCT**
> > @@ -264,6 +265,7 @@ Allocation style
> >    **ALLOC_WITH_MULTIPLY**
> >      Prefer kmalloc_array/kcalloc over kmalloc/kzalloc with a
> >      sizeof multiply.
> > +
> >      See: https://www.kernel.org/doc/html/latest/core-api/memory-allocation.html
> >
> >
> > @@ -284,6 +286,7 @@ API usage
> >      BUG() or BUG_ON() should be avoided totally.
> >      Use WARN() and WARN_ON() instead, and handle the "impossible"
> >      error condition as gracefully as possible.
> > +
> >      See: https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on
> >
> >    **CONSIDER_KSTRTO**
> > @@ -292,12 +295,23 @@ API usage
> >      may lead to unexpected results in callers.  The respective kstrtol(),
> >      kstrtoll(), kstrtoul(), and kstrtoull() functions tend to be the
> >      correct replacements.
> > +
> >      See: https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull
> >
> > +  **IN_ATOMIC**
> > +    in_atomic() is not for driver use so any such use is reported as an ERROR.
> > +    Also in_atomic() is often used to determine if we may sleep, but it is not
> > +    reliable in this use model therefore its use is strongly discouraged.
> > +
> > +    However, in_atomic() is ok for core kernel use.
> > +
> > +    See: https://lore.kernel.org/lkml/20080320201723.b87b3732.akpm@linux-foundation.org/
> > +
> >    **LOCKDEP**
> >      The lockdep_no_validate class was added as a temporary measure to
> >      prevent warnings on conversion of device->sem to device->mutex.
> >      It should not be used for any other purpose.
> > +
> >      See: https://lore.kernel.org/lkml/1268959062.9440.467.camel@laptop/
> >
> >    **MALFORMED_INCLUDE**
> > @@ -308,11 +322,18 @@ API usage
> >    **USE_LOCKDEP**
> >      lockdep_assert_held() annotations should be preferred over
> >      assertions based on spin_is_locked()
> > +
> >      See: https://www.kernel.org/doc/html/latest/locking/lockdep-design.html#annotations
> >
> >    **UAPI_INCLUDE**
> >      No #include statements in include/uapi should use a uapi/ path.
> >
> > +  **USLEEP_RANGE**
> > +    usleep_range() should be preferred over udelay(). The proper way of
> > +    using usleep_range() is mentioned in the kernel docs.
> > +
> > +    See: https://www.kernel.org/doc/html/latest/timers/timers-howto.html#delays-information-on-the-various-kernel-delay-sleep-mechanisms
>
> We really shouldn't be linking to outside sites - even kernel.org - when
> referring to the kernel docs themselves.  Just say
> "Documentation/timers/timers-howto" and let the build system handle the
> links.
>
> There's a lot of these in this file, alas...
>
> I've applied this patch since it makes things better overall, but I
> would really like to see all those URLs go away if possible.
>

Thanks Jonathan.

Yes it might make things better for the documentation, but again
since we are using these descriptions in checkpatch's --verbose mode,
we shall lose the ability to show the links there which I think is currently
a good addition for the end user.

And I don't think there will be a way to generate these links in checkpatch
without sphinx's build system....

Are there any alternatives?

Also Joe, any comments here?

Thanks,
Dwaipayan.

> Thanks,
>
> jon
