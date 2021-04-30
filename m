Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12137370348
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 23:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhD3V5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 17:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhD3V5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 17:57:46 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364F6C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 14:56:56 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i24so24714621edy.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 14:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2G4yLAFcRqPd+NnouKTDTr3z68JyxuHQPUsNrVFoJJc=;
        b=f/9ZMyx1kIeeA48lngWqwDg8RFtDJAFANUk0l7Gec/yuxT7XDeQbCA/OiMXjRmwLiE
         qRjBmIZUHMJvpo76nfv2wNZqLQBjj1cgX1ZjqoygZNBO5axsH1M8DYbKeAJ7Oy/m/70k
         VW7Tab7YagPwtiWBuo8XQRBYkYKqbPLRlO6+GCb44brTJSELebNfMsmac0KG1wvFVQUR
         jlomJh6bbfl29F23BtERjZFUgNW20wCxJ8rgBx3+jL2ShNlXsB0aL4pcKP0zxL7XrRVl
         ZYdJbYGsDotPiIL0aRVZiUwU/Or/LTUi+ZCIRHniekp47zbsVa651GR8X13nDFxFGs3O
         pk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2G4yLAFcRqPd+NnouKTDTr3z68JyxuHQPUsNrVFoJJc=;
        b=OHNcegEcC/WueN8w5VHttJQipW+vz5acq9XBl9Sy0LL5ENNPyYc4tZ1RFPPoGSAkiE
         uSaPXk3t2SiFpw+RdgY2+2eLzPzty7HGa/7SEcr/ypsO0IJX1sTIjmG95za6ouPY0YJN
         UwZ03JtUO4DJDXrQTH7IRoxhDHc9tHtqMkVfedp0e7ewCTPbCQXmQn0bzsbUo1ndGuZJ
         gtbDjKdJQeQyGhLao1JXISLxE4p7ryLOnJUeaW0F26/Tw07bfcyORuZrp51MvgtgnvOh
         80eBVcmsj0yjtlTdMDmAKcCzdy8mkjxfFMBwgWobYfWjHMHj5FjS6DxlJk/If1mbW+WU
         zLMw==
X-Gm-Message-State: AOAM530/fl+BzdK5Mkk3whsjeS5FJ+Wg86A7mYK+2QBZkJxp3pCD/oXe
        Bhck2rB85FS6HgVuWjmUYClKkLZ8YDdVF33mkOA=
X-Google-Smtp-Source: ABdhPJzO/PfuzO8Hk7UXhvlwGaC64O5IlOgXEYXq3J2mdDn+lFqvq6aRYuPaZygMdYpwHgKDcsbsMi/GZr20aXshtd8=
X-Received: by 2002:a05:6402:1907:: with SMTP id e7mr8563133edz.313.1619819814179;
 Fri, 30 Apr 2021 14:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210430210744.216095-1-shy828301@gmail.com> <F8189ACA-DE85-45F0-8C9B-A6F9D2099777@nvidia.com>
In-Reply-To: <F8189ACA-DE85-45F0-8C9B-A6F9D2099777@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 30 Apr 2021 14:56:42 -0700
Message-ID: <CAHbLzkqC8bdWtCMigmef4n0KwxKo4UuWoP1xphJiQgYChBB62Q@mail.gmail.com>
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

On Fri, Apr 30, 2021 at 2:30 PM Zi Yan <ziy@nvidia.com> wrote:
>
> On 30 Apr 2021, at 17:07, Yang Shi wrote:
>
> > When debugging the bug reported by Wang Yugui [1], try_to_unmap() may
> > return false positive for PTE-mapped THP since page_mapcount() is used
> > to check if the THP is unmapped, but it just checks compound mapount an=
d
> > head page's mapcount.  If the THP is PTE-mapped and head page is not
> > mapped, it may return false positive.
> >
> > Use total_mapcount() instead of page_mapcount() and do so for the
> > VM_BUG_ON_PAGE in split_huge_page_to_list as well.
> >
> > [1] https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-t=
ech.com/
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/huge_memory.c | 2 +-
> >  mm/rmap.c        | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 63ed6b25deaa..2122c3e853b9 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2718,7 +2718,7 @@ int split_huge_page_to_list(struct page *page, st=
ruct list_head *list)
> >       }
> >
> >       unmap_page(head);
> > -     VM_BUG_ON_PAGE(compound_mapcount(head), head);
> > +     VM_BUG_ON_PAGE(total_mapcount(head), head);
>
> I am not sure about this change. The code below also checks total_mapcoun=
t(head)
> and returns EBUSY if the count is non-zero. This change makes the code de=
ad.

It is actually dead if CONFIG_DEBUG_VM is enabled and total_mapcount
is not 0 regardless of this change due to the below code, right?

if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
                        pr_alert("total_mapcount: %u, page_count(): %u\n",
                                        mapcount, count);
                        if (PageTail(page))
                                dump_page(head, NULL);
                        dump_page(page, "total_mapcount(head) > 0");
                        BUG();
                }

> On the other hand, the change will force all mappings to the page have to=
 be
> successfully unmapped all the time. I am not sure if we want to do that.
> Maybe it is better to just check total_mapcount() and fail the split.
> The same situation happens with the code change below.

IIUC, the code did force all mappings to the page to be unmapped in
order to split it.

>
> >
> >       /* block interrupt reentry in xa_lock and spinlock */
> >       local_irq_disable();
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 693a610e181d..2e547378ab5f 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1777,7 +1777,7 @@ bool try_to_unmap(struct page *page, enum ttu_fla=
gs flags)
> >       else
> >               rmap_walk(page, &rwc);
> >
> > -     return !page_mapcount(page) ? true : false;
> > +     return !total_mapcount(page) ? true : false;
> >  }
>
> In unmap_page(), VM_BUG_ON_PAGE(!unmap_success, page) will force all mapp=
ings
> to the page have to be all unmapped, which might not be the case we want.

AFAICT, I don't see such a case from all the callers of
try_to_unmap(). Imay miss something, but I do have a hard time
thinking of a usecase which can proceed safely with "not fully
unmapped" page.

> Maybe you will want to remove the VM_BUG_ON_PAGE here, check total_mapcou=
nt()
> above, and fail the split if not all mappings to the pages are unmapped.
>
>
>
> =E2=80=94
> Best Regards,
> Yan Zi
