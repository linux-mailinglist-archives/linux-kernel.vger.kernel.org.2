Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8C43BF003
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 21:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhGGTHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 15:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhGGTG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 15:06:59 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D07DC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 12:04:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r26so6776094lfp.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 12:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/sINFkidd4wbdannETMgW4bElM0CKhLWIVOtap5WLM=;
        b=SORU3JdYg0sCHUPztl5Sml1zZLI4bEsIExEkumwT+4AQKUur+pkRMK1BnvW1ONXbtZ
         0JzEmU1KTlaFatTgJ2vPGUxRkVucKmsp/J2D4T/ZZSpSg8TH0kb6bVZpH1hdU3BCe4XC
         5ojVf2YiAaP69x0d8mlP1aCaCc74oxVkaFMQgc0SAoUVhqoOG1IAeVtKYkAcU8p5JKM2
         4McElwBzpbXd6Hlmcnzk5MO7+3quCv+izlM/4M4qiPG8lGW6wgnzbtYPxp/d8cRBevUv
         pQPxZqg524zAEYBuw+P2u1/ew3cyz89dSbil2YS3V6u0ZUBnZWw1bHWSqcbHJHdaVygb
         CfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/sINFkidd4wbdannETMgW4bElM0CKhLWIVOtap5WLM=;
        b=ntUo/qqxFm/rK7NoN8gLaSL45vFfiCe3Be0/1yraL/xYKJ3agiMzTZALq09t6mDMF7
         uIJIrzbpsA67OQquJ0jvYDPE2Fvbtr5VWNeUNOSb1Ec2McT0GD9OoKdbIVSqQOcgjeHX
         ACnDIupGVHGPEninRE+sUg0EKe5RnWVagjIMB/JQIl3ze5Hvttz2UJJl4TlV3PGrw988
         DLYvNSR/qX6S7TCT7hcD+icIR469VQ2fo3dXwkcNrG7zW5jxK5G6sGtNmPQJmOHPULhQ
         3VyrWCxkbVVerJ8kX1T7OFnqXcWDHKngRV/bOQKMPkTX+l+iCg0ZgV9+35xHo5RruM9M
         nJbA==
X-Gm-Message-State: AOAM5306RroOhf2nSEooLBGkNNpP/k5a4CwyF23PLJohVkkgB8xbHBVy
        ZXByxUvJINSMaAAZ8G1A8K+jn8PGMvjlyL/X+THpSA==
X-Google-Smtp-Source: ABdhPJwj8v/8k4dMJbEgclPT/e1K0md1TTfEAQogXLRbuui63uNa2Vfq2tb92w4GYHM9APLPcHe15RYkcfDfDYGcUKg=
X-Received: by 2002:a2e:b5b5:: with SMTP id f21mr20457637ljn.479.1625684656197;
 Wed, 07 Jul 2021 12:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210701235505.1792711-1-ndesaulniers@google.com>
 <CAK8P3a1EfBNxaMbsp+s2BiYHGKPK4NeRR+ugM82jfY43Pq7-Uw@mail.gmail.com>
 <CAKwvOdkgEeQktLgEN7CAh7bTjTN+TQNE27aETgvbXep9=xb1DQ@mail.gmail.com> <YOEFGcTJC6AWFgs1@Ryzen-9-3900X.localdomain>
