Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01F03D1E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhGVFqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:46:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59988 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229955AbhGVFqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626935232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=16MfRQqxh1i6QuzX2eKR1pL3W5i4BoPVR6Kn/ien+P4=;
        b=Kv5UVvCK48tWDSutb/78xqXi486H1D/LxXhMWKodVE1isRV8QryKAN91MYouTyXnNyrAQT
        GXJzNaH3zndQYGkCLGSFOldudK6xNFYUUDaYEzI/rwORZ+AP5hlofLj4f1b9hffzf4QO1F
        rOtlV4oAi8l7hdI8Ne7hdsX5LwmbfcI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-_EAiRz2aMnmapf_rlN5VuQ-1; Thu, 22 Jul 2021 02:27:10 -0400
X-MC-Unique: _EAiRz2aMnmapf_rlN5VuQ-1
Received: by mail-wm1-f72.google.com with SMTP id v25-20020a1cf7190000b0290197a4be97b7so1137932wmh.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 23:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=16MfRQqxh1i6QuzX2eKR1pL3W5i4BoPVR6Kn/ien+P4=;
        b=VXAFcCZncfJm0Cyt5u5iDe6zanbTbGHLqNWOX41UeDYx+NBsOi+LDqKZFqSvhmYhax
         ++LNr82zN46gM1GFIbICPY+SldCg1HhKZJdPCoXrCyWTb3Au93FkjjEDyxjbhddP+qIG
         nOwYYvwbAUtY53o74hMT9PG/nPAOEBSvNnzE8dPPIP1+3kttl2Wx/A2zz6YJjA248src
         VpoU2HnePt5nhuBp6jmuN7lFDqkzbmYYuHVP9sg4dXCyg6ShA5u7DezGy9bb1p54odnX
         ImzT40+kfVCIBcliDTcOnECF9GWmH29UwsyOP2pJx5XBhR1J9nlWbfB6b2z/jtVFRNz2
         9j7Q==
X-Gm-Message-State: AOAM532c/A3UIsAFPy3AVuEUFSSXZ5RpqvzMEv9lkRjkkjAN2GYW1ZK2
        AF8qHv9mUnpYPCdmow9DWgnACcJuTydWrRDZmbHI2MNq7TXfS948WkDQz3u5mr/eQYD1I6pXM/6
        cGN1c8X8NQn8daYAWxG1BD9hd
X-Received: by 2002:a05:600c:2298:: with SMTP id 24mr7630436wmf.36.1626935229556;
        Wed, 21 Jul 2021 23:27:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcYJZbsYRrvqEoeKSa+7sZmNgVZD81UWD+roUznufva3s9buy3uMB+FHWQJyGA3LWOh/FnSg==
X-Received: by 2002:a05:600c:2298:: with SMTP id 24mr7630396wmf.36.1626935229288;
        Wed, 21 Jul 2021 23:27:09 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6970.dip0.t-ipconnect.de. [91.12.105.112])
        by smtp.gmail.com with ESMTPSA id e15sm28507995wrp.29.2021.07.21.23.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 23:27:08 -0700 (PDT)
To:     Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>
Cc:     Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Carl Waldspurger [C]" <carl.waldspurger@nutanix.com>,
        Florian Schmidt <flosch@nutanix.com>,
        "ovzxemul@gmail.com" <ovzxemul@gmail.com>
References: <20210715201422.211004-1-peterx@redhat.com>
 <20210715201651.212134-1-peterx@redhat.com>
 <A83FCF8F-193E-4584-9442-C95B2635FD03@nutanix.com> <YPWiRsNaearMNB2g@t490s>
 <D2FD5D85-BA6D-492E-801F-E5003452DA70@nutanix.com> <YPW8xaejtl68AYCk@t490s>
 <CY4PR0201MB3460E372956C0E1B8D33F904E9E39@CY4PR0201MB3460.namprd02.prod.outlook.com>
 <5c3c84ee-02f6-a2af-13b8-5dcf70676641@redhat.com>
 <CY4PR0201MB3460AAED19F46CD184B2AB30E9E39@CY4PR0201MB3460.namprd02.prod.outlook.com>
 <YPifc+eRNSs/rjv1@t490s> <YPimPFvyH2MWLLp/@t490s>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 24/26] mm/pagemap: Recognize uffd-wp bit for
 shmem/hugetlbfs
