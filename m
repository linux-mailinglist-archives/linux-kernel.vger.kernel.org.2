Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD38C36D3E0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbhD1IYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:24:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:39286 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231635AbhD1IYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:24:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31E57AF9C;
        Wed, 28 Apr 2021 08:23:53 +0000 (UTC)
Date:   Wed, 28 Apr 2021 10:23:49 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: [PATCH] mm,hwpoison: fix race with compound page allocation
Message-ID: <20210428082344.GA29213@linux>
References: <20210423080153.GA78658@hori.linux.bs1.fc.nec.co.jp>
 <20210428074654.GA2093897@u2004>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428074654.GA2093897@u2004>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 04:46:54PM +0900, Naoya Horiguchi wrote:
> ---
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Date: Wed, 28 Apr 2021 15:55:47 +0900
> Subject: [PATCH] mm,hwpoison: fix race with compound page allocation
> 
> When hugetlb page fault (under overcommiting situation) and memory_failure()
> race, VM_BUG_ON_PAGE() is triggered by the following race:
> 
>     CPU0:                           CPU1:
> 
>                                     gather_surplus_pages()
>                                       page = alloc_surplus_huge_page()
>     memory_failure_hugetlb()
>       get_hwpoison_page(page)
>         __get_hwpoison_page(page)
>           get_page_unless_zero(page)
>                                       zero = put_page_testzero(page)
>                                       VM_BUG_ON_PAGE(!zero, page)
>                                       enqueue_huge_page(h, page)
>       put_page(page)
> 
> __get_hwpoison_page() only checks page refcount before taking additional
> one for memory error handling, which is wrong because there's time
> windows where compound pages have non-zero refcount during initialization.
> 
> So makes __get_hwpoison_page() check more page status for a few types
> of compound pages. PageSlab() check is added because otherwise
> "non anonymous thp" path is wrongly chosen for slab pages.

Was it wrongly chosen even before? If so, maybe a Fix tag is warranted.

> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Reported-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memory-failure.c | 48 +++++++++++++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a3659619d293..61988e332712 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1095,30 +1095,36 @@ static int __get_hwpoison_page(struct page *page)

> +	if (PageCompound(page)) {
> +		if (PageSlab(page)) {
> +			return get_page_unless_zero(page);
> +		} else if (PageHuge(head)) {
> +			if (HPageFreed(head) || HPageMigratable(head))
> +				return get_page_unless_zero(head);

There were concerns raised wrt. memory-failure should not be fiddling with page's
refcount without holding a hugetlb lock.
So, if we really want to make this more stable, we might want to hold the lock
here.

The clearing and setting of HPageFreed happens under the lock, and for HPageMigratable
that is also true for the clearing part, so I think it would be more sane to do
this under the lock to close any possible race.

Does it make sense?

-- 
Oscar Salvador
SUSE L3
