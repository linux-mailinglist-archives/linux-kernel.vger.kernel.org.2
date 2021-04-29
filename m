Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2201336EE12
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 18:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbhD2QYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 12:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbhD2QYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 12:24:18 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951DBC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 09:23:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r12so100762693ejr.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 09:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vbIEl3lX4eniB0Hvy8WsaM/2MqRrw5MYk50XDuG50/k=;
        b=jdPGnDgR4oHvpvgBU8D1+bfyPFm52FlwmZnr7KBh0KJahoFjBPzoJF6/RxcfdHF79s
         DOUwWx2l3GTEL6UutQ23gMFpjPkYBVHN+gLsQTZYhGM5smQ8n7tmfr3afBvuMqOhEoWw
         fmAykk2cHPm4ufRtjBWSVNOA1Upkz01X0Ajyd+HRAik7MeA7PjnrQHvL6UOzKendMJpp
         Fp8tCzgyfsosVZXYUzcUmR93p0z/b53Cy8BE5NM3VgzLtRrSfr17owrYQXGvLmnS8uve
         w+i53kt0WwCQl9WP+NLUdygQq+eWV3KTCDmjTLWRHuvCfUpLnaPiU/n+Symk9u9h6wim
         jX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vbIEl3lX4eniB0Hvy8WsaM/2MqRrw5MYk50XDuG50/k=;
        b=kHy8sKvHu+ruhPs5/jG/MTaKtZCo74bEsI4mvt9owPm53zNuEqvGmCChdIObRY+1cH
         IYUd8PkoLzBhor6fSRWv+zkQYStVpBz/El50CdD2sQS4sINGywulfmBsz7ce0Uchymw0
         +zKlR4LXmdUMiAH2R4/r+3W+5TQ82zDqM40X/Iat3fkCiIWZfPhvbv2gvODA09S6NGSr
         1URya2nAFbZxKOKjdwjhjqtVVOELg1kezdmRweWQz1nCUw7dyQMBYVJm54tABCp0T989
         fi1BhxPRFPferZjIWVmaMOTcNkSZOiD0mHUCXRVJkbaGbuElts4Ia4XoKvZRjpV839Lz
         d6Dg==
X-Gm-Message-State: AOAM530v0E8F2Ab2ITEBBDKsZO/QOKBrQ1Yhunkv7aCqys7gXErxjfHL
        0tRZMOUXUW6UdRKCZpL9T7mY8wrPR3XjzBzmVTM=
X-Google-Smtp-Source: ABdhPJzDImn8USqf4JhV+YGx8Ijv87LOQs9gd6T7X9ndVfJKQWpr9Tzu4CjncLANUbfkLxZ/Fr7NPAbrKYTbPFTkYtw=
X-Received: by 2002:a17:906:4881:: with SMTP id v1mr642169ejq.383.1619713409322;
 Thu, 29 Apr 2021 09:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210429132648.305447-1-linmiaohe@huawei.com> <20210429132648.305447-4-linmiaohe@huawei.com>
 <68c8c4a8-c4f8-83db-7326-dabeea74239c@redhat.com>
In-Reply-To: <68c8c4a8-c4f8-83db-7326-dabeea74239c@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 29 Apr 2021 09:23:17 -0700
Message-ID: <CAHbLzkpRzbXFRpgA3WzA99v5ZzX-LQ0PNHg1EXYf5Vq+hw+8dw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm/huge_memory.c: add missing read-only THP
 checking in transparent_hugepage_enabled()
To:     David Hildenbrand <david@redhat.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, william.kucharski@oracle.com,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        aneesh.kumar@linux.ibm.com, Ralph Campbell <rcampbell@nvidia.com>,
        Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 7:57 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 29.04.21 15:26, Miaohe Lin wrote:
