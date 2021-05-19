Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B04B38938B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355199AbhESQX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242363AbhESQXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:23:54 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6613BC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:22:34 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id f22so1881653pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N1WhLH5NJ9UaJpTzcOfd4vqrvZqnaGoNvuxywAdx8ds=;
        b=LEtQwpwK+XAuFQ94W6UVlTFv8EG8QC6SeS3N9mo4T0CYTRRniNvwYGybTilAv0QBhr
         WmWV0ydah7TeAbWbwMNR8sHMiEZL2erSek+eqLexmf6aeZOKWK/LUOBnxeInnYf0lkY1
         7CLKKmhVdFWLodPSa1UkfGnTKUhnHwJM7w6G+SfFlsaZCwUdlwqs7lwZ7xfIx1ryQegd
         l4F0AyQrNOMRvORXBMwgiv/OF1sZn9WXAeSFDnxKmduxSrrOtRcU4MpgvHFmzP2RUU+C
         dzNXEPwxEIQbuaGtj03bYOjKPwM2ONoMis/WhoCyoOdPBmJQKCfa1G0nakedqbM1UCYL
         5Anw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N1WhLH5NJ9UaJpTzcOfd4vqrvZqnaGoNvuxywAdx8ds=;
        b=Tg2Iq4ccmYHevtU1Zrr0of9gwn8dvE+qT0lhi0nVkozPmlja/mghp4OmnRTkrCqI+7
         OsqsVpFO5xh7YcTQcsbHbdaBgv57hyMLwvRwWMHjKMms9Y61oRliJwqCOZVvvn8/iRUs
         lHqkLIVQJq6sPWyBDgNmYa0Xrsz4XQLD0Jve22ArgPoEqkPBvKWvaWhp73aTNpKK4xJO
         lyV6pwny1DoBHggN8Wri6nlHXKEIC4k5d+IxO+y9YMPglP9TYmAQQvn1FEUl3c4l83U0
         BZzEyJuTnw/QNE2RuQiOuDV/WlyW62MfCsB4OQ/miZrDbTVC5JOuilVGl3ZScZ0yXJuF
         2LKg==
X-Gm-Message-State: AOAM533bYae4zQPSUDl7Gq0uqtbPoR9j9yeUM+GNPXPLQOseKItyC9Du
        najXNFcndafB8o+lDNzq5YCJGXcb3sVJ1hFra9+Znw==
X-Google-Smtp-Source: ABdhPJydyqLgiUphzSBR2+wh4S2N9ksRc5LSFg+dSGj8S6+oWaOPTEr57Kj+8ujuiJqTeQDKz1IYJt4rGthjXHiO0h0=
X-Received: by 2002:aa7:88c8:0:b029:2de:7b37:7d23 with SMTP id
 k8-20020aa788c80000b02902de7b377d23mr8862758pff.59.1621441353905; Wed, 19 May
 2021 09:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210518091826.36937-1-songmuchun@bytedance.com>
 <5ae7a4be-dfd5-faf6-a75c-a2adf5a344b2@arm.com> <CAMZfGtVJrnQ6Nb25CON3WupOx-K3BFzQ2t546r0xsT45vZD+4w@mail.gmail.com>
 <CAMZfGtWpu=pDqn2WZ4QPTevvHmjMaXg8oN8rh1KCDXwievzNrw@mail.gmail.com>
In-Reply-To: <CAMZfGtWpu=pDqn2WZ4QPTevvHmjMaXg8oN8rh1KCDXwievzNrw@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 20 May 2021 00:21:57 +0800
Message-ID: <CAMZfGtUOmFQCXYKq3V=bJs1Ve6kgnT_o_LhsY0gitOY+D7T10A@mail.gmail.com>
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

