Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4EE41EE98
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 15:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhJANbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 09:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhJANbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 09:31:24 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E616C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 06:29:40 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id k13so10513239ilo.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 06:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xMs0fSTF4k4sXUPE70Z2JKEpyq5JyqRAgQ76CwZyzaE=;
        b=pEDuSEGRh114uLI8QahRXH4hbVfIyGez8/8TDuXmXKhVYCzFsfbNyX1pEWIh+Z9srr
         5Ya/tRV/avnZmnS9dxocomaXcqETM2p5tIUJpxsD948EKPb0Aj/AYGl02HYndGsZlhO6
         n8LB3T/5HNkTf1tSLvuZtbMQSQQm+c/uVGIpGGJMyNS54HCub+kVakwcD8bvFwvz3vE4
         dEzTAPdwPAs8AsJ9EYFq22AF1Lg8STOzUNuDV6seYY4pMY97U2gV+0CfJzHHKzLMM5d5
         Ph4fIdwheMPuNZmdKAkw6NivHi38ClKzpIi6KZbXHaHtJ8gECoDsG97ybn0o/jBmiK8w
         NLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xMs0fSTF4k4sXUPE70Z2JKEpyq5JyqRAgQ76CwZyzaE=;
        b=BzcHfRjZXVg/dnEkEvODDFtB9iPYZBqLsxSYFSBzsldFrVKcgjMs2FZHwiZN2ZqCjC
         EuZ8UWI6rp6g6S96aKYchcBpbcfhakzazhLIVfDkcvPnHgPoRKJ7NQZZKQKpOQPOPEum
         PxbHCHFCl/Wu0xPbVa+jvt5LTCbd9cxVCQsNYPN8RpQqyLcZESxvCru+Tw9aB/cUdL+L
         FlQr2GTuZpsGqluuWYy3j570XsmY7vH2bNH4qcvvfuthHKW+mUUfeDRoQ2qy37XWJwdR
         3vNlRb333Hzhevd6RIuVh0iEtfHJXqRoiPMrsZpb7baLwgztC9pGxVVTI2aGfiSLlZDf
         prPQ==
X-Gm-Message-State: AOAM530EVv6B5OUcoRUJ4UL0b7/Fc9GVBuOK3WupnLRAUzEc4NvuGf7e
        URdTll+pYhyL9UFQwpbE6aY91Fh/tTLf4cpcFj4=
X-Google-Smtp-Source: ABdhPJzyOQrletc0/m0k7GQ9bnodD8aaSBhFEOXrQH7OYrsRBayS0WJ1GyqZPL2boYHXz9vvlKEbGHBQOXh1oFPecng=
X-Received: by 2002:a05:6e02:1a63:: with SMTP id w3mr9162209ilv.235.1633094979971;
 Fri, 01 Oct 2021 06:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211001024105.3217339-1-willy@infradead.org>
In-Reply-To: <20211001024105.3217339-1-willy@infradead.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 1 Oct 2021 15:29:29 +0200
Message-ID: <CA+fCnZfSUxToYKUfHwQT0r3bC9NYZNc2iC3PXv+GciuW0Fm79A@mail.gmail.com>
Subject: Re: [PATCH] kasan: Fix tag for large allocations when using CONFIG_SLAB
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 4:42 AM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> If an object is allocated on a tail page of a multi-page slab, kasan
> will get the wrong tagbecause page->s_mem is NULL for tail pages.

Interesting. Is this a known property of tail pages? Why does this
happen? I failed to find this exception in the code.

The tag value won't really be "wrong", just unexpected. But if s_mem
is indeed NULL for tail pages, your fix makes sense.

> I'm not quite sure what the user-visible effect of this might be.

Everything should work, as long as tag values are assigned
consistently based on the object address.

>
> Fixes: 7f94ffbc4c6a ("kasan: add hooks implementation for tag-based mode")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/kasan/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 2baf121fb8c5..41779ad109cd 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -298,7 +298,7 @@ static inline u8 assign_tag(struct kmem_cache *cache,
>         /* For caches that either have a constructor or SLAB_TYPESAFE_BY_RCU: */
>  #ifdef CONFIG_SLAB
>         /* For SLAB assign tags based on the object index in the freelist. */
> -       return (u8)obj_to_index(cache, virt_to_page(object), (void *)object);
> +       return (u8)obj_to_index(cache, virt_to_head_page(object), (void *)object);
>  #else
>         /*
>          * For SLUB assign a random tag during slab creation, otherwise reuse
> --
> 2.32.0
>
