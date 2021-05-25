Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B1338FCF1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhEYIgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhEYIfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:35:24 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2139C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 01:33:22 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id j75so29521724oih.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 01:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQM339tzjQDy+e5AN5k6Z5xiJOPOU4gvpnM5CS5cM88=;
        b=JnXSgdvulmBzN7d07UQq7gHEgu34LxEKQN4kUkXCH8P/NGiFTgMdXJkK2jUSS7faFK
         ZS99vgSWycL9iiTaejigFNXoTRCc9Jbmb/73grUf657bcbRyQBDF3Bj5PsZipq+E0LWc
         H1WHyK2swgeYi38zVS6eZMBttaeUl5YjKovF3PNlqjxxfVV3yFlzLIV0EfLOLLlBjbkK
         GHgazzdSD3fwiEwPjTm8kwT0hIIVtLrZXU4uMGt/CqjNKgf8JLS/YuXonCz7oLkL7rGM
         GDgBanmbuf+odNb4VYCvDS0/HIoAZViJ9mhlt83LTWt1yV1Ncq2HSrMBPE66n8+AURUA
         hsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQM339tzjQDy+e5AN5k6Z5xiJOPOU4gvpnM5CS5cM88=;
        b=imCPsddC/gyO9kdxqIeMJaKv7MfLhxP9LKhYjxmGP2ZAQUSubZaBLyljbsZEerlCvc
         g6U2GX7tHdq48vt1lhf6/mu0FRWOj4W6toAJeMGthUJpS2prNfBESLhbF7kcEQtxyfvu
         nV9J0XZXw/983Gh+1Tw3MfdsoNK++xHpJByCo7M3Qggk2HAU4sfXF4UhNyD/Z9giM4qZ
         hrb9G0CfqsazqakAjG8Gx0vFmLsicghp3ghuRbKEwRAnmx9OcfHVQSxl1SxWae9swj8R
         Du19011FWvzL+0x+DMguLfH1jjaUUqyxL5ydEmsz+qec/kXMNSFRzr/Gz2BMqWKI7x40
         SImQ==
X-Gm-Message-State: AOAM532UuZbkYRcUgdUmWpv6sFziIGpulpd0TQPPK/rSsDC1rcXF8P2p
        6uf801PMRCwCt7KYvrkF86SoINTnEBIyRaJ1ifC0Y2JoOJ4EQA==
X-Google-Smtp-Source: ABdhPJy5PRLwYjHdPHysnid5s45yudPto4P6iju+8j1kYEQT+qtTBEeb9BDdgu9zyJOYNedROnaE+6/eR/1aq79XTyM=
X-Received: by 2002:a05:6808:1304:: with SMTP id y4mr2151876oiv.20.1621931602411;
 Tue, 25 May 2021 01:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210517112044.233138-1-aisheng.dong@nxp.com> <20210517112044.233138-5-aisheng.dong@nxp.com>
 <a0db36d1-3ad0-ffc7-02ab-dabab346dae9@redhat.com>
In-Reply-To: <a0db36d1-3ad0-ffc7-02ab-dabab346dae9@redhat.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 25 May 2021 16:32:16 +0800
Message-ID: <CAA+hA=SYLyenE-oEy10RzuYr2WF2yh-AuwUvSmrLXP2-oNmU-g@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: rename the global section array to mem_sections
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

