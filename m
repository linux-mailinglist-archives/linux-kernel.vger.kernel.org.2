Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220F9433827
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 16:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhJSOQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 10:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhJSOQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:16:30 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A63EC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:14:18 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so2423887ott.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NdUwBl5vJzEY+z2qLVViXJz11eLRD5JHwkOtv2fvRgE=;
        b=cMEnDjIU2XKJz3D6ETstKbABN6h98BoKqPSIUExxaBux+KRqxBD1esjs4Zt+81sYag
         o60Jd9Q2a/g4vXwLpgV90U9tcSxWLkJAX+tzXuJsJNufLayspRr+IQpm31t7xdok2iGS
         khYa7YeiKqPi4mWkBiaUYVKCAWoJy6fRu583uWwk2MPv7Md6PJ0gNaKxiy+kc/pl86aQ
         oFomgwLJORiZCoahGnEHTkcKCAxO9JCoW5eKhmKv8AUUdKXsHZzXVQhpZCfISYmbxlZZ
         XGlbKogtACpQRcDQ5jUL9QN0JWln+qPEBuSiLVtHxH7yNrXS+yGQwaew5A7DHuHEGBB4
         6zCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdUwBl5vJzEY+z2qLVViXJz11eLRD5JHwkOtv2fvRgE=;
        b=OFmPq4vSDY5cO77xYoRw/1/CZ6QQnAzRitMm2kKTvk5//a+XPVYY2t9vgKwnp2ugS6
         28Y5ySQYhDyAEDzXYoNWG6PG14JmjtaC8FW1iZSD/3QluRI+e5Jz5DRoz2VAprMIjo0G
         AH2busWnKBXL6MtADl3Z/feejlXaOt2lfhJX9mYa9U1WKsbkEPks+X/7dRI2LdiTjoOK
         nfhPd0M1Oo3w2frHPEVrTShDrQy0Lc38w6zrZn+XMFx4Qo/Wxx8cVoD6CEyGPl5t+xBz
         HF18xrvG/G2Lj72t5NWBOkz7PajsqEjUX6vDM4OiZdUIt3bWzxIRk3ZcZHZXU9GM8ljd
         AS9Q==
X-Gm-Message-State: AOAM5305+WdC99e6pf7M3MWlSSGnCwa3sOgGz5+mjlkCNeJOyrOEJMKY
        mXHHpz+xdHelP6KUuunuzZUA0GxZDM2i1rrAEbtNAQ==
X-Google-Smtp-Source: ABdhPJzcbeAOpjyW1S4YoHYPGo8bxdP1x33eMLvRUwm9vgeXwvguOGMloQ1gSlkUcmDSxFg+vrzr2SOOQI/XXQsNKwQ=
X-Received: by 2002:a05:6830:1092:: with SMTP id y18mr5449783oto.329.1634652857393;
 Tue, 19 Oct 2021 07:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211019120413.20807-1-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20211019120413.20807-1-Kuan-Ying.Lee@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 19 Oct 2021 16:14:05 +0200
Message-ID: <CANpmjNMMQUHhFTdaqfx6HErnv0aXkCJn+eBGN-kfeznN8H+f3g@mail.gmail.com>
Subject: Re: [PATCH] kasan: add kasan mode messages when kasan init
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chinwen.chang@mediatek.com, yee.lee@mediatek.com,
        nicholas.tang@mediatek.com, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 at 14:04, Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:
>
> There are multiple kasan modes. It make sense that we add some messages
> to know which kasan mode is when booting up. see [1].
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=212195 [1]
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>

Looks good, however, you need to rebase to -next because of "kasan:
Extend KASAN mode kernel parameter"...

> ---
>  arch/arm64/mm/kasan_init.c | 2 +-
>  mm/kasan/hw_tags.c         | 4 +++-
>  mm/kasan/sw_tags.c         | 2 +-
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index 61b52a92b8b6..b4e78beac285 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -293,7 +293,7 @@ void __init kasan_init(void)
>         kasan_init_depth();
>  #if defined(CONFIG_KASAN_GENERIC)
>         /* CONFIG_KASAN_SW_TAGS also requires kasan_init_sw_tags(). */
> -       pr_info("KernelAddressSanitizer initialized\n");
> +       pr_info("KernelAddressSanitizer initialized (generic)\n");
>  #endif
>  }
>
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 05d1e9460e2e..3e28ecbe1d8f 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -168,7 +168,9 @@ void __init kasan_init_hw_tags(void)
>                 break;
>         }
>
> -       pr_info("KernelAddressSanitizer initialized\n");
> +       pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, stacktrace=%s)\n",
> +               kasan_flag_async ? "async" : "sync",

... which means this will have a 3rd option "asymm".

> +               kasan_stack_collection_enabled() ? "on" : "off");
>  }
>
>  void kasan_alloc_pages(struct page *page, unsigned int order, gfp_t flags)
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index bd3f540feb47..77f13f391b57 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -42,7 +42,7 @@ void __init kasan_init_sw_tags(void)
>         for_each_possible_cpu(cpu)
>                 per_cpu(prng_state, cpu) = (u32)get_cycles();
>
> -       pr_info("KernelAddressSanitizer initialized\n");
> +       pr_info("KernelAddressSanitizer initialized (sw-tags)\n");
>  }
>
>  /*
> --
> 2.18.0
