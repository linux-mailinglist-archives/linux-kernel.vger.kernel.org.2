Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DF1396F4B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhFAIsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbhFAIrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:47:45 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D33C061348
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 01:46:01 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so13424479otc.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 01:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvnZa/3GSWoijoWUP996Kg50ie5gi3CPyJfodx+nuj0=;
        b=Nm5Z+r3e6oXn/WlBAHuSatC+Zo4ChEuTrkW4GYAtxAnuTcS8ijCh9zciZfzaGMAbLe
         HwZZVgOp01U37i19k0ig3zBH8zqT5saOozaec5th3B00AAtDQW7NBV+yO63SGWAgaH6q
         ZzpIVmIYvlhwKNY884ZMyaqFTyErDAWoGe4gUkYRRmCwm9cxwknSHzfofDMd2mT3HcBQ
         Bb4+Yt/9ua1LM6uaoDAkno+wfqN9ryawjaBoDzwCWBKx3Scri/hH+hLnAhtyA+3SoAcV
         QR+yzBKTe/qJy9Iz1+vBG8Hquz4NeCqN5wz0YWIsW8m7mBLlS3WLsiLeg3uq5f2jfK41
         HqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvnZa/3GSWoijoWUP996Kg50ie5gi3CPyJfodx+nuj0=;
        b=SJd9enJL0GTFV6rAzgGv68XduTR6/N0w76yfFyIg9NBG/IplU9UL8p+1jhq9v/X0lE
         pTVp06m7P35C260kgK4DPeHyH3EkDkrlmAIJI3H1sJWDkoCO06qPblnsj4HYXzPxZZYb
         Ghw2xhH1Zh+yGY5qi7a6AAJj/z0g/njivcW9gCh6+pykG/sB/5Eg5/PUju5KebAj+Hek
         DkvVjilz6QL1s9q4RET9oFz3InY2EXon1xfA93vg7MApb8VdierET3CSWzIiVtqsLH2L
         O1AOoAVrljlHshH0xglZruTTnkf60lwaJnArXgp/Vkpr8gLGWuJnLwhIWMoZiye0dfDi
         gdDg==
X-Gm-Message-State: AOAM533N198VMwwfo0EBy75cK3mrXE3djyin/CO/QNPyp5wEXMJyhWDS
        f73/FVhKdT19Vc/xAjzCYyOio5fASNFrUMlROko//E88
X-Google-Smtp-Source: ABdhPJyFMV+qnkun3wPnfMnzQCAc/g3cwnJpVtSi+3/UR2QQDOtEF6tNOzyRVc8MK481WPpd5qi/KUtmK8FX72qE3uQ=
X-Received: by 2002:a9d:4115:: with SMTP id o21mr20597434ote.52.1622537160686;
 Tue, 01 Jun 2021 01:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-5-aisheng.dong@nxp.com> <42617372-c846-85fe-4739-abbe55eca8f6@redhat.com>
 <CAA+hA=Ss4j8qeoe7RtDJ14nuqy+TpOk2qi-A9+YN6=2y8c_CGg@mail.gmail.com> <f7f77368-72cf-e15d-cc3c-b0ddf86e14fd@redhat.com>
