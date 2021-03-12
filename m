Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EC233975B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 20:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhCLTXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 14:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbhCLTXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:23:22 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BCBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 11:23:20 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id g24so4676407qts.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 11:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LxcK0eZg763Uv1zd+J5lylhCKFwZmqtvyHdZWDEW0d8=;
        b=ljHVoGPVLNn789IjAbykCgOWdKQ/N9sJ5GU7awZHd5nVj/n4kfruTCAuf96n2b0Awu
         EVrmc+ZyQnHN8ShqPijwi8sxpJOtfbptOyCNnCGL+G7FGqFVvCI+I5P7QQNjJHcWR8G8
         r9tjpkktkjKGx05pwTrqMaqadnucvibNYg6QXXv86lleG5JLN5k6XBainK2S/jqZHGJi
         ZhPKZ/QSJ1h3LOaKxPOvpw1//Wu+hRMpw+RZ5rvi4dzS5a67HYc6TiOst4CWxvIELdGI
         zAeSbpUERGJJODlQqZ2pAfVQ7Fl7oTtiB/7fgy+nivp2oQjgdOmg71Lx0TYbwXyfj9IJ
         VKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LxcK0eZg763Uv1zd+J5lylhCKFwZmqtvyHdZWDEW0d8=;
        b=DRgW2sN0R4HMTDMXM5TSdVSLXufhyLQxRbj/zsZ+V/ygRXWl2MwsZjKeGgSlBidRSb
         jD22sDnV+cNLdg2jk6ClrRnpC9tX5c4X//5K9lRJCF3tTbqH9pJu/y+XKIdx0Ks79lmD
         d4ptE2ugi+RL43H9T+NJLKFfD+1RuR9/5ISpkuSND6Oq9xXbj2FP8ANRRUATiQaoIHIp
         8h0QBBif4xgt7OqN08x3qITT2F98zLdthnf96WN/s5ccxs6ObmZTceVc9EgaQhpK3WR3
         UVXTq4olgU1ebeEtkGRiEgtPsCvmg/uCLw6v8qmpmFxT2RZ2t/RRZm5beJSCFdY/AGWS
         Ev4Q==
X-Gm-Message-State: AOAM5303gN3Koex94OcH68Aib1AU9NPc/iaxT9n+W8CJg2DOEX2vdTXp
        qV+kupbR+LMeNHWlaqVpbPkSTw==
X-Google-Smtp-Source: ABdhPJy3iIoF9uJA3Ih8w5f7fKAqR36OCqq2XVQodovjVw2GFZip1y0c9eIaDp97366EE9OE2/8LuQ==
X-Received: by 2002:ac8:53c1:: with SMTP id c1mr13150059qtq.100.1615576999581;
        Fri, 12 Mar 2021 11:23:19 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id s19sm4982668qks.130.2021.03.12.11.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 11:23:19 -0800 (PST)
Date:   Fri, 12 Mar 2021 14:23:18 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Subject: Re: [External] Re: [PATCH v3 2/4] mm: memcontrol: make
 page_memcg{_rcu} only applicable for non-kmem page
Message-ID: <YEu/pnK0n8nI2OBy@cmpxchg.org>
References: <20210309100717.253-1-songmuchun@bytedance.com>
 <20210309100717.253-3-songmuchun@bytedance.com>
 <YEoXLX37sVgULO4A@cmpxchg.org>
 <CAMZfGtXZqe7g6e4wf=tUZqxBs-F1QkS2=01Td4Rv3_qTuF0bPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtXZqe7g6e4wf=tUZqxBs-F1QkS2=01Td4Rv3_qTuF0bPA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Muchun,

