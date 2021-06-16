Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8926C3A98EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFPLRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229546AbhFPLRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623842104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rClbIh55ij6DoY9uqd2ukH5YV4uYfoZFeaSd/jhn8U=;
        b=Qi8279as07OJS6TkQ5DDvfiQOoM3oDkERA+2YD4EKts5f32NfBrrCSoM0XvJywDdorLyZw
        mdr3jpW3ANYISd15WEdQWIxlWVGPXJ+fdrEywpCfLSFr+IlJzjTowA79bCKq01M/W/eBjR
        owd8wmllrTUtgyIPdGOzvSx9JNsJ/UQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-YaFIWfhAP1KXCZXQIReVsA-1; Wed, 16 Jun 2021 07:15:03 -0400
X-MC-Unique: YaFIWfhAP1KXCZXQIReVsA-1
Received: by mail-wr1-f69.google.com with SMTP id z4-20020adfe5440000b0290114f89c9931so947056wrm.17
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6rClbIh55ij6DoY9uqd2ukH5YV4uYfoZFeaSd/jhn8U=;
        b=k+27C+b3IRdPOaz4WBpRBrksqaKW1OC2DFCBM+jQQN38/6blOAtuNGww1XBHYpFdti
         MpdeF3LTN8zt4JiswNoz6nc4Ni7+uDPmswUB0EUYkHXR3OnFhLpXJC6hZfOO4+iFzlsJ
         ekN4P3iUvJrUw7R/SKeKLYpJ7OUwUjIVXLkgKlFBAnVaelRf0CRRgS80S/mvPs/tMVRV
         aiDCjHrShEnSo97IezwHnXRa8t6L6DO/n6XEH7qxmC0omYTjTW6k9wtHqETfcidJI8J1
         uK/N/T0bqQAhz5uJGI0hL28rWjUv1hIQ5AjyiCGm1Laojf/WhHvTLLmdBcwv56ZjDezT
         966g==
X-Gm-Message-State: AOAM5331rSTb6bdbfeA7UqUxC/lAgBAUcIRyyRLQa7MpBh9Z9v5XFScF
        kxnsRCh926Kke611ZhZSE/8TZC7j6pEi+zPt3E+AVP0DQiGEiFGQrf5znAhEMySXi9ehVIhJ1dr
        MLXrbM1ME6s6dWwNZSmLcBA+2
X-Received: by 2002:a1c:1d07:: with SMTP id d7mr8948376wmd.42.1623842102321;
        Wed, 16 Jun 2021 04:15:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXsoN6z1PnQxUGIJUgIPmldqDTc8tlMKirlgn+x38opQ+WZ7OkwTe9/3SnnarqsHdPu9xdMg==
X-Received: by 2002:a1c:1d07:: with SMTP id d7mr8948350wmd.42.1623842102032;
        Wed, 16 Jun 2021 04:15:02 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6524.dip0.t-ipconnect.de. [91.12.101.36])
        by smtp.gmail.com with ESMTPSA id f14sm4642219wmq.10.2021.06.16.04.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 04:15:01 -0700 (PDT)
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shan.gavin@gmail.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
References: <20210601033319.100737-1-gshan@redhat.com>
 <76516781-6a70-f2b0-f3e3-da999c84350f@redhat.com>
 <0c0eb8c8-463d-d6f1-3cec-bbc0af0a229c@redhat.com>
 <b45b26ea-a6ac-934c-2467-c6e829b5d3ad@redhat.com>
 <74b0d35f-707d-aa11-19e7-fedb74d77159@redhat.com>
 <6ebc99f9-649d-fbd2-aadf-87291e41b36d@redhat.com>
 <bd49c9d2-fb0b-5387-45f4-dbaa7a9eac2c@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH] mm/page_reporting: Adjust threshold according to
 MAX_ORDER