In-Reply-To: <f7f77368-72cf-e15d-cc3c-b0ddf86e14fd@redhat.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 1 Jun 2021 16:44:50 +0800
Message-ID: <CAA+hA=SEKczg-tkyEQSHR=HxE8vB5Acvf-HPGy3E-0apdkZ8FA@mail.gmail.com>
Subject: Re: [PATCH V2 4/6] mm: rename the global section array to mem_sections
To:     David Hildenbrand <david@redhat.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 4:40 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 01.06.21 10:37, Dong Aisheng wrote:
> > On Tue, Jun 1, 2021 at 4:22 PM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 31.05.21 11:19, Dong Aisheng wrote:
> >>> In order to distinguish the struct mem_section for a better code
> >>> readability and align with kernel doc [1] name below, change the
> >>> global mem section name to 'mem_sections' from 'mem_section'.
> >>>
> >>> [1] Documentation/vm/memory-model.rst
> >>> "The `mem_section` objects are arranged in a two-dimensional array
> >>> called `mem_sections`."
> >>>
> >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>> Cc: Dave Young <dyoung@redhat.com>
> >>> Cc: Baoquan He <bhe@redhat.com>
> >>> Cc: Vivek Goyal <vgoyal@redhat.com>
> >>> Cc: kexec@lists.infradead.org
> >>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >>> ---
> >>> v1->v2:
> >>>    * no changes
> >>> ---
> >>>    include/linux/mmzone.h | 10 +++++-----
> >>>    kernel/crash_core.c    |  4 ++--
> >>>    mm/sparse.c            | 16 ++++++++--------
> >>>    3 files changed, 15 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> >>> index a6bfde85ddb0..0ed61f32d898 100644
> >>> --- a/include/linux/mmzone.h
> >>> +++ b/include/linux/mmzone.h
> >>> @@ -1302,9 +1302,9 @@ struct mem_section {
> >>>    #define SECTION_ROOT_MASK   (SECTIONS_PER_ROOT - 1)
> >>>
> >>>    #ifdef CONFIG_SPARSEMEM_EXTREME
> >>> -extern struct mem_section **mem_section;
> >>> +extern struct mem_section **mem_sections;
> >>>    #else
> >>> -extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
> >>> +extern struct mem_section mem_sections[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
> >>>    #endif
> >>>
> >>>    static inline unsigned long *section_to_usemap(struct mem_section *ms)
> >>> @@ -1315,12 +1315,12 @@ static inline unsigned long *section_to_usemap(struct mem_section *ms)
> >>>    static inline struct mem_section *__nr_to_section(unsigned long nr)
> >>>    {
> >>>    #ifdef CONFIG_SPARSEMEM_EXTREME
> >>> -     if (!mem_section)
> >>> +     if (!mem_sections)
> >>>                return NULL;
> >>>    #endif
> >>> -     if (!mem_section[SECTION_NR_TO_ROOT(nr)])
> >>> +     if (!mem_sections[SECTION_NR_TO_ROOT(nr)])
> >>>                return NULL;
> >>> -     return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
> >>> +     return &mem_sections[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
> >>>    }
> >>>    extern unsigned long __section_nr(struct mem_section *ms);
> >>>    extern size_t mem_section_usage_size(void);
> >>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> >>> index 29cc15398ee4..fb1180d81b5a 100644
> >>> --- a/kernel/crash_core.c
> >>> +++ b/kernel/crash_core.c
> >>> @@ -414,8 +414,8 @@ static int __init crash_save_vmcoreinfo_init(void)
> >>>        VMCOREINFO_SYMBOL(contig_page_data);
> >>>    #endif
> >>>    #ifdef CONFIG_SPARSEMEM
> >>> -     VMCOREINFO_SYMBOL_ARRAY(mem_section);
> >>> -     VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
> >>> +     VMCOREINFO_SYMBOL_ARRAY(mem_sections);
> >>> +     VMCOREINFO_LENGTH(mem_sections, NR_SECTION_ROOTS);
> >>>        VMCOREINFO_STRUCT_SIZE(mem_section);
> >>>        VMCOREINFO_OFFSET(mem_section, section_mem_map);
> >>>        VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
> >>> diff --git a/mm/sparse.c b/mm/sparse.c
> >>> index d02ee6bb7cbc..6412010478f7 100644
> >>> --- a/mm/sparse.c
> >>> +++ b/mm/sparse.c
> >>> @@ -24,12 +24,12 @@
> >>>     * 1) mem_section   - memory sections, mem_map's for valid memory
> >>>     */
> >>>    #ifdef CONFIG_SPARSEMEM_EXTREME
> >>> -struct mem_section **mem_section;
> >>> +struct mem_section **mem_sections;
> >>>    #else
> >>> -struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
> >>> +struct mem_section mem_sections[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
> >>>        ____cacheline_internodealigned_in_smp;
> >>>    #endif
> >>> -EXPORT_SYMBOL(mem_section);
> >>> +EXPORT_SYMBOL(mem_sections);
> >>>
> >>>    #ifdef NODE_NOT_IN_PAGE_FLAGS
> >>>    /*
> >>> @@ -66,8 +66,8 @@ static void __init sparse_alloc_section_roots(void)
> >>>
> >>>        size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
> >>>        align = 1 << (INTERNODE_CACHE_SHIFT);
> >>> -     mem_section = memblock_alloc(size, align);
> >>> -     if (!mem_section)
> >>> +     mem_sections = memblock_alloc(size, align);
> >>> +     if (!mem_sections)
> >>>                panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> >>>                      __func__, size, align);
> >>>    }
> >>> @@ -103,14 +103,14 @@ static int __meminit sparse_index_init(unsigned long section_nr, int nid)
> >>>         *
> >>>         * The mem_hotplug_lock resolves the apparent race below.
> >>>         */
> >>> -     if (mem_section[root])
> >>> +     if (mem_sections[root])
> >>>                return 0;
> >>>
> >>>        section = sparse_index_alloc(nid);
> >>>        if (!section)
> >>>                return -ENOMEM;
> >>>
> >>> -     mem_section[root] = section;
> >>> +     mem_sections[root] = section;
> >>>
> >>>        return 0;
> >>>    }
> >>> @@ -145,7 +145,7 @@ unsigned long __section_nr(struct mem_section *ms)
> >>>    #else
> >>>    unsigned long __section_nr(struct mem_section *ms)
> >>>    {
> >>> -     return (unsigned long)(ms - mem_section[0]);
> >>> +     return (unsigned long)(ms - mem_sections[0]);
> >>>    }
> >>>    #endif
> >>>
> >>>
> >>
> >> I repeat: unnecessary code churn IMHO.
> >
> > Hi David,
> >
> > Thanks, i explained the reason during my last reply.
> > Andrew has already picked this patch to -mm tree.
>
> Just because it's in Andrews tree doesn't mean it will end up upstream. ;)
>
> Anyhow, no really strong opinion, it's simply unnecessary code churn
> that makes bisecting harder without real value IMHO.

In my practice, it helps improve the code reading efficiency with
scope and vim hotkey.
Before the change, I really feel mixed definition causes troubles in
reading code efficiently.
Anyway, that's my personal experience while others may have different options.
Thanks for the feedback.

Regards
Aisheng

>
> --
> Thanks,
>
> David / dhildenb
>
