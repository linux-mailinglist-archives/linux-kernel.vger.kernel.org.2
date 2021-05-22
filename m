Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2522938D788
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 23:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhEVVeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 17:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhEVVeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 17:34:18 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6059FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 14:32:52 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t11so12766255pjm.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 14:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KtBEuGQ1o7oVCLGDY9TPaDyiL0J04eVGf33YaGC2H4c=;
        b=QpxcOhwyLU3cySR/6dwTjMBmh/ncAxaELXXs4697zfQSCiLtLDWwYLBxMKDO2lxDbu
         FwrznFgtIgHPJBDfRR+zekC1BKJ+wgjLoa/rsW+y80aqI+6xUbDd+xi3Ce+O/DEF3e7j
         BOS+w+4mqTfHuO81r+OzT5LoGYV1YpZf1fjTLNfZnlir10MS6WHUtkOUWXPm4Uj/Bi7k
         E5usSst4w4y5m6TDe2iBHTvhfiqPxUUdJhy1gl72Hmg8W1grH5hMsZlVjJk/5/yJTz4c
         DVjAdu8E81Z7y4cGjSVJInK7Rq8Gt19zMYV0jfvyFhipXLBtUu9nQ6nBXuuQbn6A4Ep/
         RWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KtBEuGQ1o7oVCLGDY9TPaDyiL0J04eVGf33YaGC2H4c=;
        b=VyRyYYDILBMK3znx1nU1iSfzFvbIRItf4938zt+Dp/6lKxqpL5JZSzvr8OadSXcLcg
         tN7YAVgTwQrPkshX07lLG6A5anDVQi6lHbtXBomaralPMKe8/fNqY0Gu8shr3GwTp6T3
         lo6HI+55LgO2DoWYbsk9gsi0/+nLnq+D0W0iiO8DGv6jRunuSBrUMofWllHctYfX6Fg9
         rNRi191Fb3AhiAEzUMFSzx4pkFi+7TNynqX2LUq1D9bQBB/Acqq04jqdpjJs/m6b1d6C
         v7ldQ0tN0bKsdzau9Wy4os7fMIWmfTRhLZDOI3RYbVLuYUqhpb4+DNPfUdNRjWAqtyoM
         KyWg==
X-Gm-Message-State: AOAM533QdoPaBMIf+PSWz9mwG4xh7049X5Rrkh/DpsN8yfBsKjsUfN/S
        uCsTq+hDCLa39foaAFk53abY25WVxZAC2gZBh/xsFg==
X-Google-Smtp-Source: ABdhPJwBqNS+yuo0Duaw7TB2yGMxtuVm7HwdJ5HsTDOQazp4ES5K37sJrUJ9pN3lz5Ez/c6nyGHKuOtt8etPjVQGLuQ=
X-Received: by 2002:a17:90a:1a:: with SMTP id 26mr17243668pja.187.1621719171771;
 Sat, 22 May 2021 14:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210521074433.931380-1-almasrymina@google.com> <20210522141946.f8a62010350a76302b9508fb@linux-foundation.org>
In-Reply-To: <20210522141946.f8a62010350a76302b9508fb@linux-foundation.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Sat, 22 May 2021 14:32:40 -0700
Message-ID: <CAHS8izOV9s-A+DwRyt7V2Q_4N3nv3tRVe1W=Bii8ve-uQEQcXQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm, hugetlb: fix resv_huge_pages underflow on UFFDIO_COPY
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 2:19 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 21 May 2021 00:44:33 -0700 Mina Almasry <almasrymina@google.com> wrote:
>
> > The userfaultfd hugetlb tests detect a resv_huge_pages underflow. This
> > happens when hugetlb_mcopy_atomic_pte() is called with !is_continue on
> > an index for which we already have a page in the cache. When this
> > happens, we allocate a second page, double consuming the reservation,
> > and then fail to insert the page into the cache and return -EEXIST.
> >
> > To fix this, we first if there exists a page in the cache which already
>
>                        ^ check
>
> > consumed the reservation, and return -EEXIST immediately if so.
> >
> > Secondly, if we fail to copy the page contents while holding the
> > hugetlb_fault_mutex, we will drop the mutex and return to the caller
> > after allocating a page that consumed a reservation. In this case there
> > may be a fault that double consumes the reservation. To handle this, we
> > free the allocated page, fix the reservations, and allocate a temporary
> > hugetlb page and return that to the caller. When the caller does the
> > copy outside of the lock, we again check the cache, and allocate a page
> > consuming the reservation, and copy over the contents.
> >
> > Test:
> > Hacked the code locally such that resv_huge_pages underflows produce
> > a warning and the copy_huge_page_from_user() always fails, then:
> >
> > ./tools/testing/selftests/vm/userfaultfd hugetlb_shared 10
> >       2 /tmp/kokonut_test/huge/userfaultfd_test && echo test success
> > ./tools/testing/selftests/vm/userfaultfd hugetlb 10
> >       2 /tmp/kokonut_test/huge/userfaultfd_test && echo test success
> >
> > Both tests succeed and produce no warnings. After the test runs
> > number of free/resv hugepages is correct.
> >
> > ...
> >
> >  include/linux/hugetlb.h |   4 ++
> >  mm/hugetlb.c            | 103 ++++++++++++++++++++++++++++++++++++----
> >  mm/migrate.c            |  39 +++------------
> >  3 files changed, 103 insertions(+), 43 deletions(-)
>
> I'm assuming we want this in -stable?
>

Umm I'll yield to Mike. This is a transient underflow; not actually
THAT serious of an issue. Sorry, I'll clarify that in the commit
message for the next version.

> Are we able to identify a Fixes: for this?
>

No, this issue has been there latent for some time. It repros as far
back as 5.11 at least, which is why maybe it's not that serious to
require in -stable.

> It's a large change.  Can we come up with some smaller and easier to
> review and integrate version which we can feed into 5.13 and -stable
> and do the fancier version for 5.14?
>

Yes. If we only do the hugetlbfs_pagecache_present() check then that
gets us some 90% of the way there, the rest of the patch addresses an
unlikely race.

> If you don't think -stable needs this then this version will be OK as-is.
