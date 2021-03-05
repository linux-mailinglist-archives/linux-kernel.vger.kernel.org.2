Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B4A32E773
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 12:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhCELxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 06:53:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:45618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhCELwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 06:52:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614945173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IGTdulojVqDfD4uEHxN4sJQiQBIBDS74gP8QP9Wo5Ac=;
        b=mbsYFZ8bGlG0dPGdUPBHfoJUs5T9hVelb/uXsxSKMr/eWuZOxCWQ+1EEPjGTV+06u1eZwA
        QcUMjWuLjUGnf0VBWwn+PtZKUmZqfyTUIfTrzrYKPcHyml5zD534VQcvMzWKAKSGT9dBJ7
        GNCG6jSSQGVjQkPL/iqaiWvjSduoOl8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0CAEBAC54;
        Fri,  5 Mar 2021 11:52:53 +0000 (UTC)
Date:   Fri, 5 Mar 2021 12:52:52 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Zhou Guanghui <zhouguanghui1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com,
        kirill.shutemov@linux.intel.com, npiggin@gmail.com, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com
Subject: Re: [PATCH v2 2/2] mm/memcg: set memcg when split page
Message-ID: <YEIblNv0BMITFzYO@dhcp22.suse.cz>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
 <20210304074053.65527-3-zhouguanghui1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304074053.65527-3-zhouguanghui1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04-03-21 07:40:53, Zhou Guanghui wrote:
> As described in the split_page function comment, for the non-compound
> high order page, the sub-pages must be freed individually. If the
> memcg of the fisrt page is valid, the tail pages cannot be uncharged
> when be freed.
> 
> For example, when alloc_pages_exact is used to allocate 1MB continuous
> physical memory, 2MB is charged(kmemcg is enabled and __GFP_ACCOUNT is
> set). When make_alloc_exact free the unused 1MB and free_pages_exact
> free the applied 1MB, actually, only 4KB(one page) is uncharged.
> 
> Therefore, the memcg of the tail page needs to be set when split page.
> 

As already mentioned there are at least two explicit users of
__GFP_ACCOUNT with alloc_exact_pages added recently. It would be good to
mention that explicitly and maybe even mention 7efe8ef274024 resp.
c419621873713 so that it is clear this is not just a theoretical issue.

> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/page_alloc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3e4b29ee2b1e..3ed783e25c3c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3310,6 +3310,7 @@ void split_page(struct page *page, unsigned int order)
>  	for (i = 1; i < (1 << order); i++)
>  		set_page_refcounted(page + i);
>  	split_page_owner(page, 1 << order);
> +	split_page_memcg(page, 1 << order);
>  }
>  EXPORT_SYMBOL_GPL(split_page);
>  
> -- 
> 2.25.0
> 

-- 
Michal Hocko
SUSE Labs
