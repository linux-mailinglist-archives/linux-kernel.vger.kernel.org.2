Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77E2367DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbhDVJaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:30:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230285AbhDVJaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619083787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0PIZShYvKtST+t3n52TdrMJm7SNB4Egh+W9Ps7RZpaU=;
        b=hprl1kpY9zmHAxrRhjQOYQlRQV2PLBxly7pbr67HmPe6kll6rce0EnDOnRnzOuC2RW/+e/
        qPuk0AcvppkeNwB3xLzIrtY73i5vMazpYijOOi19jS8Hy2+IPUNNyc+XC1d/aeHTfGQEZZ
        uCcwirZTbOb8b548DBzHxjTy66GvDQY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-f0OZZVo7MEeoqsVVF6RweA-1; Thu, 22 Apr 2021 05:29:45 -0400
X-MC-Unique: f0OZZVo7MEeoqsVVF6RweA-1
Received: by mail-wm1-f69.google.com with SMTP id x20-20020a7bc2140000b029012bb4d2b5d6so6401520wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 02:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0PIZShYvKtST+t3n52TdrMJm7SNB4Egh+W9Ps7RZpaU=;
        b=FXUEhkMLsG4vt45whR1xIrJHBgWOCpFCO7IkEzbzs1GTRovmwt0trGlTkZnk09rg1/
         y6zIlLUuMKhqbLsBQkXC72L96ezeW04LpsT2qSp0jzHc+Cg+tlWOBYeZrRTN9/0pAZh3
         y/51sbKdBcPPwiiLpBlV79I9oFcT72eVuN0tSf8/CCTpVF82tzpLf9tY0I4/GxgZEs9c
         05oC0BQs89hrdy5lr51Uq20ikRgUeDbRavlG3ox9im5I+nq8PNgrQ6A+cqs/O2Snwn+G
         xB1ZuM1BFdIsBBnMjBPRkeXiweAmnfKNYkXOqAs76aO4MG19jDYVYHL4VneflyO6EpNt
         f6yw==
X-Gm-Message-State: AOAM5331qNYu4VNo1AvfZ3EC4b3aASKV9yCkjUBsEHGrboi+X/LqNiwi
        iJ6SpftI38b67I5kxSycob76E9auto1B1yTVP0rHqIRBswsqiX5Co1SHihgiI+q7j3nyaytaZhd
        MLYLMr7Pozd53+Luiqee3zI6Y
X-Received: by 2002:adf:db4d:: with SMTP id f13mr2895409wrj.203.1619083784466;
        Thu, 22 Apr 2021 02:29:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMIYAi4zF8uklRRuwtVpR5GrIUVC3QeT3/EA97BIzR0U3FMxPnuGUMv97lzDYt2bTPcpMmGw==
X-Received: by 2002:adf:db4d:: with SMTP id f13mr2895377wrj.203.1619083784194;
        Thu, 22 Apr 2021 02:29:44 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23eb0.dip0.t-ipconnect.de. [79.242.62.176])
        by smtp.gmail.com with ESMTPSA id f1sm2567569wru.60.2021.04.22.02.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 02:29:43 -0700 (PDT)
To:     Vlastimil Babka <vbabka@suse.cz>, lipeifeng@oppo.com,
        peifengl55@gmail.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210414023803.937-1-lipeifeng@oppo.com>
 <a7bb16c0-31b2-6aa5-2186-8c957955649e@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] mm: support multi_freearea to the reduction of external
 fragmentation
