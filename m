Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F6E3703D5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 00:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhD3W5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 18:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhD3W45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 18:56:57 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BCAC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 15:56:08 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u21so107539122ejo.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 15:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=43RdY4J01ubRDzd5g6EG2t/oZB879vC8jt3238dCcs0=;
        b=Mx50A2iy1FlEe+zLekdead91PpW+PDcjsTYGU+y4zfGgdao6k2ptEai2z7Tk1J6jQX
         Dx8WpHP3QZBLbrDRJkvK3kXt3rs15dTcraPO89OUhL65ZhlypvXPO55stCUO1vvA/QqV
         JAbOAtUUA31rAQ/NCdSAkoD54/t8sqJ797KFQCBTUH7q1iOm5arzsZ57jCGkuZ9Yp6MM
         AtlOneM+a82iiRYQo2k18iBO4mMI2hK4t1/emQCyQ1ql06o+e92L1todxrcphvaq3B4w
         K9/xKTQjLPocQyDTMbEhB6dvzVDj1NLSMiyXu+fFaw4s9zSQt1GC+aH4a2E6felkegis
         xfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=43RdY4J01ubRDzd5g6EG2t/oZB879vC8jt3238dCcs0=;
        b=FdNmzVfozsqCnU5lFNkpTV+X4XBnakW/5ZJN8U57OPRXzX4Y7K9krrbXST8ayCWdhd
         p2W3zjIgJT6jcS7ACtauBvfbv8XVASOZpxTNQoaM16DFZ29IWmJEk1g67u2T1dk64UoF
         l5rF7+IZWsDh/tK/GFUT9PkmTYqp99xcSmkLc1Y7gfMDanwKoxSh1CLoN7w+P1/F1wiO
         4ED6lyS2+LAq/gpGLbv5iuxHT5ErS/UMpUqXYUACN/nQfqPgRFr4Pa46xZ093Uah1Qpu
         7YU4dcQZXdpZEnBWBW23/XrLy1GpsoyCoyHt6oMoUGN+nfyeeM1G+MTsxz7v/cbK0Bce
         TFZw==
X-Gm-Message-State: AOAM5308fTmMBhmWfOS8l18f833in+8fsLWZihJVPQDToMgQsXOng657
        GRHvyNm1UWQzU2KHISfmCj+Vm+MZmYO7j9D8mS1I8xztkNE=
X-Google-Smtp-Source: ABdhPJy/S3reHe9A4CyRyZ7t0e43+EGuChbikZ8E+imKfTVItGYuDJlK4v+35CpdXBEJdR08KpAq7e2Y8Q+hFHWHe8g=
X-Received: by 2002:a17:906:c099:: with SMTP id f25mr6644244ejz.499.1619823367028;
 Fri, 30 Apr 2021 15:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210430210744.216095-1-shy828301@gmail.com> <F8189ACA-DE85-45F0-8C9B-A6F9D2099777@nvidia.com>
 <CAHbLzkqC8bdWtCMigmef4n0KwxKo4UuWoP1xphJiQgYChBB62Q@mail.gmail.com> <07E637C5-3FCD-4D78-936F-186FD051D6A9@nvidia.com>
