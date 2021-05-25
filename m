Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9135A390C62
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 00:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhEYWrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 18:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhEYWrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 18:47:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C61C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 15:45:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id s22so49580686ejv.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 15:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZEcQbvMhSoHLjMNo49ldT5vNI3t55RutmZvoGxMuPkg=;
        b=QGRKMAe+uYrh5/cVYSKtIZIu6Vpw2kbCG+B2z0JnIuuv5ol5NCCEEsxp+m0PGp5yhR
         YvaB1t+ZXx+v6S2fAp1yyTSWC4uxE5P5d01dgVzdGgEI6hBaAYI/N9UoNtx6kyJJWGf6
         BB4JpkXBvrGg04HTrVRzlDrMh/kuJtO72rfwGRqzT21Vp7LUdKzSm7oVvnhHeHsizYqV
         oW9aHUV4C23+a/mAZ21hB97oUHpEtjj5sYv1rzf50Pnn9/wA7Pb33b/LRBVtbGkRMSHc
         xBj17wLFHvCgjg8rGK6TL5UafXc1k8LLZ6iPUwkzAX3gglRW3gCBsrldSibSnXLUGL6i
         4/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZEcQbvMhSoHLjMNo49ldT5vNI3t55RutmZvoGxMuPkg=;
        b=IB4CRRoSTFGT78UVZAfBoaOVEO/nHmIppRetzrPYbOM1bdWe8iJ5/rWUaqN+WkmYaW
         tlu9P9xoYY/9/tiLPl5+zH+536GDF+600b4StVQmVJbG9sgNb4DPRzYSTPenzI/OpO7/
         2P3ciFa88kD5S+9NwFiLKBZ5Yf0eu5JLp/kKtLl9fnFANyd4MhomhcLH6wj001MF5mLw
         L5LdzwXogdkLBDYNhTYJI0tBchCbRrkStMNA5nekR1wCJscXQ8pGeSVAL46ew9knrwnq
         yY0MqjRQIk+sJbmx6cX/GJxdokJXv1R0voLemEJ4oeD7QR1LshjMCrkiRAplAnGnXE3W
         Y0Ng==
X-Gm-Message-State: AOAM531RMLiZ01evDgxShq5X0OlJta7QW7NB46GEkhZviqefx9RU+2+9
        OQ2HVD6StoeDZFfiu6S6JSV1DsAOo0dSsZfajNg=
X-Google-Smtp-Source: ABdhPJzfCBahew97KwA/E0nGsS+tI1s/DjBv3C8PfI/XV4OfaQ16fpUc3t30vmolJa2Fks9NRWlK5D9EpMVgBs5drB8=
X-Received: by 2002:a17:906:4751:: with SMTP id j17mr18079906ejs.25.1621982742594;
 Tue, 25 May 2021 15:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210525162145.3510-1-shy828301@gmail.com> <20210525162145.3510-2-shy828301@gmail.com>
 <alpine.LSU.2.11.2105251412140.2003@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2105251412140.2003@eggly.anvils>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 25 May 2021 15:45:31 -0700
Message-ID: <CAHbLzkqs32HkRiAoQeSv2ik9fBYmdhwUFq5vWkcs7PY0rUu2fA@mail.gmail.com>
Subject: Re: [v3 PATCH 2/2] mm: thp: check page_mapped instead of
 page_mapcount for split
To:     Hugh Dickins <hughd@google.com>
Cc:     Zi Yan <ziy@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Wang Yugui <wangyugui@e16-tech.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 3:06 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Tue, 25 May 2021, Yang Shi wrote:
>
> > When debugging the bug reported by Wang Yugui [1], try_to_unmap() may
> > return false positive for PTE-mapped THP since page_mapcount() is used
> > to check if the THP is unmapped, but it just checks compound mapount and
> > head page's mapcount.  If the THP is PTE-mapped and head page is not
> > mapped, it may return false positive.
>
> But those false positives did not matter because there was a separate
> DEBUG_VM check later.
>
> It's good to have the link to Wang Yugui's report, but that paragraph
> is not really about this patch, as it has evolved now: this patch
> consolidates the two DEBUG_VM checks into one VM_WARN_ON_ONCE_PAGE.
>
> >
> > The try_to_unmap() has been changed to void function, so check
> > page_mapped() after it.  And changed BUG_ON to WARN_ON since it is not a
> > fatal issue.
>
> The change from DEBUG_VM BUG to VM_WARN_ON_ONCE is the most important
> part of this, and the reason it's good for stable: and the patch title
> ought to highlight that, not the page_mapcount business.