On Wed, May 19, 2021 at 11:22 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Wed, May 19, 2021 at 10:43 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > On Wed, May 19, 2021 at 8:35 PM Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> > >
> > >
> > > On 5/18/21 2:48 PM, Muchun Song wrote:
> > > > The preparation of supporting freeing vmemmap associated with each
> > > > HugeTLB page is ready, so we can support this feature for arm64.
> > > >
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > ---
> > > >  arch/arm64/mm/mmu.c | 5 +++++
> > > >  fs/Kconfig          | 2 +-
> > > >  2 files changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > > > index 5d37e461c41f..967b01ce468d 100644
> > > > --- a/arch/arm64/mm/mmu.c
> > > > +++ b/arch/arm64/mm/mmu.c
> > > > @@ -23,6 +23,7 @@
> > > >  #include <linux/mm.h>
> > > >  #include <linux/vmalloc.h>
> > > >  #include <linux/set_memory.h>
> > > > +#include <linux/hugetlb.h>
> > > >
> > > >  #include <asm/barrier.h>
> > > >  #include <asm/cputype.h>
> > > > @@ -1134,6 +1135,10 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
> > > >       pmd_t *pmdp;
> > > >
> > > >       WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
> > > > +
> > > > +     if (is_hugetlb_free_vmemmap_enabled() && !altmap)
> > > > +             return vmemmap_populate_basepages(start, end, node, altmap);
> > > > +
> > > >       do {
> > > >               next = pmd_addr_end(addr, end);
> > > >
> > > > diff --git a/fs/Kconfig b/fs/Kconfig
> > > > index 6ce6fdac00a3..02c2d3bf1cb8 100644
> > > > --- a/fs/Kconfig
> > > > +++ b/fs/Kconfig
> > > > @@ -242,7 +242,7 @@ config HUGETLB_PAGE
> > > >
> > > >  config HUGETLB_PAGE_FREE_VMEMMAP
> > > >       def_bool HUGETLB_PAGE
> > > > -     depends on X86_64
> > > > +     depends on X86_64 || ARM64
> > > >       depends on SPARSEMEM_VMEMMAP
> > > >
> > > >  config MEMFD_CREATE
> > > >
> > >
> > > How does this interact with HugeTLB migration as such which might iterate
> > > over individual constituent struct pages (overriding the same struct page
> > > for all tail pages when this feature is enabled). A simple test involving
> > > madvise(ptr, size, MADV_SOFT_OFFLINE) fails on various HugeTLB page sizes,
> > > with this patch applied. Although I have not debugged this any further.
> >
> > It is weird. Actually, I didn't change the behaviour of the page migration.
> > This feature is default off. If you want to enable this feature, you can pass
> > "hugetlb_free_vmemmap=on" to the boot cmdline. Do you mean that the
> > success rate of page migration will decrease when you enable this feature?
> > The rate will increase if disbale. Right?
>
> I have done the test and found the issue. Because unmap_and_move_huge_page
> always returns -EBUSY. I will look into this issue in depth. Thanks for your
> report.
>
> The return point is as below:
>
> if (page_private(hpage) && !page_mapping(hpage)) {
>         rc = -EBUSY;
>         goto out_unlock;
> }

I know the issue. It was caused by commit d6995da31122 ("hugetlb:
use page.private for hugetlb specific page flags"). The below patch
can fix this issue.

diff --git a/mm/migrate.c b/mm/migrate.c
index e7a173da74ec..43419c4bb097 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1290,7 +1290,7 @@ static int unmap_and_move_huge_page(new_page_t
get_new_page,
         * page_mapping() set, hugetlbfs specific move page routine will not
         * be called and we could leak usage counts for subpools.
         */
-       if (page_private(hpage) && !page_mapping(hpage)) {
+       if (hugetlb_page_subpool(hpage) && !page_mapping(hpage)) {
                rc = -EBUSY;
                goto out_unlock;
        }

>
> >
> > Thanks.
> >
> >
> > >
> > > Soft offlining pfn 0x101c00 at process virtual address 0xffff7fa00000
> > > soft offline: 0x101c00: hugepage migration failed 1, type bfffc0000010006
> > >               (referenced|uptodate|head|node=0|zone=2|lastcpupid=0xffff)
> > >
