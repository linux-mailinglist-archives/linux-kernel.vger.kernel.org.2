Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A4436633F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 02:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbhDUA6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 20:58:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:56948 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234601AbhDUA6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 20:58:45 -0400
IronPort-SDR: 9X1GO5nzFH8TSgRktsYv0wgENcshUR9G04y0VnzdaJQEC/FQe3H5mTuPl8M3b2CdR+uy7G5vUV
 2TT9Daz/3iUA==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="195176013"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="195176013"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 17:58:10 -0700
IronPort-SDR: q/pXegkeoB3Nibz1+jCT1mt/7nLI3QUPwzj5d5LEtYCiJDc6efVnJAgRFLx3AL7fL1YOgZK4iL
 qW0/WRm2Is+A==
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="427312591"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 17:58:06 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <shy828301@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v3 3/4] mm/swap: remove confusing checking for
 non_swap_entry() in swap_ra_info()
References: <20210420133048.6773-1-linmiaohe@huawei.com>
        <20210420133048.6773-4-linmiaohe@huawei.com>
Date:   Wed, 21 Apr 2021 08:58:04 +0800
In-Reply-To: <20210420133048.6773-4-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Tue, 20 Apr 2021 09:30:47 -0400")
Message-ID: <8735vk3143.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> The non_swap_entry() was used for working with VMA based swap readahead
> via commit ec560175c0b6 ("mm, swap: VMA based swap readahead").

At that time, the non_swap_entry() checking is necessary because the
function is called before checking that in do_swap_page().

> Then it's
> moved to swap_ra_info() since commit eaf649ebc3ac ("mm: swap: clean up swap
> readahead").

After that, the non_swap_entry() checking is unnecessary, because
swap_ra_info() is called after non_swap_entry() has been checked
already.  The resulting code is confusing.

> But this makes the code confusing. The non_swap_entry() check
> looks racy because while we released the pte lock, somebody else might have
> faulted in this pte. So we should check whether it's swap pte first to
> guard against such race or swap_type will be unexpected.

The race isn't important because it will not cause problem.

Best Regards,
Huang, Ying

> But the swap_entry
> isn't used in this function and we will have enough checking when we really
> operate the PTE entries later. So checking for non_swap_entry() is not
> really needed here and should be removed to avoid confusion.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
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
