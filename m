Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55124391ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 20:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbhEZSPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 14:15:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53648 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbhEZSPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 14:15:46 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C4D9A218D6;
        Wed, 26 May 2021 18:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622052853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l9Z6k1AqIcX+FOS3J/1vgdvLOGpsPUhKVX0RFUimaCw=;
        b=VoxJjT9o8hJsjbxkCZ42Q/6OJV/qvhsZAlQWBWKK1JAF7+GsX685rNX/jtjohEcv7tq3Ew
        eVEpgTwsxw+Eoh4GW7ajeNc0JzsKrF/EpQjCzdXcXBjcVnuy2ftZF8/Lpnn7PHvPQz/Sv4
        6DHUOSoUz4vYnRgv2Fb4S+zpqpA9QVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622052853;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l9Z6k1AqIcX+FOS3J/1vgdvLOGpsPUhKVX0RFUimaCw=;
        b=PoRZJE1yIaSTHr4D+BiJqj5vpbUC9IHwZlX4mKyxd7pC+5yojLSzrRxtkJaXH0UiqueIto
        Ydafz4++k6eUf7Bg==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id AD80411A98;
        Wed, 26 May 2021 18:14:13 +0000 (UTC)
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
 <20210525080119.5455-3-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 2/6] mm/page_alloc: Disassociate the pcp->high from
 pcp->batch
Message-ID: <10cb326c-b4ad-3a82-a38b-aba7d2192736@suse.cz>
Date:   Wed, 26 May 2021 20:14:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525080119.5455-3-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 10:01 AM, Mel Gorman wrote:
> The pcp high watermark is based on the batch size but there is no
> relationship between them other than it is convenient to use early in
> boot.
> 
> This patch takes the first step and bases pcp->high on the zone low
> watermark split across the number of CPUs local to a zone while the batch
> size remains the same to avoid increasing allocation latencies. The intent
> behind the default pcp->high is "set the number of PCP pages such that
> if they are all full that background reclaim is not started prematurely".
> 
> Note that in this patch the pcp->high values are adjusted after memory
> hotplug events, min_free_kbytes adjustments and watermark scale factor
> adjustments but not CPU hotplug events which is handled later in the
> series.
> 
> On a test KVM instance;
> 
> Before grep -E "high:|batch" /proc/zoneinfo | tail -2
>               high:  378
>               batch: 63
> 
> After grep -E "high:|batch" /proc/zoneinfo | tail -2
>               high:  649
>               batch: 63
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

...

> @@ -6637,6 +6628,34 @@ static int zone_batchsize(struct zone *zone)
>  #endif
>  }
>  
> +static int zone_highsize(struct zone *zone, int batch)
> +{
> +#ifdef CONFIG_MMU
> +	int high;
> +	int nr_local_cpus;
> +
> +	/*
> +	 * The high value of the pcp is based on the zone low watermark
> +	 * so that if they are full then background reclaim will not be
> +	 * started prematurely. The value is split across all online CPUs
> +	 * local to the zone. Note that early in boot that CPUs may not be
> +	 * online yet.
> +	 */
> +	nr_local_cpus = max(1U, cpumask_weight(cpumask_of_node(zone_to_nid(zone))));
> +	high = low_wmark_pages(zone) / nr_local_cpus;
> +
> +	/*
> +	 * Ensure high is at least batch*4. The multiple is based on the
> +	 * historical relationship between high and batch.
> +	 */
> +	high = max(high, batch << 2);
> +
> +	return high;
> +#else
> +	return 0;
> +#endif
> +}
> +
>  /*
>   * pcp->high and pcp->batch values are related and generally batch is lower
>   * than high. They are also related to pcp->count such that count is lower
> @@ -6698,11 +6717,10 @@ static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long h
>   */
>  static void zone_set_pageset_high_and_batch(struct zone *zone)
>  {
> -	unsigned long new_high, new_batch;
> +	int new_high, new_batch;
>  
> -	new_batch = zone_batchsize(zone);
> -	new_high = 6 * new_batch;
> -	new_batch = max(1UL, 1 * new_batch);
> +	new_batch = max(1, zone_batchsize(zone));
> +	new_high = zone_highsize(zone, new_batch);
>  
>  	if (zone->pageset_high == new_high &&
>  	    zone->pageset_batch == new_batch)
> @@ -8170,6 +8188,12 @@ static void __setup_per_zone_wmarks(void)
>  		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
>  		zone->_watermark[WMARK_HIGH] = min_wmark_pages(zone) + tmp * 2;
>  
> +		/*
> +		 * The watermark size have changed so update the pcpu batch
> +		 * and high limits or the limits may be inappropriate.
> +		 */
> +		zone_set_pageset_high_and_batch(zone);

Hm so this puts the call in the path of various watermark related sysctl
handlers, but it's not protected by pcp_batch_high_lock. The zone lock won't
help against zone_pcp_update() from a hotplug handler. On the other hand, since
hotplug handlers also call __setup_per_zone_wmarks(), the zone_pcp_update()
calls there are now redundant and could be removed, no?
But later there will be a new sysctl in patch 6/6 using pcp_batch_high_lock,
thus that one will not be protected against the watermark related sysctl
handlers that reach here.

To solve all this, seems like the static lock in setup_per_zone_wmarks() could
become a top-level visible lock and pcp high/batch updates could switch to that
one instead of own pcp_batch_high_lock. And zone_pcp_update() calls from hotplug
handlers could be removed.

> +
>  		spin_unlock_irqrestore(&zone->lock, flags);
>  	}
>  
> 

