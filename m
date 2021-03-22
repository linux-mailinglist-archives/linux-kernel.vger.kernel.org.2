Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB586343B95
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhCVITh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhCVITI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:19:08 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C70C061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 01:19:07 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 125-20020a4a1a830000b02901b6a144a417so3879939oof.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 01:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JBfYmKFZfBEnELsahissKGVzgwoqNgBhQO83P0Ky7Zc=;
        b=vbc/hSaV4MuILyTU4P286uzmQVg34MFU7tQUli92lqMnCXWwFUEbXjQIcMpQSlbqpZ
         vCxpSDAOlaKA/4gPzfUIYMOlbCkj45dAwFF9YgyEGe2fyM1jGtbeISW7T3IprN048F3o
         IkmFqA7MYPGDrWaBcerQ8t3/QzjJ3VmbPg9EBw/MyxaInCYzs9kcemcD/YSVOeHmXBe6
         s7cQxiDZCAFmEbHysreQQLCkGqG3LXNGCSsbGwPs6K36c+Kt54OUCzI8ws19WhpYSryf
         lMkMu0YSVCvhS+HK5mLoSOHfRS95+Wi8951HhXuO0m64scpOGKlA0N3ZEv6XHVv2IOwa
         VPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JBfYmKFZfBEnELsahissKGVzgwoqNgBhQO83P0Ky7Zc=;
        b=nn3SKNB3qK/k26tmSPehN98l38gyNTQJKB6rbuk3W5e62ljjRTJAiGCxldSaHV1pcW
         0g7nPvmkhtNqSo3LC/8RSFWVhq3mHMnnriRKg2NAVXlnKKIHMyxi3wGymgo4wIoMX/oh
         UFZM4AQTGFE+Cb93MjLTQsUXQwVzfnDD5tzOcYh6wMOGelqTCwCWpS2RgyX1S4wIHR4t
         uACxjylqT3I1acTtJFwIf8yNQnTucQmuwyaL4AHaRZiV4MM6Olw/G3FlTMNnFcJV8Qa5
         DxYRydHkO6ejmfA6ANwZVC09KEvfXxHpBpYJjv8ORsxHfFohiXueh+vVIPYoi0JLDmpS
         01hQ==
X-Gm-Message-State: AOAM530FtDTk+9Azs0AQ4pVATyKqc7jezhApmu/yLX2BmEeXXs+9JEBe
        eXY1cWn6E5ySjsOsERqoUvD1bYHxzAKZIoD+V2lKLg==
X-Google-Smtp-Source: ABdhPJzOfhULA7o6Ke4gbHHc79cRpiFVd1ZzcejhYH+UmuCFogcw4AsJutpy6ZzMe2Ucj0nst5L5zLnLOTOkGxaY3p0=
X-Received: by 2002:a4a:d0ce:: with SMTP id u14mr10172401oor.36.1616401147100;
 Mon, 22 Mar 2021 01:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210319144058.772525-1-dja@axtens.net> <20210319144058.772525-2-dja@axtens.net>
In-Reply-To: <20210319144058.772525-2-dja@axtens.net>
From:   Marco Elver <elver@google.com>
Date:   Mon, 22 Mar 2021 09:18:55 +0100
Message-ID: <CANpmjNOygpN7Aifd_+ycvxA+zNvyb9rF7mTA_yCfjbRK9evLGA@mail.gmail.com>
Subject: Re: [PATCH v11 1/6] kasan: allow an architecture to disable inline instrumentation
To:     Daniel Axtens <dja@axtens.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        aneesh.kumar@linux.ibm.com, Balbir Singh <bsingharora@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 at 15:41, Daniel Axtens <dja@axtens.net> wrote:
>
> For annoying architectural reasons, it's very difficult to support inline
> instrumentation on powerpc64.
>
> Add a Kconfig flag to allow an arch to disable inline. (It's a bit
> annoying to be 'backwards', but I'm not aware of any way to have
> an arch force a symbol to be 'n', rather than 'y'.)
>
> We also disable stack instrumentation in this case as it does things that
> are functionally equivalent to inline instrumentation, namely adding
> code that touches the shadow directly without going through a C helper.
>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  lib/Kconfig.kasan | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index cffc2ebbf185..7e237dbb6df3 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -12,6 +12,9 @@ config HAVE_ARCH_KASAN_HW_TAGS
>  config HAVE_ARCH_KASAN_VMALLOC
>         bool
>
> +config ARCH_DISABLE_KASAN_INLINE
> +       def_bool n
> +

Does just "bool" work here?

>  config CC_HAS_KASAN_GENERIC
>         def_bool $(cc-option, -fsanitize=kernel-address)
>
> @@ -130,6 +133,7 @@ config KASAN_OUTLINE
>
>  config KASAN_INLINE
>         bool "Inline instrumentation"
> +       depends on !ARCH_DISABLE_KASAN_INLINE
>         help
>           Compiler directly inserts code checking shadow memory before
>           memory accesses. This is faster than outline (in some workloads
> @@ -142,6 +146,7 @@ config KASAN_STACK
>         bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
>         depends on KASAN_GENERIC || KASAN_SW_TAGS
>         default y if CC_IS_GCC
> +       depends on !ARCH_DISABLE_KASAN_INLINE

Minor, but perhaps this 'depends on' line could be moved up 1 line to
be grouped with the other 'depends on'.


>         help
>           The LLVM stack address sanitizer has a know problem that
>           causes excessive stack usage in a lot of functions, see
> @@ -154,6 +159,9 @@ config KASAN_STACK
>           but clang users can still enable it for builds without
>           CONFIG_COMPILE_TEST.  On gcc it is assumed to always be safe
>           to use and enabled by default.
> +         If the architecture disables inline instrumentation, this is
> +         also disabled as it adds inline-style instrumentation that
> +         is run unconditionally.
>
>  config KASAN_SW_TAGS_IDENTIFY
>         bool "Enable memory corruption identification"
> --
> 2.27.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210319144058.772525-2-dja%40axtens.net.
