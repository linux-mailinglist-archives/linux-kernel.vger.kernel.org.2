Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003943946B5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 19:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhE1R5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 13:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhE1R5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 13:57:23 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A14CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 10:55:48 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id q21so3028274ybg.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 10:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hn1AVNc60k/8TwFObTTNkXfOUpUDTkTWiwTGW1kuIUU=;
        b=Ub16L2GhMdVLMZVtbHNALGfFnO7Y4qHNJ7G5VoVVyO7C048lQnw9sLgFKxXneD1pm4
         3whHirjGs/rtyaLsNUiLmUQvwFAYx/HQ3o20MAEdEMH+pAEVc37fBHvNIVZHY+KeeMuk
         UKkTt2v1hd+6u37hBlZqFUdMhY7sl5jQBA40jot0m5zVIG53TZCyg2ROC4sS7FuPeRT+
         a+7FoiPRtPHgt+evhmP1vxrJhBRPl+M8u5F6JeKkE1Ip0ZVvj5biJ37gmB+Si+BbRNRs
         GrRug4UQVv1em3U/1hqN1XwNIygyK9R105W9zozWUx0oNEWJgvcko+UYM4ddzKwOFVeQ
         Z76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hn1AVNc60k/8TwFObTTNkXfOUpUDTkTWiwTGW1kuIUU=;
        b=Acn+B7bjFlWeBJip5dyYjyGpiSFv1tgIBc5DpMFhrys/jcGARk3cIRyjPyAxJhG0Pr
         pcLu1DFe2i1ugxy8fw74RT0EpZUgu2Ese9a/RazVOJJ4zcUY0j/XrSWGVWQSjMOngYbP
         tUHaNVIqI2hIcHDb3yYqcghPit51GDCBxT6fcyCAoy3qEh3Ngk7nHS5D3rUrSfhxSwDe
         Lih9hVvbDXCRXOQIo843XDPcqnU1Aspqf24PU5uHf4oK2OKy/o0PJdfbvWMDkEAyPcA7
         4G6iFaK4MDAtZ8iAlo4955zaDka233juowuVL72ikcslc4kJRRbNjoF5NQUshkxeVfBX
         A+KQ==
X-Gm-Message-State: AOAM532zLLo9bYZUcbFEsqA86aooXT59y6FK6YPNKesJNdenYbJLQAGs
        dK1CXpP5nGfa6/YHFuoNLcztgsh84nR9ghI6VioEkA==
X-Google-Smtp-Source: ABdhPJz3AvOBpJ01ewszKXrziEAalSsR4mv0lp3oWBRj4tshjy1MFUSyVSRt8ZfewcieOksB1kvxl0Awj+6U0G+8K80=
X-Received: by 2002:a5b:7c5:: with SMTP id t5mr14573508ybq.190.1622224547288;
 Fri, 28 May 2021 10:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com> <20210428153542.2814175-24-Liam.Howlett@Oracle.com>
In-Reply-To: <20210428153542.2814175-24-Liam.Howlett@Oracle.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 28 May 2021 10:55:36 -0700
Message-ID: <CAJuCfpFSE5MSDnMQ40fRx3mJ0eCLW0QDTMCbr05nrWDtC6wbaA@mail.gmail.com>
Subject: Re: [PATCH 23/94] radix tree test suite: Add support for kmem_cache_free_bulk
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 8:36 AM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  tools/testing/radix-tree/linux.c      | 9 +++++++++
>  tools/testing/radix-tree/linux/slab.h | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/linux.c
> index 93f7de81fbe8..380bbc0a48d6 100644
> --- a/tools/testing/radix-tree/linux.c
> +++ b/tools/testing/radix-tree/linux.c
> @@ -91,6 +91,15 @@ void kmem_cache_free(struct kmem_cache *cachep, void *objp)
>         pthread_mutex_unlock(&cachep->lock);
>  }
>
> +void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **list)
> +{
> +       if (kmalloc_verbose)
> +               printk("Bulk free %p[0-%lu]\n", list, size - 1);

nit: Printing the address of the "list" is meaningless IMHO unless you
output its value in kmem_cache_alloc_bulk, which you do not.
I would also suggest combining the patch introducing
kmem_cache_alloc_bulk with this one since they seem to be
compementary.

> +
> +       for (int i = 0; i < size; i++)
> +               kmem_cache_free(cachep, list[i]);
> +}
> +
>  void *kmalloc(size_t size, gfp_t gfp)
>  {
>         void *ret;
> diff --git a/tools/testing/radix-tree/linux/slab.h b/tools/testing/radix-tree/linux/slab.h
> index 2958830ce4d7..53b79c15b3a2 100644
> --- a/tools/testing/radix-tree/linux/slab.h
> +++ b/tools/testing/radix-tree/linux/slab.h
> @@ -24,4 +24,5 @@ struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
>                         unsigned int align, unsigned int flags,
>                         void (*ctor)(void *));
>
> +void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t, void **);
>  #endif         /* SLAB_H */
> --
> 2.30.2
>
