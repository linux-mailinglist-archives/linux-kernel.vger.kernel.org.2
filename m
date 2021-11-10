Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A2A44C484
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 16:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhKJPkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 10:40:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232457AbhKJPkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 10:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636558639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+erTvGbViXM/hcAqiyOBnjNlThmQiYYMieKA809wTio=;
        b=FTisEmXwb1hrb3nqOW0bk5tHKCoUufI9DtcFV3VlFQiZaWrhENHVGaYWzXTWeFCeUi6Ety
        5qbRLdaMdFRQFnBA6iBrqAIx6g5N+X5if+jVuO+zIMb/bUfNQs8Sa6eV6aAuUHc1d6CHXM
        UTjJqKnbXwvYy9VOLKQO+dVzyoVUx6c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-9XFtCmAbN8S3ZwgjGlFjtQ-1; Wed, 10 Nov 2021 10:37:18 -0500
X-MC-Unique: 9XFtCmAbN8S3ZwgjGlFjtQ-1
Received: by mail-wm1-f70.google.com with SMTP id b145-20020a1c8097000000b003335872db8dso685538wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 07:37:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=+erTvGbViXM/hcAqiyOBnjNlThmQiYYMieKA809wTio=;
        b=F3BdyMCRnVA5KqiQKnmSM2GgD3Q15aKNwr50iX8EXwpYLFrL85LeTPXo7L7cUBnUyd
         xMtvujh7NE03Wjl0OJQRx6eKR2ukfXhMGMgQ5yPt11HD6P2UI7lO5jbWNaGuRqy7RNwS
         gSQE7v002uTUbZWZx8NtUYsgePmiOnYEW8HkhKuEds6wdXAWjXYSftbLzIYLnKeLh/2D
         jW1KgzYbRIu8R+rwrOfqPiR/mvxW2CFhO4JiJT0lh5ENDEXrPPnheg72eO7yZ0EspdA7
         nbWTcSahydZcLU3yfrFlGd5M8Fvtn0TYLqk8k5kq0pCZo33WHlzpX6/oR7ES52T8vCE/
         VGgw==
X-Gm-Message-State: AOAM531RaYMh8KBwfyreQUF/bl0GKIEUmrvasz+izQ6GNPZuzS6J3jME
        jiadeTs5usIzqK6UURILFdmYXt8Jh+pyXgttuOsy1OGcVca6PzRC30ijp0Vs6ximIMu1myR/4SW
        9C2BWeY2zIzP6l9zW3QbXbw7U
X-Received: by 2002:a1c:7c14:: with SMTP id x20mr17027517wmc.75.1636558636859;
        Wed, 10 Nov 2021 07:37:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2LQ5JcN0cXDrvYwjew6cnwoFMvhJ5Q7w+5u8XlCspgHp/gRqQ3EEVovEOZf72U3nS7PJ2TA==
X-Received: by 2002:a1c:7c14:: with SMTP id x20mr17027483wmc.75.1636558636591;
        Wed, 10 Nov 2021 07:37:16 -0800 (PST)
Received: from [192.168.3.132] (p5b0c604f.dip0.t-ipconnect.de. [91.12.96.79])
        by smtp.gmail.com with ESMTPSA id h16sm267667wrm.27.2021.11.10.07.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 07:37:15 -0800 (PST)
Message-ID: <6ac9cc0d-7dea-0e19-51b3-625ec6561ac7@redhat.com>
Date:   Wed, 10 Nov 2021 16:37:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, zhouchengming@bytedance.com
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
 <20211110125601.GQ1740502@nvidia.com>
 <8d0bc258-58ba-52c5-2e0d-a588489f2572@redhat.com>
 <20211110143859.GS1740502@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 00/15] Free user PTE page table pages
