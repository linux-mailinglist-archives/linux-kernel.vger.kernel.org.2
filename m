Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0413A4F58
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 16:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhFLOpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 10:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhFLOpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 10:45:08 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3B5C061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 07:42:59 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so6213140otk.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 07:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iH7EgL9X46ZYFZJtSIwwFSnS3uKaFXLbIujUQXunbi0=;
        b=wNxXyE/0okBDTG9XmRTHjerp356Pfi5go1rJh6p6vqJuOZDqvO/1DMRy1LLkCezXFr
         TBbJQo08srak+Nx2xyguxnoqNOiMM/xDH/v9RqAcITpn/VUsEJC2S4bmfS3lo4rn+up8
         gh0GCZxE6FN8z5zsmkhEJIAzMnQlGeQDYULtdyskGHIAzkVAG6Xa9koNb5uzhsj6UN37
         psWiIwk8Ve3qnNfd3xzf3oyXy1IUaxZDCfybFJArdYSixI5CRF7NLfc8utPz3YhMvJ0m
         XzN9p/3OSeBSNFhyPfp00qFyS5Lmb8YD6IUXFGjNNFVZiQsBmEiGl1r7iwYRNskSI07K
         DBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iH7EgL9X46ZYFZJtSIwwFSnS3uKaFXLbIujUQXunbi0=;
        b=J8wvLLzcpMpbMg2FjTJn+Ev4t/3G3wcfoTuTKf5ES/jgLM94VJ2Qd+Hp47aSSxvA1L
         aMyPNFzzYyG8nGy38Kr6DsT5flxN5/zqANZIF2Mh+svsCEvvGYNMkxrZ7cVlBF9aZkwu
         f9Dc5DeZ9z5NSOHFeIJDrBrngsV+gtZsPbDCm1rhQsPBmiMCOxD8sGH133joWPuBm1+B
         WgK9xASJqcLiz/g4+iu0uF+CORtRGh5xhGBMUOujAvVlCp+uI5vk+nBSC+p9s1GPyW4T
         3ytiFImbjADfsIXWY4hBHif0ZP4E9ehmDwVF/hOnqoZNeaX37/2nkEXg+aUUc9yQUVNI
         MGEg==
X-Gm-Message-State: AOAM5300vgqnD76PseCf+RRKwKcjn8CPeI88rEXa4NCH/UkgVQFH75rH
        8jdADSDdQXShm73qfJsak1UGBTHs8CtS/T4jfA2RBQ==
X-Google-Smtp-Source: ABdhPJyBUGhk0Z9OC45WMmiRoeWwNVm++xa8VAU766aiv7xkUKDVGHjax+HBCNIyA2St+uM3/cLLEb5DZlgRxuPmJp8=
X-Received: by 2002:a05:6830:1c7b:: with SMTP id s27mr7290621otg.233.1623508976605;
 Sat, 12 Jun 2021 07:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210612045156.44763-1-kylee0686026@gmail.com> <20210612045156.44763-3-kylee0686026@gmail.com>
In-Reply-To: <20210612045156.44763-3-kylee0686026@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Sat, 12 Jun 2021 16:42:44 +0200
Message-ID: <CANpmjNMLzxMO0k_kvGaAvzyGoyKxBTtjx4PH=-MKKgDb1-dQaA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kasan: integrate the common part of two KASAN
 tag-based modes
