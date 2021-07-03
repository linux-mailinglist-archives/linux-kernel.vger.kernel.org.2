Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909993BAA8C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 01:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhGCXFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 19:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhGCXFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 19:05:31 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28002C061762
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jul 2021 16:02:56 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so2172141otp.8
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jul 2021 16:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FRTDgOZgZbls4sTZyy9sI9ZjYiInG/eav6pR4QQPXLo=;
        b=h1D0fBUQCVYZX8BDjPtlRYvPBQzXYsHRZt5iiGkdyJDEEDxpNUgKiKkkzMI6PlLwP9
         IgsFCylodGaNuiFVCwGuFnOkXl4+SprHEsdd6I9HI1Z8i1UNptbyP+RbEnxLtvyPwToM
         IvNv/Q1dXXMQrhYFNL9wB6iTphcHPVWVd/xjqVBBs9XccUmM75F6oB9wULdv9YQjQNK4
         W/5MaWbnVcCx5POmNHC6EYzNniWfZtHJiKV8MkBU7yww1Zyqf8KOEpgGrUpKyaBvVh39
         Fuxg5wj73UGnibHy65Khw3ysZSO9DZesr6Mti4G3oDHXaTjMYDmbQ15Je4txzI0VzGYh
         VCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=FRTDgOZgZbls4sTZyy9sI9ZjYiInG/eav6pR4QQPXLo=;
        b=aHYS0okNuuZauK4q26TLm5Wcop7vTpHFkie4MuKd88QrljeDjnR7NttLL7GustOd7H
         fXUjgiicspV14hh3Fkc7ZAV13C5G+8aFUbdJ/DUhXqP19pPBNs3e9At8FaDM3WvkcxG/
         0+YhnamSnhEcVQ6d4ZaTch25+bK7MVYAeVvVM2n9bTxzEEBUxjkOKhmxK4ySK16BG8Ik
         eo4Rl/y7+B7VUSku8pgiB/Oy5VajvM8iRQN2N65XsJjKR6pICnyTw5Kq+31wM0ZDiRaD
         8AsauR9cGLtDVBVtvrHHjcjjL7B7NULDNN34nUU/kFdXF5HTMy86Y9SJ5KaAZHedutQG
         0wqA==
X-Gm-Message-State: AOAM533uflff/Cixsm4wv+TLx2uwsVuNTXvrJuUvOhHs1QtTLcUQIPe8
        JEiJUkmTzVzgI0Cd+uYORc8=
X-Google-Smtp-Source: ABdhPJxfZM8zas4N6eCW6JGwqRlo1tCi1AliiYSBo0EphgrTSVwYjH1EHkJpZQIUDR4fDvox65pnyw==
X-Received: by 2002:a9d:60dd:: with SMTP id b29mr3036778otk.289.1625353375270;
        Sat, 03 Jul 2021 16:02:55 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z2sm1552635otm.2.2021.07.03.16.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 16:02:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 3 Jul 2021 16:02:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: flush tlb in pcpu_reclaim_populated()
