Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE833BBC01
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhGELPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhGELPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:15:19 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10270C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 04:12:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t3so23245722edc.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 04:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CaX0flpcWSf1BxIX9YKTaXTNjn37cg6419yg5j4auho=;
        b=jEnaley92nsYz6JbSlRThV2E1YRPY06sNCdtkau2fgB2TykXtcwbJCOtCezAV/vc8w
         4hDhe7kUwItFuUTLiiagNALF9ddj3LvI9kkEuJ9R92C/whZQ3vkZkwX1vCXIm8Ku1qzp
         z78re286Qlfn/qoPoSuG6qaVge0tBY4ZHgiys64KOnqifOQt6boJwkcYJgyBEhRGQYp4
         7o+/a95mXCP6Lwx41+T6LEZqahRtOluMr+qhtfwZLUiiBnUsCxsvQ/qj4BW0MsdnTych
         3Nm/eSxg8yMU1KdU9GSuJma36mm9SRV7maxOFBYk2RMuFpGkaJzQSv4aIRUBJXK2jp6M
         8c/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CaX0flpcWSf1BxIX9YKTaXTNjn37cg6419yg5j4auho=;
        b=sOPDXbRACOCs4v3fyr05NoBU76VPgnl3vAG9TjiiCCz83jue5Lah9tH8e24+PaFEqJ
         Xwv/b3hijCUC56p069NzDUAkq/fAJ1fthqVwlX05LuN3kjT9Rc1STn8S49yfhghtWrtH
         geyd3Gm1CEmIbxQq4MPYH9pqoFRHaWGMsT6iOJhmd7UzWxbUkQh3EUv+nUFFmte+jo/r
         SS5QBaXcNqC9XGyjrHZhBLUD8wFDyPf5OLFA9rPI3ONoM6br2ZSpXdpwoCgCRagmMe5Q
         a1a5dijGQwAEDwKpMJuVTjjsfIX9xVnxLO+MLPyCS3mceGRwDkfGqVBKIApyL05w5bEN
         bitg==
X-Gm-Message-State: AOAM533iOgcMTI7Lw4UDES6YShgrAwCIFMDPOQFXPNjyBH6z6zaacYlJ
        88gc1Z8Ca4D3jhEYW0VWeXFP+G1v4D5AxLKV0eA=
X-Google-Smtp-Source: ABdhPJy1aBflyEaVGfXBsnIY/o25eWlDAwK3mLAMTUP6Iud2PfckMEFvKMrhc6r3H3jzgXvU/DLBkOCb9vEH/JghMVM=
X-Received: by 2002:a05:6402:5c9:: with SMTP id n9mr3075816edx.30.1625483561668;
 Mon, 05 Jul 2021 04:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210705103229.8505-1-yee.lee@mediatek.com> <20210705103229.8505-3-yee.lee@mediatek.com>
In-Reply-To: <20210705103229.8505-3-yee.lee@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 5 Jul 2021 13:12:30 +0200
Message-ID: <CA+fCnZdhrjo4RMBcj94MO7Huf_BVzaF5S_E97xS1vXGHoQdu5A@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] kasan: Add memzero int for unaligned size at DEBUG
To:     yee.lee@mediatek.com
Cc:     LKML <linux-kernel@vger.kernel.org>, nicholas.Tang@mediatek.com,
        Kuan-Ying Lee <Kuan-Ying.lee@mediatek.com>,
        chinwen.chang@mediatek.com,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Mon, Jul 5, 2021 at 12:33 PM <yee.lee@mediatek.com> wrote:
>
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

What happened to slub_debug_enabled_unlikely()? Was it renamed? Why? I
didn't receive patch #1 of v6 (nor of v5).

> +           init && ((unsigned long)size & KASAN_GRANULE_MASK)) {
> +               init = false;
> +               memzero_explicit((void *)addr, size);
> +       }
>         size = round_up(size, KASAN_GRANULE_SIZE);
>
>         hw_set_mem_tag_range((void *)addr, size, tag, init);
> --
> 2.18.0
>
