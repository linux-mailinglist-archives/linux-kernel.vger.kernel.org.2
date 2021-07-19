Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2F63CD5BC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238422AbhGSMvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 08:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238401AbhGSMvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 08:51:12 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620DDC061768
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 05:53:27 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t9so18999286pgn.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 06:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5yZp7VZOqzRJ1FjiCJg4LSQFQRx2br2QAn//QhHRktM=;
        b=QO+khtR5mz8ki+MH8XFCQ5Bd9jS6cfXxx2oyG/XH78anP6Bc+tyWkR34msU4pnfrMO
         1BlSve+AaXuFLHeI1hzxEm5QLrbEtxdQc2We9tIgRKci8w+F21zza1C+bwT19F5LbZ2F
         iVg7NrYSm0EzFztAjlmemILd46y8vKGRBULU1AYWlgj0bZbG3YSsmaSGddh54vozH3ou
         zQ64snFRvZIMuMT38NCrIMHMecSots7seaAQAhhMYdyh7cyz1ce9F6Uy13l/ZnZQLZcr
         cO4PI8ycAhPP39G+G3EZ07q2/VF5hSx7RKSd5ernEiDjvRIkCWaHqQfFuNbqavasp8Y5
         ZOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5yZp7VZOqzRJ1FjiCJg4LSQFQRx2br2QAn//QhHRktM=;
        b=SZrP+W/no6Y+Mi/QQrme8s+zECsxjaY4KGh0O5PeQgNgBjrd8RqM9/YbalmL6EzkLc
         cNK5y8jGF18nR1Vn7G1MZxO4PKGjv721bYVt+u3szvs5WCH5H5MbZi16GFxHXrhWUmeC
         QTHx6mrLJpr4XvigtjscZtVnP6AIvTWk4vyxsV9bSaqfSlTu5eo0MvHseFDD68TJUHI8
         iKaJak2vAgbtZLmAzDwccvg3/dyFIH5iCISJ7UdHjezRJgBlsZaV9NbfS1d0aE+fL/B/
         cSEHHmH4IdhdzZDOQhKGo3oGKlNriBBQvMsp/cZwsk/n/C90jjUJAZ6mI3F1O4MLKEh9
         lM1A==
X-Gm-Message-State: AOAM532LzzudBgziZW6VfYIY58Ys09kjH5Ui63AEvO9vIyT//rm2pQa7
        Hg9bcABn2hIkAyRqZfpdlPrlfDRHrPp00Jg9zz4mMw==
X-Google-Smtp-Source: ABdhPJxiTW2bFUTE4xsT0zE+moeFlOhucFmKqk25I2Tp7KdXyO4CLoSMFJdS9BFEvKONqZwnyaFeMA5aQB+EzuiOfFY=
X-Received: by 2002:a63:4607:: with SMTP id t7mr25333633pga.31.1626701511860;
 Mon, 19 Jul 2021 06:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
 <5ce5fb25-df1d-b807-8807-595b8a7bfc63@redhat.com> <089e710c-fb06-e731-6d50-7858d6b9ecdf@redhat.com>
 <CAMZfGtVsHkBkYBFf-WCvnjyAqtmmNM8KE5sdehdE4zQcdYYdDQ@mail.gmail.com>
In-Reply-To: <CAMZfGtVsHkBkYBFf-WCvnjyAqtmmNM8KE5sdehdE4zQcdYYdDQ@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 19 Jul 2021 21:30:59 +0800
Message-ID: <CAMZfGtUXS+BfYaDn12cv-dSOqV_hDtE0k1Ofu-kqHcdGAis4aQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Free user PTE page table pages
To:     David Hildenbrand <david@redhat.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 8:42 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Mon, Jul 19, 2021 at 7:28 PM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 19.07.21 09:34, David Hildenbrand wrote:
> > > On 18.07.21 06:30, Qi Zheng wrote:
> > >> Hi,
> > >>
> > >> This patch series aims to free user PTE page table pages when all PTE entries
> > >> are empty.
> > >>
> > >> The beginning of this story is that some malloc libraries(e.g. jemalloc or
> > >> tcmalloc) usually allocate the amount of VAs by mmap() and do not unmap those VAs.
> > >> They will use madvise(MADV_DONTNEED) to free physical memory if they want.
> > >> But the page tables do not be freed by madvise(), so it can produce many
> > >> page tables when the process touches an enormous virtual address space.
> > >
> > > ... did you see that I am actually looking into this?
> > >
> > > https://lkml.kernel.org/r/bae8b967-c206-819d-774c-f57b94c4b362@redhat.com
> > >
> > > and have already spent a significant time on it as part of my research,
> > > which is *really* unfortunate and makes me quite frustrated at the
> > > beginning of the week alreadty ...
> > >
> > > Ripping out page tables is quite difficult, as we have to stop all page
> > > table walkers from touching it, including the fast_gup, rmap and page
> > > faults. This usually involves taking the mmap lock in write. My approach
> > > does page table reclaim asynchronously from another thread and do not
> > > rely on reference counts.
> >
>
> Hi David,
>
> > FWIW, I had a quick peek and I like the simplistic approach using
> > reference counting, although it seems to come with a price. By hooking
> > using pte_alloc_get_map_lock() instead of pte_alloc_map_lock, we can
> > handle quite some cases easily.
>
> Totally agree.
>
> >
> > There are cases where we might immediately see a reuse after discarding
> > memory (especially, with virtio-balloon free page reporting), in which
> > case it's suboptimal to immediately discard instead of waiting a bit if
> > there is a reuse. However, the performance impact seems to be
> > comparatively small.
> >
> > I do wonder if the 1% overhead you're seeing is actually because of
> > allcoating/freeing or because of the reference count handling on some
> > hot paths.
>
> Qi Zheng has compared the results collected by using the "perf top"
> command. The LRU lock is more contended with this patchset applied.
> I think the reason is that this patchset will free more pages (including
> PTE page table pages). We don't see the overhead caused by reference
> count handling.

Sorry for the confusion. I am wrong. The PTE page table page does
not add to LRU list, so it should not be the LRU lock. We actually see
that _raw_spin_unlock_irqrestore is hotter than before. I guess it is
zone lock.

>
> Thanks,
>
> Muchun
>
> >
> > I'm primarily looking into asynchronous reclaim, because it somewhat
> > makes sense to only reclaim (+ pay a cost) when there is really need to
> > reclaim memory -- similar to our shrinker infrastructure.
> >
> > --
> > Thanks,
> >
> > David / dhildenb
> >
