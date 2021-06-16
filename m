Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8453A9597
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhFPJMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbhFPJMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:12:16 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EAEC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:10:10 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so1835454oti.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N0yUvQwf56uXT+DeZe9wCbbuUfkwdrAhTZdP0qYYdjo=;
        b=qXg9QAKzdXfthLDxP6zeemP2casijCB6XU3FXrtn/t+04x7cIVKbqlwYXO/NW83y5N
         FYeOBm0U+vOR+S7vlL8vPEZS92ikMZai1afR/J68OkxxbK60emPCifUaoZRWR670JtV1
         i4RKNRk8bvwV3XC2sEDdy3AREtzi3oAkh5npEUNKEMvf/XXsQiUWIHioCfJ2JvhzVWx3
         +FVwpFNpV7NAUxq8aYV9V+myvwS+QfWj4fHQHarGOIUQQuYX0csczWusfl3gIUdHe9G0
         MfmhYwJ/pyvOYerwoV70BhYPYVJs2K05Ax3GUAuSmT11jM9gjgJWbwDFkCcHvaLdHqE4
         rzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N0yUvQwf56uXT+DeZe9wCbbuUfkwdrAhTZdP0qYYdjo=;
        b=fHHLs5/DNFTuZOHzCPzfTsFBHP1eW33I32Fq5efiC8X56OoFrheIIuxvBiNcrpfO/G
         EQ4dR28EatJYUKUWjIuR+u5cZVsSqR09ojQRxfH4Ye5tdFPdue1nVbeOVNQVw1dgfjiP
         axoHhCPSLR/J/Obu/7HdKi4wUQcymUIaQ7VxbT4Zlo4QIDSyKLGhcHgkUCX3v/3Gf6Yv
         6Z2zNo1xnotzIX6Vbp3TsmqLnAB5nFmGfF+jw0qxw5+mbN4xbgmv0Lq96eZ2adHstlc2
         oEgJcPTVgb1e8vQeDV/Ygs2LWFEm8MMSurAKQvRNgRS2fYlya5egvO+z16CuWJcusbmz
         ikRw==
X-Gm-Message-State: AOAM5314v7G+E6zFBpKLWCq/132qJGeq+FpZKoxOPDDnsXVpQpqeJAPg
        CrLu2suWxdbVd8iUvJdDd781G9o+3Kw+i4EhYFmIug==
X-Google-Smtp-Source: ABdhPJx1G9LDKsKvRnPr8r/8O1kIeSWz9edQGXedMPBDTIvsoOVeeLazZvcfHNZ+C56BFqonRi3Th8V82rYc6uHhg/w=
X-Received: by 2002:a05:6830:1591:: with SMTP id i17mr517649otr.233.1623834609650;
 Wed, 16 Jun 2021 02:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210616080244.51236-1-dja@axtens.net> <20210616080244.51236-2-dja@axtens.net>
In-Reply-To: <20210616080244.51236-2-dja@axtens.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 16 Jun 2021 11:09:57 +0200
Message-ID: <CANpmjNPnRXpmn1fJOMp8pTMvzj-obhoZHN+r8ZQMUS8jEQ3Ozw@mail.gmail.com>
Subject: Re: [PATCH v13 1/3] kasan: allow an architecture to disable inline instrumentation
To:     Daniel Axtens <dja@axtens.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        aneesh.kumar@linux.ibm.com, Balbir Singh <bsingharora@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 at 10:02, Daniel Axtens <dja@axtens.net> wrote:
>
> For annoying architectural reasons, it's very difficult to support inline
> instrumentation on powerpc64.*
>
> Add a Kconfig flag to allow an arch to disable inline. (It's a bit
> annoying to be 'backwards', but I'm not aware of any way to have
> an arch force a symbol to be 'n', rather than 'y'.)
>
> We also disable stack instrumentation in this case as it does things that
> are functionally equivalent to inline instrumentation, namely adding
> code that touches the shadow directly without going through a C helper.
>
> * on ppc64 atm, the shadow lives in virtual memory and isn't accessible in
> real mode. However, before we turn on virtual memory, we parse the device
> tree to determine which platform and MMU we're running under. That calls
> generic DT code, which is instrumented. Inline instrumentation in DT would
> unconditionally attempt to touch the shadow region, which we won't have
> set up yet, and would crash. We can make outline mode wait for the arch to
> be ready, but we can't change what the compiler inserts for inline mode.
>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Marco Elver <elver@google.com>

Thank you.

> ---
>  lib/Kconfig.kasan | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index cffc2ebbf185..cb5e02d09e11 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -12,6 +12,15 @@ config HAVE_ARCH_KASAN_HW_TAGS
>  config HAVE_ARCH_KASAN_VMALLOC
>         bool
>
> +config ARCH_DISABLE_KASAN_INLINE
> +       bool
> +       help
> +         Sometimes an architecture might not be able to support inline
> +         instrumentation but might be able to support outline instrumentation.
> +         This option allows an architecture to prevent inline and stack
> +         instrumentation from being enabled.
> +
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
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210616080244.51236-2-dja%40axtens.net.