Message-ID: <be4b74ef-ac53-8c36-3097-6acead368cab@redhat.com>
Date:   Wed, 16 Jun 2021 13:15:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <bd49c9d2-fb0b-5387-45f4-dbaa7a9eac2c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.21 14:59, Gavin Shan wrote:
> On 6/16/21 5:59 PM, David Hildenbrand wrote:
>> On 16.06.21 03:53, Gavin Shan wrote:
>>> On 6/14/21 9:03 PM, David Hildenbrand wrote:
>>>> On 11.06.21 09:44, Gavin Shan wrote:
>>>>> On 6/1/21 6:01 PM, David Hildenbrand wrote:
>>>>>> On 01.06.21 05:33, Gavin Shan wrote:
>>>>>>> The PAGE_REPORTING_MIN_ORDER is equal to @pageblock_order, taken as
>>>>>>> minimal order (threshold) to trigger page reporting. The page reporting
>>>>>>> is never triggered with the following configurations and settings on
>>>>>>> aarch64. In the particular scenario, the page reporting won't be triggered
>>>>>>> until the largest (2 ^ (MAX_ORDER-1)) free area is achieved from the
>>>>>>> page freeing. The condition is very hard, or even impossible to be met.
>>>>>>>
>>>>>>>       CONFIG_ARM64_PAGE_SHIFT:              16
>>>>>>>       CONFIG_HUGETLB_PAGE:                  Y
>>>>>>>       CONFIG_HUGETLB_PAGE_SIZE_VARIABLE:    N
>>>>>>>       pageblock_order:                      13
>>>>>>>       CONFIG_FORCE_MAX_ZONEORDER:           14
>>>>>>>       MAX_ORDER:                            14
>>>>>>>
>>>>>>> The issue can be reproduced in VM, running kernel with above configurations
>>>>>>> and settings. The 'memhog' is used inside the VM to access 512MB anonymous
>>>>>>> area. The QEMU's RSS doesn't drop accordingly after 'memhog' exits.
>>>>>>>
>>>>>>>       /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64          \
>>>>>>>       -accel kvm -machine virt,gic-version=host                        \
>>>>>>>       -cpu host -smp 8,sockets=2,cores=4,threads=1 -m 4096M,maxmem=64G \
>>>>>>>       -object memory-backend-ram,id=mem0,size=2048M                    \
>>>>>>>       -object memory-backend-ram,id=mem1,size=2048M                    \
>>>>>>>       -numa node,nodeid=0,cpus=0-3,memdev=mem0                         \
>>>>>>>       -numa node,nodeid=1,cpus=4-7,memdev=mem1                         \
>>>>>>>         :                                                              \
>>>>>>>       -device virtio-balloon-pci,id=balloon0,free-page-reporting=yes
>>>>>>>
>>>>>>> This tries to fix the issue by adjusting the threshold to the smaller value
>>>>>>> of @pageblock_order and (MAX_ORDER/2). With this applied, the QEMU's RSS
>>>>>>> drops after 'memhog' exits.
>>>>>>
>>>>>> IIRC, we use pageblock_order to
>>>>>>
>>>>>> a) Reduce the free page reporting overhead. Reporting on small chunks can make us report constantly with little system activity.
>>>>>>
>>>>>> b) Avoid splitting THP in the hypervisor, avoiding downgraded VM performance.
>>>>>>
>>>>>> c) Avoid affecting creation of pageblock_order pages while hinting is active. I think there are cases where "temporary pulling sub-pageblock pages" can negatively affect creation of pageblock_order pages. Concurrent compaction would be one of these cases.
>>>>>>
>>>>>> The monstrosity called aarch64 64k is really special in that sense, because a) does not apply because pageblocks are just very big, b) does sometimes not apply because either our VM isn't backed by (rare) 512MB THP or uses 4k with 2MB THP and c) similarly doesn't apply in smallish VMs because we don't really happen to create 512MB THP either way.
>>>>>>
>>>>>>
>>>>>> For example, going on x86-64 from reporting 2MB to something like 32KB is absolutely undesired.
>>>>>>
>>>>>> I think if we want to go down that path (and I am not 100% sure yet if we want to), we really want to treat only the special case in a special way. Note that even when doing it only for aarch64 with 64k, you will still end up splitting THP in a hypervisor if it uses 64k base pages (b)) and can affect creation of THP, for example, when compacting (c), so there is a negative side to that.
>>>>>>
>>>>>
>>>>> [Remove Alexander from the cc list as his mail isn't reachable]
>>>>>
>>>>
>>>> [adding his gmail address which should be the right one]
>>>>
>>>>> David, thanks for your time to review and sorry for the delay and late response.
>>>>> I spent some time to get myself familiar with the code, but there are still some
>>>>> questions to me, explained as below.
>>>>>
>>>>> Yes, @pageblock_order is currently taken as page reporting threshold. It will
>>>>> incur more overhead if the threshold is decreased as you said in (a).
>>>>
>>>> Right. Alex did quite some performance/overhead evaluation when introducing this feature. Changing the reporting granularity on most setups (esp., x86-64) is not desired IMHO.
>>>>
>>>
>>> Thanks for adding Alex's correct mail address, David.
>>>
>>>>>
>>>>> This patch tries to decrease the free page reporting threshold. The @pageblock_order
>>>>> isn't touched. I don't understand how the code changes affecting THP splitting
>>>>> and the creation of page blocks mentioned in (b) and (c). David, could you please
>>>>> provide more details?
>>>>
>>>> Think of it like this: while reporting to the hypervisor, we temporarily turn free/"movable" pieces part of a pageblock "unmovable" -- see __isolate_free_page()->del_page_from_free_list(). While reporting them to the hypervisor, these pages are not available and not even marked as PageBuddy() anymore.
>>>>
>>>> There are at least two scenarios where this could affect creation of free pageblocks I can see:
>>>>
>>>> a. Compaction. While compacting, we might identify completely movable/free pageblocks, however, actual compaction on that pageblock can fail because some part is temporarily unmovable.
>>>>
>>>> b. Free/alloc sequences. Assume a pageblocks is mostly free, except two pages (x and y). Assume the following sequence:
>>>>
>>>> 1. free(x)
>>>> 2. free(y)
>>>> 3. alloc
>>>>
>>>> Before your change, after 1. and 2. we'll have a free pageblock. 3 won't allocate from that pageblock.
>>>>
>>>> With your change, free page reporting might run after 1. After 2, we'll not have a free pageblock (until free page reporting finished), and 3. might just reallocate what we freed in 2 and prevent having a free pageblock.
>>>>
>>>>
>>>> No idea how relevant both points are in practice, however, the fundamental difference to current handling is that we would turn parts of pageblocks temporarily unmovable, instead of complete pageblocks.
>>>>
>>>
>>> Thank you for the details. Without my changes and the page reporting threshold
>>> is @pageblock_order, the whole page block can become 'movable' from 'unmovable'.
>>> I don't think it's what we want, but I need Alex's confirm.
>>
>> __isolate_free_page() will set the pageblock MIGRATE_MOVABLE in that case. It's only temporarily unmovable, while we're hinting.
>>
>> Note that MOVABLE vs. UNMOVABLE is just grouping for free pages, and even setting it to the wrong migratetype isn't "wrong" as in "correctness". It doesn't make a difference if there are no free pages because the whole block is isolated.
>>
> 
> Yes, It doesn't matter since these pages have been isolated. The migration type is changed to MIGRATE_MOVABLE
> in __isolated_free_page(). My questions are actually:
> 
> (1) Is it possible the migration type is changed from MIGRATE_UNMOVABLE to MIGRATE_MOVABLE
>       in __isolated_free_page()?

Yes, if the isolated page covers at least half the pageblock. So either 
if we isolate the complete pageblock (as it's free, there is nothing 
unmovable) or half the pageblock. The latter seems to be some heuristic 
that says if it's half-free, make it MIGRATE_MOVABLE -- maybe because 
that increases the chances that we might get a completely movable 
pageblock later (would have too look into the details).

> (2) After the free page reporting is completed, the migrate type is restored to MIGRATE_UNMOVABLE?

No, don't think so. And it also doesn't make too much sense if we 
decided when isolating that we're better off using MIGRATE_MOVABLE. 
After all, we're just putting back a free page we previously isolated 
from the free lists.

-- 
Thanks,

David / dhildenb

