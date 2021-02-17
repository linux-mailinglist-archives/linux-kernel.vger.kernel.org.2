Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD8731DC4D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhBQPe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbhBQPai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:30:38 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20101C061756
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:29:58 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d15so7586725plh.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IEvlIwbmXsuqHNUtpKs8VTQydOk5VI0GaImfE0fmN4U=;
        b=ask1qaCwK4yLcterujoc3O4p6eeRzLfX0AHVU+3Twr04DTtgqRjpmjFHGq2CBjTJGo
         b7DXnzAUm1D+aG2t9O2EbR9Xxxmo9BScuE6UsdB5rZDgm7sexqLt8qKvLT3glyLd9duu
         k1svoB2F2tV6grWbIEeSFe2J2WTRaC992C+DybwmjArIQ8vWwLH7rhei1paBY9XOgQCx
         bY2MNfyv2ccyvFZFMW7KY3ERiAhM0KgXXuVpa6NKehNhnI1QaFyFCKOqNbPU2niQzx2O
         I1SvEO2oYKWVfMmxTNM3wQtllDP31zJakKBjKYYGJmeC3OuVEl8iNrixWGvt3NyJP36z
         38sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IEvlIwbmXsuqHNUtpKs8VTQydOk5VI0GaImfE0fmN4U=;
        b=XpI3qsgrKHFfJSvYEWVhHhUTDxyOEB6L56l5fCzPPQzrwrunyZIDJ5xQ2MM89j+p4z
         p1PHA/p+Fth3K8aEaq2qJpRnuskHFIt2BdVZcxEY6bWd97L0uijLzxbFSWwbEjXVMm8D
         s03+DofCPB3bSY5/Yc0FJSX5ieECh8bSaI9uDcPVt75QshiFSKOQEy7nkCN998cMl257
         s25vHMIKENulIXaRinu2cB8O5EoHHlsI8w+3z8x9C/29ZTBCUx8d5LE+8k0t0A+PTKbp
         zcBmeoMXgzVZzXZH0U7VRvaMxquSqk1i5ra9cZpCvCGhcgiQ2G2QaqWsCix5qFoj66YC
         BVdg==
X-Gm-Message-State: AOAM533UpkuqUjiyOrg6z8jPTXFRm8th6xY0epjUJIlEEsVMsezB3TEB
        ZIy9heySW/ptJo0C1JLFG7+Hn2iSh7tBXIiiigO775nDHm+iVA==
X-Google-Smtp-Source: ABdhPJxFmrP4b85rMr9HbCrLZ2cfXGI2IgaAP5+1FXvM7C9T2HmvdP3BP8c2mqbGb9N21VXe/tL7GudKYMkuFEX05+I=
X-Received: by 2002:a17:90b:1096:: with SMTP id gj22mr9552250pjb.229.1613575797397;
 Wed, 17 Feb 2021 07:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20210217110907.85120-1-songmuchun@bytedance.com> <CALvZod7XLwmjDWQmUxOBoA6LB8N3ZtB507VAmXjsM4goQiVkrA@mail.gmail.com>
In-Reply-To: <CALvZod7XLwmjDWQmUxOBoA6LB8N3ZtB507VAmXjsM4goQiVkrA@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 17 Feb 2021 23:29:21 +0800
Message-ID: <CAMZfGtVpt-5BMbF00iLCOZCczEJYLN9PT-WjgM=PwNuphopVZw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] mm: memcontrol: fix swap undercounting
 in cgroup2
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 10:39 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Feb 17, 2021 at 3:09 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > When pages are swapped in, the VM may retain the swap copy to avoid
> > repeated writes in the future. It's also retained if shared pages are
> > faulted back in some processes, but not in others. During that time we
> > have an in-memory copy of the page, as well as an on-swap copy. Cgroup1
> > and cgroup2 handle these overlapping lifetimes slightly differently
> > due to the nature of how they account memory and swap:
> >
> > Cgroup1 has a unified memory+swap counter that tracks a data page
> > regardless whether it's in-core or swapped out. On swapin, we transfer
> > the charge from the swap entry to the newly allocated swapcache page,
> > even though the swap entry might stick around for a while. That's why
> > we have a mem_cgroup_uncharge_swap() call inside mem_cgroup_charge().
> >
> > Cgroup2 tracks memory and swap as separate, independent resources and
> > thus has split memory and swap counters. On swapin, we charge the
> > newly allocated swapcache page as memory, while the swap slot in turn
> > must remain charged to the swap counter as long as its allocated too.
> >
> > The cgroup2 logic was broken by commit 2d1c498072de ("mm: memcontrol:
> > make swap tracking an integral part of memory control"), because it
> > accidentally removed the do_memsw_account() check in the branch inside
> > mem_cgroup_uncharge() that was supposed to tell the difference between
> > the charge transfer in cgroup1 and the separate counters in cgroup2.
> >
> > As a result, cgroup2 currently undercounts retained swap to varying
> > degrees: swap slots are cached up to 50% of the configured limit or
> > total available swap space; partially faulted back shared pages are
> > only limited by physical capacity. This in turn allows cgroups to
> > significantly overconsume their alloted swap space.
> >
> > Add the do_memsw_account() check back to fix this problem.
> >
> > Fixes: 2d1c498072de ("mm: memcontrol: make swap tracking an integral part of memory control")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Cc: stable@vger.kernel.org # 5.8+
> > ---
> >  v2:
> >  - update commit log and add a comment to the code. Very thanks to Johannes.
> >
> >  mm/memcontrol.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index ed5cc78a8dbf..2efbb4f71d5f 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6771,7 +6771,19 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
> >         memcg_check_events(memcg, page);
> >         local_irq_enable();
> >
> > -       if (PageSwapCache(page)) {
> > +       /*
> > +        * Cgroup1's unified memory+swap counter has been charged with the
> > +        * new swapcache page, finish the transfer by uncharging the swap
> > +        * slot. The swap slot would also get uncharged when it dies, but
> > +        * it can stick around indefinitely and we'd count the page twice
> > +        * the entire time.
> > +        *
> > +        * Cgroup2 has separate resource counters for memory and swap,
> > +        * so this is a non-issue here. Memory and swap charge lifetimes
> > +        * correspond 1:1 to page and swap slot lifetimes: we charge the
> > +        * page to memory here, and uncharge swap when the slot is freed.
> > +        */
> > +       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && PageSwapCache(page)) {
>
> do_memsw_account() instead of !cgroup_subsys_on_dfl(memory_cgrp_subsys).

Thanks a lot. Will do.

>
> >                 swp_entry_t entry = { .val = page_private(page) };
> >                 /*
> >                  * The swap entry might not get freed for a long time,
> > --
> > 2.11.0
> >
