Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B063E3BF16B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 23:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhGGVcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 17:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhGGVcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 17:32:00 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E160C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 14:29:19 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i20so5643530ejw.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=12ZCunrDmFOPUQ9ZiI1IP69gcpUIltI9qlCUxX4KPz8=;
        b=naFvC3lT1oFtlwB/+mJJsK5GhxWjIG7nRr4rLTO53iLs6UrTekTPX4oovjq9cTrc8y
         JroMYBygdy3CuxKXIzVNQxbQV1B5v81/y1szt9Lpnwo1yjgIXBOXZKplYbb1XO+9+Vop
         1qNqP2O31UZ7u48iVPhJA4KR4e2ZbCihl+3CG8WFRvM4tt6oU3ItAk3C4DLl+MHiBqMr
         zFBk9AnpLF490TjCUXpKBGnpjIWErydj9rtwqiVX3U6GgpZK4apfDfVd1HMA3/2SBX1M
         pddrg8mRixnqLLozujvCstyyBkBOFsDK2BS99DC1butOugtdIHxE/92+ZytcAdx1JeGD
         B21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=12ZCunrDmFOPUQ9ZiI1IP69gcpUIltI9qlCUxX4KPz8=;
        b=o1I2dgU26+s5jPfsGhNR0ZLf1iG2MiUutN5+qpWoq2nAVis5bayojU4K7Eb4O7kO+8
         YTGT8HZ2cqIs+3yx7KWhusw/g5SAANLHX7XawrPU5ajzovGiXWBSipefRju5+lOQVMa/
         dZ+96CABB0W0HgrWWQ8fJsZrZzd/Ht9p2Bh0op7IYRqHZHP6/viSQZYzqBt4rgM0ofHE
         aOCRI7IFlmD6Tf+7cMjvwMD/ni9poKPWg414umtfct8Tf/0rq1X10NihYTYECCMQMz5Z
         SC+i68hgRo6rxC72uEm/HmVLp1Y0dHKkJFM/i6IWgS0+GgTbUXU3/I97otgOP5NiCj7O
         pLKA==
X-Gm-Message-State: AOAM5316VupBNHuMEsPeA0StPxtaUUYwwaNyl/ij2nESpYR7UWeXJJGi
        jbtWxImIIWMeks/zqtamd0BxqjUjzT2lsTwIOcg=
X-Google-Smtp-Source: ABdhPJwzK7zZeGwvYsnJ35Avvh78YSfwpTP3you+crGsfDPe6ERxvJJO4lY/szwHfqTE/eWyy1Lro0He6t2WFbJV/m4=
X-Received: by 2002:a17:907:75d2:: with SMTP id jl18mr2806442ejc.238.1625693358277;
 Wed, 07 Jul 2021 14:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com> <CAHbLzkpRfJOssBaNpch1OjJbgLc-BbSa+N9Ntay2NixNiQb0pg@mail.gmail.com>
In-Reply-To: <CAHbLzkpRfJOssBaNpch1OjJbgLc-BbSa+N9Ntay2NixNiQb0pg@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 7 Jul 2021 14:29:06 -0700
Message-ID: <CAHbLzkpoYA7RYx1r8w44ZJX564adxrRMQ7SoBzJX04kV7ksE=g@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/rmap: fix comments left over from recent changes
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 2:26 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Wed, Jul 7, 2021 at 1:06 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > Parallel developments in mm/rmap.c have left behind some out-of-date
> > comments: try_to_migrate_one() also accepts TTU_SYNC (already commented
> > in try_to_migrate() itself), and try_to_migrate() returns nothing at all.
> >
> > TTU_SPLIT_FREEZE has just been deleted, so reword the comment about it in
> > mm/huge_memory.c; and TTU_IGNORE_ACCESS was removed in 5.11, so delete
>
> I just realized this. Currently unmap_page() just unmaps file pages
> when splitting THP. But it seems this may cause some trouble for page
> cache speculative get for the below case IIUC. Am I missing something?
>
>     CPU A                  CPU B
> unmap_page()
> ...
> freeze refcount
>                               find_get_page() ->
>                                   __page_cache_add_speculative() ->
>                                       VM_BUG_ON_PAGE(page_count(page)
> == 0, page); //When CONFIG_TINY_RCU is enabled
>
>
> The race is acceptable, I think we could replace the VM_BUG_ON to
> page_ref_add_unless(), just like !CONFIG_TINY_RCU case.

Please just disregard the above comment, I just found CONFIG_TINY_RCU
is for UP only. Sorry for the noise.

>
>
> > the "recently referenced" comment from try_to_unmap_one() (once upon a
> > time the comment was near the removed codeblock, but they drifted apart).
> >
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >  mm/huge_memory.c | 2 +-
> >  mm/rmap.c        | 7 +------
> >  2 files changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 8b731d53e9f4..afff3ac87067 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2331,7 +2331,7 @@ static void remap_page(struct page *page, unsigned int nr)
> >  {
> >         int i;
> >
> > -       /* If TTU_SPLIT_FREEZE is ever extended to file, remove this check */
> > +       /* If unmap_page() uses try_to_migrate() on file, remove this check */
> >         if (!PageAnon(page))
> >                 return;
> >         if (PageTransHuge(page)) {
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 37c24672125c..746013e282c3 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1439,8 +1439,6 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> >         while (page_vma_mapped_walk(&pvmw)) {
> >                 /*
> >                  * If the page is mlock()d, we cannot swap it out.
> > -                * If it's recently referenced (perhaps page_referenced
> > -                * skipped over this mm) then we should reactivate it.
> >                  */
> >                 if (!(flags & TTU_IGNORE_MLOCK)) {
> >                         if (vma->vm_flags & VM_LOCKED) {
> > @@ -1687,8 +1685,7 @@ void try_to_unmap(struct page *page, enum ttu_flags flags)
> >   * @arg: enum ttu_flags will be passed to this argument.
> >   *
> >   * If TTU_SPLIT_HUGE_PMD is specified any PMD mappings will be split into PTEs
> > - * containing migration entries. This and TTU_RMAP_LOCKED are the only supported
> > - * flags.
> > + * containing migration entries.
> >   */
> >  static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
> >                      unsigned long address, void *arg)
> > @@ -1928,8 +1925,6 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
> >   *
> >   * Tries to remove all the page table entries which are mapping this page and
> >   * replace them with special swap entries. Caller must hold the page lock.
> > - *
> > - * If is successful, return true. Otherwise, false.
> >   */
> >  void try_to_migrate(struct page *page, enum ttu_flags flags)
> >  {
> > --
> > 2.26.2
> >
