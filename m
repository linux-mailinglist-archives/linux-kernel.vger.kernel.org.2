Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206D934B40D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 04:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhC0Deg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 23:34:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14495 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhC0DeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 23:34:16 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6kt401MkzySBp;
        Sat, 27 Mar 2021 11:32:12 +0800 (CST)
Received: from [10.174.177.208] (10.174.177.208) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 11:34:05 +0800
Subject: Re: [PATCH -next] mm, page_alloc: avoid page_to_pfn() in
 move_freepages()
To:     Matthew Wilcox <willy@infradead.org>
References: <20210323131215.934472-1-liushixin2@huawei.com>
 <20210323125400.GE1719932@casper.infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <fa98fe49-8b95-fbbf-6161-483519e742ac@huawei.com>
Date:   Sat, 27 Mar 2021 11:34:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210323125400.GE1719932@casper.infradead.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    Sorry to reply to you after a so long time and thanks for your advice. It does seem that your proposed change will make the code cleaner and more efficient.

    I repeated move_freepages_block() 2000000 times on the VM and counted jiffies. The average value before and after the change was both about 12,000. I think it's probably because I'm using the Sparse Memory Model, so pfn_to_page() is not time-consuming.


On 2021/3/23 20:54, Matthew Wilcox wrote:
> On Tue, Mar 23, 2021 at 09:12:15PM +0800, Liu Shixin wrote:
>> From: Kefeng Wang <wangkefeng.wang@huawei.com>
>>
>> The start_pfn and end_pfn are already available in move_freepages_block(),
>> there is no need to go back and forth between page and pfn in move_freepages
>> and move_freepages_block, and pfn_valid_within() should validate pfn first
>> before touching the page.
> This looks good to me:
>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>
>>  static int move_freepages(struct zone *zone,
>> -			  struct page *start_page, struct page *end_page,
>> +			  unsigned long start_pfn, unsigned long end_pfn,
>>  			  int migratetype, int *num_movable)
>>  {
>>  	struct page *page;
>> +	unsigned long pfn;
>>  	unsigned int order;
>>  	int pages_moved = 0;
>>  
>> -	for (page = start_page; page <= end_page;) {
>> -		if (!pfn_valid_within(page_to_pfn(page))) {
>> -			page++;
>> +	for (pfn = start_pfn; pfn <= end_pfn;) {
>> +		if (!pfn_valid_within(pfn)) {
>> +			pfn++;
>>  			continue;
>>  		}
>>  
>> +		page = pfn_to_page(pfn);
> I wonder if this wouldn't be even better if we did:
>
> 	struct page *start_page = pfn_to_page(start_pfn);
>
> 	for (pfn = start_pfn; pfn <= end_pfn; pfn++) {
> 		struct page *page = start_page + pfn - start_pfn;
>
> 		if (!pfn_valid_within(pfn))
> 			continue;
>
>> -
>> -			page++;
>> +			pfn++;
>>  			continue;
> ... then we can drop the increment of pfn here
>
>>  		}
>>  
>> @@ -2458,7 +2459,7 @@ static int move_freepages(struct zone *zone,
>>  
>>  		order = buddy_order(page);
>>  		move_to_free_list(page, zone, order, migratetype);
>> -		page += 1 << order;
>> +		pfn += 1 << order;
> ... and change this to pfn += (1 << order) - 1;
>
> Do you have any numbers to quantify the benefit of this change?
> .
>

