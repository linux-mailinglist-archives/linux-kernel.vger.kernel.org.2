Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622F2321C91
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhBVQPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhBVQPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:15:04 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478E1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:14:22 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id u20so13765035iot.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=wv8UYvkcZRJDa28Q22Hdgwpxjk6P0Y3TZKnCb4xl10k=;
        b=OHPYNZchCsBRehZ8NczyhHYAaJBVbqhnU/ExZygS8s0Puwq4IgjnN9dzf32lzRsYjm
         9H4Z7ZzC+x+RoonT7FAWWAwV1M5g2qm4WqqJZTWyaJh3N4zc3zqu3M9V+iqvyzeMAC/J
         24GApqFywuzG8Egf2JIFcKL56CMKyv7B4HHLzH8VmBjQW6+E7q6Y+zq49Tlec4qztSxX
         bfjjbklaWZ405XJmlM+bmIR/GYacLxkrkoTaykrxR6rker88JKZhhJ11qX0aFMFnQ2+5
         ht2oPDgh32OpkPPw7dZpFsCJbptbhmvpaXsh/R3vGgMA6YE4tfXScnwrxp8vYrXXc4Rz
         k4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=wv8UYvkcZRJDa28Q22Hdgwpxjk6P0Y3TZKnCb4xl10k=;
        b=prnCZ77AF9tCVW2abIW8ekZB6//c3suBxXdNpSfj0AyG1vZYTkxqGagPIGtnbTSdWD
         NhfHDgCaN1CTwuAOK3SzpKnbVcASyu7dN5Fv0nQxazUjdjdjZE15I8tX2B77r2y7ETyD
         Xp9YPA8H8nIMdYBEgZXQWup1qimCXngdUbEkZlFIStBVDC3oa//TzIBmI9JwR1ARAjmm
         zIjN8QCoktgDoPrTApU2xhlJPEQVsc74jGAX+4aTJG62wnh+0vmBg/kZKpOA03zISwTz
         n9yEsEnP9e6LyomSxWlg9n/NEKHoosKBFm9kOyRy6LMePsDIKFxOfGR54A4b/W5lQ6OC
         m02w==
X-Gm-Message-State: AOAM530l1YmnPlNvCU0unU30Yywn8D4ILw1vqNWxJ+/lUa4TyUjk3BAB
        1d2cybEtcd/TpDa51ALPD/p0ih4eKtvrVBZIB/Y=
X-Google-Smtp-Source: ABdhPJzG98xJhxxtLlgqZiJ4OJTBMQM1vu5ns+OzeHGmqEdeVP9YVEAESYfvCwT36bG7L7WseZ0Ge7dRVlLRFyFJSN8=
X-Received: by 2002:a05:6638:44e:: with SMTP id r14mr5145828jap.138.1614010461687;
 Mon, 22 Feb 2021 08:14:21 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtNOZ-G_RTq_Uedy-7wkFog2q+OWNbWd--eL+i2-OQ7NA@mail.gmail.com>
In-Reply-To: <CA+G9fYtNOZ-G_RTq_Uedy-7wkFog2q+OWNbWd--eL+i2-OQ7NA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 22 Feb 2021 17:14:16 +0100
Message-ID: <CA+icZUVdpyNC=e8Cdg2bXaKdQGgkY1Te-OEXE7jaKARw0KKrCw@mail.gmail.com>
Subject: Re: clang-12: i386: Unsupported relocation type: R_386_PLT32 (4)
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>,
        x86-ml <x86@kernel.org>, lkft-triage@lists.linaro.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 5:08 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> While building i386 configs on stable-rc 5.10, stable-rc 5.11 branch
> and mainline
> with clang-12 these following warnings and errors were noticed.
>

Hi Naresh,

Please see commit bb73d07148c405c293e576b40af37737faf23a6a
("x86/build: Treat R_386_PLT32 relocation as R_386_PC32").
Recently accepted into Linus Git tree.

[1] says:

Further info for the more interested:

  https://github.com/ClangBuiltLinux/linux/issues/1210
  https://sourceware.org/bugzilla/show_bug.cgi?id=27169
  https://github.com/llvm/llvm-project/commit/a084c0388e2a59b9556f2de0083333232da3f1d6

Hope that helps.

- Sedat -

[1] https://git.kernel.org/linus/bb73d07148c405c293e576b40af37737faf23a6a

> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=i386
> CROSS_COMPILE=i686-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
> clang'
>
> drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:2586:9: warning: shift
> count >= width of type [-Wshift-count-overflow]
>
>         return hweight64(VDBOX_MASK(&i915->gt));
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/asm-generic/bitops/const_hweight.h:29:49: note: expanded from
> macro 'hweight64'
> #define hweight64(w) (__builtin_constant_p(w) ? __const_hweight64(w) :
> __arch_hweight64(w))
>                                                 ^~~~~~~~~~~~~~~~~~~~
> include/asm-generic/bitops/const_hweight.h:21:76: note: expanded from
> macro '__const_hweight64'
> #define __const_hweight64(w) (__const_hweight32(w) +
> __const_hweight32((w) >> 32))
>                                                                            ^  ~~
> include/asm-generic/bitops/const_hweight.h:20:49: note: expanded from
> macro '__const_hweight32'
> #define __const_hweight32(w) (__const_hweight16(w) +
> __const_hweight16((w) >> 16))
>                                                 ^
> include/asm-generic/bitops/const_hweight.h:19:48: note: expanded from
> macro '__const_hweight16'
> #define __const_hweight16(w) (__const_hweight8(w)  +
> __const_hweight8((w)  >> 8 ))
>                                                ^
> include/asm-generic/bitops/const_hweight.h:10:9: note: expanded from
> macro '__const_hweight8'
>          ((!!((w) & (1ULL << 0))) +     \
>                ^
> drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:2586:9: warning: shift
> count >= width of type [-Wshift-count-overflow]
>         return hweight64(VDBOX_MASK(&i915->gt));
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> <trim>
>
> 32 warnings generated.
> Unsupported relocation type: R_386_PLT32 (4)
> make[3]: *** [arch/x86/boot/compressed/Makefile:116:
> arch/x86/boot/compressed/vmlinux.relocs] Error 1
> make[3]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
> make[3]: Target 'arch/x86/boot/compressed/vmlinux' not remade because of errors.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>
> Steps to reproduce:
> ---------------------------
> # TuxMake is a command line tool and Python library that provides
> # portable and repeatable Linux kernel builds across a variety of
> # architectures, toolchains, kernel configurations, and make targets.
> #
> # TuxMake supports the concept of runtimes.
> # See https://docs.tuxmake.org/runtimes/, for that to work it requires
> # that you install podman or docker on your system.
> #
> # To install tuxmake on your system globally:
> # sudo pip3 install -U tuxmake
> #
> # See https://docs.tuxmake.org/ for complete documentation.
>
> tuxmake --runtime podman --target-arch i386 --toolchain clang-12
> --kconfig defconfig  --kconfig-add
> https://builds.tuxbuild.com/1opxSKxZuRowPsiOsSJ0IoUOXOt/config
>
> --
> Linaro LKFT
> https://lkft.linaro.org
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CA%2BG9fYtNOZ-G_RTq_Uedy-7wkFog2q%2BOWNbWd--eL%2Bi2-OQ7NA%40mail.gmail.com.
