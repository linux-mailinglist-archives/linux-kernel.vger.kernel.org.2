Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5767B388E61
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353451AbhESMu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbhESMu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:50:58 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF24C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:49:38 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 6so9377698pgk.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tvJutpwC6OgwGmGHfHy5EWnjg1FWF0WzmnPf7pobyMA=;
        b=QufUefRIlU44FY39RoXA9yMQtgsz4rayOLXiUTmjXOG5uGd77aWagMHwUBMDX+RtIN
         C2eCS6q4KG2YNrXHZv2Pu3m5g0ERToP8QbxEtaMlDRU2gEuUyeaiEcG/3sYDxLt+ZP6c
         hI2RBFsfGa+wL0IVG2OBtugJ/vQM/eQ+t2eVJUl6I1en2K9CiwxU/KwuY6JLlYiX5Dn1
         JIFUtRf9S5UnpgNvVQP8HO3nDkbsURG+773vRxvuHzeNCnNc/OVNX06PzOFw7Mk0WPOS
         4bAebUHu9NpE8sAijFDlO/7hDQ315Oa9hGah43zz4zDls/1VWfSiwywpAKAe13SMUQSo
         JSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tvJutpwC6OgwGmGHfHy5EWnjg1FWF0WzmnPf7pobyMA=;
        b=WNY5O9zUpPPKWGJMqH/u/WaW9+v/3AmxU3hij+lojEks8NxHWL/p16oa3yA+1n5kRt
         9xNs8NCS0FUfXehoNDc2AYQ4oUpzThOqDAcaXUStmW9DfHtn91we5qedDNdWeGOMNfg3
         xmwXWf1RNQvAZXlCdyGazHDFOpgHyCBUVOovNs31yZdE4wta8BGjEq2KC3x3AekqaVuT
         SrQtcqhQQWYGAYCBYeifbT8VaD2OJdnMaH9wyQ0EpsnpwHz4wAtWJucOK85iBoD4OWbg
         Tk4hyTrcXWtGeq5HmlzP9KANfjuBbKLIPFnwZUpV7ynRmOo9scmJhFPEemgtY/4PvYMA
         p7Ww==
X-Gm-Message-State: AOAM530vREoijTL5qc4sWODlD/iJxyVyaHLDD0FddYw1ybvDoWxMxit5
        WLuGib/Jx1w9nFrKMhRHTE1oIOK6ToBjzijBJGSxBw==
X-Google-Smtp-Source: ABdhPJyZx4agyuvNquMytHMJMDBzKLpAAvLI6jhho/A1kk6p6EGRPN0rxd2JSuQn+Or+HTp5dG1IPPv7arMrUucHTSI=
X-Received: by 2002:a63:1953:: with SMTP id 19mr10638032pgz.273.1621428577422;
 Wed, 19 May 2021 05:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210518091826.36937-1-songmuchun@bytedance.com> <1b9d008a-7544-cc85-5c2f-532b984eb5b5@arm.com>
In-Reply-To: <1b9d008a-7544-cc85-5c2f-532b984eb5b5@arm.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 19 May 2021 20:49:02 +0800
Message-ID: <CAMZfGtVnfYjsDRSL5zURZrPvrvsGp3H22jWUy1mBEnEhKTm+eg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] arm64: mm: hugetlb: add support for free
 vmemmap pages of HugeTLB
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 7:44 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> On 5/18/21 2:48 PM, Muchun Song wrote:
> > The preparation of supporting freeing vmemmap associated with each
> > HugeTLB page is ready, so we can support this feature for arm64.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  arch/arm64/mm/mmu.c | 5 +++++
> >  fs/Kconfig          | 2 +-
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 5d37e461c41f..967b01ce468d 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/set_memory.h>
> > +#include <linux/hugetlb.h>
> >
> >  #include <asm/barrier.h>
> >  #include <asm/cputype.h>
> > @@ -1134,6 +1135,10 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
> >       pmd_t *pmdp;
> >
> >       WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
> > +
> > +     if (is_hugetlb_free_vmemmap_enabled() && !altmap)
> > +             return vmemmap_populate_basepages(start, end, node, altmap);
>
> Not considering the fact that this will force the kernel to have only
> base page size mapping for vmemmap (unless altmap is also requested)
> which might reduce the performance, it also enables vmemmap mapping to
> be teared down or build up at runtime which could potentially collide
> with other kernel page table walkers like ptdump or memory hotremove
> operation ! How those possible collisions are protected right now ?

For the ptdump, there seems no problem.  The change of pte seems
not to affect the ptdump unless I miss something.

>
> Does not this vmemmap operation increase latency for HugeTLB usage ?
> Should not this runtime enablement also take into account some other
> qualifying information apart from potential memory save from struct
> page areas. Just wondering.

The disadvantage is we add a PTE level mapping for vmemmap
pages, from this point of view, the latency will be increased.

But There's an additional benefit which is that page (un)pinners will
see an improvement, because there are fewer vmemmap pages
and thus the tail/head pages are staying in cache more often.
From this point of view, the latency will be decreased.

So if the user cares about the memory usage of the struct page, he
can enable this feature via cmdline when boot. As David said "That's
one of the reasons why it explicitly has to be enabled by an admin".

>
> > +
> >       do {
> >               next = pmd_addr_end(addr, end);
> >
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index 6ce6fdac00a3..02c2d3bf1cb8 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -242,7 +242,7 @@ config HUGETLB_PAGE
> >
> >  config HUGETLB_PAGE_FREE_VMEMMAP
> >       def_bool HUGETLB_PAGE
> > -     depends on X86_64
> > +     depends on X86_64 || ARM64
> >       depends on SPARSEMEM_VMEMMAP
> >
> >  config MEMFD_CREATE
> >
