Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3014335D4DC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 03:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245212AbhDMBeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 21:34:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:12986 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240410AbhDMBeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 21:34:06 -0400
IronPort-SDR: xriSWE7X+l81K39k/JdOQdTrIypVQtJJwqHl7DCknnb8tC78ih3qmtDrM+RJ7n7xCJx8gM9Xew
 86TUuxCpwhGw==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="255638438"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="255638438"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 18:33:46 -0700
IronPort-SDR: V+KbEoJUqwsneLAH9VH89rfVsf/Uhl9NaAxRjjUEWOfN0vy1NAvE2WdOJLzodsBna4aeGc5PvU
 P/F7QieILvaQ==
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="424042790"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 18:33:43 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>, <vbabka@suse.cz>,
        <alex.shi@linux.alibaba.com>, <willy@infradead.org>,
        <minchan@kernel.org>, <richard.weiyang@gmail.com>,
        <hughd@google.com>, <tim.c.chen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 3/5] mm/swap_state: fix get_shadow_from_swap_cache()
 race with swapoff
References: <20210408130820.48233-1-linmiaohe@huawei.com>
        <20210408130820.48233-4-linmiaohe@huawei.com>
Date:   Tue, 13 Apr 2021 09:33:41 +0800
In-Reply-To: <20210408130820.48233-4-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Thu, 8 Apr 2021 09:08:18 -0400")
Message-ID: <87im4rufwq.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> The function get_shadow_from_swap_cache() can race with swapoff, though
> it's only called by do_swap_page() now.
>
> Fixes: aae466b0052e ("mm/swap: implement workingset detection for anonymous LRU")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

This is unnecessary.  The only caller has guaranteed the swap device
from swapoff.

Best Regards,
Huang, Ying

> ---
>  mm/swap_state.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 272ea2108c9d..709c260d644a 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -83,11 +83,14 @@ void show_swap_cache_info(void)
>  
>  void *get_shadow_from_swap_cache(swp_entry_t entry)
>  {
> -	struct address_space *address_space = swap_address_space(entry);
> -	pgoff_t idx = swp_offset(entry);
> +	struct swap_info_struct *si;
>  	struct page *page;
>  
> -	page = xa_load(&address_space->i_pages, idx);
> +	si = get_swap_device(entry);
> +	if (!si)
> +		return NULL;
> +	page = xa_load(&swap_address_space(entry)->i_pages, swp_offset(entry));
> +	put_swap_device(si);
>  	if (xa_is_value(page))
>  		return page;
>  	return NULL;
