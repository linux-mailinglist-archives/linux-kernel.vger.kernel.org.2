Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6C1311F0C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 18:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBFRJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 12:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBFRJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 12:09:03 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8921AC061786
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 09:08:22 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s3so13171429edi.7
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 09:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AgKjvYfEh6xpmyvNQMjRGgDLZsYQaTS+BFtps2bpJUw=;
        b=ThVvBbpSCDok5f64vDhprvEkK/m7fVXQdQpbbP4n/lz6Ig8IxNYWkLGoMyA37vrYzz
         gPs+IShTZe52N+faFtQ1JODauvpGwgLxImTmv7yg79QuBNu7LEtLrHE0LdCfKbHwT3J0
         +momjgdxgVTTZRK6q5rJPgcQMe2nHVExdw8vz6Z9byh6fN7vSjfoWolc1hJgZPSZLJBZ
         2Y7imnARDqana7qDnNwhqC6MfQk+BkwgtXmnjVXL2A+TvvTnsaAyWef61da89hmnchIA
         obdnq5A/aZfXYGOtNKGsl4P7NrQuybdVlNyM9x8IeWcFtSbzSAi3pRJv6X2540ZNiKNS
         n4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AgKjvYfEh6xpmyvNQMjRGgDLZsYQaTS+BFtps2bpJUw=;
        b=mFcmfa6OaD8CE6lJQK9N9ODfJHydL0etG+wc+QSyguo8t3qlqNBCWFY0pjmIf5go7p
         O8zzBqaCxSg8OdLhbtsPKMQ5WYOsfQine3poN1xEXTMg/mQ1CqTJvddJlgLWC9217UxJ
         WYi8AxePscuDseLRkW8fQw0RkSDLrgEvaKlFp2UUjvGUHd3WGX4dSCIB0A2qMxJPQgLi
         SQ9bAdlOgMpuvro2KDkBdbTkVzGZbI3oFsoPTKZrpyCNZXX5nDHnNfsPLJaqIP1ic3w7
         TtaFkjLVSvF13ED+BRO7abN568MC8V0AGBm7nwq+n0nys3ODUAg7pO9OFnQ5x+9U1vTZ
         y+/w==
X-Gm-Message-State: AOAM5335YcblKNBGHd23cVuDwuWFzYVLYbuPOvAhTRwdMPfK6aLbXmVB
        FvYz/WjLxx8Zbh3oW8pjkvzxnPZAYgjtQbZWzHI=
X-Google-Smtp-Source: ABdhPJx0FddPlepxSBE7r2noeRP3IBv5OhdVLMHl6lYWFCnitUzUkWX3j9z2mKYXmvrBBG7zi8nCjO91Lavw54JADQQ=
X-Received: by 2002:a05:6402:2053:: with SMTP id bc19mr8966375edb.230.1612631301186;
 Sat, 06 Feb 2021 09:08:21 -0800 (PST)
MIME-Version: 1.0
References: <71c4ce84-8be7-49e2-90bd-348762b320b4@nvidia.com>
 <YBzU5uUbwa+QIwBQ@google.com> <34110c61-9826-4cbe-8cd4-76f5e7612dbd@nvidia.com>
 <YBzkjh5nnuNiGb6Q@google.com> <f6e41e39-d60b-764d-0af4-8e6977663821@nvidia.com>
 <YB1vIrgI9S/5CDxL@google.com> <269689b7-3b6d-55dc-9044-fbf2984089ab@nvidia.com>
 <YB24YXMJOjwokDb5@google.com> <CAJuCfpEaQqgsyGtzRvovpuLOELR0iRNvNF0rnih1bq0HQCTuww@mail.gmail.com>
 <cbd30192-6f9f-845c-6b1c-e21ed737781d@nvidia.com> <YB3K9rx7E9qMf6Is@google.com>
