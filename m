Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785563BA3C1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 19:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhGBRxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 13:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhGBRxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 13:53:12 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410C2C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 10:50:40 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id n14so19488271lfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 10:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zR51Y6h156fP4t9AhpZig8/jxWVXQ+2FTjT81KZ0jSA=;
        b=g49VPuys7EfuGjk1eCwTXbUhJJcFFvyUx8xiIMf7j9ljZsVsOblhEm4eiMsysTdr9M
         6YM4p/q3Zz7OogZTfu6sAcKZ/ecdzJfuncl2Syhg8geFftCt0aixmYwd0FoFFIWiVSRL
         vo65eLuW7s6vQcVTfXrphsislc5+gPSFtU2Zb6mb2Pjq/Z2bgeTjjd7UhODa42hJhSnt
         o4BwnoH0/CoouVK2fX33CK8aHIUQIKtsWJVpHUEXcAGilj2cqSgZNVjUwyauo3GMbY+z
         1hmkx+f6/L6Eb9PZkKuSG2kjI7Aa6qrJa4dPgbSsF1YlPr9fN8G1O7En0Uml3YSUa0Dn
         iqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zR51Y6h156fP4t9AhpZig8/jxWVXQ+2FTjT81KZ0jSA=;
        b=t+LLu3DtWKx43PnhUzG3XQVpzvi7QLlUhpTMSE7flP5alJvQ+vewPrDTcXGlLnutcW
         W0RiyRkRNvPcgKQ/fe/jEBW3ebua9B3sYwEBzNzmdCjiNPfpLjui1lsJB0T4bZypOrGN
         RPEN9oiHX2jYIqzx8cPhVO1VuiVuKkD7/BSsW3B88NWXlmEOng/USlbhgMG8X2AgzsIf
         24ZhbcH+Y0M0KQ+GFRem62UD5VqV/0r9EaOTdSy4uLedFQ5Ahy968rijAoRTj4Ca4tIK
         GWxG6Hdh4jwGZXzzCluEh/nyh/gJqfoFLrmAN2D7xP7FxFs6erTKAO7shHjxD+qI2oOx
         Y4xw==
X-Gm-Message-State: AOAM5303j2vTZnNMEeQTm3mkjZddEUhSDe41l82GnyoRripQEnyfSFbi
        MLdUXUJGrbBLPUfqXKWloN45haEtQLGJSuFow74aBA==
X-Google-Smtp-Source: ABdhPJxxMbAi9u2/TFSgpUvPoJBDz1opPlvi9uxBhDCWirMsLJDYtr4GstO3YNuT/blwBMzwjXWAgaSSrPlAoBR62ec=
X-Received: by 2002:a05:6512:3884:: with SMTP id n4mr577583lft.547.1625248238229;
 Fri, 02 Jul 2021 10:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210701235505.1792711-1-ndesaulniers@google.com> <20210702112210.GA11084@willie-the-truck>
In-Reply-To: <20210702112210.GA11084@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 2 Jul 2021 10:50:27 -0700
Message-ID: <CAKwvOdk4GLDVrOJsxPBVM+g4sBiYW-64M3rNN6hsBgHP0eYqGg@mail.gmail.com>
Subject: Re: [PATCH] arm64: drop CROSS_COMPILE for LLVM=1 LLVM_IAS=1
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 4:22 AM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Jul 01, 2021 at 04:55:05PM -0700, Nick Desaulniers wrote:
> > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > index 7bc37d0a1b68..016873fddcc3 100644
> > --- a/arch/arm64/Makefile
> > +++ b/arch/arm64/Makefile
> > @@ -34,6 +34,17 @@ $(warning LSE atomics not supported by binutils)
> >    endif
> >  endif
> >
> > +ifneq ($(LLVM),)
> > +ifneq ($(LLVM_IAS),)
> > +ifeq ($(CROSS_COMPILE),)
> > +CLANG_TARGET :=--target=aarch64-linux
> > +CLANG_FLAGS  += $(CLANG_TARGET)
> > +KBUILD_CFLAGS        += $(CLANG_TARGET)
> > +KBUILD_AFLAGS        += $(CLANG_TARGET)
>
> Do we need to do anything extra for the linker here? I can't see how we
> avoid picking up the host copy.

That's handled by the top level Makefile when LLVM=1 is set.

There is $KBUILD_LDFLAGS, but we don't do anything with it at the
moment in terms of which linker we select; $LD controls which linker
we use.

LLD can figure out the target based on the object files it's given as
input, so it doesn't need any `--target=` flag. When clang is invoked
as the compiler or assembler, it does need --target.

> Have you tested the compat vDSO with this change? I think we'll just end
> up passing two --target options, which is hopefully ok, but thought I'd
> better check.

Good catch.  We don't reuse KBUILD_CFLAGS or KBUILD_AFLAGS for the
compat vdso for this very reason. In arch/arm64/kernel/vdso32/Makefile
you'll see no references to KBUILD_CFLAGS or KBUILD_AFLAGS; instead we
use VDSO_CFLAGS and VDSO_AFLAGS in their stead.

But, we could (and should) make this same change for the compat vdso,
and drop the need for CROSS_COMPILE_COMPAT for LLVM.

Let me play around with the changes Arnd suggested and see if I can
get that working.  I'm a bit nervous about making this depend on
something from the top level Makefile on initial glance; these changes
start to become tree wide rather than isolated per arch/, but let's
see.  Maybe at that point we carry a series in the kbuild tree with
acks for the arch/ specific changes from the respective maintainers?

Either way, I'll send a v2 that nixes CROSS_COMPILE_COMPAT for LLVM.
-- 
Thanks,
~Nick Desaulniers
