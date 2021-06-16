Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E938B3A9925
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFPL1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229502AbhFPL1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623842713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANd/xLMM9lCz5M4YffhnPjBbHqFfAxIoeWO+GHOf7i8=;
        b=dPGmSwEwQmCgjmTz/LL0Knecq6N6s3MMO+XSeVfiekGJoI9jWq0dHumgfdJY/9S+WjZaYL
        xtUYgSs/veD2464BwfX3QnCACOorGS3KH2E3wIiKpOwA51LTbXSWlMx0XnqwcTW8wMkUl/
        djH5DCNW14FGupor5Hfj12lWEpRQ6GQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-MD1J5AppM2mGIldzdd1C8w-1; Wed, 16 Jun 2021 07:25:12 -0400
X-MC-Unique: MD1J5AppM2mGIldzdd1C8w-1
Received: by mail-wr1-f70.google.com with SMTP id d9-20020adffbc90000b029011a3b249b10so978913wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ANd/xLMM9lCz5M4YffhnPjBbHqFfAxIoeWO+GHOf7i8=;
        b=e0wnQQnRIpliqdJ7JilTR9WWIfhc4V3P0sjkMXZBI2J/y/6EStbUezJbXgqO1SZmQq
         W5iiNG73+pomeZBj4RQk0YFAOALZmv25nOUo0fSRNwUPL+f0DRVj/zmnd4F2zVEAQ2WQ
         0d0vpEwyCy5n098xvZoF6+DcT4bLbp2zdKB7qa2J9N5JcwHRFzqH7QAqX+R1HR6Kq+0x
         DE/1RBOz93gmynrX/1a5dLxaxxzXENTbAs/z0uwnpD2bf4HCxni9gBRUBKkSWjQkHQT9
         vzIIpA/ADndVryOLcwwV3kcBSQb00HA5o2PDGproEvb3OqnIeSNSS8I3jmM+uqr7aKlE
         sDlw==
X-Gm-Message-State: AOAM533D6/drW3f90sc2gw8Hxh+DhtK8mJ/XXfGJy8V4fjFqnFlFVmBL
        9+C3PTscW9NFsiZW9clEjpUw1NKhMcsieED3ZOg4nfsKx/G/Bcn3tNFXcKE7g9y/k3KP2wvvAf3
        tzaNS/lcbh+B6u5st9F9IxnCU
X-Received: by 2002:a7b:c772:: with SMTP id x18mr4668148wmk.3.1623842711490;
        Wed, 16 Jun 2021 04:25:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/9CpSUl6vrzN0eL2RETMc5CZTFPwp9+JNtN5aPS9mKIm0U6fbLONuU78ZN0Er5/lVITE0uw==
X-Received: by 2002:a1c:4b0d:: with SMTP id y13mr4577858wma.179.1623842406275;
        Wed, 16 Jun 2021 04:20:06 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6524.dip0.t-ipconnect.de. [91.12.101.36])
        by smtp.gmail.com with ESMTPSA id y26sm1590216wma.33.2021.06.16.04.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 04:20:06 -0700 (PDT)
Subject: Re: [RFC PATCH] mm/page_reporting: Adjust threshold according to
 MAX_ORDER
To:     Gavin Shan <gshan@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        shan.gavin@gmail.com, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210601033319.100737-1-gshan@redhat.com>
 <76516781-6a70-f2b0-f3e3-da999c84350f@redhat.com>
 <0c0eb8c8-463d-d6f1-3cec-bbc0af0a229c@redhat.com>
 <b45b26ea-a6ac-934c-2467-c6e829b5d3ad@redhat.com>
 <CAKgT0Ue9SQ8=ju1m6ftKTb4Tai9EJ5NQhnB_uk-DzMc19-R4cQ@mail.gmail.com>
 <63c06446-3b10-762c-3a29-464854b74e08@redhat.com>
 <0cb302f1-7fb6-e47c-e138-b7a03f2b02e2@redhat.com>
 <33b441b2-f10d-a7fb-8163-df2afbf6527d@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <9e553b30-ce18-df65-bd3c-c68eaa4d0d91@redhat.com>
