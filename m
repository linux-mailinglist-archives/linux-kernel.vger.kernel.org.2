Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8239031B9A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhBOMrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhBOMqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:46:14 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B42C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 04:45:33 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id z68so4177384pgz.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 04:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B/Q6VwPDe6I6EirNcsyicnPy138BEVcOe0YKhiLSwKI=;
        b=bFnBs52Ad4AzO3WrtmP1t4dKywjpPzK+A482Eht6ojz0TpmO7rLiExFrSiXmi1S2/N
         JVPugG3EVQe37M9ZZbqQbe3vnUWlJ02gF52OhqtjzccwxgbMqN7glFsab53y34iAsFbL
         4kjXYxYj4ufcMKtowhp4K7R5ARxG1wIl53SN1GNMvPvMAMKzWhz6Z+F9q9iOjCnhqXEO
         hfWRa/ZSRjqL+PRzodxE8JEJzZg0064aea6im6iFOGyV3tcqTSjWLMisoHnAe4KdD2lI
         4nfmAWUZN/9VffDyOGlST7TAebdEl3HRz5sKQJHvXGJxwQT0NXRV4c1fT6gYDqLv/YA2
         QAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/Q6VwPDe6I6EirNcsyicnPy138BEVcOe0YKhiLSwKI=;
        b=BsnSR8LVfhMIjOQW0eNL/7960/KT9UrL/6wPhBoV19apBbQREcULIx6AqYD1WX6Xby
         idDifhb0Ko0S36gcxPSqicHGN5+pkC8KgAJfqVtnd/+wA2QrivKIsaqOkUKEw4BeaiJE
         sO12z2ICVaykkesBGruLhmEUyIxwNPPdY59ljE8kpG2HrFGhfm5ASXxNfBmbSg11kRIp
         cA0dmSHXdSPi0jSePA/kD3BCTVCz3B9k8GABsI8BTUvBQ5GjpzWiVS44deOHhnTZijCp
         CUVGDYBKIseRUgm2DihcQdI9e1t2W4Pubm6Tz7yQTPrcJX24FBMyFLmhmPcgKj97Vrh/
         BqeA==
X-Gm-Message-State: AOAM5300nMCEvlvdv0cSmxytrFAu4KjW5pedn0Ds3c+uojZN6qnf83Bh
        MuAcWYBf1c5qtp/0rlvfD22LTLNLjtqx4yn7wHbGcw==
X-Google-Smtp-Source: ABdhPJyq6XwxGiX9i2zyXPYTiHNrGd98hXjL3RiX/v0CDPtNUnDm8UIfyWi8yX3TRZ6m+4rmLlNJOKb3zXYFAt+3B1c=
X-Received: by 2002:a63:de0e:: with SMTP id f14mr14400347pgg.273.1613393133150;
 Mon, 15 Feb 2021 04:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20210208085013.89436-1-songmuchun@bytedance.com>
 <20210208085013.89436-5-songmuchun@bytedance.com> <YCafit5ruRJ+SL8I@dhcp22.suse.cz>
 <CAMZfGtXgVUvCejpxu1o5WDvmQ7S88rWqGi3DAGM6j5NHJgtdcg@mail.gmail.com>
 <YCpN38i75olgispI@dhcp22.suse.cz> <CAMZfGtUXJTaMo36aB4nTFuYFy3qfWW69o=4uUo-FjocO8obDgw@mail.gmail.com>
 <CAMZfGtWT8CJ-QpVofB2X-+R7GE7sMa40eiAJm6PyD0ji=FzBYQ@mail.gmail.com> <YCpmlGuoTakPJs1u@dhcp22.suse.cz>
In-Reply-To: <YCpmlGuoTakPJs1u@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 15 Feb 2021 20:44:57 +0800
Message-ID: <CAMZfGtWd_ZaXtiEdMKhpnAHDw5CTm-CSPSXW+GfKhyX5qQK=Og@mail.gmail.com>
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

