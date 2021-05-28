Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AAE3946E8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 20:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhE1ST3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 14:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhE1ST1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 14:19:27 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B5BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 11:17:51 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id s107so2963940ybi.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 11:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6VUpcsJYQunF974Aj1XZZE3wjgNZfsPNkx9dPrFc48Y=;
        b=irL8GpdAHshCqnegX5n/Dw9wTvNdi/84WCTNyD2NkcPda2Z9jUp3v1JN5q3GcuIflt
         X2Wy6aM+xH1QaHl6QB3u3gVvuEawQHE3NtLMaiSUN+joT+6Vf3j8UOwbLdQtX+djiGN+
         ux9rMYsnGBHnah5wsgYjjHGAVGWh9Vz0pdklzf02ikgTR7HMVFrUT8WFA3QtLWeuXUMU
         Osg767zvux/0OS3ZE+x/8M1Pc9BGDYkO2TbTN0Dz1eusiUuJz5b1zgP1Jh+EhZSsfOl/
         jpj2i2eE/OH4UZaYLWETRWuxYuNGBF9FTs80dYuKyGNkeOA3bkNSGtUIpAIZzf/IsyYv
         1QHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6VUpcsJYQunF974Aj1XZZE3wjgNZfsPNkx9dPrFc48Y=;
        b=euPlBl3s4+DMkf1y+OVOiTIkC8kY/A3nLwYgSYijVQ9Mbd5udMHb9JsIDp9q1k3Qfw
         tgxJK75l3xVKfhQKjeFcGgtrskjmfzTeHNIbrEHVKuscSqL3rqZfLDiuUo0hW1am4KKq
         myrtv3uzBoZorsKeRaiTsH1+tYmRJqUQoYV/DuSvay7DK8iLpfGY3mFlogRs0l6w1EDg
         1CSTWbvYGfU/xFmqsiFSHvIMTjjO3UBJwvVxW465m85VyW4oR24vt+nY+GS/D/91abZC
         byb2TIV6CMkwcOQBqPMk1g+ryqGO1hyPnNdaSjwoweb4BMyXfJQMiHD/wNjrUdQLNaGS
         NUGg==
X-Gm-Message-State: AOAM532kiygTlnjNXwq4KAbCZJqvjC5s8zPwTs6yaVgj3GMrY1Mx7rbB
        JiCHRlOLkoRqWM7+m4FEsrrDIXQpef9ojkgJKFw4Yg==
X-Google-Smtp-Source: ABdhPJwrSc0j8lMEdAviEZz5R+4gnA9Lp4/Wcn3/OvlELPwo5ckbD0uG5+geAro2UEA11QICA4reOqQL/66rFL0Sua0=
X-Received: by 2002:a25:7ec4:: with SMTP id z187mr13330087ybc.136.1622225870685;
 Fri, 28 May 2021 11:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com> <20210428153542.2814175-25-Liam.Howlett@Oracle.com>
In-Reply-To: <20210428153542.2814175-25-Liam.Howlett@Oracle.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 28 May 2021 11:17:39 -0700
Message-ID: <CAJuCfpEq3xVPrk0d_UNbgNOLQ7wN5rm4wx+CK2krc-bkmGpq1Q@mail.gmail.com>
Subject: Re: [PATCH 24/94] radix tree test suite: Add keme_cache_alloc_bulk() support
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
>  tools/testing/radix-tree/linux.c      | 51 +++++++++++++++++++++++++++
>  tools/testing/radix-tree/linux/slab.h |  1 +
>  2 files changed, 52 insertions(+)
>
> diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/linux.c
> index 380bbc0a48d6..fb19a40ebb46 100644
> --- a/tools/testing/radix-tree/linux.c
> +++ b/tools/testing/radix-tree/linux.c
> @@ -99,6 +99,57 @@ void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **list)
>         for (int i = 0; i < size; i++)
>                 kmem_cache_free(cachep, list[i]);
>  }
> +int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
> +                         void **p)
> +{
> +       size_t i;
> +
> +       if (kmalloc_verbose)
> +               printk("Bulk alloc %lu\n", size);
> +
> +       if (!(gfp & __GFP_DIRECT_RECLAIM) && cachep->non_kernel < size)
> +               return 0;
> +
> +       if (!(gfp & __GFP_DIRECT_RECLAIM))
> +               cachep->non_kernel -= size;
> +
> +       pthread_mutex_lock(&cachep->lock);
> +       if (cachep->nr_objs >= size) {
> +               struct radix_tree_node *node = cachep->objs;
> +

I don't think the loop below is correct because "node" is not being
changed on each iteration:

> +               for (i = 0; i < size; i++) {
> +                       cachep->nr_objs--;
> +                       cachep->objs = node->parent;

In the above assignment cachep->objs will be assigned the same value
on all iterations.

> +                       p[i] = cachep->objs;

p[0] should point to the node, however here it would point to the node->parent.

> +               }
> +               pthread_mutex_unlock(&cachep->lock);
> +               node->parent = NULL;

here you terminated the original cachep->objs which is not even inside
the "p" list at this point (it was skipped).

> +       } else {
> +               pthread_mutex_unlock(&cachep->lock);
> +               for (i = 0; i < size; i++) {
> +                       if (cachep->align) {
> +                               posix_memalign(&p[i], cachep->align,
> +                                              cachep->size * size);
> +                       } else {
> +                               p[i] = malloc(cachep->size * size);
> +                       }
> +                       if (cachep->ctor)
> +                               cachep->ctor(p[i]);
> +                       else if (gfp & __GFP_ZERO)
> +                               memset(p[i], 0, cachep->size);
> +               }
> +       }
> +
> +       for (i = 0; i < size; i++) {
> +               uatomic_inc(&nr_allocated);
> +               uatomic_inc(&nr_tallocated);

I don't see nr_tallocated even in linux-next branch. Was it introduced
in one of the previous patches and I missed it?

> +               if (kmalloc_verbose)
> +                       printf("Allocating %p from slab\n", p[i]);
> +       }
> +
> +       return size;
> +}
> +
>
>  void *kmalloc(size_t size, gfp_t gfp)
>  {
> diff --git a/tools/testing/radix-tree/linux/slab.h b/tools/testing/radix-tree/linux/slab.h
> index 53b79c15b3a2..ba42b8cc11d0 100644
> --- a/tools/testing/radix-tree/linux/slab.h
> +++ b/tools/testing/radix-tree/linux/slab.h
> @@ -25,4 +25,5 @@ struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
>                         void (*ctor)(void *));
>
>  void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t, void **);
> +int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t, size_t, void **);
>  #endif         /* SLAB_H */
> --
> 2.30.2
