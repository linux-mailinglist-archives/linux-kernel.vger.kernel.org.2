Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187AE3BBC20
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhGEL0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhGEL0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:26:22 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE82BC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 04:23:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s15so23231960edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 04:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/twNUpcgioeZ8e0ihy4OvgQsOjAP9TO2paDyac3Qkg=;
        b=YM1PR4H9+B8L8UwdtxpjutwB0rqH38R2O5DOrey1dK4UErgqysTvI+jj6ATz2yvQWG
         hPXFPXCn4AxF4al8wuVWBHAWFU7Zamp+OpUBbIdBbO9vryr5tC6J3hYvjIK4M5xkTxyw
         A6kPbU9iiglpyYbCk5dZ4DYIAov+znHDcB5iFbZO/U7EftfericcwXSaBDEw8t31BjCB
         FncrlAL3zbRDQr3iMPIlPGF1PLZFfHZO+mEOgJputwH/D57Np0JF5OI1UQ/+JiypcY6R
         rbNYFR9vSubxKeS0TvansMdId29zqxKXA6SrrOpfk7BzauMC51wndZlwa25vNNa8vSvn
         jAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/twNUpcgioeZ8e0ihy4OvgQsOjAP9TO2paDyac3Qkg=;
        b=QRHsl5KtsCPZJB2nRDpoNo6ZLEjqi5SKhtZRsAwlR4pQTxW5Y5B1fUtIw71lB7U9Xe
         7FnqtbFSnqz5slMCrzi7AZBO7BeM+Jwr/6FH9n90yuDa6TFW206ndKGY0mUzC7a1R0QO
         O2WaTPDDi2zeJEOMUGBUgG/lt4AS6Is/NWzqTNUDl4wOZYm+j3+Ix8bVquSsM2mBqiB+
         AqasOb8hSSNRBFK+2DewVVw1qujuwI4mrvFI7I9O2wcgMHuY5gbEzzv7nS4lYSv8mNJ9
         +Yx8nhVOTSGDPxzUdqdNDwn2ydrCKBXNTbABvhkxUDWnHmmJuR8QpyhPQdNZsXvHV+M5
         7vbg==
X-Gm-Message-State: AOAM531P2NlGayRlXuIyhgQQvLTadNKvISKfU8SHVOx9OfcKkA3rNXKu
        NNtw62zUv7d7J+uteahbBoBa0DLYpn8q1SnKdS0=
X-Google-Smtp-Source: ABdhPJxpa2IOlQc2LEHppS6wdYTu08dyDoHQP1v4Cdpbx6OBtbIxpdca+P2eecENgraXfPvnlr+f9YlLyHcZWvqk2Eo=
X-Received: by 2002:a50:fb96:: with SMTP id e22mr8621005edq.95.1625484224390;
 Mon, 05 Jul 2021 04:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210705103229.8505-1-yee.lee@mediatek.com> <20210705103229.8505-3-yee.lee@mediatek.com>
In-Reply-To: <20210705103229.8505-3-yee.lee@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 5 Jul 2021 13:23:33 +0200
Message-ID: <CA+fCnZfr3vU3ZwGQk06JFRURDgP7qHF6RaUpJtu5V+w6ToAb8w@mail.gmail.com>
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

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
