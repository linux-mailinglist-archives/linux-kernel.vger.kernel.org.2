Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4068136A456
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 05:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhDYDKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 23:10:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:39377 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229592AbhDYDKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 23:10:00 -0400
IronPort-SDR: J8Z8kVLYMGW/VcI1I9WB8uzQQj+9lKzjrSSR3vsQDZl1Nsuo6vXzPFvlkA1ZtsUuO4kLJBVz2v
 b6OzsmMXEAHQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9964"; a="260162110"
X-IronPort-AV: E=Sophos;i="5.82,249,1613462400"; 
   d="scan'208";a="260162110"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 20:09:20 -0700
IronPort-SDR: CRUydiyRZCcxxUktF8ALsPsp7pExL6AWNIFbr0n9Xys2yPdRlAXCsK4upUlRT0+jxSkeQEOgDZ
 9he9kPwURuvw==
X-IronPort-AV: E=Sophos;i="5.82,249,1613462400"; 
   d="scan'208";a="525371685"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 20:09:16 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <shy828301@gmail.com>,
        <david@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v4 3/4] mm/swap: remove confusing checking for
 non_swap_entry() in swap_ra_info()
References: <20210425023806.3537283-1-linmiaohe@huawei.com>
        <20210425023806.3537283-4-linmiaohe@huawei.com>
Date:   Sun, 25 Apr 2021 11:09:14 +0800
In-Reply-To: <20210425023806.3537283-4-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Sun, 25 Apr 2021 10:38:05 +0800")
Message-ID: <8735vfxdph.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> The non_swap_entry() was used for working with VMA based swap readahead
> via commit ec560175c0b6 ("mm, swap: VMA based swap readahead"). At that
> time, the non_swap_entry() checking is necessary because the function is
> called before checking that in do_swap_page(). Then it's moved to
> swap_ra_info() since commit eaf649ebc3ac ("mm: swap: clean up swap
> readahead"). After that, the non_swap_entry() checking is unnecessary,
> because swap_ra_info() is called after non_swap_entry() has been checked
> already. The resulting code is confusing as the non_swap_entry() check
> looks racy now because while we released the pte lock, somebody else might
> have faulted in this pte. So we should check whether it's swap pte first
> to guard against such race or swap_type will be unexpected. But the race
> isn't important because it will not cause problem. We would have enough
> checking when we really operate the PTE entries later. So we remove the
> non_swap_entry() check here to avoid confusion.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Best Regards,
Huang, Ying

> ---
>  mm/swap_state.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 272ea2108c9d..df5405384520 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -721,7 +721,6 @@ static void swap_ra_info(struct vm_fault *vmf,
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	unsigned long ra_val;
> -	swp_entry_t entry;
>  	unsigned long faddr, pfn, fpfn;
>  	unsigned long start, end;
>  	pte_t *pte, *orig_pte;
> @@ -739,11 +738,6 @@ static void swap_ra_info(struct vm_fault *vmf,
>  
>  	faddr = vmf->address;
>  	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
> -	entry = pte_to_swp_entry(*pte);
> -	if ((unlikely(non_swap_entry(entry)))) {
> -		pte_unmap(orig_pte);
> -		return;
> -	}
>  
>  	fpfn = PFN_DOWN(faddr);
>  	ra_val = GET_SWAP_RA_VAL(vma);
