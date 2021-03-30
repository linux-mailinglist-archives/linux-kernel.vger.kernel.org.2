Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C204134E2D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhC3IJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhC3IJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:09:13 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77025C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:09:13 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s11so5560778pfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PB9iUKEPVj2X9TCtIHU68DohXbno7XR7v6QDGO/igRQ=;
        b=YmpsvoneVKvBDySj1WjQ1+LgtxCkvRZF59P9vv9qcYhhJXAw/AGhOOTSIPfVYC8KUd
         Yakh01qaYVMQd9qGK5iyegd/Zdv0mMurktcDfCgR17eGzRJ0msm06vr5i5Oo0oJv8Cbe
         2qC2O/1DXz5ZAZdTsh6MgIj1RVKG8jBEp7bUYJXL1j+LTcSf8RDzl1RYLljBr5SFRuEj
         wXcMZfQMAlJ305hVdO8MgtZDi0Zs9INtKEffaCpm9N0va/tyyouXB9hKSUH+Mejigvr4
         gYt+wiLi9CMbmCAX71zWXoXK6qopz7NewM49kHfng6AqVmWXt31SuBADsEMnN/shHFUD
         H85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PB9iUKEPVj2X9TCtIHU68DohXbno7XR7v6QDGO/igRQ=;
        b=LcNdUxlNL978QDy1lxiO1KOvLFpJtwh0cFB7IfySltHYUndK1vaZM9qx7aqhRs7t0o
         IlhBLUrN9Q6GIV9RnUwPtPhVApOKtMffFXAujIAsJ4pdYNInpYaCbhNv9fagHFxmxP6b
         zI5K/qXaFqQJoei9ldljLwIyN4Ur/yNQkRcsiUApf3jqjGB6u3g6siKnPN8kQy5GWntA
         onKIkONZZUD25rp6QVrGG+qU22seo5Hqmz6m1cgCUtGQ8XHISrZvgnAar98+yl1KBqAh
         dGvqAet5ZlJbMaVknskRgheL/7eaWYqPH+H0vF8tAUX+gTo3Dhju0Fy+TXCqVDgOaIIf
         wgog==
X-Gm-Message-State: AOAM532BGSe4+nLt48WFG+aUYlfFNNiB8ZoWI28L9V5P1aOZTM+9Fd+S
        dyn0LmxArKYCwyJGTCl8JE9L6Agf1dg8NIDsKnPlPw==
X-Google-Smtp-Source: ABdhPJxs5t5yHpj6+kSOJzEGouafGur/MJrNMF278g3GOzw1gaWCvgVeP7f59Rnp5rAKEVxkPri4YuGXTI0bLAYzW9I=
X-Received: by 2002:a63:141e:: with SMTP id u30mr27933831pgl.31.1617091753004;
 Tue, 30 Mar 2021 01:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210329232402.575396-1-mike.kravetz@oracle.com>
 <20210329232402.575396-2-mike.kravetz@oracle.com> <YGLayMqYOrMMQ841@dhcp22.suse.cz>
In-Reply-To: <YGLayMqYOrMMQ841@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 30 Mar 2021 16:08:36 +0800
Message-ID: <CAMZfGtUv4O_+W5rHt0P4Xbw=WXJ-ZwHYMrg=iJa2CEkfxb91gA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/8] mm/cma: change cma mutex to irq
 safe spinlock
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 4:01 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 29-03-21 16:23:55, Mike Kravetz wrote:
> > Ideally, cma_release could be called from any context.  However, that is
> > not possible because a mutex is used to protect the per-area bitmap.
> > Change the bitmap to an irq safe spinlock.
>
> I would phrase the changelog slightly differerent
> "
> cma_release is currently a sleepable operatation because the bitmap
> manipulation is protected by cma->lock mutex. Hugetlb code which relies
> on cma_release for CMA backed (giga) hugetlb pages, however, needs to be
> irq safe.
>
> The lock doesn't protect any sleepable operation so it can be changed to
> a (irq aware) spin lock. The bitmap processing should be quite fast in
> typical case but if cma sizes grow to TB then we will likely need to
> replace the lock by a more optimized bitmap implementation.
> "
>
> it seems that you are overusing irqsave variants even from context which
> are never called from the IRQ context so they do not need storing flags.
>
> [...]
> > @@ -391,8 +391,9 @@ static void cma_debug_show_areas(struct cma *cma)
> >       unsigned long start = 0;
> >       unsigned long nr_part, nr_total = 0;
> >       unsigned long nbits = cma_bitmap_maxno(cma);
> > +     unsigned long flags;
> >
> > -     mutex_lock(&cma->lock);
> > +     spin_lock_irqsave(&cma->lock, flags);
>
> spin_lock_irq should be sufficient. This is only called from the
> allocation context and that is never called from IRQ context.

