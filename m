Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6601D319A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 08:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhBLHT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 02:19:57 -0500
Received: from foss.arm.com ([217.140.110.172]:33240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhBLHTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 02:19:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86BA7113E;
        Thu, 11 Feb 2021 23:19:07 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E2C83F73D;
        Thu, 11 Feb 2021 23:19:03 -0800 (PST)
Subject: Re: [PATCH 3/3] dma-contiguous: Type cast MAX_ORDER as unsigned int
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, akpm@linux-foundation.org,
        will@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        David Hildenbrand <david@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1613024531-19040-1-git-send-email-anshuman.khandual@arm.com>
 <1613024531-19040-4-git-send-email-anshuman.khandual@arm.com>
 <20210211080417.GC14448@lst.de>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <cb6b039a-5a8f-b2c4-2c9e-bcd973ba6232@arm.com>
Date:   Fri, 12 Feb 2021 12:49:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210211080417.GC14448@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/21 1:34 PM, Christoph Hellwig wrote:
> On Thu, Feb 11, 2021 at 11:52:11AM +0530, Anshuman Khandual wrote:
>> Type cast MAX_ORDER as unsigned int to fix the following build warning.
>>
>> In file included from ./include/linux/kernel.h:14,
>>                  from ./include/asm-generic/bug.h:20,
>>                  from ./arch/arm64/include/asm/bug.h:26,
>>                  from ./include/linux/bug.h:5,
>>                  from ./include/linux/mmdebug.h:5,
>>                  from ./arch/arm64/include/asm/memory.h:166,
>>                  from ./arch/arm64/include/asm/page.h:42,
>>                  from kernel/dma/contiguous.c:46:
>> kernel/dma/contiguous.c: In function ‘rmem_cma_setup’:
>> ./include/linux/minmax.h:18:28: warning: comparison of distinct pointer
>> types lacks a cast
>>   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>>                             ^~
>> ./include/linux/minmax.h:32:4: note: in expansion of macro ‘__typecheck’
>>    (__typecheck(x, y) && __no_side_effects(x, y))
>>     ^~~~~~~~~~~
>> ./include/linux/minmax.h:42:24: note: in expansion of macro ‘__safe_cmp’
>>   __builtin_choose_expr(__safe_cmp(x, y), \
>>                         ^~~~~~~~~~
>> ./include/linux/minmax.h:58:19: note: in expansion of macro
>> ‘__careful_cmp’
>>  #define max(x, y) __careful_cmp(x, y, >)
>>                    ^~~~~~~~~~~~~
>> kernel/dma/contiguous.c:402:35: note: in expansion of macro ‘max’
>>   phys_addr_t align = PAGE_SIZE << max(MAX_ORDER - 1, pageblock_order);
>>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: iommu@lists.linux-foundation.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  kernel/dma/contiguous.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
>> index 3d63d91cba5c..1c2782349d71 100644
>> --- a/kernel/dma/contiguous.c
>> +++ b/kernel/dma/contiguous.c
>> @@ -399,7 +399,7 @@ static const struct reserved_mem_ops rmem_cma_ops = {
>>  
>>  static int __init rmem_cma_setup(struct reserved_mem *rmem)
>>  {
>> -	phys_addr_t align = PAGE_SIZE << max(MAX_ORDER - 1, pageblock_order);
>> +	phys_addr_t align = PAGE_SIZE << max((unsigned int)MAX_ORDER - 1, pageblock_order);
> 
> MAX_ORDER and pageblock_order should be the same type.  So either fix

Right.

> MAX_ORDER to be an unsigned constant, which would be fundamentally
> the right thing to do but might cause some fallout, or turn
> pageblock_order into an int, which is probably much either as the stub
> define of it already has an integer type derived from MAX_ORDER as well.

Right, will change pageblock_order as 'int' which would be easier.
