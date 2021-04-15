Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2208361073
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbhDOQwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 12:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbhDOQww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:52:52 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62422C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:52:28 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u20so27842115lja.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U37DmZ+J3T6SaAA0HXrJNqq/8z5wrCoZ7qw6igvtpHg=;
        b=o0LZ7oRTf0bmGgDrCymXA3Les/i63Ka5ogz7o1R1QfOxWJbRt8gkDAK9714JEu1rLU
         07mzVIPZ37KqJOzpjXbGgjsok/9XGmeInZdGGnxAo7EowibqCjFPzQZkBkr9nfEso++4
         A2sh15q4Q/k/dBUGA5hvzKkd1t/ZyMtHbD8xd6XgC2UzMAPuPCzuv3QKg5CC0q1OGaZH
         NvMyJD2+w3mArpciv55SzvVhBakchRZf9FXWbXEmN2AVV+qulegnay8nTIa/5Us6TD76
         hLSfjwbUpowtjmcLXjJflvhz0AgaDp+rx4NggJljseocLt2+ZHL+CBfd/C3eSip1/Flx
         toHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U37DmZ+J3T6SaAA0HXrJNqq/8z5wrCoZ7qw6igvtpHg=;
        b=a/vTJf2c2l1Vafm96A8Cdm1Yjd8BFKwgnsnNUIu/noCsc3+mgQiMz0hSYU2ERmpfrZ
         8Uf16QNEmM5ZUs0cpfDkyg3puAljvh4fMeFNFGpNGX4gFWiZhTdbkpDASFIHHFXAAJQx
         yIJ/+qwT3uOmRxtMqikF4uE+SqWB5fn5+XsW/HEkl2tscTxH2iTEfxxbElzQffYo2819
         W9k6NT8+m8R60eS0dQVET/B8k0+BhtHb3PNVZgcWsgNNM587gviFosVa7lffU6/6PuFU
         9J6CpVEzsTmDvJeptHRrUEMFaDCQ40+MddH56fuCfSqn2QjWKF+ivI+gW7zHkQXrMzvt
         GI7g==
X-Gm-Message-State: AOAM532q4PUH1lijvObyXADYVYvwI0XQqewDAPTShtfV18ao9Yo1hv7h
        ARrwk0AW/r1PlyHOT6rGCD1vNmsyzoyUS2kaO7e1Ag==
X-Google-Smtp-Source: ABdhPJzznbQyUFRW/iVVZ9tQXDX6RP0t8cOuOqshRtcMUWyAbg9L0s31GZVOrqcXe8nEpgBZGTl2/NZNUByE9ogevGE=
X-Received: by 2002:a2e:988a:: with SMTP id b10mr57627ljj.341.1618505546655;
 Thu, 15 Apr 2021 09:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <YHYlQnFRMNdn/CDp@archlinux-ax161> <20210414214548.700993-1-ndesaulniers@google.com>
 <a2ddf4d2-110a-9290-f766-3925e451ddef@arm.com>
In-Reply-To: <a2ddf4d2-110a-9290-f766-3925e451ddef@arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 15 Apr 2021 09:52:14 -0700
Message-ID: <CAKwvOdms0SVJMMLOwK-w=fzsw1FmCSK9qjZ_Syq0A-kRzYkHLQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: vdso32: drop -no-integrated-as flag
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 6:31 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
>
>
> On 4/14/21 10:45 PM, Nick Desaulniers wrote:
> > Clang can assemble these files just fine; this is a relic from the top
> > level Makefile conditionally adding this. We no longer need --prefix,
> > --gcc-toolchain, or -Qunused-arguments flags either with this change, so
> > remove those too.
> >
> > To test building:
> > $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
> >   CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 LLVM_IAS=1 \
> >   defconfig arch/arm64/kernel/vdso32/
> >
> > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> The patch looks fine, but I have one question: the kernel requires as a minimum
> Clang/LLVM version 10.0.1. Did you verify that with that version compat vDSOs
> still builds and works correctly?

