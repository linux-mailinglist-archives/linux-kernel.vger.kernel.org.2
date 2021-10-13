Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A67A42B30C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbhJMDFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:05:11 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:65204 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhJMDFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:05:10 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 19D32s1k013593
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:02:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 19D32s1k013593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1634094174;
        bh=tNlDnh3wV/mofN17CR9XUn/PjqpItz5YDbO4h+r0dIU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KkBZPPxtge3npCKyRpwGBeqURAumSl1E5HNdxYSRWJvSFMYTSGTBwL9cZXiA37efI
         s/ULWHY1LMAUw7syieFs5qjSEgUhf4YhzfVP8Q+3G9N2MG929WGXIhxMQ9NHPocJUU
         Qmkc22VTV029by29N08Nk0zNcvVHLTGsmzysHWTWvC+FIDwimZcjFXDFCr0rZZcwAS
         Kyv/92c45+lp3+YKf0k8oeY/yU3WmdqgqRYCLyCGCDpgJMQiM5DEaXDLrkG+vRa1nr
         I6sd5a3StNb7YFoB51rsbo5WZbAe890p9x3LkzVr72Vtw7wjVw6jaqyzLcpnT9RRZB
         hw+IJIonCnYcQ==
X-Nifty-SrcIP: [209.85.216.51]
Received: by mail-pj1-f51.google.com with SMTP id k23-20020a17090a591700b001976d2db364so1162761pji.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 20:02:54 -0700 (PDT)
X-Gm-Message-State: AOAM532/wfU+DbWcwTm/+6jxB4DV3sdonBAQipKghOhtZ80u1pv753xQ
        l0qIQDC10XZ9Q47HagMjGoM3pmWSM5AFH8H+apU=
X-Google-Smtp-Source: ABdhPJxU7LZNiD0CqnvHudknEPsQ2Waww+h2Z0Ej9EfhwBvI6wfB6dY2unbVVMrquQxV+Syc5ZF0AH2ALN/h8KSS4iU=
X-Received: by 2002:a17:902:f703:b029:12c:982:c9ae with SMTP id
 h3-20020a170902f703b029012c0982c9aemr33656832plo.20.1634094173755; Tue, 12
 Oct 2021 20:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211012234606.91717-1-ndesaulniers@google.com> <20211012234606.91717-3-ndesaulniers@google.com>
In-Reply-To: <20211012234606.91717-3-ndesaulniers@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 13 Oct 2021 12:02:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNASGRQqL4Qu7ZVOcrW8-oXm7xvB-m7yoMJHnCDR5-_jrDQ@mail.gmail.com>
Message-ID: <CAK7LNASGRQqL4Qu7ZVOcrW8-oXm7xvB-m7yoMJHnCDR5-_jrDQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: vdso32: lazily invoke COMPAT_CC
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, llvm@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Lucas Henneman <henneman@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 8:46 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> When running the following command without arm-linux-gnueabi-gcc in
> one's $PATH, the following warning is observed:
>
> $ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make -j72 LLVM=1 mrproper
> make[1]: arm-linux-gnueabi-gcc: No such file or directory
>
> This is because KCONFIG is not run for mrproper, so CONFIG_CC_IS_CLANG
> is not set, and we end up eagerly evaluating various variables that try
> to invoke CC_COMPAT.
>
> This is a similar problem to what was observed in
> commit 3ec8a5b33dea ("kbuild: do not export LDFLAGS_vmlinux")
>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Reported-by: Lucas Henneman <henneman@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>


There are two ways to fix it:

  [1]: sink the error message to /dev/null
        (as in commit dc960bfeedb01cf832c5632ed1f3daed4416b142)
  [2]: use a recursively-expanded variable as you did.


"Simple variable (:=) vs recursive variable (=)" is a trade-off.

Please be careful about the cost when you try the [2] approach.



Simple variables are immediately expanded while parsing Makefile.
There are 7 call-sites for cc32-option, hence
the compiler is invoked 7 times for building vdso32,
0 times for cleaning.
(Since 57fd251c789647552d32d2fc51bedd4f90d70f9f,
try-run is no-op for 'make clean').




Recursive variables are expanded every time they are used.

IIUC, if_changed expands the command line 3 times.
There are 2 objects (note.o and vgettimeofday.o)
There are 7 call-sites for cc32-option.

So, the compiler is invoked 42 (3 * 2 * 7) times
for building vdso32.







> ---
>  arch/arm64/kernel/vdso32/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 89299a26638b..d24b12318f4c 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -38,12 +38,12 @@ cc32-disable-warning = $(call try-run,\
>  # As a result we set our own flags here.
>
>  # KBUILD_CPPFLAGS and NOSTDINC_FLAGS from top-level Makefile
> -VDSO_CPPFLAGS := -DBUILD_VDSO -D__KERNEL__ -nostdinc -isystem $(shell $(CC_COMPAT) -print-file-name=include)
> +VDSO_CPPFLAGS = -DBUILD_VDSO -D__KERNEL__ -nostdinc -isystem $(shell $(CC_COMPAT) -print-file-name=include)
>  VDSO_CPPFLAGS += $(LINUXINCLUDE)
>
>  # Common C and assembly flags
>  # From top-level Makefile
> -VDSO_CAFLAGS := $(VDSO_CPPFLAGS)
> +VDSO_CAFLAGS = $(VDSO_CPPFLAGS)
>  ifneq ($(shell $(CC_COMPAT) --version 2>&1 | head -n 1 | grep clang),)
>  VDSO_CAFLAGS += --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
>  endif
> @@ -73,7 +73,7 @@ VDSO_CAFLAGS += -DDISABLE_BRANCH_PROFILING
>  VDSO_CAFLAGS += $(call cc32-option,-march=armv8-a -D__LINUX_ARM_ARCH__=8,\
>                                     -march=armv7-a -D__LINUX_ARM_ARCH__=7)
>
> -VDSO_CFLAGS := $(VDSO_CAFLAGS)
> +VDSO_CFLAGS = $(VDSO_CAFLAGS)
>  VDSO_CFLAGS += -DENABLE_COMPAT_VDSO=1
>  # KBUILD_CFLAGS from top-level Makefile
>  VDSO_CFLAGS += -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
> @@ -108,7 +108,7 @@ else
>  VDSO_CFLAGS += -marm
>  endif
>
> -VDSO_AFLAGS := $(VDSO_CAFLAGS)
> +VDSO_AFLAGS = $(VDSO_CAFLAGS)
>  VDSO_AFLAGS += -D__ASSEMBLY__
>
>  # From arm vDSO Makefile
> --
> 2.33.0.882.g93a45727a2-goog
>


--
Best Regards
Masahiro Yamada