In-Reply-To: <YOEFGcTJC6AWFgs1@Ryzen-9-3900X.localdomain>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 7 Jul 2021 12:04:04 -0700
Message-ID: <CAKwvOdnNWKDGOEqCg5g0GX=zPJce9gBoCLcYs8nayLA7ud2XPQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: drop CROSS_COMPILE for LLVM=1 LLVM_IAS=1
To:     Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 3, 2021 at 5:47 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Fri, Jul 02, 2021 at 11:29:31AM -0700, Nick Desaulniers wrote:
> > On Fri, Jul 2, 2021 at 4:59 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > On Fri, Jul 2, 2021 at 1:55 AM 'Nick Desaulniers' via Clang Built
> > > Linux <clang-built-linux@googlegroups.com> wrote:
> > > >
> > > > +ifneq ($(LLVM),)
> > > > +ifneq ($(LLVM_IAS),)
> > > > +ifeq ($(CROSS_COMPILE),)
> > > > +CLANG_TARGET   :=--target=aarch64-linux
> > > > +CLANG_FLAGS    += $(CLANG_TARGET)
> > > > +KBUILD_CFLAGS  += $(CLANG_TARGET)
> > > > +KBUILD_AFLAGS  += $(CLANG_TARGET)
> > > > +endif
> > > > +endif
> > > > +endif
> > >
> > > I think only the "CLANG_TARGET   :=--target=aarch64-linux" line should
> > > go into the
> > > per-architecture Makefile. It doesn't hurt to just set that
> > > unconditionally here,
> > > and then change the CLANG_FLAGS logic in the top-level Makefile to use this
> > > in place of $(notdir $(CROSS_COMPILE:%-=%)).
> >
> > I don't think we can do that. Based on the order the arch/ specific
> > Makefiles are included, if we don't eagerly add --target to the
> > KBUILD_{C|A}FLAGS, then cc-option, as-option, and as-instr macros
> > (defined in scripts/Makefile.compiler) checks in per arch/ Makefiles
> > may fail erroneously because --target was not set for
> > KBUILD_{C|A}FLAGS yet.
> >
> > Another issue is the order of operations between the top level
> > Makefile and the per arch/ Makefiles.  The `notdir` block you
> > reference occurs earlier than the per-arch includes:
> >
> >  609 TENTATIVE_CLANG_FLAGS += --target=$(notdir $(CROSS_COMPILE:%-=%))
> > ...
> >  648 include $(srctree)/arch/$(SRCARCH)/Makefile
> >
> > We would need the opposite order to do what you describe. Reordering
> > these would effectively be a revert of
> > commit ae6b289a3789 ("kbuild: Set KBUILD_CFLAGS before incl. arch Makefile")
> > which I'm not sure we want to do.  But maybe there's another way I'm
> > not seeing yet?
>
> Is there any reason we cannot just add this sort of logic to the main
> Makefile?
>
> Such as (indentation to emphasis diff):
>
> ifeq ($(CROSS_COMPILE),)
> ifneq ($(LLVM),)
> ifeq ($(LLVM_IAS),1)
>         ifeq ($(ARCH),arm64)
>                 TENTATIVE_CLANG_FLAGS   += --target=aarch64-linux
>         else ifeq ($(ARCH),s390)
>                 TENTATIVE_CLANG_FLAGS   += --target=s390x-linux
>         else ifeq ($(ARCH),x86_64)
>                 TENTATIVE_CLANG_FLAGS   += --target=x86_64-linux
>         else
>                 $(error Specify CROSS_COMPILE or add '--target=' option to Makefile)
>         endif
> endif
> endif
> else
> TENTATIVE_CLANG_FLAGS   += --target=$(notdir $(CROSS_COMPILE:%-=%))
> ifeq ($(LLVM_IAS),1)
> TENTATIVE_CLANG_FLAGS   += -integrated-as
> else
> TENTATIVE_CLANG_FLAGS   += -no-integrated-as
> GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
> TENTATIVE_CLANG_FLAGS   += --prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
> endif
> endif
>
> I know this looks a little cumbersome but it does help us avoid
> duplication across architecture Makefiles and ordering dependencies.

Yeah, ok.

I like the use of `include` to compartmentalize the top level Makefile
further.  We can move this whole block of LLVM related flag handling
into something under scripts, then add this block and it doesn't look
too bad IMO.  Masahiro, are you ok with that?  If so, I'd break this
into 2 patches:
1. moving this block of existing code into a new file.
2. adding the CROSS_COMPILE functionality.

See https://groups.google.com/g/clang-built-linux/c/s-voh6WQFxM for
the gist of what I was thinking (though not broken into 2 patches yet,
just testing that it works; it does).

This approach will collide with Miguel's series in -next.  Should I
base the patches on mainline, or linux-kbuild, then have Miguel rebase
his patches on that or what?
-- 
Thanks,
~Nick Desaulniers
