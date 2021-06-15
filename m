Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191123A7838
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 09:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhFOHsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 03:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhFOHsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:48:33 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269D4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 00:46:29 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so13474412otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 00:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iSVyAacN7l8MRU6+yXnglhfZd0yPT6M71q0qhoSn658=;
        b=Ma5dk7dw0py0KMSezsjczrNLk2CqZKg10JsIjyEe3U1pEvt5ydu0bUCARaRJ4qeU5L
         IWbS57fwsWyMAKpwDOsj0Al0AZWttPfUdRJkX/g9LsxM8DhlXrWVFVngFvAlaFRPd+bM
         wCI3fJ8zFZDal4fw1RhxmNpYqgXqmsSz+hIfI6J/WkJcINCWTgPji8QxdTaE4ViYxLab
         X9cpI1EvtyDDoAgzipck4FVqQrEau2v5WXDpkNVBzo0kBpK8oVI+qy+O0otdYEFni1Ba
         rYtoVW/wNEsmiX0tg4zEatuiCYZw8BMmHJwXeSBCbG85/X43XF0gkIYlWj4u4EreqbZ4
         CrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iSVyAacN7l8MRU6+yXnglhfZd0yPT6M71q0qhoSn658=;
        b=B0XgRxY4CEJn5fhIPP/mTkV7w5q0/OprFWPd0Xubs+Drfo/mEONWUUGBiAoyclstr/
         afkHeLr+znQj4kM01U3EiUkY+sytsQ6Aux5pPhEbBdwm7f7FF76FQU3lk8z5mQHMu0w7
         E1m+bIfxJ0tOo9JLL34g84Y5mvl548F7vtKBaGOragB3UypwsM+n8E9+v9lv5GctRvjH
         bKNKkblddfymqYHU0Zvd4qopVLXGtm+7re4YbZpT3VwXJFICKX50g/UFu38jevNFCQvF
         H3w3nRK9vJxs8R/f2vLL3+1ysFrUEkM7iZch884HEttNNVFhzPv2Pv9aJT98QL/xBG06
         KS8Q==
X-Gm-Message-State: AOAM530vM8y6FCch9TL4qRtT0AJJgiJtwiv7jiezFNLXsI/fGiZC68Oz
        sLty5gm3qCnqKl8K9UX3iILbVljOQVxGpImI7OOpWw==
X-Google-Smtp-Source: ABdhPJxTwVuYpOsUHB/zZCmNgAEl0R34kaWfPaSAc5XQzSsCOzmFbbJ5xQFNjbnBZfWDTPH1mExgV8EmLRtJfclXSTU=
X-Received: by 2002:a05:6830:93:: with SMTP id a19mr16704693oto.17.1623743188202;
 Tue, 15 Jun 2021 00:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210615014705.2234866-1-dja@axtens.net> <20210615014705.2234866-2-dja@axtens.net>
In-Reply-To: <20210615014705.2234866-2-dja@axtens.net>
From:   Marco Elver <elver@google.com>
Date:   Tue, 15 Jun 2021 09:46:16 +0200
Message-ID: <CANpmjNOa-a=M-EgdkneiWDD0eCF-DELjMFxAeJzGQz6AgCdNWg@mail.gmail.com>
Subject: Re: [PATCH v12 1/6] kasan: allow an architecture to disable inline instrumentation
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

On Tue, 15 Jun 2021 at 03:47, Daniel Axtens <dja@axtens.net> wrote:
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
>  lib/Kconfig.kasan | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index cffc2ebbf185..935814f332a7 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -12,6 +12,15 @@ config HAVE_ARCH_KASAN_HW_TAGS
>  config HAVE_ARCH_KASAN_VMALLOC
>         bool
>
> +# Sometimes an architecture might not be able to support inline instrumentation
> +# but might be able to support outline instrumentation. This option allows an
> +# arch to prevent inline and stack instrumentation from being enabled.

This comment could be moved into 'help' of this new config option.

> +# ppc64 turns on virtual memory late in boot, after calling into generic code
> +# like the device-tree parser, so it uses this in conjuntion with a hook in
> +# outline mode to avoid invalid access early in boot.

I think the ppc64-related comment isn't necessary and can be moved to
arch/ppc64 somewhere, if there isn't one already.

> +config ARCH_DISABLE_KASAN_INLINE
> +       bool
> +
>  config CC_HAS_KASAN_GENERIC
>         def_bool $(cc-option, -fsanitize=kernel-address)
>
> @@ -130,6 +139,7 @@ config KASAN_OUTLINE
>
>  config KASAN_INLINE
>         bool "Inline instrumentation"
> +       depends on !ARCH_DISABLE_KASAN_INLINE
>         help
>           Compiler directly inserts code checking shadow memory before
>           memory accesses. This is faster than outline (in some workloads
> @@ -141,6 +151,7 @@ endchoice
>  config KASAN_STACK
>         bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
>         depends on KASAN_GENERIC || KASAN_SW_TAGS
> +       depends on !ARCH_DISABLE_KASAN_INLINE
>         default y if CC_IS_GCC
>         help
>           The LLVM stack address sanitizer has a know problem that
> @@ -154,6 +165,9 @@ config KASAN_STACK
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210615014705.2234866-2-dja%40axtens.net.
