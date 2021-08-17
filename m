Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D96E3EF1C3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhHQSXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbhHQSXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:23:13 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA364C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:22:39 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id n6so242868ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHXsbwlr2q769RcSioIqWqNf/dDckOAdNnjL858Y61M=;
        b=BlD5xxFtICFapjAHQcstmJGbiTZsguL0mH7GZWbDcbspHlqjE1vBt3I+YWJ3qJ2s3I
         wUKPj5aDkmiK1Ens3kyO+ZelMEzll29qiV+xIoNQX4fxyMiKgiNyBw4HWPYgBhbe/fry
         2AdKJee/cCHbtU2q/vgmicMliVqyhzNX5CJj+OzHIK4LQ4jF9wNuJ6Yi7zlunSW3bSKK
         qsjnIHpXhyPYsgehyWNx6AOB0UwqEUapsIO8jhgL10Gfu/LGl9gWKfOFcFH3MngyVI2A
         hBC4m77fdw7ArbEo+EgQ3KDjqV/YaWDlERLS3a5VwrTiKDsX0dgFRh31Vzpo2lwXDNH8
         Paew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHXsbwlr2q769RcSioIqWqNf/dDckOAdNnjL858Y61M=;
        b=Ih1aYc42kCK5AgMvzuYVZ6MDBMlSGY6fSwEm7H17OzJyXYZIQiEeslcnuQDf6HUrjp
         MWcio3p6HI9a/coau/8S+AhxNgVoLOcBoytWS68C++BeN3bWIBOfP1EEoAFOVn0cXnCU
         85/LA0hkmheC57aSFIdC5BovnTpa1nL5H/iJQICNdTbouB85D5THtwkUzxRwb5rJ0/mJ
         /5y9iZURyQY6m4k0N2HtzRplpqe1ima+CktYkG2GkHGv+pSisaVdkuA+6h1RbMERxeED
         P9E6DoPN+M3msb0O9db6L+kqfKNoVTM0vKzt5Ah2TIOPqNble9VJdjo9+5OzZSUsbO6y
         V83g==
X-Gm-Message-State: AOAM533ozL1yjeatnSUjF2BnWQViKZfUJYIEF36t47jJDd4nvPbnLJWG
        iQVU76h8ikZb6Kb18FpzgXXGcu11KkM2xcPYml9Mi2/Pl7Dj7ULC
X-Google-Smtp-Source: ABdhPJyrCQABEpPNxGrS/anDK2BIfQ6lEMVrMW3IK5f/iF14lbFV7IFwQcW67A0Ybx2xUSvUExbIBjpqm1QzAv4gruE=
X-Received: by 2002:a2e:a784:: with SMTP id c4mr4469069ljf.479.1629224557771;
 Tue, 17 Aug 2021 11:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <269701460.117528.1629210189833@office.mailbox.org>
 <796036867.117557.1629210288168@office.mailbox.org> <CAKwvOdkYgC4pU0Ta+vS-UkyAYFTkg8MaLuR+OAsSX63_BY+1vA@mail.gmail.com>
