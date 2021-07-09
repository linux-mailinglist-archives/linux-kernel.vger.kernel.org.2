Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DE13C2250
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhGIKoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229641AbhGIKoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625827278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ae+Gb/BEIsgQOybAACBFyFC4tH7km6cb1VeiKPutZiM=;
        b=goopRlM/SjxekQnt8OxA2dfe9yVQDFIaJSgd4Vk1UL4uGmhel41vsbJNJ6dNpxkrrU83nk
        F/lgj1Tn8QtrNnbbESPULbCSl+qMeyq4Qul3IqEkoggMlKrmYpR7P1LVN+xBkS4yqv90NS
        8Vro85xS2r9s7AEahBLendIqpqbV1NE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-jKUBdeSOMJ-R1zdRWab_hQ-1; Fri, 09 Jul 2021 06:41:17 -0400
X-MC-Unique: jKUBdeSOMJ-R1zdRWab_hQ-1
Received: by mail-wm1-f72.google.com with SMTP id p9-20020a7bcc890000b02902190142995dso1938568wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 03:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ae+Gb/BEIsgQOybAACBFyFC4tH7km6cb1VeiKPutZiM=;
        b=ajBoJwb2ICT/y76LdF2ksLlf9yd/vQt5BkjQ8P7ic/CyMWQ1b2r06QfS9h6dr8O5QS
         mwFtqiwbwHog2mEpriIl6onST+UXap/S4WA5iHmswUZ0fgDj2U/xtqbq1ftA47ZQZlbY
         2gKHXMs4HvkBGQBSqfUfg1W7qmRSH2ocI6d6TDYVkE/qFg6F4Xaq0xC5T8wD+0eXdLJh
         /6Ekd0RAKuasXmGdkPkPsNT+SvsnJC3qNB+Txh0fsfabb13yay2uloEbvXdBbQHJ1tS6
         C0v5I/la7hvA5x0wpV1raxLol59ViSlVpl177GSysfCCl8AAyB/Gy/Mhe49OcQTHr0Pg
         ACWg==
X-Gm-Message-State: AOAM530xOmtJAPtzgFs6yHTF1M/yHIpw9PbIkWV3i2BoaG2/G2FEa+FI
        FQgG8CuA3nG0VWhqsTc6bkMg6HyUReKAEiQTcSWaOLfx3Sl/yLgZPDSwEO8TBuJUpXhVtv/j7bD
        Aal3KzwnfAVqYg2+gn5NV3/rz
X-Received: by 2002:a5d:528d:: with SMTP id c13mr40788001wrv.343.1625827276307;
        Fri, 09 Jul 2021 03:41:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwp4lRsvoO/OSRheLkdIaB+VCVt9XlFPcQgpI8J2XgrxJLWROr/cDL2Oa2hpm3+6ZEkL0kNEA==
X-Received: by 2002:a5d:528d:: with SMTP id c13mr40787974wrv.343.1625827275982;
        Fri, 09 Jul 2021 03:41:15 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23a45.dip0.t-ipconnect.de. [79.242.58.69])
        by smtp.gmail.com with ESMTPSA id i11sm13140221wmg.18.2021.07.09.03.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 03:41:15 -0700 (PDT)
Subject: Re: [PATCH 00/29] Speculative page faults (anon vmas only)
From:   David Hildenbrand <david@redhat.com>
To:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
 <3047d699-2793-e051-e1eb-deef7c5764a8@redhat.com>
