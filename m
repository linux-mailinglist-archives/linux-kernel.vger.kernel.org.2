Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB783B4F26
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 17:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFZPO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 11:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhFZPOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 11:14:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D63C061766
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 08:12:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id hz1so20206282ejc.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/h1uJ7qFN4vR9+WQkLvQTgqKrkSpgOks6V+odHZLsI=;
        b=sM5nFsqf8c+w6mnFgw1BXqUe7DmuTC/3ntixqyE6Yvd+j8oKkZ3nWY9A64glBNpE8/
         rUmDsIEwg97VZiARE5lQn/NzioBzDBXKdcdxRf2MPGjIxx1lvwDgx3RoYymWxkxls1Xv
         NG3zB/1Dm+H+I5WnWZcflfg1gCKV+wThFltBPJsAK2CixQ+L6CvrH0rL3o5EoSI42JIz
         Y4PiDXKWN32o5EyZpKnDNVtKlKB1kGC2u7DweS125eD6BTlO4VD4EXEsUxUvupRQvw+M
         FtbwjcqzBneFCRJRkiLl55MMO6a311jcngViIL9WE/+NdbfnKN9NxGL+Kj4HloYdGmaG
         7+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/h1uJ7qFN4vR9+WQkLvQTgqKrkSpgOks6V+odHZLsI=;
        b=C+amdHynRLTHOTSfFUpMYy5camlP4GBoyr9jroQAJopM9kxZnA+Q1jzWx2aCXv3vvv
         Hou+Y1F54++r1JdcpL9i76FDBA0kya0wLcSOuDId5f7k1cAYfMBbf3bxxo+Szg9ARVJM
         GhN8uvSe1j7W34nLAx1FWvH2/gAnUIDj4QOlCI0bv/gvtvEdhL6piBm66Vdjazz67Q0F
         zJ7FqaEhXjTB8jSN2sp2VQYEYVep0wX/Y9+InIAs6W7FObIDu/lh9MqWBTbCTOgKXvND
         9PwGYwGZiG/ABFjIxSZyNfSYoOV/Ylge/dXCGnMYo7OTTXdIe2DkGAMBlW6A1jQwy4ke
         +xOQ==
X-Gm-Message-State: AOAM531RFzpbIaWbnStuage2SKPEY/llXoGhTx64kDNVxyXFK2yjidyY
        7F5GBELzr6Q2Vn9OqnzQ0cdQBBGlSBE3FqtrfKg=
X-Google-Smtp-Source: ABdhPJzkrt8KTHMK9yAmdtZg8EfjgY3ZK0nbWO86hcQW6c6vKKd5HuZK3lRbkuybHxKoGVXtigR4tqvbBwCwr6iqX3g=
X-Received: by 2002:a17:906:9452:: with SMTP id z18mr16652221ejx.227.1624720337395;
 Sat, 26 Jun 2021 08:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210626100931.22794-1-Kuan-Ying.Lee@mediatek.com> <20210626100931.22794-3-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20210626100931.22794-3-Kuan-Ying.Lee@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sat, 26 Jun 2021 18:12:06 +0300
Message-ID: <CA+fCnZfy-C+J_wdMm7Wao+4iUcN1YUAmxX9wjNKDGRq=4YgAng@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] kasan: integrate the common part of two KASAN
 tag-based modes
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, wsd_upstream@mediatek.com,
        chinwen.chang@mediatek.com, nicholas.tang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2021 at 1:09 PM Kuan-Ying Lee