In-Reply-To: <07E637C5-3FCD-4D78-936F-186FD051D6A9@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 30 Apr 2021 15:55:54 -0700
Message-ID: <CAHbLzkqAM-2Dg-JSy8Yqq99ch39BeSEnxPkmRg2BrhTF1M1N2A@mail.gmail.com>
Subject: Re: [PATCH] mm: thp: check total_mapcount instead of page_mapcount
To:     Zi Yan <ziy@nvidia.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 3:30 PM Zi Yan <ziy@nvidia.com> wrote:
>
> On 30 Apr 2021, at 17:56, Yang Shi wrote:
>
> > On Fri, Apr 30, 2021 at 2:30 PM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On 30 Apr 2021, at 17:07, Yang Shi wrote:
> >>
> >>> When debugging the bug reported by Wang Yugui [1], try_to_unmap() may
> >>> return false positive for PTE-mapped THP since page_mapcount() is use=
d
> >>> to check if the THP is unmapped, but it just checks compound mapount =
and
> >>> head page's mapcount.  If the THP is PTE-mapped and head page is not
> >>> mapped, it may return false positive.
> >>>
> >>> Use total_mapcount() instead of page_mapcount() and do so for the
> >>> VM_BUG_ON_PAGE in split_huge_page_to_list as well.
> >>>
> >>> [1] https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16=
-tech.com/
> >>>
> >>> Signed-off-by: Yang Shi <shy828301@gmail.com>
> >>> ---
> >>>  mm/huge_memory.c | 2 +-
> >>>  mm/rmap.c        | 2 +-
> >>>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>> index 63ed6b25deaa..2122c3e853b9 100644
> >>> --- a/mm/huge_memory.c
> >>> +++ b/mm/huge_memory.c
> >>> @@ -2718,7 +2718,7 @@ int split_huge_page_to_list(struct page *page, =
struct list_head *list)
> >>>       }
> >>>
> >>>       unmap_page(head);
> >>> -     VM_BUG_ON_PAGE(compound_mapcount(head), head);
> >>> +     VM_BUG_ON_PAGE(total_mapcount(head), head);
> >>
> >> I am not sure about this change. The code below also checks total_mapc=
ount(head)
> >> and returns EBUSY if the count is non-zero. This change makes the code=
 dead.
> >
> > It is actually dead if CONFIG_DEBUG_VM is enabled and total_mapcount
> > is not 0 regardless of this change due to the below code, right?
> >
> > if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
> >                         pr_alert("total_mapcount: %u, page_count(): %u\=
n",
> >                                         mapcount, count);
> >                         if (PageTail(page))
> >                                 dump_page(head, NULL);
> >                         dump_page(page, "total_mapcount(head) > 0");
> >                         BUG();
> >                 }
>
> Right. But with this change, mapcount will never be non-zero. The code ab=
ove
> will be useless and can be removed.

Yes, you are correct.

>
> >> On the other hand, the change will force all mappings to the page have=
 to be
> >> successfully unmapped all the time. I am not sure if we want to do tha=
t.
> >> Maybe it is better to just check total_mapcount() and fail the split.
> >> The same situation happens with the code change below.
> >
> > IIUC, the code did force all mappings to the page to be unmapped in
> > order to split it.
> >>
> >>>
> >>>       /* block interrupt reentry in xa_lock and spinlock */
> >>>       local_irq_disable();
> >>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>> index 693a610e181d..2e547378ab5f 100644
> >>> --- a/mm/rmap.c
> >>> +++ b/mm/rmap.c
> >>> @@ -1777,7 +1777,7 @@ bool try_to_unmap(struct page *page, enum ttu_f=
lags flags)
> >>>       else
> >>>               rmap_walk(page, &rwc);
> >>>
> >>> -     return !page_mapcount(page) ? true : false;
> >>> +     return !total_mapcount(page) ? true : false;
> >>>  }
> >>
> >> In unmap_page(), VM_BUG_ON_PAGE(!unmap_success, page) will force all m=
appings
> >> to the page have to be all unmapped, which might not be the case we wa=
nt.
> >
> > AFAICT, I don't see such a case from all the callers of
> > try_to_unmap(). Imay miss something, but I do have a hard time
> > thinking of a usecase which can proceed safely with "not fully
> > unmapped" page.
>
> This code change is correct, but after the change unmap_page() will fire =
VM_BUG_ON
> when not all mappings are unmapped. Along with the change above, we will =
have
> two identical VM_BUG_ONs happen one after another. We might want to remov=
e one
> of them.

Yes. I'd prefer keep the one after unmap_page() since it seems more
obvious. Any objection?

>
> Also, this changes the semantics of try_to_unmap. The comment for try_to_=
unmap
> might need to be updated.

What comment do you refer to?

>
>
> =E2=80=94
> Best Regards,
> Yan Zi
