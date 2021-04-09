Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81B8359805
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhDIIhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:37:24 -0400
Received: from foss.arm.com ([217.140.110.172]:44578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229673AbhDIIhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:37:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3B821FB;
        Fri,  9 Apr 2021 01:37:10 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BE023F694;
        Fri,  9 Apr 2021 01:37:09 -0700 (PDT)
Subject: Re: [PATCH] mm/page_alloc: Ensure that HUGETLB_PAGE_ORDER is less
 than MAX_ORDER
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1617947717-2424-1-git-send-email-anshuman.khandual@arm.com>
 <5a92f302-1917-1374-a8c7-0badb9ec1b8c@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <2fde38dd-7556-4651-8623-321066e48861@arm.com>
Date:   Fri, 9 Apr 2021 14:07:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5a92f302-1917-1374-a8c7-0badb9ec1b8c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/21 1:54 PM, David Hildenbrand wrote:
> On 09.04.21 07:55, Anshuman Khandual wrote:
>> pageblock_order must always be less than MAX_ORDER, otherwise it might lead
>> to an warning during boot. A similar problem got fixed on arm64 platform
>> with the commit 79cc2ed5a716 ("arm64/mm: Drop THP conditionality from
>> FORCE_MAX_ZONEORDER"). Assert the above condition before HUGETLB_PAGE_ORDER
>> gets assigned as pageblock_order. This will help detect the problem earlier
>> on platforms where HUGETLB_PAGE_SIZE_VARIABLE is enabled.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   mm/page_alloc.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 604dcd69397b..81b7460e1228 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -7068,10 +7068,17 @@ void __init set_pageblock_order(void)
>>       if (pageblock_order)
>>           return;
>>   -    if (HPAGE_SHIFT > PAGE_SHIFT)
>> +    if (HPAGE_SHIFT > PAGE_SHIFT) {
>> +        /*
>> +         * pageblock_order must always be less than
>> +         * MAX_ORDER. So does HUGETLB_PAGE_ORDER if
>> +         * that is being assigned here.
>> +         */
>> +        WARN_ON(HUGETLB_PAGE_ORDER >= MAX_ORDER);
> 
> Can't that be a BUILD_BUG_ON() ?

Yes, it can be. Probably might be appropriate as well, given that both
the arguments here are compile time constants. Okay, will change.

> 
>>           order = HUGETLB_PAGE_ORDER;
>> -    else
>> +    } else {
>>           order = MAX_ORDER - 1;
>> +    }
>>         /*
>>        * Assume the largest contiguous order of interest is a huge page.
>>
> 
> 
