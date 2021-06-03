Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FFD39A1C6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhFCNGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:06:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59976 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhFCNGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:06:35 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6C2DE219E8;
        Thu,  3 Jun 2021 13:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622725490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yBE3ZFoB2r4VvcZDNePwOrSTwHirlx2YX1pCV98NQNE=;
        b=yWfW7xi+27Vm+688aNBhRKdYaB16hUd/LJNhSCyC4Ty3T8yyPaI4m14K+JfOKAL/fek2SD
        asudaNGhZZs2TdaqrczVTzdz9pK+M0I6TVQzCGxsea6nTF/vDOOzEMUlTyXuVH+M8uh8Om
        l6SWuJ/MctvP8uey2NrIx1J0ien2+og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622725490;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yBE3ZFoB2r4VvcZDNePwOrSTwHirlx2YX1pCV98NQNE=;
        b=Qc980Qx0MXpDJ4QjlKjKtIGs/ggqBnYAC/4GHE8w0woNgE3x6+ZrUxUvB8eJSzn7W20Z1b
        mxH72KzQLakoz2AQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 4751C118DD;
        Thu,  3 Jun 2021 13:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622725490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yBE3ZFoB2r4VvcZDNePwOrSTwHirlx2YX1pCV98NQNE=;
        b=yWfW7xi+27Vm+688aNBhRKdYaB16hUd/LJNhSCyC4Ty3T8yyPaI4m14K+JfOKAL/fek2SD
        asudaNGhZZs2TdaqrczVTzdz9pK+M0I6TVQzCGxsea6nTF/vDOOzEMUlTyXuVH+M8uh8Om
        l6SWuJ/MctvP8uey2NrIx1J0ien2+og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622725490;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yBE3ZFoB2r4VvcZDNePwOrSTwHirlx2YX1pCV98NQNE=;
        b=Qc980Qx0MXpDJ4QjlKjKtIGs/ggqBnYAC/4GHE8w0woNgE3x6+ZrUxUvB8eJSzn7W20Z1b
        mxH72KzQLakoz2AQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id TsNhEHLTuGBlJwAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Thu, 03 Jun 2021 13:04:50 +0000
Subject: Re: [PATCH 2/2] mm/page_alloc: Allow high-order pages to be stored on
 the per-cpu lists
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210603084621.24109-1-mgorman@techsingularity.net>
 <20210603084621.24109-3-mgorman@techsingularity.net>
 <1c15b083-26f8-4473-80e6-bcc2f549ba41@suse.cz>
 <20210603123437.GW30378@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7657abef-cc50-b6a1-3b6a-697d97a3d4e2@suse.cz>
Date:   Thu, 3 Jun 2021 15:04:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603123437.GW30378@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/21 2:34 PM, Mel Gorman wrote:
> 
>> > @@ -687,10 +687,53 @@ static void bad_page(struct page *page, const char *reason)
>> >  	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>> >  }
>> >  
>> > +static inline unsigned int order_to_pindex(int migratetype, int order)
>> > +{
>> > +	int base = order;
>> > +
>> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> > +	if (order > PAGE_ALLOC_COSTLY_ORDER) {
>> > +		VM_BUG_ON(order != pageblock_order);
>> > +		base = PAGE_ALLOC_COSTLY_ORDER + 1;
>> > +	}
>> > +#else
>> > +	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
>> > +#endif
>> > +
>> > +	return (MIGRATE_PCPTYPES * base) + migratetype;
>> > +}
>> > +
>> > +static inline int pindex_to_order(unsigned int pindex)
>> > +{
>> > +	int order = pindex / PAGE_ALLOC_COSTLY_ORDER;
>> 
>> This seems wrong, shouldn't we divide by MIGRATE_PCPTYPES?
>> It just happens to be the same number, so testing won't flag this.
>> 
> 
> Whoops, yes, basic algebra says you're right so well spotted. If
> PAGE_ALLOC_COSTLY_ORDER ever changed for some reason, this would blow up.
> 
> So this?

Yeah, great!

> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index bbe05289b121..f1bed5b847ec 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -345,11 +345,11 @@ enum zone_watermarks {
>  #define NR_PCP_LISTS (MIGRATE_PCPTYPES * (PAGE_ALLOC_COSTLY_ORDER + 1 + NR_PCP_THP))
>  
>  /*
> - * Shift to encode migratetype in order in the least significant bits and
> - * migratetype in the higher bits.
> + * Shift to encode migratetype and order in the same integer, with order
> + * in the least significant bits.
>   */
> -#define NR_PCP_ORDER_SHIFT 8
> -#define NR_PCP_ORDER_MASK ((1<<NR_PCP_ORDER_SHIFT) - 1)
> +#define NR_PCP_ORDER_WIDTH 8
> +#define NR_PCP_ORDER_MASK ((1<<NR_PCP_ORDER_WIDTH) - 1)
>  
>  #define min_wmark_pages(z) (z->_watermark[WMARK_MIN] + z->watermark_boost)
>  #define low_wmark_pages(z) (z->_watermark[WMARK_LOW] + z->watermark_boost)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 49f3c7dcdfca..7be71f9ad9f0 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -694,7 +694,7 @@ static inline unsigned int order_to_pindex(int migratetype, int order)
>  
>  static inline int pindex_to_order(unsigned int pindex)
>  {
> -	int order = pindex / PAGE_ALLOC_COSTLY_ORDER;
> +	int order = pindex / MIGRATE_PCPTYPES;
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	if (order > PAGE_ALLOC_COSTLY_ORDER) {
> @@ -1487,7 +1487,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  			batch_free = count;
>  
>  		order = pindex_to_order(pindex);
> -		BUILD_BUG_ON(MAX_ORDER >= (1<<NR_PCP_ORDER_SHIFT));
> +		BUILD_BUG_ON(MAX_ORDER >= (1<<NR_PCP_ORDER_WIDTH));
>  		do {
>  			page = list_last_entry(list, struct page, lru);
>  			/* must delete to avoid corrupting pcp list */
> @@ -1499,7 +1499,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  				continue;
>  
>  			/* Encode order with the migratetype */
> -			page->index <<= NR_PCP_ORDER_SHIFT;
> +			page->index <<= NR_PCP_ORDER_WIDTH;
>  			page->index |= order;
>  
>  			list_add_tail(&page->lru, &head);
> @@ -1537,7 +1537,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  
>  		/* mt has been encoded with the order (see above) */
>  		order = mt & NR_PCP_ORDER_MASK;
> -		mt >>= NR_PCP_ORDER_SHIFT;
> +		mt >>= NR_PCP_ORDER_WIDTH;
>  
>  		/* MIGRATE_ISOLATE page should not go to pcplists */
>  		VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
> 
> 
> 

