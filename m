Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2359444D589
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 12:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhKKLLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 06:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhKKLLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 06:11:33 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A2EC061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 03:08:44 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id p17so4881443pgj.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 03:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=1+xaCmV6Hn3zO59rMpgR4feSecB3T/0jAB5KPesc7ZA=;
        b=cYkjIYJYQAO5ZoYoWf+CL9ig21nVS7CqMr23yCxjvuIVAy0SgtP1WiQ0WQQ3BOfl/v
         hV9R0mNGbxT3v5++I9ooZm3+gj/m4Pu4JdP0flapAf3eVOoQtpv/Cp5FlypDqNYgvO8Y
         0JsKCYjQ0tkybNjzafcgdoA1Hwb1hwJt2v+wtbCvzs5r8M40B+6sb+H5L/ThGWi5nI9c
         tWURndWHuC4Mdi9vpiZWG4kNTEnJxQ+CqtEKijOwVliB+ODZLD1E0byvyQ1eHX6X4pmv
         Hlmt9ylUjT2DqKRZKRuQoEvEjiEnAic7uzaouay1g/eB1wgkXZ7NyqlbzwkejrwFKF76
         WhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1+xaCmV6Hn3zO59rMpgR4feSecB3T/0jAB5KPesc7ZA=;
        b=0lnF9lpB6zLfEK9GOcWMelorO98xQWiBHXRh16UR3bgMeUNRCOx4xUsb+MASjw+9MG
         MOCejONJUHvnnLhR2ayCKrrUgUcJaHlHO3ErUDlaEo9bE40dgSnTMR5OQoEAhbgORjGp
         Yw35RVAj5TxLcetnBJxBYSuGTe1xhuEnt0a38omGmUlYkSefP/5IXChT+sy/vLGu/2Py
         cB8858ncBpmcDej9jQKv1263klbWnrDEhyUN3zUERMXMF9YSfUed77dCCY4dkFKRZpFU
         DAi2x6AlRkSyU9+3IxnwKKmpJibws+NhJF9GIS3XRA8lka2w6j4EYqL9+XsnoSjlWCH+
         JYlg==
X-Gm-Message-State: AOAM533yRMlgOCljhmT5D8e+2nKUf9CRPS8HTv/p67kDHzqbZsBve0fo
        81Kq4NGiVCkzkAW3e26TJ9Tceg==
X-Google-Smtp-Source: ABdhPJz67P4vUHNseHsMlzE9QMANsBWRW6gtm2ephSmH+1A44Wp4PNkq94ElDr7xgac1/L+wC+q9Gg==
X-Received: by 2002:a63:1b5c:: with SMTP id b28mr4039791pgm.316.1636628924386;
        Thu, 11 Nov 2021 03:08:44 -0800 (PST)
Received: from [10.254.173.217] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id z22sm1877942pfe.93.2021.11.11.03.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 03:08:43 -0800 (PST)
Message-ID: <9ee06b52-4844-7996-fa34-34fc7d4fdc10@bytedance.com>
Date:   Thu, 11 Nov 2021 19:08:35 +0800
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
 <20211110143859.GS1740502@nvidia.com>
 <6ac9cc0d-7dea-0e19-51b3-625ec6561ac7@redhat.com>
 <20211110163925.GX1740502@nvidia.com>
 <7c97d86f-57f4-f764-3e92-1660690a0f24@redhat.com>
 <60515562-5f93-11cd-6c6a-c7cc92ff3bf8@bytedance.com>
 <a052e0ba-a22c-5df1-80b8-d847efacd66e@redhat.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <a052e0ba-a22c-5df1-80b8-d847efacd66e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/21 5:22 PM, David Hildenbrand wrote:
