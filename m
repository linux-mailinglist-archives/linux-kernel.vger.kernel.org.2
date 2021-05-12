Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6EC37BC60
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhELMUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:20:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:35698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231540AbhELMUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:20:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620821981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kqxflV6XM/62poKNO3QyoeAtrChGAFFnXymEn3/2qWE=;
        b=qlLrFjaPeuo9/qukkcds0+FLMDCjWMVBspLQU6+CP7l9gcWE5zLmO7PMfYVHtyOGMarKDA
        33jZ0OfYZMsjdm+6sqvMcXGjL37UCBuMhYR8P8ILf47VryqvCpyMXLB0e4gFsUuWiPgJ/F
        nmkvd+Zv+L0oYGGnqP0tOu+GN2/75Mc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A40BEB0EA;
        Wed, 12 May 2021 12:19:41 +0000 (UTC)
Date:   Wed, 12 May 2021 14:19:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm,hwpoison: fix race with compound page
 allocation
Message-ID: <YJvH1IBcXIGcxLOY@dhcp22.suse.cz>
References: <20210511151016.2310627-1-nao.horiguchi@gmail.com>
 <20210511151016.2310627-2-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511151016.2310627-2-nao.horiguchi@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-05-21 00:10:15, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> When hugetlb page fault (under overcommiting situation) and
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
> one for memory error handling, which is wrong because there's time
> windows where compound pages have non-zero refcount during initialization.
> 
> So makes __get_hwpoison_page() check page status a bit more for a few
> types of compound pages. PageSlab() check is added because otherwise
> "non anonymous thp" path is wrongly chosen.

This should really describe the fix in more details. E.g.
[...]
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

So you do rely on PageCompound to be true. Which is prone to races as
well. All you need is to check before prep_compound_page and run into
get_page_unless_zero (down in this function) before hugetlb reaches
put_page_testzero. Or do I miss something that would prevent from that?
-- 
Michal Hocko
SUSE Labs
