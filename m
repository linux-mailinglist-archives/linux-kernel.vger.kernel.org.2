Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803C235BAC5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbhDLHZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:25:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:13015 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230510AbhDLHZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:25:11 -0400
IronPort-SDR: U9ZatO4MvkqWlifDt9H94SBGcTu7lt2Zo2ZyOpWjR9mqDaO47nZqf18mCUO9s2V15MR7xPUMBF
 d3epiS2MKTfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="214592458"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="214592458"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 00:24:54 -0700
IronPort-SDR: B9SU3wecjSe4accQUXOvGF+Iorh6vcLJJBTEy3kxZJASuwb0+V61dr3jxnQ6wrQkEILhccp2TO
 X/IJmGgNVlAg==
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="417264247"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 00:24:50 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>, <vbabka@suse.cz>,
        <alex.shi@linux.alibaba.com>, <willy@infradead.org>,
        <minchan@kernel.org>, <richard.weiyang@gmail.com>,
        <hughd@google.com>, <tim.c.chen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 1/5] mm/swapfile: add percpu_ref support for swap
References: <20210408130820.48233-1-linmiaohe@huawei.com>
        <20210408130820.48233-2-linmiaohe@huawei.com>
        <87fszww55d.fsf@yhuang6-desk1.ccr.corp.intel.com>
Date:   Mon, 12 Apr 2021 15:24:48 +0800
In-Reply-To: <87fszww55d.fsf@yhuang6-desk1.ccr.corp.intel.com> (Ying Huang's
        message of "Mon, 12 Apr 2021 11:30:54 +0800")
Message-ID: <87zgy4ufr3.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Huang, Ying" <ying.huang@intel.com> writes:

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

I just noticed that the comments of percpu_ref_tryget_live() says,

 * This function is safe to call as long as @ref is between init and exit.

While we need to call get_swap_device() almost at any time, so it's
better to avoid to call percpu_ref_exit() at all.  This will waste some
memory, but we need to follow the API definition to avoid potential
issues in the long term.

And we need to call percpu_ref_init() before insert the swap_info_struct
into the swap_info[].

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

Check the original commit description for commit eb085574a752 "mm, swap:
fix race between swapoff and some swap operations" and discussion email
thread as follows again,

https://lore.kernel.org/linux-mm/20171219053650.GB7829@linux.vnet.ibm.com/

I found that the synchronize_rcu() here is to avoid to call smp_rmb() or
smp_load_acquire() in get_swap_device().  Now we will use
percpu_ref_tryget_live() in get_swap_device(), so we will need to add
the necessary memory barrier, or make sure percpu_ref_tryget_live() has
ACQUIRE semantics.  Per my understanding, we need to change
percpu_ref_tryget_live() for that.

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

After reading the original commit description as above, I found that we
need synchronize_rcu() here to protect the accessing to the swap cache
data structure.  Because there's call_rcu() during percpu_ref_kill(), it
appears OK to keep the synchronize_rcu() here.  And we need to revise
the comments to make it clear what is protected by which operation.

Best Regards,
Huang, Ying

[snip]
