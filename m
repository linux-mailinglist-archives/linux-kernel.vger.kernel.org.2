Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488293629F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 23:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344121AbhDPVJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 17:09:50 -0400
Received: from mail-il1-f170.google.com ([209.85.166.170]:37441 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344038AbhDPVJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:09:46 -0400
Received: by mail-il1-f170.google.com with SMTP id j12so10336817ils.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 14:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ku325xR6gcu6Ab0160Ej5sx3fi9r5K88bMC216XFIYo=;
        b=D/MZMsWiiRxujlWthVOI7C+PbXivkRIjLIQSCEA6VxC/OyZMfqyMCAu6F7oVBMqQFz
         1EhFNkcCMcZQwbBMYYGMMJo6AIkmC4y88b/Xs5HjIFrYaxD30R6hxwqEdOLk9bPv3upB
         Y8YLm/WAxhFfXTaFe7XibpzWcAePOe4cXwacE+6sT70WXYtNV7tIE0fj3dLncBJMLO1E
         bLwySVw01Axfrhs6sFftw/0MbAwvgqIY86drm0u5DX2C5pfo02uB9u0HIH8ho1h0b9yn
         E7o083nJOcZ+geZJ88kPClpTnn+yDG6jcuMUk/uv96daHvcKVtQn/pBi2XQ6vDlia9my
         FkYw==
X-Gm-Message-State: AOAM533+UiUVh0KBPznLuwhjjb1tbqsfGcMSz9t4YNaBiEGdXTcg+8MI
        H45g10PWa8/fusv2bBjOWS8=
X-Google-Smtp-Source: ABdhPJySvdl8wEWlZ8KAwhuM6eRd0zx+FsVY7Ptfz+lSoY969IE0mg5VyOC8981H+HI2mL37KZvM9A==
X-Received: by 2002:a05:6e02:10cf:: with SMTP id s15mr8848576ilj.302.1618607359891;
        Fri, 16 Apr 2021 14:09:19 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id j2sm3003494ila.2.2021.04.16.14.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:09:19 -0700 (PDT)
Date:   Fri, 16 Apr 2021 21:09:18 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] percpu: generalize pcpu_balance_populated()
Message-ID: <YHn8/lXOGxMDMGa3@google.com>
References: <20210408035736.883861-1-guro@fb.com>
 <20210408035736.883861-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408035736.883861-5-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Apr 07, 2021 at 08:57:34PM -0700, Roman Gushchin wrote:
