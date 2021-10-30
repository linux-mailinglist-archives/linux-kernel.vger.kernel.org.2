Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE39E4408B3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 14:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhJ3M0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 08:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhJ3M0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 08:26:20 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A608BC061570
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 05:23:50 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id t127so31243876ybf.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 05:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5YtV6Ot0jonvatdmpLsBTlUfPHWMnjmg4fL8qYE8kh8=;
        b=HkhxAVHm2ETNFoCcDmD8TAiYQ59p7oUOP/GX/OwevsAZSm7FQdqD50kmazqxzoG/XO
         dfWM/zD3+m8BiVAop5p9sIkbJd+oy+311HQ8tv7mwhG+m4Kj9/mYdY3BSYvz7efKlmEf
         ML/9BTCjoJH/v8kQG/7meUYrYS9ImHJwx377dL4yWJes+1SeBaBoJD94C+sKNj6hHRux
         G2o/tZ41SCY+CR/doKnp/0Cu7MKVEIhR086qgRlS3365ckPaJrvI4Q0Q9lYcorC0i4zX
         3RPfFv/9IIbQ5nSA1uSN5DiLKuifXt6wQnfCshv+wVUkq81ogKJxnIiqKFawg0C2fOkE
         eb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YtV6Ot0jonvatdmpLsBTlUfPHWMnjmg4fL8qYE8kh8=;
        b=7TQ8cwNd0gk+kAH+4GrVuaRjZqqv88wHTeLoYRn8i6rCcnP1rSlBfjEkV2GSrNQmk/
         HNioZszYlB2fbw2XjQ4SxoobeoyHV8xni8vS7fRVNDSaFToWKLjDR1oyEP0wdm/OY27D
         VM6H7ixibWncpOfqV/7MWQVyO7VEm0ZSuNYu9kuyvhQVUKC1sK4IEQm6jKYSiXqApXEx
         AVkt7/RsGDlMsF9FQxvDHpsOrqVyONiAr6bBW9Y7aSQXCq18Qi/DvuFdEFdlRPdAwWk2
         QIZ0BDOk/++19g1dBf50tsCYdod0nnOjQHfAw3p4xl65uH3PSE9Ml+w2bSodW1sZA9Op
         yKsA==
X-Gm-Message-State: AOAM5329JprA/eNEoiTsbaiMJgYr3xXfzAQABouT57uoyL7Y5tyJwJBR
        2C/rwIC5ymP+sm6OO/e9aFjLUn3rTGjZv3Hmj+sG6A==
X-Google-Smtp-Source: ABdhPJygShUOaRjn74sLxEG8tBRi+W3lqvbC+DVaQVq27wuJMONDctszG9FIwEb5qe/XXYIX830gQuAqPt7HgfTed4o=
X-Received: by 2002:a25:59d5:: with SMTP id n204mr17770867ybb.189.1635596629841;
 Sat, 30 Oct 2021 05:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <867f6da4-6d38-6435-3fbb-a2a3744029f1@huawei.com>
In-Reply-To: <867f6da4-6d38-6435-3fbb-a2a3744029f1@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 30 Oct 2021 20:23:12 +0800
Message-ID: <CAMZfGtU+wyjD6e0Xm7-toqqfA2tsu8nSUQJsZdC=piZzgq76fw@mail.gmail.com>
Subject: Re: [PATCH] mm, slub: place the trace before freeing memory in kmem_cache_free()
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, wuxu.wu@huawei.com,
        Hewenliang <hewenliang4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2021 at 6:12 PM Yunfeng Ye <yeyunfeng@huawei.com> wrote:
>
> After the memory is freed, it may be allocated by other CPUs and has
> been recorded by trace. So the timing sequence of the memory tracing is
> inaccurate.
>
> For example, we expect the following timing sequeuce:
>
>     CPU 0                 CPU 1
>
>   (1) alloc xxxxxx
>   (2) free  xxxxxx
>                          (3) alloc xxxxxx
>                          (4) free  xxxxxx
>
> However, the following timing sequence may occur:
>
>     CPU 0                 CPU 1
>
>   (1) alloc xxxxxx
>                          (2) alloc xxxxxx
>   (3) free  xxxxxx
>                          (4) free  xxxxxx
>
> So place the trace before freeing memory in kmem_cache_free().

Could you tell me what problem you have encountered
here?

Thanks.

>
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 432145d7b4ec..427e62034c3f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3526,8 +3526,8 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
>         s = cache_from_obj(s, x);
>         if (!s)
>                 return;
> -       slab_free(s, virt_to_head_page(x), x, NULL, 1, _RET_IP_);
>         trace_kmem_cache_free(_RET_IP_, x, s->name);
> +       slab_free(s, virt_to_head_page(x), x, NULL, 1, _RET_IP_);
>  }
>  EXPORT_SYMBOL(kmem_cache_free);
>
> --
> 2.27.0
