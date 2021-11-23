Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D85945ABF7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 20:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbhKWTGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 14:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbhKWTGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 14:06:39 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBEAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:03:30 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id i63so211695lji.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EjOmAhFDgrhvowToE/lUbuq/OCLfMw8Xrzh45UKZoyQ=;
        b=IfDn/GrTpnwDujtS5SsdHh/LSaxaw3XLTTp9JDQ2OHIftjSS5OUthFU8hod2rbOcP9
         cLN/U3HF+SI/4VezCS3aqAOSUY6ZcEGO/aU74DTx3/rGWoNmfgKBAyOwcM1Op1k+b9Gs
         gOmzBr2P9aF5EdSQGLp4gfdEDYjd95qjK4fZHFRKKdiAmwqo/PUipXDbvfCkEjaJzBK5
         OLoMgMbhVd6lYdqG0DdoJOld+f04kB/tzJ6uUzqMfsINVi3VnnIdsBHwKpJBqqsXiB3T
         puMJTv6pq+lIhYAR2fDXmPgCSD73cLUYYJsmSxhMlnp5H4E2GW7gmFG4CKveohy8Hxkj
         GcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EjOmAhFDgrhvowToE/lUbuq/OCLfMw8Xrzh45UKZoyQ=;
        b=E304rXYzJDHwR7V+f1LgQ2lJvjbk8pOGc9xcbuePsTPESwn66J0opWre969MpOUnK2
         4ODAYJD50ygJB+8HSsb8nk61s0jJxVrSOiI74k70crALsBGK5zovj2J9UkpCS3VwwfRw
         TPkgE0pXrzNf3U22HWdNSXeCpplsIpNV2u68+BF26AyRk/QfUglyyieRAB8XWnmfeLhb
         mIaY/xQgpeINgnCYnN0VvkRGeJB0SIVFWgfmnpJMm/JfUoALzXuYHRka1xADxMxunDVn
         BTLZ0SoArV/Irl7fYMqZPfxCTp2N4Edb9+HPUYW5SwWYVAFj4e4VAG28kXwk70Nx1bdH
         B26A==
X-Gm-Message-State: AOAM532sOOyp2tuEn8rQPREn944eiImeM2QNsOCX7jU80JadRp/2/jMi
        7nSWP8DNnsbCV8EkbNznizYv1FEcxCyPl3zhWx4e6g==
X-Google-Smtp-Source: ABdhPJyiAR2C563ifXIiqy/wu450DL8dnjn2qI8PRNrqU7Cc8chD+JxOfnmZPNzhpTj/uicXOAyMcBnu96g2DqL+gpY=
X-Received: by 2002:a2e:a314:: with SMTP id l20mr8319445lje.86.1637694208612;
 Tue, 23 Nov 2021 11:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20211123174658.1728753-1-shakeelb@google.com> <CAHbLzkpxnbzLFB0=dbtavkvNGY8aamNKSu+YU2eYK3KM5d2g4Q@mail.gmail.com>
In-Reply-To: <CAHbLzkpxnbzLFB0=dbtavkvNGY8aamNKSu+YU2eYK3KM5d2g4Q@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 23 Nov 2021 11:03:17 -0800
Message-ID: <CALvZod4YUd1Vb_BmN8K1ZfRr1aL2XHGhtAYN+Kwnz6tsWMu5Cg@mail.gmail.com>
Subject: Re: [PATCH] mm: thp: update split_queue_len correctly
To:     Yang Shi <shy828301@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 10:51 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Tue, Nov 23, 2021 at 9:47 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > The deferred THPs are split on memory pressure through shrinker
> > callback and splitting of THP during reclaim can fail for several
> > reasons like unable to lock the THP, under writeback or unexpected
> > number of pins on the THP. Such pages are put back on the deferred split
> > list for consideration later. However kernel does not update the
> > deferred queue size on putting back the pages whose split was failed.
> > This patch fixes that.
> >
> > Fixes: 364c1eebe453 ("mm: thp: extract split_queue_* into a struct")
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > ---
> >  mm/huge_memory.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index e5483347291c..4fff9584815b 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2809,7 +2809,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
> >         unsigned long flags;
> >         LIST_HEAD(list), *pos, *next;
> >         struct page *page;
> > -       int split = 0;
> > +       unsigned long split = 0, num = 0;
> >
> >  #ifdef CONFIG_MEMCG
> >         if (sc->memcg)
> > @@ -2823,6 +2823,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
> >                 page = compound_head(page);
> >                 if (get_page_unless_zero(page)) {
> >                         list_move(page_deferred_list(page), &list);
> > +                       num++;
>
> Thanks for catching this. But I don't think "num" is needed, isn't the
> below code good enough?

Yes you are right. I will send the next version. I will at least
change the type of split to unsigned long.

>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e5483347291c..1fbd8299db0c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2847,6 +2847,7 @@ static unsigned long deferred_split_scan(struct
> shrinker *shrink,
>
>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>         list_splice_tail(&list, &ds_queue->split_queue);
> +       ds_queue->split_queue_len -= split;
>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>
>         /*
>
> >                 } else {
> >                         /* We lost race with put_compound_page() */
> >                         list_del_init(page_deferred_list(page));
> > @@ -2847,6 +2848,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
> >
> >         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> >         list_splice_tail(&list, &ds_queue->split_queue);
> > +       ds_queue->split_queue_len += (num - split);
> >         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> >
> >         /*
> > --
> > 2.34.0.rc2.393.gf8c9666880-goog
> >
