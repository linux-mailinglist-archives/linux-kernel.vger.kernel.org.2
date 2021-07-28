Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC6D3D8E76
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbhG1NEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhG1NEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:04:04 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88606C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 06:04:02 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id n19so2987934ioz.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 06:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDwDfx19j8IGibNTUHdU1OYEGVTNVsxhXq9vsnGephU=;
        b=T9Kn0NABhI9/vFnTqlnUzxPVoF4Eg+BM4JaLDCYMJ4enYtWQ+1AQwKYiVIAiAkduJy
         9xc8EdyrObSuET7Ru9C48g2wGdErdmKWoGVz6ZsP9mYxH10aH6KuAPuM2g3UljUT8iqx
         VSP88IUJgbfm7dlS2xzHmQDd16b6Xm1EaB2ZHdWM1WPbX6IaTBganzyEd5mIBa7nNxMk
         LR9kEcP1H+tYeq2Dp1fcO0VvmpsrzAYS4KxTDVcgEigyrDR4j8dCdiftqdG4N+IJRfA7
         kL1ESIbuQ1YlFx19YsgDLs4QcZL4PI+cE0dPbOPvfEbeN+7S/QXqSL1UhgKqrosr73X/
         xjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDwDfx19j8IGibNTUHdU1OYEGVTNVsxhXq9vsnGephU=;
        b=EfLPsXOgd39Z0WZfiALbgzjmkqhJwLVkGCMeq6mx73kX+aBy/eddRWNf01X6ty0tno
         g92GibPe2CSBcUeq8rYw8nYti6H6YT+gcoYEOCAWXKsNA79+nlQ7cocKVVOiHoFv/MwP
         v06PA342XhwvGcWEx+UV2o2e2DUSKmIWkQrOIBnvLONdq37o/6rcL+20Gk6PDPtcX0i2
         JEfoM5gW0rkS5zQu74lHTYozAjN2ex2ykj1gRjKUOjYrMqiBQIzSScsQrZeq4z+XRhTU
         VCaLcmwHG6k40L6BTwr+1LLYy6mT+RQ9nQ6wgr5ehMPPIDbrwVYInqfz/FVkM//eFNRs
         gZsQ==
X-Gm-Message-State: AOAM531Kc0tec0CJUrGsmgT8nusZlw7TYvuTXMGeSFQ8WSCZ4PyUtIHY
        +RcMLs3ni8qGIG6kG1avbK0toT1H0BMzF+dH9Bw=
X-Google-Smtp-Source: ABdhPJy/duLqQ6muZtfL+logI9fB+6Ffci+lLijgEoR2IX9pEEZu1ZmBjYloZz5eSitgIJKup9OkrIqjh3ehtIdYpGw=
X-Received: by 2002:a6b:fe06:: with SMTP id x6mr23706657ioh.38.1627477442031;
 Wed, 28 Jul 2021 06:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210723080000.93953-1-ying.huang@intel.com> <24187e5e-069-9f3f-cefe-39ac70783753@google.com>
In-Reply-To: <24187e5e-069-9f3f-cefe-39ac70783753@google.com>
From:   huang ying <huang.ying.caritas@gmail.com>
Date:   Wed, 28 Jul 2021 21:03:50 +0800
Message-ID: <CAC=cRTNby4GkSJ-pjs6utgHtrQYEdy3XZQ06Qsxgyf1MJSBjrw@mail.gmail.com>
Subject: Re: [PATCH] mm,shmem: Fix a typo in shmem_swapin_page()
To:     Hugh Dickins <hughd@google.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hugh,

Thanks for your comments.

On Sat, Jul 24, 2021 at 4:23 AM Hugh Dickins <hughd@google.com> wrote:
>
> On Fri, 23 Jul 2021, Huang Ying wrote:
>
> > "-" is missing before "EINVAL".
> >
> > Fixes: 2efa33fc7f6e ("mm/shmem: fix shmem_swapin() race with swapoff")
> > Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> > Cc: Miaohe Lin <linmiaohe@huawei.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > ---
> >  mm/shmem.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 9af4b2173fe9..e201a3ba12fa 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1708,7 +1708,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
> >       /* Prevent swapoff from happening to us. */
> >       si = get_swap_device(swap);
> >       if (!si) {
> > -             error = EINVAL;
> > +             error = -EINVAL;
> >               goto failed;
> >       }
> >       /* Look it up and read it in.. */
> > --
> > 2.30.2
>
> Thanks for catching that; and as David says, it's worse than a typo.
>
> But this is not the right fix:
> 2efa33fc7f6e ("mm/shmem: fix shmem_swapin() race with swapoff")
> needs to be reverted.
>
> It's been on my pile to look at for weeks: now I look at it and see
> it's just a bad patch.  Over-enthusiastic stablehands already rushed
> it out, I was wary, and reverts are already in -rc for 5.13 and 5.10,
> phew, but 5.12.19 EOL is stuck with it unfortunately, oh well.
>
> I was wary because, if the (never observed) race to be fixed is in
> swap_cluster_readahead(), why was shmem_swapin_page() being patched?

When we get a swap entry from the page table or shmem xarray, and no
necessary lock is held to prevent the swap device to be swapoff (e.g.
page table lock, page lock, etc.), it's possible that the swap device
has been swapoff when we operate on the swap entry (e.g. swapin).  So
we need to find a way to prevent the swap device to be swapoff,
get_swap_device() based on percpu_ref is used for that.  To avoid to
call get_swap_device() here and there (e.g. now it is called in many
different places), I think it's better to call get_swap_device() when
we just get a swap entry without holding the necessary lock, that is,
in do_swap_page() and shmem_swapin_page(), etc.  So that we can delete
the get_swap_device() call in lookup_swap_cache(),
__read_swap_cache_async(), etc.  This will make it easier to
understand when to use get_swap_device() and clean up the code.  Do
you agree?

> Not explained in its commit message, probably a misunderstanding of
> how mm/shmem.c already manages races (and prefers not to be involved
> in swap_info_struct stuff).

Yes.  The commit message isn't clean enough about why we do that.

> But why do I now say it's bad?  Because even if you correct the EINVAL
> to -EINVAL, that's an unexpected error: -EEXIST is common, -ENOMEM is
> not surprising, -ENOSPC can need consideration, but -EIO and anything
> else just end up as SIGBUS when faulting (or as error from syscall).

Yes.  -EINVAL isn't a good choice.  If it's the swapoff race, then
retrying can fix the race, so -EAGAIN may be a choice.  But if the
swap entry is really invalid (almost impossible in theory), we may
need something else, for example, WARN_ON_ONCE() and SIGBUS?  This
reminds me that we may need to distinguish the two possibilities in
get_swap_device()?

Best Regards,
Huang, Ying
