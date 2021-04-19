Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D190363BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 08:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbhDSG5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 02:57:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17012 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbhDSG5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 02:57:46 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FNyGd4S5bzPs3L;
        Mon, 19 Apr 2021 14:54:17 +0800 (CST)
Received: from [10.174.178.5] (10.174.178.5) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Mon, 19 Apr 2021
 14:57:14 +0800
Subject: Re: [PATCH v2 2/5] mm/swapfile: use percpu_ref to serialize against
 concurrent swapoff
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <david@redhat.com>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20210417094039.51711-1-linmiaohe@huawei.com>
 <20210417094039.51711-3-linmiaohe@huawei.com>
 <87a6pvkmqi.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <16a20b86-b690-9397-def1-1171828c245e@huawei.com>
Date:   Mon, 19 Apr 2021 14:57:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87a6pvkmqi.fsf@yhuang6-desk1.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.5]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/19 10:54, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> Use percpu_ref to serialize against concurrent swapoff. Also remove the
>> SWP_VALID flag because it's used together with RCU solution.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  include/linux/swap.h |  3 +--
>>  mm/swapfile.c        | 43 +++++++++++++++++--------------------------
>>  2 files changed, 18 insertions(+), 28 deletions(-)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index 8be36eb58b7a..993693b38109 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -177,7 +177,6 @@ enum {
>>  	SWP_PAGE_DISCARD = (1 << 10),	/* freed swap page-cluster discards */
>>  	SWP_STABLE_WRITES = (1 << 11),	/* no overwrite PG_writeback pages */
>>  	SWP_SYNCHRONOUS_IO = (1 << 12),	/* synchronous IO is efficient */
>> -	SWP_VALID	= (1 << 13),	/* swap is valid to be operated on? */
>>  					/* add others here before... */
>>  	SWP_SCANNING	= (1 << 14),	/* refcount in scan_swap_map */
>>  };
>> @@ -514,7 +513,7 @@ sector_t swap_page_sector(struct page *page);
>>  
>>  static inline void put_swap_device(struct swap_info_struct *si)
>>  {
>> -	rcu_read_unlock();
>> +	percpu_ref_put(&si->users);
>>  }
>>  
>>  #else /* CONFIG_SWAP */
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 66515a3a2824..90e197bc2eeb 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -1279,18 +1279,12 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
>>   * via preventing the swap device from being swapoff, until
>>   * put_swap_device() is called.  Otherwise return NULL.
>>   *
>> - * The entirety of the RCU read critical section must come before the
>> - * return from or after the call to synchronize_rcu() in
>> - * enable_swap_info() or swapoff().  So if "si->flags & SWP_VALID" is
>> - * true, the si->map, si->cluster_info, etc. must be valid in the
>> - * critical section.
>> - *
>>   * Notice that swapoff or swapoff+swapon can still happen before the
>> - * rcu_read_lock() in get_swap_device() or after the rcu_read_unlock()
>> - * in put_swap_device() if there isn't any other way to prevent
>> - * swapoff, such as page lock, page table lock, etc.  The caller must
>> - * be prepared for that.  For example, the following situation is
>> - * possible.
>> + * percpu_ref_tryget_live() in get_swap_device() or after the
>> + * percpu_ref_put() in put_swap_device() if there isn't any other way
>> + * to prevent swapoff, such as page lock, page table lock, etc.  The
>> + * caller must be prepared for that.  For example, the following
>> + * situation is possible.
>>   *
>>   *   CPU1				CPU2
>>   *   do_swap_page()
>> @@ -1318,21 +1312,24 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
>>  	si = swp_swap_info(entry);
>>  	if (!si)
>>  		goto bad_nofile;
>> -
>> -	rcu_read_lock();
>> -	if (data_race(!(si->flags & SWP_VALID)))
>> -		goto unlock_out;
>> +	if (!percpu_ref_tryget_live(&si->users))
>> +		goto out;
>> +	/*
>> +	 * Guarantee we will not reference uninitialized fields
>> +	 * of swap_info_struct.
>> +	 */
> 
> /*
>  * Guarantee the si->users are checked before accessing other fields of
>  * swap_info_struct.
> */
> 
>> +	smp_rmb();
> 
> Usually, smp_rmb() need to be paired with smp_wmb().  Some comments are
> needed for that.  Here smb_rmb() is paired with the spin_unlock() after
> setup_swap_info() in enable_swap_info().
> 
>>  	offset = swp_offset(entry);
>>  	if (offset >= si->max)
>> -		goto unlock_out;
>> +		goto put_out;
>>  
>>  	return si;
>>  bad_nofile:
>>  	pr_err("%s: %s%08lx\n", __func__, Bad_file, entry.val);
>>  out:
>>  	return NULL;
>> -unlock_out:
>> -	rcu_read_unlock();
>> +put_out:
>> +	percpu_ref_put(&si->users);
>>  	return NULL;
>>  }
>>  
>> @@ -2475,7 +2472,7 @@ static void setup_swap_info(struct swap_info_struct *p, int prio,
>>  
>>  static void _enable_swap_info(struct swap_info_struct *p)
>>  {
>> -	p->flags |= SWP_WRITEOK | SWP_VALID;
>> +	p->flags |= SWP_WRITEOK;
>>  	atomic_long_add(p->pages, &nr_swap_pages);
>>  	total_swap_pages += p->pages;
>>  
>> @@ -2507,7 +2504,7 @@ static void enable_swap_info(struct swap_info_struct *p, int prio,
>>  	spin_unlock(&swap_lock);
>>  	/*
>>  	 * Guarantee swap_map, cluster_info, etc. fields are valid
>> -	 * between get/put_swap_device() if SWP_VALID bit is set
>> +	 * between get/put_swap_device().
>>  	 */
> 
> The comments need to be revised.  Something likes below?
> 
> /* Finished initialized swap device, now it's safe to reference it */
> 

All look good for me. Will do. Many thanks!

> Best Regards,
> Huang, Ying
> 
>>  	percpu_ref_resurrect(&p->users);
>>  	spin_lock(&swap_lock);
>> @@ -2625,12 +2622,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>>  
>>  	reenable_swap_slots_cache_unlock();
>>  
>> -	spin_lock(&swap_lock);
>> -	spin_lock(&p->lock);
>> -	p->flags &= ~SWP_VALID;		/* mark swap device as invalid */
>> -	spin_unlock(&p->lock);
>> -	spin_unlock(&swap_lock);
>> -
>>  	percpu_ref_kill(&p->users);
>>  	/*
>>  	 * We need synchronize_rcu() here to protect the accessing
> 
> .
> 

