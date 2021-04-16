Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D27F362A04
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 23:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241978AbhDPVQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 17:16:21 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:40845 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbhDPVQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:16:13 -0400
Received: by mail-io1-f48.google.com with SMTP id e186so29035327iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 14:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+W0hnQa1CjbAyTNkhndY0LLW1aGekZ/YUtZf1MUBxVw=;
        b=b9QsuEb7Lstf7AQwzle3+6XYJ2xOXlicY639q+75SaZ7N1SGKY1RM3FYse+pnKr1Od
         771tOKuHOcUKypoaR+ptwI9sJ35gdfo7HZF4sF6PcQ4lBhII3IqJLncx2F4oWIWVNrJT
         QFrkrXDMfYlsIJbGadsIq4IpYsshb1wdAiqoLAGpiolCtcoOJk8ol3d11xydBOFvFQTf
         /CzvASNaKVYIBFcGeFOkLD7j+H/g6WFu1u3zadVk7qJFguLI3KQwI5Qcz6GFJtnnsGyh
         m38N+jpgVNZsLvevYKDkrP7e5dDvqmJiNblQS7STtXtnRqbYiWYei9980m5VxxZVSZL/
         BgLg==
X-Gm-Message-State: AOAM530T/migHSXmZkiShzfOa3/5Lp2xYl1qENw/sLj4WwHL/G3lq5qZ
        yGC2PWQ5HcC/CsxOErtXbJg=
X-Google-Smtp-Source: ABdhPJwySTTp9aY4FHoEo5+4VzJHcJ4gs/hwoO7Tsr3Q4kn0nmLjqLR5pdwJZb2AZCaL8PyOujadyw==
X-Received: by 2002:a02:a616:: with SMTP id c22mr5275872jam.129.1618607727888;
        Fri, 16 Apr 2021 14:15:27 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id s1sm852425iov.52.2021.04.16.14.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:15:27 -0700 (PDT)
Date:   Fri, 16 Apr 2021 21:15:25 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] percpu: factor out pcpu_check_chunk_hint()
Message-ID: <YHn+beQ8QRpm8WqU@google.com>
References: <20210408035736.883861-1-guro@fb.com>
 <20210408035736.883861-6-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408035736.883861-6-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Apr 07, 2021 at 08:57:35PM -0700, Roman Gushchin wrote:
> Factor out the pcpu_check_chunk_hint() helper, which will be useful
> in the future. The new function checks if the allocation can likely
> fit the given chunk.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/percpu.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index e20119668c42..357fd6994278 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -306,6 +306,26 @@ static unsigned long pcpu_block_off_to_off(int index, int off)
>  	return index * PCPU_BITMAP_BLOCK_BITS + off;
>  }
>  
> +/**
> + * pcpu_check_chunk_hint - check that allocation can fit a chunk
> + * @chunk_md: chunk's block

nit for consistency: @block: block of interest

> + * @bits: size of request in allocation units
> + * @align: alignment of area (max PAGE_SIZE)
> + *
> + * Check to see if the allocation can fit in the chunk's contig hint.
> + * This is an optimization to prevent scanning by assuming if it
> + * cannot fit in the global hint, there is memory pressure and creating
> + * a new chunk would happen soon.
> + */

It occurred to me, That I converged block_md and chunk_md to be the same
object as 1 is just a degenerative case of the other. Can we rename this
to be pcpu_check_block_hint() and have it take in pcpu_block_md?

> +static bool pcpu_check_chunk_hint(struct pcpu_block_md *chunk_md, int bits,
> +				  size_t align)
> +{
> +	int bit_off = ALIGN(chunk_md->contig_hint_start, align) -
> +		chunk_md->contig_hint_start;
> +
> +	return bit_off + bits <= chunk_md->contig_hint;
> +}
> +
>  /*
>   * pcpu_next_hint - determine which hint to use
>   * @block: block of interest
> @@ -1065,15 +1085,7 @@ static int pcpu_find_block_fit(struct pcpu_chunk *chunk, int alloc_bits,
>  	struct pcpu_block_md *chunk_md = &chunk->chunk_md;
>  	int bit_off, bits, next_off;
>  
> -	/*
> -	 * Check to see if the allocation can fit in the chunk's contig hint.
> -	 * This is an optimization to prevent scanning by assuming if it
> -	 * cannot fit in the global hint, there is memory pressure and creating
> -	 * a new chunk would happen soon.
> -	 */
> -	bit_off = ALIGN(chunk_md->contig_hint_start, align) -
> -		  chunk_md->contig_hint_start;
> -	if (bit_off + alloc_bits > chunk_md->contig_hint)
> +	if (!pcpu_check_chunk_hint(chunk_md, alloc_bits, align))
>  		return -1;
>  
>  	bit_off = pcpu_next_hint(chunk_md, alloc_bits);
> -- 
> 2.30.2
> 

Thanks,
Dennis
