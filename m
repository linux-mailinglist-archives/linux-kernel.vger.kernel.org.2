Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6176F41EAF7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 12:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352769AbhJAKco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 06:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352697AbhJAKcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 06:32:43 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA39BC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 03:30:59 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id a17-20020a4a6851000000b002b59bfbf669so2728970oof.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 03:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8UnM6fWprDP/p4IMmb85dmfiw4okGcebGCdS4L7uqiY=;
        b=PypTI49BIXrd7YfVzyBx3BuNZ9XRgaWYoOW7T4Z6fPlr5GaE9BrvhhEenNY1TkRyL8
         o2PlvsmZLHWH6ygyq4u30gapPB/J1vr9H1KNyIuSMLVE8Q6I8nCPzHzyTU2aJFPiRh4a
         14hKLJX6nEItjU+4Ys47YcFaz5CF5zMbzHUY6vhIuBfUIiVLWlXPSRP9mq8fteM0P+uQ
         6fZsPUVOE1RrCArWnUurhfsypt3+c51zaoToC4qiFmNppU7bmHidLyG2VRaNmHCJMdeu
         gde9MiYFdY6Am0jbESZ3DuhugiZLYG8skhHuhdPpzRWMot3QGZSeAHvwFSFVjVX/IzZA
         fbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8UnM6fWprDP/p4IMmb85dmfiw4okGcebGCdS4L7uqiY=;
        b=tJQ2j+4X/ueVXTz6h7AJPuEEzr+kYzjbimMQQYG/qMgOu9RNq0myAVKQjc5WENxULD
         WmmBNzdJST/sD+aIx1bku6kKNpyPN23w0Tr8vFbj2BueaT7qumna8cRFpJHua1Xylh0W
         h8SEy/MDL9zLCMLKwSrKhz2RxO7IQjC90xqGt8eXGBabKN9HfAzthI8ueM40+maP97uO
         s1RQ97/J5dMfYknkET9OGI/+P4TtmsCD/9rFPU1ESNwRvqkXFGSNjB1KozP0pSaabU+X
         2E1rPJlDmQQDm7eYhMEnylXt52tIIERCwY5vojvLg20Bwvy718vXBVaY+TLT9rpyYnCE
         ryBA==
X-Gm-Message-State: AOAM533SytWuDw10n+qDL7X1CQiHmt6e500CEZsLtAoznl5afiU1Ew0M
        cOBorvTblYBwFxfa1BYxMpbdKjOnLGGGaylmXoIQOg==
X-Google-Smtp-Source: ABdhPJxwtZAXvTBeaHiHcb09pWND5enhe0cJSwW/tIh2yXN7U0Z9ZBzLIy/s7yq9kHv8b4dRxnX8r19yio4QslKX8BE=
X-Received: by 2002:a4a:a6c6:: with SMTP id i6mr8693696oom.73.1633084259052;
 Fri, 01 Oct 2021 03:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211001024105.3217339-1-willy@infradead.org>
In-Reply-To: <20211001024105.3217339-1-willy@infradead.org>
From:   Marco Elver <elver@google.com>
Date:   Fri, 1 Oct 2021 12:30:47 +0200
Message-ID: <CANpmjNOoFdbGi3vsKtgQ3VVzJb126Gj90txA83C41HHhoy3DOQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: Fix tag for large allocations when using CONFIG_SLAB
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2021 at 04:42, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> If an object is allocated on a tail page of a multi-page slab, kasan
> will get the wrong tag because page->s_mem is NULL for tail pages.
> I'm not quite sure what the user-visible effect of this might be.
>
> Fixes: 7f94ffbc4c6a ("kasan: add hooks implementation for tag-based mode")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Marco Elver <elver@google.com>

Indeed this looks wrong. I don't know how much this code is even
tested, because it depends on CONFIG_KASAN_SW_TAGS && CONFIG_SLAB, and
the cache having a constructor or SLAB_TYPESAFE_BY_RCU. HW_TAGS isn't
affected because it doesn't work with SLAB.

And to run SW_TAGS, one needs an arm64 CPU with TBI. And the instances
of KASAN_SW_TAGS I'm aware of use SLUB.

With eventual availability of Intel LAM, I expect KASAN_SW_TAGS to
become more widely used though, including its SLAB support.

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
