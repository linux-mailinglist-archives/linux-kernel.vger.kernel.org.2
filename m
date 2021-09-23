Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14480416198
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241859AbhIWPBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241807AbhIWPBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:01:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F03A60FC1;
        Thu, 23 Sep 2021 14:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632409192;
        bh=88u0FgUHUX8cPCvfv9jW9Rt/RzvchoT0U9GwNmj1jp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NHICIs3caYFBGM/yfGprZHt5bU45CHP3ScZk049PBlmwAd5Q5IIln5NPt+Zl2cFaN
         t7pMrCVnMm0s3LTkguNrIFsd5B35xXV0XanI1ekaqke5c7G+8Fg0nehoUk3sFDa2ts
         vTLW++ZKgsxxZlTKATzwbAIdSsgm7Y78T46jqSHwVa61MLEN0V+izmBDyS+w15rD1X
         yBgT17HMxKSnDtxpiosBOigF+SeZTw6QrefWwORlh8NRzmDepfpPaH/2R7THC28qgt
         bkDtLGVqJmuKFjYYnV7ZcFY+pe3rrCwmIuMZ85q9+shGYKu9e6A3hlAK+rlGAQCWQH
         f8ouRLX560bIw==
Date:   Thu, 23 Sep 2021 07:59:46 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-mm@kvack.org
Subject: Re: [PATCH] kasan: Always respect CONFIG_KASAN_STACK
Message-ID: <YUyWYpDl2Dmegz0a@archlinux-ax161>
References: <20210922205525.570068-1-nathan@kernel.org>
 <CANpmjNNqgUSbiPHOpD8z5JAv2aiujxAMiO4siymYdU6zpid_2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNqgUSbiPHOpD8z5JAv2aiujxAMiO4siymYdU6zpid_2g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 12:07:17PM +0200, Marco Elver wrote:
> On Wed, 22 Sept 2021 at 22:55, Nathan Chancellor <nathan@kernel.org> wrote:
> > Currently, the asan-stack parameter is only passed along if
> > CFLAGS_KASAN_SHADOW is not empty, which requires KASAN_SHADOW_OFFSET to
> > be defined in Kconfig so that the value can be checked. In RISC-V's
> > case, KASAN_SHADOW_OFFSET is not defined in Kconfig, which means that
> > asan-stack does not get disabled with clang even when CONFIG_KASAN_STACK
> > is disabled, resulting in large stack warnings with allmodconfig:
> >
> > drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c:117:12:
> > error: stack frame size (14400) exceeds limit (2048) in function
> > 'lb035q02_connect' [-Werror,-Wframe-larger-than]
> > static int lb035q02_connect(struct omap_dss_device *dssdev)
> >            ^
> > 1 error generated.
> >
> > Ensure that the value of CONFIG_KASAN_STACK is always passed along to
> > the compiler so that these warnings do not happen when
> > CONFIG_KASAN_STACK is disabled.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1453
> > References: 6baec880d7a5 ("kasan: turn off asan-stack for clang-8 and earlier")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> Reviewed-by: Marco Elver <elver@google.com>

Thanks!

> [ Which tree are you planning to take it through? ]

Gah, I was intending for it to go through -mm, then I cc'd neither
Andrew nor linux-mm... :/ Andrew, do you want me to resend or can you
grab it from LKML?

> Note, arch/riscv/include/asm/kasan.h mentions KASAN_SHADOW_OFFSET in
> comment (copied from arm64). Did RISC-V just forget to copy over the
> Kconfig option?

I do see it defined in that file as well but you are right that they did
not copy the Kconfig logic, even though it was present in the tree when
RISC-V KASAN was implemented. Perhaps they should so that they get
access to the other flags in the "else" branch?

> > ---
> >  scripts/Makefile.kasan | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> > index 801c415bac59..b9e94c5e7097 100644
> > --- a/scripts/Makefile.kasan
> > +++ b/scripts/Makefile.kasan
> > @@ -33,10 +33,11 @@ else
> >         CFLAGS_KASAN := $(CFLAGS_KASAN_SHADOW) \
> >          $(call cc-param,asan-globals=1) \
> >          $(call cc-param,asan-instrumentation-with-call-threshold=$(call_threshold)) \
> > -        $(call cc-param,asan-stack=$(stack_enable)) \
> >          $(call cc-param,asan-instrument-allocas=1)
> >  endif
> >
> > +CFLAGS_KASAN += $(call cc-param,asan-stack=$(stack_enable))
> > +
> >  endif # CONFIG_KASAN_GENERIC
> >
> >  ifdef CONFIG_KASAN_SW_TAGS
> >
> > base-commit: 4057525736b159bd456732d11270af2cc49ec21f
> > --
> > 2.33.0.514.g99c99ed825
> >
> >
