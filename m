Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C9F459535
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 19:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbhKVTCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 14:02:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230159AbhKVTCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 14:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637607573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EBdMIiD94CxZyJ8exI6TvTTX3AhzIJQBc1Jh5aLmKUY=;
        b=GB/8Z6B8Zbf66gqkJc1bwP7tABYjcCcwTO/lKGLxAVwZi5+yURSzum0ISV6O70sWs4Gr8P
        dNGFzMaLXP3ziW+vI3BixFKvbMacg3UBjycIOWujsmlgyoYl2QYpvamH06QEPswWWsrh+Z
        jPxmoVgezQM0r2F19i2NreHINe/kGNQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-6b1RzQdrMA-5-RMx-vYxow-1; Mon, 22 Nov 2021 13:59:32 -0500
X-MC-Unique: 6b1RzQdrMA-5-RMx-vYxow-1
Received: by mail-wm1-f71.google.com with SMTP id 69-20020a1c0148000000b0033214e5b021so7209596wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 10:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=EBdMIiD94CxZyJ8exI6TvTTX3AhzIJQBc1Jh5aLmKUY=;
        b=6UhNCqMbnEU4tVvMAwd+daUKvH1gYPkNicPBQ7hRNPANwoSz9rYe9MXz9u+cnxB3b+
         UOphNmVKFLSuPYlbbszt4PZ5W+zjGTJCkW2ydsocNwhGRHfSb21h0aH6GBuuWvBhIlWy
         L52SB+MV6D8gQA8kZdUEmgxn32jZiexs0lVj8kvhLKQOBF2jNChr9Lvxdpx67z+aO2fV
         rP1wQUmUcHIDaq2vq2EJIdPjZ/IK5VuOnfUHQc0XwAhQeeRmfBaZ25SIfnn1KVqvySM7
         BggWkuDH5aTbLuZDfELRmdCWe+Ns89AJsgnQp8pT2ytxfvkk1cOl9/xM2GhXtu75fSN8
         5UXg==
X-Gm-Message-State: AOAM531MZOHbI+7L6jpI+/5QtZGyU26sUUaHfebVgcS4WrnsUoKQ93Io
        pyzdc23eA9ObRgDE1suxur1pTtt7IH3unomqLc02z+tcuVzdUVpkBAOhmRmlsyYFZVwZO6v28Q+
        vUjva+rzBxILMGckWzRTv0/7j
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr32898438wmq.26.1637607571025;
        Mon, 22 Nov 2021 10:59:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz4h5ayUjDJFHRj/e8HxhdGSuXFE8GfuC/y623hSpzLQq0+z6UvU8ABidTTQ9NoED8Ozn30xA==
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr32898396wmq.26.1637607570779;
        Mon, 22 Nov 2021 10:59:30 -0800 (PST)
Received: from [192.168.3.132] (p5b0c667b.dip0.t-ipconnect.de. [91.12.102.123])
        by smtp.gmail.com with ESMTPSA id f81sm24683266wmf.22.2021.11.22.10.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 10:59:30 -0800 (PST)
Message-ID: <1b30d06d-f9c0-1737-13e6-2d1a7d7b8507@redhat.com>
Date:   Mon, 22 Nov 2021 19:59:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211120201230.920082-1-shakeelb@google.com>
 <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
 <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
In-Reply-To: <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.21 19:40, Shakeel Butt wrote:
> On Mon, Nov 22, 2021 at 12:32 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 20.11.21 21:12, Shakeel Butt wrote:
>>> Many applications do sophisticated management of their heap memory for
>>> better performance but with low cost. We have a bunch of such
>>> applications running on our production and examples include caching and
>>> data storage services. These applications keep their hot data on the
>>> THPs for better performance and release the cold data through
>>> MADV_DONTNEED to keep the memory cost low.
>>>
>>> The kernel defers the split and release of THPs until there is memory
>>> pressure. This causes complicates the memory management of these
>>> sophisticated applications which then needs to look into low level
>>> kernel handling of THPs to better gauge their headroom for expansion.
>>
>> Can you elaborate a bit on that point? What exactly does such an
>> application do? I would have assumed that it's mostly transparent for
>> applications.
>>
> 
> The application monitors its cgroup usage to decide if it can expand
> the memory footprint or release some (unneeded/cold) buffer. It
> releases madvise(MADV_DONTNEED) to release the memory which basically
> puts the THP into defer list. These deferred THPs are still charged to
> the cgroup which leads to bloated usage read by the application and
> making wrong decisions. Internally we added a cgroup interface to
> trigger the split of deferred THPs for that cgroup but this is hacky
> and exposing kernel internals to users. I want to solve this problem
> in a more general way for the users.