Organization: Red Hat
Message-ID: <fef963b1-cb28-9e75-f2b0-6744a2520e54@redhat.com>
Date:   Fri, 9 Jul 2021 12:41:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3047d699-2793-e051-e1eb-deef7c5764a8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.06.21 15:46, David Hildenbrand wrote:
> On 30.04.21 21:52, Michel Lespinasse wrote:
>> This patchset is my take on speculative page faults (spf).
>> It builds on ideas that have been previously proposed by Laurent Dufour,
>> Peter Zijlstra and others before. While Laurent's previous proposal
>> was rejected around the time of LSF/MM 2019, I am hoping we can revisit
>> this now based on what I think is a simpler and more bisectable approach,
>> much improved scaling numbers in the anonymous vma case, and the Android
>> use case that has since emerged. I will expand on these points towards
>> the end of this message.
>>
>> The patch series applies on top of linux v5.12;
>> a git tree is also available:
>> git fetch https://github.com/lespinasse/linux.git v5.12-spf-anon
>>
>> I believe these patches should be considered for merging.
>> My github also has a v5.12-spf branch which extends this mechanism
>> for handling file mapped vmas too; however I believe these are less
>> mature and I am not submitting them for inclusion at this point.
>>
>>
>> Compared to the previous (RFC) proposal, I have split out / left out
>> the file VMA handling parts, fixed some config specific build issues,
>> added a few more comments and modified the speculative fault handling
>> to use rcu_read_lock() rather than local_irq_disable() in the
>> MMU_GATHER_RCU_TABLE_FREE case.
>>
>>
>> Classical page fault processing takes the mmap read lock in order to
>> prevent races with mmap writers. In contrast, speculative fault
>> processing does not take the mmap read lock, and instead verifies,
>> when the results of the page fault are about to get committed and
>> become visible to other threads, that no mmap writers have been
>> running concurrently with the page fault. If the check fails,
>> speculative updates do not get committed and the fault is retried
>> in the usual, non-speculative way (with the mmap read lock held).
>>
>> The concurrency check is implemented using a per-mm mmap sequence count.
>> The counter is incremented at the beginning and end of each mmap write
>> operation. If the counter is initially observed to have an even value,
>> and has the same value later on, the observer can deduce that no mmap
>> writers have been running concurrently with it between those two times.
>> This is similar to a seqlock, except that readers never spin on the
>> counter value (they would instead revert to taking the mmap read lock),
>> and writers are allowed to sleep. One benefit of this approach is that
>> it requires no writer side changes, just some hooks in the mmap write
>> lock APIs that writers already use.
>>
>> The first step of a speculative page fault is to look up the vma and
>> read its contents (currently by making a copy of the vma, though in
>> principle it would be sufficient to only read the vma attributes that
>> are used in page faults). The mmap sequence count is used to verify
>> that there were no mmap writers concurrent to the lookup and copy steps.
>> Note that walking rbtrees while there may potentially be concurrent
>> writers is not an entirely new idea in linux, as latched rbtrees
>> are already doing this. This is safe as long as the lookup is
>> followed by a sequence check to verify that concurrency did not
>> actually occur (and abort the speculative fault if it did).
>>
>> The next step is to walk down the existing page table tree to find the
>> current pte entry. This is done with interrupts disabled to avoid
>> races with munmap(). Again, not an entirely new idea, as this repeats
>> a pattern already present in fast GUP. Similar precautions are also
>> taken when taking the page table lock.
> 
> Hi Michel,
> 
> I just started working on a project to reclaim page tables inside
> running processes that are no longer needed (for example, empty after
> madvise(DISCARD)). Long story short, there are scenarios where we want
> to scan for such page tables asynchronously to free up memory (which can
> be quite significant in some use cases).
> 
> Now that I (mostly) understood the complex locking, I'm looking for
> other mm features that might be "problematic" in that regard and require
> properly planning to get right (or let them run mutually exclusive).
> 
> As I essentially rip out page tables from the page table hierarchy to
> free them (in the simplest case within a VMA to get started), I
> certainly need the mmap lock in read right now to scan the page table
> hierarchy, and the mmap lock in write when actually removing a page
> table. This is similar handling as khugepagd when collapsing a THP and
> removing a page table. Of course, we could use any kind of
> synchronization mechanism (-> rcu) to make sure nobody is using a page
> table anymore before actually freeing it.
> 
> 1. I now wonder how your code actually protects against e.g., khugepaged
> and how it could protect against page table reclaim. Will we be using
> RCU while walking the page tables? That would make life easier.
> 
> 2. You mention "interrupts disabled to avoid races with munmap()". Can
> you elaborate how that is supposed to work? Shouldn't we rather be using
> RCU than manually disabling interrupts? What is the rationale?

Answering my questions, I assume this works just like gup_fast 
lockless_pages_from_mm(), whereby we rely on an IPI when clearing the 
TLB before actually freeing the page (-> mmu gather).

-- 
Thanks,

David / dhildenb