To:     Kuan-Ying Lee <kylee0686026@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2021 at 06:52, Kuan-Ying Lee <kylee0686026@gmail.com> wrote:
> 1. Move kasan_get_free_track() and kasan_set_free_info()
>    into tags.c
> 2. Move kasan_get_bug_type() to header file
>
> Signed-off-by: Kuan-Ying Lee <kylee0686026@gmail.com>
> Suggested-by: Marco Elver <elver@google.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/kasan/Makefile         |  4 +--
>  mm/kasan/hw_tags.c        | 22 ---------------
>  mm/kasan/report_hw_tags.c |  6 +---
>  mm/kasan/report_sw_tags.c | 46 +------------------------------
>  mm/kasan/report_tags.h    | 56 +++++++++++++++++++++++++++++++++++++
>  mm/kasan/sw_tags.c        | 41 ---------------------------
>  mm/kasan/tags.c           | 58 +++++++++++++++++++++++++++++++++++++++
>  7 files changed, 118 insertions(+), 115 deletions(-)
>  create mode 100644 mm/kasan/report_tags.h
>  create mode 100644 mm/kasan/tags.c
[...]
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index ed5e5b833d61..4ea8c368b5b8 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -216,28 +216,6 @@ void __init kasan_init_hw_tags(void)
>         pr_info("KernelAddressSanitizer initialized\n");
>  }
>
> -void kasan_set_free_info(struct kmem_cache *cache,
> -                               void *object, u8 tag)
> -{
> -       struct kasan_alloc_meta *alloc_meta;
> -
> -       alloc_meta = kasan_get_alloc_meta(cache, object);
> -       if (alloc_meta)
> -               kasan_set_track(&alloc_meta->free_track[0], GFP_NOWAIT);
> -}
> -
> -struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> -                               void *object, u8 tag)
> -{
> -       struct kasan_alloc_meta *alloc_meta;
> -
> -       alloc_meta = kasan_get_alloc_meta(cache, object);
> -       if (!alloc_meta)
> -               return NULL;
> -
> -       return &alloc_meta->free_track[0];
> -}
> -
>  void kasan_alloc_pages(struct page *page, unsigned int order, gfp_t flags)
>  {
>         /*
> diff --git a/mm/kasan/report_hw_tags.c b/mm/kasan/report_hw_tags.c
> index 42b2168755d6..ef5e7378f3aa 100644
> --- a/mm/kasan/report_hw_tags.c
> +++ b/mm/kasan/report_hw_tags.c
> @@ -14,11 +14,7 @@
>  #include <linux/types.h>
>
>  #include "kasan.h"
> -
> -const char *kasan_get_bug_type(struct kasan_access_info *info)
> -{
> -       return "invalid-access";
> -}
> +#include "report_tags.h"
>
>  void *kasan_find_first_bad_addr(void *addr, size_t size)
>  {
> diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
> index 821a14a19a92..d965a170083e 100644
> --- a/mm/kasan/report_sw_tags.c
> +++ b/mm/kasan/report_sw_tags.c
> @@ -26,51 +26,7 @@
>
>  #include <asm/sections.h>
>
> -#include "kasan.h"
> -#include "../slab.h"
> -
> -const char *kasan_get_bug_type(struct kasan_access_info *info)
> -{
> -#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> -       struct kasan_alloc_meta *alloc_meta;
> -       struct kmem_cache *cache;
> -       struct page *page;
> -       const void *addr;
> -       void *object;
> -       u8 tag;
> -       int i;
> -
> -       tag = get_tag(info->access_addr);
> -       addr = kasan_reset_tag(info->access_addr);
> -       page = kasan_addr_to_page(addr);
> -       if (page && PageSlab(page)) {
> -               cache = page->slab_cache;
> -               object = nearest_obj(cache, page, (void *)addr);
> -               alloc_meta = kasan_get_alloc_meta(cache, object);
> -
> -               if (alloc_meta) {
> -                       for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
> -                               if (alloc_meta->free_pointer_tag[i] == tag)
> -                                       return "use-after-free";
> -                       }
> -               }
> -               return "out-of-bounds";
> -       }
> -
> -#endif
> -       /*
> -        * If access_size is a negative number, then it has reason to be
> -        * defined as out-of-bounds bug type.
> -        *
> -        * Casting negative numbers to size_t would indeed turn up as
> -        * a large size_t and its value will be larger than ULONG_MAX/2,
> -        * so that this can qualify as out-of-bounds.
> -        */
> -       if (info->access_addr + info->access_size < info->access_addr)
> -               return "out-of-bounds";
> -
> -       return "invalid-access";
> -}
> +#include "report_tags.h"
>
>  void *kasan_find_first_bad_addr(void *addr, size_t size)
>  {
> diff --git a/mm/kasan/report_tags.h b/mm/kasan/report_tags.h
> new file mode 100644
> index 000000000000..4f740d4d99ee
> --- /dev/null
> +++ b/mm/kasan/report_tags.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __MM_KASAN_REPORT_TAGS_H
> +#define __MM_KASAN_REPORT_TAGS_H
> +
> +#include "kasan.h"
> +#include "../slab.h"
> +
> +#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> +const char *kasan_get_bug_type(struct kasan_access_info *info)
> +{
[...]
> +       /*
> +        * If access_size is a negative number, then it has reason to be
> +        * defined as out-of-bounds bug type.
> +        *
> +        * Casting negative numbers to size_t would indeed turn up as
> +        * a large size_t and its value will be larger than ULONG_MAX/2,
> +        * so that this can qualify as out-of-bounds.
> +        */
> +       if (info->access_addr + info->access_size < info->access_addr)
> +               return "out-of-bounds";

This seems to change behaviour for SW_TAGS because it was there even
if !CONFIG_KASAN_TAGS_IDENTIFY. Does it still work as before?

> +
> +       return "invalid-access";
> +}
> +#else
> +const char *kasan_get_bug_type(struct kasan_access_info *info)
> +{
> +       return "invalid-access";
> +}
> +#endif
> +
> +#endif
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index dd05e6c801fa..bd3f540feb47 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -167,47 +167,6 @@ void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size)
>  }
>  EXPORT_SYMBOL(__hwasan_tag_memory);
>
> -void kasan_set_free_info(struct kmem_cache *cache,
> -                               void *object, u8 tag)
> -{
> -       struct kasan_alloc_meta *alloc_meta;
> -       u8 idx = 0;
> -
> -       alloc_meta = kasan_get_alloc_meta(cache, object);
> -       if (!alloc_meta)
> -               return;
> -
> -#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> -       idx = alloc_meta->free_track_idx;
> -       alloc_meta->free_pointer_tag[idx] = tag;
> -       alloc_meta->free_track_idx = (idx + 1) % KASAN_NR_FREE_STACKS;
> -#endif
> -
> -       kasan_set_track(&alloc_meta->free_track[idx], GFP_NOWAIT);
> -}
> -
> -struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> -                               void *object, u8 tag)
> -{
> -       struct kasan_alloc_meta *alloc_meta;
> -       int i = 0;
> -
> -       alloc_meta = kasan_get_alloc_meta(cache, object);
> -       if (!alloc_meta)
> -               return NULL;
> -
> -#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> -       for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
> -               if (alloc_meta->free_pointer_tag[i] == tag)
> -                       break;
> -       }
> -       if (i == KASAN_NR_FREE_STACKS)
> -               i = alloc_meta->free_track_idx;
> -#endif
> -
> -       return &alloc_meta->free_track[i];
> -}
> -
>  void kasan_tag_mismatch(unsigned long addr, unsigned long access_info,
>                         unsigned long ret_ip)
>  {
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> new file mode 100644
> index 000000000000..9c33c0ebe1d1
> --- /dev/null
> +++ b/mm/kasan/tags.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * This file contains common tag-based KASAN code.
> + *
> + * Author: Kuan-Ying Lee <kylee0686026@gmail.com>

We appreciate your work on this, but this is misleading. Because you
merely copied/moved the code, have a look what sw_tags.c says -- that
should either be preserved, or we add nothing here.

I prefer to add nothing or the bare minimum (e.g. if the company
requires a Copyright line) for non-substantial additions because this
stuff becomes out-of-date fast and just isn't useful at all. 'git log'
is the source of truth.

Cc'ing Greg for process advice. For moved code, does it have to
preserve the original Copyright line if there was one?

Thanks,
-- Marco
