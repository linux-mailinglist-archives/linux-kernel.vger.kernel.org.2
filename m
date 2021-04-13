Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E0335D4E1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 03:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240654AbhDMBg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 21:36:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:31488 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239217AbhDMBg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 21:36:28 -0400
IronPort-SDR: Ks0mNFRqGQZmpFyxEOl2Z5y1JGtX5HLC+GQEeVxxYk/QpbdjfqDHx6kK6o7lq0iUEFNy3WffUi
 rSRjbpmeacuQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="193875059"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="193875059"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 18:36:08 -0700
IronPort-SDR: zRlTi4pzNrHKsmZ1fcfAtAzWVA3jCcJG8g9hFVnAJVpg7onB/ZJS3Ep7RWTCBa6g8uZXCUGAey
 ojf9Jh8O6dpA==
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="460397719"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 18:36:04 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>, <vbabka@suse.cz>,
        <alex.shi@linux.alibaba.com>, <willy@infradead.org>,
        <minchan@kernel.org>, <richard.weiyang@gmail.com>,
        <hughd@google.com>, <tim.c.chen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 5/5] mm/swap_state: fix swap_cluster_readahead() race
 with swapoff
References: <20210408130820.48233-1-linmiaohe@huawei.com>
        <20210408130820.48233-6-linmiaohe@huawei.com>
Date:   Tue, 13 Apr 2021 09:36:02 +0800
In-Reply-To: <20210408130820.48233-6-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Thu, 8 Apr 2021 09:08:20 -0400")
Message-ID: <87eeffufst.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> swap_cluster_readahead() could race with swapoff and might dereference
> si->swap_file after it's released by swapoff. Close this race window by
> using get/put_swap_device() pair.

I think we should fix the callers instead to reduce the overhead.  Now,
do_swap_page() has been fixed.  We need to fix shmem_swapin().

Best Regards,
Huang, Ying

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/swap_state.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 3bf0d0c297bc..eba6b0cf6cf9 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -626,12 +626,17 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  	unsigned long offset = entry_offset;
>  	unsigned long start_offset, end_offset;
>  	unsigned long mask;
> -	struct swap_info_struct *si = swp_swap_info(entry);
> +	struct swap_info_struct *si;
>  	struct blk_plug plug;
>  	bool do_poll = true, page_allocated;
>  	struct vm_area_struct *vma = vmf->vma;
>  	unsigned long addr = vmf->address;
>  
> +	si = get_swap_device(entry);
> +	/* In case we raced with swapoff. */
> +	if (!si)
> +		return NULL;
> +
>  	mask = swapin_nr_pages(offset) - 1;
>  	if (!mask)
>  		goto skip;
> @@ -673,7 +678,9 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  
>  	lru_add_drain();	/* Push any new pages onto the LRU now */
>  skip:
> -	return read_swap_cache_async(entry, gfp_mask, vma, addr, do_poll);
> +	page = read_swap_cache_async(entry, gfp_mask, vma, addr, do_poll);
> +	put_swap_device(si);
> +	return page;
>  }
>  
>  int init_swap_address_space(unsigned int type, unsigned long nr_pages)
