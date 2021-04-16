Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786BF3629EB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 23:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344062AbhDPVH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 17:07:26 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:33551 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343949AbhDPVHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:07:25 -0400
Received: by mail-io1-f47.google.com with SMTP id a11so26913082ioo.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 14:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EKyEsfbEdP05yBqMIYFaM4FBS/vxypwwn4CFBa3hXxE=;
        b=rGMAcyqD0GHTHZY8DsqblUO+zfJcwT2QBposuvlpW5kIDpcEXK1fzdjBd0eQlZezln
         v29m40uL5HVuI4FF9lfxkmrmSWsPjmrwiatQlIxX8ZYmMcuR82DLkkW8s7acdefcPQXz
         Fa1jVw4WFDjdB8CbfcNAMEdSfMUfTnTuIawIlXntlUEfwuOcJqLK2cinusFewtAPAYx1
         qJspvfFWui2Hgl2chQc6OR1EoX38HJSYPrvmgw06eiailwdrcdrVuv2rr+8sMsLYjqKI
         HkHnPFJgEVXuiqFZgA+++tLlKG9uvcm2z4gRToULNPO+FwM/QIFCWej/fzboOQp/HUwq
         307Q==
X-Gm-Message-State: AOAM530TmIMK198OLRz5f/Smq5plcZe1BHNwysRkV7fsriNIcdGaEjzL
        gZraL5zp3y+Wi7nS5ayo7mo=
X-Google-Smtp-Source: ABdhPJxjVZQeVCWbhjpOcQjmzBete1gMjhI+YNLMIcDRzmrV93dS5EkCfshSqp+WXQl2rImFSTvAKg==
X-Received: by 2002:a6b:7e0c:: with SMTP id i12mr5107770iom.196.1618607218632;
        Fri, 16 Apr 2021 14:06:58 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id m5sm3213345ilg.79.2021.04.16.14.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:06:58 -0700 (PDT)
Date:   Fri, 16 Apr 2021 21:06:57 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] percpu: split __pcpu_balance_workfn()
Message-ID: <YHn8cURoctyYV5LT@google.com>
References: <20210408035736.883861-1-guro@fb.com>
 <20210408035736.883861-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408035736.883861-3-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Apr 07, 2021 at 08:57:32PM -0700, Roman Gushchin wrote:
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
> Reviewed-by: Dennis Zhou <dennis@kernel.org>
> ---
>  mm/percpu.c | 46 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 2f27123bb489..7e31e1b8725f 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1933,31 +1933,22 @@ void __percpu *__alloc_reserved_percpu(size_t size, size_t align)
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
> @@ -1985,6 +1976,25 @@ static void __pcpu_balance_workfn(enum pcpu_chunk_type type)
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
> @@ -2054,22 +2064,24 @@ static void __pcpu_balance_workfn(enum pcpu_chunk_type type)
>  			goto retry_pop;
>  		}
>  	}
> -
> -	mutex_unlock(&pcpu_alloc_mutex);
>  }
>  
>  /**
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
> 

I've applied this to for-5.14.

Thanks,
Dennis
