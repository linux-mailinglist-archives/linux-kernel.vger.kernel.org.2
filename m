Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF2533A516
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 14:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhCNN6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 09:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbhCNN52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 09:57:28 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B9AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 06:57:26 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id e2so8766724pld.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 06:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OKhlbmcxL3jmSyB94SGhAWOpGn6Okl982SAADf6jBKw=;
        b=gznDeK+OJP/Qpucx8Md9RAr36/bNZyID+J/btToPPkX8R4peZO1jMSF/2R0s2ZS9ds
         q3aVEl8FbszRYgRxL2yjGxDZ0nxEAxlUH2iVmG4hyEXPQLc99GGMAtKDiALxVBHTma3l
         rCy0fEthW6aWBUn8wrSsYdc8WuCIEAoILzj9NPgBZwRBxhn4XWT9atxaGwMWB8Dktsh9
         QKk4JkXmsMbazBYfAP36fEX3Mvv6iqZ2iNcnZz/3gWJi+HGWGvxiMVyPgJqoMup2BTfN
         3B3we6Ul1E+p5SXaNaIZxXg5AgQfjsH9fQLlEy/9r6vvoBm4jvKJ5t+LRN+xPYGUDzd5
         BnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OKhlbmcxL3jmSyB94SGhAWOpGn6Okl982SAADf6jBKw=;
        b=gBHASC3SboX1/zl7+Czwlvmywh158GWfZZw23/CmAWyBbzoSOrinASPBeUE7oM+UJ9
         oW+0iHKi/U7VWg3qf49Wlb9aKJZMcrd3Q8ASA32WaVKUfP1Zz2KxL3yqvKLn4fSGIBok
         ssGfGDHkj5nm8fVknVz3GDQHenHFehIqzoMoMYuD+yUedpeUqP3gJWGWLZNL8NwNZxAk
         8O8CKDsf2dTzMlwNfASvVS6mGxnm49b5gYjMapX6gIITty45ayyB0ie6ropJb1HfvUw6
         npwUvFQecaQtENQRZYGTCBqdQgQVLi79s16pNIFN0w8nq2ZfMSMCG6yqAZuE3Yy+yx23
         qCeQ==
X-Gm-Message-State: AOAM5303Ocqf2q+KbWPmC2v/+F4paVSvNMpLNf8tbCk/waxyxl3+DYXV
        HHv1Gx9iWAlv60GEDjYP1Mcg4kX3QdJBrQqFMGOhhQ==
X-Google-Smtp-Source: ABdhPJy6D52jvjfgZ/X0PDv+vIu9QfAmwIiTxg4w7Fv3JYMP31bvc3twJ2eBBvMl3nYTtuM9g1QHNEqPQKWnI2lVLFs=
X-Received: by 2002:a17:90a:f008:: with SMTP id bt8mr8261959pjb.13.1615730245780;
 Sun, 14 Mar 2021 06:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210309100717.253-1-songmuchun@bytedance.com>
 <20210309100717.253-3-songmuchun@bytedance.com> <YEoXLX37sVgULO4A@cmpxchg.org>
 <CAMZfGtXZqe7g6e4wf=tUZqxBs-F1QkS2=01Td4Rv3_qTuF0bPA@mail.gmail.com> <YEu/pnK0n8nI2OBy@cmpxchg.org>