> > Since commit 99cb0dbd47a1 ("mm,thp: add read-only THP support for
> > (non-shmem) FS"), read-only THP file mapping is supported. But it
> > forgot to add checking for it in transparent_hugepage_enabled().
> > To fix it, we add checking for read-only THP file mapping and also
> > introduce helper transhuge_vma_enabled() to check whether thp is
> > enabled for specified vma to reduce duplicated code.
> >
> > Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > ---
> >   include/linux/huge_mm.h | 21 +++++++++++++++++----
> >   mm/huge_memory.c        |  6 ++++++
> >   mm/khugepaged.c         |  4 +---
> >   mm/shmem.c              |  3 +--
> >   4 files changed, 25 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 0a526f211fec..f460b74619fc 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -115,6 +115,16 @@ extern struct kobj_attribute shmem_enabled_attr;
> >
> >   extern unsigned long transparent_hugepage_flags;
> >
> > +static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
> > +                                       unsigned long vm_flags)
>
> You're passing the vma already, why do you pass vma->vm_flags
> separately? It's sufficient to pass in the vma only.

I do agree.

>
> > +{
> > +     /* Explicitly disabled through madvise. */
> > +     if ((vm_flags & VM_NOHUGEPAGE) ||
> > +         test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> > +             return false;
> > +     return true;
> > +}
> > +
> >   /*
> >    * to be used on vmas which are known to support THP.
> >    * Use transparent_hugepage_enabled otherwise
> > @@ -128,15 +138,12 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
> >       if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
> >               return false;
> >
> > -     if (vma->vm_flags & VM_NOHUGEPAGE)
> > +     if (!transhuge_vma_enabled(vma, vma->vm_flags))
> >               return false;
> >
> >       if (vma_is_temporary_stack(vma))
> >               return false;
> >
> > -     if (test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> > -             return false;
> > -
> >       if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
> >               return true;
> >
> > @@ -362,6 +369,12 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> >       return false;
> >   }
> >
> > +static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
> > +                                       unsigned long vm_flags)
> > +{
> > +     return false;
> > +}
> > +
> >   static inline void prep_transhuge_page(struct page *page) {}
> >
> >   static inline bool is_transparent_hugepage(struct page *page)
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 76ca1eb2a223..e24a96de2e37 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -68,12 +68,18 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
> >       /* The addr is used to check if the vma size fits */
> >       unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
> >
> > +     if (!transhuge_vma_enabled(vma, vma->vm_flags))
> > +             return false;
> >       if (!transhuge_vma_suitable(vma, addr))
> >               return false;
> >       if (vma_is_anonymous(vma))
> >               return __transparent_hugepage_enabled(vma);
> >       if (vma_is_shmem(vma))
> >               return shmem_huge_enabled(vma);
> > +     if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
> > +         !inode_is_open_for_write(vma->vm_file->f_inode) &&
> > +         (vma->vm_flags & VM_EXEC))
> > +             return true;
>
> Nit: I'm really wondering why we have 3 different functions that sound
> like they are doing the same thing
>
> transparent_hugepage_enabled(vma)

This one is called by smap code only which does check everything (for
both anonymous and shmem) to decide if allocating THP is possible.
Miaohe Lin's patch adds check for readonly FS THP.

> transhuge_vma_enabled()

This is the helper added by Miaohe Lin in this patch. It checks
VM_NOHUGEPAGE and MMF_DISABLE flags. It helps eliminate some duplicate
code. And this check is called at a couple of different places.

> transhuge_vma_suitable()

This one checks if vma is aligned properly. It may be better to rename
it to transhuge_vma_aligned(). It seems this check is just called by
page fault handler.

>
> Which check belongs where? Does it really have to be that complicated?
>
> >
> >       return false;
> >   }
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 6c0185fdd815..d97b20fad6e8 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -442,9 +442,7 @@ static inline int khugepaged_test_exit(struct mm_struct *mm)
> >   static bool hugepage_vma_check(struct vm_area_struct *vma,
> >                              unsigned long vm_flags)
> >   {
> > -     /* Explicitly disabled through madvise. */
> > -     if ((vm_flags & VM_NOHUGEPAGE) ||
> > -         test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> > +     if (!transhuge_vma_enabled(vma, vm_flags))
> >               return false;
> >
> >       /* Enabled via shmem mount options or sysfs settings. */
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index a08cedefbfaa..1dcbec313c70 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -4032,8 +4032,7 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
> >       loff_t i_size;
> >       pgoff_t off;
> >
> > -     if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> > -         test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> > +     if (!transhuge_vma_enabled(vma, vma->vm_flags))
> >               return false;
> >       if (shmem_huge == SHMEM_HUGE_FORCE)
> >               return true;
> >
>
>
> --
> Thanks,
>
> David / dhildenb
>
>
