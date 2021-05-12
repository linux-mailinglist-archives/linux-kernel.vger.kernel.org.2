Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83B937B812
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 10:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhELIei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:34:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:59100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230211AbhELIeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:34:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD62FAFA9;
        Wed, 12 May 2021 08:33:28 +0000 (UTC)
Date:   Wed, 12 May 2021 10:33:24 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm,hwpoison: fix race with compound page
 allocation
Message-ID: <20210512083319.GA14726@linux>
References: <20210511151016.2310627-1-nao.horiguchi@gmail.com>
 <20210511151016.2310627-2-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511151016.2310627-2-nao.horiguchi@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 12:10:15AM +0900, Naoya Horiguchi wrote:
> @@ -1095,30 +1095,43 @@ static int __get_hwpoison_page(struct page *page)
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
> +			if (!PageHuge(head))
> +				ret = -EBUSY;
> +			else if (HPageFreed(head) || HPageMigratable(head))
> +				ret = get_page_unless_zero(head);
> +			spin_unlock(&hugetlb_lock);
> +			return ret;

Uhm, I am having a hard time with that -EBUSY.
At this stage, we expect __get_hwpoison_page() to either return true or false,
depending on whether it could grab a page's refcount or not. Returning -EBUSY
here seems wrong (plus it is inconsistent with the comment above the function).
It might be useful for the latter patch, I do not know as I yet have to check
that one, but if anything, let us stay consistent here in this one.
So, if hugetlb vanished under us, let us return "we could not grab the
refcount". Does it make sense?

-- 
Oscar Salvador
SUSE L3