In-Reply-To: <YEu/pnK0n8nI2OBy@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sun, 14 Mar 2021 21:56:47 +0800
Message-ID: <CAMZfGtVbLc6y20d5_p84rsanaqY7np5eyoRSZKtaOraR8JDrmQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 2/4] mm: memcontrol: make
 page_memcg{_rcu} only applicable for non-kmem page
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 3:23 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Hello Muchun,
>
> On Fri, Mar 12, 2021 at 03:14:07PM +0800, Muchun Song wrote:
> > On Thu, Mar 11, 2021 at 9:12 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > @@ -358,14 +358,26 @@ enum page_memcg_data_flags {
> > > >
> > > >  #define MEMCG_DATA_FLAGS_MASK (__NR_MEMCG_DATA_FLAGS - 1)
> > > >
> > > > +/* Return true for charged page, otherwise false. */
> > > > +static inline bool page_memcg_charged(struct page *page)
> > > > +{
> > > > +     unsigned long memcg_data = page->memcg_data;
> > > > +
> > > > +     VM_BUG_ON_PAGE(PageSlab(page), page);
> > > > +     VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> > > > +
> > > > +     return !!memcg_data;
> > > > +}
> > >
> > > This is mosntly used right before a page_memcg_check(), which makes it
> > > somewhat redundant except for the VM_BUG_ON_PAGE() for slab pages.
> >
> > Should I rename page_memcg_charged to page_memcg_raw?
> > And use page_memcg_raw to check whether the page is charged.
> >
> > static inline bool page_memcg_charged(struct page *page)
> > {
> >         return page->memcg_data;
> > }
>
> You can just directly access page->memcg_data in places where you'd
> use this helper. I think it's only the two places in mm/page_alloc.c,
> and they already have CONFIG_MEMCG in place, so raw access works.

OK.

>
> > > But it's also a bit of a confusing name: slab pages are charged too,
> > > but this function would crash if you called it on one.
> > >
> > > In light of this, and in light of what I wrote above about hopefully
> > > converting more and more allocations from raw memcg pins to
> > > reparentable objcg, it would be bettor to have
> > >
> > >         page_memcg() for 1:1 page-memcg mappings, i.e. LRU & kmem
> >
> > Sorry. I do not get the point. Because in the next patch, the kmem
> > page will use objcg to charge memory. So the page_memcg()
> > should not be suitable for the kmem pages. So I add a VM_BUG_ON
> > in the page_memcg() to catch invalid usage.
> >
> > So I changed some page_memcg() calling to page_memcg_check()
> > in this patch, but you suggest using page_memcg().
>
> It would be better if page_memcg() worked on LRU and kmem pages. I'm
> proposing to change its implementation.
>
> The reason is that page_memcg_check() allows everything and does no
> sanity checking. You need page_memcg_charged() for the sanity checks
> that it's LRU or kmem, but that's a bit difficult to understand, and
> it's possible people will add more callsites to page_memcg_check()
> without the page_memcg_charged() checks. It makes the code less safe.
>
> We should discourage page_memcg_check() and make page_memcg() more
> useful instead.
>
> > I am very confused. Are you worried about the extra overhead brought
> > by calling page_memcg_rcu()? In the next patch, I will remove
> > page_memcg_check() calling and use objcg APIs.
>
> I'm just worried about the usability of the interface. It should be
> easy to use, and make it obvious if there is a user bug.
>
> For example, in your next patch, mod_lruvec_page_state does this:
>
>        if (PageMemcgKmem(head)) {
>                rcu_read_lock();
>                memcg = obj_cgroup_memcg(page_objcg(page));
>        } else {
>                memcg = page_memcg(head);
>                /*
>                 * Untracked pages have no memcg, no lruvec. Update only the
>                 * node.
>                 */
>                if (!memcg) {
>                        __mod_node_page_state(pgdat, idx, val);
>                        return;
>                }
>         }
>
>         lruvec = mem_cgroup_lruvec(memcg, pgdat);
>         __mod_lruvec_state(lruvec, idx, val);
>
>        if (PageMemcgKmem(head))
>                rcu_read_unlock();
>
> I'm proposing to implement page_memcg() in a way where you can do this:
>
>         rcu_read_lock();
>         memcg = page_memcg(page);
>         if (!memcg) {
>                 rcu_read_unlock();
>                 __mod_node_page_state();
>                 return;
>         }
>         lruvec = mem_cgroup_lruvec(memcg, pgdat);
>         __mod_lruvec_state(lruvec, idx, val);
>         rcu_read_unlock();
>
> [ page_memcg() is:
>
>         if (PageMemcgKmem(page))
>                 return obj_cgroup_memcg(__page_objcg(page));
>         else
>                 return __page_memcg(page);
>
>   and __page_objcg() and __page_memcg() do the raw page->memcg_data
>   translation and the VM_BUG_ON_PAGE() checks for MEMCG_DATA_* ]

Thanks for your suggestions. I will rework the code like this.

>
> This is a lot simpler and less error prone.
>
> It does take rcu_read_lock() for LRU pages too, which strictly it
> doesn't need to right now. But it's cheap enough (and actually saves a
> branch).
>
> Longer term we most likely need it there anyway. The issue you are
> describing in the cover letter - allocations pinning memcgs for a long
> time - it exists at a larger scale and is causing recurring problems
> in the real world: page cache doesn't get reclaimed for a long time,
> or is used by the second, third, fourth, ... instance of the same job
> that was restarted into a new cgroup every time. Unreclaimable dying
> cgroups pile up, waste memory, and make page reclaim very inefficient.
>
> We likely have to convert LRU pages and most other raw memcg pins to
> the objcg direction to fix this problem, and then the page->memcg
> lookup will always require the rcu read lock anyway.

Yeah. I agree with you. I am doing this (it is already on my todo list).

>
> Finally, a universal page_memcg() should also make uncharge_page()
> simpler. Instead of obj_cgroup_memcg_get(), you could use the new
> page_memcg() to implement a universal get_mem_cgroup_from_page():
>
>         rcu_read_lock();
> retry:
>         memcg = page_memcg(page);
>         if (unlikely(!css_tryget(&memcg->css)))
>                 goto retry;
>         rcu_read_unlock();
>         return memcg;
>
> and then uncharge_page() becomes something like this:
>
>         /* Look up page's memcg & prepare the batch */
>         memcg = get_mem_cgroup_from_page(page);
>         if (!memcg)
>                 return;
>         if (ug->memcg != memcg) {
>                 ...
>                 css_get(&memcg->css); /* batch ref, put in uncharge_batch() */
>         }
>         mem_cgroup_put(memcg);
>
>         /* Add page to batch */
>         nr_pages = compound_nr(page);
>         ...
>
>         /* Clear the page->memcg link */
>         if (PageMemcgKmem(page))
>                 obj_cgroup_put(__page_objcg(page));
>         else
>                 css_put(__page_memcg(&memcg->css));
>         page->memcg_data = 0;
>
> Does that sound reasonable?

Make sense to me.

>
> PS: We have several page_memcg() callsites that could use the raw
> __page_memcg() directly for now. Is it worth switching them and saving
> the branch? I think probably not, because these paths aren't hot, and
> as per above, we should switch them to objcg sooner or later anyway.

Got it.

Very thanks for your explanation.