<Kuan-Ying.Lee@mediatek.com> wrote:
>
> 1. Move kasan_get_free_track() and kasan_set_free_info()
>    into tags.c and combine these two functions for
>    SW_TAGS and HW_TAGS kasan mode.
> 2. Move kasan_get_bug_type() to report_tags.c and
>    make this function compatible for SW_TAGS and
>    HW_TAGS kasan mode.
>
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> Suggested-by: Marco Elver <elver@google.com>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/kasan/Makefile         |  4 +--
>  mm/kasan/hw_tags.c        | 22 ---------------
>  mm/kasan/report_hw_tags.c |  5 ----
>  mm/kasan/report_sw_tags.c | 43 ----------------------------
>  mm/kasan/report_tags.c    | 51 +++++++++++++++++++++++++++++++++
>  mm/kasan/sw_tags.c        | 41 ---------------------------
>  mm/kasan/tags.c           | 59 +++++++++++++++++++++++++++++++++++++++
>  7 files changed, 112 insertions(+), 113 deletions(-)
>  create mode 100644 mm/kasan/report_tags.c
>  create mode 100644 mm/kasan/tags.c
>
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index 9fe39a66388a..adcd9acaef61 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -37,5 +37,5 @@ CFLAGS_sw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
>
>  obj-$(CONFIG_KASAN) := common.o report.o
>  obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o report_generic.o shadow.o quarantine.o
> -obj-$(CONFIG_KASAN_HW_TAGS) += hw_tags.o report_hw_tags.o
> -obj-$(CONFIG_KASAN_SW_TAGS) += init.o report_sw_tags.o shadow.o sw_tags.o
> +obj-$(CONFIG_KASAN_HW_TAGS) += hw_tags.o report_hw_tags.o tags.o report_tags.o
> +obj-$(CONFIG_KASAN_SW_TAGS) += init.o report_sw_tags.o shadow.o sw_tags.o tags.o report_tags.o
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
> index 42b2168755d6..5dbbbb930e7a 100644
> --- a/mm/kasan/report_hw_tags.c
> +++ b/mm/kasan/report_hw_tags.c
> @@ -15,11 +15,6 @@
>
>  #include "kasan.h"
>
> -const char *kasan_get_bug_type(struct kasan_access_info *info)
> -{
> -       return "invalid-access";
> -}
> -
>  void *kasan_find_first_bad_addr(void *addr, size_t size)
>  {
>         return kasan_reset_tag(addr);
> diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
> index 821a14a19a92..d2298c357834 100644
> --- a/mm/kasan/report_sw_tags.c
> +++ b/mm/kasan/report_sw_tags.c
> @@ -29,49 +29,6 @@
>  #include "kasan.h"
>  #include "../slab.h"
>
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
> -
>  void *kasan_find_first_bad_addr(void *addr, size_t size)
>  {
>         u8 tag = get_tag(addr);
> diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
> new file mode 100644
> index 000000000000..8a319fc16dab
> --- /dev/null
> +++ b/mm/kasan/report_tags.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> + * Copyright (c) 2020 Google, Inc.
> + */
> +
> +#include "kasan.h"
> +#include "../slab.h"
> +
> +const char *kasan_get_bug_type(struct kasan_access_info *info)
> +{
> +#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> +       struct kasan_alloc_meta *alloc_meta;
> +       struct kmem_cache *cache;
> +       struct page *page;
> +       const void *addr;
> +       void *object;
> +       u8 tag;
> +       int i;
> +
> +       tag = get_tag(info->access_addr);
> +       addr = kasan_reset_tag(info->access_addr);
> +       page = kasan_addr_to_page(addr);
> +       if (page && PageSlab(page)) {
> +               cache = page->slab_cache;
> +               object = nearest_obj(cache, page, (void *)addr);
> +               alloc_meta = kasan_get_alloc_meta(cache, object);
> +
> +               if (alloc_meta) {
> +                       for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
> +                               if (alloc_meta->free_pointer_tag[i] == tag)
> +                                       return "use-after-free";
> +                       }
> +               }
> +               return "out-of-bounds";
> +       }
> +#endif
> +
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
> +
> +       return "invalid-access";
> +}
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
> index 000000000000..8f48b9502a17
> --- /dev/null
> +++ b/mm/kasan/tags.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * This file contains common tag-based KASAN code.
> + *
> + * Copyright (c) 2018 Google, Inc.
> + * Copyright (c) 2020 Google, Inc.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kasan.h>
> +#include <linux/kernel.h>
> +#include <linux/memory.h>
> +#include <linux/mm.h>
> +#include <linux/static_key.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +#include "kasan.h"
> +
> +void kasan_set_free_info(struct kmem_cache *cache,
> +                               void *object, u8 tag)
> +{
> +       struct kasan_alloc_meta *alloc_meta;
> +       u8 idx = 0;
> +
> +       alloc_meta = kasan_get_alloc_meta(cache, object);
> +       if (!alloc_meta)
> +               return;
> +
> +#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> +       idx = alloc_meta->free_track_idx;
> +       alloc_meta->free_pointer_tag[idx] = tag;
> +       alloc_meta->free_track_idx = (idx + 1) % KASAN_NR_FREE_STACKS;
> +#endif
> +
> +       kasan_set_track(&alloc_meta->free_track[idx], GFP_NOWAIT);
> +}
> +
> +struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> +                               void *object, u8 tag)
> +{
> +       struct kasan_alloc_meta *alloc_meta;
> +       int i = 0;
> +
> +       alloc_meta = kasan_get_alloc_meta(cache, object);
> +       if (!alloc_meta)
> +               return NULL;
> +
> +#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> +       for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
> +               if (alloc_meta->free_pointer_tag[i] == tag)
> +                       break;
> +       }
> +       if (i == KASAN_NR_FREE_STACKS)
> +               i = alloc_meta->free_track_idx;
> +#endif
> +
> +       return &alloc_meta->free_track[i];
> +}
> --
> 2.18.0
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
