Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F763366738
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbhDUIp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45018 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237440AbhDUIp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618994693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bcu+wrxn0FqEovyk3sgh/f7CXEAiST4+EaHgahYx5jU=;
        b=G75aNtI/AT9JjLU0qrjoofMRDBtHOJEPEHfgPX57qkyiMzsP60Tj873lSqSBdRprIoBqvv
        GyiQ7wmhFHokVa0uyiqUbQjAYN/EVGspl4CGRFjCebbUizTFItVjAoAifQYwDerk2LGbns
        mKUbe2xYcQJD5lJ1YiA8ASUbFhhVlZA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-EZFgsCQfMoGCuLAJhQ6uPg-1; Wed, 21 Apr 2021 04:44:41 -0400
X-MC-Unique: EZFgsCQfMoGCuLAJhQ6uPg-1
Received: by mail-ed1-f69.google.com with SMTP id c13-20020a05640227cdb0290385526e5de5so4581264ede.21
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 01:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bcu+wrxn0FqEovyk3sgh/f7CXEAiST4+EaHgahYx5jU=;
        b=r/yN9Y5Cfi52qFCtljVP/yKL2jUh7uBFHrjK3mHit87+RlKWqvccZI0EbQviXsYxgz
         4yRMZf5X4HkA7D9Qb9SqmXVBqeY5kZ4nPqfWFNJDYVwonHIahsHwbkBN9d52sFVFOSX0
         ISQiYhVbdPUCQ0GiJ63ELEiBnm1MNcJKs85q5clRHg+TQz7PHWFo2Ubpt6xfJx7yg1PK
         DCxXerwNW8ENt6kCi4tgx90QtoMRnOZNKj3FL33m3IfhDWSxg0hkdGqgaOv9mBmbKvQQ
         BS/Vn+prNZvcfIouubg3rnwXXdbYYyy0Dt+OTDTkcVo/u2q5IEfNMJyFCXOw7uTqPY1q
         Xppw==
X-Gm-Message-State: AOAM531cFJGoOf8nUn5UHLG12n58nC4zU7huxSbV5cvrcrIDt7ZdeTdx
        wrEva/OLGoOVF8HBLpzuy4k+xvQwYXN/z7hI7sZIr2CNZSW0+YCpPP2BLpDMGSo3bAYP1Jr+2Cf
        8e/LUfsoC1KQ61jA9OJ+VHeKeqcVO9+SDRDakgHUgRAh3Yg6YACX3ONHL5W+H7q/kEWYmPtgV
X-Received: by 2002:a17:907:1b11:: with SMTP id mp17mr12776379ejc.1.1618994679864;
        Wed, 21 Apr 2021 01:44:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPUTjREzwxVVb+hC6ridnEY1W4T5jRx1GvQO/A5PCE3+cm8DMLZKdHPR6IcFvegByCc8rkBw==
X-Received: by 2002:a17:907:1b11:: with SMTP id mp17mr12776357ejc.1.1618994679589;
        Wed, 21 Apr 2021 01:44:39 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64b8.dip0.t-ipconnect.de. [91.12.100.184])
        by smtp.gmail.com with ESMTPSA id c19sm2271296edu.20.2021.04.21.01.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 01:44:39 -0700 (PDT)
Subject: Re: [PATCH v9 4/8] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210416112411.9826-1-osalvador@suse.de>
 <20210416112411.9826-5-osalvador@suse.de> <YH6zQ1Dty9kJFkuk@dhcp22.suse.cz>
 <20210421081546.GD22456@linux> <YH/ktDG/9o2OHNGj@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <c248d75d-fe50-7d3f-69bc-6df3241f39ac@redhat.com>
Date:   Wed, 21 Apr 2021 10:44:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YH/ktDG/9o2OHNGj@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.04.21 10:39, Michal Hocko wrote:
> On Wed 21-04-21 10:15:46, Oscar Salvador wrote:
>> On Tue, Apr 20, 2021 at 12:56:03PM +0200, Michal Hocko wrote:
> [...]
>>> necessary. Using two different iteration styles is also hurting the code
>>> readability. I would go with the following
>>> 	for (pfn = start_pfn; pfn < end_pfn; ) {
>>> 		unsigned long order = min(MAX_ORDER - 1UL, __ffs(pfn));
>>>
>>> 		while (start + (1UL << order) > end_pfn)
>>>                          order--;
>>> 		(*online_page_callback)(pfn_to_page(pfn), pageblock_order);
>>> 		pfn += 1 << order;
>>> 	}
>>>
>>> which is what __free_pages_memory does already.
>>
>> this is kinda what I used to have in the early versions, but it was agreed
>> with David to split it in two loops to make it explicit.
>> I can go back to that if it is preferred.
> 
> Not that I would insist but I find it better to use common constructs
> when it doesn't hurt readability. The order evaluation can be even done
> in a trivial helper.
> 
>>>> +	if (memmap_on_memory) {
>>>> +		nr_vmemmap_pages = walk_memory_blocks(start, size, NULL,
>>>> +						      get_nr_vmemmap_pages_cb);
>>>> +		if (nr_vmemmap_pages) {
>>>> +			if (size != memory_block_size_bytes()) {
>>>> +				pr_warn("Refuse to remove %#llx - %#llx,"
>>>> +					"wrong granularity\n",
>>>> +					start, start + size);
>>>> +				return -EINVAL;
>>>> +			}
>>>> +
>>>> +			/*
>>>> +			 * Let remove_pmd_table->free_hugepage_table do the
>>>> +			 * right thing if we used vmem_altmap when hot-adding
>>>> +			 * the range.
>>>> +			 */
>>>> +			mhp_altmap.alloc = nr_vmemmap_pages;
>>>> +			altmap = &mhp_altmap;
>>>> +		}
>>>> +	}
>>>> +
>>>>   	/* remove memmap entry */
>>>>   	firmware_map_remove(start, start + size, "System RAM");
>>>
>>> I have to say I still dislike this and I would just wrap it inside out
>>> and do the operation from within walk_memory_blocks but I will not
>>> insist.
>>
>> I have to confess I forgot about the details of that dicussion, as we were
>> quite focused on decoupling vmemmap pages from {online,offline} interface.
>> Would you mind elaborating a bit more?
> 
> As I've said I will not insist and this can be done in the follow up.
> You are iterating over memory blocks just to refuse to do an operation
> which can be split to several memory blocks. See
> http://lkml.kernel.org/r/YFtPxH0CT5QZsnR1@dhcp22.suse.cz and follow
> walk_memory_blocks(start, size, NULL, remove_memory_block_cb)
> 

We'll have to be careful in general when removing memory in different 
granularity than it was added, especially calling arch_remove_memory() 
in smaller granularity than it was added via arch_add_memory(). We might 
fail to tear down the direct map, imagine having mapped a 1GiB page but 
decide to remove individual 128 MiB chunks -- that won't work and the 
direct map would currently remain.

So this should be handled separately in the future.

-- 
Thanks,

David / dhildenb

