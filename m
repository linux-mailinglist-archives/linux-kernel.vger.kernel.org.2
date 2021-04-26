Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A509736AA29
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 02:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhDZA4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 20:56:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:61330 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231247AbhDZA4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 20:56:48 -0400
IronPort-SDR: 6xtyxkuInOlL/96WVUjtr3A+ciUhCcpDsguufVkcBHX/nQQsd3WyLOreUdKaosSPvVb2zjqTGR
 POuDKekh+ZHQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="183398203"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="183398203"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 17:56:06 -0700
IronPort-SDR: O7fvrG/uZjaFVoQyOH5zf8WJ+n29SIr4OjZdnc0pILVRSO84WuMgdE3xXPqmvCK1cCUkBqVZGa
 YdL1K5IvJXeg==
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="422410038"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 17:56:02 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <shy828301@gmail.com>,
        <david@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v5 4/4] mm/shmem: fix shmem_swapin() race with swapoff
References: <20210425095419.3830298-1-linmiaohe@huawei.com>
        <20210425095419.3830298-5-linmiaohe@huawei.com>
Date:   Mon, 26 Apr 2021 08:56:00 +0800
In-Reply-To: <20210425095419.3830298-5-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Sun, 25 Apr 2021 17:54:19 +0800")
Message-ID: <87pmyhx3rz.fsf@yhuang6-desk1.ccr.corp.intel.com>
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
> CPU 1                                         CPU 2
> -----                                         -----
> shmem_swapin
>   swap_cluster_readahead
>     if (likely(si->flags & (SWP_BLKDEV | SWP_FS_OPS))) {
>                                               swapoff
>                                                 ..
>                                                 si->swap_file = NULL;
>                                                 ..
>     struct inode *inode = si->swap_file->f_mapping->host;[oops!]
>
> Close this race window by using get/put_swap_device() to guard against
> concurrent swapoff.
>
> Fixes: 8fd2e0b505d1 ("mm: swap: check if swap backing device is congested or not")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/shmem.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 26c76b13ad23..2dafd65b0b42 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1696,6 +1696,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>  	struct address_space *mapping = inode->i_mapping;
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	struct mm_struct *charge_mm = vma ? vma->vm_mm : current->mm;
> +	struct swap_info_struct *si;
>  	struct page *page;
>  	swp_entry_t swap;
>  	int error;
> @@ -1704,6 +1705,12 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>  	swap = radix_to_swp_entry(*pagep);
>  	*pagep = NULL;
>  
> +	/* Prevent swapoff from happening to us. */
> +	si = get_swap_device(swap);
> +	if (!si) {
> +		error = EINVAL;
> +		goto failed;
> +	}
>  	/* Look it up and read it in.. */
>  	page = lookup_swap_cache(swap, NULL, 0);
>  	if (!page) {
> @@ -1765,6 +1772,8 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>  	swap_free(swap);
>  
>  	*pagep = page;
> +	if (si)
> +		put_swap_device(si);
>  	return 0;
>  failed:
>  	if (!shmem_confirm_swap(mapping, index, swap))
> @@ -1775,6 +1784,9 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>  		put_page(page);
>  	}
>  
> +	if (si)
> +		put_swap_device(si);
> +
>  	return error;
>  }
