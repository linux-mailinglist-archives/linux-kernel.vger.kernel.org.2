Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9ED36A455
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 05:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhDYDJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 23:09:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:45647 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhDYDJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 23:09:21 -0400
IronPort-SDR: XK6RLg1zf2azbmpfuXm8M4RlnY+3NoezAwOQAOORd8zh+AxiAUcjwpJhZrzNEvaV7VX8nN7k3e
 ubFPQEfs0yGw==
X-IronPort-AV: E=McAfee;i="6200,9189,9964"; a="194091140"
X-IronPort-AV: E=Sophos;i="5.82,249,1613462400"; 
   d="scan'208";a="194091140"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 20:08:41 -0700
IronPort-SDR: GCWUeG9Clk7R9Dj2RDIZI7NT3+JEbMA8vymVhE9MS6gCXx5KziMJmNb7rB0TyS6BHAUfBhLpOu
 s/f9SbKFXVbA==
X-IronPort-AV: E=Sophos;i="5.82,249,1613462400"; 
   d="scan'208";a="422203947"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 20:08:38 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <shy828301@gmail.com>,
        <david@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v4 2/4] swap: fix do_swap_page() race with swapoff
References: <20210425023806.3537283-1-linmiaohe@huawei.com>
        <20210425023806.3537283-3-linmiaohe@huawei.com>
Date:   Sun, 25 Apr 2021 11:08:36 +0800
In-Reply-To: <20210425023806.3537283-3-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Sun, 25 Apr 2021 10:38:04 +0800")
Message-ID: <877dkrxdqj.fsf@yhuang6-desk1.ccr.corp.intel.com>
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
>   if (data_race(si->flags & SWP_SYNCHRONOUS_IO)
>   swap_readpage
>     if (data_race(sis->flags & SWP_FS_OPS)) {
>                                         	swapoff
> 					  	  ..
> 					  	  p->swap_file = NULL;
> 					  	  ..
>     struct file *swap_file = sis->swap_file;
>     struct address_space *mapping = swap_file->f_mapping;[oops!]
>
> Note that for the pages that are swapped in through swap cache, this isn't
> an issue. Because the page is locked, and the swap entry will be marked
> with SWAP_HAS_CACHE, so swapoff() can not proceed until the page has been
> unlocked.
>
> Fix this race by using get/put_swap_device() to guard against concurrent
> swapoff.
>
> Fixes: 0bcac06f27d7 ("mm,swap: skip swapcache for swapin of synchronous device")
> Reported-by: kernel test robot <lkp@intel.com> (auto build test ERROR)
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Best Regards,
Huang, Ying

> ---
>  include/linux/swap.h |  9 +++++++++
>  mm/memory.c          | 11 +++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index c9e7fea10b83..46d51d058d05 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -527,6 +527,15 @@ static inline struct swap_info_struct *swp_swap_info(swp_entry_t entry)
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
> index 27014c3bde9f..39c910678387 100644
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
> @@ -3338,14 +3339,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
>  	swapcache = page;
>  
>  	if (!page) {
> -		struct swap_info_struct *si = swp_swap_info(entry);
> -
>  		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>  		    __swap_count(entry) == 1) {
>  			/* skip swapcache */
> @@ -3514,6 +3517,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  unlock:
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
>  out:
> +	if (si)
> +		put_swap_device(si);
>  	return ret;
>  out_nomap:
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
> @@ -3525,6 +3530,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		unlock_page(swapcache);
>  		put_page(swapcache);
>  	}
> +	if (si)
> +		put_swap_device(si);
>  	return ret;
>  }
