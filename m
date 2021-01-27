Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B383F306611
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhA0V3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbhA0V1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:27:15 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4842AC061786
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:26:08 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id q131so2148510pfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H4wYdYZxwdbWGzK2JDLYdiHMKyIE6uo335eyGMtSLco=;
        b=pVvARrOgazAx47oDVr+JRrz3THFq6XZdUlV/9hocdgX6rmuAoOUbnhNma9j5cf2qq9
         HExK2XtTjt9AOgnHY8n0Qn9QvTUnJcA2/SYPBJg1hiPKZ56sbs8MnPAQv09rDk/XQSdK
         /RtYc8ClMUFRPQOONGh8q/rTjY8nf6+N1fnNWwDbWRsSK1M6fY1MqQRUpxieuX9YiCbZ
         wiaYOkKn9InRJYdHlt80E17MqvH5K7g5KJDMVw4V4JhRHknnHF+Sm6Km/qxJyoxi+kwc
         AAJYk6Hc+92YI3tl13bNmoM5OfHt7+7+VwDN502Hf28vWOJtWWjmoEyPaUsJEFUbrR+u
         msUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H4wYdYZxwdbWGzK2JDLYdiHMKyIE6uo335eyGMtSLco=;
        b=KGMXCgSYgMHnRKZANQ3IJ37+bchGTJi2O0499UtXKQEr1kNjP3n85dVZd/OP+VIn1L
         Eix3hwM7p+C29jm/G+oFnxW2hv2Y/BYpy6HMDctY1U+dBUhbayxT9sh9LyGBhIzFQI73
         7foDMhT5WsY5pyEwZtgCaqeAWBk8ziRYTB8Evv6KKNPhXYQ1LEtEOB4DB4KV7o3Djml4
         GHNUW55nfcvu2AIwkpStRh9O4lQda6LA6bZ92VAWJpdZpLt5sYmlvndG8xYQ03RrVCAh
         ga5JI6mfyeLfkgUMIe06Kq4pwcyaflDyvP7gt4AljezcN4UbQXIyV5CTTCxjEJbWzP8l
         rr1g==
X-Gm-Message-State: AOAM5312VekpYc1OBkHlDvB+AnlT65PgtchdN/2dYYS3htzG+FB+1Sp8
        ZbcTg9XUrNrCKX1xFEBiR6IugLMpaIjpN8KWZy+HNQ==
X-Google-Smtp-Source: ABdhPJwqCNPlPDpaL1i90PWLetMonQPmkN+B816BhKFxVw2dI+707/Lr0UAOHEgTEbKHZPdYieTwKogk1rPqlXc4qsc=
X-Received: by 2002:a62:18d6:0:b029:1bf:1c5f:bfa4 with SMTP id
 205-20020a6218d60000b02901bf1c5fbfa4mr12428501pfy.24.1611782767499; Wed, 27
 Jan 2021 13:26:07 -0800 (PST)
MIME-Version: 1.0
References: <20210125112831.2156212-1-arnd@kernel.org>
In-Reply-To: <20210125112831.2156212-1-arnd@kernel.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 27 Jan 2021 22:25:56 +0100
Message-ID: <CAAeHK+yOTiUWqo1fUNm56ez6dAXfu_rEpxLvB1jDCupZNgYQWw@mail.gmail.com>
Subject: Re: [PATCH] kasan: export kasan_poison
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 12:28 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The unit test module fails to build after adding a reference
> to kasan_poison:
>
> ERROR: modpost: "kasan_poison" [lib/test_kasan.ko] undefined!
>
> Export this symbol to make it available to loadable modules.

Could you share the config you used to trigger this?

> Fixes: b9b322c2bba9 ("kasan: add match-all tag tests")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/kasan/shadow.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index de6b3f074742..32e7a5c148e6 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -94,6 +94,7 @@ void kasan_poison(const void *address, size_t size, u8 value)
>
>         __memset(shadow_start, value, shadow_end - shadow_start);
>  }
> +EXPORT_SYMBOL_GPL(kasan_poison);

Should this be _GPL? All of the other EXPORT_SYMBOL() we use in KASAN
are without the GPL suffix.

>
>  void kasan_unpoison(const void *address, size_t size)
>  {
> --
> 2.29.2
>
