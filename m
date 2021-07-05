Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C9A3BBB73
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 12:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhGEKsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 06:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhGEKsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 06:48:01 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2A6C061760
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 03:45:23 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso17888880otu.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 03:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/dlGtZu9Ej/xN5Tsuqsmc/vVOMpJLibVcfVItFdDo7U=;
        b=rzSYkZK4ThrPA7smzcFNs/5Jpclbny/wcmfSQ8ORkq914C2DoGl0LnnmVaVBf+GSTU
         cLg454r3cKsTz8r0/LI3A8jiqvat498AEPySwnwQDrkBQB2Z8MPavannymAkadlwCbfx
         Csku08DMBzkEafDnNel69M7EN0kR7nB9LMem4pcRtUUH+kql+y8bf8n0b2GFWDknwps6
         //spGXvECrbO40sSisf4xvjw2KfLYVu2/TIhODA91ZPkGbr3BWPAY+C8hUppoPo728RU
         VKby50aiKF843yEXxbKAGEFYcuw8/4FVbXCC7lfE5ubVb87wKWwmyU5A+9xmy94ciW/Z
         fe0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/dlGtZu9Ej/xN5Tsuqsmc/vVOMpJLibVcfVItFdDo7U=;
        b=tnn4Kzs6ikueu4Zg5cutvjqphMJnu2jDKwFQ1nAj8G+jmdP7iVjvzUhv0wFTXgsULd
         zPuAQWFwmY9DpgXL1D3pu6JctOcqTtifXV2tCcMSkWO89hEHMsEwqZvuRLyY19xOctDe
         zyiLhWnUmpbCJ0QrdGevxMi0k45Zjy94zVqU5Fw125bqnxhlh3nbMhrLEEUCkWBkz6Rm
         rSKLwMG8FNw9dg1KMmfPCg+OaHtrnP+MfWqQZeb4g59C8l8v1cLzcqPsVHjmusFjQwjL
         V65lTSHikhvz2rpbfcdWNUpnlotPUMz5ObZRqpFIbBx5VhgI/zYb6NgZ5XILwS+gc3Z6
         g7GQ==
X-Gm-Message-State: AOAM532lDelIG+5JHrzRx/GaaXVCv+pcqlakoBl+QvxnpjBgYdPDU1Ry
        nqzfIaNVBAG6PR4FXbZmTQeiNIi+WOa6T6YbZForGw==
X-Google-Smtp-Source: ABdhPJz7Ojrr+OaKK7eh0H330aLKUBIAQgR26pV3/KDO8TkXS7oJOSMJQ2lq5muUp+LwEhxnKBOuBoP/AfYymTXkTok=
X-Received: by 2002:a9d:d04:: with SMTP id 4mr10779395oti.251.1625481922714;
 Mon, 05 Jul 2021 03:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210705103229.8505-1-yee.lee@mediatek.com> <20210705103229.8505-3-yee.lee@mediatek.com>
In-Reply-To: <20210705103229.8505-3-yee.lee@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 5 Jul 2021 12:45:11 +0200
Message-ID: <CANpmjNMg7DwVJL10AesxTsiz_9UEuwZkAxdGrQdsmxOR4qiHXQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] kasan: Add memzero int for unaligned size at DEBUG
To:     yee.lee@mediatek.com
Cc:     linux-kernel@vger.kernel.org, nicholas.tang@mediatek.com,
        Kuan-Ying.Lee@mediatek.com, chinwen.chang@mediatek.com,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KASAN" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jul 2021 at 12:33, <yee.lee@mediatek.com> wrote:
> From: Yee Lee <yee.lee@mediatek.com>
>
> Issue: when SLUB debug is on, hwtag kasan_unpoison() would overwrite
> the redzone of object with unaligned size.
>
> An additional memzero_explicit() path is added to replacing init by
> hwtag instruction for those unaligned size at SLUB debug mode.
>
> The penalty is acceptable since they are only enabled in debug mode,
> not production builds. A block of comment is added for explanation.
>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Suggested-by: Marco Elver <elver@google.com>
> Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Yee Lee <yee.lee@mediatek.com>

Reviewed-by: Marco Elver <elver@google.com>

Thank you!

> ---
>  mm/kasan/kasan.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 98e3059bfea4..d739cdd1621a 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -9,6 +9,7 @@
>  #ifdef CONFIG_KASAN_HW_TAGS
>
>  #include <linux/static_key.h>
> +#include "../slab.h"
>
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_stacktrace);
>  extern bool kasan_flag_async __ro_after_init;
> @@ -387,6 +388,17 @@ static inline void kasan_unpoison(const void *addr, size_t size, bool init)
>
>         if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
>                 return;
> +       /*
> +        * Explicitly initialize the memory with the precise object size to
> +        * avoid overwriting the SLAB redzone. This disables initialization in
> +        * the arch code and may thus lead to performance penalty. The penalty
> +        * is accepted since SLAB redzones aren't enabled in production builds.
> +        */
> +       if (__slub_debug_enabled() &&
> +           init && ((unsigned long)size & KASAN_GRANULE_MASK)) {
> +               init = false;
> +               memzero_explicit((void *)addr, size);
> +       }
>         size = round_up(size, KASAN_GRANULE_SIZE);
>
>         hw_set_mem_tag_range((void *)addr, size, tag, init);
> --
> 2.18.0