On Fri, Mar 12, 2021 at 03:14:07PM +0800, Muchun Song wrote:
> On Thu, Mar 11, 2021 at 9:12 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > @@ -358,14 +358,26 @@ enum page_memcg_data_flags {
> > >
> > >  #define MEMCG_DATA_FLAGS_MASK (__NR_MEMCG_DATA_FLAGS - 1)
> > >
> > > +/* Return true for charged page, otherwise false. */
> > > +static inline bool page_memcg_charged(struct page *page)
> > > +{
> > > +     unsigned long memcg_data = page->memcg_data;
> > > +
> > > +     VM_BUG_ON_PAGE(PageSlab(page), page);
> > > +     VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> > > +
> > > +     return !!memcg_data;
> > > +}
> >
> > This is mosntly used right before a page_memcg_check(), which makes it
> > somewhat redundant except for the VM_BUG_ON_PAGE() for slab pages.
> 
> Should I rename page_memcg_charged to page_memcg_raw?
> And use page_memcg_raw to check whether the page is charged.
> 
> static inline bool page_memcg_charged(struct page *page)
> {
>         return page->memcg_data;
> }

You can just directly access page->memcg_data in places where you'd
use this helper. I think it's only the two places in mm/page_alloc.c,
and they already have CONFIG_MEMCG in place, so raw access works.

> > But it's also a bit of a confusing name: slab pages are charged too,
> > but this function would crash if you called it on one.
> >
> > In light of this, and in light of what I wrote above about hopefully
> > converting more and more allocations from raw memcg pins to
> > reparentable objcg, it would be bettor to have
> >
> >         page_memcg() for 1:1 page-memcg mappings, i.e. LRU & kmem
> 
> Sorry. I do not get the point. Because in the next patch, the kmem
> page will use objcg to charge memory. So the page_memcg()
> should not be suitable for the kmem pages. So I add a VM_BUG_ON
> in the page_memcg() to catch invalid usage.
> 
> So I changed some page_memcg() calling to page_memcg_check()
> in this patch, but you suggest using page_memcg().

It would be better if page_memcg() worked on LRU and kmem pages. I'm
proposing to change its implementation.

The reason is that page_memcg_check() allows everything and does no
sanity checking. You need page_memcg_charged() for the sanity checks
that it's LRU or kmem, but that's a bit difficult to understand, and
it's possible people will add more callsites to page_memcg_check()
without the page_memcg_charged() checks. It makes the code less safe.

We should discourage page_memcg_check() and make page_memcg() more
useful instead.

> I am very confused. Are you worried about the extra overhead brought
> by calling page_memcg_rcu()? In the next patch, I will remove
> page_memcg_check() calling and use objcg APIs.

I'm just worried about the usability of the interface. It should be
easy to use, and make it obvious if there is a user bug.

For example, in your next patch, mod_lruvec_page_state does this:

       if (PageMemcgKmem(head)) {
	       rcu_read_lock();
	       memcg = obj_cgroup_memcg(page_objcg(page));
       } else {
	       memcg = page_memcg(head);
	       /*
		* Untracked pages have no memcg, no lruvec. Update only the
		* node.
		*/
	       if (!memcg) {
		       __mod_node_page_state(pgdat, idx, val);
		       return;
	       }
	}

	lruvec = mem_cgroup_lruvec(memcg, pgdat);
	__mod_lruvec_state(lruvec, idx, val);

       if (PageMemcgKmem(head))
	       rcu_read_unlock();

I'm proposing to implement page_memcg() in a way where you can do this:

	rcu_read_lock();
	memcg = page_memcg(page);
	if (!memcg) {
		rcu_read_unlock();
		__mod_node_page_state();
		return;
	}
	lruvec = mem_cgroup_lruvec(memcg, pgdat);
	__mod_lruvec_state(lruvec, idx, val);
	rcu_read_unlock();

[ page_memcg() is:

	if (PageMemcgKmem(page))
		return obj_cgroup_memcg(__page_objcg(page));
	else
		return __page_memcg(page);

  and __page_objcg() and __page_memcg() do the raw page->memcg_data
  translation and the VM_BUG_ON_PAGE() checks for MEMCG_DATA_* ]

This is a lot simpler and less error prone.

It does take rcu_read_lock() for LRU pages too, which strictly it
doesn't need to right now. But it's cheap enough (and actually saves a
branch).

Longer term we most likely need it there anyway. The issue you are
describing in the cover letter - allocations pinning memcgs for a long
time - it exists at a larger scale and is causing recurring problems
in the real world: page cache doesn't get reclaimed for a long time,
or is used by the second, third, fourth, ... instance of the same job
that was restarted into a new cgroup every time. Unreclaimable dying
cgroups pile up, waste memory, and make page reclaim very inefficient.

We likely have to convert LRU pages and most other raw memcg pins to
the objcg direction to fix this problem, and then the page->memcg
lookup will always require the rcu read lock anyway.

Finally, a universal page_memcg() should also make uncharge_page()
simpler. Instead of obj_cgroup_memcg_get(), you could use the new
page_memcg() to implement a universal get_mem_cgroup_from_page():

	rcu_read_lock();
retry:
	memcg = page_memcg(page);
	if (unlikely(!css_tryget(&memcg->css)))
		goto retry;
	rcu_read_unlock();
	return memcg;

and then uncharge_page() becomes something like this:

	/* Look up page's memcg & prepare the batch */
	memcg = get_mem_cgroup_from_page(page);
	if (!memcg)
		return;
	if (ug->memcg != memcg) {
		...
		css_get(&memcg->css); /* batch ref, put in uncharge_batch() */
	}
	mem_cgroup_put(memcg);

	/* Add page to batch */
	nr_pages = compound_nr(page);
	...

	/* Clear the page->memcg link */
	if (PageMemcgKmem(page))
		obj_cgroup_put(__page_objcg(page));
	else
		css_put(__page_memcg(&memcg->css));
	page->memcg_data = 0;

Does that sound reasonable?

PS: We have several page_memcg() callsites that could use the raw
__page_memcg() directly for now. Is it worth switching them and saving
the branch? I think probably not, because these paths aren't hot, and
as per above, we should switch them to objcg sooner or later anyway.
