Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE67405139
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 14:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353155AbhIIMe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 08:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352956AbhIIMWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 08:22:48 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CFAC034037
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 04:46:13 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so2071617otk.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 04:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=scnpuQEkIxlsg5dECCNfy9fibrsqF7ou9Zg/wTCMvoU=;
        b=HocwwpvIksbWJirVOnxgkgytjZ7wOGw3bbBsvcTefpQe6yTb8YILKbo9qwPW2zKcia
         uAvzxBZRpgb629jFpVbEEOWJ+FyUmtFR/cF8wq6OSKdFbdT6dCilHyNssc6kHAtZhAlL
         rbotHx+W8bj0o/uX2Qoirf8mDSm4E4bTDGD/zbWkpH3FdbS/9e2mUxUET2Jp7p8LBeom
         c/Ph7Mxz1urJJNZGVjAztutFhA/8G6fuU4qfvO2MhrVThrZ+ABBVhpaMWc73QRzkcfcR
         hWMwVAzQL2HlpF8GkxmfcwWBaiauMOfQn7/q8GJ8gqrNC+IH9pZ+T6Y59KHvss1wqSYA
         SSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=scnpuQEkIxlsg5dECCNfy9fibrsqF7ou9Zg/wTCMvoU=;
        b=A9a1mLF2fzyrnVhW29Ti4hKC3F7dGtbsgLDE9UBIXAlhlerFLqhYp49NLUKasvrgdG
         52a/Ny7Mg/NhpmOOpgcn4PAYkbZuITzFj/XF0QcqzF0k/LHA3Da8iU+UKF6zo1TXwa/b
         eOGSoAeHFGKjDG5+Z0Wci5hjjNrJ05sXRueyMeBdLCcgjHsnenbEabUY+E99FkFD06dK
         ShDXQNS1Qq3fLYARl+RJGNZaIlxcjP0I72WIXmrYXUyisM6fg1g58Qr10Fmo4Og/c/yQ
         gMncwnf1rCUsU0Rt5LH1+fZ0mT2JVwRA/ZouZncU8KwkgPqqC7XlKVweZreqFTVv+GRZ
         wXhg==
X-Gm-Message-State: AOAM532TetZShqgEtJVDqiapDaA7T5TPSI3rSYBe7bZUvXqwtJb1mENK
        Yxc+hlPn1rTZF8x/CcRDJmMkcDDYJV86sdT2uXo0wA==
X-Google-Smtp-Source: ABdhPJzVOGJv68hgNTD6ItSe21Ujca3BqWEty2OpMmoHpzOLufjrr5uNJY5SgI4LWRC5Qv4frt+gwMvxWB38mBWp3tQ=
X-Received: by 2002:a9d:71db:: with SMTP id z27mr2066335otj.292.1631187972828;
 Thu, 09 Sep 2021 04:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210909104925.809674-1-elver@google.com>
In-Reply-To: <20210909104925.809674-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 9 Sep 2021 13:46:01 +0200
Message-ID: <CANpmjNOHG3z7qPKWBukjqHC6f1pxbdR1WOMUhsij9whyx0W=VQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: double -Wframe-larger-than threshold if KASAN
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Arnd Bergmann <arnd@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Taras Madan <tarasmadan@google.com>, linux-mm@kvack.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Sept 2021 at 12:49, Marco Elver <elver@google.com> wrote:
> All architectures at least double stack size when using one of the KASAN
> software modes that rely on compiler instrumentation.
>
> Until now, warnings emitted by -Wframe-larger-than could easily be
> ignored, as we would still get a working kernel.
>
> However, with the introduction of -Werror (CONFIG_WERROR=y), it makes
> sense to at least double the -Wframe-larger-than threshold for
> software-based KASAN modes to reflect the already increased stack sizes
> when building a kernel with KASAN enabled.
>
> Link: https://lkml.kernel.org/r/YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain
> Signed-off-by: Marco Elver <elver@google.com>

FWIW, there's still no consensus if this is what we want, and the
discussion continues at:
https://lkml.kernel.org/r/CANpmjNPBdx4b7bp=reNJPMzSNetdyrk+503_1LLoxNMYwUhSHg@mail.gmail.com

> ---
>  lib/Kconfig.debug | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ed4a31e34098..2055bbb6724a 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -345,6 +345,8 @@ endif # DEBUG_INFO
>  config FRAME_WARN
>         int "Warn for stack frames larger than"
>         range 0 8192
> +       default 4096 if 64BIT && (KASAN_GENERIC || KASAN_SW_TAGS)
> +       default 2048 if !64BIT && (KASAN_GENERIC || KASAN_SW_TAGS)
>         default 2048 if GCC_PLUGIN_LATENT_ENTROPY
>         default 1536 if (!64BIT && PARISC)
>         default 1024 if (!64BIT && !PARISC)
> --
> 2.33.0.153.gba50c8fa24-goog
>
