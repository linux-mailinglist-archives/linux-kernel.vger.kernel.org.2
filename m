Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D0C419D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhI0Rxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237656AbhI0RxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:53:22 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEECAC061254
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 10:50:16 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id x2so20231550ilm.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 10:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JeXAWwMhuDPs2Ucq4IAy5MhKNcSmQryqivEVv2PvDCs=;
        b=s9ZJL5p5FYvRrjU9NT1lZZPz6433tvlK8E6ueAnEAOThH49SUqnJnUCD4/4ymIk0z7
         /KSaT37hlbdMTvwZLyBKLo6uKignRJDRewVGDXXHNWS3jtsYQF652+48uRExIm1iBWmh
         2bCq3xiX/P1HLK/A+Kp6UeUV7NTfBGKoploeSrFe57usKdF5euTy2CW05M1v7HxioKjt
         5YH/hDNBsKzGeXez/Gv8mVhPdChzaWf2HBwM82xejR7Ewaf1SvXGSjQmDHBAeHj4SxCe
         40m2LoVEGi786EsfZffrwumhN+ZwOl4iFct6oTS5JorDeffpsmmsT3NRPnz/mCDjin90
         M17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JeXAWwMhuDPs2Ucq4IAy5MhKNcSmQryqivEVv2PvDCs=;
        b=fkK3T4lbET7jqDvgfYUZ+jM4V1uZ6EuRpj8HcXS3kAsxJhNPpAYAFWv9C1cAUxUb1R
         HYfwmZKxrowbcCrSCCeIw7Y0y5hnycyMxLjazlW462oyuJYvyhtKPQKY1yVCn1GeHt/H
         +bbfY0QpXzTCwm62JJP+zJ61CXkIBHSEO982L2XfCFTQuueE5ETvTpD0jPijYdHwgvFR
         7zkQ93VWInveK8zY5Ney+lJKT/zRtS5N8SfzRz96nCMkrRmsuLYnNgJrFe5tRt5gS0bS
         lJSNWG3t8qnUtve9va5Qh7zGaIIoa/9+EiNpPQXKbF5YoOEV6UuQHNOSDnDKfUde8I4z
         vRdQ==
X-Gm-Message-State: AOAM530Vf0caOjhCeV4YOIUrRZBmhJMiZfOa1j/PZTeGOdlf+PL5rkk7
        L7jpvtKNQlWI5NIhXgienkNFFzVITB42o1sb27paDA==
X-Google-Smtp-Source: ABdhPJyrmCxobuoyAQvGwJsxAHPiuYGwrnui4qRSnu3bfn+xhA6+xuVdUEYs94sZCaLvn1luw3VU8VWthC/K2dtll1c=
X-Received: by 2002:a92:de07:: with SMTP id x7mr956128ilm.239.1632765015930;
 Mon, 27 Sep 2021 10:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210923232512.210092-1-peterx@redhat.com> <CAJHvVci8ig4WCY2aK-GvmHP=Uw3s8DrGahk-Yh37GX2kR35kww@mail.gmail.com>
 <YU4uJLJHsHLVsS2w@t490s> <YVIBCh+jrZABo3xS@t490s>
