Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33293666DA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhDUIQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbhDUIQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:16:15 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB2FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 01:15:43 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id w10so29070258pgh.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 01:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDNi7Pq76OfCbCdDxGFAeY3yEV5OAvKRxPwWNq6c2gI=;
        b=o8Og5Y6Dn/+kfZJBIZs6BSbOTg5nNzykjXvsqwsIVdyq+0GF0bS3b+DdqN6hXehJDI
         biDuz3w83z7gZ2p3zCFEgxTozK7f5T/vS/T4lP+erF7v0waEzzszV296BjZMgUPSbINI
         JyCsfp0RQMKtwvkdEP7Zw9uEKNFwIxYCHtVCyPfWq9appujBXx4FzsxfBdMwgnEvqNXf
         mTcBcncnis9jwnR1Ldm+6ZG0LjnIrYvoFQ+FVyqr774UZGGGf2HWWhLZ5AwdK6oI6L4r
         ER0aZh3OT3sajU78pis5FyN1AdgC7Vz638KeEDzGnG5IUGDHdWteZ4RDDdqXgFkpl2zC
         QP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDNi7Pq76OfCbCdDxGFAeY3yEV5OAvKRxPwWNq6c2gI=;
        b=FmuzGo8hFRp7PgXOgv7Al4+qMJDUBZYl2p8hOqW5Ps738x3l8XYWXskJlR2hfW6FgN
         6qjKd5/I6EnJuY04mBeVcdCEIxnF20JXDkQuqyxbwCq6dR1THvojflVaS/uAu9qubp5w
         r5vSF6/EAsSG7Lrzt+jFzYiieNPOlKNRDy8tIPmplOPBKH6B8F27kTiAzADOG2fFl4AS
         Rg/vxOu35QhoHr9JodbGRFqjfgbC05scALbZQsyE86CL6UIbVkMlVWaIyQaf4CtDpzoZ
         ifGcLfdFA/Vjz0/J+hGov4U6rKOTpib/JYhr/geA5u4FJ0oi7393jb1MbgkJKmEaFL3z
         cR3Q==
X-Gm-Message-State: AOAM5327H78HO/cWb2csiCvQa4B2gFM8Dp9r8BrQDtKRP3DlesTiJqvT
        36YIrYkzXdxvNf6lYmsYmOrmbEIQBMy80In3wi8VVg==
X-Google-Smtp-Source: ABdhPJzXH/SH9ISXGP6z7pxMlQohQseRZtXZzZ6t0MqPW7IN6/wHVEY+DNN9jKRYkpmbFgdPziL4EhPQZKiFliNnuHE=
X-Received: by 2002:a63:f07:: with SMTP id e7mr21045228pgl.341.1618992937492;
 Wed, 21 Apr 2021 01:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210421060259.67554-1-songmuchun@bytedance.com> <YH/cVoUCTKu/UkqB@dhcp22.suse.cz>
In-Reply-To: <YH/cVoUCTKu/UkqB@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 21 Apr 2021 16:15:00 +0800
Message-ID: <CAMZfGtWh4tRiMrOTLvv5GHM1JUCt9b+UHf_DwLev32S=+iLW8g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: hugetlb: fix a race between
 memory-failure/soft_offline and gather_surplus_pages
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 4:03 PM Michal Hocko <mhocko@suse.com> wrote:
>
> [Cc Naoya]
>
> On Wed 21-04-21 14:02:59, Muchun Song wrote:
> > The possible bad scenario:
> >
> > CPU0:                           CPU1:
> >
> >                                 gather_surplus_pages()
> >                                   page = alloc_surplus_huge_page()
> > memory_failure_hugetlb()
> >   get_hwpoison_page(page)
> >     __get_hwpoison_page(page)
> >       get_page_unless_zero(page)
> >                                   zero = put_page_testzero(page)
> >                                   VM_BUG_ON_PAGE(!zero, page)
> >                                   enqueue_huge_page(h, page)
> >   put_page(page)
> >
> > The refcount can possibly be increased by memory-failure or soft_offline
> > handlers, we can trigger VM_BUG_ON_PAGE and wrongly add the page to the
> > hugetlb pool list.
>
> The hwpoison side of this looks really suspicious to me. It shouldn't
> really touch the reference count of hugetlb pages without being very
> careful (and having hugetlb_lock held). What would happen if the
> reference count was increased after the page has been enqueed into the
> pool? This can just blow up later.

If the page has been enqueued into the pool, then the page can be
allocated to other users. The page reference count will be reset to
1 in the dequeue_huge_page_node_exact(). Then memory-failure
will free the page because of put_page(). This is wrong. Because
there is another user.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/hugetlb.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 3476aa06da70..6c96332db34b 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -2145,17 +2145,14 @@ static int gather_surplus_pages(struct hstate *h, long delta)
> >
> >       /* Free the needed pages to the hugetlb pool */
> >       list_for_each_entry_safe(page, tmp, &surplus_list, lru) {
> > -             int zeroed;
> > -
> >               if ((--needed) < 0)
> >                       break;
> >               /*
> > -              * This page is now managed by the hugetlb allocator and has
> > -              * no users -- drop the buddy allocator's reference.
> > +              * The refcount can possibly be increased by memory-failure or
> > +              * soft_offline handlers.
> >                */
> > -             zeroed = put_page_testzero(page);
> > -             VM_BUG_ON_PAGE(!zeroed, page);
> > -             enqueue_huge_page(h, page);
> > +             if (likely(put_page_testzero(page)))
> > +                     enqueue_huge_page(h, page);
> >       }
> >  free:
> >       spin_unlock_irq(&hugetlb_lock);
> > --
> > 2.11.0
> >
>
> --
> Michal Hocko
> SUSE Labs