This makes me think more. I think that spin_lock should be
sufficient. Right?


>
> >       pr_info("number of available pages: ");
> >       for (;;) {
> >               next_zero_bit = find_next_zero_bit(cma->bitmap, nbits, start);
> > @@ -407,7 +408,7 @@ static void cma_debug_show_areas(struct cma *cma)
> >               start = next_zero_bit + nr_zero;
> >       }
> >       pr_cont("=> %lu free of %lu total pages\n", nr_total, cma->count);
> > -     mutex_unlock(&cma->lock);
> > +     spin_unlock_irqrestore(&cma->lock, flags);
> >  }
> >  #else
> >  static inline void cma_debug_show_areas(struct cma *cma) { }
> > @@ -430,6 +431,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
> >       unsigned long pfn = -1;
> >       unsigned long start = 0;
> >       unsigned long bitmap_maxno, bitmap_no, bitmap_count;
> > +     unsigned long flags;
> >       size_t i;
> >       struct page *page = NULL;
> >       int ret = -ENOMEM;
> > @@ -454,12 +456,12 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
> >               goto out;
> >
> >       for (;;) {
> > -             mutex_lock(&cma->lock);
> > +             spin_lock_irqsave(&cma->lock, flags);
> >               bitmap_no = bitmap_find_next_zero_area_off(cma->bitmap,
> >                               bitmap_maxno, start, bitmap_count, mask,
> >                               offset);
> >               if (bitmap_no >= bitmap_maxno) {
> > -                     mutex_unlock(&cma->lock);
> > +                     spin_unlock_irqrestore(&cma->lock, flags);
> >                       break;
> >               }
> >               bitmap_set(cma->bitmap, bitmap_no, bitmap_count);
>
> same here.
>
> > @@ -468,7 +470,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
> >                * our exclusive use. If the migration fails we will take the
> >                * lock again and unmark it.
> >                */
> > -             mutex_unlock(&cma->lock);
> > +             spin_unlock_irqrestore(&cma->lock, flags);
> >
> >               pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
> >               ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
> > diff --git a/mm/cma.h b/mm/cma.h
> > index 68ffad4e430d..2c775877eae2 100644
> > --- a/mm/cma.h
> > +++ b/mm/cma.h
> > @@ -15,7 +15,7 @@ struct cma {
> >       unsigned long   count;
> >       unsigned long   *bitmap;
> >       unsigned int order_per_bit; /* Order of pages represented by one bit */
> > -     struct mutex    lock;
> > +     spinlock_t      lock;
> >  #ifdef CONFIG_CMA_DEBUGFS
> >       struct hlist_head mem_head;
> >       spinlock_t mem_head_lock;
> > diff --git a/mm/cma_debug.c b/mm/cma_debug.c
> > index d5bf8aa34fdc..6379cfbfd568 100644
> > --- a/mm/cma_debug.c
> > +++ b/mm/cma_debug.c
> > @@ -35,11 +35,12 @@ static int cma_used_get(void *data, u64 *val)
> >  {
> >       struct cma *cma = data;
> >       unsigned long used;
> > +     unsigned long flags;
> >
> > -     mutex_lock(&cma->lock);
> > +     spin_lock_irqsave(&cma->lock, flags);
> >       /* pages counter is smaller than sizeof(int) */
> >       used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
> > -     mutex_unlock(&cma->lock);
> > +     spin_unlock_irqrestore(&cma->lock, flags);
> >       *val = (u64)used << cma->order_per_bit;
>
> same here
>
> >
> >       return 0;
> > @@ -52,8 +53,9 @@ static int cma_maxchunk_get(void *data, u64 *val)
> >       unsigned long maxchunk = 0;
> >       unsigned long start, end = 0;
> >       unsigned long bitmap_maxno = cma_bitmap_maxno(cma);
> > +     unsigned long flags;
> >
> > -     mutex_lock(&cma->lock);
> > +     spin_lock_irqsave(&cma->lock, flags);
> >       for (;;) {
> >               start = find_next_zero_bit(cma->bitmap, bitmap_maxno, end);
> >               if (start >= bitmap_maxno)
> > @@ -61,7 +63,7 @@ static int cma_maxchunk_get(void *data, u64 *val)
> >               end = find_next_bit(cma->bitmap, bitmap_maxno, start);
> >               maxchunk = max(end - start, maxchunk);
> >       }
> > -     mutex_unlock(&cma->lock);
> > +     spin_unlock_irqrestore(&cma->lock, flags);
> >       *val = (u64)maxchunk << cma->order_per_bit;
> >
> >       return 0;
>
> and here.
> --
> Michal Hocko
> SUSE Labs
