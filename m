Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35053A8CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 01:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhFOXys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:54:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34727 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231681AbhFOXyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623801151;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mYpZ62mnOVCAysL58NZOznPfS67Uz89cb607A1bXdGs=;
        b=T8iVUdYINotK1YSeiSVczEp30Q+gJCTxODuOD1Lb7BLW0EKIjtRZmsbFQpshruSTqMo3FK
        U3kC3O12SmgyEa4gIo3D/fq7sqjKro4a8Ec8s9z+jRU03AGn7P7odOlCrluLDchM6USS5I
        v53mrc2uZFA6/ZsPPmle2bu0NwFASEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-05jhUJEAPeClir-fXcUGRw-1; Tue, 15 Jun 2021 19:52:27 -0400
X-MC-Unique: 05jhUJEAPeClir-fXcUGRw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C39C9803621;
        Tue, 15 Jun 2021 23:52:26 +0000 (UTC)
Received: from [10.64.54.84] (vpn2-54-84.bne.redhat.com [10.64.54.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 980861002EF0;
        Tue, 15 Jun 2021 23:52:20 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [RFC PATCH] mm/page_reporting: Adjust threshold according to
 MAX_ORDER
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shan.gavin@gmail.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
References: <20210601033319.100737-1-gshan@redhat.com>
 <76516781-6a70-f2b0-f3e3-da999c84350f@redhat.com>
 <0c0eb8c8-463d-d6f1-3cec-bbc0af0a229c@redhat.com>
 <b45b26ea-a6ac-934c-2467-c6e829b5d3ad@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <74b0d35f-707d-aa11-19e7-fedb74d77159@redhat.com>
Date:   Wed, 16 Jun 2021 11:53:22 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <b45b26ea-a6ac-934c-2467-c6e829b5d3ad@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/21 9:03 PM, David Hildenbrand wrote:
> On 11.06.21 09:44, Gavin Shan wrote:
>> On 6/1/21 6:01 PM, David Hildenbrand wrote:
>>> On 01.06.21 05:33, Gavin Shan wrote:
>>>> The PAGE_REPORTING_MIN_ORDER is equal to @pageblock_order, taken as
>>>> minimal order (threshold) to trigger page reporting. The page reporting
>>>> is never triggered with the following configurations and settings on
>>>> aarch64. In the particular scenario, the page reporting won't be triggered
>>>> until the largest (2 ^ (MAX_ORDER-1)) free area is achieved from the
>>>> page freeing. The condition is very hard, or even impossible to be met.
>>>>
>>>>     CONFIG_ARM64_PAGE_SHIFT:              16
>>>>     CONFIG_HUGETLB_PAGE:                  Y
>>>>     CONFIG_HUGETLB_PAGE_SIZE_VARIABLE:    N
>>>>     pageblock_order:                      13
>>>>     CONFIG_FORCE_MAX_ZONEORDER:           14
>>>>     MAX_ORDER:                            14
>>>>
>>>> The issue can be reproduced in VM, running kernel with above configurations
>>>> and settings. The 'memhog' is used inside the VM to access 512MB anonymous
>>>> area. The QEMU's RSS doesn't drop accordingly after 'memhog' exits.
>>>>
>>>>     /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64          \
>>>>     -accel kvm -machine virt,gic-version=host                        \
>>>>     -cpu host -smp 8,sockets=2,cores=4,threads=1 -m 4096M,maxmem=64G \
>>>>     -object memory-backend-ram,id=mem0,size=2048M                    \
>>>>     -object memory-backend-ram,id=mem1,size=2048M                    \
>>>>     -numa node,nodeid=0,cpus=0-3,memdev=mem0                         \
>>>>     -numa node,nodeid=1,cpus=4-7,memdev=mem1                         \
>>>>       :                                                              \
>>>>     -device virtio-balloon-pci,id=balloon0,free-page-reporting=yes
>>>>
>>>> This tries to fix the issue by adjusting the threshold to the smaller value
>>>> of @pageblock_order and (MAX_ORDER/2). With this applied, the QEMU's RSS
>>>> drops after 'memhog' exits.
>>>
>>> IIRC, we use pageblock_order to
>>>
>>> a) Reduce the free page reporting overhead. Reporting on small chunks can make us report constantly with little system activity.
>>>
>>> b) Avoid splitting THP in the hypervisor, avoiding downgraded VM performance.
>>>
>>> c) Avoid affecting creation of pageblock_order pages while hinting is active. I think there are cases where "temporary pulling sub-pageblock pages" can negatively affect creation of pageblock_order pages. Concurrent compaction would be one of these cases.
>>>
>>> The monstrosity called aarch64 64k is really special in that sense, because a) does not apply because pageblocks are just very big, b) does sometimes not apply because either our VM isn't backed by (rare) 512MB THP or uses 4k with 2MB THP and c) similarly doesn't apply in smallish VMs because we don't really happen to create 512MB THP either way.
>>>
>>>
>>> For example, going on x86-64 from reporting 2MB to something like 32KB is absolutely undesired.
>>>
>>> I think if we want to go down that path (and I am not 100% sure yet if we want to), we really want to treat only the special case in a special way. Note that even when doing it only for aarch64 with 64k, you will still end up splitting THP in a hypervisor if it uses 64k base pages (b)) and can affect creation of THP, for example, when compacting (c), so there is a negative side to that.
>>>
>>
>> [Remove Alexander from the cc list as his mail isn't reachable]
>>
> 
> [adding his gmail address which should be the right one]
> 
>> David, thanks for your time to review and sorry for the delay and late response.
>> I spent some time to get myself familiar with the code, but there are still some
>> questions to me, explained as below.
>>
>> Yes, @pageblock_order is currently taken as page reporting threshold. It will
>> incur more overhead if the threshold is decreased as you said in (a).
> 
> Right. Alex did quite some performance/overhead evaluation when introducing this feature. Changing the reporting granularity on most setups (esp., x86-64) is not desired IMHO.
> 

Thanks for adding Alex's correct mail address, David.

>>
>> This patch tries to decrease the free page reporting threshold. The @pageblock_order
>> isn't touched. I don't understand how the code changes affecting THP splitting
>> and the creation of page blocks mentioned in (b) and (c). David, could you please
>> provide more details?
> 
> Think of it like this: while reporting to the hypervisor, we temporarily turn free/"movable" pieces part of a pageblock "unmovable" -- see __isolate_free_page()->del_page_from_free_list(). While reporting them to the hypervisor, these pages are not available and not even marked as PageBuddy() anymore.
> 
> There are at least two scenarios where this could affect creation of free pageblocks I can see:
> 
> a. Compaction. While compacting, we might identify completely movable/free pageblocks, however, actual compaction on that pageblock can fail because some part is temporarily unmovable.
> 
> b. Free/alloc sequences. Assume a pageblocks is mostly free, except two pages (x and y). Assume the following sequence:
> 
> 1. free(x)
> 2. free(y)
> 3. alloc
> 
> Before your change, after 1. and 2. we'll have a free pageblock. 3 won't allocate from that pageblock.
> 
> With your change, free page reporting might run after 1. After 2, we'll not have a free pageblock (until free page reporting finished), and 3. might just reallocate what we freed in 2 and prevent having a free pageblock.
> 
> 
> No idea how relevant both points are in practice, however, the fundamental difference to current handling is that we would turn parts of pageblocks temporarily unmovable, instead of complete pageblocks.
> 

Thank you for the details. Without my changes and the page reporting threshold
is @pageblock_order, the whole page block can become 'movable' from 'unmovable'.
I don't think it's what we want, but I need Alex's confirm.

If we needn't change page block's migration type in page reporting, I guess I
need additional parameter for __isolate_free_page() so that the migration type
won't be changed by page reporting.

For (a), the 'movable' and 'unmovable' type is maintained with page block
granularity. So it seems the pages in one page block can't have different
migration types, or I missed something.

For (b), the scenario is possible to happen. It means the changed page
reporting threshold could affect the page allocator's behaviour, which could
introduce more fragmentations. However, it's really depending on how the
memory is allocated.

Thanks,
Gavin



