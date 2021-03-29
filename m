Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3207434D3F7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhC2Pbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:31:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:56882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230204AbhC2PbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:31:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 57CD5AFF6;
        Mon, 29 Mar 2021 15:31:10 +0000 (UTC)
Subject: Re: [PATCH -next] mm, page_alloc: avoid page_to_pfn() in
 move_freepages()
To:     Liu Shixin <liushixin2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20210323131215.934472-1-liushixin2@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <33e6c72e-5479-e503-99ec-5025fafd46f6@suse.cz>
Date:   Mon, 29 Mar 2021 17:31:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323131215.934472-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 2:12 PM, Liu Shixin wrote:
> From: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> The start_pfn and end_pfn are already available in move_freepages_block(),
> there is no need to go back and forth between page and pfn in move_freepages
> and move_freepages_block, and pfn_valid_within() should validate pfn first
> before touching the page.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Agreed with Matthew's suggestion, also:

> @@ -2468,25 +2469,22 @@ static int move_freepages(struct zone *zone,
>  int move_freepages_block(struct zone *zone, struct page *page,
>  				int migratetype, int *num_movable)
>  {
> -	unsigned long start_pfn, end_pfn;
> -	struct page *start_page, *end_page;
> +	unsigned long start_pfn, end_pfn, pfn;
>  
>  	if (num_movable)
>  		*num_movable = 0;
>  
> -	start_pfn = page_to_pfn(page);
> -	start_pfn = start_pfn & ~(pageblock_nr_pages-1);
> -	start_page = pfn_to_page(start_pfn);
> -	end_page = start_page + pageblock_nr_pages - 1;
> +	pfn = page_to_pfn(page);
> +	start_pfn = pfn & ~(pageblock_nr_pages - 1);

Since you touch this already, consider pageblock_start_pfn()

>  	end_pfn = start_pfn + pageblock_nr_pages - 1;

I'd also drop the "- 1" here and instead adjust the for loop's ending condition
from "pfn <= end_pfn" to "pfn < end_pfn" as that's more common way of doing it.

Thanks.

>  
>  	/* Do not cross zone boundaries */
>  	if (!zone_spans_pfn(zone, start_pfn))
> -		start_page = page;
> +		start_pfn = pfn;
>  	if (!zone_spans_pfn(zone, end_pfn))
>  		return 0;
>  
> -	return move_freepages(zone, start_page, end_page, migratetype,
> +	return move_freepages(zone, start_pfn, end_pfn, migratetype,
>  								num_movable);
>  }
>  
> 

