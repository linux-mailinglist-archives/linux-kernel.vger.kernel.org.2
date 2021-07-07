Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0983BF236
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 00:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhGGWrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 18:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhGGWrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 18:47:18 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66328C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 15:44:36 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n14so8569446lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 15:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=AL+sBNTLXrPYA3MvceLjKhPc+A6YHDbfTT0sNYCb8iw=;
        b=XGCMeltM/eIDpVBNIlq4D7Jf70i/U9ZaUZAYBtYlUyhI2KNIMNe33PYWdzqh985beM
         3W1nslTRgrOOHXubQ+GcJyG6pQ0o91R09lVBg7S6DoKmFDPREmUGiOf+BKxuDnggz3uw
         tiWQ0zexPNA34YADBvh/n4SaYGLXiKfB40gCJ9ymfBZl9XBU0dqrbkVSgtFi+kAZkj+Y
         JhBcxjVPZvQociD+3z2wCs7IMl2ItO1/tbG1KeBCRusvQsBRYah/c6KEhWtJ7T+vHbNv
         79enY89bV9xmpX3UMWRwty21Cak+SLppxqjt2xouDOnm+qNl4jbd2SHETjVi0Uyrc/v9
         cvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=AL+sBNTLXrPYA3MvceLjKhPc+A6YHDbfTT0sNYCb8iw=;
        b=Vjv+20xGbz2pxNfSl7/yjGkqtW7f6aTj3oo9oVsgqtwASJsLM/6Gggl2/IkCS8MkLS
         kZT42U+w+Dom/wtfMvmqZt+3g4sTiZj8b9JNVCM617tFCfEFdMXDObJd+EsOM6vyk2Fu
         qmW54UGLvkvZZisHn94Vi9VnMCzNE851i59zgdn2Qq+o0FSv3QgNr+i4eNw2uHFKsNus
         OpO2br+RVrScydQ8BjzOZ9mGDPz+bJJPEf1Z4vNBeE2gbNC1hr7Q4F/sJ/lz/QMpbWoZ
         cLpK02nWTaKGZhPr03h0Oa3UlJvC64wZHD9gnqfV+Svy0bFEcAGptPtzfZYE2V1z4uYz
         2FAA==
X-Gm-Message-State: AOAM531VbHRDyTjUEwFnGHYVOcExklcMFbU1YisLwb9slr/XuZ6ZBbZ3
        j+9Q/ldolJL7Xit3sPsZGWp0aJLqY1YDf5LLDApzQg==
X-Received: by 2002:a05:6512:20cb:: with SMTP id u11mt5852566lfr.73.1625697874486;
 Wed, 07 Jul 2021 15:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210701235505.1792711-1-ndesaulniers@google.com>
 <CAK8P3a1EfBNxaMbsp+s2BiYHGKPK4NeRR+ugM82jfY43Pq7-Uw@mail.gmail.com>
 <CAKwvOdkgEeQktLgEN7CAh7bTjTN+TQNE27aETgvbXep9=xb1DQ@mail.gmail.com>
 <YOEFGcTJC6AWFgs1@Ryzen-9-3900X.localdomain> <CAKwvOdnNWKDGOEqCg5g0GX=zPJce9gBoCLcYs8nayLA7ud2XPQ@mail.gmail.com>
 <546f3d11-8580-7f23-875d-ef856913cb6d@kernel.org>
