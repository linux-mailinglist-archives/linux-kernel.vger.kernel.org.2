Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAB43A94B1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhFPIFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:05:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231391AbhFPIFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623830624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XdeNFtC+7hDTJoC9u2Jb81KRLHiQC3idxPXLEXohuCQ=;
        b=Cse6XBhBQz3JFcjRRs7/6MLyaoH77M+InpjTp97DtnDdzMfGtPr/vc5NmX+mp8lpv13gZZ
        cRp4atzXCdGA+xBtsWFii8FILV+ta/GDNnldT/U47+HxVsosz4WvLuqxAIWD1UNlUdyTfa
        hZ7uxBv9YDtyaQ2ziekuqy796LCK8iY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-R4fh6al3PDuyQVI2IbzxFA-1; Wed, 16 Jun 2021 04:03:42 -0400
X-MC-Unique: R4fh6al3PDuyQVI2IbzxFA-1
Received: by mail-wr1-f72.google.com with SMTP id t10-20020a5d49ca0000b029011a61d5c96bso727194wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 01:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XdeNFtC+7hDTJoC9u2Jb81KRLHiQC3idxPXLEXohuCQ=;
        b=B3sJTIS/s0wMTBL5OxcSqYk+UA/jHWF39aXQ1vA07EMri9YvrC3TyEYVKuEqZF3Lkd
         Ly9hR9Ww9fyo9v67KMq+3Ec+EAg/IXLIj8+d1m2bD7qFnxtZbbokDAKGRXnxV0EV282f
         gcRqCjKjDiFq5WSJFV51cE+n5wFrnJf+tH3uocxTe4xslMIPFJRyLMnArbtIQ7p9evzY
         li4BouRDb4pkP+ix6n0VVnpK5C4fosHwLZwueqj6rfQvzJy4rqzuS5j5ToBontAitEVV
         Dm8XvqwjCgiwjDt05MXizR/ziLZ0CdlL7KaLeHLcQj7i2AeuGjg3ccPmod1MKBeldCRn
         y68g==
X-Gm-Message-State: AOAM5337zOumm338xM6L4wfbH2Zx7BHaXAEw1itTuN4NOYJ5XgcsmQ1P
        fQeFbdcOQThMSxitS2K4V2deZFT2J8LzGcS1LQmLseRF+lQ0SdBykFlnO7q6eeyLNgdktwwv08V
        4iK0n1C2UqnpOp7EFFC2iYIrb
X-Received: by 2002:a05:6000:511:: with SMTP id a17mr3731846wrf.351.1623830621747;
        Wed, 16 Jun 2021 01:03:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvySarOdgHVGd5FVf4mH+ZYqIBOMQDo1xalXRgQhDD315Lk0gtSQu/KTBisDpCY3lJyVsZXw==
X-Received: by 2002:a05:6000:511:: with SMTP id a17mr3731833wrf.351.1623830621551;
        Wed, 16 Jun 2021 01:03:41 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6524.dip0.t-ipconnect.de. [91.12.101.36])
        by smtp.gmail.com with ESMTPSA id 61sm1371336wrp.4.2021.06.16.01.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 01:03:41 -0700 (PDT)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <0cb302f1-7fb6-e47c-e138-b7a03f2b02e2@redhat.com>
