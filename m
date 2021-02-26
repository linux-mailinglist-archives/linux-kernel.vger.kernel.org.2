Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C2D3262C8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 13:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhBZMfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 07:35:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:49074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhBZMfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 07:35:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61E1CAE72;
        Fri, 26 Feb 2021 12:34:26 +0000 (UTC)
Subject: Re: [PATCH 4/3] mm,shmem,thp: limit shmem THP allocations to
 requested zones
To:     Rik van Riel <riel@surriel.com>, Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, xuyu@linux.alibaba.com,
        mgorman@suse.de, aarcange@redhat.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, mhocko@suse.com
References: <20201124194925.623931-1-riel@surriel.com>
 <alpine.LSU.2.11.2012141226350.1925@eggly.anvils>
 <e3f67a5f-9835-2752-3d35-fb5f6d701cf1@suse.cz>
 <alpine.LSU.2.11.2102232329180.9202@eggly.anvils>
 <a7a85f81bd21254805bc91772530f237c9b73c04.camel@surriel.com>
 <alpine.LSU.2.11.2102240854140.10197@eggly.anvils>
 <20210224121016.1314ed6d@imladris.surriel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e3d20e7f-d29f-132c-f81d-ac0c294de66b@suse.cz>
Date:   Fri, 26 Feb 2021 13:34:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224121016.1314ed6d@imladris.surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/21 6:10 PM, Rik van Riel wrote:
> On Wed, 24 Feb 2021 08:55:40 -0800 (PST)
> Hugh Dickins <hughd@google.com> wrote:
>> On Wed, 24 Feb 2021, Rik van Riel wrote:
>> > On Wed, 2021-02-24 at 00:41 -0800, Hugh Dickins wrote:  
>> > > Oh, I'd forgotten all about that gma500 aspect:
>> > > well, I can send a fixup later on.  
>> > 
>> > I already have code to fix that, which somebody earlier
>> > in this discussion convinced me to throw away. Want me
>> > to send it as a patch 4/3 ?  
>> 
>> If Andrew wants it all, yes, please do add that - thanks Rik.
> 
> Trivial patch to fix the gma500 thing below:
> 
> ---8<---
> 
> mm,shmem,thp: limit shmem THP allocations to requested zones
> 
> Hugh pointed out that the gma500 driver uses shmem pages, but needs
> to limit them to the DMA32 zone. Ensure the allocations resulting from
> the gfp_mask returned by limit_gfp_mask use the zone flags that were
> originally passed to shmem_getpage_gfp.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Suggested-by: Hugh Dickins <hughd@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/shmem.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index ee3cea10c2a4..876fec89686f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1539,7 +1539,11 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
>  {
>  	gfp_t allowflags = __GFP_IO | __GFP_FS | __GFP_RECLAIM;
>  	gfp_t denyflags = __GFP_NOWARN | __GFP_NORETRY;
> -	gfp_t result = huge_gfp & ~allowflags;
> +	gfp_t zoneflags = limit_gfp & GFP_ZONEMASK;
> +	gfp_t result = huge_gfp & ~(allowflags | GFP_ZONEMASK);
> +
> +	/* Allow allocations only from the originally specified zones. */
> +	result |= zoneflags;
>  
>  	/*
>  	 * Minimize the result gfp by taking the union with the deny flags,
> 