Message-ID: <c289b9dc-1259-c829-8ee4-1bee94d7d73d@redhat.com>
Date:   Thu, 22 Apr 2021 11:29:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <a7bb16c0-31b2-6aa5-2186-8c957955649e@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.21 13:06, Vlastimil Babka wrote:
> On 4/14/21 4:38 AM, lipeifeng@oppo.com wrote:
>> From: lipeifeng <lipeifeng@oppo.com>
>>
>> This patch would "sort" the free-pages in buddy by pages-PFN to concentrate
>> low-order-pages allocation in the front area of memory and high-order-pages
>> allcation on the contrary so that few memory-pollution in the back area of
>> memory and the probablity of high-order-pages allocation would be increased
>> significantly.
>> -----------------------------------------------------------------------
>>
>>    1) Divide memory into several segments by pages-PFN
>>       "Multi_freearea" would divide memory into FREE_AREA_COUNTS segments
>>       by pages-PFN,each memory-segment corresponds to a free_area.
>>
>>       Example: machine(4G of physical memery) and FREE_AREA_COUNTS(4):
>>          page-PFN:0x0     0x40000(1G)   0x80000(2G)  0xc0000(3G) 0xFFFFF(4G)
>>                   |------------|--------------|--------------|-------------|
>>          free_area:  [0][]           [1][]           [2][]        [3][]
>>
>>       NOTE: Selecting the corresponding freearea when pages are freed back
>> 	       to buddy:
>>          - pages-PFN[0, free_area_segment[0].max_pfn] -> free_area[0][]
>>          - pages-PFN[free_area_segment[flc - 1].max_pfn,
>> 	            free_area_segment[flc].max_pfn] -> free_area[flc][]
>>                     (flc > 0)
>>
>>       By this way, all pages in the same segment/free_area is within a
>>       certain range of pages-PFN.
>>
>>    2) Select the corresponding freearea to alloc-pages
>>       "Multi_freearea" would select the corresponding free_area by the
>>       allocation-order when alloc-pages.
>>          - order <  HIGH_ORDER_TO_FLC:
>> 	        free_area[0] -> ... -> free_area[FREE_AREA_COUNTS - 1]
>>          - order >= HIGH_ORDER_TO_FLC:
>> 	        free_area[FREE_AREA_COUNTS - 1] -> ... -> free_area[0]
>>
>>       Example:
>>          The machine(4G of physical memery) and FREE_AREA_COUNTS(4)
>>          and HIGH_ORDER_TO_FLC(3).
>> 	If user allocs page(order = 0),it would take page from
>> 	free_area[0][] first, if that fails,try free_area[1][] and so on.
>> 	If user allocs page(order = 4),it would take page from
>> 	free_area[3][] first, if that fails,try free_area[2][] and so on.
>>
>>       By this way,low-order pages will be concentrated in the front area
>>       of memory.Because of few memory-pollution in the back area of memory,
>>       the sussessful probablity of high-order allocation would be improved.
>>
>>    3) Adjust the location of free-pages in the free_list
>>       "Multi_freearea" would place free-pages in the head of free_list if
>>       pages-PFN is smaller than free_area_segment[flc]->median_pfn and in
>>       the tail of free_list on the contrary.
>>
>>       Example:
>>          page-PFN:        free_area_segment[flc]->median_pfn
>>                                          |
>>          free_list: page->page->page->...|...page->page->page
>>          pages-PFN:|   < median_pfn      |  >= median_pfn    |
>>
>>       Because it would take pages from the head of the freelist first in
>>       buddy system,the free-pages in the tail are more likely to keep in the
>>       buddy system.The closer the PFN of pages kept in buddy system, the
>>       greater the probablity of merging that into high-order pages.
> 
> I think this part 3) would be worth to be tried separately first, as it's not a
> big change compared to the other ones.
> 

Let's consider part 3 only and ignore the 1) multi freearea (which might 
be problematic with sparcity) and 2) the modified allocation scheme 
(which doesn't yet quite sense to me yet, e.g., because we group by 
mobility and have compaction in place; I assume this really only helps 
in some special cases -- like the test case you are giving; I might be 
wrong)

Right now, we decide whether to but to head or tail based on how likely 
it is that we might merge to a higher-order page (buddy_merge_likely()) 
in the future. So we only consider the current "neighborhood" of the 
page we're freeing. As we restrict our neighborhood to MAX_ORDER - 1 
pages (what we can actually merge). Of course, we can easily be wrong 
here. Grouping by movability and compaction only helps to some degree I 
guess.

AFAIK, what you propose is basing the decisions where to place a page 
(in addition?) on a median_pfn. Without 1) and 2) I cannot completely 
understand if 3) itself would help at all (and how to set the 
median_pfn). But it would certainly be interesting if we can tweak the 
current logic to better identify merge targets simply by tweaking 
buddy_merge_likely() or the assumptions it is making.

-- 
Thanks,

David / dhildenb