Date:   Wed, 16 Jun 2021 10:03:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <63c06446-3b10-762c-3a29-464854b74e08@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.21 11:10, Gavin Shan wrote:
> On 6/15/21 12:26 PM, Alexander Duyck wrote:
>> On Mon, Jun 14, 2021 at 4:03 AM David Hildenbrand <david@redhat.com> wrote:
>>> On 11.06.21 09:44, Gavin Shan wrote:
>>>> On 6/1/21 6:01 PM, David Hildenbrand wrote:
>>>>> On 01.06.21 05:33, Gavin Shan wrote:
>>>>>> The PAGE_REPORTING_MIN_ORDER is equal to @pageblock_order, taken as
>>>>>> minimal order (threshold) to trigger page reporting. The page reporting
>>>>>> is never triggered with the following configurations and settings on
>>>>>> aarch64. In the particular scenario, the page reporting won't be triggered
>>>>>> until the largest (2 ^ (MAX_ORDER-1)) free area is achieved from the
>>>>>> page freeing. The condition is very hard, or even impossible to be met.
>>>>>>
>>>>>>       CONFIG_ARM64_PAGE_SHIFT:              16
>>>>>>       CONFIG_HUGETLB_PAGE:                  Y
>>>>>>       CONFIG_HUGETLB_PAGE_SIZE_VARIABLE:    N
>>>>>>       pageblock_order:                      13
>>>>>>       CONFIG_FORCE_MAX_ZONEORDER:           14
>>>>>>       MAX_ORDER:                            14
>>>>>>
>>>>>> The issue can be reproduced in VM, running kernel with above configurations
>>>>>> and settings. The 'memhog' is used inside the VM to access 512MB anonymous
>>>>>> area. The QEMU's RSS doesn't drop accordingly after 'memhog' exits.
>>>>>>
>>>>>>       /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64          \
>>>>>>       -accel kvm -machine virt,gic-version=host                        \
>>>>>>       -cpu host -smp 8,sockets=2,cores=4,threads=1 -m 4096M,maxmem=64G \
>>>>>>       -object memory-backend-ram,id=mem0,size=2048M                    \
>>>>>>       -object memory-backend-ram,id=mem1,size=2048M                    \
>>>>>>       -numa node,nodeid=0,cpus=0-3,memdev=mem0                         \
>>>>>>       -numa node,nodeid=1,cpus=4-7,memdev=mem1                         \
>>>>>>         :                                                              \
>>>>>>       -device virtio-balloon-pci,id=balloon0,free-page-reporting=yes
>>>>>>
>>>>>> This tries to fix the issue by adjusting the threshold to the smaller value
>>>>>> of @pageblock_order and (MAX_ORDER/2). With this applied, the QEMU's RSS
>>>>>> drops after 'memhog' exits.
>>>>>
>>>>> IIRC, we use pageblock_order to
>>>>>
>>>>> a) Reduce the free page reporting overhead. Reporting on small chunks can make us report constantly with little system activity.
>>>>>
>>>>> b) Avoid splitting THP in the hypervisor, avoiding downgraded VM performance.
>>>>>
>>>>> c) Avoid affecting creation of pageblock_order pages while hinting is active. I think there are cases where "temporary pulling sub-pageblock pages" can negatively affect creation of pageblock_order pages. Concurrent compaction would be one of these cases.
>>>>>
>>>>> The monstrosity called aarch64 64k is really special in that sense, because a) does not apply because pageblocks are just very big, b) does sometimes not apply because either our VM isn't backed by (rare) 512MB THP or uses 4k with 2MB THP and c) similarly doesn't apply in smallish VMs because we don't really happen to create 512MB THP either way.
>>>>>
>>>>>
>>>>> For example, going on x86-64 from reporting 2MB to something like 32KB is absolutely undesired.
>>>>>
>>>>> I think if we want to go down that path (and I am not 100% sure yet if we want to), we really want to treat only the special case in a special way. Note that even when doing it only for aarch64 with 64k, you will still end up splitting THP in a hypervisor if it uses 64k base pages (b)) and can affect creation of THP, for example, when compacting (c), so there is a negative side to that.
>>>>>
>>>>
>>>> [Remove Alexander from the cc list as his mail isn't reachable]
>>>>
>>>
>>> [adding his gmail address which should be the right one]
>>>
>>>> David, thanks for your time to review and sorry for the delay and late response.
>>>> I spent some time to get myself familiar with the code, but there are still some
>>>> questions to me, explained as below.
>>>>
>>>> Yes, @pageblock_order is currently taken as page reporting threshold. It will
>>>> incur more overhead if the threshold is decreased as you said in (a).
>>>
>>> Right. Alex did quite some performance/overhead evaluation when
>>> introducing this feature. Changing the reporting granularity on most
>>> setups (esp., x86-64) is not desired IMHO.
>>
>> Yes, generally reporting pages comes at a fairly high cost so it is
>> important to find the right trade-off between the size of the page and
>> the size of the batch of pages being reported. If the size of the
>> pages is reduced it maybe important to increase the batch size in
>> order to avoid paying too much in the way of overhead.
>>
>> The other main reason for holding to pageblock_order on x86 is to
>> avoid THP splitting. Anything smaller than pageblock_order will
>> trigger THP splitting which will significantly hurt the performance of
>> the VM in general as it forces it down to order 0 pages.
>>
> 
> Alex, Thanks for your reply and sorry for taking your time to this
> discussion.
> 
> Could you please confirm it's PAGE_REPORTING_CAPACITY or the budget
> used in page_reporting_cycle() when you're talking about "batch"?
> 
> I don't understand how the THP splitting is triggered. As I understood,
> the free page reporting works like this: the free pages are reported
> back to QEMU through virtio-balloon, madvise(DONTNEED) is called on the
> free pages. For THP related VMA, its memory is guranteed to be physically
> 2MB contiguous. The 2MB memory is free'd at once as I understand. I
> don't think the 2MB memory can be free'd partially apart from the THP
> splitting caused by some reasons. One of the reason is memory reclaim
> and swapping. However, I think the THP splitting is caused by memory
> reclaim is irrelevant to what you were saying.


Anonymous memory: Assume you have a 2 MB THP in the hypervisor. If you 
madvise(DONTNEED, 4K), you'll split the THP and free the single 4k page 
back to the buddy. That virtual memory region is no longer backed by a 
physically contiguous 2 MB page and there is no huge mapping in the page 
tables. Instead, there is now an "ordinary" 4k mapping with a hole. Bad 
for performance.

-- 
Thanks,

David / dhildenb

