Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2578363BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 08:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbhDSGqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 02:46:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16135 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbhDSGqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 02:46:44 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FNy1s6qHrzpYBl;
        Mon, 19 Apr 2021 14:43:13 +0800 (CST)
Received: from [10.174.178.5] (10.174.178.5) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Mon, 19 Apr 2021
 14:46:08 +0800
Subject: Re: [PATCH v2 1/5] mm/swapfile: add percpu_ref support for swap
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <david@redhat.com>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20210417094039.51711-1-linmiaohe@huawei.com>
 <20210417094039.51711-2-linmiaohe@huawei.com>
 <87eef7kmzw.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <753f414f-34a1-b16a-f826-7deb2dcd4af6@huawei.com>
Date:   Mon, 19 Apr 2021 14:46:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87eef7kmzw.fsf@yhuang6-desk1.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.5]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/19 10:48, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> We will use percpu-refcount to serialize against concurrent swapoff. This
>> patch adds the percpu_ref support for swap.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  include/linux/swap.h |  3 +++
>>  mm/swapfile.c        | 33 +++++++++++++++++++++++++++++----
>>  2 files changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index 144727041e78..8be36eb58b7a 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -240,6 +240,7 @@ struct swap_cluster_list {
>>   * The in-memory structure used to track swap areas.
>>   */
>>  struct swap_info_struct {
>> +	struct percpu_ref users;	/* serialization against concurrent swapoff */
> 
> The comments aren't general enough.  We use this to check whether the
> swap device has been fully initialized, etc. May be something as below?
> 
> /* indicate and keep swap device valid */

Looks good.

> 
>>  	unsigned long	flags;		/* SWP_USED etc: see above */
>>  	signed short	prio;		/* swap priority of this type */
>>  	struct plist_node list;		/* entry in swap_active_head */
>> @@ -260,6 +261,8 @@ struct swap_info_struct {
>>  	struct block_device *bdev;	/* swap device or bdev of swap file */
>>  	struct file *swap_file;		/* seldom referenced */
>>  	unsigned int old_block_size;	/* seldom referenced */
>> +	bool ref_initialized;		/* seldom referenced */
>> +	struct completion comp;		/* seldom referenced */
>>  #ifdef CONFIG_FRONTSWAP
>>  	unsigned long *frontswap_map;	/* frontswap in-use, one bit per page */
>>  	atomic_t frontswap_pages;	/* frontswap pages in-use counter */
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 149e77454e3c..66515a3a2824 100644
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
>> @@ -511,6 +512,14 @@ static void swap_discard_work(struct work_struct *work)
>>  	spin_unlock(&si->lock);
>>  }
>>  
>> +static void swap_users_ref_free(struct percpu_ref *ref)
>> +{
>> +	struct swap_info_struct *si;
>> +
>> +	si = container_of(ref, struct swap_info_struct, users);
>> +	complete(&si->comp);
>> +}
>> +
>>  static void alloc_cluster(struct swap_info_struct *si, unsigned long idx)
>>  {
>>  	struct swap_cluster_info *ci = si->cluster_info;
>> @@ -2500,7 +2509,7 @@ static void enable_swap_info(struct swap_info_struct *p, int prio,
>>  	 * Guarantee swap_map, cluster_info, etc. fields are valid
>>  	 * between get/put_swap_device() if SWP_VALID bit is set
>>  	 */
>> -	synchronize_rcu();
> 
> You cannot remove this without changing get/put_swap_device().  It's
> better to squash at least PATCH 1-2.

Will squash PATCH 1-2. Thanks.

> 
>> +	percpu_ref_resurrect(&p->users);
>>  	spin_lock(&swap_lock);
>>  	spin_lock(&p->lock);
>>  	_enable_swap_info(p);
>> @@ -2621,11 +2630,18 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>>  	p->flags &= ~SWP_VALID;		/* mark swap device as invalid */
>>  	spin_unlock(&p->lock);
>>  	spin_unlock(&swap_lock);
>> +
>> +	percpu_ref_kill(&p->users);
>>  	/*
>> -	 * wait for swap operations protected by get/put_swap_device()
>> -	 * to complete
>> +	 * We need synchronize_rcu() here to protect the accessing
>> +	 * to the swap cache data structure.
>>  	 */
>>  	synchronize_rcu();
>> +	/*
>> +	 * Wait for swap operations protected by get/put_swap_device()
>> +	 * to complete.
>> +	 */
> 
> I think the comments (after some revision) can be moved before
> percpu_ref_kill().  The synchronize_rcu() comments can be merged.
> 

Ok.

>> +	wait_for_completion(&p->comp);
>>  
>>  	flush_work(&p->discard_work);
>>  
>> @@ -3132,7 +3148,7 @@ static bool swap_discardable(struct swap_info_struct *si)
>>  SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>>  {
>>  	struct swap_info_struct *p;
>> -	struct filename *name;
>> +	struct filename *name = NULL;
>>  	struct file *swap_file = NULL;
>>  	struct address_space *mapping;
>>  	int prio;
>> @@ -3163,6 +3179,15 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>>  
>>  	INIT_WORK(&p->discard_work, swap_discard_work);
>>  
>> +	if (!p->ref_initialized) {
> 
> I don't think it's necessary to add another flag p->ref_initialized.  We
> can distinguish newly allocated and reused swap_info_struct in alloc_swap_info().
> 

If newly allocated swap_info_struct failed to init percpu_ref, it will be considered as
a reused one in alloc_swap_info() _but_ the field users of swap_info_struct is actually
uninitialized. Does this make sense for you?

Many Thanks for quick review.

> Best Regards,
> Huang, Ying
> 
>> +		error = percpu_ref_init(&p->users, swap_users_ref_free,
>> +					PERCPU_REF_INIT_DEAD, GFP_KERNEL);
>> +		if (unlikely(error))
>> +			goto bad_swap;
>> +		init_completion(&p->comp);
>> +		p->ref_initialized = true;
>> +	}
>> +
>>  	name = getname(specialfile);
>>  	if (IS_ERR(name)) {
>>  		error = PTR_ERR(name);
> .
> 

