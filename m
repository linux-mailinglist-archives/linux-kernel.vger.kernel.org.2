Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63188396B7B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 04:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhFACl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 22:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhFAClZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 22:41:25 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE0CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 19:39:44 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso5856869otu.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 19:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=66WU/OYhf8/UwAHOYjWvVcdDw9Pdav8Sh+qnUyaTJQ0=;
        b=iI0ft9pTkdeQ+G3YXcWQ64+QUUe2EJaVkfUFE2rQHO4oH5yrpUI/qQwPf5/YL90iIE
         SRQLBswZOiJVcAOot6MJCRF+lMOrVRa+/DGGvg8jQ7pjcShdaGRsXuPVVPRMA3YbMRYo
         jcPSA0E1qvnQq8rM66I+jR+d8jaFbApUbREvIUSb4Gn5kGQK+RaCJ5ymjvAyxdhb2ts+
         CQFUlZiNPA0nC2ddGhx1yh/V/MQMxyinO+tiskMYtuEeffMevJlzyYnFFz43bhtXjIM9
         qkodMlUoSgBekhrFg7+9TJCTDmqL9PedufkEJFkjH8ryUwCTxFV5Arq+KpP6hGuaSSER
         tUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66WU/OYhf8/UwAHOYjWvVcdDw9Pdav8Sh+qnUyaTJQ0=;
        b=rVV8yUir5TobMZeH6n2ouNng10zKB1w9AZhWx8lwHAT735InzVqFH3oYyTFGZ9/PMT
         icD9JcWoHrvegnUwbatBqgSOei1d3CuOdz1cL5vCoLz4njnhWbUgkp+MBtBX6cHaga3u
         0UoQ55YP0eAndPmQGKqoAzk+paKZ44IYuojIppTm6Faat/FmjgqOHgM49098oF32eqww
         0o9u0gWmS8G3a2OFSdztizF7hsTahj5iYLD1OGGG2QYa68PbibhuSllYgGFuYFIUOLfg
         7b4TVDW6EHOMZlqdvbwz1l0cBKktfJyoNm1NsnEn7vIvGQUejIxBfOO6nHQ1w1pP3Iln
         o+Cg==
X-Gm-Message-State: AOAM532RMgSVBX5M8wbtbdcnGzKQ6RauC5ZSQ507Lo2jl68Ff1Cz26yZ
        /ujzzctRTfFdGAQnRz7B/6e6NKwC1zlNzct1b2HKofkB
X-Google-Smtp-Source: ABdhPJyaCX9j4/a2SojGeqejlEl0P1R12d7cCtEIMzCFq1CDU7S9DzIwCeoBjLRanURsESoqB84hoc+gw2uj+yIE4M8=
X-Received: by 2002:a9d:4d99:: with SMTP id u25mr6678833otk.248.1622515184264;
 Mon, 31 May 2021 19:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-4-aisheng.dong@nxp.com> <20210531143852.h226vpjrgpyo2eqw@revolver>
In-Reply-To: <20210531143852.h226vpjrgpyo2eqw@revolver>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 1 Jun 2021 10:38:33 +0800
Message-ID: <CAA+hA=Q0d14zkqibpNGWHaMTgFqot8YX71SHfnS4VTV3vMyXnw@mail.gmail.com>
Subject: Re: [PATCH V2 3/6] mm/sparse: move mem_sections allocation out of memory_present()
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 10:39 PM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Dong Aisheng <aisheng.dong@nxp.com> [210531 05:20]:
> > The only path to call memory_present() is from memblocks_present().
> > The struct mem_section **mem_section only needs to be initialized once,
> > so no need put the initialization/allocation code in memory_present()
> > which will be called multiple times for each section.
> >
> > After moving, the 'unlikely' condition statement becomes to be
> > meaningless as it's only initialized one time, so dropped as well.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > ChangeLog:
> > v1->v2:
> >  * split into a helper function and called directly from sparse_init
> > ---
> >  mm/sparse.c | 29 ++++++++++++++++-------------
> >  1 file changed, 16 insertions(+), 13 deletions(-)
> >
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 408b737e168e..d02ee6bb7cbc 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -60,6 +60,18 @@ static inline void set_section_nid(unsigned long section_nr, int nid)
> >  #endif
> >
> >  #ifdef CONFIG_SPARSEMEM_EXTREME
> > +static void __init sparse_alloc_section_roots(void)
> > +{
> > +     unsigned long size, align;
> > +
> > +     size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
> > +     align = 1 << (INTERNODE_CACHE_SHIFT);
> > +     mem_section = memblock_alloc(size, align);
> > +     if (!mem_section)
> > +             panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> > +                   __func__, size, align);
> > +}
> > +
> >  static noinline struct mem_section __ref *sparse_index_alloc(int nid)
> >  {
> >       struct mem_section *section = NULL;
> > @@ -107,6 +119,8 @@ static inline int sparse_index_init(unsigned long section_nr, int nid)
> >  {
> >       return 0;
> >  }
> > +
> > +static inline void sparse_alloc_section_roots(void) {}
> >  #endif
> >
> >  #ifdef CONFIG_SPARSEMEM_EXTREME
> > @@ -254,19 +268,6 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
> >  {
> >       unsigned long pfn;
> >
> > -#ifdef CONFIG_SPARSEMEM_EXTREME
> > -     if (unlikely(!mem_section)) {
> > -             unsigned long size, align;
> > -
> > -             size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
> > -             align = 1 << (INTERNODE_CACHE_SHIFT);
> > -             mem_section = memblock_alloc(size, align);
> > -             if (!mem_section)
> > -                     panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> > -                           __func__, size, align);
> > -     }
> > -#endif
> > -
> >       start &= PAGE_SECTION_MASK;
> >       mminit_validate_memmodel_limits(&start, &end);
> >       for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
> > @@ -582,6 +583,8 @@ void __init sparse_init(void)
> >       unsigned long pnum_end, pnum_begin, map_count = 1;
> >       int nid_begin;
> >
> > +     sparse_alloc_section_roots();
>
> nit: The newline below is unnecessary
>

Can drop it , thanks

Regards
AIsheng

> > +
> >       memblocks_present();
> >
> >       pnum_begin = first_present_section_nr();
> > --
> > 2.25.1
> >
> >
