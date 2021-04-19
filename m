Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B6B36395F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 04:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbhDSCYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 22:24:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:40297 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232186AbhDSCYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 22:24:34 -0400
IronPort-SDR: ZoL0MoyYK3RUgheuV/CIF8wHbg76gVZSXmiEwapoztTgdjJ/QluZgrWwho3JaqX6DjBK7Fb8Xl
 GokNy12hzxZw==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="256568650"
X-IronPort-AV: E=Sophos;i="5.82,232,1613462400"; 
   d="scan'208";a="256568650"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2021 19:24:05 -0700
IronPort-SDR: E2tx3KbQIVp4eQDaF/1C81uzKqFwF3rgmB5bbYuJmKs739v2n5aEFQ0H3Et2HtNjIiYUmSZXeJ
 Ld9oLPG5XsmA==
X-IronPort-AV: E=Sophos;i="5.82,232,1613462400"; 
   d="scan'208";a="400480351"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2021 19:24:01 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <david@redhat.com>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v2 3/5] swap: fix do_swap_page() race with swapoff
References: <20210417094039.51711-1-linmiaohe@huawei.com>
        <20210417094039.51711-4-linmiaohe@huawei.com>
Date:   Mon, 19 Apr 2021 10:23:59 +0800
In-Reply-To: <20210417094039.51711-4-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Sat, 17 Apr 2021 05:40:37 -0400")
Message-ID: <87k0ozko5c.fsf@yhuang6-desk1.ccr.corp.intel.com>
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
> CPU 1                                   	CPU 2
> -----                                   	-----
> do_swap_page

This is OK for swap cache cases.  So

  if (data_race(si->flags & SWP_SYNCHRONOUS_IO))

should be shown here.

>   swap_readpage(skip swap cache case)
>     if (data_race(sis->flags & SWP_FS_OPS)) {
>                                         	swapoff
> 					  	  p->flags = &= ~SWP_VALID;
> 					  	  ..
> 					  	  synchronize_rcu();
> 					  	  ..
> 					  	  p->swap_file = NULL;
>     struct file *swap_file = sis->swap_file;
>     struct address_space *mapping = swap_file->f_mapping;[oops!]
>
> Note that for the pages that are swapped in through swap cache, this isn't
> an issue. Because the page is locked, and the swap entry will be marked
> with SWAP_HAS_CACHE, so swapoff() can not proceed until the page has been
> unlocked.
>
> Using current get/put_swap_device() to guard against concurrent swapoff for
> swap_readpage() looks terrible because swap_readpage() may take really long
> time. And this race may not be really pernicious because swapoff is usually
> done when system shutdown only. To reduce the performance overhead on the
> hot-path as much as possible, it appears we can use the percpu_ref to close
> this race window(as suggested by Huang, Ying).

I still suggest to squash PATCH 1-3, at least PATCH 1-2.  That will
change the relevant code together and make it easier to review.

Best Regards,
Huang, Ying

> Fixes: 0bcac06f27d7 ("mm,swap: skip swapcache for swapin of synchronous device")
> Reported-by: kernel test robot <lkp@intel.com> (auto build test ERROR)
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/swap.h | 9 +++++++++
>  mm/memory.c          | 9 +++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 993693b38109..523c2411a135 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -528,6 +528,15 @@ static inline struct swap_info_struct *swp_swap_info(swp_entry_t entry)
>  	return NULL;
>  }
>  
> +static inline struct swap_info_struct *get_swap_device(swp_entry_t entry)
> +{
> +	return NULL;
> +}
> +
> +static inline void put_swap_device(struct swap_info_struct *si)
> +{
> +}
> +
>  #define swap_address_space(entry)		(NULL)
>  #define get_nr_swap_pages()			0L
>  #define total_swap_pages			0L
> diff --git a/mm/memory.c b/mm/memory.c
> index 27014c3bde9f..7a2fe12cf641 100644
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
> @@ -3338,6 +3339,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		goto out;
>  	}
>  
> +	/* Prevent swapoff from happening to us. */
> +	si = get_swap_device(entry);
> +	if (unlikely(!si))
> +		goto out;
>  
>  	delayacct_set_flag(current, DELAYACCT_PF_SWAPIN);
>  	page = lookup_swap_cache(entry, vma, vmf->address);
> @@ -3514,6 +3519,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  unlock:
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
>  out:
> +	if (si)
> +		put_swap_device(si);
>  	return ret;
>  out_nomap:
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
> @@ -3525,6 +3532,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		unlock_page(swapcache);
>  		put_page(swapcache);
>  	}
> +	if (si)
> +		put_swap_device(si);
>  	return ret;
>  }