In-Reply-To: <YB3K9rx7E9qMf6Is@google.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Sat, 6 Feb 2021 22:38:09 +0530
Message-ID: <CAOuPNLj9kKFFOS_56KkJ4w3jD51WOZ+d=nubcQQeihpk4B_-Ng@mail.gmail.com>
Subject: Re: [PATCH] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Dias <joaodias@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Feb 2021 at 04:17, Minchan Kim <minchan@kernel.org> wrote:
>
> On Fri, Feb 05, 2021 at 01:58:06PM -0800, John Hubbard wrote:
> > On 2/5/21 1:52 PM, Suren Baghdasaryan wrote:
> > > > > > I takes your suggestion something like this.
> > > > > >
> > > > > > [alloc_range] could be order or range by interval
> > > > > >
> > > > > > /sys/kernel/mm/cma/cma-A/[alloc_range]/success
> > > > > > /sys/kernel/mm/cma/cma-A/[alloc_range]/fail
> > > > > > ..
> > > > > > ..
> > > > > > /sys/kernel/mm/cma/cma-Z/[alloc_range]/success
> > > > > > /sys/kernel/mm/cma/cma-Z/[alloc_range]/fail
> > >
> > > The interface above seems to me the most useful actually, if by
> > > [alloc_range] you mean the different allocation orders. This would
> > > cover Minchan's per-CMA failure tracking and would also allow us to
> > > understand what kind of allocations are failing and therefore if the
> > > problem is caused by pinning/fragmentation or by over-utilization.
> > >
> >
> > I agree. That seems about right, now that we've established that
> > cma areas are a must-have.
>
> Okay, now we agreed the dirction right now so let me do that in next
> version. If you don't see it's reasonable, let me know.
>
> * I will drop the number of CMA *page* allocation attemtps/failures to
> make simple start
> * I will keep CMA allocation attemtps/failures
> * They will be under /sys/kernel/mm/cma/cma-XX/success,fail
> * It will turn on CONFIG_CMA && CONFIG_SYSFS
>
> Orthognal work(diffrent patchset)
>
> * adding global CMA alloc/fail into vmstat
> * adding alloc_range success/failure under CONFIG_CMA_ALLOC_TRACKING
>   whatever configuration or just by default if everyone agree
>

> # cat meminfo | grep -i cma
> CmaTotal:        1048576 kB
> CmaFree:         1046872 kB

This CMA info was added by me way back in 2014.
At that time I even thought about adding this cma alloc/fail counter in vmstat.
That time I also had an internal patch about it but later dropped
(never released to mainline).
If required I can re-work again on this part.

And I have few more points to add here.
1) In the past I have faced this cma allocation failure (which could
be common in small embedded devices).
Earlier it was even difficult to figure if cma failure actually happened.
Thus I added this simple patch:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.11-rc6&id=5984af1082f3b115082178ed88c47033d43b924d

2) IMO just reporting CMA alloc/fail may not be enough (at times). The
main point is for which client/dev is this failure happening ?
Sometimes just tuning the size or fixing the alignment can resolve the
failure if we know the client. For global CMA it will be just NULL
(dev).

3) IMO having 2 options SYSFS and DEBUGFS may confuse the
developer/user (personal experience). So are we going to remove the
DEBUGFS or merge it ?

4) Sometimes CMA (or DMA) allocation failure can happen even very
early in boot time itself. At that time these are anyways not useful.
Some system may not proceed if CMA/DMA allocation is failing (again
personal experience).
==> Anyways this is altogether is different case...

5) The default max CMA areas are defined to be 7 but user can
configure it to any number, may be 20 or 50 (???)

6) Thus I would like to propose another thing here.
Just like we have /proc/vmallocinfo, /proc/slabinfo, etc., we can also
have: /proc/cmainfo
Here in /proc/cmaminfo we can capute more detailed information:
Global CMA Data: Alloc/Free
Client specific data: name, size, success, fail, flags, align, etc
(just a random example).
==> This can dynamically grow as large as possible
==> It can also be enabled/disabled based on CMA config itself (no
additional config required)

Any feedback on point (6) specifically ?


Thanks,
Pintu
