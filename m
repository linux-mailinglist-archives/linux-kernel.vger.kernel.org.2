Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF65D378EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbhEJNbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:31:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241818AbhEJN22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:28:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7376D6147D
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 13:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620653243;
        bh=rAIhN2kmOvlnwW/jbV0c5jtC6Hz4noTOqD76ZgYWfyY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rVa43gZz5ACpqot6bVMWZDrDaWrKGhatLuA3GNkwUBW4Rh1PRFzV3buZzexyrfwId
         FJFVn9RznOYtD5kOtJF6HNFDelqPRHeUcHoXZF8WphFdiWReJcmaMAE2l1Gkjwr3vv
         UHB/SxDP7j1oDqXWmxMWEc8UK5W2sebRSuVLuhqu193YpoP6o8Uf+KrBS/2+CRNpgK
         jT+aqRToT5eFyXRANfpvgbfpEmE7Q4JMyEbbfwsVEarD26Cs53bxpJu48v3vBA934V
         t4mk2LUmr60+zGsbZYGnGsPkR6Ujtb+9rp+ZGYJM7qvzaDKHdZB037CgJIgzuxlX22
         MJHweK6dcRv8A==
Received: by mail-lj1-f170.google.com with SMTP id w15so20772237ljo.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:27:23 -0700 (PDT)
X-Gm-Message-State: AOAM531NhyXVV9FncH+cy3K0kbxb65uXIJK5C+DU1IXxzSZgkhq5kMGP
        xWYyEzHimVBUZHFyn561SsjfRJyLqNQfzSlTZCo=
X-Google-Smtp-Source: ABdhPJwZqLbGYUhhgAIjKp/ai9boa189gjv9mt7B36g6gRBvTC7hYDq1WTOAnR6YavZjPZYhBBI85YbZHtIpJXoWtHA=
X-Received: by 2002:a05:651c:1307:: with SMTP id u7mr19838234lja.498.1620653241673;
 Mon, 10 May 2021 06:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210510093753.40683-1-mark.rutland@arm.com> <20210510093753.40683-17-mark.rutland@arm.com>
In-Reply-To: <20210510093753.40683-17-mark.rutland@arm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 10 May 2021 21:27:10 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSwzb9rOvuubgz0PNeweOVQ_94mqDXyTfdprVZDcEp+FA@mail.gmail.com>
Message-ID: <CAJF2gTSwzb9rOvuubgz0PNeweOVQ_94mqDXyTfdprVZDcEp+FA@mail.gmail.com>
Subject: Re: [PATCH 16/33] locking/atomic: csky: move to ARCH_ATOMIC
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, boqun.feng@gmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Brian Cain <bcain@codeaurora.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Zankel <chris@zankel.net>, Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Henderson <rth@twiddle.net>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 5:41 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> We'd like all architectures to convert to ARCH_ATOMIC, as once all
> architectures are converted it will be possible to make significant
> cleanups to the atomics headers, and this will make it much easier to
> generically enable atomic functionality (e.g. debug logic in the
> instrumented wrappers).
>
> As a step towards that, this patch migrates csky to ARCH_ATOMIC. The
> arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
> code wraps these with optional instrumentation to provide the regular
> functions.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/csky/Kconfig               | 1 +
>  arch/csky/include/asm/cmpxchg.h | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 8de5b987edb9..3521f14bcd96 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -2,6 +2,7 @@
>  config CSKY
>         def_bool y
>         select ARCH_32BIT_OFF_T
> +       select ARCH_ATOMIC
>         select ARCH_HAS_DMA_PREP_COHERENT
>         select ARCH_HAS_GCOV_PROFILE_ALL
>         select ARCH_HAS_SYNC_DMA_FOR_CPU
> diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
> index dabc8e46ce7b..d1bef11f8dc9 100644
> --- a/arch/csky/include/asm/cmpxchg.h
> +++ b/arch/csky/include/asm/cmpxchg.h
> @@ -31,7 +31,7 @@ extern void __bad_xchg(void);
>         __ret;                                                  \
>  })
>
> -#define xchg_relaxed(ptr, x) \
> +#define arch_xchg_relaxed(ptr, x) \
>                 (__xchg_relaxed((x), (ptr), sizeof(*(ptr))))
>
>  #define __cmpxchg_relaxed(ptr, old, new, size)                 \
> @@ -61,14 +61,14 @@ extern void __bad_xchg(void);
>         __ret;                                                  \
>  })
>
> -#define cmpxchg_relaxed(ptr, o, n) \
> +#define arch_cmpxchg_relaxed(ptr, o, n) \
>         (__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
>
> -#define cmpxchg(ptr, o, n)                                     \
> +#define arch_cmpxchg(ptr, o, n)                                \
>  ({                                                             \
>         __typeof__(*(ptr)) __ret;                               \
>         __smp_release_fence();                                  \
> -       __ret = cmpxchg_relaxed(ptr, o, n);                     \
> +       __ret = arch_cmpxchg_relaxed(ptr, o, n);                \
>         __smp_acquire_fence();                                  \
>         __ret;                                                  \
>  })
> --
> 2.11.0
>
Acked-by: Guo Ren <guoren@kernel.org>

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
