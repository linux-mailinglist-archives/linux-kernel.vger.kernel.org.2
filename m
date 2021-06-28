Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5433B58E2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 08:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhF1GCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 02:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbhF1GCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:02:46 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FDBC061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 23:00:20 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id o6so6160835oic.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 23:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OxWWpaIFrA1MZdBiGZNBP423mwRSvrkYLeFkLxi+psE=;
        b=LMUpZBEyoJQnBtAQ8SeofxWWGMQdCIhgV/12CUm7166Cn94MsSRbJqn1hSoEAYl+Et
         Bm+iirwqCVPLotrlInWQgdyT9JBMMS645aOU3F8aPbMHfI0N8MA9VGFm0sPU7RqJxyHN
         wG7AdpdAKNj/zNyjwgLIVa03j4ih5laE+WvZ6PV4zu/AI7JKejTi2ScC6+qEtb02JyIc
         jeiA3Sux/OM7PfWw29g/o/CdeqN5RDkEvvCGQQmhhykp1DpGaWVeFVUnti+ZEqzKd3yY
         dky0y+WveAm1wwgBKioF9IE1tJ+Ykya0kNBrTC+OHy4rSnf56FPsJcKoPB6XRvTSxfrs
         1BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OxWWpaIFrA1MZdBiGZNBP423mwRSvrkYLeFkLxi+psE=;
        b=KLd84K3ZrO/iO/uu9R9iZY8o4JEpUUDgwcszTSM0/1lur/wQgIdpyywkYiWtEoqSYE
         xgL9ZtfziDGb+nLAAErZowLqxN5RLAOXAUlxRD9zmHRCOFJAiqukVGT079MriZCmtMNq
         hSNJJ+LMAU7dxmkgU8JjC5qzHEQl4irSkpZHjebbmLtd2Xrahydr74o48cVe7NcbfSvJ
         rjvMkrelo3K6+fWVlHeiZAS/Nk7cvq9vpjQcY0ttGQSApKD0cDo/jwzLqnaJPNtPXSyq
         GRKWvua1ekjvzrdXqHbhnGV7HQzt+NFAxtf7q/LrFyPPBpKvrK404L7FG4CeaXzDMTCh
         dF8g==
X-Gm-Message-State: AOAM533/bzvEV3nlHjw4LGy0Es28WAZQwavo/sfjopDHrHfjO6vWEwOn
        5Kj9ufQ0I0PdD+F+QAqLGy9gsiBwHNHBC+wqec8AiQ==
X-Google-Smtp-Source: ABdhPJxqhFj8BmcDYjY03LVKniU00V6a9H9F3IfGZ6CZRYiwE68CJG4CI1RaEcWvHwvAkHNXok4eZ8Ddb4luicY15Ys=
X-Received: by 2002:aca:ba06:: with SMTP id k6mr16229848oif.70.1624860018200;
 Sun, 27 Jun 2021 23:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210626100931.22794-1-Kuan-Ying.Lee@mediatek.com> <20210626100931.22794-2-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20210626100931.22794-2-Kuan-Ying.Lee@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 28 Jun 2021 08:00:00 +0200
Message-ID: <CANpmjNO6k5=0HMf-Y3j70iTKLKY8XJAiLDDrfNf4-3cLASxHOA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] kasan: rename CONFIG_KASAN_SW_TAGS_IDENTIFY to CONFIG_KASAN_TAGS_IDENTIFY
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        chinwen.chang@mediatek.com, nicholas.tang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jun 2021 at 12:09, Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:
>
> This patch renames CONFIG_KASAN_SW_TAGS_IDENTIFY to
> CONFIG_KASAN_TAGS_IDENTIFY in order to be compatible
> with hardware tag-based mode.
>
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> Suggested-by: Marco Elver <elver@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  lib/Kconfig.kasan         | 2 +-
>  mm/kasan/kasan.h          | 4 ++--
>  mm/kasan/report_sw_tags.c | 2 +-
>  mm/kasan/sw_tags.c        | 4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index c3b228828a80..fdb4a08dba83 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -167,7 +167,7 @@ config KASAN_STACK
>           instrumentation is also disabled as it adds inline-style
>           instrumentation that is run unconditionally.
>
> -config KASAN_SW_TAGS_IDENTIFY
> +config KASAN_TAGS_IDENTIFY
>         bool "Enable memory corruption identification"
>         depends on KASAN_SW_TAGS
>         help
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 7b45b17a8106..952df2db7fdd 100644
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
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210626100931.22794-2-Kuan-Ying.Lee%40mediatek.com.
