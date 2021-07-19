Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68623CD4F8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbhGSMCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 08:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236641AbhGSMC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 08:02:27 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4692FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 05:00:38 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id u126so8658669pfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 05:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3i69/SEUDfY5dda/3djs36gQdijIEYAP5WBCFa0LJWg=;
        b=u3pS/9O0DzqPA+z7fsxjsKfJOTPsxbxzbKFHETn/i5Nz6uE2TKXu7SqmfNA3RRO+K4
         /svH5XPh1y5zLsJHVNltPycjJ3DqK3dXAPL66pyzb56NgkQElF/GurHlCnF3yWt8QNbD
         l/KMZpGxlyCBkRsv5blz0s13dlIOPxFYMtTtOrzfs4zwxLcM3hNJbIO9pJPlHYKHiAwf
         0kVVuGPXsQaI09dxhLR921i0FNJpLs68WaQRFidsc0TIlJjWG5bT1zMzseX3gzCHcXpD
         bg4jcFFSDxonZGKKiD8Sl08yMa00wMmoPCe/cE9QCT5oXOJ0nQfG+BgnrhUxIqqEminu
         hB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3i69/SEUDfY5dda/3djs36gQdijIEYAP5WBCFa0LJWg=;
        b=bUmzVEkjIIFdzRpgpck6oVON7MepLeAZPjmjJfdxIO1Z/QvbgNJbTqCqRPx7ZrVbtZ
         JjRFprLG4G8wPCcXIFP/HuvQypoG4lb0Lml8aS2rUTytJnsvfyIxv9XpvSGRuPaLUmWQ
         jGFlGsUfjlI0dy8GZuoz1UrPzhqiW/psI4/3wtgIqUFvAwcuvrxXBPwWG0Y6KZuubcQp
         5hReYDxZpZSzPq+xTKVmp86NoyIbT7gVVLt/0cbdQmRl256j4ITsK1S0cGQVLX1U4VZt
         tyMOU79HWq7XaTrcnnNrtS6JKYghv2dmUcJWFP1COdeRzzmizoQuMFV2v0noMGtggdjU
         8pUA==
X-Gm-Message-State: AOAM532epJldIIDDflgUrs4NzvhjjBgQIMcljnF+FzpkcQrVOhGyIYAg
        +kiztzIJmS+8YOZUnyj7fejIgmyQX8cGdzoaGMPs9w==
X-Google-Smtp-Source: ABdhPJwAzViyP9u+h3fvAL2e/YIOs1fYRXGujiP79l5lnRsoxUcjhRdc0NqXoKfpEhuOCI1Vi5rnka5td58MrI3PRHU=
X-Received: by 2002:a62:92d7:0:b029:32c:8c46:9491 with SMTP id
 o206-20020a6292d70000b029032c8c469491mr26236621pfd.2.1626698586565; Mon, 19
 Jul 2021 05:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
 <5ce5fb25-df1d-b807-8807-595b8a7bfc63@redhat.com> <089e710c-fb06-e731-6d50-7858d6b9ecdf@redhat.com>
In-Reply-To: <089e710c-fb06-e731-6d50-7858d6b9ecdf@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 19 Jul 2021 20:42:13 +0800
Message-ID: <CAMZfGtVsHkBkYBFf-WCvnjyAqtmmNM8KE5sdehdE4zQcdYYdDQ@mail.gmail.com>
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

On Mon, Jul 19, 2021 at 7:28 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 19.07.21 09:34, David Hildenbrand wrote:
> > On 18.07.21 06:30, Qi Zheng wrote:
> >> Hi,
> >>
> >> This patch series aims to free user PTE page table pages when all PTE entries
> >> are empty.
> >>
> >> The beginning of this story is that some malloc libraries(e.g. jemalloc or
> >> tcmalloc) usually allocate the amount of VAs by mmap() and do not unmap those VAs.
> >> They will use madvise(MADV_DONTNEED) to free physical memory if they want.
> >> But the page tables do not be freed by madvise(), so it can produce many
> >> page tables when the process touches an enormous virtual address space.
> >
> > ... did you see that I am actually looking into this?
> >
> > https://lkml.kernel.org/r/bae8b967-c206-819d-774c-f57b94c4b362@redhat.com
> >
> > and have already spent a significant time on it as part of my research,
> > which is *really* unfortunate and makes me quite frustrated at the
> > beginning of the week alreadty ...
> >
> > Ripping out page tables is quite difficult, as we have to stop all page
> > table walkers from touching it, including the fast_gup, rmap and page
> > faults. This usually involves taking the mmap lock in write. My approach
> > does page table reclaim asynchronously from another thread and do not
> > rely on reference counts.
>

Hi David,

> FWIW, I had a quick peek and I like the simplistic approach using
> reference counting, although it seems to come with a price. By hooking
> using pte_alloc_get_map_lock() instead of pte_alloc_map_lock, we can
> handle quite some cases easily.

Totally agree.

>
> There are cases where we might immediately see a reuse after discarding
> memory (especially, with virtio-balloon free page reporting), in which
> case it's suboptimal to immediately discard instead of waiting a bit if
> there is a reuse. However, the performance impact seems to be
> comparatively small.
>
> I do wonder if the 1% overhead you're seeing is actually because of
> allcoating/freeing or because of the reference count handling on some
> hot paths.

Qi Zheng has compared the results collected by using the "perf top"
command. The LRU lock is more contended with this patchset applied.
I think the reason is that this patchset will free more pages (including
PTE page table pages). We don't see the overhead caused by reference
count handling.

Thanks,

Muchun

>
> I'm primarily looking into asynchronous reclaim, because it somewhat
> makes sense to only reclaim (+ pay a cost) when there is really need to
> reclaim memory -- similar to our shrinker infrastructure.
>
> --
> Thanks,
>
> David / dhildenb
>