Date:   Wed, 16 Jun 2021 13:20:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <33b441b2-f10d-a7fb-8163-df2afbf6527d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.21 15:16, Gavin Shan wrote:
> On 6/16/21 6:03 PM, David Hildenbrand wrote:
>> On 16.06.21 11:10, Gavin Shan wrote:
>>> On 6/15/21 12:26 PM, Alexander Duyck wrote:
>>>> On Mon, Jun 14, 2021 at 4:03 AM David Hildenbrand <david@redhat.com> wrote:
>>>>> On 11.06.21 09:44, Gavin Shan wrote:
>>>>>> On 6/1/21 6:01 PM, David Hildenbrand wrote:
>>>>>>> On 01.06.21 05:33, Gavin Shan wrote:
>>>>>>>> The PAGE_REPORTING_MIN_ORDER is equal to @pageblock_order, taken as
>>>>>>>> minimal order (threshold) to trigger page reporting. The page reporting
>>>>>>>> is never triggered with the following configurations and settings on
>>>>>>>> aarch64. In the particular scenario, the page reporting won't be triggered
>>>>>>>> until the largest (2 ^ (MAX_ORDER-1)) free area is achieved from the
>>>>>>>> page freeing. The condition is very hard, or even impossible to be met.
>>>>>>>>
>>>>>>>>        CONFIG_ARM64_PAGE_SHIFT:              16
>>>>>>>>        CONFIG_HUGETLB_PAGE:                  Y
>>>>>>>>        CONFIG_HUGETLB_PAGE_SIZE_VARIABLE:    N
>>>>>>>>        pageblock_order:                      13
>>>>>>>>        CONFIG_FORCE_MAX_ZONEORDER:           14
>>>>>>>>        MAX_ORDER:                            14
>>>>>>>>
>>>>>>>> The issue can be reproduced in VM, running kernel with above configurations
>>>>>>>> and settings. The 'memhog' is used inside the VM to access 512MB anonymous
>>>>>>>> area. The QEMU's RSS doesn't drop accordingly after 'memhog' exits.
>>>>>>>>
>>>>>>>>        /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64          \
>>>>>>>>        -accel kvm -machine virt,gic-version=host                        \
>>>>>>>>        -cpu host -smp 8,sockets=2,cores=4,threads=1 -m 4096M,maxmem=64G \
>>>>>>>>        -object memory-backend-ram,id=mem0,size=2048M                    \
>>>>>>>>        -object memory-backend-ram,id=mem1,size=2048M                    \
>>>>>>>>        -numa node,nodeid=0,cpus=0-3,memdev=mem0                         \
>>>>>>>>        -numa node,nodeid=1,cpus=4-7,memdev=mem1                         \
>>>>>>>>          :                                                              \
>>>>>>>>        -device virtio-balloon-pci,id=balloon0,free-page-reporting=yes
>>>>>>>>
>>>>>>>> This tries to fix the issue by adjusting the threshold to the smaller value
>>>>>>>> of @pageblock_order and (MAX_ORDER/2). With this applied, the QEMU's RSS
>>>>>>>> drops after 'memhog' exits.
>>>>>>>
>>>>>>> IIRC, we use pageblock_order to
>>>>>>>
>>>>>>> a) Reduce the free page reporting overhead. Reporting on small chunks can make us report constantly with little system activity.
>>>>>>>
>>>>>>> b) Avoid splitting THP in the hypervisor, avoiding downgraded VM performance.
>>>>>>>
>>>>>>> c) Avoid affecting creation of pageblock_order pages while hinting is active. I think there are cases where "temporary pulling sub-pageblock pages" can negatively affect creation of pageblock_order pages. Concurrent compaction would be one of these cases.
>>>>>>>
>>>>>>> The monstrosity called aarch64 64k is really special in that sense, because a) does not apply because pageblocks are just very big, b) does sometimes not apply because either our VM isn't backed by (rare) 512MB THP or uses 4k with 2MB THP and c) similarly doesn't apply in smallish VMs because we don't really happen to create 512MB THP either way.
>>>>>>>
>>>>>>>
>>>>>>> For example, going on x86-64 from reporting 2MB to something like 32KB is absolutely undesired.
>>>>>>>
>>>>>>> I think if we want to go down that path (and I am not 100% sure yet if we want to), we really want to treat only the special case in a special way. Note that even when doing it only for aarch64 with 64k, you will still end up splitting THP in a hypervisor if it uses 64k base pages (b)) and can affect creation of THP, for example, when compacting (c), so there is a negative side to that.
>>>>>>>
>>>>>>
>>>>>> [Remove Alexander from the cc list as his mail isn't reachable]
>>>>>>
>>>>>
>>>>> [adding his gmail address which should be the right one]
>>>>>
>>>>>> David, thanks for your time to review and sorry for the delay and late response.
>>>>>> I spent some time to get myself familiar with the code, but there are still some
>>>>>> questions to me, explained as below.
>>>>>>
>>>>>> Yes, @pageblock_order is currently taken as page reporting threshold. It will
>>>>>> incur more overhead if the threshold is decreased as you said in (a).
>>>>>
>>>>> Right. Alex did quite some performance/overhead evaluation when
>>>>> introducing this feature. Changing the reporting granularity on most
>>>>> setups (esp., x86-64) is not desired IMHO.
>>>>
>>>> Yes, generally reporting pages comes at a fairly high cost so it is
>>>> important to find the right trade-off between the size of the page and
>>>> the size of the batch of pages being reported. If the size of the
>>>> pages is reduced it maybe important to increase the batch size in
>>>> order to avoid paying too much in the way of overhead.
>>>>
>>>> The other main reason for holding to pageblock_order on x86 is to
>>>> avoid THP splitting. Anything smaller than pageblock_order will
>>>> trigger THP splitting which will significantly hurt the performance of
>>>> the VM in general as it forces it down to order 0 pages.
>>>>
>>>
>>> Alex, Thanks for your reply and sorry for taking your time to this
>>> discussion.
>>>
>>> Could you please confirm it's PAGE_REPORTING_CAPACITY or the budget
>>> used in page_reporting_cycle() when you're talking about "batch"?
>>>
>>> I don't understand how the THP splitting is triggered. As I understood,
>>> the free page reporting works like this: the free pages are reported
>>> back to QEMU through virtio-balloon, madvise(DONTNEED) is called on the
>>> free pages. For THP related VMA, its memory is guranteed to be physically
>>> 2MB contiguous. The 2MB memory is free'd at once as I understand. I
>>> don't think the 2MB memory can be free'd partially apart from the THP
>>> splitting caused by some reasons. One of the reason is memory reclaim
>>> and swapping. However, I think the THP splitting is caused by memory
>>> reclaim is irrelevant to what you were saying.
>>
>>
>> Anonymous memory: Assume you have a 2 MB THP in the hypervisor. If you madvise(DONTNEED, 4K), you'll split the THP and free the single 4k page back to the buddy. That virtual memory region is no longer backed by a physically contiguous 2 MB page and there is no huge mapping in the page tables. Instead, there is now an "ordinary" 4k mapping with a hole. Bad for performance.
>>
> 
> Ok, now I see and thanks for your explanation. In this regard, we need gurantee
> the page reporting threshold is larger or equal to THP size. The THP size is 2MB
> or 512MB if base page size is 4KB or 64KB.
> 
> It makes the issue hard to be fixed as we have 512MB THP size with 64KB base page
> size on arm64. The following configurations are used in this case.
> 
>      CONFIG_FORCE_MAX_ZONEORDER          14
>      MAX_ORDER                           14
>      pageblock_order                     13
> 
> The free page reporting won't be started until the page freeing comes up with 512MB
> free area. On system, which has limited memory (e.g. 4GB), 512MB free area is hard
> to have due to memory fragmentation.
> 

FWIW, in an ideal world the hypervisor would tell us (guest) which 
granularity it prefers. Could be that the hypervisor is using a 
different page size / thp size ... but that's a different story :)

 From a guest POV, it usually makes sense to report only whole 
pageblocks. But as identified, this is an issue with abnormally large 
pageblocks.

512MB pageblocks / THP is simply far from ideal for VMs, kindly phrased. :)

-- 
Thanks,

David / dhildenb

