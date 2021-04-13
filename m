Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F8435D4CE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 03:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbhDMB1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 21:27:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:3028 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237080AbhDMB1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 21:27:52 -0400
IronPort-SDR: oarlFEOgE/Wl4aXkyADnwTm10sYT6+xy6PsNeP9n8mZpiHmKid17Fxu2GvZxkPsOZQ8ymXNFFg
 Uxm16i193rSw==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="279617814"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="279617814"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 18:27:32 -0700
IronPort-SDR: 4bK8dtNIYAcL5D0+3xpb3eoVaW2oN7QyDqGY9Fcy+bUjAt+5yF+e0ZFlbpo3lxGBiyJXdvY6xC
 m0mXSysFT/CQ==
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="424041399"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 18:27:27 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>, <vbabka@suse.cz>,
        <alex.shi@linux.alibaba.com>, <willy@infradead.org>,
        <minchan@kernel.org>, <richard.weiyang@gmail.com>,
        <hughd@google.com>, <tim.c.chen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 2/5] swap: fix do_swap_page() race with swapoff
References: <20210408130820.48233-1-linmiaohe@huawei.com>
        <20210408130820.48233-3-linmiaohe@huawei.com>
Date:   Tue, 13 Apr 2021 09:27:25 +0800
In-Reply-To: <20210408130820.48233-3-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Thu, 8 Apr 2021 09:08:17 -0400")
Message-ID: <87o8ejug76.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> When I was investigating the swap code, I found the below possible race
> window:
>
> CPU 1					CPU 2
> -----					-----
> do_swap_page
>   synchronous swap_readpage
>     alloc_page_vma
> 					swapoff
> 					  release swap_file, bdev, or ...
>       swap_readpage
> 	check sis->flags is ok
> 	  access swap_file, bdev...[oops!]
> 					    si->flags = 0
>
> Using current get/put_swap_device() to guard against concurrent swapoff for
> swap_readpage() looks terrible because swap_readpage() may take really long
> time. And this race may not be really pernicious because swapoff is usually
> done when system shutdown only. To reduce the performance overhead on the
> hot-path as much as possible, it appears we can use the percpu_ref to close
> this race window(as suggested by Huang, Ying).
>
> Fixes: 235b62176712 ("mm/swap: add cluster lock")

This isn't the commit that introduces the race.  You can use `git blame`
find out the correct commit.  For this it's commit 0bcac06f27d7 "mm,
swap: skip swapcache for swapin of synchronous device".

And I suggest to merge 1/5 and 2/5 to make it easy to get the full
picture.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/swap.h |  2 +-
>  mm/memory.c          | 10 ++++++++++
>  mm/swapfile.c        | 28 +++++++++++-----------------
>  3 files changed, 22 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 849ba5265c11..9066addb57fd 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -513,7 +513,7 @@ sector_t swap_page_sector(struct page *page);
>  
>  static inline void put_swap_device(struct swap_info_struct *si)
>  {
> -	rcu_read_unlock();
> +	percpu_ref_put(&si->users);
>  }
>  
>  #else /* CONFIG_SWAP */
> diff --git a/mm/memory.c b/mm/memory.c
> index cc71a445c76c..8543c47b955c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3311,6 +3311,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct page *page = NULL, *swapcache;
> +	struct swap_info_struct *si = NULL;
>  	swp_entry_t entry;
>  	pte_t pte;
>  	int locked;
> @@ -3339,6 +3340,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	}
>  
>

I suggest to add comments here as follows (words copy from Matthew Wilcox)

	/* Prevent swapoff from happening to us */

> +	si = get_swap_device(entry);
> +	/* In case we raced with swapoff. */
> +	if (unlikely(!si))
> +		goto out;
> +

Because we wrap the whole do_swap_page() with get/put_swap_device()
now.  We can remove several get/put_swap_device() for function called by
do_swap_page().  That can be another optimization patch.

>  	delayacct_set_flag(DELAYACCT_PF_SWAPIN);
>  	page = lookup_swap_cache(entry, vma, vmf->address);
>  	swapcache = page;
> @@ -3514,6 +3520,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  unlock:
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
>  out:
> +	if (si)
> +		put_swap_device(si);
>  	return ret;
>  out_nomap:
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
> @@ -3525,6 +3533,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		unlock_page(swapcache);
>  		put_page(swapcache);
>  	}
> +	if (si)
> +		put_swap_device(si);
>  	return ret;
>  }
>  
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 724173cd7d0c..01032c72ceae 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1280,18 +1280,12 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
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
> @@ -1319,21 +1313,21 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
>  	si = swp_swap_info(entry);
>  	if (!si)
>  		goto bad_nofile;
> -
> -	rcu_read_lock();
>  	if (data_race(!(si->flags & SWP_VALID)))

We can delete SWP_VALID, that is used together with RCU solution.

> -		goto unlock_out;
> +		goto out;
> +	if (!percpu_ref_tryget_live(&si->users))
> +		goto out;
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

Best Regards,
Huang, Ying