Hi Vincenzo,
Great question, let's check.
$ cd path/to/llvm-project
$ git checkout origin/release/10.x
$ cd llvm/build && ninja
$ cd path/to/linux
$ b4 am https://lore.kernel.org/lkml/20210413230609.3114365-1-ndesaulniers@google.com/
-o - | git am -3

We can't generally build ARCH=arm64 defconfig with LLVM_IAS=1 with
clang-10, but dropping LLVM_IAS=1 it looks like we can still build
without that.

$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 -j72 defconfig
clean all
$ ls -l arch/arm64/kernel/vdso32
total 116
-rw-r----- 1 ndesaulniers primarygroup  7534 Apr 14 14:41 Makefile
-rw-r----- 1 ndesaulniers primarygroup   387 Mar 31 10:47 note.c
-rw-r----- 1 ndesaulniers primarygroup  2544 Apr 15 09:48 note.o
-rw-r----- 1 ndesaulniers primarygroup  4552 Apr 15 09:48 vdso.lds
-rw-r----- 1 ndesaulniers primarygroup  1587 Apr  1 12:55 vdso.lds.S
-rw------- 1 ndesaulniers primarygroup  3576 Apr 15 09:48 vdso.so
-rw------- 1 ndesaulniers primarygroup 24380 Apr 15 09:48 vdso.so.dbg
-rwxr-x--- 1 ndesaulniers primarygroup 24380 Apr 15 09:48 vdso.so.raw
-rw-r----- 1 ndesaulniers primarygroup   828 Apr  1 12:55 vgettimeofday.c
-rw-r----- 1 ndesaulniers primarygroup 29084 Apr 15 09:48 vgettimeofday.o

FWIW, clang-10 was missing support for R_AARCH64_PREL32, which affects
building arch/arm64/kvm/hyp/nvhe/hyp-reloc.S.

>
> Otherwise:
>
> Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> > ---
> > Changes V1 -> V2:
> > * Remove --prefix, --gcc-toolchain, COMPAT_GCC_TOOLCHAIN, and
> >   COMPAT_GCC_TOOLCHAIN_DIR as per Nathan.
> > * Credit Nathan with Suggested-by tag.
> > * Remove -Qunused-arguments.
> > * Update commit message.
> >
> >  arch/arm64/kernel/vdso32/Makefile | 8 --------
> >  1 file changed, 8 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> > index 789ad420f16b..3dba0c4f8f42 100644
> > --- a/arch/arm64/kernel/vdso32/Makefile
> > +++ b/arch/arm64/kernel/vdso32/Makefile
> > @@ -10,15 +10,7 @@ include $(srctree)/lib/vdso/Makefile
> >
> >  # Same as cc-*option, but using CC_COMPAT instead of CC
> >  ifeq ($(CONFIG_CC_IS_CLANG), y)
> > -COMPAT_GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE_COMPAT)elfedit))
> > -COMPAT_GCC_TOOLCHAIN := $(realpath $(COMPAT_GCC_TOOLCHAIN_DIR)/..)
> > -
> >  CC_COMPAT_CLANG_FLAGS := --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
> > -CC_COMPAT_CLANG_FLAGS += --prefix=$(COMPAT_GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE_COMPAT))
> > -CC_COMPAT_CLANG_FLAGS += -no-integrated-as -Qunused-arguments
> > -ifneq ($(COMPAT_GCC_TOOLCHAIN),)
> > -CC_COMPAT_CLANG_FLAGS += --gcc-toolchain=$(COMPAT_GCC_TOOLCHAIN)
> > -endif
> >
> >  CC_COMPAT ?= $(CC)
> >  CC_COMPAT += $(CC_COMPAT_CLANG_FLAGS)
> >
>
> --
> Regards,
> Vincenzo



-- 
Thanks,
~Nick Desaulniers
