Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901103A9493
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhFPIBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:01:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41266 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231195AbhFPIBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623830370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ydQaNNt01ob73exPiqxRV+4741Z1kAkyQHRaIWVUuy4=;
        b=WyIrihv8Q7YKEPyaO1jZTTsg0zo7PIId7Qh6qQVP8FcaFGNU4gA7VHJgmyPZJzy8ceTgUR
        r2LMIaKFbdDqtxXy+WVswyk/gcjZAGiCE3zwgsDnhi8qImxkEP5xEUFJxyfqRrrR4N/iSH
        efjxje5by2pZvYEVSK2m4IiWvE7A/OE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-SyXekYDOOtuCVoRaflu2oQ-1; Wed, 16 Jun 2021 03:59:29 -0400
X-MC-Unique: SyXekYDOOtuCVoRaflu2oQ-1
Received: by mail-wr1-f72.google.com with SMTP id q15-20020adfc50f0000b0290111f48b865cso730651wrf.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ydQaNNt01ob73exPiqxRV+4741Z1kAkyQHRaIWVUuy4=;
        b=UuanjKmHmZurJ00RE3iwaTN26ElJtnHD2AX8lc3n1brlTWiP28WNfoOs0//Z5cUehU
         qfFRCd736rTzhe7P03kSAcL6rw4pyjwbvu0xBSVqTJ4FEdl0zd0WbgTUCF4w/Pe8dSa2
         selBN9HNpwz/ittdd1surz3y9GhhEfjESK5ic7y8WVZdq2Enq2/6iw99B6Yf99mhX9Ph
         JYS7tzNdMSri+0ezzV/03H6jxJw7ShOGfcKpBkVSWvTemHW16IXCHUB4787ibcRiM+jb
         /vTwsSMrlX3xl7se1RH42m/6QjOKGI0H8sE9JjUMWuo6HToFYt9ue16Zn/eT/SjmEoza
         UZOQ==
X-Gm-Message-State: AOAM5325ggcSrLesKk+VXM9nX9NoBPH68yTtmwNqp+HbGdElGx7+CWlg
        TkmJ30rv1mITpKPQvAhaje3WLC6fQbI9kuh/+GFTeDsAaAYzVdj9sp0VUDA6LCY5A6py3rTMU6m
        VsJrX/CMfq+7LVzKpqASBILhH
X-Received: by 2002:a5d:4cd1:: with SMTP id c17mr3730002wrt.295.1623830367905;
        Wed, 16 Jun 2021 00:59:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyI+HmoKMAJWCUeDjNq1GKPkINAc/59yB1cZZb2CSDdwCyPD1ZeNIHMH4RgrhqWcABWv5jBMA==
X-Received: by 2002:a5d:4cd1:: with SMTP id c17mr3729984wrt.295.1623830367701;
        Wed, 16 Jun 2021 00:59:27 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6524.dip0.t-ipconnect.de. [91.12.101.36])
        by smtp.gmail.com with ESMTPSA id q20sm1564928wrf.45.2021.06.16.00.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 00:59:27 -0700 (PDT)
Subject: Re: [RFC PATCH] mm/page_reporting: Adjust threshold according to
 MAX_ORDER
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <6ebc99f9-649d-fbd2-aadf-87291e41b36d@redhat.com>
Date:   Wed, 16 Jun 2021 09:59:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <74b0d35f-707d-aa11-19e7-fedb74d77159@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.21 03:53, Gavin Shan wrote:
> On 6/14/21 9:03 PM, David Hildenbrand wrote:
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
>>>>>      CONFIG_ARM64_PAGE_SHIFT:              16
>>>>>      CONFIG_HUGETLB_PAGE:                  Y
>>>>>      CONFIG_HUGETLB_PAGE_SIZE_VARIABLE:    N
>>>>>      pageblock_order:                      13
>>>>>      CONFIG_FORCE_MAX_ZONEORDER:           14
>>>>>      MAX_ORDER:                            14
>>>>>
>>>>> The issue can be reproduced in VM, running kernel with above configurations
>>>>> and settings. The 'memhog' is used inside the VM to access 512MB anonymous
>>>>> area. The QEMU's RSS doesn't drop accordingly after 'memhog' exits.
>>>>>
>>>>>      /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64          \
>>>>>      -accel kvm -machine virt,gic-version=host                        \
>>>>>      -cpu host -smp 8,sockets=2,cores=4,threads=1 -m 4096M,maxmem=64G \
>>>>>      -object memory-backend-ram,id=mem0,size=2048M                    \
>>>>>      -object memory-backend-ram,id=mem1,size=2048M                    \
>>>>>      -numa node,nodeid=0,cpus=0-3,memdev=mem0                         \
>>>>>      -numa node,nodeid=1,cpus=4-7,memdev=mem1                         \
>>>>>        :                                                              \
>>>>>      -device virtio-balloon-pci,id=balloon0,free-page-reporting=yes
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
>> Right. Alex did quite some performance/overhead evaluation when introducing this feature. Changing the reporting granularity on most setups (esp., x86-64) is not desired IMHO.
>>
> 
> Thanks for adding Alex's correct mail address, David.
> 
>>>
>>> This patch tries to decrease the free page reporting threshold. The @pageblock_order
>>> isn't touched. I don't understand how the code changes affecting THP splitting
>>> and the creation of page blocks mentioned in (b) and (c). David, could you please
>>> provide more details?
>>
>> Think of it like this: while reporting to the hypervisor, we temporarily turn free/"movable" pieces part of a pageblock "unmovable" -- see __isolate_free_page()->del_page_from_free_list(). While reporting them to the hypervisor, these pages are not available and not even marked as PageBuddy() anymore.
>>
>> There are at least two scenarios where this could affect creation of free pageblocks I can see:
>>
>> a. Compaction. While compacting, we might identify completely movable/free pageblocks, however, actual compaction on that pageblock can fail because some part is temporarily unmovable.
>>
>> b. Free/alloc sequences. Assume a pageblocks is mostly free, except two pages (x and y). Assume the following sequence:
>>
>> 1. free(x)
>> 2. free(y)
>> 3. alloc
>>
>> Before your change, after 1. and 2. we'll have a free pageblock. 3 won't allocate from that pageblock.
>>
>> With your change, free page reporting might run after 1. After 2, we'll not have a free pageblock (until free page reporting finished), and 3. might just reallocate what we freed in 2 and prevent having a free pageblock.
>>
>>
>> No idea how relevant both points are in practice, however, the fundamental difference to current handling is that we would turn parts of pageblocks temporarily unmovable, instead of complete pageblocks.
>>
> 
> Thank you for the details. Without my changes and the page reporting threshold
> is @pageblock_order, the whole page block can become 'movable' from 'unmovable'.
> I don't think it's what we want, but I need Alex's confirm.

__isolate_free_page() will set the pageblock MIGRATE_MOVABLE in that 
case. It's only temporarily unmovable, while we're hinting.

Note that MOVABLE vs. UNMOVABLE is just grouping for free pages, and 
even setting it to the wrong migratetype isn't "wrong" as in 
"correctness". It doesn't make a difference if there are no free pages 
because the whole block is isolated.

-- 
Thanks,

David / dhildenb