In-Reply-To: <CAKwvOdkYgC4pU0Ta+vS-UkyAYFTkg8MaLuR+OAsSX63_BY+1vA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 17 Aug 2021 11:22:26 -0700
Message-ID: <CAKwvOdk+fwHQDe23Ttva46tyB9yGGxB73zXzNPkcMCggSRWUdQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86, Makefile: Add new generic x86-64 settings v2/v3/v4
To:     torvic9@mailbox.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "graysky@archlinux.us" <graysky@archlinux.us>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 11:17 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Aug 17, 2021 at 7:24 AM torvic9 via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > Add new generic x86-64 CPU tunings introduced with recent versions of
> > gcc and clang, as documented in x86-64-psABI [1].
> >
> > This is taken straight from graysky's CPU optimization patch with minor
> > modifications [2].
> >
> > [1] https://gitlab.com/x86-psABIs/x86-64-ABI/-/commit/77566eb03bc6a326811cb7e9a6b9396884b67c7c
> > [2] https://github.com/graysky2/kernel_compiler_patch
> >
> > Signed-off-by: Tor Vic <torvic9@mailbox.org>
> > ---
> >  arch/x86/Kconfig.cpu  | 26 +++++++++++++++++++++++++-
> >  arch/x86/Makefile.cpu |  6 ++++++
> >  2 files changed, 31 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> > index 814fe0d349b0..a2c872aa5a0b 100644
> > --- a/arch/x86/Kconfig.cpu
> > +++ b/arch/x86/Kconfig.cpu
> > @@ -294,6 +294,30 @@ config GENERIC_CPU
> >           Generic x86-64 CPU.
> >           Run equally well on all x86-64 CPUs.
> >
> > +config GENERIC_CPU_V2
> > +       bool "Generic-x86-64-v2"
> > +       depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )
>
> Can we stick with either > or >=, but at least be consistent? Also,
> there's unnecessary whitespace inside the parens that could be
> removed.

Ah, cc-option can be used from Kconfig. Perhaps a cc-option call to
-march=x86-64-vX with a comment about which compiler versions first
supported these (so that we can remove the feature test when the
minimum supported toolchains are advanced) would be better?

>
> > +       depends on X86_64
> > +       help
> > +         Generic x86-64 CPU.
> > +         Run equally well on all x86-64 CPUs with min support of x86-64-v2.
> > +
> > +config GENERIC_CPU_V3
> > +       bool "Generic-x86-64-v3"
> > +       depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )
> > +       depends on X86_64
> > +       help
> > +         Generic x86-64-v3 CPU with v3 instructions.
> > +         Run equally well on all x86-64 CPUs with min support of x86-64-v3.
> > +
> > +config GENERIC_CPU_V4
> > +       bool "Generic-x86-64-v4"
> > +       depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )
> > +       depends on X86_64
> > +       help
> > +         Generic x86-64 CPU with v4 instructions.
> > +         Run equally well on all x86-64 CPUs with min support of x86-64-v4.
> > +
> >  endchoice
> >
> >  config X86_GENERIC
> > @@ -318,7 +342,7 @@ config X86_INTERNODE_CACHE_SHIFT
> >  config X86_L1_CACHE_SHIFT
> >         int
> >         default "7" if MPENTIUM4 || MPSC
> > -       default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || X86_GENERIC || GENERIC_CPU
> > +       default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || X86_GENERIC || GENERIC_CPU || GENERIC_CPU_V2 || GENERIC_CPU_V3 || GENERIC_CPU_V4
> >         default "4" if MELAN || M486SX || M486 || MGEODEGX1
> >         default "5" if MWINCHIP3D || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODE_LX
> >
> > diff --git a/arch/x86/Makefile.cpu b/arch/x86/Makefile.cpu
> > index fb407ae94d90..f190feefe964 100644
> > --- a/arch/x86/Makefile.cpu
> > +++ b/arch/x86/Makefile.cpu
> > @@ -10,3 +10,9 @@ cflags-$(CONFIG_MCORE2) += \
> >  cflags-$(CONFIG_MATOM) += $(call cc-option,-march=atom) \
> >         $(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
> >  cflags-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=generic)
> > +
> > +# New generic x86-64 CPU options.
> > +# Don't call the compiler, we have Kconfig compiler checks for these.
>
> You'd be surprised how quickly using time-relative words like "New"
> bitrot. My copy of "Modern C++" already doesn't feel very "modern" for
> example.  I'd just drop the comment block here; we don't need a
> comment every time we skip cc-option checks.  Thanks for the patches!
>
> > +cflags-$(CONFIG_GENERIC_CPU_V2) += -march=x86-64-v2
> > +cflags-$(CONFIG_GENERIC_CPU_V3) += -march=x86-64-v3
> > +cflags-$(CONFIG_GENERIC_CPU_V4) += -march=x86-64-v4
> > --
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
