Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55053C5FED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 17:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbhGLQAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbhGLQAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:00:32 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A715C0613EF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 08:57:43 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id r132so29777543yba.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N9Vsyf7u0V+Ft7+096/kMzSi5iobK3XqcnGMJrpg+tE=;
        b=hhSy8Vnz1wd1BsEaHB/mm4pUGxueHg3H9aiR6qpV6lk+8ysJ6SCoL1MmYSCqJpIqwh
         0tplbTJre0RBWmYNVtwpwimDV7DAezCaVKE1azllWzTzWLM4PePeeTHUK121IsBn6HGc
         GiMAc5r+QlaMlUo4+8m8cUYOjWvevJmJ1WljFQPI9rjP2VyKtvNAM9tPRTTsIgoLQ97l
         N32TyopBfSih3yP0Dci9auCmEQLajZkCwYnEXtq1IKrcaBK5GpjeqTP0XUoLZcN7eLIo
         fcOqysFdLZ4cMmkqV5fQ1x0SqtryUzk8ylJbhukP0eXS5gmwKr1EVpusI5lE+Ylh17Dx
         7yCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N9Vsyf7u0V+Ft7+096/kMzSi5iobK3XqcnGMJrpg+tE=;
        b=rjXd5UOz3vUe60U2eDfXxXYLT8Ou7NswCj7Ze3licbW3ehAgkxOquOhWWSho6FjwNT
         75mDInoK6M//YdglfKVKNVhItRVrIyFj+k3m28UupW9oVHxHkQ6sdjmO96TMcPDjEBXc
         e94VQtxyKZV0N0E5w3zO83viTI3N+SottPAgyYpg0MZQjeZQDKQhJJOhy8r7dygXhCeF
         Hy1qKY5fQFMMxIttb58sdplbUZewjJsj8iW21wutxOHlLcJCQ7uP055LCenoL7orzr0U
         b4n8KvpTziFsaxK8jTuM83qBWLnaIFl+OGZqP3NUdYK5OEmW91sJbv9s/A7ZqdvzeTZT
         0/Aw==
X-Gm-Message-State: AOAM530RkF8qah3+VwYdzg8SnnvKVQGpERNc/b+FVpjlR+dfT/uIm7Ta
        lvPdj+pdhCNMDZ0u1xBA2nJqXezdLp3WDl1CL/UHJQ==
X-Google-Smtp-Source: ABdhPJxnPb3hMIEwwz5tXpcaGMusf44U+ZBIftbm795emnO5AN+nrSWWqPh/RwkOCFqgAmSZB1kaEa6h/m0jHrIrRyM=
X-Received: by 2002:a25:ba08:: with SMTP id t8mr66449426ybg.111.1626105462122;
 Mon, 12 Jul 2021 08:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210710003626.3549282-1-surenb@google.com> <20210710003626.3549282-3-surenb@google.com>
 <YOvsijKufJzjHuvd@dhcp22.suse.cz>
In-Reply-To: <YOvsijKufJzjHuvd@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 12 Jul 2021 08:57:31 -0700
Message-ID: <CAJuCfpHO7ZGfCcbTWGvmJtSEHzxDJLHFYShm=rVxXJju_LOa7w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mm, memcg: inline swap-related functions to
 improve disabled memcg config
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        vdavydov.dev@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, songmuchun@bytedance.com,
        Yang Shi <shy828301@gmail.com>, alexs@kernel.org,
        richard.weiyang@gmail.com, Vlastimil Babka <vbabka@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, apopple@nvidia.com,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 12:17 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 09-07-21 17:36:26, Suren Baghdasaryan wrote:
> > Inline mem_cgroup_try_charge_swap, mem_cgroup_uncharge_swap and
> > cgroup_throttle_swaprate functions to perform mem_cgroup_disabled static
> > key check inline before calling the main body of the function. This
> > minimizes the memcg overhead in the pagefault and exit_mmap paths when
> > memcgs are disabled using cgroup_disable=memory command-line option.
> > This change results in ~1% overhead reduction when running PFT test
> > comparing {CONFIG_MEMCG=n} against {CONFIG_MEMCG=y, cgroup_disable=memory}
> > configuration on an 8-core ARM64 Android device.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> I find it a bit surprising to see such a big difference over a function
> call in a slow path like swap in/out.

