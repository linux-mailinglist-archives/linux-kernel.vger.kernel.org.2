Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB6F35BA7C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 08:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbhDLG7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 02:59:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16443 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhDLG7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 02:59:43 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FJfgB2YnMzqTMK;
        Mon, 12 Apr 2021 14:57:10 +0800 (CST)
Received: from [10.174.176.162] (10.174.176.162) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Mon, 12 Apr 2021 14:59:21 +0800
Subject: Re: [PATCH 1/5] mm/swapfile: add percpu_ref support for swap
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>, <vbabka@suse.cz>,
        <alex.shi@linux.alibaba.com>, <willy@infradead.org>,
        <minchan@kernel.org>, <richard.weiyang@gmail.com>,
        <hughd@google.com>, <tim.c.chen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210408130820.48233-1-linmiaohe@huawei.com>
 <20210408130820.48233-2-linmiaohe@huawei.com>
 <87fszww55d.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <87e0c968-f203-eaac-8993-0ae5d9abfd45@huawei.com>
Date:   Mon, 12 Apr 2021 14:59:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87fszww55d.fsf@yhuang6-desk1.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/12 11:30, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> We will use percpu-refcount to serialize against concurrent swapoff. This
>> patch adds the percpu_ref support for later fixup.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  include/linux/swap.h |  2 ++
>>  mm/swapfile.c        | 25 ++++++++++++++++++++++---
>>  2 files changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index 144727041e78..849ba5265c11 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -240,6 +240,7 @@ struct swap_cluster_list {
>>   * The in-memory structure used to track swap areas.
>>   */
>>  struct swap_info_struct {
>> +	struct percpu_ref users;	/* serialization against concurrent swapoff */
>>  	unsigned long	flags;		/* SWP_USED etc: see above */
>>  	signed short	prio;		/* swap priority of this type */
>>  	struct plist_node list;		/* entry in swap_active_head */
>> @@ -260,6 +261,7 @@ struct swap_info_struct {
>>  	struct block_device *bdev;	/* swap device or bdev of swap file */
>>  	struct file *swap_file;		/* seldom referenced */
>>  	unsigned int old_block_size;	/* seldom referenced */
>> +	struct completion comp;		/* seldom referenced */
>>  #ifdef CONFIG_FRONTSWAP
>>  	unsigned long *frontswap_map;	/* frontswap in-use, one bit per page */
>>  	atomic_t frontswap_pages;	/* frontswap pages in-use counter */
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 149e77454e3c..724173cd7d0c 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -39,6 +39,7 @@
>>  #include <linux/export.h>
>>  #include <linux/swap_slots.h>
>>  #include <linux/sort.h>
>> +#include <linux/completion.h>
>>  
>>  #include <asm/tlbflush.h>
>>  #include <linux/swapops.h>
>> @@ -511,6 +512,15 @@ static void swap_discard_work(struct work_struct *work)
>>  	spin_unlock(&si->lock);
>>  }
>>  
>> +static void swap_users_ref_free(struct percpu_ref *ref)
>> +{
>> +	struct swap_info_struct *si;
>> +
>> +	si = container_of(ref, struct swap_info_struct, users);
>> +	complete(&si->comp);
>> +	percpu_ref_exit(&si->users);
> 
> Because percpu_ref_exit() is used, we cannot use percpu_ref_tryget() in
> get_swap_device(), better to add comments there.

Will do.

> 
>> +}
>> +
>>  static void alloc_cluster(struct swap_info_struct *si, unsigned long idx)
>>  {
>>  	struct swap_cluster_info *ci = si->cluster_info;
>> @@ -2500,7 +2510,7 @@ static void enable_swap_info(struct swap_info_struct *p, int prio,
>>  	 * Guarantee swap_map, cluster_info, etc. fields are valid
>>  	 * between get/put_swap_device() if SWP_VALID bit is set
>>  	 */
>> -	synchronize_rcu();
>> +	percpu_ref_reinit(&p->users);
> 
> Although the effect is same, I think it's better to use
> percpu_ref_resurrect() here to improve code readability.
> 

Agree.

>>  	spin_lock(&swap_lock);
>>  	spin_lock(&p->lock);
>>  	_enable_swap_info(p);
>> @@ -2621,11 +2631,13 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>>  	p->flags &= ~SWP_VALID;		/* mark swap device as invalid */
>>  	spin_unlock(&p->lock);
>>  	spin_unlock(&swap_lock);
>> +
>> +	percpu_ref_kill(&p->users);
>>  	/*
>>  	 * wait for swap operations protected by get/put_swap_device()
>>  	 * to complete
>>  	 */
>> -	synchronize_rcu();
>> +	wait_for_completion(&p->comp);
> 
> Better to move percpu_ref_kill() after the comments.  And maybe revise
> the comments.

Will do.

> 
>>  
>>  	flush_work(&p->discard_work);
>>  
>> @@ -3132,7 +3144,7 @@ static bool swap_discardable(struct swap_info_struct *si)
>>  SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>>  {
>>  	struct swap_info_struct *p;
>> -	struct filename *name;
>> +	struct filename *name = NULL;
>>  	struct file *swap_file = NULL;
>>  	struct address_space *mapping;
>>  	int prio;
>> @@ -3163,6 +3175,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>>  
>>  	INIT_WORK(&p->discard_work, swap_discard_work);
>>  
>> +	init_completion(&p->comp);
>> +	error = percpu_ref_init(&p->users, swap_users_ref_free,
>> +				PERCPU_REF_INIT_DEAD, GFP_KERNEL);
>> +	if (unlikely(error))
>> +		goto bad_swap;
>> +
>>  	name = getname(specialfile);
>>  	if (IS_ERR(name)) {
>>  		error = PTR_ERR(name);
>> @@ -3356,6 +3374,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>>  bad_swap_unlock_inode:
>>  	inode_unlock(inode);
>>  bad_swap:
>> +	percpu_ref_exit(&p->users);
> 
> Usually the resource freeing order matches their allocating order
> reversely.  So, if there's no special reason, please follow that rule.
> 

My oversight. Will fix it in V2.

> Best Regards,
> Huang, Ying
> 
>>  	free_percpu(p->percpu_cluster);
>>  	p->percpu_cluster = NULL;
>>  	free_percpu(p->cluster_next_cpu);
> .
> 

Many thanks for review and nice suggestion! :)
