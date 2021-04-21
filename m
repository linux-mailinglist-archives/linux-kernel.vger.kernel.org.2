Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AEB366335
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 02:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhDUAzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 20:55:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:20914 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233879AbhDUAzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 20:55:32 -0400
IronPort-SDR: HjWHxHL2TeHK6bxqnO+VOQUDPMDnnhGiS1yc2srbKs/WmWZGirlPTNyXpcTfSXItgm3W7f1g0Y
 8AzfDhMkH+KQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="280950041"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="280950041"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 17:53:14 -0700
IronPort-SDR: vuoAgGJOiKXukaQlTtzHZ/Q2gJBD+wF/P20v3xuSrVlwliklefdMHTmVRnVc3ngGoW1ZCNX1q2
 ziLMTfIpybJA==
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="427311101"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 17:52:45 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <shy828301@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v3 2/4] swap: fix do_swap_page() race with swapoff
References: <20210420133048.6773-1-linmiaohe@huawei.com>
        <20210420133048.6773-3-linmiaohe@huawei.com>
Date:   Wed, 21 Apr 2021 08:52:43 +0800
In-Reply-To: <20210420133048.6773-3-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Tue, 20 Apr 2021 09:30:46 -0400")
Message-ID: <877dkw31d0.fsf@yhuang6-desk1.ccr.corp.intel.com>
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
> 					  	  p->flags &= ~SWP_VALID;
> 					  	  ..
> 					  	  synchronize_rcu();
> 					  	  ..

You have deleted SWP_VALID and RCU solution in 1/4, so please revise this.

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

This needs to be revised too.  Unless you squash 1/4 and 2/4.

> Fixes: 0bcac06f27d7 ("mm,swap: skip swapcache for swapin of synchronous device")
> Reported-by: kernel test robot <lkp@intel.com> (auto build test ERROR)
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/swap.h | 9 +++++++++
>  mm/memory.c          | 9 +++++++++
>  2 files changed, 18 insertions(+)
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

There's

		struct swap_info_struct *si = swp_swap_info(entry);

in do_swap_page(), you can remove that.

Best Regards,
Huang, Ying

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
