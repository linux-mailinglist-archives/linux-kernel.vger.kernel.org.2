Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FA535B8F0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 05:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbhDLDbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 23:31:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:53566 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235366AbhDLDbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 23:31:37 -0400
IronPort-SDR: 0ukDDaNAh/+Y0Hy07hI2q/KgUptjSWq/Y2JE/YXwh4fkiLm0EXnUVcONI1VvIIt0k57/V4kd5B
 vOoosKpolrig==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="194214130"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="194214130"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 20:30:59 -0700
IronPort-SDR: Q8HjgPHaqEtlpMrqQfI0O8jMEibBYK91zautCNPZK5d813piMOSSX4qc52aBx/fODeBBs7F4Ye
 mfNIg232OR6w==
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="423611895"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 20:30:56 -0700
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
Date:   Mon, 12 Apr 2021 11:30:54 +0800
In-Reply-To: <20210408130820.48233-2-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Thu, 8 Apr 2021 09:08:16 -0400")
Message-ID: <87fszww55d.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> We will use percpu-refcount to serialize against concurrent swapoff. This
> patch adds the percpu_ref support for later fixup.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/swap.h |  2 ++
>  mm/swapfile.c        | 25 ++++++++++++++++++++++---
>  2 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 144727041e78..849ba5265c11 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -240,6 +240,7 @@ struct swap_cluster_list {
>   * The in-memory structure used to track swap areas.
>   */
>  struct swap_info_struct {
> +	struct percpu_ref users;	/* serialization against concurrent swapoff */
>  	unsigned long	flags;		/* SWP_USED etc: see above */
>  	signed short	prio;		/* swap priority of this type */
>  	struct plist_node list;		/* entry in swap_active_head */
> @@ -260,6 +261,7 @@ struct swap_info_struct {
>  	struct block_device *bdev;	/* swap device or bdev of swap file */
>  	struct file *swap_file;		/* seldom referenced */
>  	unsigned int old_block_size;	/* seldom referenced */
> +	struct completion comp;		/* seldom referenced */
>  #ifdef CONFIG_FRONTSWAP
>  	unsigned long *frontswap_map;	/* frontswap in-use, one bit per page */
>  	atomic_t frontswap_pages;	/* frontswap pages in-use counter */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 149e77454e3c..724173cd7d0c 100644
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
> @@ -511,6 +512,15 @@ static void swap_discard_work(struct work_struct *work)
>  	spin_unlock(&si->lock);
>  }
>  
> +static void swap_users_ref_free(struct percpu_ref *ref)
> +{
> +	struct swap_info_struct *si;
> +
> +	si = container_of(ref, struct swap_info_struct, users);
> +	complete(&si->comp);
> +	percpu_ref_exit(&si->users);

Because percpu_ref_exit() is used, we cannot use percpu_ref_tryget() in
get_swap_device(), better to add comments there.

> +}
> +
>  static void alloc_cluster(struct swap_info_struct *si, unsigned long idx)
>  {
>  	struct swap_cluster_info *ci = si->cluster_info;
> @@ -2500,7 +2510,7 @@ static void enable_swap_info(struct swap_info_struct *p, int prio,
>  	 * Guarantee swap_map, cluster_info, etc. fields are valid
>  	 * between get/put_swap_device() if SWP_VALID bit is set
>  	 */
> -	synchronize_rcu();
> +	percpu_ref_reinit(&p->users);

Although the effect is same, I think it's better to use
percpu_ref_resurrect() here to improve code readability.

>  	spin_lock(&swap_lock);
>  	spin_lock(&p->lock);
>  	_enable_swap_info(p);
> @@ -2621,11 +2631,13 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  	p->flags &= ~SWP_VALID;		/* mark swap device as invalid */
>  	spin_unlock(&p->lock);
>  	spin_unlock(&swap_lock);
> +
> +	percpu_ref_kill(&p->users);
>  	/*
>  	 * wait for swap operations protected by get/put_swap_device()
>  	 * to complete
>  	 */
> -	synchronize_rcu();
> +	wait_for_completion(&p->comp);

Better to move percpu_ref_kill() after the comments.  And maybe revise
the comments.

>  
>  	flush_work(&p->discard_work);
>  
> @@ -3132,7 +3144,7 @@ static bool swap_discardable(struct swap_info_struct *si)
>  SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  {
>  	struct swap_info_struct *p;
> -	struct filename *name;
> +	struct filename *name = NULL;
>  	struct file *swap_file = NULL;
>  	struct address_space *mapping;
>  	int prio;
> @@ -3163,6 +3175,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  
>  	INIT_WORK(&p->discard_work, swap_discard_work);
>  
> +	init_completion(&p->comp);
> +	error = percpu_ref_init(&p->users, swap_users_ref_free,
> +				PERCPU_REF_INIT_DEAD, GFP_KERNEL);
> +	if (unlikely(error))
> +		goto bad_swap;
> +
>  	name = getname(specialfile);
>  	if (IS_ERR(name)) {
>  		error = PTR_ERR(name);
> @@ -3356,6 +3374,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  bad_swap_unlock_inode:
>  	inode_unlock(inode);
>  bad_swap:
> +	percpu_ref_exit(&p->users);

Usually the resource freeing order matches their allocating order
reversely.  So, if there's no special reason, please follow that rule.

Best Regards,
Huang, Ying

>  	free_percpu(p->percpu_cluster);
>  	p->percpu_cluster = NULL;
>  	free_percpu(p->cluster_next_cpu);
