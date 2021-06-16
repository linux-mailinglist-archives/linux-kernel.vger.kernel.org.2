Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE633A9388
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhFPHMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:12:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22325 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231516AbhFPHMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623827403;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oln2reXUo8+/mjpGU+4+W9/9q1UBKwsHP8eHkJE7n1M=;
        b=BFBkQmMqsgDDjInsWesKvbI1ubTFMf9ZlMLMPJEa0hk4uysR3ZACKPHlpKUYGk8qDG8D3R
        bbnjNuy5wmnFgdJPpRUHMLLOXDupKFC4rrozw+fDKrYFCpzmCWhfCzziNZzr1sXSDpMVz6
        PENxkaphTih/GaHBEZaYBTOI0HhlVk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-9TIoEbJJMgy9fss5WyLCXA-1; Wed, 16 Jun 2021 03:09:59 -0400
X-MC-Unique: 9TIoEbJJMgy9fss5WyLCXA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 179D38015C6;
        Wed, 16 Jun 2021 07:09:58 +0000 (UTC)
Received: from [10.64.54.84] (vpn2-54-84.bne.redhat.com [10.64.54.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 441495C1C2;
        Wed, 16 Jun 2021 07:09:51 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [RFC PATCH] mm/page_reporting: Adjust threshold according to
 MAX_ORDER
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        shan.gavin@gmail.com, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210601033319.100737-1-gshan@redhat.com>
 <76516781-6a70-f2b0-f3e3-da999c84350f@redhat.com>
 <0c0eb8c8-463d-d6f1-3cec-bbc0af0a229c@redhat.com>
 <b45b26ea-a6ac-934c-2467-c6e829b5d3ad@redhat.com>
 <CAKgT0Ue9SQ8=ju1m6ftKTb4Tai9EJ5NQhnB_uk-DzMc19-R4cQ@mail.gmail.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <63c06446-3b10-762c-3a29-464854b74e08@redhat.com>
Date:   Wed, 16 Jun 2021 19:10:55 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ue9SQ8=ju1m6ftKTb4Tai9EJ5NQhnB_uk-DzMc19-R4cQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/21 12:26 PM, Alexander Duyck wrote:
> On Mon, Jun 14, 2021 at 4:03 AM David Hildenbrand <david@redhat.com> wrote:
>> On 11.06.21 09:44, Gavin Shan wrote:
>>> On 6/1/21 6:01 PM, David Hildenbrand wrote:
>>>> On 01.06.21 05:33, Gavin Shan wrote:
>>>>> The PAGE_REPORTING_MIN_ORDER is equal to @pageblock_order, taken as
>>>>> minimal order (threshold) to trigger page reporting. The page reporting
>>>>> is never triggered with the following configurations and settings on
>>>>> aarch64. In the particular scenario, the page reporting won't be triggered
>>>>> until the largest (2 ^ (MAX_ORDER-1)) free area is achieved from the
>>>>> page freeing. The condition is very hard, or even impossible to be met.
>>>>>
>>>>>      CONFIG_ARM64_PAGE_SHIFT:              16
>>>>>      CONFIG_HUGETLB_PAGE:                  Y
>>>>>      CONFIG_HUGETLB_PAGE_SIZE_VARIABLE:    N
>>>>>      pageblock_order:                      13
>>>>>      CONFIG_FORCE_MAX_ZONEORDER:           14
>>>>>      MAX_ORDER:                            14
>>>>>
>>>>> The issue can be reproduced in VM, running kernel with above configurations
>>>>> and settings. The 'memhog' is used inside the VM to access 512MB anonymous
>>>>> area. The QEMU's RSS doesn't drop accordingly after 'memhog' exits.
>>>>>
>>>>>      /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64          \
>>>>>      -accel kvm -machine virt,gic-version=host                        \
>>>>>      -cpu host -smp 8,sockets=2,cores=4,threads=1 -m 4096M,maxmem=64G \
>>>>>      -object memory-backend-ram,id=mem0,size=2048M                    \
>>>>>      -object memory-backend-ram,id=mem1,size=2048M                    \
>>>>>      -numa node,nodeid=0,cpus=0-3,memdev=mem0                         \
>>>>>      -numa node,nodeid=1,cpus=4-7,memdev=mem1                         \
>>>>>        :                                                              \
>>>>>      -device virtio-balloon-pci,id=balloon0,free-page-reporting=yes
>>>>>
>>>>> This tries to fix the issue by adjusting the threshold to the smaller value
>>>>> of @pageblock_order and (MAX_ORDER/2). With this applied, the QEMU's RSS
>>>>> drops after 'memhog' exits.
>>>>
>>>> IIRC, we use pageblock_order to
>>>>
>>>> a) Reduce the free page reporting overhead. Reporting on small chunks can make us report constantly with little system activity.
>>>>
>>>> b) Avoid splitting THP in the hypervisor, avoiding downgraded VM performance.
>>>>
>>>> c) Avoid affecting creation of pageblock_order pages while hinting is active. I think there are cases where "temporary pulling sub-pageblock pages" can negatively affect creation of pageblock_order pages. Concurrent compaction would be one of these cases.
>>>>
>>>> The monstrosity called aarch64 64k is really special in that sense, because a) does not apply because pageblocks are just very big, b) does sometimes not apply because either our VM isn't backed by (rare) 512MB THP or uses 4k with 2MB THP and c) similarly doesn't apply in smallish VMs because we don't really happen to create 512MB THP either way.
>>>>
>>>>
>>>> For example, going on x86-64 from reporting 2MB to something like 32KB is absolutely undesired.
>>>>
>>>> I think if we want to go down that path (and I am not 100% sure yet if we want to), we really want to treat only the special case in a special way. Note that even when doing it only for aarch64 with 64k, you will still end up splitting THP in a hypervisor if it uses 64k base pages (b)) and can affect creation of THP, for example, when compacting (c), so there is a negative side to that.
>>>>
>>>
>>> [Remove Alexander from the cc list as his mail isn't reachable]
>>>
>>
>> [adding his gmail address which should be the right one]
>>
>>> David, thanks for your time to review and sorry for the delay and late response.
>>> I spent some time to get myself familiar with the code, but there are still some
>>> questions to me, explained as below.
>>>
>>> Yes, @pageblock_order is currently taken as page reporting threshold. It will
>>> incur more overhead if the threshold is decreased as you said in (a).
>>
>> Right. Alex did quite some performance/overhead evaluation when
>> introducing this feature. Changing the reporting granularity on most
>> setups (esp., x86-64) is not desired IMHO.
> 
> Yes, generally reporting pages comes at a fairly high cost so it is
> important to find the right trade-off between the size of the page and
> the size of the batch of pages being reported. If the size of the
> pages is reduced it maybe important to increase the batch size in
> order to avoid paying too much in the way of overhead.
> 
> The other main reason for holding to pageblock_order on x86 is to
> avoid THP splitting. Anything smaller than pageblock_order will
> trigger THP splitting which will significantly hurt the performance of
> the VM in general as it forces it down to order 0 pages.
> 

Alex, Thanks for your reply and sorry for taking your time to this
discussion.

Could you please confirm it's PAGE_REPORTING_CAPACITY or the budget
used in page_reporting_cycle() when you're talking about "batch"?

I don't understand how the THP splitting is triggered. As I understood,
the free page reporting works like this: the free pages are reported
back to QEMU through virtio-balloon, madvise(DONTNEED) is called on the
free pages. For THP related VMA, its memory is guranteed to be physically
2MB contiguous. The 2MB memory is free'd at once as I understand. I
don't think the 2MB memory can be free'd partially apart from the THP
splitting caused by some reasons. One of the reason is memory reclaim
and swapping. However, I think the THP splitting is caused by memory
reclaim is irrelevant to what you were saying.

Thanks,
Gavin

