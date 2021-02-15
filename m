Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5E731B89F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhBOMC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhBOMBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:01:25 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A744DC061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 04:00:44 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id e9so3625463plh.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 04:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=INHSTdbbMAnHJ5ngsCbA6pXfb/MxgNU1cYVOuivMAiY=;
        b=p6AO+q/ktNMDiNWH1a7tvx6qA16y2fDrsuKOr0X1dmpkBM8j/5qcKH+w+LCRt6IMwU
         i/cSUkqkFJMxC7+nWPyAjmy9LzTabHuWpfPF2wo0fqKYGo+3BNCr9QEP2lFwSyuZJNgl
         PBiRexvgW9iYvqqcvBjln6Jy1PZQ7ggWFClnPzYUcBjpLUkQC5A0R93+pCB1a0NbzndF
         x3lGiUltcjV/+jCZVaOlWCZV48YwUv94MvuPWp8on+SQiDn0o/PAuQT9Y7DgtECp0R3A
         EVgfj8XJVEagUTzYd+IB2HvAZJpVFUzEPUZbxJquJv6HxtLtzIB8R06qwrVssAkHA5Wn
         a45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=INHSTdbbMAnHJ5ngsCbA6pXfb/MxgNU1cYVOuivMAiY=;
        b=NYMWEPqudPr0aCqnaz9vOGrjxJbnw7Q66HgDDgBXrLgmvSw/MTZ+1y0GMoolEaYOks
         6eR0xDSAMeFzTlJqsi2UDjnahb8nhWnXXA3H599UcwzsgSqDcmXrgyf2Ph3Z3I4NEDPX
         Wz1Ow3z9JaXy+rWYiafq2/695UAaEPLM4QzVMPJHcziywC6JFIn6/U3HIqV6Bwjbr5pb
         GPbINnCtVNsjEIdQ8WrL6ZGdUIxApAcn7fHTtm0qooz3b9bgQHUVHRjfk4vI+6T7Y1dC
         M2qfFrPP46V6ZiKUzWOeSvS9ZYkKNB64h1Rwm07CShDix7gDwIjp0AqMoAAj3qtWf3k8
         lfKA==
X-Gm-Message-State: AOAM531nSkN8Cjuy5zoxFq7vVPCoQ++k/38lT2h6D+Pphwnc/IorcMHt
        enKgRGDxB+fSDG6CO5IqDuEa1lSbV0PUPoQ9sqyFoQ==
X-Google-Smtp-Source: ABdhPJyWMlV/mO73WwnpuLR16zCguDYlLKmFOmYmPXRr8hHb+1e2qA13X/czPsChMsuZHd+Et2QMW9S7ko3NxqnurVc=
X-Received: by 2002:a17:902:7290:b029:e3:1dcf:f3ec with SMTP id
 d16-20020a1709027290b02900e31dcff3ecmr15025687pll.20.1613390444235; Mon, 15
 Feb 2021 04:00:44 -0800 (PST)
MIME-Version: 1.0
References: <20210208085013.89436-1-songmuchun@bytedance.com>
 <20210208085013.89436-5-songmuchun@bytedance.com> <YCafit5ruRJ+SL8I@dhcp22.suse.cz>
 <CAMZfGtXgVUvCejpxu1o5WDvmQ7S88rWqGi3DAGM6j5NHJgtdcg@mail.gmail.com>
 <YCpN38i75olgispI@dhcp22.suse.cz> <CAMZfGtUXJTaMo36aB4nTFuYFy3qfWW69o=4uUo-FjocO8obDgw@mail.gmail.com>
In-Reply-To: <CAMZfGtUXJTaMo36aB4nTFuYFy3qfWW69o=4uUo-FjocO8obDgw@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 15 Feb 2021 20:00:07 +0800
Message-ID: <CAMZfGtWT8CJ-QpVofB2X-+R7GE7sMa40eiAJm6PyD0ji=FzBYQ@mail.gmail.com>
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

