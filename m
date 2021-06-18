Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B483AC10F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 04:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhFRCzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 22:55:16 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:43589 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhFRCzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 22:55:15 -0400
Received: by mail-io1-f50.google.com with SMTP id k16so5417438ios.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 19:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SDWeQISHJ4j5pHR3hlooWBcjy0lmkm8xWsM2aTeQjac=;
        b=YGXNZtMPMbQWOoh7C0+aam5E5xDsmkP1GltUHv8lWMlBlwfTjtfbhzLu5z1x6YybPL
         H7KXQvMPFd6TD+I6yPnmMiTn7fIHDzAo66Ipa8CVFdvMu2lBLU1sbsBcczpS1ai0TxuA
         k1MiKQSiJ+RP6dqdZNYF9fSUIEJhoNRSfQubza2zV6gdzt2oHRor/VcTx7RVlwJjqhZI
         /3xNX3zW46aZSkHuwpjrBBt+A5VpZfEYD2HM5SWERoTNogHxASac4KWrcKk7OU0u8d64
         5dxDcKRuQHrqfgporn1asbXUgBgddSzbQfNdpqhIPI4UbViIm7xGGJub356w4Kt4a6KW
         Eh9Q==
X-Gm-Message-State: AOAM532V+WuHVKKtFpdsXlaDClIiJ4UaiCBjW3WXt9yc6GmVX7MP75hZ
        CIXe2oGPolFK1732PlLoYxE=
X-Google-Smtp-Source: ABdhPJwJQHFhl4GJ+Max18sHnW1XiMYPvOP8W1h5MMA+wQ2c2NSucJh/dr8YLKj4CsHZdI5+xZmu1Q==
X-Received: by 2002:a6b:7c07:: with SMTP id m7mr1469288iok.177.1623984785393;
        Thu, 17 Jun 2021 19:53:05 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id v18sm3791164iom.5.2021.06.17.19.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 19:53:05 -0700 (PDT)
