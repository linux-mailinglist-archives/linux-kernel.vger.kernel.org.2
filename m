Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50783B44B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 15:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhFYNrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 09:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhFYNrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 09:47:47 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066D0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 06:45:26 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id df12so13505206edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 06:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iL+ONoFlGB91h/2MUDT1aNEjicjs7hNRvFGJskZUmDk=;
        b=kiJfd8p4xmlfbbZeSAn7Lzj+f+Dlybzapab68m2GbQ4GvW+A/165hn6+a7u63+lL5M
         fmiLROxHMEoHu+rgaB8iM+cA7KHd25HadOrD0bN+0W8TumCO/d3Y897stl/sl9kr1Ji4
         lIZ0EYrGQk2nvmZKHixDg2iWcBGDsiGaql1sDyCuc1bKIFm5Avth0s+MgpnNAV9GJftx
         WJhC+gEsldsGSxaUb4snna01s+M1LtJb5Sbs2NGlahU1QE4mwG7MTczxaOcuCMdvhdVg
         vX6FUgy2TMfumXgLOfXFWl+5wTxxmMewDH7X/QET8Kut41gxOLuanOpo3n3TZqTwzrK6
         wWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iL+ONoFlGB91h/2MUDT1aNEjicjs7hNRvFGJskZUmDk=;
        b=aliX+qaRgdp7368mbIf4cdCrBLNwpmxxyeBGrfL5vl6tZFLQqMbeVghqLLHBT0Q3ke
         n4SZb3FECNk8gbul/rjOCgsi1b1IXWLkemSTPX+DtveqF2C2ChTlZFLRbrVEXNsgDBJr
         JlHIEhETU6MhjJff2QIOWgSVzKZSqSGtzdW5tIH88eHUGs3pVuDLr1pWC2CtG5ZuUXzV
         bREr84HoBIofl3q+IEjRkW4UjSwIEBcB6NgkMEQqqUAeuxjZ/bjQt/HLJxcpJfl5KTLi
         RD2znJDil3NhYUIOPkcRN78cbpaW/eXbPux4lvR0T1dHp0Lq6d7HHecFSqjMlkRP0fPU
         3y0g==
X-Gm-Message-State: AOAM533swPnHrsirc9RC5c3MurF0yB1EAh5p+rL/LbMK9Ofxwi07siCu
        mi4PafqVXO4jN3YTfKPUapfCuBdE2fTXb+ab2OI=
X-Google-Smtp-Source: ABdhPJx/7wjtLCAR6FYQikOX37FFylP8a7qQdtDOPEXfXKCSIS4vRYSHLyq4FbUNXPoqlm8HtjDFpeUqLxV3DCkiGxE=
X-Received: by 2002:a05:6402:4408:: with SMTP id y8mr14915135eda.55.1624628724627;
 Fri, 25 Jun 2021 06:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210624034050.511391-1-dja@axtens.net> <20210624034050.511391-2-dja@axtens.net>
In-Reply-To: <20210624034050.511391-2-dja@axtens.net>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 25 Jun 2021 16:45:02 +0300
Message-ID: <CA+fCnZeLFoqm6_bxVgwG3teP6688rvQ1vBJyor1dCfj6F7kLUQ@mail.gmail.com>
Subject: Re: [PATCH v16 1/4] kasan: allow an architecture to disable inline instrumentation
To:     Daniel Axtens <dja@axtens.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 6:41 AM Daniel Axtens <dja@axtens.net> wrote:
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
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  lib/Kconfig.kasan | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index cffc2ebbf185..c3b228828a80 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -12,6 +12,13 @@ config HAVE_ARCH_KASAN_HW_TAGS
>  config HAVE_ARCH_KASAN_VMALLOC
>         bool
>
> +config ARCH_DISABLE_KASAN_INLINE
> +       bool
> +       help
> +         An architecture might not support inline instrumentation.
> +         When this option is selected, inline and stack instrumentation are
> +         disabled.
> +
>  config CC_HAS_KASAN_GENERIC
>         def_bool $(cc-option, -fsanitize=kernel-address)
>
> @@ -130,6 +137,7 @@ config KASAN_OUTLINE
>
>  config KASAN_INLINE
>         bool "Inline instrumentation"
> +       depends on !ARCH_DISABLE_KASAN_INLINE
>         help
>           Compiler directly inserts code checking shadow memory before
>           memory accesses. This is faster than outline (in some workloads
> @@ -141,6 +149,7 @@ endchoice
>  config KASAN_STACK
>         bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
>         depends on KASAN_GENERIC || KASAN_SW_TAGS
> +       depends on !ARCH_DISABLE_KASAN_INLINE
>         default y if CC_IS_GCC
>         help
>           The LLVM stack address sanitizer has a know problem that
> @@ -154,6 +163,9 @@ config KASAN_STACK
>           but clang users can still enable it for builds without
>           CONFIG_COMPILE_TEST.  On gcc it is assumed to always be safe
>           to use and enabled by default.
> +         If the architecture disables inline instrumentation, stack
> +         instrumentation is also disabled as it adds inline-style
> +         instrumentation that is run unconditionally.
>
>  config KASAN_SW_TAGS_IDENTIFY
>         bool "Enable memory corruption identification"
> --
> 2.30.2
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks, Daniel!
