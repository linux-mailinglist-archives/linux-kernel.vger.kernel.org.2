Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB3431B86D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 12:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhBOLxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 06:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhBOLwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 06:52:44 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C76C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 03:52:03 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id q72so3590715pjq.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 03:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ELXsaA6h2gd3/2XQSUpZtIfYlq6fHEtAZT6xqmaOGS4=;
        b=Dh6h6aUxZyxT9mZOEFDApEmhokQpI3yJ+/bpvDReNio8+/wY/9QxWqG2Rf9jWS+LBm
         WEgYVe5iGG4CVZzCxLPhdAS2BB5wSLWkyhr+/+2yug9QKh0mNDnRJH8PXryXuxT5yhhe
         Yj/0vEXgC8cr/5h8zU+Lsup3t3R4Fxsg3+YGw7xQ+ko1nfmnuI3cWS/49c2KMuCvRFRF
         6bwOlDCyKKfQTv8wv6j2JZ8F869L2CkSbhG8m+pkbgy+a0Dj9mojgJ+FM593mk7ohaWP
         fGZOs7zgayE35XhJfH/Jyd4dgSMze+hzpttwNy1vXWLWm2vXB97Ydssjj6YmLk+Ic3/F
         NUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ELXsaA6h2gd3/2XQSUpZtIfYlq6fHEtAZT6xqmaOGS4=;
        b=J6qIFRhxi+vAhxXu9F8NTpRKbkJQiKk3JEjc74Y4skkbPRZql3VEZGdMTmISXuU6tz
         RB57JwfJIaDhJqBHM6VzP5fNqb9vKX3CUnRFoXzSQkLYCLlJCwb+gsOQ9o7YR6ZlYbP4
         DD9PN7+GHvEGoGkt21e7ZU4iq+uVI71YnB/C65m1888R4J7HgCz9eomtn6VRG4RwV9cY
         4MpjIOPaBo2WXB/5j02NeMGN+1Kc6CNST3snA2YgqA4ul+vhgNVfyARFNjNRTAtXNCkG
         Hlz6BP5lx0DOYmxVOMsCTFR9Oo5j0RFZX9KV2DAUJZVaNG+gu6dXOC3FwdXhl1B1fRZP
         BbEA==
X-Gm-Message-State: AOAM532ycAwJt29u14w0RytOXw0lguID3c2tdGVkCVKl2mJafaqONTP9
        5/tifcbU+cW9l6RzuAxyuA2/KgmSOzj/61yRo3IXVw==
X-Google-Smtp-Source: ABdhPJzKyCtml9leEi1lmizMczQoWM9KaThCAeZnS9YTLYJ5Ia67P/pubrmRAW/pcM7dVvToP5VuRY7YIJH81Qa7d2I=
X-Received: by 2002:a17:90b:1096:: with SMTP id gj22mr15623262pjb.229.1613389923470;
 Mon, 15 Feb 2021 03:52:03 -0800 (PST)
MIME-Version: 1.0
References: <20210208085013.89436-1-songmuchun@bytedance.com>
 <20210208085013.89436-5-songmuchun@bytedance.com> <YCafit5ruRJ+SL8I@dhcp22.suse.cz>
 <CAMZfGtXgVUvCejpxu1o5WDvmQ7S88rWqGi3DAGM6j5NHJgtdcg@mail.gmail.com> <YCpN38i75olgispI@dhcp22.suse.cz>
In-Reply-To: <YCpN38i75olgispI@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 15 Feb 2021 19:51:26 +0800
Message-ID: <CAMZfGtUXJTaMo36aB4nTFuYFy3qfWW69o=4uUo-FjocO8obDgw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v15 4/8] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 6:33 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 15-02-21 18:05:06, Muchun Song wrote:
> > On Fri, Feb 12, 2021 at 11:32 PM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > > +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> > > > +{
> > > > +     int ret;
> > > > +     unsigned long vmemmap_addr = (unsigned long)head;
> > > > +     unsigned long vmemmap_end, vmemmap_reuse;
> > > > +
> > > > +     if (!free_vmemmap_pages_per_hpage(h))
> > > > +             return 0;
> > > > +
> > > > +     vmemmap_addr += RESERVE_VMEMMAP_SIZE;
> > > > +     vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
> > > > +     vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
> > > > +
> > > > +     /*
> > > > +      * The pages which the vmemmap virtual address range [@vmemmap_addr,
> > > > +      * @vmemmap_end) are mapped to are freed to the buddy allocator, and
> > > > +      * the range is mapped to the page which @vmemmap_reuse is mapped to.
> > > > +      * When a HugeTLB page is freed to the buddy allocator, previously
> > > > +      * discarded vmemmap pages must be allocated and remapping.
> > > > +      */
> > > > +     ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
> > > > +                               GFP_ATOMIC | __GFP_NOWARN | __GFP_THISNODE);
> > >
> > > I do not think that this is a good allocation mode. GFP_ATOMIC is a non
> > > sleeping allocation and a medium memory pressure might cause it to
> > > fail prematurely. I do not think this is really an atomic context which
> > > couldn't afford memory reclaim. I also do not think we want to grant
> >
> > Because alloc_huge_page_vmemmap is called under hugetlb_lock
> > now. So using GFP_ATOMIC indeed makes the code more simpler.
>
> You can have a preallocated list of pages prior taking the lock.

A discussion about this can refer to here:

https://patchwork.kernel.org/project/linux-mm/patch/20210117151053.24600-5-songmuchun@bytedance.com/

> Moreover do we want to manipulate vmemmaps from under spinlock in
> general. I have to say I have missed that detail when reviewing. Need to
> think more.
>
> > From the document of the kernel, I learned that __GFP_NOMEMALLOC
> > can be used to explicitly forbid access to emergency reserves. So if
> > we do not want to use the reserve memory. How about replacing it to
> >
> > GFP_ATOMIC | __GFP_NOMEMALLOC | __GFP_NOWARN | __GFP_THISNODE
>
> The whole point of GFP_ATOMIC is to grant access to memory reserves so
> the above is quite dubious. If you do not want access to memory reserves

Look at the code of gfp_to_alloc_flags().

static inline unsigned int gfp_to_alloc_flags(gfp_t gfp_mask)
{
        [...]
        if (gfp_mask & __GFP_ATOMIC) {
        /*
         * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
         * if it can't schedule.
         */
        if (!(gfp_mask & __GFP_NOMEMALLOC))
                alloc_flags |= ALLOC_HARDER;
       [...]
}

Seems to allow this operation (GFP_ATOMIC | __GFP_NOMEMALLOC).

> then use GFP_NOWAIT instead. But failures are much more easier to happen
> then.
>
> NOMEMALLOC is meant to be used from paths which are allowed to consume
> memory reserves - e.g. when invoked from the memory reclaim path.
> --
> Michal Hocko
> SUSE Labs
