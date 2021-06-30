Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34213B84A2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 16:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhF3OHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 10:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbhF3OGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:06:50 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94728C06122E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 07:03:09 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id g13-20020a4ac4cd0000b029024c717ed8aeso638398ooq.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 07:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0F//f0x+IlSuTVhD2o09FmJBTCLPD1WCy4S2G9ePpc=;
        b=a/z4bOFfSrZMHOKq5nfEiUadvfO9+JWMzXVisHQSDedJlx2RH1WWBTmLDfoP3mBcqk
         9t5uMt+LafclLyJtVbIYofEIeLsPuQGK+gRNQKyq1jgdZesUWyYgfJUbr7j6j0gwqkGs
         9LMkxjqjGFyiXtkz3b272td5PsqwfV+pwgfxudf2tQvTt2/J5+1MfWEHJfXQCJPIP7Xq
         AuWIshMO2OFbzJwXxyAVl9XrT8q5hc2ejH7LwaZpghqKIBEpexfL1nqL9gIz4cVHw+nN
         4XaFnYBXIrDLHFwmghFwT5h3lf8ipJiRDNdEpcABg2X4WP1mH+6MObCP1xcExYBn33p4
         59vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0F//f0x+IlSuTVhD2o09FmJBTCLPD1WCy4S2G9ePpc=;
        b=hJj2r1hQLqJSe7mv+f00VWV9a2TOON8dEhLRN7UaKWivYFdnmJxw4og82Jrr5NkTle
         7yeOEM9WrKOIxbhvJe5ApQOa2OzrAvUeHfDBds0+gfqXttl1/dWUviMRH/v1yyuXpSO0
         tAoKvbebX3HGs4iekLCkclnuvsxjaYlSVNE0ZXdS/0Yx/7bWc7nzGjxSjgX3038Nq8+k
         dhQY4f2xckDjvByqZD0YgL/zi+OYkklBwyEsmszoiWK2DyKZFkzJRnw/tuS+0plogj7L
         0bwqs3aTDc6z/nZ0sb7HFdWtMquIJ/QNZ5xs6NDApaOvKwMll7dDmYzW+jC34rYZ3ayK
         bCFQ==
X-Gm-Message-State: AOAM533EDA1FJGMBVidRNIIA4eI26NP6pxxh9B+XUDO8duJua60G1yLt
        FxAXDhmGfr2l2C7ZihjSVZb1hOdRiptUtwZ5CE55iQ==
X-Google-Smtp-Source: ABdhPJzhU6va1OQ+ffknnRGi+3XNwnd77TIu63SOlmaTjFu4VTxpZBUWtxk+KN60aRBNpB1K8W1vcePNsu1717j+uRY=
X-Received: by 2002:a4a:6049:: with SMTP id t9mr8547439oof.14.1625061788645;
 Wed, 30 Jun 2021 07:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210630135313.1072577-1-glider@google.com> <20210630135313.1072577-2-glider@google.com>
In-Reply-To: <20210630135313.1072577-2-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 30 Jun 2021 16:02:53 +0200
Message-ID: <CANpmjNPuFY66OwXxTvGs_t8eic1et9ZMJV5RDL_mkPVNkHqHzg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kfence: skip all GFP_ZONEMASK allocations
To:     Alexander Potapenko <glider@google.com>
Cc:     akpm@linux-foundation.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, gregkh@linuxfoundation.org,
        jrdr.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2021 at 15:53, Alexander Potapenko <glider@google.com> wrote:
> Allocation requests outside ZONE_NORMAL (MOVABLE, HIGHMEM or DNA) cannot

s/DNA/DMA/
... but probably no need to do v4 just for this (everyone knows we're
not yet in the business of allocating DNA ;-)).

> be fulfilled by KFENCE, because KFENCE memory pool is located in a
> zone different from the requested one.
>
> Because callers of kmem_cache_alloc() may actually rely on the
> allocation to reside in the requested zone (e.g. memory allocations done
> with __GFP_DMA must be DMAable), skip all allocations done with
> GFP_ZONEMASK and/or respective SLAB flags (SLAB_CACHE_DMA and
> SLAB_CACHE_DMA32).
>
> Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: stable@vger.kernel.org # 5.12+
> Signed-off-by: Alexander Potapenko <glider@google.com>

With the change below, you can add:

  Reviewed-by: Marco Elver <elver@google.com>


> ---
>
> v2:
>  - added parentheses around the GFP clause, as requested by Marco
> v3:
>  - ignore GFP_ZONEMASK, which also covers __GFP_HIGHMEM and __GFP_MOVABLE
>  - move the flag check at the beginning of the function, as requested by
>    Souptick Joarder
> ---
>  mm/kfence/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 33bb20d91bf6a..d51f77329fd3c 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -740,6 +740,14 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
>         if (size > PAGE_SIZE)
>                 return NULL;
>
> +       /*
> +        * Skip allocations from non-default zones, including DMA. We cannot guarantee that pages
> +        * in the KFENCE pool will have the requested properties (e.g. reside in DMAable memory).

Comments should still be 80 cols, like the rest of the file. :-/

> +        */
> +       if ((flags & GFP_ZONEMASK) ||
> +           (s->flags & (SLAB_CACHE_DMA | SLAB_CACHE_DMA32)))
> +               return NULL;
> +
>         /*
>          * allocation_gate only needs to become non-zero, so it doesn't make
>          * sense to continue writing to it and pay the associated contention
> --
> 2.32.0.93.g670b81a890-goog
>