> On 11.11.21 04:58, Qi Zheng wrote:
>>
>>
>> On 11/11/21 1:37 AM, David Hildenbrand wrote:
>>>>> It would still be a fairly coarse-grained locking, I am not sure if that
>>>>> is a step into the right direction. If you want to modify *some* page
>>>>> table in your process you have exclude each and every page table walker.
>>>>> Or did I mis-interpret what you were saying?
>>>>
>>>> That is one possible design, it favours fast walking and penalizes
>>>> mutation. We could also stick a lock in the PMD (instead of a
>>>> refcount) and still logically be using a lock instead of a refcount
>>>> scheme. Remember modify here is "want to change a table pointer into a
>>>> leaf pointer" so it isn't an every day activity..
>>>
>>> It will be if we somewhat frequent when reclaim an empty PTE page table
>>> as soon as it turns empty. This not only happens when zapping, but also
>>> during writeback/swapping. So while writing back / swapping you might be
>>> left with empty page tables to reclaim.
>>>
>>> Of course, this is the current approach. Another approach that doesn't
>>> require additional refcounts is scanning page tables for empty ones and
>>> reclaiming them. This scanning can either be triggered manually from
>>> user space or automatically from the kernel.
>>
>> Whether it is introducing a special rwsem or scanning an empty page
>> table, there are two problems as follows:
>>
>> 	#1. When to trigger the scanning or releasing?
> 
> For example when reclaiming memory, when scanning page tables in
> khugepaged, or triggered by user space (note that this is the approach I
> originally looked into). But it certainly requires more locking thought
> to avoid stopping essentially any page table walker.
> 
>> 	#2. Every time to release a 4K page table page, 512 page table
>> 	    entries need to be scanned.
> 
> It would happen only when actually trigger reclaim of page tables
> (again, someone has to trigger it), so it's barely an issue.
> 
> For example, khugepaged already scans the page tables either way.
> 
>>
>> For #1, if the scanning is triggered manually from user space, the
>> kernel is relatively passive, and the user does not fully know the best
>> timing to scan. If the scanning is triggered automatically from the
>> kernel, that is great. But the timing is not easy to confirm, is it
>> scanned and reclaimed every time zap or try_to_unmap?
>>
>> For #2, refcount has advantages.
>>
>>>
>>>>
>>>> There is some advantage with this thinking because it harmonizes well
>>>> with the other stuff that wants to convert tables into leafs, but has
>>>> to deal with complicated locking.
>>>>
>>>> On the other hand, refcounts are a degenerate kind of rwsem and only
>>>> help with freeing pages. It also puts more atomics in normal fast
>>>> paths since we are refcounting each PTE, not read locking the PMD.
>>>>
>>>> Perhaps the ideal thing would be to stick a rwsem in the PMD. read
>>>> means a table cannot be come a leaf. I don't know if there is space
>>>> for another atomic in the PMD level, and we'd have to use a hitching
>>>> post/hashed waitq scheme too since there surely isn't room for a waitq
>>>> too..
>>>>
>>>> I wouldn't be so quick to say one is better than the other, but at
>>>> least let's have thought about a locking solution before merging
>>>> refcounts :)
>>>
>>> Yes, absolutely. I can see the beauty in the current approach, because
>>> it just reclaims "automatically" once possible -- page table empty and
>>> nobody is walking it. The downside is that it doesn't always make sense
>>> to reclaim an empty page table immediately once it turns empty.
>>>
>>> Also, it adds complexity for something that is only a problem in some
>>> corner cases -- sparse memory mappings, especially relevant for some
>>> memory allocators after freeing a lot of memory or running VMs with
>>> memory ballooning after inflating the balloon. Some of these use cases
>>> might be good with just triggering page table reclaim manually from user
>>> space.
>>>
>>
>> Yes, this is indeed a problem. Perhaps some flags can be introduced so
>> that the release of page table pages can be delayed in some cases.
>> Similar to the lazyfree mechanism in MADV_FREE?
> 
> The issue AFAIU is that once your refcount hits 0 (no more references,
> no more entries), the longer you wait with reclaim, the longer others
> have to wait for populating a fresh page table because the "page table
> to be reclaimed" is still stuck around. You'd have to keep the refcount
> increased for a while, and only drop it after a while. But when? And
> how? IMHO it's not trivial, but maybe there is an easy way to achieve it.
> 

For running VMs with memory ballooning after inflating the balloon, is
this a hot behavior? Even if it is, it is already facing the release and
reallocation of physical pages. The overhead after introducing
pte_refcount is that we need to release and re-allocate page table page.
But 2MB physical pages only corresponds to 4KiB of PTE page table page.
So maybe the overhead is not big.

In fact, the performance test shown on the cover letter is this case:

	test program: 
https://lore.kernel.org/lkml/20100106160614.ff756f82.kamezawa.hiroyu@jp.fujitsu.com/2-multi-fault-all.c

Thanks,
Qi

> 
