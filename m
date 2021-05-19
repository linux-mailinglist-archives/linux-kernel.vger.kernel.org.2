Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0BC3891BE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354698AbhESOqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354694AbhESOp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:45:57 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEABC061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:44:36 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 10so10065591pfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQ207tTDtBZqiTJyVjjPk14vSj+OnERA+lKMgEJtpXM=;
        b=DmVjnx1ZjRs032XlqXxHAiloqsPT9uEgH+ZCFtXxO75WGMQ+yIVMOREjFBSfKdcPk6
         amm9Jf9y8wOzehHucLNyu+hRK/3aPuEiUJZHLtoItHDP8fRVJSJFLUQ4P/YbAkjH3QMG
         UovuxGYqAl2oJRwqdws9IwP8HVB0wffHwkmBCTbVQRKN54vInasfK0ogNGskkt8WZ1MY
         3CnXrbHOhI61yTSB8kdAVU/x1TgZfLanCDsTvPnZskzKsbHu5Z0i+C/Nmp0F3RiT0cYy
         /4XQhLpTJ9gQz6JnyVYEcZnNfGR4zZ/cWWomewk+lE9EebuhqHLpctOO4xH5PctsNoO/
         yKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQ207tTDtBZqiTJyVjjPk14vSj+OnERA+lKMgEJtpXM=;
        b=Bc/Cw3bnvq7ZF/vAtS0E/Iv+gI6AwuX7pGdKMU/ahy572kzb9ZHNmkrds0XOnfdj+q
         /XibeMahUBrWbExJduIFLTwO/gxMRtwL1Ifp1KIgiwy/N5HoO6e1OHVlSfI5qj3CdTPQ
         rOn3NL5ywI1wfF2o+To3PbUaIZSN+LgLgL1SwOL2833/qxeXS5F/eA2KIslNKd0A3MT/
         IBzT25ay3Gvn7M4Pn86Rc5IWB+YJU4v2cpXHWkl9PLmn3G44bGnFSZA1vxNBH3P2op31
         q4W52SOo+EK1tGD1nSe8PuEKONi0Qq25C3CNRQIux2z+xKlC774lwzok2llHw4mbTxAk
         ETWg==
X-Gm-Message-State: AOAM532LhtFC2VCZkKXFGLJoUg2Txzft3oG0oY/amhZA5LxvCeZyb2n4
        RWQdgTvDkGnorECof1SSxHsKd8PAVieTLQXwAZ1FZQ==
X-Google-Smtp-Source: ABdhPJze7UFgGu+Z4sJ8Sncz473jeSL8WSIjg2sIlnLePNc1MquvL8NNJZ3sUN2wqRSjZXR6j3kclr8T/60SI2r5/Qc=
X-Received: by 2002:a05:6a00:8c7:b029:20f:1cf4:d02 with SMTP id
 s7-20020a056a0008c7b029020f1cf40d02mr10985559pfu.49.1621435476007; Wed, 19
 May 2021 07:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210518091826.36937-1-songmuchun@bytedance.com> <5ae7a4be-dfd5-faf6-a75c-a2adf5a344b2@arm.com>
In-Reply-To: <5ae7a4be-dfd5-faf6-a75c-a2adf5a344b2@arm.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 19 May 2021 22:43:59 +0800
Message-ID: <CAMZfGtVJrnQ6Nb25CON3WupOx-K3BFzQ2t546r0xsT45vZD+4w@mail.gmail.com>
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

On Wed, May 19, 2021 at 8:35 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
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
>
> How does this interact with HugeTLB migration as such which might iterate
> over individual constituent struct pages (overriding the same struct page
> for all tail pages when this feature is enabled). A simple test involving
> madvise(ptr, size, MADV_SOFT_OFFLINE) fails on various HugeTLB page sizes,
> with this patch applied. Although I have not debugged this any further.

It is weird. Actually, I didn't change the behaviour of the page migration.
This feature is default off. If you want to enable this feature, you can pass
"hugetlb_free_vmemmap=on" to the boot cmdline. Do you mean that the
success rate of page migration will decrease when you enable this feature?
The rate will increase if disbale. Right?

Thanks.


>
> Soft offlining pfn 0x101c00 at process virtual address 0xffff7fa00000
> soft offline: 0x101c00: hugepage migration failed 1, type bfffc0000010006
>               (referenced|uptodate|head|node=0|zone=2|lastcpupid=0xffff)
>
