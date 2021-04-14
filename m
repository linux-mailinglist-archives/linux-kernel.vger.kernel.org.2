Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5DF35EB0F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344703AbhDNCnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:43:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17328 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbhDNCng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:43:36 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FKmtc6jqkzB0Sy;
        Wed, 14 Apr 2021 10:40:56 +0800 (CST)
Received: from [10.174.176.162] (10.174.176.162) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 10:43:10 +0800
Subject: Re: [PATCH 5/5] mm/swap_state: fix swap_cluster_readahead() race with
 swapoff
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>, <vbabka@suse.cz>,
        <alex.shi@linux.alibaba.com>, <willy@infradead.org>,
        <minchan@kernel.org>, <richard.weiyang@gmail.com>,
        <hughd@google.com>, <tim.c.chen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210408130820.48233-1-linmiaohe@huawei.com>
 <20210408130820.48233-6-linmiaohe@huawei.com>
 <87eeffufst.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <444ce6f6-9ba7-6161-6429-85b01561ad5e@huawei.com>
Date:   Wed, 14 Apr 2021 10:43:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87eeffufst.fsf@yhuang6-desk1.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/13 9:36, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> swap_cluster_readahead() could race with swapoff and might dereference
>> si->swap_file after it's released by swapoff. Close this race window by
>> using get/put_swap_device() pair.
> 
> I think we should fix the callers instead to reduce the overhead.  Now,
> do_swap_page() has been fixed.  We need to fix shmem_swapin().
> 

Will do. Many thanks.

> Best Regards,
> Huang, Ying
> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/swap_state.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/swap_state.c b/mm/swap_state.c
>> index 3bf0d0c297bc..eba6b0cf6cf9 100644
>> --- a/mm/swap_state.c
>> +++ b/mm/swap_state.c
>> @@ -626,12 +626,17 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>>  	unsigned long offset = entry_offset;
>>  	unsigned long start_offset, end_offset;
>>  	unsigned long mask;
>> -	struct swap_info_struct *si = swp_swap_info(entry);
>> +	struct swap_info_struct *si;
>>  	struct blk_plug plug;
>>  	bool do_poll = true, page_allocated;
>>  	struct vm_area_struct *vma = vmf->vma;
>>  	unsigned long addr = vmf->address;
>>  
>> +	si = get_swap_device(entry);
>> +	/* In case we raced with swapoff. */
>> +	if (!si)
>> +		return NULL;
>> +
>>  	mask = swapin_nr_pages(offset) - 1;
>>  	if (!mask)
>>  		goto skip;
>> @@ -673,7 +678,9 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>>  
>>  	lru_add_drain();	/* Push any new pages onto the LRU now */
>>  skip:
>> -	return read_swap_cache_async(entry, gfp_mask, vma, addr, do_poll);
>> +	page = read_swap_cache_async(entry, gfp_mask, vma, addr, do_poll);
>> +	put_swap_device(si);
>> +	return page;
>>  }
>>  
>>  int init_swap_address_space(unsigned int type, unsigned long nr_pages)
> .
> 