On Mon, Feb 15, 2021 at 7:51 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Mon, Feb 15, 2021 at 6:33 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 15-02-21 18:05:06, Muchun Song wrote:
> > > On Fri, Feb 12, 2021 at 11:32 PM Michal Hocko <mhocko@suse.com> wrote:
> > [...]
> > > > > +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> > > > > +{
> > > > > +     int ret;
> > > > > +     unsigned long vmemmap_addr = (unsigned long)head;
> > > > > +     unsigned long vmemmap_end, vmemmap_reuse;
> > > > > +
> > > > > +     if (!free_vmemmap_pages_per_hpage(h))
> > > > > +             return 0;
> > > > > +
> > > > > +     vmemmap_addr += RESERVE_VMEMMAP_SIZE;
> > > > > +     vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
> > > > > +     vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
> > > > > +
> > > > > +     /*
> > > > > +      * The pages which the vmemmap virtual address range [@vmemmap_addr,
> > > > > +      * @vmemmap_end) are mapped to are freed to the buddy allocator, and
> > > > > +      * the range is mapped to the page which @vmemmap_reuse is mapped to.
> > > > > +      * When a HugeTLB page is freed to the buddy allocator, previously
> > > > > +      * discarded vmemmap pages must be allocated and remapping.
> > > > > +      */
> > > > > +     ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
> > > > > +                               GFP_ATOMIC | __GFP_NOWARN | __GFP_THISNODE);
> > > >
> > > > I do not think that this is a good allocation mode. GFP_ATOMIC is a non
> > > > sleeping allocation and a medium memory pressure might cause it to
> > > > fail prematurely. I do not think this is really an atomic context which
> > > > couldn't afford memory reclaim. I also do not think we want to grant
> > >
> > > Because alloc_huge_page_vmemmap is called under hugetlb_lock
> > > now. So using GFP_ATOMIC indeed makes the code more simpler.
> >
> > You can have a preallocated list of pages prior taking the lock.
>
> A discussion about this can refer to here:
>
> https://patchwork.kernel.org/project/linux-mm/patch/20210117151053.24600-5-songmuchun@bytedance.com/
>
> > Moreover do we want to manipulate vmemmaps from under spinlock in
> > general. I have to say I have missed that detail when reviewing. Need to
> > think more.
> >
> > > From the document of the kernel, I learned that __GFP_NOMEMALLOC
> > > can be used to explicitly forbid access to emergency reserves. So if
> > > we do not want to use the reserve memory. How about replacing it to
> > >
> > > GFP_ATOMIC | __GFP_NOMEMALLOC | __GFP_NOWARN | __GFP_THISNODE
> >
> > The whole point of GFP_ATOMIC is to grant access to memory reserves so
> > the above is quite dubious. If you do not want access to memory reserves
>
> Look at the code of gfp_to_alloc_flags().
>
> static inline unsigned int gfp_to_alloc_flags(gfp_t gfp_mask)
> {
>         [...]
>         if (gfp_mask & __GFP_ATOMIC) {
>         /*
>          * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
>          * if it can't schedule.
>          */
>         if (!(gfp_mask & __GFP_NOMEMALLOC))
>                 alloc_flags |= ALLOC_HARDER;
>        [...]
> }
>
> Seems to allow this operation (GFP_ATOMIC | __GFP_NOMEMALLOC).

I also found similar users.

netdev_alloc_frag()
    page_frag_alloc(GFP_ATOMIC)
        __page_frag_cache_refill(GFP_ATOMIC)
            alloc_pages_node(GFP_ATOMIC | __GFP_COMP | __GFP_NOWARN |
__GFP_NORETRY |
                                                __GFP_NOMEMALLOC)

>
> > then use GFP_NOWAIT instead. But failures are much more easier to happen
> > then.
> >
> > NOMEMALLOC is meant to be used from paths which are allowed to consume
> > memory reserves - e.g. when invoked from the memory reclaim path.
> > --
> > Michal Hocko
> > SUSE Labs
