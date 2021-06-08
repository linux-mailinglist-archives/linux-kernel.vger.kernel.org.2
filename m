Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614B039ED5C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 06:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhFHEGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 00:06:15 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:60661 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231238AbhFHEGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 00:06:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=yaohuiwang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ubixn0M_1623125043;
Received: from Dillions-MBP-16.local(mailfrom:yaohuiwang@linux.alibaba.com fp:SMTPD_---0Ubixn0M_1623125043)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Jun 2021 12:04:19 +0800
From:   Yaohui Wang <yaohuiwang@linux.alibaba.com>
Subject: Re: [PATCH] mm: fix pfn calculation mistake in __ioremap_check_ram
To:     Dave Hansen <dave.hansen@intel.com>, dave.hansen@linux.intel.com
Cc:     luto@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, yaohuiwang@linux.alibaba.com,
        luoben@linux.alibaba.com
References: <20210607091938.47960-1-yaohuiwang@linux.alibaba.com>
 <b77d2374-56d5-4b97-1319-56e744b81303@intel.com>
Message-ID: <0d1a308b-4d0e-d91a-52a7-6456ec6713f8@linux.alibaba.com>
Date:   Tue, 8 Jun 2021 12:04:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b77d2374-56d5-4b97-1319-56e744b81303@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/7 21:55, Dave Hansen wrote:
> On 6/7/21 2:19 AM, Yaohui Wang wrote:
>> According to the source code in function
>> arch/x86/mm/ioremap.c:__ioremap_caller, after __ioremap_check_mem, if the
>> mem range is IORES_MAP_SYSTEM_RAM, then __ioremap_caller should fail. But
>> because of the pfn calculation problem, __ioremap_caller can success
>> on IORES_MAP_SYSTEM_RAM region when the @size parameter is less than
>> PAGE_SIZE. This may cause misuse of the ioremap function and raise the
>> risk of performance issues. For example, ioremap(phys, PAGE_SIZE-1) may
>> cause the direct memory mapping of @phys to be uncached, and iounmap won't
>> revert this change. This patch fixes this issue.
>>
>> In arch/x86/mm/ioremap.c:__ioremap_check_ram, start_pfn should wrap down
>> the res->start address, and end_pfn should wrap up the res->end address.
>> This makes the check more strict and should be more reasonable.
> 
> Was this found by inspection, or was there a real-world bug which this
> patch addresses?
>

I did a performance test for linux kernel in many aspects. One of my 
scripts is to test the performance influence of ioremap. I found that 
applying ioremap on normal RAM may cause terrible performance issues.

To avoid memory cache behavior aliasing, ioremap will call 
memtype_kernel_map_sync to sync the cache attribute in the directing 
mapping, which causes:

1. If the phys addr is in a huge page in the directing mapping, then 
ioremap will split the huge page into 4K pages.
2. It will set the PCD bit in the directing mapping pte.

Both the above behaviors will downgrade the performance of the machine, 
especially when there is important code/data which is accessed 
frequently. What's worse, iounmap won't clear the PCD bit in the 
directing mapping pte, and I need to call ioremap_cache to clear the PCD 
bit. All these should be avoided.

Another thing also confuses me:

 From __ioremap_caller, we can see that __ioremap_caller don't allow us 
to remap normal RAM. In my understanding, direct mapping only maps 
normal RAM. So if the remap behavior is not allowed on normal RAM, it 
should be unnecessary to call memtype_kernel_map_sync. Is this right?
