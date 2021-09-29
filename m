Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812AC41CC7A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346517AbhI2TQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344094AbhI2TQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:16:31 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45556C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:14:50 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g41so15020755lfv.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mDIHNqxX9Fp8iiFTAvj5TgT5mn2InH9rtjbNe9JUOVc=;
        b=bKY7C5IcjqavnCqVxihn9nHiGkMGiMtGwrm2kfRvll1oMIo+bT1kqscky7Sw5FKxxf
         RSow5PD50qjDN6jxSzc1V9RCYDNAbELzzGkgDl3sH8rQFMTb5NfhosDA2hcTPkBiEs9d
         lLZ/B0d3BrL5la+7B9iIiXuzwUj1vcevZp+I+EJl6Y+VTzqOeVv5LjJ4c1BFHGOZVEB7
         9F1m5Sc/s8dSx7z41gdKWS1zydSpd8E9QrlJKUAuRA/xZ2vomuBMSI+dN701Fne3hvfR
         Y+Vyuj1JbJ9uao+pkT+EOybZ4ML6dsYpWx6SJi9zRuLxftvJmf5oDFl5QXBoINPuFlJM
         iXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDIHNqxX9Fp8iiFTAvj5TgT5mn2InH9rtjbNe9JUOVc=;
        b=kaifqb8YFiqPSeUtAkn95CqwCua6fLIAqmErPrpLPvWeovtRhruVXhtpIUKeUl3zLo
         6E0WS31rUg8pc5UWWjD6ZTJfYhv1aUPcI9bb7xBAr9QKk9EdCeHHxuY/+KGd2CNxu9QL
         APwFCnyFD/OFNM2qQIF0PsjjuaQqfuQXgFoMD+6SuQ1odWguGtI2NngUeC7RiEfx1IzG
         A1HYb+E72ZjImq8aI0Gh3E407u6B+m2vB781Ms2lDuptDqlEtRpFrZ4mKtgpcilERQN0
         Roe/0AIrwyMciNyyJYYC/7I//Rc2R67rYmTCG+HDlJkKTVcFVEA1FsODadOMirwrKUrj
         o/5Q==
X-Gm-Message-State: AOAM5336uh/3XbZVSk6eQvXVuPnNG5IxxD5yox01XhEI0fnrXvria7bK
        nD3qd1k4czPXm853+XIR5q+eJ2GKfpVULdsopQ1sEw==
X-Google-Smtp-Source: ABdhPJwUC21w9EPT7MxbyN//j9rdIOl3NsSsHXixRJqVJs9/TftB+fMW8zXEGAuzgGk7MPUx34BuO6hryBxkrerd1Uo=
X-Received: by 2002:a2e:461a:: with SMTP id t26mr1653883lja.198.1632942888274;
 Wed, 29 Sep 2021 12:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210929190810.1597399-1-ndesaulniers@google.com> <CAKwvOd=v+1H4CrDDFENGiUx=9-Q3ieMsA9P7G270pSpW1jC-Yw@mail.gmail.com>
In-Reply-To: <CAKwvOd=v+1H4CrDDFENGiUx=9-Q3ieMsA9P7G270pSpW1jC-Yw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 29 Sep 2021 12:14:36 -0700
Message-ID: <CAKwvOdmjZ+QmjTJnQ-w5hLPJjow1gYnWTe6f8RBhQUJ2b3cYnw@mail.gmail.com>
Subject: Re: [PATCH] ARM: mm: proc-macros: ensure *_tlb_fns are 4B aligned
To:     linux-arm-kernel@lists.infradead.org
Cc:     Fangrui Song <maskray@google.com>,
        Peter Smith <Peter.Smith@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dave Martin <dave.martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 12:10 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> + Dave (Dave, I got a bounceback on your linaro.org email address.
> Consider sending a patch updating the .mailmap)
>
> On Wed, Sep 29, 2021 at 12:08 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > QEMU 6.1.0 is more correct about trapping on misaligned accesses. A
> > kernel built with CONFIG_THUMB2_KERNEL=y and using clang as the
> > assembler could generate non-naturally-aligned v7wbi_tlb_fns which
> > results in a boot failure. The original commit adding the macro missed
> > the .align directive on this data.
> >
> > Fixes: 66a625a88174 ("ARM: mm: proc-macros: Add generic proc/cache/tlb struct definition macros")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1447
> > Link: https://lore.kernel.org/all/0699da7b-354f-aecc-a62f-e25693209af4@linaro.org/
> > Debugged-by: Ard Biesheuvel <ardb@kernel.org>
> > Debugged-by: Nathan Chancellor <nathan@kernel.org>
> > Debugged-by: Richard Henderson <richard.henderson@linaro.org>
> > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  arch/arm/Kconfig          | 1 +

d'oh, had an unintentional `-a` when I did `git commit`. Will resend a v2...

> >  arch/arm/mm/proc-macros.S | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index fc196421b2ce..b760dd45b734 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -92,6 +92,7 @@ config ARM
> >         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> >         select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
> >         select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> > +       select HAVE_FUTEX_CMPXCHG if FUTEX
> >         select HAVE_GCC_PLUGINS
> >         select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
> >         select HAVE_IRQ_TIME_ACCOUNTING
> > diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> > index e2c743aa2eb2..d9f7dfe2a7ed 100644
> > --- a/arch/arm/mm/proc-macros.S
> > +++ b/arch/arm/mm/proc-macros.S
> > @@ -340,6 +340,7 @@ ENTRY(\name\()_cache_fns)
> >
> >  .macro define_tlb_functions name:req, flags_up:req, flags_smp
> >         .type   \name\()_tlb_fns, #object
> > +       .align 2
> >  ENTRY(\name\()_tlb_fns)
> >         .long   \name\()_flush_user_tlb_range
> >         .long   \name\()_flush_kern_tlb_range
> > --
> > 2.33.0.685.g46640cef36-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
