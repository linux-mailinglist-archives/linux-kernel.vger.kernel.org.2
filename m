Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2A543486E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhJTKAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 06:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhJTKAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 06:00:53 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB8DC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:58:39 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id e59-20020a9d01c1000000b00552c91a99f7so6360540ote.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/MXj6rprc3vo+rohvgYqe3T54Ggc+J0xvFrcFXcAdLY=;
        b=jgc+NSn/FrAvNhiM6EigcGhOPwxLJD01UhblZ9Huaty8vGGXwjW4h8ZJQhXXeTwcFW
         hlVik+C0gnFGhtI8/Uzr/N9UCEjhHBZ2W7pvlKCk0cpocnky1AAiW8GF/yHMhwn1fEXF
         FUfllrMWO3L0KRvV3hF9H545urR9N013GRelK99vV5vJPh6R/ZhYuUa9GIaZ/iOIKdZT
         IaS/JPXRcw8Wfd1z3cHmwFsJQT/MsQ2IZSaMEyUY3bwNA6/Q4iH2fiDhW98J8Y5X1uqV
         S2ZpAdyTQNqhbG5ahUSD2mJAnjePjPRsaWRnvbT8xhIsrbMH6+jV6WP8gjd1+rm7ehSQ
         Wzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/MXj6rprc3vo+rohvgYqe3T54Ggc+J0xvFrcFXcAdLY=;
        b=QpiqwVuTQq6OIxa7ZaDHgrN0atO2f05xlnywbE0DUxWEanFMUm8S2xtSF6Jap0awBV
         86+jeACC4775aGS8sLyqLP1gBjaySWfTxn6a7kzikDGr8ppfYJ8X1AlPIzjEeHi3SYJR
         RJo8bAV+vPPRGfqrViP79dvOhSiLDhU8Ae4Ab3i3IJcdfw3AkW1mt/ogCPqDF25EFnvs
         1ENio+i3gGJz2O+3S4CftT2jhR3eT78hBht87jQkvOX28G8AGiqXUoASis+RY1VBvseC
         778TduRqaOiwoSO9DVd9wnWO2iLsPXF3QT5YRJZKbZYWbQKKeaSlEzRErmpEEgtxNCCS
         dsXg==
X-Gm-Message-State: AOAM5322ZKo6w475a7TSeIyx+QJ3ak3A9b+SxyeLM0C0dpmCDDEk/N9W
        +9j1Vb/6luTC6JxcELwNxrcg435i9E20mp3AIc8UTg==
X-Google-Smtp-Source: ABdhPJyt4FTPQc//xLDZCUzdp8LQGxbGS81ohYqcX1wLfbpWMg/6AW9oD7bnAsKaC+F3b2lsjJCIgJtkOE2rJb57SyA=
X-Received: by 2002:a9d:71cf:: with SMTP id z15mr10021143otj.157.1634723918292;
 Wed, 20 Oct 2021 02:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211020094850.4113-1-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20211020094850.4113-1-Kuan-Ying.Lee@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 20 Oct 2021 11:58:26 +0200
Message-ID: <CANpmjNMk-2pfBjD3ak9hto+xAFExuG+Pc-_vQRa6DSS=9-=WUg@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: add kasan mode messages when kasan init
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

On Wed, 20 Oct 2021 at 11:48, Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:
>
> There are multiple kasan modes. It makes sense that we add some messages
> to know which kasan mode is when booting up. see [1].
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=212195 [1]
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>

Reviewed-by: Marco Elver <elver@google.com>

Thank you.

Because this is rebased on the changes in the arm64 tree, and also
touches arch/arm64, it probably has to go through the arm64 tree.

> ---
> v3:
>  - Rebase to linux-next
>  - Move kasan_mode_info() into hw_tags.c
> v2:
>  - Rebase to linux-next
>  - HW-tag based mode need to consider asymm mode
>  - Thanks Marco's suggestion
>
>  arch/arm64/mm/kasan_init.c |  2 +-
>  mm/kasan/hw_tags.c         | 14 +++++++++++++-
>  mm/kasan/sw_tags.c         |  2 +-
>  3 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index 5b996ca4d996..6f5a6fe8edd7 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -309,7 +309,7 @@ void __init kasan_init(void)
>         kasan_init_depth();
>  #if defined(CONFIG_KASAN_GENERIC)
>         /* CONFIG_KASAN_SW_TAGS also requires kasan_init_sw_tags(). */
> -       pr_info("KernelAddressSanitizer initialized\n");
> +       pr_info("KernelAddressSanitizer initialized (generic)\n");
>  #endif
>  }

Note: Other architectures may want to update their message once they
support any one of the tags modes. But currently that's not yet the
case.

You could also consider leaving out the "(generic)" bit if it's the
generic mode to avoid adding this to all arch/**/kasan_init.c. Both is
fine with me. I leave it to you.

> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index dc892119e88f..7355cb534e4f 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -106,6 +106,16 @@ static int __init early_kasan_flag_stacktrace(char *arg)
>  }
>  early_param("kasan.stacktrace", early_kasan_flag_stacktrace);
>
> +static inline const char *kasan_mode_info(void)
> +{
> +       if (kasan_mode == KASAN_MODE_ASYNC)
> +               return "async";
> +       else if (kasan_mode == KASAN_MODE_ASYMM)
> +               return "asymm";
> +       else
> +               return "sync";
> +}
> +
>  /* kasan_init_hw_tags_cpu() is called for each CPU. */
>  void kasan_init_hw_tags_cpu(void)
>  {
> @@ -177,7 +187,9 @@ void __init kasan_init_hw_tags(void)
>                 break;
>         }
>
> -       pr_info("KernelAddressSanitizer initialized\n");
> +       pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, stacktrace=%s)\n",
> +               kasan_mode_info(),
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