Message-ID: <20210703230253.GA2242521@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2021 at 09:05:23PM +0000, Dennis Zhou wrote:
> Prior to "percpu: implement partial chunk depopulation",
> pcpu_depopulate_chunk() was called only on the destruction path. This
> meant the virtual address range was on its way back to vmalloc which
> will handle flushing the tlbs for us.
> 
> However, with pcpu_reclaim_populated(), we are now calling
> pcpu_depopulate_chunk() during the active lifecycle of a chunk.
> Therefore, we need to flush the tlb as well otherwise we can end up
> accessing the wrong page through an invalid tlb mapping as reported in
> [1].
> 
> [1] https://lore.kernel.org/lkml/20210702191140.GA3166599@roeck-us.net/
> 
> Fixes: f183324133ea ("percpu: implement partial chunk depopulation")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
> I think I'm happier with this. It does the same thing as [2] but moves
> the flush to the caller so we can batch per chunk.
> 
> [2] https://lore.kernel.org/lkml/20210703040449.3213210-1-dennis@kernel.org/
> 
>  mm/percpu-km.c |  6 ++++++
>  mm/percpu-vm.c |  5 +++--
>  mm/percpu.c    | 29 +++++++++++++++++++++++------
>  3 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/percpu-km.c b/mm/percpu-km.c
> index c9d529dc7651..fe31aa19db81 100644
> --- a/mm/percpu-km.c
> +++ b/mm/percpu-km.c
> @@ -32,6 +32,12 @@
>  
>  #include <linux/log2.h>
>  
> +static void pcpu_post_unmap_tlb_flush(struct pcpu_chunk *chunk,
> +				      int page_start, int page_end)
> +{
> +	/* nothing */
> +}
> +
>  static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
>  			       int page_start, int page_end, gfp_t gfp)
>  {
> diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> index ee5d89fcd66f..2054c9213c43 100644
> --- a/mm/percpu-vm.c
> +++ b/mm/percpu-vm.c
> @@ -303,6 +303,9 @@ static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
>   * For each cpu, depopulate and unmap pages [@page_start,@page_end)
>   * from @chunk.
>   *
> + * Caller is required to call pcpu_post_unmap_tlb_flush() if not returning the
> + * region back to vmalloc() which will lazily flush the tlb.
> + *
>   * CONTEXT:
>   * pcpu_alloc_mutex.
>   */
> @@ -324,8 +327,6 @@ static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
>  
>  	pcpu_unmap_pages(chunk, pages, page_start, page_end);
>  
> -	/* no need to flush tlb, vmalloc will handle it lazily */
> -
>  	pcpu_free_pages(chunk, pages, page_start, page_end);
>  }
>  
> diff --git a/mm/percpu.c b/mm/percpu.c
> index b4cebeca4c0c..8d8efd668f76 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1572,6 +1572,7 @@ static void pcpu_chunk_depopulated(struct pcpu_chunk *chunk,
>   *
>   * pcpu_populate_chunk		- populate the specified range of a chunk
>   * pcpu_depopulate_chunk	- depopulate the specified range of a chunk
> + * pcpu_post_unmap_tlb_flush	- flush tlb for the specified range of a chunk
>   * pcpu_create_chunk		- create a new chunk
>   * pcpu_destroy_chunk		- destroy a chunk, always preceded by full depop
>   * pcpu_addr_to_page		- translate address to physical address
> @@ -1581,6 +1582,8 @@ static int pcpu_populate_chunk(struct pcpu_chunk *chunk,
>  			       int page_start, int page_end, gfp_t gfp);
>  static void pcpu_depopulate_chunk(struct pcpu_chunk *chunk,
>  				  int page_start, int page_end);
> +static void pcpu_post_unmap_tlb_flush(struct pcpu_chunk *chunk,
> +				      int page_start, int page_end);
>  static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp);
>  static void pcpu_destroy_chunk(struct pcpu_chunk *chunk);
>  static struct page *pcpu_addr_to_page(void *addr);
> @@ -2137,11 +2140,12 @@ static void pcpu_reclaim_populated(void)
>  {
>  	struct pcpu_chunk *chunk;
>  	struct pcpu_block_md *block;
> +	int freed_page_start, freed_page_end;
>  	int i, end;
> +	bool reintegrate;
>  
>  	lockdep_assert_held(&pcpu_lock);
>  
> -restart:
>  	/*
>  	 * Once a chunk is isolated to the to_depopulate list, the chunk is no
>  	 * longer discoverable to allocations whom may populate pages.  The only
> @@ -2157,6 +2161,9 @@ static void pcpu_reclaim_populated(void)
>  		 * Scan chunk's pages in the reverse order to keep populated
>  		 * pages close to the beginning of the chunk.
>  		 */
> +		freed_page_start = chunk->nr_pages;
> +		freed_page_end = 0;
> +		reintegrate = false;
>  		for (i = chunk->nr_pages - 1, end = -1; i >= 0; i--) {
>  			/* no more work to do */
>  			if (chunk->nr_empty_pop_pages == 0)
> @@ -2164,8 +2171,8 @@ static void pcpu_reclaim_populated(void)
>  
>  			/* reintegrate chunk to prevent atomic alloc failures */
>  			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH) {
> -				pcpu_reintegrate_chunk(chunk);
> -				goto restart;
> +				reintegrate = true;
> +				goto end_chunk;
>  			}
>  
>  			/*
> @@ -2194,16 +2201,26 @@ static void pcpu_reclaim_populated(void)
>  			spin_lock_irq(&pcpu_lock);
>  
>  			pcpu_chunk_depopulated(chunk, i + 1, end + 1);
> +			freed_page_start = min(freed_page_start, i + 1);
> +			freed_page_end = max(freed_page_end, end + 1);
>  
>  			/* reset the range and continue */
>  			end = -1;
>  		}
>  
> -		if (chunk->free_bytes == pcpu_unit_size)
> +end_chunk:
> +		/* batch tlb flush per chunk to amortize cost */
> +		if (freed_page_start < freed_page_end) {
> +			pcpu_post_unmap_tlb_flush(chunk,
> +						  freed_page_start,
> +						  freed_page_end);
> +		}
> +
> +		if (reintegrate || chunk->free_bytes == pcpu_unit_size)
>  			pcpu_reintegrate_chunk(chunk);
>  		else
> -			list_move(&chunk->list,
> -				  &pcpu_chunk_lists[pcpu_sidelined_slot]);
> +			list_move_tail(&chunk->list,
> +				       &pcpu_chunk_lists[pcpu_sidelined_slot]);
>  	}
>  }
>  
> -- 
> 2.32.0.93.g670b81a890-goog
> 
