Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5613FC666
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 13:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241411AbhHaLJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 07:09:41 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14441 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241405AbhHaLJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 07:09:40 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GzPTr1YqMzbfcG;
        Tue, 31 Aug 2021 19:04:48 +0800 (CST)
Received: from [10.174.178.75] (10.174.178.75) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 31 Aug 2021 19:08:42 +0800
Subject: Re: [PATCH 2/6] mm/page_alloc.c: simplify the code by using macro K()
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
CC:     <vbabka@suse.cz>, <sfr@canb.auug.org.au>, <peterz@infradead.org>,
        <mgorman@techsingularity.net>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210830141051.64090-1-linmiaohe@huawei.com>
 <20210830141051.64090-3-linmiaohe@huawei.com>
 <9161665.bUqNH3lxUD@natalenko.name>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <52bbb8f2-db63-8c56-ea49-d982c13ba541@huawei.com>
Date:   Tue, 31 Aug 2021 19:08:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <9161665.bUqNH3lxUD@natalenko.name>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.75]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/31 16:54, Oleksandr Natalenko wrote:
> Hello.
> 
> On pondělí 30. srpna 2021 16:10:47 CEST Miaohe Lin wrote:
>> Use helper macro K() to convert the pages to the corresponding size.
>> Minor readability improvement.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/page_alloc.c | 12 +++++-------
>>  1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index dbb3338d9287..d3983244f56f 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8134,8 +8134,7 @@ unsigned long free_reserved_area(void *start, void
>> *end, int poison, const char }
>>
>>  	if (pages && s)
>> -		pr_info("Freeing %s memory: %ldK\n",
>> -			s, pages << (PAGE_SHIFT - 10));
>> +		pr_info("Freeing %s memory: %ldK\n", s, K(pages));
>>
>>  	return pages;
>>  }
>> @@ -8180,14 +8179,13 @@ void __init mem_init_print_info(void)
>>  		", %luK highmem"
>>  #endif
>>  		")\n",
>> -		nr_free_pages() << (PAGE_SHIFT - 10),
>> -		physpages << (PAGE_SHIFT - 10),
>> +		K(nr_free_pages()), K(physpages),
>>  		codesize >> 10, datasize >> 10, rosize >> 10,
>>  		(init_data_size + init_code_size) >> 10, bss_size >> 10,
>> -		(physpages - totalram_pages() - totalcma_pages) << (PAGE_SHIFT 
> - 10),
>> -		totalcma_pages << (PAGE_SHIFT - 10)
>> +		K(physpages - totalram_pages() - totalcma_pages),
>> +		K(totalcma_pages)
>>  #ifdef	CONFIG_HIGHMEM
>> -		, totalhigh_pages() << (PAGE_SHIFT - 10)
>> +		, K(totalhigh_pages())
>>  #endif
>>  		);
>>  }
> 
> (my concern is not quite within the scope of this submission, but I'll ask 
> anyway)
> 
> Given we have this:
> 
> ```
> git grep '#define K(x)' v5.14
> v5.14:drivers/base/node.c:#define K(x) ((x) << (PAGE_SHIFT - 10))
> v5.14:drivers/net/hamradio/scc.c:#define K(x) kiss->x
> v5.14:kernel/debug/kdb/kdb_main.c:#define K(x) ((x) << (PAGE_SHIFT - 10))
> v5.14:mm/backing-dev.c:#define K(x) ((x) << (PAGE_SHIFT - 10))
> v5.14:mm/memcontrol.c:#define K(x) ((x) << (PAGE_SHIFT-10))
> v5.14:mm/oom_kill.c:#define K(x) ((x) << (PAGE_SHIFT-10))
> v5.14:mm/page_alloc.c:#define K(x) ((x) << (PAGE_SHIFT-10))
> ```
> 
> Shouldn't this macro go to some header file instead to get rid of define 
> repetitions?

Many thanks for figuring this out. I think we should get rid of these repetitions too.
But I'am not sure where this definition should be. Any suggestion? Thanks.

> 
> Thanks.
> 