In-Reply-To: <YVIBCh+jrZABo3xS@t490s>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Mon, 27 Sep 2021 10:49:39 -0700
Message-ID: <CAJHvVcj976vz5xC=CzDQvVY7Yf8ZoDnt9jv_SwPtUKs_1LjATA@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: selftests: Fix memory corruption with thp enabled
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>, Li Wang <liwan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 10:36 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Sep 24, 2021 at 03:59:32PM -0400, Peter Xu wrote:
> > On Fri, Sep 24, 2021 at 10:21:30AM -0700, Axel Rasmussen wrote:
> > > On Thu, Sep 23, 2021 at 4:25 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > In RHEL's gating selftests we've encountered memory corruption in the uffd
> > > > event test even with upstream kernel:
> > > >
> > > >         # ./userfaultfd anon 128 4
> > > >         nr_pages: 32768, nr_pages_per_cpu: 32768
> > > >         bounces: 3, mode: rnd racing read, userfaults: 6240 missing (6240) 14729 wp (14729)
> > > >         bounces: 2, mode: racing read, userfaults: 1444 missing (1444) 28877 wp (28877)
> > > >         bounces: 1, mode: rnd read, userfaults: 6055 missing (6055) 14699 wp (14699)
> > > >         bounces: 0, mode: read, userfaults: 82 missing (82) 25196 wp (25196)
> > > >         testing uffd-wp with pagemap (pgsize=4096): done
> > > >         testing uffd-wp with pagemap (pgsize=2097152): done
> > > >         testing events (fork, remap, remove): ERROR: nr 32427 memory corruption 0 1 (errno=0, line=963)
> > > >         ERROR: faulting process failed (errno=0, line=1117)
> > > >
> > > > It can be easily reproduced when global thp enabled, which is the default for
> > > > RHEL.
> > > >
> > > > It's also known as a side effect of commit 0db282ba2c12 ("selftest: use mmap
> > > > instead of posix_memalign to allocate memory", 2021-07-23), which is imho right
> > > > itself on using mmap() to make sure the addresses will be untagged even on arm.
> > > >
> > > > The problem is, for each test we allocate buffers using two allocate_area()
> > > > calls.  We assumed these two buffers won't affect each other, however they
> > > > could, because mmap() could have found that the two buffers are near each other
> > > > and having the same VMA flags, so they got merged into one VMA.
> > > >
> > > > It won't be a big problem if thp is not enabled, but when thp is agressively
> > > > enabled it means when initializing the src buffer it could accidentally setup
> > > > part of the dest buffer too when there's a shared THP that overlaps the two
> > > > regions.  Then some of the dest buffer won't be able to be trapped by
> > > > userfaultfd missing mode, then it'll cause memory corruption as described.
> > > >
> > > > To fix it, do release_pages() after initializing the src buffer.
> > >
> > > But, if I understand correctly, release_pages() will just free the
> > > physical pages, but not touch the VMA(s). So, with the right
> > > max_ptes_none setting, why couldn't khugepaged just decide to
> > > re-collapse (with zero pages) immediately after we release the pages,
> > > causing the same problem? It seems to me this change just
> > > significantly narrows the race window (which explains why we see less
> > > of the issue), but doesn't fix it fundamentally.
> >
> > Did you mean you can reproduce the issue even with this patch?
> >
> > It is a good point anyway, indeed I don't see anything stops it from happening.
> >
> > I wanted to prepare a v2 by releasing the pages after uffdio registration where
> > we'll do the vma split, but it won't simply work because release_pages() will
> > cause the process to hang death since that test registers with EVENT_REMOVE,
> > and release_pages() upon the thp will trigger synchronous EVENT_REMOVE which
> > cannot be handled by anyone.
> >
> > Another solution is to map some PROT_NONE regions between the buffers, to make
> > sure they won't share a VMA.  I'll need to think more about which is better..
>
> Axel, let me know if you can reproduce an issue with this patch, or otherwise
> would you mind we keep this patch in -mm and fix the issue first?  I can never
> reproduce any issue with current patch even if I agree you're probably right,
> however before the patch is mostly 100% reproducable to fail.

Totally fair, if nothing else the patch at least makes it a lot
better. :) Keeping it in the mm tree or even merging it seems fine to
me, we can continue iterating later.

One small comment:

I'd prefer to keep the "uffd_test_ops->release_pages(area_src);"
above, to ensure the src region is empty. It's not immediately obvious
to me that we overwrite *all* of the bytes in src when we initialize
it. (I'd have to go look at the definition of area_count and read the
loop carefully.) It may not be technically needed, but it makes the
guarantee that we're starting with a clean slate, free from any
changes from previous test cases, very clear + explicit.

Moving the release_pages(area_dst) down as you've done seems correct to me.

Either way you can take:

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

>
> It's just that after the weekend when I look back I still don't see a 100%
> clean way to fix it yet.  Mapping 4K PROT_NONE before/after each allocation is
> the most ideal but still looks tricky to me.
>
> Would you have time on looking for a better solution, so as to (see it a way
> to) complete what commit 8ba6e8640844 whats to do afterwards?

Sure, it seems related to the other THP investigations we talked about
in the other thread, so I'm happy to look into it.

Just to set expectations, progress may be slightly slow as I'm
balancing other work my employer wants done, and some upcoming time
off. But, I think with your patch the test is at least stable (not
flaky) enough that there is no *urgent* need for this, so it should be
fine.

>
> Thanks,
>
> --
> Peter Xu
>
