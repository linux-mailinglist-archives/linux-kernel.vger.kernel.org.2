Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9D535EB0E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243269AbhDNCnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:43:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16990 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhDNCnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:43:02 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FKmsH20DhzNvtd;
        Wed, 14 Apr 2021 10:39:47 +0800 (CST)
Received: from [10.174.176.162] (10.174.176.162) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 10:42:38 +0800
Subject: Re: [PATCH 3/5] mm/swap_state: fix get_shadow_from_swap_cache() race
 with swapoff
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>, <vbabka@suse.cz>,
        <alex.shi@linux.alibaba.com>, <willy@infradead.org>,
        <minchan@kernel.org>, <richard.weiyang@gmail.com>,
        <hughd@google.com>, <tim.c.chen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210408130820.48233-1-linmiaohe@huawei.com>
 <20210408130820.48233-4-linmiaohe@huawei.com>
 <87im4rufwq.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4ebc0a78-6fde-9d43-7562-8ef7679b5460@huawei.com>
Date:   Wed, 14 Apr 2021 10:42:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87im4rufwq.fsf@yhuang6-desk1.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/13 9:33, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> The function get_shadow_from_swap_cache() can race with swapoff, though
>> it's only called by do_swap_page() now.
>>
>> Fixes: aae466b0052e ("mm/swap: implement workingset detection for anonymous LRU")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> This is unnecessary.  The only caller has guaranteed the swap device
> from swapoff

Ok. This patch is just in case get_shadow_from_swap_cache() would be
called from elsewhere someday.

It's unnecessary and can be dropped now

.
> 
> Best Regards,
> Huang, Ying
> 
>> ---
>>  mm/swap_state.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/swap_state.c b/mm/swap_state.c
>> index 272ea2108c9d..709c260d644a 100644
>> --- a/mm/swap_state.c
>> +++ b/mm/swap_state.c
>> @@ -83,11 +83,14 @@ void show_swap_cache_info(void)
>>  
>>  void *get_shadow_from_swap_cache(swp_entry_t entry)
>>  {
>> -	struct address_space *address_space = swap_address_space(entry);
>> -	pgoff_t idx = swp_offset(entry);
>> +	struct swap_info_struct *si;
>>  	struct page *page;
>>  
>> -	page = xa_load(&address_space->i_pages, idx);
>> +	si = get_swap_device(entry);
>> +	if (!si)
>> +		return NULL;
>> +	page = xa_load(&swap_address_space(entry)->i_pages, swp_offset(entry));
>> +	put_swap_device(si);
>>  	if (xa_is_value(page))
>>  		return page;
>>  	return NULL;
> 
> .
> 