In-Reply-To: <20211110143859.GS1740502@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.11.21 15:38, Jason Gunthorpe wrote:
> On Wed, Nov 10, 2021 at 02:25:50PM +0100, David Hildenbrand wrote:
>> On 10.11.21 13:56, Jason Gunthorpe wrote:
>>> On Wed, Nov 10, 2021 at 06:54:13PM +0800, Qi Zheng wrote:
>>>
>>>> In this patch series, we add a pte_refcount field to the struct page of page
>>>> table to track how many users of PTE page table. Similar to the mechanism of
>>>> page refcount, the user of PTE page table should hold a refcount to it before
>>>> accessing. The PTE page table page will be freed when the last refcount is
>>>> dropped.
>>>
>>> So, this approach basically adds two atomics on every PTE map
>>>
>>> If I have it right the reason that zap cannot clean the PTEs today is
>>> because zap cannot obtain the mmap lock due to a lock ordering issue
>>> with the inode lock vs mmap lock.
>>
>> There are different ways to zap: madvise(DONTNEED) vs
>> fallocate(PUNCH_HOLE). It depends on "from where" we're actually
>> comming: a process page table walker or the rmap.
> 
> AFAIK rmap is the same issue, it can't lock the mmap_sem
> 
>> The way locking currently works doesn't allow to remove a page table
>> just by holding the mmap lock, not even in write mode. 
> 
> I'm not sure I understand this. If the goal is to free the PTE tables
> then the main concern is use-after free on page table walkers (which
> this series is addressing). Ignoring bugs, we have only three ways to
> read the page table:

Yes, use-after-free and reuse-while-freeing are the two challenges AFAIKs.

> 
>  - Fully locked. Under the PTLs (gup slow is an example)
>  - Semi-locked. Under the read mmap lock and no PTLs (hmm is an example)
>  - hw-locked. Barriered with TLB flush (gup fast is an example)

Three additions as far as I can tell:

1. Fully locked currently needs the read mmap lock OR the rmap lock in
   read. PTLs on their own are not sufficient AFAIKT.
2. #1 and #2 can currently only walk within VMA ranges.
3. We can theoretically walk page tables outside VMA ranges with the
write mmap lock, because page tables get removed with the mmap lock in
read mode and heavy-weight operations (VMA layout, khugepaged) are
performed under the write mmap lock.

The rmap locks protect from modifications where we want to exclude rmap
walkers similarly to how we grab the mmap lock in write, where the PTLs
are not sufficient.

See mm/mremap.c:move_ptes() as an example which performs VMA layout +
page table modifications. See khugepagd which doesn't perform VMA layout
modifications but page table modifications.

> 
> #1 should be completely safe as the PTLs will protect eveything
> #2 is safe so long as the write side is held during any layout changes
> #3 interacts with the TLB flush, and is also safe with zap
> 
> rmap itself is a #1 page table walker, ie it gets the PTLs under
> page_vma_mapped_walk().

When you talk about PTLs, do you mean only PTE-PTLs or also PMD-PTLs?

Because the PMD-PTLs re usually not taken in case we know there is a
page table (nothing would currently change it without heavy locking).
And if they are taken, they are only held while allocating/checking a
PMDE, not while actually *using* the page table that's mapped in that entry.

For example, walk_page_range() requires the mmap lock in read and grabs
the PTE-PTLs.

> 
> The sin we have comitted here is that both the mmap lock and the PTLs
> are being used to protect the page table itself with a very
> complicated dual semantic.
> 
> Splitting the sleeping mmap lock into 'covers vma' and 'covers page
> tables' lets us solve the lock ordering and semi-locked can become
> more fully locked by the new lock, instead of by abusing mmap sem.

It would still be a fairly coarse-grained locking, I am not sure if that
is a step into the right direction. If you want to modify *some* page
table in your process you have exclude each and every page table walker.
Or did I mis-interpret what you were saying?

> 
> I'd suggest to make this new lock a special rwsem which allows either
> concurrent read access OR concurrent PTL access, but not both. This

I looked into such a lock recently in similar context and something like
that does not exist yet (and fairness will be challenging). You either
have a single reader or multiple writer. I'd be interested if someone
knows of something like that.


-- 
Thanks,

David / dhildenb

