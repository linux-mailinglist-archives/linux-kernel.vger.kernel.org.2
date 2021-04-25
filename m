Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2056F36A479
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 06:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhDYEVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 00:21:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:15603 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhDYEU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 00:20:59 -0400
IronPort-SDR: zVzHmtPfpiB852+CK+GSDrjJDdoob6fYlsAGGh7+tUBnGLP4kdqhCyRTrrlY0r6yVomTNIIw2b
 bxs/4FNtOt3w==
X-IronPort-AV: E=McAfee;i="6200,9189,9964"; a="193024389"
X-IronPort-AV: E=Sophos;i="5.82,249,1613462400"; 
   d="scan'208";a="193024389"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 21:20:20 -0700
IronPort-SDR: ym8i6ju2tJwF/ZR3B2VcI2uSfKn88r2osxdbyTNHkYF7bbyB0Tssbnf2Mfov/F4fTM5Pywopsp
 2mkKVVhlvOaw==
X-IronPort-AV: E=Sophos;i="5.82,249,1613462400"; 
   d="scan'208";a="428932092"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 21:20:15 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <shy828301@gmail.com>,
        <david@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v4 4/4] mm/shmem: fix shmem_swapin() race with swapoff
References: <20210425023806.3537283-1-linmiaohe@huawei.com>
        <20210425023806.3537283-5-linmiaohe@huawei.com>
        <87bla3xdt0.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <0213893e-2b05-8d2e-9a79-e8a71db23644@huawei.com>
Date:   Sun, 25 Apr 2021 12:20:13 +0800
In-Reply-To: <0213893e-2b05-8d2e-9a79-e8a71db23644@huawei.com> (Miaohe Lin's
        message of "Sun, 25 Apr 2021 11:33:42 +0800")
Message-ID: <87y2d7vvuq.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> On 2021/4/25 11:07, Huang, Ying wrote:
>> I think it's better to put_swap_device() just before returning from the
>> function.  It's not a big issue to slow down swapoff() a little.  And
>> this will make the logic easier to be understood.
>> 
>
> shmem_swapin_page() already has a methed, i.e. locked page, to prevent races. I was intended
> to not mix with that. But your suggestion is good as this will make the logic easier to be
> understood.
>
> Just to make sure, is this what you mean? Many thanks!

Yes.  Just a minor comment.

>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 26c76b13ad23..737e5b3200c3 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1696,6 +1696,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>         struct address_space *mapping = inode->i_mapping;
>         struct shmem_inode_info *info = SHMEM_I(inode);
>         struct mm_struct *charge_mm = vma ? vma->vm_mm : current->mm;
> +       struct swap_info_struct *si;
>         struct page *page;
>         swp_entry_t swap;
>         int error;
> @@ -1704,6 +1705,12 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>         swap = radix_to_swp_entry(*pagep);
>         *pagep = NULL;
>
> +       /* Prevent swapoff from happening to us. */
> +       si = get_swap_device(swap);
> +       if (unlikely(!si)) {

I don't think it's necessary to use unlikely() here.

Best Regards,
Huang, Ying

> +               error = EINVAL;
> +               goto failed;
> +       }
>         /* Look it up and read it in.. */
>         page = lookup_swap_cache(swap, NULL, 0);
>         if (!page) {
> @@ -1765,6 +1772,8 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>         swap_free(swap);
>
>         *pagep = page;
> +       if (si)
> +               put_swap_device(si);
>         return 0;
>  failed:
>         if (!shmem_confirm_swap(mapping, index, swap))
> @@ -1775,6 +1784,9 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>                 put_page(page);
>         }
>
> +       if (si)
> +               put_swap_device(si);
> +
>         return error;
>  }
>
>> Best Regards,
>> Huang, Ying
>> 
