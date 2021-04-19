Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B63E363987
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 04:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhDSCzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 22:55:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:55258 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhDSCzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 22:55:04 -0400
IronPort-SDR: CME6AwAlVCvo4gr90hMIMlB9cDSR5dh4J3ZmjzxKOB5VC6ljXWmdPONjDDuEWCyvF+wwc1glz+
 6OBkiIQx5AbA==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="192071066"
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="192071066"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2021 19:54:34 -0700
IronPort-SDR: eAzKJsHcHzyNdV5oBsYqLNL0tkbWI3w8Zv77hHvCohRtf/KK6AxZxuyTxFPWfsxV29YBauFXw3
 cK2WURUxjbfw==
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="419831701"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2021 19:54:31 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <david@redhat.com>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v2 2/5] mm/swapfile: use percpu_ref to serialize against
 concurrent swapoff
References: <20210417094039.51711-1-linmiaohe@huawei.com>
        <20210417094039.51711-3-linmiaohe@huawei.com>
Date:   Mon, 19 Apr 2021 10:54:29 +0800
In-Reply-To: <20210417094039.51711-3-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Sat, 17 Apr 2021 05:40:36 -0400")
Message-ID: <87a6pvkmqi.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> Use percpu_ref to serialize against concurrent swapoff. Also remove the
> SWP_VALID flag because it's used together with RCU solution.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/swap.h |  3 +--
>  mm/swapfile.c        | 43 +++++++++++++++++--------------------------
>  2 files changed, 18 insertions(+), 28 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 8be36eb58b7a..993693b38109 100644
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
> @@ -514,7 +513,7 @@ sector_t swap_page_sector(struct page *page);
>  
>  static inline void put_swap_device(struct swap_info_struct *si)
>  {
> -	rcu_read_unlock();
> +	percpu_ref_put(&si->users);
>  }
>  
>  #else /* CONFIG_SWAP */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 66515a3a2824..90e197bc2eeb 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1279,18 +1279,12 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
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
> @@ -1318,21 +1312,24 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
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
> +	 * Guarantee we will not reference uninitialized fields
> +	 * of swap_info_struct.
> +	 */

/*
 * Guarantee the si->users are checked before accessing other fields of
 * swap_info_struct.
*/

> +	smp_rmb();

Usually, smp_rmb() need to be paired with smp_wmb().  Some comments are
needed for that.  Here smb_rmb() is paired with the spin_unlock() after
setup_swap_info() in enable_swap_info().

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
> @@ -2475,7 +2472,7 @@ static void setup_swap_info(struct swap_info_struct *p, int prio,
>  
>  static void _enable_swap_info(struct swap_info_struct *p)
>  {
> -	p->flags |= SWP_WRITEOK | SWP_VALID;
> +	p->flags |= SWP_WRITEOK;
>  	atomic_long_add(p->pages, &nr_swap_pages);
>  	total_swap_pages += p->pages;
>  
> @@ -2507,7 +2504,7 @@ static void enable_swap_info(struct swap_info_struct *p, int prio,
>  	spin_unlock(&swap_lock);
>  	/*
>  	 * Guarantee swap_map, cluster_info, etc. fields are valid
> -	 * between get/put_swap_device() if SWP_VALID bit is set
> +	 * between get/put_swap_device().
>  	 */

The comments need to be revised.  Something likes below?

/* Finished initialized swap device, now it's safe to reference it */

Best Regards,
Huang, Ying

>  	percpu_ref_resurrect(&p->users);
>  	spin_lock(&swap_lock);
> @@ -2625,12 +2622,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  
>  	reenable_swap_slots_cache_unlock();
>  
> -	spin_lock(&swap_lock);
> -	spin_lock(&p->lock);
> -	p->flags &= ~SWP_VALID;		/* mark swap device as invalid */
> -	spin_unlock(&p->lock);
> -	spin_unlock(&swap_lock);
> -
>  	percpu_ref_kill(&p->users);
>  	/*
>  	 * We need synchronize_rcu() here to protect the accessing
