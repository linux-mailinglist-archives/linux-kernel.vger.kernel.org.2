Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166653EC230
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 13:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbhHNLDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 07:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbhHNLDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 07:03:15 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F727C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 04:02:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id d11so23045985eja.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 04:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ad97cnuJ60n5L2dXuWbdhv2jj+zm4I/j9SiEmdlB3hk=;
        b=vPBicPaxBjSV9abB+6Scs73fr2fPNlYt6PmGAcfKZdmoKvaWOCdpyYZfLZuimuu8Px
         1956ZOlTmalN/EbO6gaxRN9r3xE667VP3H8aaumhaXet2LM/MODHWH26oboEvgfSVl36
         oeahSvk7UbOyI/9LnrfMYytaIibitmPOvb21AEF0ZD09AiNoGKS5VJkh4EejxSCmnpZz
         4i6IyJ1ymX4GF2nQC+FtUvNKnD0URs3n+lCbbTaKAL73mJBqsmxpLaoyiGpcKIYWs0G5
         Uf6/QtCiJkgBbTYcmagNXaFxunlz+rE7zvGC9qpnr/DDJ3eIE3gtXHwDWJKLiuLEfyUu
         /vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ad97cnuJ60n5L2dXuWbdhv2jj+zm4I/j9SiEmdlB3hk=;
        b=J0E4Dh/TPozBaCR1GWXwpEi8nttY0Ds+0Sab+pD6bwqaai3Ga5r4bQL0OcoYQZ5EYP
         5g/6/FQU6HCYoOKh9czNL7gZhG9VqeoW35TV2UaJc7gub1Z4WMsIxIrYnHbi+Yvr8F6b
         E0v0wzJEHloJ0DkP+P0fXZBzdp7eCbucxXD79Fkybo4Hfy4c8jeWnU5IL8dZYb+QqaBQ
         4jfaTXiH9dcPDbsGbM4b7o8dp07JMfl0FHZlodMmiyNB2NGgwJCFXscWMUTQe5rlJXZH
         /QnARmvCFkWHNjhldu5cQjsNY8gjZ1k7k1hO5eibpIzz10H3Uk5lrS9Aju+w/t2K7tg9
         +7Cw==
X-Gm-Message-State: AOAM533Aysjro5ea0SNuE6B90KlaEITYrhQEz1N8Shb+93D4Cx1xarn3
        Q32NjW2kCWpv5rrusiG5JjWqi+McSHZQN6W7JObc/Q==
X-Google-Smtp-Source: ABdhPJzw4ilcgsQi4SqLJvvq5rIZW4z4zD/rsTwZ9B30e+YK/IuiswglWXFG8idEu+8nua1jwr04jE/12QI7Hf8VKB4=
X-Received: by 2002:a17:906:40d1:: with SMTP id a17mr6955098ejk.503.1628938965819;
 Sat, 14 Aug 2021 04:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210810204240.4008685-1-ndesaulniers@google.com>
In-Reply-To: <20210810204240.4008685-1-ndesaulniers@google.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 14 Aug 2021 16:32:34 +0530
Message-ID: <CA+G9fYtPBp_-Ko_P7NuOX6vN9-66rjJuBt21h3arrLqEaQQn6w@mail.gmail.com>
Subject: Re: [PATCH] Makefile: remove stale cc-option checks
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kbuild@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 at 02:12, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> cc-option, cc-option-yn, and cc-disable-warning all invoke the compiler
> during build time, and can slow down the build when these checks become
> stale for our supported compilers, whose minimally supported versions
> increases over time. See Documentation/process/changes.rst for the
> current supported minimal versions (GCC 4.9+, clang 10.0.1+). Compiler
> version support for these flags may be verified on godbolt.org.
>
> The following flags are GCC only and supported since at least GCC 4.9.
> Remove cc-option and cc-disable-warning tests.
> * -fno-tree-loop-im
> * -Wno-maybe-uninitialized
> * -fno-reorder-blocks
> * -fno-ipa-cp-clone
> * -fno-partial-inlining
> * -femit-struct-debug-baseonly
> * -fno-inline-functions-called-once
> * -fconserve-stack
>
> The following flags are supported by all supported versions of GCC and
> Clang. Remove their cc-option, cc-option-yn, and cc-disable-warning tests.
> * -fno-delete-null-pointer-checks
> * -fno-var-tracking
> * -mfentry
> * -Wno-array-bounds
>
> The following configs are made dependent on GCC, since they use GCC
> specific flags.
> * READABLE_ASM
> * DEBUG_SECTION_MISMATCH
>
> --param=allow-store-data-races=0 was renamed to --allow-store-data-races
> in the GCC 10 release.

[Please ignore this if it is already reported]

Linux next 20210813 tag s390 build failed with gcc-8 but pass with
gcc-9 and gcc-10.

 s390 (defconfig) with gcc-8 FAILED
 s390 (defconfig) with gcc-9 PASS
 s390 (defconfig) with gcc-10 PASS

Build error:
-----------
s390x-linux-gnu-gcc: error: unrecognized command line option
'-mfentry'; did you mean '--entry'?
make[2]: *** [/builds/linux/scripts/Makefile.build:272:
scripts/mod/empty.o] Error 1
s390x-linux-gnu-gcc: error: unrecognized command line option
'-mfentry'; did you mean '--entry'?
make[2]: *** [/builds/linux/scripts/Makefile.build:118:
scripts/mod/devicetable-offsets.s] Error 1
make[2]: Target '__build' not remade because of errors.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log,
https://builds.tuxbuild.com/1wfNcaYbsp29k3RvYuPXzxrM4vs/

metadata:
--------
    git_describe: next-20210813
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
    git_short_log: 4b358aabb93a (\Add linux-next specific files for 20210813\)
    target_arch: s390
    toolchain: gcc-8


Steps to reproduce:
-------------------
# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.


tuxmake --runtime podman --target-arch s390 --toolchain gcc-8
--kconfig defconfig


--
Linaro LKFT
https://lkft.linaro.org
