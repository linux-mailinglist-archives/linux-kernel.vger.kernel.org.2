Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1675539BF4D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 20:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhFDSG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 14:06:57 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:46635 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhFDSG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 14:06:57 -0400
Received: by mail-ed1-f41.google.com with SMTP id r11so12096491edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 11:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6u9C0rQYVqsqXWtKWXaZKVuAhwcfVIDbCc3WqpmlEfI=;
        b=bh+P6SnyBZhy0DEY5x4DSE64ESRBzAhai4VcVhkTO6HeqqvIGGJYdqQ+fvs0wH7oHw
         mEbNEWYmaXRaho8uWkVTlTTUGPDgjRKgxDqMXO80dSFa1i/aaMKXHWiq6JV6ilPFNIyt
         3mGpEgzuehIcqqJ8cE3kVbPnoNRSt6fh2QUEMYcGI1amHyTu3eEnyYcEwEUubEntPx7I
         lrb+Itjkm8OkqZuEZTBqkLnqqEhXtMEh56rJWFHcgzBKn0GKkFCjv8uyZBZuEHdx1fZS
         Xv5kmFpaYLig1h+PqYwH8mXlcZMoRmfnqFbOdBvooV/QZpKAcoQF5dd8WuirlRAnbynf
         Zzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6u9C0rQYVqsqXWtKWXaZKVuAhwcfVIDbCc3WqpmlEfI=;
        b=Yby8z0ggoWJ6n4Wb7Dmbcvt30b37McTOV3+r6GdYzeoAm6qjjTxhztES+lRm/+6T36
         CLVug4QswKnYuZEmEcA2h9rsObbmHK2W0Ie/Y/9/Ql6rwadZQSiptWuF5MVodCflYvCn
         UiPcADMtUtGIU5AoqP4mKvf6I7GzQx6ADDnGtGrjW041Kb9Mwn0fdtzM7qcr76VP/M7e
         JhypDdUgRvHQnAdAwjtMCtfyQ3ovUBbEMBF1zoG6lZhZ0Nb0QIzc4jigtfbuqA3R7XUY
         O14l1dhBE563pLLOzoh3FbFPPtffzoOX/SXkP1stPGoVGukTrFJODTLyE6gl4S4z2HLt
         5C7w==
X-Gm-Message-State: AOAM531kBGLBhISL6k6J2t/cFcaGoPbxx4z8lPnzMt1je8pnHLSmigCc
        9Y/SuGK60KU88i6NgDnXctMlRJOC99nneE5N0t8=
X-Google-Smtp-Source: ABdhPJzd2i7kOilHUilrYn48mb+/d5wsI1lPzkORiARU4thKOVGUUOGv9XEKCnHISX/VNj4NIvYizYKQu8FTbG2FX5Q=
X-Received: by 2002:a05:6402:1d0f:: with SMTP id dg15mr3375544edb.137.1622829849830;
 Fri, 04 Jun 2021 11:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
 <alpine.LSU.2.11.2106011403540.2148@eggly.anvils> <CAHbLzkobMaW15iN6y8Zot3kmpA1c4z2r6rSR7B9Pqwg5YY+hcA@mail.gmail.com>
 <alpine.LSU.2.11.2106031918400.12760@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2106031918400.12760@eggly.anvils>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 4 Jun 2021 11:03:57 -0700
Message-ID: <CAHbLzkqYyoXm1sAq7yBi3s8PbY127VbbgNGZ-5e-zqZMzFOzWA@mail.gmail.com>
Subject: Re: [PATCH 1/7] mm/thp: fix __split_huge_pmd_locked() on shmem
 migration entry
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 7:23 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Thu, 3 Jun 2021, Yang Shi wrote:
> > On Tue, Jun 1, 2021 at 2:05 PM Hugh Dickins <hughd@google.com> wrote:
> > >
> > > Are there more places that need to be careful about pmd migration entries?
> > > None hit in practice, but several of those is_huge_zero_pmd() tests were
> > > done without checking pmd_present() first: I believe a pmd migration entry
> > > could end up satisfying that test.  Ah, the inversion of swap offset, to
> > > protect against L1TF, makes that impossible on x86; but other arches need
> > > the pmd_present() check, and even x86 ought not to apply pmd_page() to a
> > > swap-like pmd.  Fix those instances; __split_huge_pmd_locked() was not
> > > wrong to be checking with pmd_trans_huge() instead, but I think it's
> > > clearer to use pmd_present() in each instance.
> ...
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index 63ed6b25deaa..9fb7b47da87e 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -1676,7 +1676,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
> > >                 spin_unlock(ptl);
> > >                 if (is_huge_zero_pmd(orig_pmd))
> > >                         tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
> > > -       } else if (is_huge_zero_pmd(orig_pmd)) {
> > > +       } else if (pmd_present(orig_pmd) && is_huge_zero_pmd(orig_pmd)) {
> >
> > If it is a huge zero migration entry, the code would fallback to the
> > "else". But IIUC the "else" case doesn't handle the huge zero page
> > correctly. It may mess up the rss counter.
>
> A huge zero migration entry?  I hope that's not something special
> that I've missed.
>
> Do we ever migrate a huge zero page - and how do we find where it's
> mapped, to insert the migration entries?  But if we do, I thought it
> would use the usual kind of pmd migration entry; and the first check
> in is_pmd_migration_entry() is !pmd_present(pmd).

I overlooked if the huge zero page is migratable or not when I was
writing the comment, just focused on the if/else if/else conditions.

I don't think huge zero page is migratable by a quick look since:
* mempolicy and numa hinting skip huge zero pmd
* other migration callsites just try to migrate LRU pages

>
> (I have to be rather careful to check such details, after getting
> burnt once by pmd_present(): which includes the "huge" bit even when
> not otherwise present, to permit races with pmdp_invalidate().
> I mentioned in private mail that I'd dropped one of my "fixes" because
> it was harmless but mistaken: I had misunderstood pmd_present().)
>
> The point here (see commit message above) is that some unrelated pmd
> migration entry could pass the is_huge_zero_pmd() test, which rushes
> off to use pmd_page() without even checking pmd_present() first.  And
> most of its users have, one way or another, checked pmd_present() first;
> but this place and a couple of others had not.

Thanks for the elaboration. Wondering whether we'd better add some
comments in the code? Someone may submit a fix patch by visual
inspection in the future due to missing these points.

>
> I'm just verifying that it's really a a huge zero pmd before handling
> its case; the "else" still does not need to handle the huge zero page.
>
> Hugh
