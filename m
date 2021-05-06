Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3858937511C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 10:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhEFIwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 04:52:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:47532 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233464AbhEFIwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 04:52:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C5426AC47;
        Thu,  6 May 2021 08:51:35 +0000 (UTC)
Date:   Thu, 6 May 2021 10:51:33 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm,hwpoison: fix race with compound page allocation
Message-ID: <YJOuFeteYQEPY9WF@localhost.localdomain>
References: <20210423080153.GA78658@hori.linux.bs1.fc.nec.co.jp>
 <20210428074654.GA2093897@u2004>
 <20210428082344.GA29213@linux>
 <20210428091835.GA273940@hori.linux.bs1.fc.nec.co.jp>
 <20210506013122.GA2240524@u2004>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506013122.GA2240524@u2004>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 10:31:22AM +0900, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Date: Thu, 6 May 2021 09:54:39 +0900
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
> "non anonymous thp" path is wrongly chosen.
> 
> Fixes: ead07f6a867b ("mm/memory-failure: introduce get_hwpoison_page() for consistent refcount handling")
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Reported-by: Muchun Song <songmuchun@bytedance.com>
> Cc: stable@vger.kernel.org # 5.12+

Hi Naoya, 

thanks for the patch.
I have some concerns though, more below:

> ---
>  mm/memory-failure.c | 53 +++++++++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a3659619d293..966a1d6b0bc8 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1095,30 +1095,41 @@ static int __get_hwpoison_page(struct page *page)
>  {
>  	struct page *head = compound_head(page);
>  
> -	if (!PageHuge(head) && PageTransHuge(head)) {
> -		/*
> -		 * Non anonymous thp exists only in allocation/free time. We
> -		 * can't handle such a case correctly, so let's give it up.
> -		 * This should be better than triggering BUG_ON when kernel
> -		 * tries to touch the "partially handled" page.
> -		 */
> -		if (!PageAnon(head)) {
> -			pr_err("Memory failure: %#lx: non anonymous thp\n",
> -				page_to_pfn(page));
> -			return 0;
> +	if (PageCompound(page)) {
> +		if (PageSlab(page)) {
> +			return get_page_unless_zero(page);
> +		} else if (PageHuge(head)) {
> +			int ret = 0;
> +
> +			spin_lock(&hugetlb_lock);
> +			if (HPageFreed(head) || HPageMigratable(head))
> +				ret = get_page_unless_zero(head);
> +			spin_unlock(&hugetlb_lock);
> +			return ret;

Ok, I am probably overthinking this but should we re-check under the
lock wehther the page is a hugetlb page?
My concern is, what would happen if:

CPU0                                          CPU1
 __get_hwpoison_page                          
  PageHuge(head) == T                         
                                              dissolve hugetlb page
   hugetlb_lock                               


In that case, by the time we get to check hugetlb flags, those checks
might return false, and we do not get a refcount.
So, I guess my question is: Should we re-check under the lock, and if it
is not, do a "goto try_to_get_ref" that starts right at the beginning,
or goes directly to the get_page_unless_zero at the end (the former
probably better)?

As I said, I might be overthinking this, but well.

-- 
Oscar Salvador
SUSE L3
