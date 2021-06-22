Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459613B063F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhFVN4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhFVN4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:56:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93291C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:54:35 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id he7so34637149ejc.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FByLAh6Nf6CrO0CmfvZoHDR68Ruso4bZUuWvxrdb7+g=;
        b=tA5vW637kCakI7hlfEOyVaNxytSpmD41CBKAyDpRHd4Nn3k0+ZOuUy4ktkdPl1/o62
         P+dR7c0sevpmjUYfYJL03s+RVXxoH8OjCLZnvrA9iibyuUPgCllBgCyDKYuVeZ0+XBrg
         TWGcLxJPYLoXL9c17cezS9A2eVBZVnfY8tO5BCG1XwIwj/oCs+dekgk5yel8P2qPaAnw
         S7g3Xkr+GY7P/VEoaR9DljrLM+euVjfN1bu2FzbOvQBjjdqMjGm1kC+onLxtNjs2aEdp
         4QSwPemSPqTKNGJMGn5YQEyTFYebMUjFjZYlfhczM2OPyFwDUaL/iKO6JiRPrZw78FjM
         dFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FByLAh6Nf6CrO0CmfvZoHDR68Ruso4bZUuWvxrdb7+g=;
        b=RYt9hba2KtzOfANP/XsDY4ZIaa6aHfF3EosbEuIW3eOiCQl0JmlfH/AL7tdGAMDPzx
         nxqPojuis6iRDNaHGPCupm3CcNXvFUCxhbRk3hllnCSuySBhEl8YRjh1FtIVwY4i8K4B
         h6p7hR4MwSGCx9rSHHwpC77AU+CfOmaXq+ddR1HNLiEkzkq375uO8blKjR8DCKud6VNP
         dbi+QzrvVTz91Emz9w6mts4auZVCQ/7f5yy643dTz7EvEEAtAkyW0qdXH/LxDtO70lZQ
         KzBT2dT1Bp0J/zBrwuQxF8n1SotjEG+qwZlTCVl92EnHIGQTmoe0by5Pmk8CEYjXAu7P
         VuWQ==
X-Gm-Message-State: AOAM531Vuft3efyerG8YIbsR0BeXndoEiuaYJBmEFnNS+7sDLTYPyqeA
        Lp7i6FvX8WiEVTg0z6Ki7tS86OX71wMJpZD0sEk=
X-Google-Smtp-Source: ABdhPJx/V5oszBpwip0SxZHN++QihYaRpmfEKLkSDaCjMEhM4cmOUiXuiBz3yinojddOmwomdd+B4Q2fYeZRyy2KxAU=
X-Received: by 2002:a17:906:2f91:: with SMTP id w17mr4164114eji.443.1624370074257;
 Tue, 22 Jun 2021 06:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210620114756.31304-1-Kuan-Ying.Lee@mediatek.com> <20210620114756.31304-2-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20210620114756.31304-2-Kuan-Ying.Lee@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 22 Jun 2021 16:54:14 +0300
Message-ID: <CA+fCnZcFxNwVd7oCLn4an-c6sx=3tQbZAB7Zu4jSPVqr6xDrVg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kasan: rename CONFIG_KASAN_SW_TAGS_IDENTIFY to CONFIG_KASAN_TAGS_IDENTIFY
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
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        chinwen.chang@mediatek.com, nicholas.tang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 2:48 PM Kuan-Ying Lee
<Kuan-Ying.Lee@mediatek.com> wrote:
>
> This patch renames CONFIG_KASAN_SW_TAGS_IDENTIFY to
> CONFIG_KASAN_TAGS_IDENTIFY in order to be compatible
> with hardware tag-based mode.
>
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> Suggested-by: Marco Elver <elver@google.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  lib/Kconfig.kasan         | 2 +-
>  mm/kasan/kasan.h          | 4 ++--
>  mm/kasan/report_sw_tags.c | 2 +-
>  mm/kasan/sw_tags.c        | 4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index cffc2ebbf185..6f5d48832139 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -155,7 +155,7 @@ config KASAN_STACK
>           CONFIG_COMPILE_TEST.  On gcc it is assumed to always be safe
>           to use and enabled by default.
>
> -config KASAN_SW_TAGS_IDENTIFY
> +config KASAN_TAGS_IDENTIFY
>         bool "Enable memory corruption identification"
>         depends on KASAN_SW_TAGS
>         help
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 8f450bc28045..b0fc9a1eb7e3 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -153,7 +153,7 @@ struct kasan_track {
>         depot_stack_handle_t stack;
>  };
>
> -#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> +#ifdef CONFIG_KASAN_TAGS_IDENTIFY
>  #define KASAN_NR_FREE_STACKS 5
>  #else
>  #define KASAN_NR_FREE_STACKS 1
> @@ -170,7 +170,7 @@ struct kasan_alloc_meta {
>  #else
>         struct kasan_track free_track[KASAN_NR_FREE_STACKS];
>  #endif
> -#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> +#ifdef CONFIG_KASAN_TAGS_IDENTIFY
>         u8 free_pointer_tag[KASAN_NR_FREE_STACKS];
>         u8 free_track_idx;
>  #endif
> diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
> index 3d20d3451d9e..821a14a19a92 100644
> --- a/mm/kasan/report_sw_tags.c
> +++ b/mm/kasan/report_sw_tags.c
> @@ -31,7 +31,7 @@
>
>  const char *kasan_get_bug_type(struct kasan_access_info *info)
>  {
> -#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> +#ifdef CONFIG_KASAN_TAGS_IDENTIFY
>         struct kasan_alloc_meta *alloc_meta;
>         struct kmem_cache *cache;
>         struct page *page;
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index 9362938abbfa..dd05e6c801fa 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -177,7 +177,7 @@ void kasan_set_free_info(struct kmem_cache *cache,
>         if (!alloc_meta)
>                 return;
>
> -#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> +#ifdef CONFIG_KASAN_TAGS_IDENTIFY
>         idx = alloc_meta->free_track_idx;
>         alloc_meta->free_pointer_tag[idx] = tag;
>         alloc_meta->free_track_idx = (idx + 1) % KASAN_NR_FREE_STACKS;
> @@ -196,7 +196,7 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
>         if (!alloc_meta)
>                 return NULL;
>
> -#ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
> +#ifdef CONFIG_KASAN_TAGS_IDENTIFY
>         for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
>                 if (alloc_meta->free_pointer_tag[i] == tag)
>                         break;
> --
> 2.18.0
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
