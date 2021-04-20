Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F62365532
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 11:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhDTJXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 05:23:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:53888 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhDTJXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 05:23:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618910589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/5IXcgsmdD3t1zNsGNoaWDjQrmxOzE8QlJ+Xw16K8VM=;
        b=t0yA2jZLNoBkL9ccC7xfqST7tWB3nwiiZC2FKxU51vo5DB8QaYkK0wWLUArsKoh9TLGP7v
        oj0ORNsB8hrdFmtHIje2aAq0FQECe4izep5r1yitnG6aU+8bAwCYlTBSjdcGdHztZZdoz4
        docti5679AFxBgOeDe5dT2bMMLW9jUo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0C7FBAF0C;
        Tue, 20 Apr 2021 09:23:09 +0000 (UTC)
Date:   Tue, 20 Apr 2021 11:23:08 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/8] drivers/base/memory: Introduce
 memory_block_{online,offline}
Message-ID: <YH6dfDbT56koiow6@dhcp22.suse.cz>
References: <20210416112411.9826-1-osalvador@suse.de>
 <20210416112411.9826-2-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416112411.9826-2-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-04-21 13:24:04, Oscar Salvador wrote:
> This is a preparatory patch that introduces two new functions:
> memory_block_online() and memory_block_offline().
> 
> For now, these functions will only call online_pages() and offline_pages()
> respectively, but they will be later in charge of preparing the vmemmap
> pages, carrying out the initialization and proper accounting of such
> pages.
> 
> Since memory_block struct contains all the information, pass this struct
> down the chain till the end functions.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  drivers/base/memory.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index f35298425575..f209925a5d4e 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -169,30 +169,41 @@ int memory_notify(unsigned long val, void *v)
>  	return blocking_notifier_call_chain(&memory_chain, val, v);
>  }
>  
> +static int memory_block_online(struct memory_block *mem)
> +{
> +	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
> +	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
> +
> +	return online_pages(start_pfn, nr_pages, mem->online_type, mem->nid);
> +}
> +
> +static int memory_block_offline(struct memory_block *mem)
> +{
> +	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
> +	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
> +
> +	return offline_pages(start_pfn, nr_pages);
> +}
> +
>  /*
>   * MEMORY_HOTPLUG depends on SPARSEMEM in mm/Kconfig, so it is
>   * OK to have direct references to sparsemem variables in here.
>   */
>  static int
> -memory_block_action(unsigned long start_section_nr, unsigned long action,
> -		    int online_type, int nid)
> +memory_block_action(struct memory_block *mem, unsigned long action)
>  {
> -	unsigned long start_pfn;
> -	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
>  	int ret;
>  
> -	start_pfn = section_nr_to_pfn(start_section_nr);
> -
>  	switch (action) {
>  	case MEM_ONLINE:
> -		ret = online_pages(start_pfn, nr_pages, online_type, nid);
> +		ret = memory_block_online(mem);
>  		break;
>  	case MEM_OFFLINE:
> -		ret = offline_pages(start_pfn, nr_pages);
> +		ret = memory_block_offline(mem);
>  		break;
>  	default:
>  		WARN(1, KERN_WARNING "%s(%ld, %ld) unknown action: "
> -		     "%ld\n", __func__, start_section_nr, action, action);
> +		     "%ld\n", __func__, mem->start_section_nr, action, action);
>  		ret = -EINVAL;
>  	}
>  
> @@ -210,9 +221,7 @@ static int memory_block_change_state(struct memory_block *mem,
>  	if (to_state == MEM_OFFLINE)
>  		mem->state = MEM_GOING_OFFLINE;
>  
> -	ret = memory_block_action(mem->start_section_nr, to_state,
> -				  mem->online_type, mem->nid);
> -
> +	ret = memory_block_action(mem, to_state);
>  	mem->state = ret ? from_state_req : to_state;
>  
>  	return ret;
> -- 
> 2.16.3

-- 
Michal Hocko
SUSE Labs
