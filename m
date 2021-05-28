Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826D139467A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 19:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhE1Rck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 13:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhE1Rci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 13:32:38 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C5AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 10:31:03 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id s107so2782207ybi.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SacFLm32CPGeImUT6UaF+ahwAEU/HeJM7D02PNPQwRo=;
        b=Jc4ed2hTaestHVmcTK4P4nRaC+VWL3oV0So8mB1CocHElSEBdtFoAUmZsv6ecIJrlW
         dbM6l7pFPlC4ExL8pXmas3UjKGa3C+Ur29gA7/p14yjaTcoIK7ko2ixpuDf0QJk64rfN
         KOHR43IPAKLV3gjmbNTLjvG/rnr1X3H58PG/R8gCDVlSEj9ALKru/JrWyO1qx1sDG1q0
         nSkWi+vl2MAXuTxeQizOTP+qJNRzyrj25Wz60SIu+NV11Jnb2RIbpDKr9/B+A4EOP2FF
         Lad81eZ/ZMGXuYVFGBf5wk3JgI/TjqrUYeHiVrM19ZfQtcG00zaDIWSywpMlxwv5SBvM
         lCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SacFLm32CPGeImUT6UaF+ahwAEU/HeJM7D02PNPQwRo=;
        b=lhW6eZvoqnLX9VxuXQ96V+qRsIM5Y2mSoblCc4tWGB417vCjqQZkvvOK7YqjNrqcrg
         GegkXphh/tF+d0Z4aTDUJPaH9gOahft8JWCDmq738lycRZ++2p7S9uePdxK8cg/XQdjx
         0O1rQoJJ+/QZ87JdMI/YGS4btyd/fkCymFo6JS+YXKdtxHMqelqKEPwjh2XvRjWuh+7X
         iYsssSpyPX7dfu2tzjf/fQEaR77Q34/+Vcw1vR2CcHx0Q+zI50l7I9JlZfhI85jPCTso
         hsQo8kfbDI3AGbcT+M3ZqLVRDzhdMqR2hvlZzQPYRa9j9MLIGilIa6CDxdEhrdUXwpNG
         ErZw==
X-Gm-Message-State: AOAM533Yfx8aLr8yYwL3ejhnNidoSCBMP1az088rBLjE3gZjB12AvJ3P
        M3JDt7QNGJEMRVcnA1uaWVvh0iroP0liaSyyzrJkHIPmTFsCbg==
X-Google-Smtp-Source: ABdhPJwwOonwugncLBiTpOm/BDnPzn0zHyFewgcqdzv2JOcSBQwp4vpGpivdYkT17BEo5+sVj5puKNB8ACQhv10EU/0=
X-Received: by 2002:a25:9c88:: with SMTP id y8mr12578188ybo.294.1622223062894;
 Fri, 28 May 2021 10:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com> <20210428153542.2814175-22-Liam.Howlett@Oracle.com>
In-Reply-To: <20210428153542.2814175-22-Liam.Howlett@Oracle.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 28 May 2021 10:30:51 -0700
Message-ID: <CAJuCfpHto4kwjPuC-9iH9Pp45OO-6TJnHLGtfyJ-VtiaNstrAA@mail.gmail.com>
Subject: Re: [PATCH 21/94] radix tree test suite: Enhancements for Maple Tree
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

I know you have v2 for the first part of this patchset, I'm just going
over the whole thing... There should be some description here of what
the new struct member and new function are for. Ideally you would also
split it in two because it introduces two seemingly independent
additions: non_kernel and kmem_cache_get_alloc.

> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  tools/testing/radix-tree/linux.c        | 16 +++++++++++++++-
>  tools/testing/radix-tree/linux/kernel.h |  1 +
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/linux.c
> index 2d9c59df60de..93f7de81fbe8 100644
> --- a/tools/testing/radix-tree/linux.c
> +++ b/tools/testing/radix-tree/linux.c
> @@ -24,15 +24,28 @@ struct kmem_cache {
>         int nr_objs;
>         void *objs;
>         void (*ctor)(void *);
> +       unsigned int non_kernel;
>  };
>
> +void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val)
> +{
> +       cachep->non_kernel = val;
> +}
> +
> +unsigned long kmem_cache_get_alloc(struct kmem_cache *cachep)
> +{
> +       return cachep->size * nr_allocated;

IIUC nr_allocated is incremented/decremented every time memory is
allocated/freed from *any* kmem_cache. Each kmem_cache has its own
size. So, nr_allocated counts allocated objects of potentially
different sizes. If that is so then I'm unclear what the result of
this multiplication would represent.

> +}
>  void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp)
>  {
>         void *p;
>
> -       if (!(gfp & __GFP_DIRECT_RECLAIM))
> +       if (!(gfp & __GFP_DIRECT_RECLAIM) && !cachep->non_kernel)
>                 return NULL;
>
> +       if (!(gfp & __GFP_DIRECT_RECLAIM))
> +               cachep->non_kernel--;
> +
>         pthread_mutex_lock(&cachep->lock);
>         if (cachep->nr_objs) {
>                 struct radix_tree_node *node = cachep->objs;
> @@ -116,5 +129,6 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
>         ret->nr_objs = 0;
>         ret->objs = NULL;
>         ret->ctor = ctor;
> +       ret->non_kernel = 0;
>         return ret;
>  }
> diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-tree/linux/kernel.h
> index 39867fd80c8f..c5c9d05f29da 100644
> --- a/tools/testing/radix-tree/linux/kernel.h
> +++ b/tools/testing/radix-tree/linux/kernel.h
> @@ -14,6 +14,7 @@
>  #include "../../../include/linux/kconfig.h"
>
>  #define printk printf
> +#define pr_err printk
>  #define pr_info printk
>  #define pr_debug printk
>  #define pr_cont printk
> --
> 2.30.2