Message-ID: <3a316327-0971-6c30-ca23-a2f9d580f97d@redhat.com>
Date:   Thu, 22 Jul 2021 08:27:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPimPFvyH2MWLLp/@t490s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.07.21 00:57, Peter Xu wrote:
> On Wed, Jul 21, 2021 at 06:28:03PM -0400, Peter Xu wrote:
>> Hi, Ivan,
>>
>> On Wed, Jul 21, 2021 at 07:54:44PM +0000, Ivan Teterevkov wrote:
>>> On Wed, Jul 21, 2021 4:20 PM +0000, David Hildenbrand wrote:
>>>> On 21.07.21 16:38, Ivan Teterevkov wrote:
>>>>> On Mon, Jul 19, 2021 5:56 PM +0000, Peter Xu wrote:
>>>>>> I'm also curious what would be the real use to have an accurate
>>>>>> PM_SWAP accounting.  To me current implementation may not provide
>>>>>> accurate value but should be good enough for most cases.  However not
>>>>>> sure whether it's also true for your use case.
>>>>>
>>>>> We want the PM_SWAP bit implemented (for shared memory in the pagemap
>>>>> interface) to enhance the live migration for some fraction of the
>>>>> guest VMs that have their pages swapped out to the host swap. Once
>>>>> those pages are paged in and transferred over network, we then want to
>>>>> release them with madvise(MADV_PAGEOUT) and preserve the working set
>>>>> of the guest VMs to reduce the thrashing of the host swap.
>>>>
>>>> There are 3 possibilities I think (swap is just another variant of the page cache):
>>>>
>>>> 1) The page is not in the page cache, e.g., it resides on disk or in a swap file.
>>>> pte_none().
>>>> 2) The page is in the page cache and is not mapped into the page table.
>>>> pte_none().
>>>> 3) The page is in the page cache and mapped into the page table.
>>>> !pte_none().
>>>>
>>>> Do I understand correctly that you want to identify 1) and indicate it via
>>>> PM_SWAP?
>>>
>>> Yes, and I also want to outline the context so we're on the same page.
>>>
>>> This series introduces the support for userfaultfd-wp for shared memory
>>> because once a shared page is swapped, its PTE is cleared. Upon retrieval
>>> from a swap file, there's no way to "recover" the _PAGE_SWP_UFFD_WP flag
>>> because unlike private memory it's not kept in PTE or elsewhere.
>>>
>>> We came across the same issue with PM_SWAP in the pagemap interface, but
>>> fortunately, there's the place that we could query: the i_pages field of
>>> the struct address_space (XArray). In https://lkml.org/lkml/2021/7/14/595
>>> we do it similarly to what shmem_fault() does when it handles #PF.
>>>
>>> Now, in the context of this series, we were exploring whether it makes
>>> any practical sense to introduce more brand new flags to the special
>>> PTE to populate the pagemap flags "on the spot" from the given PTE.
>>>
>>> However, I can't see how (and why) to achieve that specifically for
>>> PM_SWAP even with an extra bit: the XArray is precisely what we need for
>>> the live migration use case. Another flag PM_SOFT_DIRTY suffers the same
>>> problem as UFFD_WP_SWP_PTE_SPECIAL before this patch series, but we don't
>>> need it at the moment.
>>>
>>> Hope that clarification makes sense?
>>
>> Yes it helps, thanks.
>>
>> So I can understand now on how that patch comes initially, even if it may not
>> work for PM_SOFT_DIRTY but it seems working indeed for PM_SWAP.
>>
>> However I have a concern that I raised also in the other thread: I think
>> there'll be an extra and meaningless xa_load() for all the real pte_none()s
>> that aren't swapped out but just having no page at the back from the very
>> beginning.  That happens much more frequent when the memory being observed by
>> pagemap is mapped in a huge chunk and sparsely mapped.
>>
>> With old code we'll simply skip those ptes, but now I have no idea how much
>> overhead would a xa_load() brings.

