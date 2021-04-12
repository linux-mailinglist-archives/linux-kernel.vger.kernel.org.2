Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636DA35CF9B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 19:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244241AbhDLRnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 13:43:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:47564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243735AbhDLRnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 13:43:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7E6A9AF10;
        Mon, 12 Apr 2021 17:43:19 +0000 (UTC)
Subject: Re: [PATCH 01/11] mm/page_alloc: Split per cpu page lists and zone
 stats
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
 <20210407202423.16022-2-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <81cf880c-826e-6bbf-3af0-22d7aa2d3075@suse.cz>
Date:   Mon, 12 Apr 2021 19:43:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210407202423.16022-2-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/21 10:24 PM, Mel Gorman wrote:
> @@ -6691,7 +6697,7 @@ static __meminit void zone_pcp_init(struct zone *zone)
>  	 * relies on the ability of the linker to provide the
>  	 * offset of a (static) per cpu variable into the per cpu area.
>  	 */
> -	zone->pageset = &boot_pageset;
> +	zone->per_cpu_pageset = &boot_pageset;

I don't see any &boot_zonestats assignment here in zone_pcp_init() or its
caller(s), which seems strange, as zone_pcp_reset() does it.

>  	zone->pageset_high = BOOT_PAGESET_HIGH;
>  	zone->pageset_batch = BOOT_PAGESET_BATCH;
>  
> @@ -8954,17 +8960,19 @@ void zone_pcp_reset(struct zone *zone)
>  {
>  	unsigned long flags;
>  	int cpu;
> -	struct per_cpu_pageset *pset;
> +	struct per_cpu_zonestat *pzstats;
>  
>  	/* avoid races with drain_pages()  */
>  	local_irq_save(flags);
> -	if (zone->pageset != &boot_pageset) {
> +	if (zone->per_cpu_pageset != &boot_pageset) {
>  		for_each_online_cpu(cpu) {
> -			pset = per_cpu_ptr(zone->pageset, cpu);
> -			drain_zonestat(zone, pset);
> +			pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
> +			drain_zonestat(zone, pzstats);
>  		}
> -		free_percpu(zone->pageset);
> -		zone->pageset = &boot_pageset;
> +		free_percpu(zone->per_cpu_pageset);
> +		free_percpu(zone->per_cpu_zonestats);
> +		zone->per_cpu_pageset = &boot_pageset;
> +		zone->per_cpu_zonestats = &boot_zonestats;

^ here

>  	}
>  	local_irq_restore(flags);
>  }