Will update the subject and the commit log accordingly.

>
> >
> > [1] https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-tech.com/
> >
> > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> This will be required Cc: stable@vger.kernel.org
> (but we don't want to Cc them on this mail).
>
> As I said on the other, I think this should be 1/2 not 2/2.

Sure.

>
> > ---
> > v3: Incorporated the comments from Hugh. Keep Zi Yan's reviewed-by tag
> >     since there is no fundamental change against v2.
> > v2: Removed dead code and updated the comment of try_to_unmap() per Zi
> >     Yan.
> >  mm/huge_memory.c | 17 +++++------------
> >  1 file changed, 5 insertions(+), 12 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 80fe642d742d..72d81d8e01b1 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2343,6 +2343,8 @@ static void unmap_page(struct page *page)
> >               ttu_flags |= TTU_SPLIT_FREEZE;
> >
> >       try_to_unmap(page, ttu_flags);
> > +
> > +     VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
>
> There is one useful piece of information that dump_page() will not show:
> total_mapcount(page).  Is there a way of crafting that into the output?
>
> Not with the macros available, I think.  Maybe we should be optimistic
> and assume I already have the fixes, so not worth trying to refine the
> message (but I'm not entirely convinced of that!).
>
> The trouble with
>         if (VM_WARN_ON_ONCE_PAGE(page_mapped(page), page))
>                 pr_warn("total_mapcount:%d\n", total_mapcount(page));
> is that it's printed regardless of the ONCEness.  Another "trouble"
> is that it's printed so long after the page_mapped(page) check that
> it may be 0 by now - but one can see that as itself informative.

We should be able to make dump_page() print total mapcount, right? The
dump_page() should be just called in some error paths so taking some
extra overhead to dump more information seems harmless, or am I
missing something? Of course, this can be done in a separate patch.

>
> I guess leave it as you have it, I don't see an easy better
> (without going back to something like the old contortions).
>
> >  }
> >
> >  static void remap_page(struct page *page, unsigned int nr)
> > @@ -2653,7 +2655,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
> >       struct deferred_split *ds_queue = get_deferred_split_queue(head);
> >       struct anon_vma *anon_vma = NULL;
> >       struct address_space *mapping = NULL;
> > -     int count, mapcount, extra_pins, ret;
> > +     int mapcount, extra_pins, ret;
>
> Remove mapcount too.
>
> >       pgoff_t end;
> >
> >       VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
> > @@ -2712,7 +2714,6 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
> >       }
> >
> >       unmap_page(head);
> > -     VM_BUG_ON_PAGE(compound_mapcount(head), head);
> >
> >       /* block interrupt reentry in xa_lock and spinlock */
> >       local_irq_disable();
> > @@ -2730,7 +2731,6 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
> >
> >       /* Prevent deferred_split_scan() touching ->_refcount */
> >       spin_lock(&ds_queue->split_queue_lock);
> > -     count = page_count(head);
> >       mapcount = total_mapcount(head);
> >       if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
>
> mapcount was useful for printing in the hand-crafted message deleted,
> but serves no purpose now: just do the page_ref_freeze() without it.

Aha, yes, good catch. If mapcount is not zero, the refcount freeze
won't succeed.

>
> >               if (!list_empty(page_deferred_list(head))) {
> > @@ -2752,16 +2752,9 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
> >               __split_huge_page(page, list, end);
> >               ret = 0;
> >       } else {
> > -             if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
> > -                     pr_alert("total_mapcount: %u, page_count(): %u\n",
> > -                                     mapcount, count);
> > -                     if (PageTail(page))
> > -                             dump_page(head, NULL);
> > -                     dump_page(page, "total_mapcount(head) > 0");
> > -                     BUG();
> > -             }
> >               spin_unlock(&ds_queue->split_queue_lock);
> > -fail:                if (mapping)
> > +fail:
> > +             if (mapping)
> >                       xa_unlock(&mapping->i_pages);
> >               local_irq_enable();
> >               remap_page(head, thp_nr_pages(head));
> > --
> > 2.26.2
