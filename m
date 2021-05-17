Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDE3382993
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbhEQKOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:14:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:46932 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236275AbhEQKOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:14:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 023B6ADF1;
        Mon, 17 May 2021 10:12:55 +0000 (UTC)
Date:   Mon, 17 May 2021 12:12:50 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm,hwpoison: fix race with compound page
 allocation
Message-ID: <20210517101239.GA21612@linux>
References: <20210517045401.2506032-1-nao.horiguchi@gmail.com>
 <20210517045401.2506032-2-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517045401.2506032-2-nao.horiguchi@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 01:54:00PM +0900, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> When hugetlb page fault (under overcommitting situation) and
> memory_failure() race, VM_BUG_ON_PAGE() is triggered by the following race:
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
                                  ^^ the?                      ^^ an
> one for memory error handling, which is wrong because there's a time
> window where compound pages have non-zero refcount during initialization.
> 
> So makes __get_hwpoison_page() check page status a bit more for a few
     ^^ make
> types of compound pages. PageSlab() check is added because otherwise
> "non anonymous thp" path is wrongly chosen.

This is no longer true with this patch, is it? What happened here?

>  static int __get_hwpoison_page(struct page *page)
>  {
>  	struct page *head = compound_head(page);
> +	int ret = 0;
> +
> +#ifdef CONFIG_HUGETLB_PAGE
> +	spin_lock(&hugetlb_lock);
> +	if (PageHuge(head) && (HPageFreed(head) || HPageMigratable(head)))
> +		ret = get_page_unless_zero(head);
> +	spin_unlock(&hugetlb_lock);
> +	if (ret > 0)
> +		return ret;
> +#endif

I am kind of fine with this, but I wonder whether it makes sense to hide this
details into helper (with an empty stub for non-hugetlb pages)?

>  	if (!PageHuge(head) && PageTransHuge(head)) {
This !PageHuge could go?


-- 
Oscar Salvador
SUSE L3
