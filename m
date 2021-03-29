Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B6C34D608
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 19:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhC2R2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 13:28:31 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:36854 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhC2R2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 13:28:25 -0400
Received: by mail-io1-f43.google.com with SMTP id f19so13576005ion.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 10:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nkzt5ca+QTI2PdMNoQrVYUu19ObnRjYQ/LdWspjTQOA=;
        b=ZIsFrrwKXqPJ+JoOBx+dKxNdMuFH5Nr0ZaEOkv3ugoN6ur81yeS81YoPweQ83ekNJY
         mcmheM7GGE3PX/asMPyk2YIXdDxz7kI/PtvK+RwZtUM+y71AkDYFnngThvTrwmVoK43F
         M1Q8wzlLbVtj822QL/mP/xI2pwCRtCqCDcGcjZkqn+U2rSYmezwRdKODWAFo+9Jc1lvG
         wQ5VBm/iOdKINzBtySCYRstaHwsyHbkdYhSS3osaJnHlbWmFVgUr7Eb4E5XMlwafHRuC
         Q/G0HAr72FVEb9NVGw9hPs7/luesoCL2QWqoK5fYaLiyQ75IPcosf0vSdkk4siqQJYS8
         lPaA==
X-Gm-Message-State: AOAM532mSl1+UvvOpHRF2RoJvpkN4vBL6FqXh5ZRgP7liC9H68f6PzH8
        14lx3jo9VfmiC8IHPPLkmIk=
X-Google-Smtp-Source: ABdhPJxW6JdM2bXLojdubZTuopcLdyZe28g3PcUDHgAwrq2Vhm7NvakTtgSqMCd/hxKe4m6b5oyPdQ==
X-Received: by 2002:a05:6602:2348:: with SMTP id r8mr21193050iot.77.1617038905185;
        Mon, 29 Mar 2021 10:28:25 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id z10sm7541252ilq.38.2021.03.29.10.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 10:28:24 -0700 (PDT)
Date:   Mon, 29 Mar 2021 17:28:23 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH rfc 2/4] percpu: split __pcpu_balance_workfn()
Message-ID: <YGION8fYFy0uVVlm@google.com>
References: <20210324190626.564297-1-guro@fb.com>
 <20210324190626.564297-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324190626.564297-3-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 12:06:24PM -0700, Roman Gushchin wrote:
> __pcpu_balance_workfn() became fairly big and hard to follow, but in
> fact it consists of two fully independent parts, responsible for
> the destruction of excessive free chunks and population of necessarily
> amount of free pages.
> 
> In order to simplify the code and prepare for adding of a new
> functionality, split it in two functions:
> 
>   1) pcpu_balance_free,
>   2) pcpu_balance_populated.
> 
> Move the taking/releasing of the pcpu_alloc_mutex to an upper level
> to keep the current synchronization in place.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/percpu.c | 46 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 78c55c73fa28..015d076893f5 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1930,31 +1930,22 @@ void __percpu *__alloc_reserved_percpu(size_t size, size_t align)
>  }
>  
>  /**
> - * __pcpu_balance_workfn - manage the amount of free chunks and populated pages
> + * pcpu_balance_free - manage the amount of free chunks
>   * @type: chunk type
>   *
> - * Reclaim all fully free chunks except for the first one.  This is also
> - * responsible for maintaining the pool of empty populated pages.  However,
> - * it is possible that this is called when physical memory is scarce causing
> - * OOM killer to be triggered.  We should avoid doing so until an actual
> - * allocation causes the failure as it is possible that requests can be
> - * serviced from already backed regions.
> + * Reclaim all fully free chunks except for the first one.
>   */
> -static void __pcpu_balance_workfn(enum pcpu_chunk_type type)
> +static void pcpu_balance_free(enum pcpu_chunk_type type)
>  {
> -	/* gfp flags passed to underlying allocators */
> -	const gfp_t gfp = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
>  	LIST_HEAD(to_free);
>  	struct list_head *pcpu_slot = pcpu_chunk_list(type);
>  	struct list_head *free_head = &pcpu_slot[pcpu_nr_slots - 1];
>  	struct pcpu_chunk *chunk, *next;
> -	int slot, nr_to_pop, ret;
>  
>  	/*
>  	 * There's no reason to keep around multiple unused chunks and VM
>  	 * areas can be scarce.  Destroy all free chunks except for one.
>  	 */
> -	mutex_lock(&pcpu_alloc_mutex);
>  	spin_lock_irq(&pcpu_lock);
>  
>  	list_for_each_entry_safe(chunk, next, free_head, list) {
> @@ -1982,6 +1973,25 @@ static void __pcpu_balance_workfn(enum pcpu_chunk_type type)
>  		pcpu_destroy_chunk(chunk);
>  		cond_resched();
>  	}
> +}
> +
> +/**
> + * pcpu_balance_populated - manage the amount of populated pages
> + * @type: chunk type
> + *
> + * Maintain a certain amount of populated pages to satisfy atomic allocations.
> + * It is possible that this is called when physical memory is scarce causing
> + * OOM killer to be triggered.  We should avoid doing so until an actual
> + * allocation causes the failure as it is possible that requests can be
> + * serviced from already backed regions.
> + */
> +static void pcpu_balance_populated(enum pcpu_chunk_type type)
> +{
> +	/* gfp flags passed to underlying allocators */
> +	const gfp_t gfp = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
> +	struct list_head *pcpu_slot = pcpu_chunk_list(type);
> +	struct pcpu_chunk *chunk;
> +	int slot, nr_to_pop, ret;
>  
>  	/*
>  	 * Ensure there are certain number of free populated pages for
> @@ -2051,8 +2061,6 @@ static void __pcpu_balance_workfn(enum pcpu_chunk_type type)
>  			goto retry_pop;
>  		}
>  	}
> -
> -	mutex_unlock(&pcpu_alloc_mutex);
>  }
>  
>  /**
> @@ -2149,14 +2157,18 @@ static void pcpu_shrink_populated(enum pcpu_chunk_type type)
>   * pcpu_balance_workfn - manage the amount of free chunks and populated pages
>   * @work: unused
>   *
> - * Call __pcpu_balance_workfn() for each chunk type.
> + * Call pcpu_balance_free() and pcpu_balance_populated() for each chunk type.
>   */
>  static void pcpu_balance_workfn(struct work_struct *work)
>  {
>  	enum pcpu_chunk_type type;
>  
> -	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++)
> -		__pcpu_balance_workfn(type);
> +	for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++) {
> +		mutex_lock(&pcpu_alloc_mutex);
> +		pcpu_balance_free(type);
> +		pcpu_balance_populated(type);
> +		mutex_unlock(&pcpu_alloc_mutex);
> +	}
>  }
>  
>  /**
> -- 
> 2.30.2
> 

Reviewed-by: Dennis Zhou <dennis@kernel.org>

This makes sense. If you want me to pick this and the last patch up
first I can. Otherwise, do you mind moving this to the front of the
stack because it is a clean up?

Thanks,
Dennis
