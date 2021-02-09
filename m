Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67F2314596
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhBIBZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:25:33 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11705 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhBIBZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:25:27 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DZQBD0V1BzlHrj;
        Tue,  9 Feb 2021 09:23:00 +0800 (CST)
Received: from [10.174.179.149] (10.174.179.149) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Feb 2021 09:24:43 +0800
Subject: Re: [PATCH] mm/hugetlb: use helper huge_page_size() to get hugepage
 size
To:     Mike Kravetz <mike.kravetz@oracle.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210208082450.15716-1-linmiaohe@huawei.com>
 <3752cc85-06d1-5af7-8baf-2810c98524d3@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f7aee85c-d320-5127-35b3-77a53db6a00f@huawei.com>
Date:   Tue, 9 Feb 2021 09:24:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <3752cc85-06d1-5af7-8baf-2810c98524d3@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi：
On 2021/2/9 8:45, Mike Kravetz wrote:
> On 2/8/21 12:24 AM, Miaohe Lin wrote:
>> We can use helper huge_page_size() to get the hugepage size directly to
>> simplify the code slightly.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/hugetlb.c | 14 ++++++--------
>>  1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 18628f8dbfb0..6cdb59d8f663 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -3199,7 +3199,7 @@ void __init hugetlb_add_hstate(unsigned int order)
>>  	BUG_ON(order == 0);
>>  	h = &hstates[hugetlb_max_hstate++];
>>  	h->order = order;
>> -	h->mask = ~((1ULL << (order + PAGE_SHIFT)) - 1);
>> +	h->mask = ~(huge_page_size(h) - 1);
>>  	for (i = 0; i < MAX_NUMNODES; ++i)
>>  		INIT_LIST_HEAD(&h->hugepage_freelists[i]);
>>  	INIT_LIST_HEAD(&h->hugepage_activelist);
>> @@ -3474,7 +3474,7 @@ void hugetlb_report_meminfo(struct seq_file *m)
>>  	for_each_hstate(h) {
>>  		unsigned long count = h->nr_huge_pages;
>>  
>> -		total += (PAGE_SIZE << huge_page_order(h)) * count;
>> +		total += huge_page_size(h) * count;
>>  
>>  		if (h == &default_hstate)
>>  			seq_printf(m,
>> @@ -3487,10 +3487,10 @@ void hugetlb_report_meminfo(struct seq_file *m)
>>  				   h->free_huge_pages,
>>  				   h->resv_huge_pages,
>>  				   h->surplus_huge_pages,
>> -				   (PAGE_SIZE << huge_page_order(h)) / 1024);
>> +				   huge_page_size(h) / SZ_1K);
>>  	}
>>  
>> -	seq_printf(m, "Hugetlb:        %8lu kB\n", total / 1024);
>> +	seq_printf(m, "Hugetlb:        %8lu kB\n", total / SZ_1K);
>>  }
>>  
>>  int hugetlb_report_node_meminfo(char *buf, int len, int nid)
>> @@ -3524,7 +3524,7 @@ void hugetlb_show_meminfo(void)
>>  				h->nr_huge_pages_node[nid],
>>  				h->free_huge_pages_node[nid],
>>  				h->surplus_huge_pages_node[nid],
>> -				1UL << (huge_page_order(h) + PAGE_SHIFT - 10));
>> +				huge_page_size(h) >> 10);
> 
> Should we change this to
> 
> 				huge_page_size(h) / SZ_1K);
> > as in hugetlb_report_meminfo above?  Or, is that one where it takes an
> additional instruction to do the divide as opposed to the shift?  I would> rather add the instruction and keep everything consistent.
> 

Yes, it takes an additional instruction to do the divide as opposed to the shift. So I did not
change this. But it seems keeping everything consistent in a function is more important. So should
I send a V2 to change this or Andrew would kindly handle this ?

Many thanks.