Let's benchmark it then. I feel like we really shouldn't be storing 
unnecessarily data in page tables if they are readily available 
somehwere else, because ...

>>
>> Btw, I think there's a way to implement such an idea similar to the swap
>> special uffd-wp pte - when page reclaim of shmem pages, instead of putting a
>> none pte there maybe we can also have one bit set in the none pte showing that
>> this pte is swapped out.  When the page faulted back we just drop that bit.
>>
>> That bit could be also scanned by pagemap code to know that this page was
>> swapped out.  That should be much lighter than xa_load(), and that identifies
>> immediately from a real none pte just by reading the value.

... we are optimizing a corner case feature (pagemap) by affecting other 
system parts. Just imagine

1. Forking: will always have to copy the whole page tables for shemem 
instead of optimizing.
2. New shmem mappings: will always have to sync back that bit from the 
pagecache

And these are just the things that immediately come to mind. There is 
certainly more (e.g., page table reclaim [1]).

>>
>> Do you think this would work?
> 
> Btw, I think that's what Tiberiu used to mention, but I think I just changed my
> mind..  Sorry to have brought such a confusion.
> 
> So what I think now is: we can set it (instead of zeroing the pte) right at
> unmapping the pte of page reclaim.  Code-wise, that can be a special flag
> (maybe, TTU_PAGEOUT?) passed over to try_to_unmap() of shrink_page_list() to
> differenciate from other try_to_unmap()s.
> 
> I think that bit can also be dropped correctly e.g. when punching a hole in the
> file, then rmap_walk() can find and drop the marker (I used to suspect uffd-wp
> bit could get left-overs, but after a second thought here similarly, it seems
> it won't; as long as hole punching and vma unmapping will always be able to
> scan those marker ptes, then it seems all right to drop them correctly).
> 
> But that's my wild thoughts; I could have missed something too.
> 

Adding to that, Peter can you enlighten me  how uffd-wp on shmem 
combined with the uffd-wp bit in page tables is supposed to work in 
general when talking about multiple processes?

Shmem means any process can modify any memory. To be able to properly 
catch writes to such memory, the only way I can see it working is

1. All processes register uffd-wp on the shmem VMA
2. All processes arm uffd-wp by setting the same uffd-wp bits in their 
page tables for the affected shmem
3. All processes synchronize, sending each other uffd-wp events when 
they receive one

This is quite ... suboptimal I have to say. This is really the only way 
I can imagine uffd-wp to work reliably. Is there any obvious way to make 
this work I am missing?

But then, all page tables are already supposed to contain the uffd-wp 
bit. Which makes me think that we can actually get rid of the uffd-wp 
bit in the page table for pte_none() entries and instead store this 
information somewhere else (in the page cache?) for all entries combined.

So that simplification would result in

1. All processes register uffd-wp on the shmem VMA
2. One processes wp-protects uffd-wp via the page cache (we can update 
all PTEs in other processes)
3. All processes synchronize, sending each other uffd-wp events when 
they receive one

The semantics of uffd-wp on shmem would be different to what we have so 
far ... which would be just fine as we never had uffd-wp on shared memory.

In an ideal world, 1. and 3. wouldn't be required and all registered 
uffd listeners would be notified when any process writes to it.


Sure, for single-user shmem it would work just like !shmem, but then, 
maybe that user really shouldn't be using shmem. But maybe I am missing 
something important :)

> Thanks,
> 

[1] 
https://lkml.kernel.org/r/20210718043034.76431-1-zhengqi.arch@bytedance.com

-- 
Thanks,

David / dhildenb