On Tue, May 25, 2021 at 3:55 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 17.05.21 13:20, Dong Aisheng wrote:
> > In order to distinguish the struct mem_section for a better code
> > readability and align with kernel doc [1] name below, change the
> > global mem section name to 'mem_sections' from 'mem_section'.
> >
> > [1] Documentation/vm/memory-model.rst
> > "The `mem_section` objects are arranged in a two-dimensional array
> > called `mem_sections`."
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: kexec@lists.infradead.org
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >   include/linux/mmzone.h | 10 +++++-----
> >   kernel/crash_core.c    |  4 ++--
> >   mm/sparse.c            | 16 ++++++++--------
> >   3 files changed, 15 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index fc23e36cb165..b348a06915c5 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1297,9 +1297,9 @@ struct mem_section {
> >   #define SECTION_ROOT_MASK   (SECTIONS_PER_ROOT - 1)
> >
> >   #ifdef CONFIG_SPARSEMEM_EXTREME
> > -extern struct mem_section **mem_section;
> > +extern struct mem_section **mem_sections;
> >   #else
> > -extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
> > +extern struct mem_section mem_sections[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
> >   #endif
> >
> >   static inline unsigned long *section_to_usemap(struct mem_section *ms)
> > @@ -1310,12 +1310,12 @@ static inline unsigned long *section_to_usemap(struct mem_section *ms)
> >   static inline struct mem_section *__nr_to_section(unsigned long nr)
> >   {
> >   #ifdef CONFIG_SPARSEMEM_EXTREME
> > -     if (!mem_section)
> > +     if (!mem_sections)
> >               return NULL;
> >   #endif
> > -     if (!mem_section[SECTION_NR_TO_ROOT(nr)])
> > +     if (!mem_sections[SECTION_NR_TO_ROOT(nr)])
> >               return NULL;
> > -     return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
> > +     return &mem_sections[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
> >   }
> >   extern unsigned long __section_nr(struct mem_section *ms);
> >   extern size_t mem_section_usage_size(void);
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index 29cc15398ee4..fb1180d81b5a 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -414,8 +414,8 @@ static int __init crash_save_vmcoreinfo_init(void)
> >       VMCOREINFO_SYMBOL(contig_page_data);
> >   #endif
> >   #ifdef CONFIG_SPARSEMEM
> > -     VMCOREINFO_SYMBOL_ARRAY(mem_section);
> > -     VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
> > +     VMCOREINFO_SYMBOL_ARRAY(mem_sections);
> > +     VMCOREINFO_LENGTH(mem_sections, NR_SECTION_ROOTS);
> >       VMCOREINFO_STRUCT_SIZE(mem_section);
> >       VMCOREINFO_OFFSET(mem_section, section_mem_map);
> >       VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index df4418c12f04..a96e7e65475f 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -24,12 +24,12 @@
> >    * 1) mem_section   - memory sections, mem_map's for valid memory
> >    */
> >   #ifdef CONFIG_SPARSEMEM_EXTREME
> > -struct mem_section **mem_section;
> > +struct mem_section **mem_sections;
> >   #else
> > -struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
> > +struct mem_section mem_sections[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
> >       ____cacheline_internodealigned_in_smp;
> >   #endif
> > -EXPORT_SYMBOL(mem_section);
> > +EXPORT_SYMBOL(mem_sections);
> >
> >   #ifdef NODE_NOT_IN_PAGE_FLAGS
> >   /*
> > @@ -91,14 +91,14 @@ static int __meminit sparse_index_init(unsigned long section_nr, int nid)
> >        *
> >        * The mem_hotplug_lock resolves the apparent race below.
> >        */
> > -     if (mem_section[root])
> > +     if (mem_sections[root])
> >               return 0;
> >
> >       section = sparse_index_alloc(nid);
> >       if (!section)
> >               return -ENOMEM;
> >
> > -     mem_section[root] = section;
> > +     mem_sections[root] = section;
> >
> >       return 0;
> >   }
> > @@ -131,7 +131,7 @@ unsigned long __section_nr(struct mem_section *ms)
> >   #else
> >   unsigned long __section_nr(struct mem_section *ms)
> >   {
> > -     return (unsigned long)(ms - mem_section[0]);
> > +     return (unsigned long)(ms - mem_sections[0]);
> >   }
> >   #endif
> >
> > @@ -286,8 +286,8 @@ static void __init memblocks_present(void)
> >   #ifdef CONFIG_SPARSEMEM_EXTREME
> >       size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
> >       align = 1 << (INTERNODE_CACHE_SHIFT);
> > -     mem_section = memblock_alloc(size, align);
> > -     if (!mem_section)
> > +     mem_sections = memblock_alloc(size, align);
> > +     if (!mem_sections)
> >               panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> >                     __func__, size, align);
> >   #endif
> >
>
> Smells like unnecessary code churn. I'd rather just fix the doc because
> it doesn't really improve readability IMHO.
>

In  practice I feel it does affect readability that the global
mem_section pointer is mixed
with struct mem_section names which results in:
1. hard to quickly jump between global mem_section operation in a
single source file.
    e.g. by VIM hotkey of search
2. hard to quickly identify all global mem_section operations in
global source files
    by tools, e.g. cscope, grep

This does cause troubles if users want to quickly go through and
understand the code.

Regards
Aisheng

> Anyhow, just my 2 cents.
>
> --
> Thanks,
>
> David / dhildenb
>