Date:   Fri, 18 Jun 2021 02:53:03 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] percpu: optimize locking in pcpu_balance_workfn()
Message-ID: <YMwKj10VhO5JTMjE@google.com>
References: <20210617190322.3636731-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617190322.3636731-1-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jun 17, 2021 at 12:03:22PM -0700, Roman Gushchin wrote:
> pcpu_balance_workfn() unconditionally calls pcpu_balance_free(),
> pcpu_reclaim_populated(), pcpu_balance_populated() and
> pcpu_balance_free() again.
> 
> Each call to pcpu_balance_free() and pcpu_reclaim_populated() will
> cause at least one acquisition of the pcpu_lock. So even if the
> balancing was scheduled because of a failed atomic allocation,
> pcpu_lock will be acquired at least 4 times. This obviously
> increases the contention on the pcpu_lock.
> 
> To optimize the scheme let's grab the pcpu_lock on the upper level
> (in pcpu_balance_workfn()) and keep it generally locked for the whole
> duration of the scheduled work, but release conditionally to perform
> any slow operations like chunk (de)population and creation of new
> chunks.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/percpu.c | 41 +++++++++++++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index e7b9ca82e9aa..deee7e5bb255 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1980,6 +1980,9 @@ void __percpu *__alloc_reserved_percpu(size_t size, size_t align)
>   * If empty_only is %false, reclaim all fully free chunks regardless of the
>   * number of populated pages.  Otherwise, only reclaim chunks that have no
>   * populated pages.
> + *
> + * CONTEXT:
> + * pcpu_lock (can be dropped temporarily)
>   */
>  static void pcpu_balance_free(bool empty_only)
>  {
> @@ -1987,12 +1990,12 @@ static void pcpu_balance_free(bool empty_only)
>  	struct list_head *free_head = &pcpu_chunk_lists[pcpu_free_slot];
>  	struct pcpu_chunk *chunk, *next;
>  
> +	lockdep_assert_held(&pcpu_lock);
> +
>  	/*
>  	 * There's no reason to keep around multiple unused chunks and VM
>  	 * areas can be scarce.  Destroy all free chunks except for one.
>  	 */
> -	spin_lock_irq(&pcpu_lock);
> -
>  	list_for_each_entry_safe(chunk, next, free_head, list) {
>  		WARN_ON(chunk->immutable);
>  
> @@ -2004,8 +2007,10 @@ static void pcpu_balance_free(bool empty_only)
>  			list_move(&chunk->list, &to_free);
>  	}
>  
> -	spin_unlock_irq(&pcpu_lock);
> +	if (list_empty(&to_free))
> +		return;
>  
> +	spin_unlock_irq(&pcpu_lock);
>  	list_for_each_entry_safe(chunk, next, &to_free, list) {
>  		unsigned int rs, re;
>  
> @@ -2019,6 +2024,7 @@ static void pcpu_balance_free(bool empty_only)
>  		pcpu_destroy_chunk(chunk);
>  		cond_resched();
>  	}
> +	spin_lock_irq(&pcpu_lock);
>  }
>  
>  /**
> @@ -2029,6 +2035,9 @@ static void pcpu_balance_free(bool empty_only)
>   * OOM killer to be triggered.  We should avoid doing so until an actual
>   * allocation causes the failure as it is possible that requests can be
>   * serviced from already backed regions.
> + *
> + * CONTEXT:
> + * pcpu_lock (can be dropped temporarily)
>   */
>  static void pcpu_balance_populated(void)
>  {
> @@ -2037,6 +2046,8 @@ static void pcpu_balance_populated(void)
>  	struct pcpu_chunk *chunk;
>  	int slot, nr_to_pop, ret;
>  
> +	lockdep_assert_held(&pcpu_lock);
> +
>  	/*
>  	 * Ensure there are certain number of free populated pages for
>  	 * atomic allocs.  Fill up from the most packed so that atomic
> @@ -2064,13 +2075,11 @@ static void pcpu_balance_populated(void)
>  		if (!nr_to_pop)
>  			break;
>  
> -		spin_lock_irq(&pcpu_lock);
>  		list_for_each_entry(chunk, &pcpu_chunk_lists[slot], list) {
>  			nr_unpop = chunk->nr_pages - chunk->nr_populated;
>  			if (nr_unpop)
>  				break;
>  		}
> -		spin_unlock_irq(&pcpu_lock);
>  
>  		if (!nr_unpop)
>  			continue;
> @@ -2080,12 +2089,13 @@ static void pcpu_balance_populated(void)
>  					     chunk->nr_pages) {
>  			int nr = min_t(int, re - rs, nr_to_pop);
>  
> +			spin_unlock_irq(&pcpu_lock);
>  			ret = pcpu_populate_chunk(chunk, rs, rs + nr, gfp);
> +			cond_resched();
> +			spin_lock_irq(&pcpu_lock);
>  			if (!ret) {
>  				nr_to_pop -= nr;
> -				spin_lock_irq(&pcpu_lock);
>  				pcpu_chunk_populated(chunk, rs, rs + nr);
> -				spin_unlock_irq(&pcpu_lock);
>  			} else {
>  				nr_to_pop = 0;
>  			}
> @@ -2097,11 +2107,12 @@ static void pcpu_balance_populated(void)
>  
>  	if (nr_to_pop) {
>  		/* ran out of chunks to populate, create a new one and retry */
> +		spin_unlock_irq(&pcpu_lock);
>  		chunk = pcpu_create_chunk(gfp);
> +		cond_resched();
> +		spin_lock_irq(&pcpu_lock);
>  		if (chunk) {
> -			spin_lock_irq(&pcpu_lock);
>  			pcpu_chunk_relocate(chunk, -1);
> -			spin_unlock_irq(&pcpu_lock);
>  			goto retry_pop;
>  		}
>  	}
> @@ -2117,6 +2128,10 @@ static void pcpu_balance_populated(void)
>   * populated pages threshold, reintegrate the chunk if it has empty free pages.
>   * Each chunk is scanned in the reverse order to keep populated pages close to
>   * the beginning of the chunk.
> + *
> + * CONTEXT:
> + * pcpu_lock (can be dropped temporarily)
> + *
>   */
>  static void pcpu_reclaim_populated(void)
>  {
> @@ -2124,7 +2139,7 @@ static void pcpu_reclaim_populated(void)
>  	struct pcpu_block_md *block;
>  	int i, end;
>  
> -	spin_lock_irq(&pcpu_lock);
> +	lockdep_assert_held(&pcpu_lock);
>  
>  restart:
>  	/*
> @@ -2190,8 +2205,6 @@ static void pcpu_reclaim_populated(void)
>  			list_move(&chunk->list,
>  				  &pcpu_chunk_lists[pcpu_sidelined_slot]);
>  	}
> -
> -	spin_unlock_irq(&pcpu_lock);
>  }
>  
>  /**
> @@ -2212,10 +2225,14 @@ static void pcpu_balance_workfn(struct work_struct *work)
>  	 * appropriate.
>  	 */
>  	mutex_lock(&pcpu_alloc_mutex);
> +	spin_lock_irq(&pcpu_lock);
> +
>  	pcpu_balance_free(false);
>  	pcpu_reclaim_populated();
>  	pcpu_balance_populated();
>  	pcpu_balance_free(true);
> +
> +	spin_unlock_irq(&pcpu_lock);
>  	mutex_unlock(&pcpu_alloc_mutex);
>  }
>  
> -- 
> 2.31.1
> 

I've applied this to for-5.14.

Thanks,
Dennis