Might be due to the nature of the test. It is designed to generate an
avalanche of anonymous pagefaults and that might be the reason swap
functions are hit this hard.

>
> Anyway the change makes sense.
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> Thanks!
>
> > ---
> >  include/linux/swap.h | 26 +++++++++++++++++++++++---
> >  mm/memcontrol.c      | 14 ++++----------
> >  mm/swapfile.c        |  5 +----
> >  3 files changed, 28 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 6f5a43251593..f30d26b0f71d 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -721,7 +721,13 @@ static inline int mem_cgroup_swappiness(struct mem_cgroup *mem)
> >  #endif
> >
> >  #if defined(CONFIG_SWAP) && defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
> > -extern void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask);
> > +extern void __cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask);
> > +static inline  void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
> > +{
> > +     if (mem_cgroup_disabled())
> > +             return;
> > +     __cgroup_throttle_swaprate(page, gfp_mask);
> > +}
> >  #else
> >  static inline void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
> >  {
> > @@ -730,8 +736,22 @@ static inline void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
> >
> >  #ifdef CONFIG_MEMCG_SWAP
> >  extern void mem_cgroup_swapout(struct page *page, swp_entry_t entry);
> > -extern int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry);
> > -extern void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages);
> > +extern int __mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry);
> > +static inline int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
> > +{
> > +     if (mem_cgroup_disabled())
> > +             return 0;
> > +     return __mem_cgroup_try_charge_swap(page, entry);
> > +}
> > +
> > +extern void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages);
> > +static inline void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
> > +{
> > +     if (mem_cgroup_disabled())
> > +             return;
> > +     __mem_cgroup_uncharge_swap(entry, nr_pages);
> > +}
> > +
> >  extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
> >  extern bool mem_cgroup_swap_full(struct page *page);
> >  #else
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index cdaf7003b43d..0b05322836ec 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -7234,7 +7234,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
> >  }
> >
> >  /**
> > - * mem_cgroup_try_charge_swap - try charging swap space for a page
> > + * __mem_cgroup_try_charge_swap - try charging swap space for a page
> >   * @page: page being added to swap
> >   * @entry: swap entry to charge
> >   *
> > @@ -7242,16 +7242,13 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
> >   *
> >   * Returns 0 on success, -ENOMEM on failure.
> >   */
> > -int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
> > +int __mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
> >  {
> >       unsigned int nr_pages = thp_nr_pages(page);
> >       struct page_counter *counter;
> >       struct mem_cgroup *memcg;
> >       unsigned short oldid;
> >
> > -     if (mem_cgroup_disabled())
> > -             return 0;
> > -
> >       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> >               return 0;
> >
> > @@ -7287,18 +7284,15 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
> >  }
> >
> >  /**
> > - * mem_cgroup_uncharge_swap - uncharge swap space
> > + * __mem_cgroup_uncharge_swap - uncharge swap space
> >   * @entry: swap entry to uncharge
> >   * @nr_pages: the amount of swap space to uncharge
> >   */
> > -void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
> > +void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
> >  {
> >       struct mem_cgroup *memcg;
> >       unsigned short id;
> >
> > -     if (mem_cgroup_disabled())
> > -             return;
> > -
> >       id = swap_cgroup_record(entry, 0, nr_pages);
> >       rcu_read_lock();
> >       memcg = mem_cgroup_from_id(id);
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 707fa0481bb4..04a0c83f1313 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -3773,14 +3773,11 @@ static void free_swap_count_continuations(struct swap_info_struct *si)
> >  }
> >
> >  #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
> > -void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
> > +void __cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
> >  {
> >       struct swap_info_struct *si, *next;
> >       int nid = page_to_nid(page);
> >
> > -     if (mem_cgroup_disabled())
> > -             return;
> > -
> >       if (!(gfp_mask & __GFP_IO))
> >               return;
> >
> > --
> > 2.32.0.93.g670b81a890-goog
>
> --
> Michal Hocko
> SUSE Labs
