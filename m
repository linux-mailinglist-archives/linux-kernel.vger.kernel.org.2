Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5B239E4A8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhFGRCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhFGRCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:02:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A70C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 10:00:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r7so6832076edv.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jW69KZFe/XuaGImn+7cx9RiotDNOGd9QgoUO4oCEX5I=;
        b=rjLwWqomwAsbpO8msDMz9xkrgxxQKgeeRbnnD3rxAUUqsv5IwQZzNrVu0Hz83sXW9U
         9YZtt9ROVLupgqmTgNyj547P7uVMWhry5nhALfbSZCMOZoTdtpW1mTK3V5riQUkfPcEX
         r4l/WpQ2KjncmDxKj2TGk6+tfJZl130/B3Lei3bPmpGtpxJenbtDGQEgtcu+YOW6uZ8M
         gv5quly1mJjB8GUajXLNmb4MOenE+r/vYBSAsa5PFgvvMrMZh2Y4QA3MIOFfUIwVJn0X
         BoT4nq6ToD78PLW7PCK4txrI0fVmZFOM5L73PhV4HuweIjNleutSfz6kpIPpwRrmMWOA
         AEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jW69KZFe/XuaGImn+7cx9RiotDNOGd9QgoUO4oCEX5I=;
        b=DCVxX8hkcAye6URBs4b2jEA5vrJC3BvczlzFte8TgAuvsfVYZ79WDJH7f7xbSHdpAB
         VVHDeUjlbRSc7eBtMwdY/ZAQ6kh6JJhiJhQTXV80XAkbHfUl9QwJwzvG5r49MZlAvzRL
         VBVUcOsFZuyd2jzDPr3NBJdjna1l7117gwHY3W2hceUfUySc1b5lNgI0LT6sPCIdwjVD
         tSFNip0/ex0ZuEzkuk8+XF0iaj9uBeBCXH7w4ha4qmIdv4ClDZm+L39AX/dDBD4onCPJ
         86bRNNV3iXLwKt/PmkoMOd8ZSZPm+vC7fbLnw5UY5TBhhyIBt7aeevB/II+ERVJ+Z9ya
         nTZg==
X-Gm-Message-State: AOAM530SzdJ+mJXvhUz0W3Q/YeBcLZma5VmI81i/zfbVJZqT7B7MdsE+
        ilpy1DLZGnADIQp7gropxGxdKA2HaX+xMUkgq7o=
X-Google-Smtp-Source: ABdhPJyXS2QpHrPa/CIuatbmyt7Vrkhc+ZBH/iDjIMF1d5alRpx3R2P+HnrTuXLxSuAZ2ODANvtRr8aqsiBzzyGB+K8=
X-Received: by 2002:a05:6402:1d0f:: with SMTP id dg15mr18446657edb.137.1623085212831;
 Mon, 07 Jun 2021 10:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210604203513.240709-1-shy828301@gmail.com> <YL265A86DQe5Rgon@dhcp22.suse.cz>
In-Reply-To: <YL265A86DQe5Rgon@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 7 Jun 2021 10:00:01 -0700
Message-ID: <CAHbLzkowcskM=p==-q48Ca12D=h9SgqUuUB4NknRNR=64TyXCw@mail.gmail.com>
Subject: Re: [PATCH] mm: mempolicy: don't have to split pmd for huge zero page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Zi Yan <ziy@nvidia.com>, nao.horiguchi@gmail.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 6, 2021 at 11:21 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 04-06-21 13:35:13, Yang Shi wrote:
> > When trying to migrate pages to obey mempolicy, the huge zero page is
> > split then the page table walk at PTE level just skips zero page.  So it
> > seems pointless to split huge zero page, it could be just skipped like
> > base zero page.
>
> My THP knowledge is not the best but this is incorrect AIACS. Huge zero
> page is not split. We do split the pmd which is mapping the said page. I
> suspect you refer to vm_normal_page when talking about a zero page but
> please be aware that huge zero page is not a normal zero page. It is
> allocated dynamically (see get_huge_zero_page).

For a normal huge page, yes, split_huge_pmd() just splits pmd. But
actually the base zero pfn will be inserted to PTEs when splitting
huge zero pmd. Please check __split_huge_zero_page_pmd() out.

I should make this point clearer in the commit log. Sorry for the confusion.

>
> So in the end you patch disables mbind of zero pages to a target node
> and that is a regression.

Do we really migrate zero page? IIUC zero page is just skipped by
vm_normal_page() check in queue_pages_pte_range(), isn't it?

>
> Have you tested the patch?

No, just build test. I thought this change was straightforward.

>
> > Set ACTION_CONTINUE to prevent the walk_page_range() split the pmd for
> > this case.
>
> Btw. this changelog is missing a problem statement. I suspect there is
> no actual problem that it should fix and it is likely driven by reading
> the code. Right?

The actual problem is it is pointless to split a huge zero pmd. Yes,
it is driven by visual inspection.

The behavior before the patch for huge zero page is:
split huge zero pmd (insert base zero pfn to ptes)
walk ptes
skip zero pfn

So why not just skip the huge zero page in the first place?

>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/mempolicy.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index b5f4f584009b..205c1a768775 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -436,7 +436,8 @@ static inline bool queue_pages_required(struct page *page,
> >
> >  /*
> >   * queue_pages_pmd() has four possible return values:
> > - * 0 - pages are placed on the right node or queued successfully.
> > + * 0 - pages are placed on the right node or queued successfully, or
> > + *     special page is met, i.e. huge zero page.
> >   * 1 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
> >   *     specified.
> >   * 2 - THP was split.
> > @@ -460,8 +461,7 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
> >       page = pmd_page(*pmd);
> >       if (is_huge_zero_page(page)) {
> >               spin_unlock(ptl);
> > -             __split_huge_pmd(walk->vma, pmd, addr, false, NULL);
> > -             ret = 2;
> > +             walk->action = ACTION_CONTINUE;
> >               goto out;
> >       }
> >       if (!queue_pages_required(page, qp))
> > @@ -488,7 +488,8 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
> >   * and move them to the pagelist if they do.
> >   *
> >   * queue_pages_pte_range() has three possible return values:
> > - * 0 - pages are placed on the right node or queued successfully.
> > + * 0 - pages are placed on the right node or queued successfully, or
> > + *     special page is met, i.e. zero page.
> >   * 1 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
> >   *     specified.
> >   * -EIO - only MPOL_MF_STRICT was specified and an existing page was already
> > --
> > 2.26.2
>
> --
> Michal Hocko
> SUSE Labs
