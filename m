Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB08238927C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354706AbhESPYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346674AbhESPYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:24:41 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3FAC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:23:20 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b13so6383745pfv.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qd20th7hRcH2q8Nunhpc+31ZIDOCqw3EIS/TwDw4/5s=;
        b=hrQ2z1MJedI9hhV2DkzXya0LObavlrHaeahHSCDI5cDEQdt8Z791xlEqqNS9mSsoax
         jYoTsbeTE6KR0NkjofrHUE2OD6bnD2NKzCZ0qk5AiYtjDwTAAylxNAGVoFPsBSxwHBli
         vrNhUJUUaF2MxrrzjC9Lu9URErZq07UlYBWMMKWmh6vLwfdK0Y1bWBH6/BOWBb6tgKpw
         ti9QcZvP8ylE7WhnFchZtWnI7afM+cJHzgKDkoGO4MWiZnMU4TmrmO+Hb1pRUO/SUaz4
         Cpd8gu+5lyikno0EJqjhAd8LPOz0b81l7les/DhfhJaEeoIFpeEifRVxX+8/ZrHPjX7g
         vNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qd20th7hRcH2q8Nunhpc+31ZIDOCqw3EIS/TwDw4/5s=;
        b=hpkJnXWQPS3iqY+DZsEKp9LIKCRkh+fUsnVOhF1vnE9ZNtWDvQj2hW/r47UfPjhJKU
         7iitU79EkTTkjfnJsIB7Z1jUiGe9OyMwv91+oNlPyyRXwQhsHDdeQphsbBX/RN5b6nqR
         vi5QaNgr624ib5BVwH9QgQ0xPpOudmeTwCDPkwYZ1fjUqPxTl069xxucAnwfeMSoyQQS
         LffZHLbNozy7hynvdIak0V4/o4SKeem8wwd+MDrz0Ze5N4OxYyB2qRIVofetRWM8EUWp
         QvAB/oBMd2NyHk9Q3QG3Jx45vGtGZvOAFggNsegVyeu3LUgxODcYkHI654Bdz4yb2PqE
         ZoUw==
X-Gm-Message-State: AOAM530QB8A3SB2uKoTW8ULOe97Z2vU91gYdRwsg+B+3jaV5R0cx7sdP
        B++tENc/IDYfar0J48qwj5NAkFxpPQRj44Xybo6Zvg==
X-Google-Smtp-Source: ABdhPJx2oArkMo6klT1vMbR7KAuXL96KcBr/xM1HVB2qpd5pMbiuJ1baIg/WKvqauKfLrSAo71zWY00dLxreNi+tfXA=
X-Received: by 2002:a65:5288:: with SMTP id y8mr11305466pgp.31.1621437800210;
 Wed, 19 May 2021 08:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210518091826.36937-1-songmuchun@bytedance.com>
 <5ae7a4be-dfd5-faf6-a75c-a2adf5a344b2@arm.com> <CAMZfGtVJrnQ6Nb25CON3WupOx-K3BFzQ2t546r0xsT45vZD+4w@mail.gmail.com>
In-Reply-To: <CAMZfGtVJrnQ6Nb25CON3WupOx-K3BFzQ2t546r0xsT45vZD+4w@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 19 May 2021 23:22:44 +0800
Message-ID: <CAMZfGtWpu=pDqn2WZ4QPTevvHmjMaXg8oN8rh1KCDXwievzNrw@mail.gmail.com>
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

On Wed, May 19, 2021 at 10:43 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Wed, May 19, 2021 at 8:35 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
> >
> >
> > On 5/18/21 2:48 PM, Muchun Song wrote:
> > > The preparation of supporting freeing vmemmap associated with each
> > > HugeTLB page is ready, so we can support this feature for arm64.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  arch/arm64/mm/mmu.c | 5 +++++
> > >  fs/Kconfig          | 2 +-
> > >  2 files changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > > index 5d37e461c41f..967b01ce468d 100644
> > > --- a/arch/arm64/mm/mmu.c
> > > +++ b/arch/arm64/mm/mmu.c
> > > @@ -23,6 +23,7 @@
> > >  #include <linux/mm.h>
> > >  #include <linux/vmalloc.h>
> > >  #include <linux/set_memory.h>
> > > +#include <linux/hugetlb.h>
> > >
> > >  #include <asm/barrier.h>
> > >  #include <asm/cputype.h>
> > > @@ -1134,6 +1135,10 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
> > >       pmd_t *pmdp;
> > >
> > >       WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
> > > +
> > > +     if (is_hugetlb_free_vmemmap_enabled() && !altmap)
> > > +             return vmemmap_populate_basepages(start, end, node, altmap);
> > > +
> > >       do {
> > >               next = pmd_addr_end(addr, end);
> > >
> > > diff --git a/fs/Kconfig b/fs/Kconfig
> > > index 6ce6fdac00a3..02c2d3bf1cb8 100644
> > > --- a/fs/Kconfig
> > > +++ b/fs/Kconfig
> > > @@ -242,7 +242,7 @@ config HUGETLB_PAGE
> > >
> > >  config HUGETLB_PAGE_FREE_VMEMMAP
> > >       def_bool HUGETLB_PAGE
> > > -     depends on X86_64
> > > +     depends on X86_64 || ARM64
> > >       depends on SPARSEMEM_VMEMMAP
> > >
> > >  config MEMFD_CREATE
> > >
> >
> > How does this interact with HugeTLB migration as such which might iterate
> > over individual constituent struct pages (overriding the same struct page
> > for all tail pages when this feature is enabled). A simple test involving
> > madvise(ptr, size, MADV_SOFT_OFFLINE) fails on various HugeTLB page sizes,
> > with this patch applied. Although I have not debugged this any further.
>
> It is weird. Actually, I didn't change the behaviour of the page migration.
> This feature is default off. If you want to enable this feature, you can pass
> "hugetlb_free_vmemmap=on" to the boot cmdline. Do you mean that the
> success rate of page migration will decrease when you enable this feature?
> The rate will increase if disbale. Right?

I have done the test and found the issue. Because unmap_and_move_huge_page
always returns -EBUSY. I will look into this issue in depth. Thanks for your
report.

The return point is as below:

if (page_private(hpage) && !page_mapping(hpage)) {
        rc = -EBUSY;
        goto out_unlock;
}

>
> Thanks.
>
>
> >
> > Soft offlining pfn 0x101c00 at process virtual address 0xffff7fa00000
> > soft offline: 0x101c00: hugepage migration failed 1, type bfffc0000010006
> >               (referenced|uptodate|head|node=0|zone=2|lastcpupid=0xffff)
> >
