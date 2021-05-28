Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D953940DE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbhE1K3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:29:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40308 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbhE1K3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:29:34 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 45F891FD2F;
        Fri, 28 May 2021 10:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622197679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MeSbALZmIII2yBXVbZ7zlQ01so3hhDxLJ3HUHGlfodo=;
        b=Iv5gaDbQ+fBLXM2H7Tl9O2Q0jFLvN0DMmwocQlOEJUg+76X3o0LPbz2dQ6qpC0I+L3h0Fk
        R2uNaDYi/rsXcK2OjmtEQGLZSgTs4/DjdxEC964QMqGxWrLhzAtMFqcbc5L29I8GI50c/R
        DFDKHcoN/4HH5k0kCib7g/5gTemQ+j8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622197679;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MeSbALZmIII2yBXVbZ7zlQ01so3hhDxLJ3HUHGlfodo=;
        b=ZapyTHsk/d3QTM7phAtdC7lp9ZjEBUDQ1UDlWpV/LRxkzoFzXtczfpTUgdAk7HWnQCtnWV
        zMYp0n4vBar8laBA==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 2E6C611A98;
        Fri, 28 May 2021 10:27:59 +0000 (UTC)
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
 <20210525080119.5455-3-mgorman@techsingularity.net>
 <10cb326c-b4ad-3a82-a38b-aba7d2192736@suse.cz>
 <20210527105241.GB30378@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 2/6] mm/page_alloc: Disassociate the pcp->high from
 pcp->batch
Message-ID: <9ccf113a-d292-2b34-2470-5a4e2ed4276e@suse.cz>
Date:   Fri, 28 May 2021 12:27:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210527105241.GB30378@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/21 12:52 PM, Mel Gorman wrote:
> On Wed, May 26, 2021 at 08:14:13PM +0200, Vlastimil Babka wrote:
>> > @@ -6698,11 +6717,10 @@ static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long h
>> >   */
>> >  static void zone_set_pageset_high_and_batch(struct zone *zone)
>> >  {
>> > -	unsigned long new_high, new_batch;
>> > +	int new_high, new_batch;
>> >  
>> > -	new_batch = zone_batchsize(zone);
>> > -	new_high = 6 * new_batch;
>> > -	new_batch = max(1UL, 1 * new_batch);
>> > +	new_batch = max(1, zone_batchsize(zone));
>> > +	new_high = zone_highsize(zone, new_batch);
>> >  
>> >  	if (zone->pageset_high == new_high &&
>> >  	    zone->pageset_batch == new_batch)
>> > @@ -8170,6 +8188,12 @@ static void __setup_per_zone_wmarks(void)
>> >  		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
>> >  		zone->_watermark[WMARK_HIGH] = min_wmark_pages(zone) + tmp * 2;
>> >  
>> > +		/*
>> > +		 * The watermark size have changed so update the pcpu batch
>> > +		 * and high limits or the limits may be inappropriate.
>> > +		 */
>> > +		zone_set_pageset_high_and_batch(zone);
>> 
>> Hm so this puts the call in the path of various watermark related sysctl
>> handlers, but it's not protected by pcp_batch_high_lock. The zone lock won't
>> help against zone_pcp_update() from a hotplug handler. On the other hand, since
>> hotplug handlers also call __setup_per_zone_wmarks(), the zone_pcp_update()
>> calls there are now redundant and could be removed, no?
>> But later there will be a new sysctl in patch 6/6 using pcp_batch_high_lock,
>> thus that one will not be protected against the watermark related sysctl
>> handlers that reach here.
>> 
>> To solve all this, seems like the static lock in setup_per_zone_wmarks() could
>> become a top-level visible lock and pcp high/batch updates could switch to that
>> one instead of own pcp_batch_high_lock. And zone_pcp_update() calls from hotplug
>> handlers could be removed.
>> 
> 
> Hmm, the locking has very different hold times. The static lock in
> setup_per_zone_wmarks is a spinlock that protects against parallel updates
> of watermarks and is held for a short duration. The pcp_batch_high_lock
> is a mutex that is held for a relatively long time while memory is being
> offlined and can sleep. Memory hotplug updates the watermarks without
> pcp_batch_high_lock held so overall, unifying the locking there should
> be a separate series.
> 
> How about this as a fix for this patch?
> 
> ---8<---
> mm/page_alloc: Disassociate the pcp->high from pcp->batch -fix
> 
> Vlastimil Babka noted that __setup_per_zone_wmarks updating pcp->high
> did not protect watermark-related sysctl handlers from a parallel
> memory hotplug operations. This patch moves the PCP update to
> setup_per_zone_wmarks and updates the PCP high value while protected
> by the pcp_batch_high_lock mutex.
> 
> This is a fix to the mmotm patch mm-page_alloc-disassociate-the-pcp-high-from-pcp-batch.patch.
> It'll cause a conflict with mm-page_alloc-adjust-pcp-high-after-cpu-hotplug-events.patch
> but the resolution is simply to change the caller in setup_per_zone_wmarks
> to zone_pcp_update(zone, 0)
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Looks fine. But I would also remove the redudancy introduced by this patch+fix,
as part of the patch:

online_pages()
  zone_pcp_update(zone); <- this predates the patch
  init_per_zone_wmark_min()
    setup_per_zone_wmarks()
      for_each_zone(zone)
         zone_pcp_update(zone); <- new in this patch

offline_pages() similarly

In any case, for the fixed version:
Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 329b71e41db4..b1b3c66e9d88 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8199,12 +8199,6 @@ static void __setup_per_zone_wmarks(void)
>  		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
>  		zone->_watermark[WMARK_HIGH] = min_wmark_pages(zone) + tmp * 2;
>  
> -		/*
> -		 * The watermark size have changed so update the pcpu batch
> -		 * and high limits or the limits may be inappropriate.
> -		 */
> -		zone_set_pageset_high_and_batch(zone);
> -
>  		spin_unlock_irqrestore(&zone->lock, flags);
>  	}
>  
> @@ -8221,11 +8215,19 @@ static void __setup_per_zone_wmarks(void)
>   */
>  void setup_per_zone_wmarks(void)
>  {
> +	struct zone *zone;
>  	static DEFINE_SPINLOCK(lock);
>  
>  	spin_lock(&lock);
>  	__setup_per_zone_wmarks();
>  	spin_unlock(&lock);
> +
> +	/*
> +	 * The watermark size have changed so update the pcpu batch
> +	 * and high limits or the limits may be inappropriate.
> +	 */
> +	for_each_zone(zone)
> +		zone_pcp_update(zone);
>  }
>  
>  /*
> 