> To prepare for the depopulation of percpu chunks, split out the
> populating part of the pcpu_balance_populated() into the new
> pcpu_grow_populated() (with an intention to add
> pcpu_shrink_populated() in the next commit).
> 
> The goal of pcpu_balance_populated() is to determine whether
> there is a shortage or an excessive amount of empty percpu pages
> and call into the corresponding function.
> 
> pcpu_grow_populated() takes a desired number of pages as an argument
> (nr_to_pop). If it creates a new chunk, nr_to_pop should be updated
> to reflect that the new chunk could be created already populated.
> Otherwise an infinite loop might appear.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/percpu.c | 63 +++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 39 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 61339b3d9337..e20119668c42 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1979,7 +1979,7 @@ static void pcpu_balance_free(enum pcpu_chunk_type type)
>  }
>  
>  /**
> - * pcpu_balance_populated - manage the amount of populated pages
> + * pcpu_grow_populated - populate chunk(s) to satisfy atomic allocations
>   * @type: chunk type
>   *
>   * Maintain a certain amount of populated pages to satisfy atomic allocations.
> @@ -1988,35 +1988,15 @@ static void pcpu_balance_free(enum pcpu_chunk_type type)
>   * allocation causes the failure as it is possible that requests can be
>   * serviced from already backed regions.
>   */
> -static void pcpu_balance_populated(enum pcpu_chunk_type type)
> +static void pcpu_grow_populated(enum pcpu_chunk_type type, int nr_to_pop)
>  {
>  	/* gfp flags passed to underlying allocators */
>  	const gfp_t gfp = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
>  	struct list_head *pcpu_slot = pcpu_chunk_list(type);
>  	struct pcpu_chunk *chunk;
> -	int slot, nr_to_pop, ret;
> +	int slot, ret;
>  
> -	/*
> -	 * Ensure there are certain number of free populated pages for
> -	 * atomic allocs.  Fill up from the most packed so that atomic
> -	 * allocs don't increase fragmentation.  If atomic allocation
> -	 * failed previously, always populate the maximum amount.  This
> -	 * should prevent atomic allocs larger than PAGE_SIZE from keeping
> -	 * failing indefinitely; however, large atomic allocs are not
> -	 * something we support properly and can be highly unreliable and
> -	 * inefficient.
> -	 */
>  retry_pop:
> -	if (pcpu_atomic_alloc_failed) {
> -		nr_to_pop = PCPU_EMPTY_POP_PAGES_HIGH;
> -		/* best effort anyway, don't worry about synchronization */
> -		pcpu_atomic_alloc_failed = false;
> -	} else {
> -		nr_to_pop = clamp(PCPU_EMPTY_POP_PAGES_HIGH -
> -				  pcpu_nr_empty_pop_pages[type],
> -				  0, PCPU_EMPTY_POP_PAGES_HIGH);
> -	}
> -
>  	for (slot = pcpu_size_to_slot(PAGE_SIZE); slot < pcpu_nr_slots; slot++) {
>  		unsigned int nr_unpop = 0, rs, re;
>  
> @@ -2060,12 +2040,47 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
>  		if (chunk) {
>  			spin_lock_irq(&pcpu_lock);
>  			pcpu_chunk_relocate(chunk, -1);
> +			nr_to_pop = max_t(int, 0, nr_to_pop - chunk->nr_populated);
>  			spin_unlock_irq(&pcpu_lock);
> -			goto retry_pop;
> +			if (nr_to_pop)
> +				goto retry_pop;
>  		}
>  	}
>  }
>  
> +/**
> + * pcpu_balance_populated - manage the amount of populated pages
> + * @type: chunk type
> + *
> + * Populate or depopulate chunks to maintain a certain amount
> + * of free pages to satisfy atomic allocations, but not waste
> + * large amounts of memory.
> + */
> +static void pcpu_balance_populated(enum pcpu_chunk_type type)
> +{
> +	int nr_to_pop;
> +
> +	/*
> +	 * Ensure there are certain number of free populated pages for
> +	 * atomic allocs.  Fill up from the most packed so that atomic
> +	 * allocs don't increase fragmentation.  If atomic allocation
> +	 * failed previously, always populate the maximum amount.  This
> +	 * should prevent atomic allocs larger than PAGE_SIZE from keeping
> +	 * failing indefinitely; however, large atomic allocs are not
> +	 * something we support properly and can be highly unreliable and
> +	 * inefficient.
> +	 */
> +	if (pcpu_atomic_alloc_failed) {
> +		nr_to_pop = PCPU_EMPTY_POP_PAGES_HIGH;
> +		/* best effort anyway, don't worry about synchronization */
> +		pcpu_atomic_alloc_failed = false;
> +		pcpu_grow_populated(type, nr_to_pop);
> +	} else if (pcpu_nr_empty_pop_pages[type] < PCPU_EMPTY_POP_PAGES_HIGH) {
> +		nr_to_pop = PCPU_EMPTY_POP_PAGES_HIGH - pcpu_nr_empty_pop_pages[type];
> +		pcpu_grow_populated(type, nr_to_pop);
> +	}
> +}
> +
>  /**
>   * pcpu_balance_workfn - manage the amount of free chunks and populated pages
>   * @work: unused
> -- 
> 2.30.2
> 

I've applied this for-5.14.

Thanks,
Dennis
