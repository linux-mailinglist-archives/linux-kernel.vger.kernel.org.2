Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6BF366348
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 03:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhDUBFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 21:05:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:57469 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234309AbhDUBFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 21:05:47 -0400
IronPort-SDR: B+tUoRw35AsO4yFi8/syhQqwHItney1+p6wBbp0lBkqcebBwQpGVtWZT+6P62G4X4GvlZ5GJsv
 krKjtgUU04VA==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="195176771"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="195176771"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 18:05:15 -0700
IronPort-SDR: ofllOQnAqjGwclmN0l+mJiJRuoK9RnwgIKdVJf5xmnHS85bGQUHCejv2//dlEhk/CfD2v6qdl0
 xSjfArYbKJkw==
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="401322839"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 18:05:11 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <shy828301@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v3 1/4] mm/swapfile: use percpu_ref to serialize against
 concurrent swapoff
References: <20210420133048.6773-1-linmiaohe@huawei.com>
        <20210420133048.6773-2-linmiaohe@huawei.com>
Date:   Wed, 21 Apr 2021 09:05:08 +0800
In-Reply-To: <20210420133048.6773-2-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Tue, 20 Apr 2021 09:30:45 -0400")
Message-ID: <87wnsw1m7v.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> Using current get/put_swap_device() to guard against concurrent swapoff
> for some swap ops, e.g. swap_readpage(), looks terrible because they
> might take really long time. This patch adds the percpu_ref support to
> serialize against concurrent swapoff. Also we remove the SWP_VALID flag
> because it's used together with RCU solution.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/swap.h |  5 +--
>  mm/swapfile.c        | 79 +++++++++++++++++++++++++++-----------------
>  2 files changed, 52 insertions(+), 32 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 144727041e78..c9e7fea10b83 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -177,7 +177,6 @@ enum {
>  	SWP_PAGE_DISCARD = (1 << 10),	/* freed swap page-cluster discards */
>  	SWP_STABLE_WRITES = (1 << 11),	/* no overwrite PG_writeback pages */
>  	SWP_SYNCHRONOUS_IO = (1 << 12),	/* synchronous IO is efficient */
> -	SWP_VALID	= (1 << 13),	/* swap is valid to be operated on? */
>  					/* add others here before... */
>  	SWP_SCANNING	= (1 << 14),	/* refcount in scan_swap_map */
>  };
> @@ -240,6 +239,7 @@ struct swap_cluster_list {
>   * The in-memory structure used to track swap areas.
>   */
>  struct swap_info_struct {
> +	struct percpu_ref users;	/* indicate and keep swap device valid. */
>  	unsigned long	flags;		/* SWP_USED etc: see above */
>  	signed short	prio;		/* swap priority of this type */
>  	struct plist_node list;		/* entry in swap_active_head */
> @@ -260,6 +260,7 @@ struct swap_info_struct {
>  	struct block_device *bdev;	/* swap device or bdev of swap file */
>  	struct file *swap_file;		/* seldom referenced */
>  	unsigned int old_block_size;	/* seldom referenced */
> +	struct completion comp;		/* seldom referenced */
>  #ifdef CONFIG_FRONTSWAP
>  	unsigned long *frontswap_map;	/* frontswap in-use, one bit per page */
>  	atomic_t frontswap_pages;	/* frontswap pages in-use counter */
> @@ -511,7 +512,7 @@ sector_t swap_page_sector(struct page *page);
>  
>  static inline void put_swap_device(struct swap_info_struct *si)
>  {
> -	rcu_read_unlock();
> +	percpu_ref_put(&si->users);
>  }
>  
>  #else /* CONFIG_SWAP */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 149e77454e3c..a640fc84be5b 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -39,6 +39,7 @@
>  #include <linux/export.h>
>  #include <linux/swap_slots.h>
>  #include <linux/sort.h>
> +#include <linux/completion.h>
>  
>  #include <asm/tlbflush.h>
>  #include <linux/swapops.h>
> @@ -511,6 +512,14 @@ static void swap_discard_work(struct work_struct *work)
>  	spin_unlock(&si->lock);
>  }
>  
> +static void swap_users_ref_free(struct percpu_ref *ref)
> +{
> +	struct swap_info_struct *si;
> +
> +	si = container_of(ref, struct swap_info_struct, users);
> +	complete(&si->comp);
> +}
> +
>  static void alloc_cluster(struct swap_info_struct *si, unsigned long idx)
>  {
>  	struct swap_cluster_info *ci = si->cluster_info;
> @@ -1270,18 +1279,12 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
>   * via preventing the swap device from being swapoff, until
>   * put_swap_device() is called.  Otherwise return NULL.
>   *
> - * The entirety of the RCU read critical section must come before the
> - * return from or after the call to synchronize_rcu() in
> - * enable_swap_info() or swapoff().  So if "si->flags & SWP_VALID" is
> - * true, the si->map, si->cluster_info, etc. must be valid in the
> - * critical section.
> - *
>   * Notice that swapoff or swapoff+swapon can still happen before the
> - * rcu_read_lock() in get_swap_device() or after the rcu_read_unlock()
> - * in put_swap_device() if there isn't any other way to prevent
> - * swapoff, such as page lock, page table lock, etc.  The caller must
> - * be prepared for that.  For example, the following situation is
> - * possible.
> + * percpu_ref_tryget_live() in get_swap_device() or after the
> + * percpu_ref_put() in put_swap_device() if there isn't any other way
> + * to prevent swapoff, such as page lock, page table lock, etc.  The
> + * caller must be prepared for that.  For example, the following
> + * situation is possible.
>   *
>   *   CPU1				CPU2
>   *   do_swap_page()
> @@ -1309,21 +1312,27 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
>  	si = swp_swap_info(entry);
>  	if (!si)
>  		goto bad_nofile;
> -
> -	rcu_read_lock();
> -	if (data_race(!(si->flags & SWP_VALID)))
> -		goto unlock_out;
> +	if (!percpu_ref_tryget_live(&si->users))
> +		goto out;
> +	/*
> +	 * Guarantee the si->users are checked before accessing other
> +	 * fields of swap_info_struct.
> +	 *
> +	 * Paired with the spin_unlock() after setup_swap_info() in
> +	 * enable_swap_info().
> +	 */
> +	smp_rmb();
>  	offset = swp_offset(entry);
>  	if (offset >= si->max)
> -		goto unlock_out;
> +		goto put_out;
>  
>  	return si;
>  bad_nofile:
>  	pr_err("%s: %s%08lx\n", __func__, Bad_file, entry.val);
>  out:
>  	return NULL;
> -unlock_out:
> -	rcu_read_unlock();
> +put_out:
> +	percpu_ref_put(&si->users);
>  	return NULL;
>  }
>  
> @@ -2466,7 +2475,7 @@ static void setup_swap_info(struct swap_info_struct *p, int prio,
>  
>  static void _enable_swap_info(struct swap_info_struct *p)
>  {
> -	p->flags |= SWP_WRITEOK | SWP_VALID;
> +	p->flags |= SWP_WRITEOK;
>  	atomic_long_add(p->pages, &nr_swap_pages);
>  	total_swap_pages += p->pages;
>  
> @@ -2497,10 +2506,9 @@ static void enable_swap_info(struct swap_info_struct *p, int prio,
>  	spin_unlock(&p->lock);
>  	spin_unlock(&swap_lock);
>  	/*
> -	 * Guarantee swap_map, cluster_info, etc. fields are valid
> -	 * between get/put_swap_device() if SWP_VALID bit is set
> +	 * Finished initialized swap device, now it's safe to reference it.

s/initialized/initializing/

Otherwise looks good to me!  Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

>  	 */
> -	synchronize_rcu();
> +	percpu_ref_resurrect(&p->users);
>  	spin_lock(&swap_lock);
>  	spin_lock(&p->lock);
>  	_enable_swap_info(p);
> @@ -2616,16 +2624,16 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  
>  	reenable_swap_slots_cache_unlock();
>  
> -	spin_lock(&swap_lock);
> -	spin_lock(&p->lock);
> -	p->flags &= ~SWP_VALID;		/* mark swap device as invalid */
> -	spin_unlock(&p->lock);
> -	spin_unlock(&swap_lock);
>  	/*
> -	 * wait for swap operations protected by get/put_swap_device()
> -	 * to complete
> +	 * Wait for swap operations protected by get/put_swap_device()
> +	 * to complete.
> +	 *
> +	 * We need synchronize_rcu() here to protect the accessing to
> +	 * the swap cache data structure.
>  	 */
> +	percpu_ref_kill(&p->users);
>  	synchronize_rcu();
> +	wait_for_completion(&p->comp);
>  
>  	flush_work(&p->discard_work);
>  
> @@ -2857,6 +2865,12 @@ static struct swap_info_struct *alloc_swap_info(void)
>  	if (!p)
>  		return ERR_PTR(-ENOMEM);
>  
> +	if (percpu_ref_init(&p->users, swap_users_ref_free,
> +			    PERCPU_REF_INIT_DEAD, GFP_KERNEL)) {
> +		kvfree(p);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
>  	spin_lock(&swap_lock);
>  	for (type = 0; type < nr_swapfiles; type++) {
>  		if (!(swap_info[type]->flags & SWP_USED))
> @@ -2864,6 +2878,7 @@ static struct swap_info_struct *alloc_swap_info(void)
>  	}
>  	if (type >= MAX_SWAPFILES) {
>  		spin_unlock(&swap_lock);
> +		percpu_ref_exit(&p->users);
>  		kvfree(p);
>  		return ERR_PTR(-EPERM);
>  	}
> @@ -2891,9 +2906,13 @@ static struct swap_info_struct *alloc_swap_info(void)
>  		plist_node_init(&p->avail_lists[i], 0);
>  	p->flags = SWP_USED;
>  	spin_unlock(&swap_lock);
> -	kvfree(defer);
> +	if (defer) {
> +		percpu_ref_exit(&defer->users);
> +		kvfree(defer);
> +	}
>  	spin_lock_init(&p->lock);
>  	spin_lock_init(&p->cont_lock);
> +	init_completion(&p->comp);
>  
>  	return p;
>  }