In-Reply-To: <546f3d11-8580-7f23-875d-ef856913cb6d@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 7 Jul 2021 15:44:23 -0700
Message-ID: <CAKwvOdmCcX4bMXcT1B6OkHABa8QgJwrW5TB3=Yk_2V3OydQKnw@mail.gmail.com>
Subject: Re: [PATCH] arm64: drop CROSS_COMPILE for LLVM=1 LLVM_IAS=1
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 12:08 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On 7/7/2021 12:04 PM, Nick Desaulniers wrote:
> > On Sat, Jul 3, 2021 at 5:47 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >>
> >> On Fri, Jul 02, 2021 at 11:29:31AM -0700, Nick Desaulniers wrote:
> >>> On Fri, Jul 2, 2021 at 4:59 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >>>>
> >>>> On Fri, Jul 2, 2021 at 1:55 AM 'Nick Desaulniers' via Clang Built
> >>>> Linux <clang-built-linux@googlegroups.com> wrote:
> >>>>>
> >>>>> +ifneq ($(LLVM),)
> >>>>> +ifneq ($(LLVM_IAS),)
> >>>>> +ifeq ($(CROSS_COMPILE),)
> >>>>> +CLANG_TARGET   :=--target=aarch64-linux
> >>>>> +CLANG_FLAGS    += $(CLANG_TARGET)
> >>>>> +KBUILD_CFLAGS  += $(CLANG_TARGET)
> >>>>> +KBUILD_AFLAGS  += $(CLANG_TARGET)
> >>>>> +endif
> >>>>> +endif
> >>>>> +endif
> >>>>
> >>>> I think only the "CLANG_TARGET   :=--target=aarch64-linux" line should
> >>>> go into the
> >>>> per-architecture Makefile. It doesn't hurt to just set that
> >>>> unconditionally here,
> >>>> and then change the CLANG_FLAGS logic in the top-level Makefile to use this
> >>>> in place of $(notdir $(CROSS_COMPILE:%-=%)).
> >>>
> >>> I don't think we can do that. Based on the order the arch/ specific
> >>> Makefiles are included, if we don't eagerly add --target to the
> >>> KBUILD_{C|A}FLAGS, then cc-option, as-option, and as-instr macros
> >>> (defined in scripts/Makefile.compiler) checks in per arch/ Makefiles
> >>> may fail erroneously because --target was not set for
> >>> KBUILD_{C|A}FLAGS yet.
> >>>
> >>> Another issue is the order of operations between the top level
> >>> Makefile and the per arch/ Makefiles.  The `notdir` block you
> >>> reference occurs earlier than the per-arch includes:
> >>>
> >>>   609 TENTATIVE_CLANG_FLAGS += --target=$(notdir $(CROSS_COMPILE:%-=%))
> >>> ...
> >>>   648 include $(srctree)/arch/$(SRCARCH)/Makefile
> >>>
> >>> We would need the opposite order to do what you describe. Reordering
> >>> these would effectively be a revert of
> >>> commit ae6b289a3789 ("kbuild: Set KBUILD_CFLAGS before incl. arch Makefile")
> >>> which I'm not sure we want to do.  But maybe there's another way I'm
> >>> not seeing yet?
> >>
> >> Is there any reason we cannot just add this sort of logic to the main
> >> Makefile?
> >>
> >> Such as (indentation to emphasis diff):
> >>
> >> ifeq ($(CROSS_COMPILE),)
> >> ifneq ($(LLVM),)
> >> ifeq ($(LLVM_IAS),1)
> >>          ifeq ($(ARCH),arm64)
> >>                  TENTATIVE_CLANG_FLAGS   += --target=aarch64-linux
> >>          else ifeq ($(ARCH),s390)
> >>                  TENTATIVE_CLANG_FLAGS   += --target=s390x-linux
> >>          else ifeq ($(ARCH),x86_64)
> >>                  TENTATIVE_CLANG_FLAGS   += --target=x86_64-linux
> >>          else
> >>                  $(error Specify CROSS_COMPILE or add '--target=' option to Makefile)
> >>          endif
> >> endif
> >> endif
> >> else
> >> TENTATIVE_CLANG_FLAGS   += --target=$(notdir $(CROSS_COMPILE:%-=%))
> >> ifeq ($(LLVM_IAS),1)
> >> TENTATIVE_CLANG_FLAGS   += -integrated-as
> >> else
> >> TENTATIVE_CLANG_FLAGS   += -no-integrated-as
> >> GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
> >> TENTATIVE_CLANG_FLAGS   += --prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
> >> endif
> >> endif
> >>
> >> I know this looks a little cumbersome but it does help us avoid
> >> duplication across architecture Makefiles and ordering dependencies.
> >
> > Yeah, ok.
> >
> > I like the use of `include` to compartmentalize the top level Makefile
> > further.  We can move this whole block of LLVM related flag handling
> > into something under scripts, then add this block and it doesn't look
> > too bad IMO.  Masahiro, are you ok with that?  If so, I'd break this
> > into 2 patches:
> > 1. moving this block of existing code into a new file.
> > 2. adding the CROSS_COMPILE functionality.
> >
> > See https://groups.google.com/g/clang-built-linux/c/s-voh6WQFxM for
> > the gist of what I was thinking (though not broken into 2 patches yet,
> > just testing that it works; it does).
>
> Yeah, I think that looks okay. Not sure how I feel about the name since
> it is handling more than just the target triple but that is a bikeshed
> for another time :)
>
> > This approach will collide with Miguel's series in -next.  Should I
> > base the patches on mainline, or linux-kbuild, then have Miguel rebase
> > his patches on that or what?
>
> Yes, the patches should be based on mainline or linux-kbuild then Miguel
> will have to solve the conflicts and let Stephen Rothwell know about
> them so that -next keeps working.

Folks can find the new thread for v1:
https://lore.kernel.org/lkml/20210707224310.1403944-1-ndesaulniers@google.com/
if interested.

-- 
Thanks,
~Nick Desaulniers
