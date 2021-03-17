Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B27B33EBA7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhCQIi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCQIiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:38:46 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6301C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:38:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z2so899779wrl.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2i0xfPlcj0R7orAOCHVfIWfI1iiOnTAxO0LsIr7b+yo=;
        b=gPyIMb4jZqIQk6gaiWJgguRRKa7sKRivhhMPnxSXkJz86PkoitTBPbhizjRm+Hkmv3
         4jTxGsxeuqA1Ui9h2hSSfb5ZIPA++1VzZU2GonexbyYYq7sQ1ER44TCiLaUUAgZodqS0
         YH4DgsLLctyORruGmLYKCWT1s0eigXlx8UdPZvJuMVwOBnNoyHJYmM6pZDmZfMI+epHQ
         He8dnDcFtgYjOpxiKE8YQyaMhFNB/AFJqaShZ8DRBKyDeByvRYvMmQHHb61DonnT6IQ2
         P/IqXjF/zrZHDvoqqXXl+JvvserIRqTnrHdmXQ+Rp0iy2TR2zMZsdyQXrMbMaxU+em09
         G+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2i0xfPlcj0R7orAOCHVfIWfI1iiOnTAxO0LsIr7b+yo=;
        b=QTEugpPfRyrn3oF3LmBQqd2mRGmawYrUEKyhDWRurV02qMDwp84V8yfo56Gmgm55qC
         oprpgNF8Rerhkw5sR4KVNBirWkJ/MsbQsQhiHCCnptAGpEr7a3TvdnoSqO2bcXPUTQGj
         LfO8vVNHcJ2phn8J18Ft+XoSZXNoogZ3EheilAT2paEBSfE5Sz/vpGVeiH/ytf66NFaQ
         4Q1X5aV6te3q/uWb0eK7zCABzAokNU4CWVIB43vG0/MF9jQED6YV4LGF1uUnFjHgor4S
         VfhB4PT5C2s/M6VO1ZDUDUzIXwnC4IFdjrXu4HWnVLTFn0VIviqEnKjqRQ7lyreaxsPk
         ttog==
X-Gm-Message-State: AOAM53212iPlLBR6yoS9e56qlY4wA3jwvxOaag3RLYr5NIl8WwrxvZG6
        4bzkxLtPz6P16os5YsSJT88=
X-Google-Smtp-Source: ABdhPJyVrgfRMLebJ1ITTiBNFr0rvrY5DfDfa2OH84H6X95EO/blE2eMgJ4MLzmj1SRj5Qe4IisbSw==
X-Received: by 2002:adf:82af:: with SMTP id 44mr3015737wrc.279.1615970313254;
        Wed, 17 Mar 2021 01:38:33 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id g202sm1743891wme.20.2021.03.17.01.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:38:32 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Mar 2021 09:38:30 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH v2] Increase page and bit waitqueue hash size
Message-ID: <20210317083830.GC3881262@gmail.com>
References: <20210317075427.587806-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317075427.587806-1-npiggin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nicholas Piggin <npiggin@gmail.com> wrote:

> The page waitqueue hash is a bit small (256 entries) on very big systems. A
> 16 socket 1536 thread POWER9 system was found to encounter hash collisions
> and excessive time in waitqueue locking at times. This was intermittent and
> hard to reproduce easily with the setup we had (very little real IO
> capacity). The theory is that sometimes (depending on allocation luck)
> important pages would happen to collide a lot in the hash, slowing down page
> locking, causing the problem to snowball.
> 
> An small test case was made where threads would write and fsync different
> pages, generating just a small amount of contention across many pages.
> 
> Increasing page waitqueue hash size to 262144 entries increased throughput
> by 182% while also reducing standard deviation 3x. perf before the increase:
> 
>   36.23%  [k] _raw_spin_lock_irqsave                -      -
>               |
>               |--34.60%--wake_up_page_bit
>               |          0
>               |          iomap_write_end.isra.38
>               |          iomap_write_actor
>               |          iomap_apply
>               |          iomap_file_buffered_write
>               |          xfs_file_buffered_aio_write
>               |          new_sync_write
> 
>   17.93%  [k] native_queued_spin_lock_slowpath      -      -
>               |
>               |--16.74%--_raw_spin_lock_irqsave
>               |          |
>               |           --16.44%--wake_up_page_bit
>               |                     iomap_write_end.isra.38
>               |                     iomap_write_actor
>               |                     iomap_apply
>               |                     iomap_file_buffered_write
>               |                     xfs_file_buffered_aio_write
> 
> This patch uses alloc_large_system_hash to allocate a bigger system hash
> that scales somewhat with memory size. The bit/var wait-queue is also
> changed to keep code matching, albiet with a smaller scale factor.
> 
> A very small CONFIG_BASE_SMALL option is also added because these are two
> of the biggest static objects in the image on very small systems.
> 
> This hash could be made per-node, which may help reduce remote accesses
> on well localised workloads, but that adds some complexity with indexing
> and hotplug, so until we get a less artificial workload to test with,
> keep it simple.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  kernel/sched/wait_bit.c | 30 +++++++++++++++++++++++-------
>  mm/filemap.c            | 24 +++++++++++++++++++++---
>  2 files changed, 44 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
> index 02ce292b9bc0..dba73dec17c4 100644
> --- a/kernel/sched/wait_bit.c
> +++ b/kernel/sched/wait_bit.c
> @@ -2,19 +2,24 @@
>  /*
>   * The implementation of the wait_bit*() and related waiting APIs:
>   */
> +#include <linux/memblock.h>
>  #include "sched.h"
>  
> -#define WAIT_TABLE_BITS 8
> -#define WAIT_TABLE_SIZE (1 << WAIT_TABLE_BITS)

Ugh, 256 entries is almost embarrassingly small indeed.

I've put your patch into sched/core, unless Andrew is objecting.

> -	for (i = 0; i < WAIT_TABLE_SIZE; i++)
> +	if (!CONFIG_BASE_SMALL) {
> +		bit_wait_table = alloc_large_system_hash("bit waitqueue hash",
> +							sizeof(wait_queue_head_t),
> +							0,
> +							22,
> +							0,
> +							&bit_wait_table_bits,
> +							NULL,
> +							0,
> +							0);
> +	}
> +	for (i = 0; i < BIT_WAIT_TABLE_SIZE; i++)
>  		init_waitqueue_head(bit_wait_table + i);


Meta suggestion: maybe the CONFIG_BASE_SMALL ugliness could be folded 
into alloc_large_system_hash() itself?

> --- a/mm/filemap.c
> +++ b/mm/filemap.c

>  static wait_queue_head_t *page_waitqueue(struct page *page)
>  {
> -	return &page_wait_table[hash_ptr(page, PAGE_WAIT_TABLE_BITS)];
> +	return &page_wait_table[hash_ptr(page, page_wait_table_bits)];
>  }

I'm wondering whether you've tried to make this NUMA aware through 
page->node?

Seems like another useful step when having a global hash ...

Thanks,

	Ingo