On Mon, Feb 15, 2021 at 8:18 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 15-02-21 20:00:07, Muchun Song wrote:
> > On Mon, Feb 15, 2021 at 7:51 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > On Mon, Feb 15, 2021 at 6:33 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Mon 15-02-21 18:05:06, Muchun Song wrote:
> > > > > On Fri, Feb 12, 2021 at 11:32 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > [...]
> > > > > > > +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> > > > > > > +{
> > > > > > > +     int ret;
> > > > > > > +     unsigned long vmemmap_addr = (unsigned long)head;
> > > > > > > +     unsigned long vmemmap_end, vmemmap_reuse;
> > > > > > > +
> > > > > > > +     if (!free_vmemmap_pages_per_hpage(h))
> > > > > > > +             return 0;
> > > > > > > +
> > > > > > > +     vmemmap_addr += RESERVE_VMEMMAP_SIZE;
> > > > > > > +     vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
> > > > > > > +     vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
> > > > > > > +
> > > > > > > +     /*
> > > > > > > +      * The pages which the vmemmap virtual address range [@vmemmap_addr,
> > > > > > > +      * @vmemmap_end) are mapped to are freed to the buddy allocator, and
> > > > > > > +      * the range is mapped to the page which @vmemmap_reuse is mapped to.
> > > > > > > +      * When a HugeTLB page is freed to the buddy allocator, previously
> > > > > > > +      * discarded vmemmap pages must be allocated and remapping.
> > > > > > > +      */
> > > > > > > +     ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
> > > > > > > +                               GFP_ATOMIC | __GFP_NOWARN | __GFP_THISNODE);
> > > > > >
> > > > > > I do not think that this is a good allocation mode. GFP_ATOMIC is a non
> > > > > > sleeping allocation and a medium memory pressure might cause it to
> > > > > > fail prematurely. I do not think this is really an atomic context which
> > > > > > couldn't afford memory reclaim. I also do not think we want to grant
> > > > >
> > > > > Because alloc_huge_page_vmemmap is called under hugetlb_lock
> > > > > now. So using GFP_ATOMIC indeed makes the code more simpler.
> > > >
> > > > You can have a preallocated list of pages prior taking the lock.
> > >
> > > A discussion about this can refer to here:
> > >
> > > https://patchwork.kernel.org/project/linux-mm/patch/20210117151053.24600-5-songmuchun@bytedance.com/
> > >
> > > > Moreover do we want to manipulate vmemmaps from under spinlock in
> > > > general. I have to say I have missed that detail when reviewing. Need to
> > > > think more.
> > > >
> > > > > From the document of the kernel, I learned that __GFP_NOMEMALLOC
> > > > > can be used to explicitly forbid access to emergency reserves. So if
> > > > > we do not want to use the reserve memory. How about replacing it to
> > > > >
> > > > > GFP_ATOMIC | __GFP_NOMEMALLOC | __GFP_NOWARN | __GFP_THISNODE
> > > >
> > > > The whole point of GFP_ATOMIC is to grant access to memory reserves so
> > > > the above is quite dubious. If you do not want access to memory reserves
> > >
> > > Look at the code of gfp_to_alloc_flags().
> > >
> > > static inline unsigned int gfp_to_alloc_flags(gfp_t gfp_mask)
> > > {
> > >         [...]
> > >         if (gfp_mask & __GFP_ATOMIC) {
> > >         /*
> > >          * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
> > >          * if it can't schedule.
> > >          */
> > >         if (!(gfp_mask & __GFP_NOMEMALLOC))
> > >                 alloc_flags |= ALLOC_HARDER;
> > >        [...]
> > > }
> > >
> > > Seems to allow this operation (GFP_ATOMIC | __GFP_NOMEMALLOC).
>
> Please read my response again more carefully. I am not claiming that
> combination is not allowed. I have said it doesn't make any sense in
> this context.

I see you are worried that using GFP_ATOMIC will use reverse memory
unlimited. So I think that __GFP_NOMEMALLOC may be suitable for us.
Sorry, I may not understand the point you said. What I missed?

>
> --
> Michal Hocko
> SUSE Labs
