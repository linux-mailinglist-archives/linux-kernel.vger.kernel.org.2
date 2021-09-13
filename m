Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92E1408ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 14:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239887AbhIMMOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 08:14:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54400 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbhIMMOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 08:14:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7E34321F92;
        Mon, 13 Sep 2021 12:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631535180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zzVUxmb5DpJSe2zaB7Ppa7a2SNgZQz8/SnCpXyr+Mx0=;
        b=QtDHPwuc2qRw9wHW5wjLVix9W0ABTmUWUVAH8lsvMWuoFPPWqEKW7LPOtIur2IouXcwRm/
        aPBxBO/jLfvTFg6LBiZ7wvCrsiJacP3ndM7SvXWxWUu4Wwbm3GXwW2ZMbauzWRClW5wjYl
        +F96piuQ5EdDMZ1c/QT+aJXpmXd7UBY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5095AA3B93;
        Mon, 13 Sep 2021 12:13:00 +0000 (UTC)
Date:   Mon, 13 Sep 2021 14:12:59 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix potential missing call to
 unset_migratetype_isolate()
Message-ID: <YT9AS6I1Th14mCxh@dhcp22.suse.cz>
References: <20210913115125.33617-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913115125.33617-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 13-09-21 19:51:25, Miaohe Lin wrote:
> In start_isolate_page_range() undo path, pfn_to_online_page() just checks
> the first pfn in a pageblock while __first_valid_page() will traverse the
> pageblock until the first online pfn is found. So we may miss the call to
> unset_migratetype_isolate() in undo path and pages will remain isolated
> unexpectedly. Fix this by calling undo_isolate_page_range() and this will
> also help to simplify the code further.

I like the clean up part but is this a real problem that requires CC
stable? Have you ever seen this to be a real problem? It looks like
something based on reading the code.

> Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: <stable@vger.kernel.org>
> ---
> v1->v2:
>   Simplify the code further per David Hildenbrand.
> ---
>  mm/page_isolation.c | 20 +++-----------------
>  1 file changed, 3 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index a95c2c6562d0..f93cc63d8fa1 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -183,7 +183,6 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  			     unsigned migratetype, int flags)
>  {
>  	unsigned long pfn;
> -	unsigned long undo_pfn;
>  	struct page *page;
>  
>  	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
> @@ -193,25 +192,12 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  	     pfn < end_pfn;
>  	     pfn += pageblock_nr_pages) {
>  		page = __first_valid_page(pfn, pageblock_nr_pages);
> -		if (page) {
> -			if (set_migratetype_isolate(page, migratetype, flags)) {
> -				undo_pfn = pfn;
> -				goto undo;
> -			}
> +		if (page && set_migratetype_isolate(page, migratetype, flags)) {
> +			undo_isolate_page_range(start_pfn, pfn, migratetype);
> +			return -EBUSY;
>  		}
>  	}
>  	return 0;
> -undo:
> -	for (pfn = start_pfn;
> -	     pfn < undo_pfn;
> -	     pfn += pageblock_nr_pages) {
> -		struct page *page = pfn_to_online_page(pfn);
> -		if (!page)
> -			continue;
> -		unset_migratetype_isolate(page, migratetype);
> -	}
> -
> -	return -EBUSY;
>  }
>  
>  /*
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
