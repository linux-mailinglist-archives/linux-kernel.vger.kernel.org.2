Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A63C396F10
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhFAIkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhFAIkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:40:01 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB0FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 01:38:19 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id b25so14799720oic.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 01:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K09IrAPvE5MRHX04mzk8Ep22b0oA6uTwLbtqAfJZpmg=;
        b=kwK+0+A7cU3Lg8ENKdtiM5H6fVDzdAXZKYRFirp5TubNr1ftKW68Qo7/q/EajAMLzb
         dcp3sW3u4fPRVuqJQdwLYbLNM8LGaw9IMdcLtAtz5Y7BuN4A+i3FwIqL1DYMg48GGVi3
         1wGiD2B3S7sqXvDVnpeGRsRYzTD5TgY7lMdx5DuZrHNuLN4V71RdJX5TrlnodrvKgdHs
         klls8bjfC1UKdyk8NCtBIV2IF1qh8QiBbvR6WnQ+IGWN0lDDWPPyqOQi9A81NAo9Ixia
         sSaNt21doMN6yY52ckEWeGcCQIb1hEqKjbM/+SqaChK8T8MdW4dOx/I4jH8N6rDhb4Qa
         uf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K09IrAPvE5MRHX04mzk8Ep22b0oA6uTwLbtqAfJZpmg=;
        b=XQT/RDCJ7DCfzxdZvhBA8sgiPHBJgU1PbY2MXv4JfAxZgonBGZ1a2zaohPK+w49G3V
         ReR5waygxO5PNk6+fQT6DHenfOFopJviDRzrA6Vh4oJPruj/2/5nje2MoT7aw9Sntotj
         G2NNqYLbFN5j+fEL4+gZtFuo0P/B/jrc2dtjV32B6FLez3txZ/K626OAKIIm2UavUPMh
         rjowNRnc0OwNIhIue7tuNlnZSHPS4ERM5P3DTw/Ji57iK6p1QscbiID9rD1iNF7z8d0A
         2ecG7J7QAPLa6QJgTOQ2vlfcN76wSfXQy4Mu7r36nzGFJ3Orn15f5alhEAapOmLfvOBD
         L2Dg==
X-Gm-Message-State: AOAM532Ssr7o8fnbgXYkgLMoFohLPyZd1FO9uthaAEYbHjF0rkbMqmEP
        OW/ysTfz91Zq+uPGeijnx3GcS6J4dS9a9pEgRGM=
X-Google-Smtp-Source: ABdhPJzY7sFVuTKvPueCDIaGrQGiywebbawmgY4Hva/tfGpmiRT1VKGbQo8mnYoZrCIoua423h0uSQX7FbN49FTXO0g=
X-Received: by 2002:a54:460a:: with SMTP id p10mr2359145oip.47.1622536698682;
 Tue, 01 Jun 2021 01:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-5-aisheng.dong@nxp.com> <42617372-c846-85fe-4739-abbe55eca8f6@redhat.com>
In-Reply-To: <42617372-c846-85fe-4739-abbe55eca8f6@redhat.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 1 Jun 2021 16:37:08 +0800
Message-ID: <CAA+hA=Ss4j8qeoe7RtDJ14nuqy+TpOk2qi-A9+YN6=2y8c_CGg@mail.gmail.com>
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

On Tue, Jun 1, 2021 at 4:22 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 31.05.21 11:19, Dong Aisheng wrote:
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
> > v1->v2:
> >   * no changes
> > ---
> >   include/linux/mmzone.h | 10 +++++-----
> >   kernel/crash_core.c    |  4 ++--
> >   mm/sparse.c            | 16 ++++++++--------
> >   3 files changed, 15 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index a6bfde85ddb0..0ed61f32d898 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1302,9 +1302,9 @@ struct mem_section {
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
> > @@ -1315,12 +1315,12 @@ static inline unsigned long *section_to_usemap(struct mem_section *ms)
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
> > index d02ee6bb7cbc..6412010478f7 100644
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
> > @@ -66,8 +66,8 @@ static void __init sparse_alloc_section_roots(void)
> >
> >       size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
> >       align = 1 << (INTERNODE_CACHE_SHIFT);
> > -     mem_section = memblock_alloc(size, align);
> > -     if (!mem_section)
> > +     mem_sections = memblock_alloc(size, align);
> > +     if (!mem_sections)
> >               panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> >                     __func__, size, align);
> >   }
> > @@ -103,14 +103,14 @@ static int __meminit sparse_index_init(unsigned long section_nr, int nid)
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
> > @@ -145,7 +145,7 @@ unsigned long __section_nr(struct mem_section *ms)
> >   #else
> >   unsigned long __section_nr(struct mem_section *ms)
> >   {
> > -     return (unsigned long)(ms - mem_section[0]);
> > +     return (unsigned long)(ms - mem_sections[0]);
> >   }
> >   #endif
> >
> >
>
> I repeat: unnecessary code churn IMHO.

Hi David,

Thanks, i explained the reason during my last reply.
Andrew has already picked this patch to -mm tree.

Regards
Aisheng

>
> --
> Thanks,
>
> David / dhildenb
>
