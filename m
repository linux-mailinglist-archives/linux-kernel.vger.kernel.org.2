Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7512D3BAAC0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 02:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhGDAuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 20:50:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhGDAt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 20:49:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4AF5615A0;
        Sun,  4 Jul 2021 00:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625359644;
        bh=tNmU3/BJSe1WKBQAIawduNDOsi8ptZPl+E8CPIdtgSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=htslqKoGRK2dOOFeN/2PafvZxs3xFi8BsMEDmetFYgTBmZfI/eyxrDt+FV/8tX+W/
         1ZTHSJYJHSCV7wmoNAkqCorxrXi+7vGH9pOVI2I7+rofWgPTEVjz1jvJlh1Yv6jzv8
         HRNZ47r5qERvu5kYNpd2HW0kB+xjZ+WkWmh654TpdqaNWb/EYL3sYwcytx3LJKms2U
         gJw4yAoMT3HeT3BmkQQp4GeRWbi7HkSZ7Eo5sUJrVPffQmg8cbYt+lwXDMC2Estjdu
         h2fC7K7IBvgnruYBbre5SWF5HHo/PoVsJaK3pyXTYmKpL1Jyf7SNLxWRr4sOl5/rWQ
         uUOvy6FNsnrqA==
Date:   Sat, 3 Jul 2021 17:47:21 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] arm64: drop CROSS_COMPILE for LLVM=1 LLVM_IAS=1
Message-ID: <YOEFGcTJC6AWFgs1@Ryzen-9-3900X.localdomain>
References: <20210701235505.1792711-1-ndesaulniers@google.com>
 <CAK8P3a1EfBNxaMbsp+s2BiYHGKPK4NeRR+ugM82jfY43Pq7-Uw@mail.gmail.com>
 <CAKwvOdkgEeQktLgEN7CAh7bTjTN+TQNE27aETgvbXep9=xb1DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkgEeQktLgEN7CAh7bTjTN+TQNE27aETgvbXep9=xb1DQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 11:29:31AM -0700, Nick Desaulniers wrote:
> On Fri, Jul 2, 2021 at 4:59 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Fri, Jul 2, 2021 at 1:55 AM 'Nick Desaulniers' via Clang Built
> > Linux <clang-built-linux@googlegroups.com> wrote:
> > >
> > > +ifneq ($(LLVM),)
> > > +ifneq ($(LLVM_IAS),)
> > > +ifeq ($(CROSS_COMPILE),)
> > > +CLANG_TARGET   :=--target=aarch64-linux
> > > +CLANG_FLAGS    += $(CLANG_TARGET)
> > > +KBUILD_CFLAGS  += $(CLANG_TARGET)
> > > +KBUILD_AFLAGS  += $(CLANG_TARGET)
> > > +endif
> > > +endif
> > > +endif
> >
> > I think only the "CLANG_TARGET   :=--target=aarch64-linux" line should
> > go into the
> > per-architecture Makefile. It doesn't hurt to just set that
> > unconditionally here,
> > and then change the CLANG_FLAGS logic in the top-level Makefile to use this
> > in place of $(notdir $(CROSS_COMPILE:%-=%)).
> 
> I don't think we can do that. Based on the order the arch/ specific
> Makefiles are included, if we don't eagerly add --target to the
> KBUILD_{C|A}FLAGS, then cc-option, as-option, and as-instr macros
> (defined in scripts/Makefile.compiler) checks in per arch/ Makefiles
> may fail erroneously because --target was not set for
> KBUILD_{C|A}FLAGS yet.
> 
> Another issue is the order of operations between the top level
> Makefile and the per arch/ Makefiles.  The `notdir` block you
> reference occurs earlier than the per-arch includes:
> 
>  609 TENTATIVE_CLANG_FLAGS += --target=$(notdir $(CROSS_COMPILE:%-=%))
> ...
>  648 include $(srctree)/arch/$(SRCARCH)/Makefile
> 
> We would need the opposite order to do what you describe. Reordering
> these would effectively be a revert of
> commit ae6b289a3789 ("kbuild: Set KBUILD_CFLAGS before incl. arch Makefile")
> which I'm not sure we want to do.  But maybe there's another way I'm
> not seeing yet?

Is there any reason we cannot just add this sort of logic to the main
Makefile?

Such as (indentation to emphasis diff):

ifeq ($(CROSS_COMPILE),)
ifneq ($(LLVM),)
ifeq ($(LLVM_IAS),1)
	ifeq ($(ARCH),arm64)
		TENTATIVE_CLANG_FLAGS	+= --target=aarch64-linux
	else ifeq ($(ARCH),s390)
		TENTATIVE_CLANG_FLAGS	+= --target=s390x-linux
	else ifeq ($(ARCH),x86_64)
		TENTATIVE_CLANG_FLAGS	+= --target=x86_64-linux
	else
		$(error Specify CROSS_COMPILE or add '--target=' option to Makefile)
	endif
endif
endif
else
TENTATIVE_CLANG_FLAGS	+= --target=$(notdir $(CROSS_COMPILE:%-=%))
ifeq ($(LLVM_IAS),1)
TENTATIVE_CLANG_FLAGS	+= -integrated-as
else
TENTATIVE_CLANG_FLAGS	+= -no-integrated-as
GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
TENTATIVE_CLANG_FLAGS	+= --prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
endif
endif

I know this looks a little cumbersome but it does help us avoid
duplication across architecture Makefiles and ordering dependencies.

Cheers,
Nathan