Thanks for the details, that makes sense to me. It's essentially like
another kernel buffer charged to the process, only reclaimed on memory
reclaim.

(can we add that to the patch description?)

> 
>>> In
>>> addition these applications are very latency sensitive and would prefer
>>> to not face memory reclaim due to non-deterministic nature of reclaim.
>>
>> That makes sense.
>>
>>>
>>> This patch let such applications not worry about the low level handling
>>> of THPs in the kernel and splits the THPs synchronously on
>>> MADV_DONTNEED.
>>
>> The main user I'm concerned about is virtio-balloon, which ends up
>> discarding VM memory via MADV_DONTNEED when inflating the balloon in the
>> guest in 4k granularity, but also during "free page reporting"
>> continuously when e.g., a 2MiB page becomes free in the guest. We want
>> both activities to be fast, and especially during "free page reporting",
>> to defer any heavy work.
> 
> Thanks for the info. What is the source virtio-balloon used for free pages?

So inside the guest (driver/virtio/virtio_balloon.c), we can see:

1. Balloon inflation. We essentially allocate a 4k page and send the PFN
to the hypervisor. The hypervisor will MADV_DONTNEED that memory.

2. Free page reporting. We pull some free higher-order (e.g., 2 MB on
x86-64) pages from the page allocator and report the PFNs to the
hypervisor. The hypervisor will MADV_DONTNEED the regions. Once
reported, we putback the free pages to the free page list in the page
allocator, from where it can be re-allocated eventually immediately.

On some archs (especially aarch64), we can see free page reporting
report sub-THP granularity. But usually we're dealing with THP granularity.

> 
>>
>> Do we have a performance evaluation how much overhead is added e.g., for
>> a single 4k MADV_DONTNEED call on a THP or on a MADV_DONTNEED call that
>> covers the whole THP?
> 
> I did a simple benchmark of madvise(MADV_DONTNEED) on 10000 THPs on
> x86 for both settings you suggested. I don't see any statistically
> significant difference with and without the patch. Let me know if you
> want me to try something else.

Awesome, thanks for benchmarking. I did not check, but I assume on
re-access, we won't actually re-use pages from the underlying, partially
unmapped, THP, correct? So after MADV_DONTNEED, the zapped sub-pages are
essentially lost until reclaimed by splitting the THP? If they could get
reused, there would be value in the deferred split when partially
unmapping a THP.


I do wonder which purpose the deferred split serves nowadays at all.
Fortunately, there is documentation: Documentation/vm/transhuge.rst:

"
Unmapping part of THP (with munmap() or other way) is not going to free
memory immediately. Instead, we detect that a subpage of THP is not in
use in page_remove_rmap() and queue the THP for splitting if memory
pressure comes. Splitting will free up unused subpages.

Splitting the page right away is not an option due to locking context in
the place where we can detect partial unmap. It also might be
counterproductive since in many cases partial unmap happens during
exit(2) if a THP crosses a VMA boundary.

The function deferred_split_huge_page() is used to queue a page for
splitting. The splitting itself will happen when we get memory pressure
via shrinker interface.
"

I do wonder which these locking contexts are exactly, and if we could
also do the same thing on ordinary munmap -- because I assume it can be
similarly problematic for some applications. The "exit()" case might
indeed be interesting, but I really do wonder if this is even observable
in actual number: I'm not so sure about the "many cases" but I might be
wrong, of course.

-- 
Thanks,

David / dhildenb

