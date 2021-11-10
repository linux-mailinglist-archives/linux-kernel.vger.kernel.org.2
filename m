Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D0544C2A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 14:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhKJOCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 09:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhKJOCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 09:02:34 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A15C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 05:59:46 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so1911193pjc.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 05:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=tFIzrVfWxUu1s11DMzseTciEZacVYJOeZPAxD7PkBnc=;
        b=fMUDtoK0LHbZtB4+J67U/8RChvQYDgrgNEChmKP8uO3RjuUAAPdRq004ML+AfuGCgn
         7MiZdzrDqODFsUVAXsjvQbTS/61YMYBifNacfpXUDICni4DdnTEeLEFGKR/87CCW/0U4
         zeNPkt0ejt+JePwX3vMqp3ENHuGTLdSU3Cm9wmTZBRBOfGntCJUTe8MeF5dTmjmkplAp
         4rCCHYaU77kyY00DemZ765mAN/XVPiVOMsnMyWDUJNg5z8Om+kvq5wFA+Ecgjq3gJ5WM
         SS/01f4YZrlmPyGz2n9DzCXkaca2eVq3nnMTUjfEPJ1FDqFlOwMEHSEM6/OjZldlEO44
         SDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tFIzrVfWxUu1s11DMzseTciEZacVYJOeZPAxD7PkBnc=;
        b=B/5RDvejf1PKuc00yR2sIFvXtNp8GfmhHcO5GHSjnxhIxoKY99DkywzCSfjKYNmMn6
         Dq+Sa1qbL0FOF6AgQ4aFSdJQ+yatoXRyj+phRKrmujs/7EFGUFF/IkUN8pAuO/iGhivJ
         b1uO2LJ2td+Qu7I9uiplE2x+113jylapFHa+SfJEqR6srs9d3bQBnISC6ZUGOCEJMcu4
         QImBDWTvhYdSNgLKU312hYbTyfzpEfTLGcJ5K0c/xebvnrDwuJcxoD/vo+F/kRgXXwrS
         eKMddaqJQJKlFNFUE9CTXQd5ZbuI1mvsGLvhMr6z1w1KU4H7Kdk/zsX82g81zOdQrG/R
         XvyQ==
X-Gm-Message-State: AOAM530cgHqockZADEBcWotSU1UFr0dylUT/jNsRAFmuBZNjEgMkzUiu
        n3o03GrBA8mlqp06/aolALCfrg==
X-Google-Smtp-Source: ABdhPJyhZgAb2msPG/ckhwytGG7U2KKGRU4QdobBz5WlQJnXbF5X4E026bM/Jw/kMzmZVHJF6VUNhw==
X-Received: by 2002:a17:90a:c58f:: with SMTP id l15mr98890pjt.168.1636552786017;
        Wed, 10 Nov 2021 05:59:46 -0800 (PST)
Received: from [10.254.189.129] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id w12sm6189400pjq.2.2021.11.10.05.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 05:59:45 -0800 (PST)
Message-ID: <1dac28b1-9a35-25bd-08f4-e1594fdb35d1@bytedance.com>
Date:   Wed, 10 Nov 2021 21:59:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v3 00/15] Free user PTE page table pages
To:     David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
 <20211110125601.GQ1740502@nvidia.com>
 <8d0bc258-58ba-52c5-2e0d-a588489f2572@redhat.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <8d0bc258-58ba-52c5-2e0d-a588489f2572@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/21 9:25 PM, David Hildenbrand wrote:
> On 10.11.21 13:56, Jason Gunthorpe wrote:
>> On Wed, Nov 10, 2021 at 06:54:13PM +0800, Qi Zheng wrote:
>>
>>> In this patch series, we add a pte_refcount field to the struct page of page
>>> table to track how many users of PTE page table. Similar to the mechanism of
>>> page refcount, the user of PTE page table should hold a refcount to it before
>>> accessing. The PTE page table page will be freed when the last refcount is
>>> dropped.
>>
>> So, this approach basically adds two atomics on every PTE map
>>
>> If I have it right the reason that zap cannot clean the PTEs today is
>> because zap cannot obtain the mmap lock due to a lock ordering issue
>> with the inode lock vs mmap lock.
> 
> There are different ways to zap: madvise(DONTNEED) vs
> fallocate(PUNCH_HOLE). It depends on "from where" we're actually
> comming: a process page table walker or the rmap.
> 
> The way locking currently works doesn't allow to remove a page table
> just by holding the mmap lock, not even in write mode. You'll also need
> to hold the respective rmap locks -- which implies that reclaiming apge
> tables crossing VMAs is "problematic". Take a look at khugepaged which
> has to play quite some tricks to remove a page table.
> 
> And there are other ways we can create empty page tables via the rmap,
> like reclaim/writeback, although they are rather a secondary concern mostly.
> 
>>
>> If it could obtain the mmap lock then it could do the zap using the
>> write side as unmapping a vma does.
>>
>> Rather than adding a new "lock" to ever PTE I wonder if it would be
>> more efficient to break up the mmap lock and introduce a specific
>> rwsem for the page table itself, in addition to the PTL. Currently the
>> mmap lock is protecting both the vma list and the page table.
> 
> There is the rmap side of things as well. At least the rmap won't
> reclaim alloc/free page tables, but it will walk page tables while
> holding the respective rmap lock.
> 
>>
>> I think that would allow the lock ordering issue to be resolved and
>> zap could obtain a page table rwsem.
>>
>> Compared to two atomics per PTE this would just be two atomic per
>> page table walk operation, it is conceptually a lot simpler, and would
>> allow freeing all the page table levels, not just PTEs.
> 
> Another alternative is to not do it in the kernel automatically, but
> instead have a madvise(MADV_CLEANUP_PGTABLE) mechanism that will get
> called by user space explicitly once it's reasonable. While this will
> work for the obvious madvise(DONTNEED) users -- like memory allocators
> -- that zap memory, it's a bit more complicated once shared memory is
> involved and we're fallocate(PUNCH_HOLE) memory. But it would at least
> work for many use cases that want to optimize memory consumption for
> sparse memory mappings.
> 
> Note that PTEs are the biggest memory consumer. On x86-64, a 1 TiB area
> will consume 2 GiB of PTE tables and only 4 MiB of PMD tables. So PTEs
> are most certainly the most important part piece.
> 

total agree!

Thanks,
Qi
